DELIMITER $$
CREATE PROCEDURE payCheck(IN crewNum INT, INOUT salary VARCHAR(4000))
BEGIN
  DECLARE v_finished INTEGER DEFAULT 0;
  DECLARE v_lines VARCHAR(100) DEFAULT "----------------------------------------------\n---------------------------------- ";
  DECLARE v_cFirst VARCHAR(100) DEFAULT "";
  DECLARE v_cLast VARCHAR(100) DEFAULT "";
  DECLARE v_cAddress VARCHAR(100) DEFAULT "";
  DECLARE v_cCity VARCHAR(100) DEFAULT "";
  DECLARE v_cState VARCHAR(100) DEFAULT "";
  DECLARE v_cZip VARCHAR(100) DEFAULT "";
  DECLARE v_tHours INT DEFAULT 0;
  DECLARE v_pHourly DECIMAL(5,2) DEFAULT 0.0;
  DECLARE v_overtime INT DEFAULT 0;
  DECLARE v_count INTEGER DEFAULT 0;
  DECLARE v_pay DECIMAL(8,2) DEFAULT 0.0;
  

  
  DECLARE crew_cursor CURSOR FOR SELECT 
 c.firstName, c.lastName, c.address, cs.city, cs.state, cs.zipCode,
 t.sun+t.mon+t.tues+t.wed+t.thurs+t.fri+t.sat as hours,p.hourly 
 FROM crew c, cityState cs, timesheet t, position p
 WHERE t.crewId = crewNum;
 
 
 DECLARE CONTINUE HANDLER
 FOR NOT FOUND SET v_finished = 1;
 
  
  get_crew: LOOP
    FETCH crew_cursor INTO v_cFirst, v_cLast, v_cAddress, v_cCity, v_cState, v_cZip, v_tHours, v_pHourly;
    IF v_finished = 1 THEN
      LEAVE get_crew;
    END IF;
    
    SET v_count = v_count + 1;
    
    IF v_count = 1 THEN
      IF v_tHours <= 40 THEN
        SET v_pay = v_tHours * v_pHourly;
      ELSE
        SET v_overtime = (v_tHours - 40) * (v_pHourly * 1.5);
        SET v_pay = (40 * v_pHourly) + v_overtime;
      END IF;
      
      SET salary = CONCAT(salary, '\From:\n');
      SET salary = CONCAT(salary, '\nCGS 2545 Cruiselines\n');
      SET salary = CONCAT(salary, '\UCF\n');
      SET salary = CONCAT(salary, '\MSB 260\n\n');
      SET salary = CONCAT(salary, 'Pay to the order of:\n\n');
      SET salary = CONCAT(salary, v_cFirst, ' ', v_cLast, '\n');
      SET salary = CONCAT(salary, v_cAddress, '\n');
      SET salary = CONCAT(salary, v_cCity, ', ', v_cState, ' ', v_cZip, '\n');
      SET salary = CONCAT(salary, 'In the amount of:\n\n');
      SET salary = CONCAT(salary, '$', v_pay, '\n');
      SET salary = CONCAT(salary, '\n', v_lines, '\n');
    END IF;
  END LOOP get_crew;
  
  CLOSE crew_cursor;
  
END$$
DELIMITER ;
