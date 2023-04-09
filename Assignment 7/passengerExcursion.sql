/* order of data
    passenger.firstName, passenger.lastName, excursion.name 
  
  This requires a lookup in tables excursion and passenger to find the associated ID values.
  
  An example insert statement would be:
  
  INSERT INTO passengerExcursion VALUES (1, 1);
*/
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

+----+-----------+-----------+
| id | firstName | lastName  |
+----+-----------+-----------+
|  1 | Yvonne    | Goodman   |
|  2 | Dante     | Mackenzie |
|  3 | Alysha    | Rollins   |
|  4 | Avaya     | Gonzalez  |
|  5 | Haniya    | Kelly     |
|  6 | Nathalie  | Chambers  |
|  7 | Dante     | Rollins   |
|  8 | Beverley  | Mckee     |
|  9 | Paris     | Lindsey   |
| 10 | Umaiza    | Melia     |
| 11 | Nico      | Prince    |
| 12 | Javan     | Rennie    |
| 13 | Ali       | Waters    |
| 14 | JohnPaul  | Clarke    |
| 15 | Dane      | Kaiser    |
| 16 | Hammad    | Newman    |
| 17 | Maha      | Guthrie   |
| 18 | Tulisa    | Roberts   |
| 19 | Robin     | Solis     |
| 20 | Kavita    | Heath     |
| 21 | Meera     | White     |
| 22 | Bradlee   | Esparza   |
| 23 | Leilani   | Leonard   |
| 24 | Stefanie  | Brook     |
| 25 | Grover    | Squires   |
| 26 | Jonathan  | Kumar     |
| 27 | Angus     | Neville   |
| 28 | Uzair     | Sparrow   |
| 29 | Amari     | Currie    |
| 30 | Imaani    | Wallace   |
| 31 | Efe       | House     |
| 32 | Atticus   | Atkinson  |
| 33 | Michelle  | Ramirez   |
| 34 | Remy      | Hassan    |
| 35 | Jordana   | Beck      |
+----+-----------+-----------+


| id | name                                               |
+----+----------------------------------------------------+
|  8 | Best of Juneau                                     |
|  6 | Exclusive Juneau City and Mendenhall Glacier Tour  |
| 11 | Helicopter Dog Sledding Extended Tour              |
|  3 | Helicopter Glacier Discovery                       |
|  9 | Mended hall Lake Kayak and Salmon Bake             |
| 10 | Mendenhall Glacier Trek                            |
|  2 | Scenic Waterfall Adventure                         |
|  1 | Skagway City and White Pass Summit                 |
|  7 | Whales and Mendenhall Glacier                      |
|  4 | White Pass Summit Rail and Bus Excursion           |
|  5 | White Pass Summit Rail and Yukon Suspension Bridge |
+----+----------------------------------------------------+