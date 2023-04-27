/*use cruise*/

use cruise;

/*Create procedure*/
DELIMITER $$
DROP PROCEDURE IF EXISTS payCheck$$
CREATE PROCEDURE payCheck(IN crewNum INT, INOUT salary VARCHAR(4000))
BEGIN
        DECLARE v_finished integer DEFAULT 0;
 DECLARE v_lines varchar(100) DEFAULT " ----------------------------------------------
---------------------------------- ";
 DECLARE v_cFirst varchar(100) DEFAULT "";
DECLARE  v_cLast varchar(100) DEFAULT "";
DECLARE  v_cAddress varchar(100) DEFAULT "";
DECLARE  v_cCity varchar(100) DEFAULT "";
DECLARE  v_cState varchar(100) DEFAULT "";
DECLARE  v_cZip varchar(100) DEFAULT "";
DECLARE  v_tHours int DEFAULT 0;
DECLARE  v_pHourly decimal(5,2) DEFAULT 0.0;
DECLARE  v_overtime INT DEFAULT 0;
DECLARE  v_count integer DEFAULT 0;
DECLARE  v_pay decimal(8,2) DEFAULT 0.0;
 
 DECLARE crew_cursor CURSOR FOR SELECT 
 c.firstName, c.lastName, c.address, cs.city, cs.state, cs.zipCode,
 t.sun+t.mon+t.tues+t.wed+t.thurs+t.fri+t.sat as hours,p.hourly 
 FROM crew c, cityState cs, timesheet t, position p, crewposition cp
 WHERE t.crewId = crewNum
 AND c.zipCode = cs.zipCode
 AND t.crewId = c.Id
 AND cp.crewId = c.id
 AND cp.positionId = p.id;
 
 
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
 OPEN crew_cursor;
 
 get_crew: LOOP
 FETCH crew_cursor INTO
 v_cFirst, v_cLast, v_cAddress,
 v_cCity, v_cState, v_cZip, v_tHours, v_pHourly;
 
 IF v_finished = 1 THEN
 LEAVE get_crew;
 END IF;
 
 SET v_count = v_count + 1;
 IF v_count = 1 THEN
    IF v_tHours <= 40 THEN 
    set v_pay = v_tHours *  v_pHourly;
ELSEIF v_tHours > 40 THEN
set v_overtime = (v_tHours - 40) * (v_pHourly * 1.5);
set v_pay = (40 * v_pHourly);
set v_pay = v_pay + v_overtime;
END IF;


set salary = CONCAT (salary,'\From:\n');
set salary = CONCAT (salary,'\nCGS 2545 Cruiselines\n');
set salary = CONCAT (salary,'\UCF\n');
set salary = CONCAT (salary,'\MSB 260\n\n');
set salary = CONCAT (salary,'Pay to the order of:\n\n');
set salary = CONCAT (salary,v_cFirst,' ',v_cLast,'\n');
set salary = CONCAT (salary,v_cAddress,'\n');
set salary = CONCAT (salary,v_cCity,', ',v_cState,' ',v_cZip,'\n');
set salary = CONCAT (salary,'In the amount of:\n\n');
set salary = CONCAT (salary,'$',v_pay,'\n');
set salary = CONCAT (salary,'\n',v_lines,'\n');
END IF;

END LOOP get_crew;
CLOSE crew_cursor;
END$$
DELIMITER ;