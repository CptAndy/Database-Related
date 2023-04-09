use cruise;


/*Create a table named activityLevel*/


CREATE TABLE activityLevel (
    
  ID integer NOT NULL AUTO_INCREMENT,
    exLevel varchar(25) NOT NULL UNIQUE,
    PRIMARY KEY (ID)
   
);

/*Create a table named size*/

CREATE TABLE size (
ID integer NOT NULL AUTO_INCREMENT,
exSize varchar(25) NOT NULL UNIQUE,
    PRIMARY KEY (ID)

);

/*Create a table named type*/

CREATE TABLE type (
ID integer NOT NULL AUTO_INCREMENT,
    exType varchar(25) NOT NULL UNIQUE,
    PRIMARY KEY (ID)

);

/*Create a table named foodBeverage*/


CREATE TABLE foodBeverage (
ID integer NOT NULL AUTO_INCREMENT,
    offering varchar(25) NOT NULL UNIQUE,
    PRIMARY KEY (ID)
);

/*Insert data from other table(s)*/

INSERT INTO activityLevel (exLevel)
SELECT DISTINCT activityLevel FROM excursion;

INSERT INTO size (exSize)
SELECT DISTINCT size FROM excursion;


INSERT INTO type (exType)
SELECT DISTINCT type FROM excursion;

INSERT INTO foodBeverage (offering)
SELECT DISTINCT foodBeverage FROM excursion;


/*Table updates*/

UPDATE excursion
set activityLevel = 1
where activityLevel = 'Moderate' ;

UPDATE excursion
set activityLevel = 2
where activityLevel = 'Easy' ;

UPDATE excursion
set size = 1
where size = 'Standard';


UPDATE excursion
set size = 2
where size = 'Small';

UPDATE excursion
set type = 1
where type = 'Scenic';

UPDATE excursion
set type = 2
where type = 'Cultural, Scenic';

UPDATE excursion 
set foodBeverage = 1;


/*Alter data types*/

ALTER TABLE excursion
MODIFY COLUMN activityLevel integer NOT NULL;

ALTER TABLE excursion
MODIFY COLUMN size integer NOT NULL;

ALTER TABLE excursion
MODIFY COLUMN type integer NOT NULL;

ALTER TABLE excursion
MODIFY COLUMN foodBeverage integer NOT NULL;

/*Alter names*/

ALTER TABLE excursion
RENAME COLUMN activityLevel to activityLevelId,
RENAME COLUMN size to sizeId,
RENAME COLUMN type to typeId,
RENAME COLUMN foodBeverage to foodBeverageId;

/*Alter Keys*/

ALTER TABLE excursion
ADD FOREIGN KEY (activityLevelId) REFERENCES activityLevel(ID);

ALTER TABLE excursion
ADD FOREIGN KEY (sizeID) REFERENCES size(ID);

ALTER TABLE excursion
ADD FOREIGN KEY (typeID) REFERENCES type(ID);

ALTER TABLE excursion
ADD FOREIGN KEY (foodBeverageID) REFERENCES foodBeverage(ID);

/*Join Query*/

SELECT e.id, name, exSize, exType, Offering, exLevel, durationMinutes, price
FROM excursion e, foodBeverage fb, type t, size s, activityLevel al
WHERE e.activityLevelId = al.Id
AND e.foodBeverageId = fb.Id
AND e.typeID = t.Id
AND e.sizeId = s.Id
ORDER BY e.id; 
