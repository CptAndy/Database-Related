/* create stored procedure */

DELIMITER $$
DROP PROCEDURE IF EXISTS payCheck$$ 
CREATE PROCEDURE payCheck (IN crewNum int, INOUT salary varchar(4000))
BEGIN
 
 -- declare variables FIRST!
 DECLARE v_finished INTEGER DEFAULT 0;
 DECLARE v_lines varchar(100) DEFAULT "--------------------------------------------------------------------------------";
 
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
 
 
 -- declare cursor for crew
 DEClARE crew_cursor CURSOR FOR SELECT 
 c.firstName, c.lastName, c.address, cs.city, cs.state, cs.zipCode,
 t.sun+t.mon+t.tues+t.wed+t.thurs+t.fri+t.sat as hours,p.hourly 
 FROM crew c, cityState cs, timesheet t, position p
 WHERE t.crewId = crewNum;
 

-- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;

-- open the cursor
OPEN crew_cursor;
 -- use a label for the LOOP
 get_crew: LOOP
 
 /*
 
 fetch the data into the local variables
 
 local variable names should be in the same order as the SELECT statement for the CURSOR

*/
FETCH crew_cursor INTO v_cFirst, v_cLast,
3. v_cAddress, v_cCity, v_cState, 
v_cZip, v_tHours, v_pHourly;

 -- check if reached the end of the result set
 IF v_finished = 1 THEN 
    LEAVE get_crew;
 END IF;
 
-- increment the counter v_count by 1 (one)
SET v_count = c_count + 1;
-- build the salary check --

-- debug statements --
/*
SELECT v_cFirst;
SELECT v_cLast;
SELECT v_cAddress; 
SELECT v_cCity; 
SELECT v_cZip;
*/

-- formatting the crew salary check

IF v_count = 1 THEN
    -- calculate the salary

-- debug statements --
-- SELECT v_pay;

-- from
    SET salary = CONCAT(salary, '\n', v_lines, '\n');     

/*

    write concatenated SET statements here

    -- payee

    -- amount

*/

END IF;


-- debug statements --
-- SELECT salary;
 
-- end the loop

-- close the cursor
 
 -- end the stored procedure
END$$
 
 -- reset the delimiter
DELIMITER ;

-- test the stored procedure

--  Ty Bell

--  Oliwier Barnett

--  Rebekah Morgan

--  Krystal Walters

--  Kaya Hodge

--  Paris Solis

-- Umaiza Heath

-- Floyd Johns

-- Jemima HeatMillerh

-- Raja Glass
