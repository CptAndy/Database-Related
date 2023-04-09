use cruise;

/*Create Table*/
CREATE TABLE crewExcursion (

    crewId integer NOT NULL,
    excursionId integer NOT NULL,
    PRIMARY KEY (crewId, excursionId),
    FOREIGN KEY (crewId) REFERENCES crew(id),
    FOREIGN KEY (excursionId) REFERENCES excursion(id)

);

/*Populate Table*/

 INSERT INTO crewExcursion VALUES
(16,8),
(29,6 ),
(31,11),
(32,3),
(16,10), 
(29,9 ),
(32,9 ),
(31,2),
(32,1),
(16,7),   
(29,4),
(31,5);


/*Create View*/
 CREATE VIEW crewPositionView  AS 
 SELECT CONCAT(c.firstName, ' ',c.lastName) AS "Crew Member", 
 c.phone AS "Crew Phone", 
 p.description AS "Crew Position"
 FROM crew c, position p, crewposition cp
 where cp.crewID = c.id AND cp.positionId = p.id
 ORDER BY p.description, c.lastName;
 
 CREATE VIEW excursionView AS
 SELECT e.name AS 'Excursion', 
 s.exSize AS 'Size',
 t.exType AS 'Type',
 fb.offering AS 'Food/Beverage',
 al.exLevel AS 'Activity Level',
 e.durationMinutes AS "Duration in Minutes",
 e.price AS 'Price'
 FROM excursion e, foodBeverage fb, type t, size s, activityLevel al 
 where e.foodBeverageId = fb.id
 AND e.sizeId = s.id
 AND e.typeId = t.id
 AND e.activityLevelId = al.id
 ORDER BY al.exLevel;
 
CREATE VIEW bookedExcursionView AS
SELECT CONCAT(c.firstName , ' ', c.lastName) AS "Crew Member",
CONCAT(p.firstName , ' ', p.lastName) AS 'Passenger',
e.name AS 'Excursion',
fb.offering AS 'Food/Beverage',
e.durationMinutes AS "Duration in Minutes"
FROM crew c, passenger p, excursion e, passengerExcursion pe, foodBeverage fb, crewExcursion ce
WHERE c.id = ce.crewId
AND p.id = pe.passengerId
AND e.foodbeverageId = fb.id
AND e.id = pe.excursionid
AND e.id = ce.excursionid
ORDER BY e.name;
 