/* order of data

    crew.firstName, crew.lastName, timsheet.sun, timsheet.mon, timsheet.tues, timsheet.wed, timsheet.thurs, timsheet.fri, timsheet.sat
    
    crewId should be looked up in table crew based on crew.firstName, crew.lastName
    
    Example insert statement:
    
    INSERT INTO timesheet(crewId, sun, mon, tues, wed, thurs, fri, sat) VALUES
    (29, 0, 8, 8, 8, 8, 8, 0);

*/

(Ethan, Ali, 12, 0, 12, 0, 4, 12, 0),
(Oliwier, Barnett, 7, 4, 9, 0, 0, 10, 3),
(Sara, Barron, 0, 12, 6, 10, 6, 8, 0),
(Ty, Bell, 8, 8, 0, 0, 8, 10, 6),
(Leo, Bird, 0, 8, 8, 8, 8, 8, 0),
(Awais, Carrillo, 12, 0, 12, 0, 4, 12, 0),
(Laila, Christensen, 0, 12, 6, 10, 6, 8, 0),
(Avaya, Clarke, 10, 8, 0, 0, 8, 10, 10),
(Aamina, Dillon, 8, 8, 0, 0, 8, 10, 6),
(Fern, Garner, 12, 0, 12, 0, 4, 12, 0),
(Louis, Giles, 8, 8, 0, 0, 8, 10, 6),
(Raja, Glass, 12, 0, 12, 0, 4, 12, 0),
(Brodie, Gordon, 0, 8, 8, 8, 8, 8, 0),
(Douglas, Guthrie, 12, 0, 12, 0, 4, 12, 0),
(Umaiza, Heath, 6, 6, 6, 6, 6, 5, 0),
(Ernest, Higgins, 0, 8, 8, 8, 8, 8, 0),
(Kaya, Hodge, 10, 8, 0, 0, 8, 10, 10),
(Mathew, Horton, 7, 4, 9, 0, 0, 10, 3),
(Floyd, Johns, 6, 6, 6, 6, 6, 5, 0),
(Haniya, Kaiser, 6, 6, 6, 6, 6, 5, 0),
(Kamil, Lozano, 10, 8, 0, 0, 8, 10, 10),
(Dawson, Marquez, 7, 4, 9, 0, 0, 10, 3),
(Jemima, Miller, 10, 8, 0, 0, 8, 10, 10),
(Raheem, Montgomery, 10, 8, 0, 0, 8, 10, 10),
(Rebekah, Morgan, 7, 4, 9, 0, 0, 10, 3),
(Lauren, Morton, 8, 8, 0, 0, 8, 10, 6),
(Lyra, Murphy, 12, 0, 12, 0, 4, 12, 0),
(Victor, Newman, 0, 8, 8, 8, 8, 8, 0),
(Alissa, Ortiz, 10, 8, 0, 0, 8, 10, 10),
(Nicholas, Pena, 0, 8, 8, 8, 8, 8, 0),
(Alexa, Preston, 6, 6, 6, 6, 6, 5, 0),
(Igor, Prince, 0, 12, 6, 10, 6, 8, 0),
(Dante, Rennie, 0, 8, 8, 8, 8, 8, 0),
(Brian, Roberts, 8, 8, 0, 0, 8, 10, 6),
(Paris, Solis, 0, 12, 6, 10, 6, 8, 0),
(Malik, Vincent, 0, 12, 6, 10, 6, 8, 0),
(Krystal, Walters, 6, 6, 6, 6, 6, 5, 0),
(Honey, Warren, 0, 12, 6, 10, 6, 8, 0),
(Thomas, Waters, 6, 6, 6, 6, 6, 5, 0),
(Harvey, West, 0, 8, 8, 8, 8, 8, 0);