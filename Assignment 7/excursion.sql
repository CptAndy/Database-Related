/* order of data
    name, description, size, type, foodBeverage, activityLevel, durationMinutes, price 
  
  This requires a lookup in tables , size, type, foodBeverage and acitivityLevel to find the associated ID values.
  
  An example insert statement would be:
  
  INSERT INTO excursion VALUES ('Name', 'Description', 1, 1, 1, 1, 120, 60.00);
  
*/    
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