use cruise;

/*Update table columns*/

UPDATE type
SET exType = 'Cultural'
WHERE id = 2;

/*Passenger excursion table*/

CREATE TABLE passengerExcursion(

    passengerId integer NOT NULL,
    excursionId integer NOT NULL,
    PRIMARY KEY (passengerId,excursionId),
    FOREIGN KEY (passengerId) REFERENCES passenger(Id),
    FOREIGN KEY (excursionId) REFERENCES excursion(Id)
);


/*Data Insertion*/

INSERT INTO activityLevel (exLevel)
VALUES ('Difficult');

INSERT INTO size(exSize)
VALUES ('Private');

INSERT INTO type(exType)
VALUES ('Cuisine'), 
('Active'),
('Water'),
('Beach');


INSERT INTO foodBeverage (offering)
VALUES ('None'),
('Snack'),
('Coffee Included'),
('Salmon Bake'), 
('Buffet Included'),
('Lunch is Included'),
('Beverages Included');

INSERT INTO excursion (name, description, sizeId, typeId, foodBeverageId, activityLevelId, durationMinutes, price)VALUES
('Exclusive Juneau City and Mendenhall Glacier Tour', 
'This half day program will give you a city orientation and a visit to the Mendenhall Glacier and visitors center.', 
1, 
1, 
4, 
2, 
180, 
75.00),

('Whales and Mendenhall Glacier', 
'Alaska spectacular marine life and one of its best known glaciers all in a half day program on a boat holding a maximum of 40 guests. Whale viewing is guaranteed.', 
1, 
1, 
5, 
1, 
280, 
225.00),

('Best of Juneau', 
'Combine whale watching, a salmon bake, and views of the Mendenhall Glacier in this Juneau combination.', 
1, 
4, 
7, 
2, 
375, 
223.00),

('Mendenhall Lake Kayak and Salmon Bake', 
'Kayak into the breathtaking glacial waters of Mendenhall Lake and allow your senses to absorb the beauty this majestic place has to offer.', 
2, 
5, 
9, 
1, 
300, 
293.00),

('Mendenhall Glacier Trek', 
'For the hearty and experienced hiker, come along for glacier trekking on the Mendenhall Glacier!', 
2, 
5, 
5, 
4, 
480, 
257.00),

('Helicopter Dog Sledding Extended Tour', 
'This is a "once in a lifetime" tour. The helicopter flight is only one part of this legendary experience that includes flying over the Juneau Icefield to the dog camp and then experiencing a kennel tour and a dogsled ride. Choose this extended adventure for more time at the glacier!', 
2, 
5, 
1, 
2, 
220, 
832.00);

INSERT INTO passengerExcursion VALUES
(27,3),                     
(32, 8),                                    
(8, 4),          
(22, 11),             
(15, 7),                     
(7, 1),                
(2, 2),                        
(31, 11),             
(16, 5),
(5, 1),                
(30, 5),
(12, 1),                
(35, 8),                                    
(20, 6), 
(23, 3),                      
(11, 4),          
(19, 6), 
(28, 7),                     
(1, 2);

/*Join query*/
SELECT p.firstName,p.lastName, e.name, s.exSize, t.exType, fb.Offering, al.exLevel, e.durationMinutes, e.price
FROM passenger p, passengerexcursion pe,excursion e, foodBeverage fb, type t, size s, activityLevel al 
WHERE e.activityLevelId = al.Id
AND e.foodBeverageId = fb.Id
AND e.typeID = t.Id
AND e.sizeId = s.Id
AND pe.passengerId = p.Id 
AND pe.excursionId = e.id
ORDER BY e.name, p.lastName; 