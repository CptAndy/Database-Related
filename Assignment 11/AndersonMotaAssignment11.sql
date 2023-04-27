CREATE DATABASE  IF NOT EXISTS `cruise` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cruise`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: cruise
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activitylevel`
--

DROP TABLE IF EXISTS `activitylevel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activitylevel` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `exLevel` varchar(25) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `exLevel` (`exLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activitylevel`
--

LOCK TABLES `activitylevel` WRITE;
/*!40000 ALTER TABLE `activitylevel` DISABLE KEYS */;
INSERT INTO `activitylevel` VALUES (4,'Difficult'),(2,'Easy'),(1,'Moderate');
/*!40000 ALTER TABLE `activitylevel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `bookedexcursionview`
--

DROP TABLE IF EXISTS `bookedexcursionview`;
/*!50001 DROP VIEW IF EXISTS `bookedexcursionview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `bookedexcursionview` AS SELECT 
 1 AS `Crew Member`,
 1 AS `Passenger`,
 1 AS `Excursion`,
 1 AS `Food/Beverage`,
 1 AS `Duration in Minutes`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `citystate`
--

DROP TABLE IF EXISTS `citystate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citystate` (
  `city` varchar(90) NOT NULL,
  `state` char(2) NOT NULL,
  `zipCode` char(5) NOT NULL,
  PRIMARY KEY (`zipCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citystate`
--

LOCK TABLES `citystate` WRITE;
/*!40000 ALTER TABLE `citystate` DISABLE KEYS */;
INSERT INTO `citystate` VALUES ('Trumbull','CT','06611'),('Paterson','NJ','07501'),('Piscataway','NJ','08854'),('Ballston Spa','NY','12020'),('Havertown','PA','19083'),('Waldorf','MD','20601'),('Glenarden','MD','20706'),('Chesterfield','VA','23832'),('Abingdon','VA','24210'),('Indian Trail','NC','28079'),('Mooresville','NC','28115'),('Clover','SC','29710'),('Duluth','GA','30096'),('Jupiter','FL','33458'),('Nashville','TN','37205'),('Memphis','TN','38117'),('Vicksburg','MS','39180'),('Willoughby','OH','44094'),('Cuyahoga Falls','OH','44223'),('Chillicothe','OH','45601'),('Noblesville','IN','46060'),('Battle Creek','MI','49016'),('Jefferson','LA','70121'),('Covington','LA','70433'),('Scottsdale','AZ','85260'),('Ontario','CA','91764'),('San Marcos','CA','92078'),('Huntington Beach','CA','92647'),('Santa Cruz','CA','95060');
/*!40000 ALTER TABLE `citystate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crew`
--

DROP TABLE IF EXISTS `crew`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crew` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `address` varchar(90) NOT NULL,
  `zipCode` char(5) NOT NULL,
  `phone` char(10) NOT NULL,
  `email` varchar(90) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `zipCode` (`zipCode`),
  CONSTRAINT `crew_ibfk_1` FOREIGN KEY (`zipCode`) REFERENCES `citystate` (`zipCode`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crew`
--

LOCK TABLES `crew` WRITE;
/*!40000 ALTER TABLE `crew` DISABLE KEYS */;
INSERT INTO `crew` VALUES (1,'Igor','Prince','12 Creekside St','92647','2025550109','iprince@cruise.com'),(2,'Dante','Rennie','137 Wall St','38117','2025550112','drennie@cruise.com'),(3,'Thomas','Waters','411 Shirley St','24210','2025550115','twaters@cruise.com'),(4,'Avaya','Clarke','7771 Border Court','92078','2025550119','aclarke@cruise.com'),(5,'Haniya','Kaiser','6 South Sulphur Springs Street','70121','2025550121','hkaiser@cruise.com'),(6,'Victor','Newman','942 New Saddle Drive','70433','2025550122','vnewman@cruise.com'),(7,'Douglas','Guthrie','9 Wrangler Ave','91764','2025550124','dguthrie@cruise.com'),(8,'Brian','Roberts','7319 S. Greenview Drive','44223','2025550125','broberts@cruise.com'),(9,'Paris','Solis','763 West Mulberry St','49016','2025550132','psolis@cruise.com'),(10,'Umaiza','Heath','545 Ohio Ave','85260','2025550135','uheath@cruise.com'),(11,'Montgomery','Raheem','71 Paris Hill Rd.','39180','4134849795','rmontgomery@cruise.com'),(12,'Bird','Leo','201 Eagle Dr.','12020','7747829407','lbird@cruise.com'),(13,'Barnett','Oliwier','81 Cedar Swamp St.','39180','2764343958','obarnett@cruise.com'),(14,'Garner','Fern','37 Gartner Court','12020','2256254378','fgarner@cruise.com'),(15,'Marquez','Dawson','90 Mammoth Street','45601','7634882879','dmarquez@cruise.com'),(16,'Glass','Raja','7918 Talbot Ave.','45601','2319969540','rglass@cruise.com'),(17,'Ortiz','Alissa','7756 Fulton Court','23832','2397268929','aortiz@cruise.com'),(18,'Pena','Nicholas','8123 Race Ave.','95060','7815242242','npena@cruise.com'),(19,'West','Harvey','9 Cherry Ave','23832','7326232762','hwest@cruise.com'),(20,'Dillon','Aamina','9 West Boston Lane','95060','2035745299','adillon@cruise.com'),(21,'Giles','Louis','598 North Road','28115','2708583758','lgiles@cruise.com'),(22,'Walters','Krystal','583 North Nichols Street','95060','3232591832','kwalters@cruise.com'),(23,'Preston','Alexa','9227 North Bow Ridge Street','28115','4098496634','apreston@cruise.com'),(24,'Morgan','Rebekah','9437 East 6th Street','20601','6073928343','rmorgan@cruise.com'),(25,'Ali','Ethan','167 NE. Depot Dr.','28115','2245499884','eali@cruise.com'),(26,'Vincent','Malik','312 Colonial Ave.','19083','9149573014','mvincent@cruise.com'),(27,'Barron','Sara','9064 E. Swanson St.','20601','8707743244','sbarron@cruise.com'),(28,'Murphy','Lyra','400 Nut Swamp Drive','19083','3527673126','lmurphy@cruise.com'),(29,'Carrillo','Awais','225 South Manhattan Street','28079','6369577670','acarrillo@cruise.com'),(30,'Hodge','Kaya','9572 William Lane','46060','2125271561','khodge@cruise.com'),(31,'Miller','Jemima','9290 Indian Spring Rd.','28079','6206673264','jmiller@cruise.com'),(32,'Christensen','Laila','15 Rose Avenue','07501','9017396978','lchristensen@cruise.com'),(33,'Warren','Honey','7946 Leeton Ridge Street','06611','5858531050','hwarren@cruise.com'),(34,'Gordon','Brodie','71 Jackson Ave.','46060','9016899813','bgordon@cruise.com'),(35,'Morton','Lauren','7931 Rockaway Street','28079','4476721422','lmorton@cruise.com'),(36,'Bell','Ty','921 Brook St.','07501','2393336881','tbell@cruise.com'),(37,'Johns','Floyd','2 Shore Street','06611','4065842872','fjohns@cruise.com'),(38,'Horton','Mathew','1 Rockland Ave.','46060','7195789907','mhorton@cruise.com'),(39,'Higgins','Ernest','451 Marshall Lane','06611','7637651247','ehiggins@cruise.com'),(40,'Lozano','Kamil','75 N. Golden Star Street','07501','7638554744','klozano@cruise.com');
/*!40000 ALTER TABLE `crew` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crewexcursion`
--

DROP TABLE IF EXISTS `crewexcursion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crewexcursion` (
  `crewId` int NOT NULL,
  `excursionId` int NOT NULL,
  PRIMARY KEY (`crewId`,`excursionId`),
  KEY `excursionId` (`excursionId`),
  CONSTRAINT `crewexcursion_ibfk_1` FOREIGN KEY (`crewId`) REFERENCES `crew` (`ID`),
  CONSTRAINT `crewexcursion_ibfk_2` FOREIGN KEY (`excursionId`) REFERENCES `excursion` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crewexcursion`
--

LOCK TABLES `crewexcursion` WRITE;
/*!40000 ALTER TABLE `crewexcursion` DISABLE KEYS */;
INSERT INTO `crewexcursion` VALUES (32,1),(31,2),(32,3),(29,4),(31,5),(29,6),(16,7),(16,8),(29,9),(32,9),(16,10),(31,11);
/*!40000 ALTER TABLE `crewexcursion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `crewposition`
--

DROP TABLE IF EXISTS `crewposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `crewposition` (
  `crewId` int NOT NULL,
  `positionId` int NOT NULL,
  PRIMARY KEY (`crewId`,`positionId`),
  UNIQUE KEY `crewId` (`crewId`),
  KEY `positionId` (`positionId`),
  CONSTRAINT `crewposition_ibfk_1` FOREIGN KEY (`crewId`) REFERENCES `crew` (`ID`),
  CONSTRAINT `crewposition_ibfk_2` FOREIGN KEY (`positionId`) REFERENCES `position` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `crewposition`
--

LOCK TABLES `crewposition` WRITE;
/*!40000 ALTER TABLE `crewposition` DISABLE KEYS */;
INSERT INTO `crewposition` VALUES (1,24),(2,12),(3,6),(4,3),(5,1),(6,20),(7,10),(8,5),(9,2),(10,16),(11,4),(12,19),(13,8),(14,17),(15,8),(16,23),(17,12),(18,10),(19,11),(20,5),(21,20),(22,13),(23,21),(24,15),(25,17),(26,7),(27,9),(28,18),(29,23),(30,13),(31,23),(32,23),(33,7),(34,19),(35,10),(36,15),(37,13),(38,7),(39,22),(40,14);
/*!40000 ALTER TABLE `crewposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `crewpositionview`
--

DROP TABLE IF EXISTS `crewpositionview`;
/*!50001 DROP VIEW IF EXISTS `crewpositionview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `crewpositionview` AS SELECT 
 1 AS `Crew Member`,
 1 AS `Crew Phone`,
 1 AS `Crew Position`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `excursion`
--

DROP TABLE IF EXISTS `excursion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `excursion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(300) NOT NULL,
  `sizeId` int NOT NULL,
  `typeId` int NOT NULL,
  `foodBeverageId` int NOT NULL,
  `activityLevelId` int NOT NULL,
  `durationMinutes` int NOT NULL,
  `price` decimal(6,2) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `name` (`name`),
  KEY `activityLevelId` (`activityLevelId`),
  KEY `sizeId` (`sizeId`),
  KEY `typeId` (`typeId`),
  KEY `foodBeverageId` (`foodBeverageId`),
  CONSTRAINT `excursion_ibfk_1` FOREIGN KEY (`activityLevelId`) REFERENCES `activitylevel` (`ID`),
  CONSTRAINT `excursion_ibfk_2` FOREIGN KEY (`sizeId`) REFERENCES `size` (`ID`),
  CONSTRAINT `excursion_ibfk_3` FOREIGN KEY (`typeId`) REFERENCES `type` (`ID`),
  CONSTRAINT `excursion_ibfk_4` FOREIGN KEY (`foodBeverageId`) REFERENCES `foodbeverage` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `excursion`
--

LOCK TABLES `excursion` WRITE;
/*!40000 ALTER TABLE `excursion` DISABLE KEYS */;
INSERT INTO `excursion` VALUES (1,'Skagway City and White Pass Summit','Start with a tour of historic Skagway, and \nlearn of its lawless days during the Klondike Gold Rush of 1897-99 and travel \nthrough the White Pass Summit with lots of stops along the way to photograph the \nbeautiful scenery.',1,1,1,1,150,65.00),(2,'Scenic Waterfall Adventure','When you stop in Skagway, there is no better scenic\nand relaxing ride to the areas beautiful waterfall destinations, both in the state \nand along the Klondike Highway into Canada.',1,2,1,2,180,75.00),(3,'Helicopter Glacier Discovery','When you stop in Skagway, there is no better \nscenic and relaxing ride to the areas beautiful waterfall destinations, both in the\nstate and along the Klondike Highway into Canada.',1,2,1,2,180,435.00),(4,'White Pass Summit Rail and Bus Excursion','See more of Alaska on this scenic \nexcursion that combines the best of the White Pass Railroad with a bus tour along a\ndifferent route with stops along the way.',2,1,1,2,225,186.00),(5,'White Pass Summit Rail and Yukon Suspension Bridge','See more of Alaska on this \nscenic excursion that combines the best of the White Pass Railroad with an \nexpedition to the Yukon Suspension Bridge.',2,1,1,2,285,229.00),(6,'Exclusive Juneau City and Mendenhall Glacier Tour','This half day program will give you a city orientation and a visit to the Mendenhall Glacier and visitors center.',1,1,4,2,180,75.00),(7,'Whales and Mendenhall Glacier','Alaska spectacular marine life and one of its best known glaciers all in a half day program on a boat holding a maximum of 40 guests. Whale viewing is guaranteed.',1,1,5,1,280,225.00),(8,'Best of Juneau','Combine whale watching, a salmon bake, and views of the Mendenhall Glacier in this Juneau combination.',1,4,7,2,375,223.00),(9,'Mended hall Lake Kayak and Salmon Bake','Kayak into the breathtaking glacial waters of Mendenhall Lake and allow your senses to absorb the beauty this majestic place has to offer.',2,5,9,1,300,293.00),(10,'Mendenhall Glacier Trek','For the hearty and experienced hiker, come along for glacier trekking on the Mendenhall Glacier!',2,5,5,4,480,257.00),(11,'Helicopter Dog Sledding Extended Tour','This is a \"once in a lifetime\" tour. The helicopter flight is only one part of this legendary experience that includes flying over the Juneau Icefield to the dog camp and then experiencing a kennel tour and a dogsled ride. Choose this extended adventure for more time at the glacier!',2,5,1,2,220,832.00);
/*!40000 ALTER TABLE `excursion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `excursionview`
--

DROP TABLE IF EXISTS `excursionview`;
/*!50001 DROP VIEW IF EXISTS `excursionview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `excursionview` AS SELECT 
 1 AS `Excursion`,
 1 AS `Size`,
 1 AS `Type`,
 1 AS `Food/Beverage`,
 1 AS `Activity Level`,
 1 AS `Duration in Minutes`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `foodbeverage`
--

DROP TABLE IF EXISTS `foodbeverage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foodbeverage` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `offering` varchar(25) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `offering` (`offering`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foodbeverage`
--

LOCK TABLES `foodbeverage` WRITE;
/*!40000 ALTER TABLE `foodbeverage` DISABLE KEYS */;
INSERT INTO `foodbeverage` VALUES (10,'Beverages Included'),(8,'Buffet Included'),(6,'Coffee Included'),(9,'Lunch is Included'),(4,'None'),(2,'Not \nIncluded'),(1,'Not Included'),(7,'Salmon Bake'),(5,'Snack');
/*!40000 ALTER TABLE `foodbeverage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(50) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `address` varchar(90) NOT NULL,
  `zipCode` char(5) NOT NULL,
  `phone` char(10) NOT NULL,
  `email` varchar(90) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`),
  KEY `zipCode` (`zipCode`),
  CONSTRAINT `passenger_ibfk_1` FOREIGN KEY (`zipCode`) REFERENCES `citystate` (`zipCode`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,'Yvonne','Goodman','12 Creekside \nSt','37205','2025550109','ygoodman@isp.com'),(2,'Dante','Mackenzie','137 Wall \nSt','37205','2025550112','dmackenzie@isp.com'),(3,'Alysha','Rollins','411 Shirley \nSt','37205','2025550115','arollins@isp.com'),(4,'Avaya','Gonzalez','7771 Border \nCourt','37205','2025550119','agonzalez@isp.com'),(5,'Haniya','Kelly','6 South Sulphur Springs Street','37205','2025550121','hkelly@isp.com'),(6,'Nathalie','Chambers','942 New Saddle \nDrive','29710','2025550122','nchambers@isp.com'),(7,'Dante','Rollins','9 Wrangler \nAve','29710','2025550124','drollins@isp.com'),(8,'Beverley','Mckee','7319 S. Greenview \nDrive','29710','2025550125','bmckee@isp.com'),(9,'Paris','Lindsey','763 West Mulberry \nSt','29710','2025550132','plindsey@isp.com'),(10,'Umaiza','Melia','545 Ohio \nAve','29710','2025550135','umelia@isp.com'),(11,'Nico','Prince','20 Middle River \nStreet','44094','2025550137','nprince@isp.com'),(12,'Javan','Rennie','8112 North Country \nSt','44094','2025550139','jrennie@isp.com'),(13,'Ali','Waters','83 Rockland \nLane','44094','2025550144','awaters@isp.com'),(14,'JohnPaul','Clarke','1 Riverside \nLane','44094','2025550153','jpcClarke@isp.com'),(15,'Dane','Kaiser','694 Wall \nRoad','44094','2025550155','kdaiser@isp.com'),(16,'Hammad','Newman','9970 State \nCourt','30096','2025550157','hnewman@isp.com'),(17,'Maha','Guthrie','54 Woodsman \nDrive','30096','2025550161','mguthrie@isp.com'),(18,'Tulisa','Roberts','7174 Studebaker \nStreet','30096','2025550163','troberts@isp.com'),(19,'Robin','Solis','8474 Wentworth \nStreet','30096','2025550164','rsolis@isp.com'),(20,'Kavita','Heath','796 Hartford \nSt','30096','2025550165','kheath@isp.com'),(21,'Meera','White','484 Bridge \nSt','08854','2025550166','mwhite@isp.com'),(22,'Bradlee','Esparza','7031 Gainsway \nSt','08854','2025550173','besparza@isp.com'),(23,'Leilani','Leonard','37 Monroe \nStreet','08854','2025550175','lleonard@isp.com'),(24,'Stefanie','Brook','7990 West Surrey \nSt','08854','2025550179','sbrook@isp.com'),(25,'Grover','Squires','7618 Madison \nCourt','08854','2025550180','gsquires@isp.com'),(26,'Jonathan','Kumar','25 Annadale \nCourt','33458','2025550182','jkumar@isp.com'),(27,'Angus','Neville','9841 Smith \nDrive','33458','2025550187','aneville@isp.com'),(28,'Uzair','Sparrow','7999 Hall \nStreet','33458','2025550188','usparrow@isp.com'),(29,'Amari','Currie','8411 Pleasant \nSt','33458','2025550194','acurrie@isp.com'),(30,'Imaani','Wallace','33 Pierce \nRd','33458','2025550195','iwallace@isp.com'),(31,'Efe','House','97 High Point Street','20706','2025550196','ehouse@isp.com'),(32,'Atticus','Atkinson','66 Harrison Dr','20706','2025550197','aatkinson@isp.com'),(33,'Michelle','Ramirez','370 Hill Field Ave','20706','2025550198','mramirez@isp.com'),(34,'Remy','Hassan','249 Devon Lane','20706','2025550199','rhassan@isp.com'),(35,'Jordana','Beck','7911 Carson Lane','20706','2025550200','jbeck@isp.com');
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengerexcursion`
--

DROP TABLE IF EXISTS `passengerexcursion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengerexcursion` (
  `passengerId` int NOT NULL,
  `excursionId` int NOT NULL,
  PRIMARY KEY (`passengerId`,`excursionId`),
  KEY `excursionId` (`excursionId`),
  CONSTRAINT `passengerexcursion_ibfk_1` FOREIGN KEY (`passengerId`) REFERENCES `passenger` (`ID`),
  CONSTRAINT `passengerexcursion_ibfk_2` FOREIGN KEY (`excursionId`) REFERENCES `excursion` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengerexcursion`
--

LOCK TABLES `passengerexcursion` WRITE;
/*!40000 ALTER TABLE `passengerexcursion` DISABLE KEYS */;
INSERT INTO `passengerexcursion` VALUES (5,1),(7,1),(12,1),(1,2),(2,2),(23,3),(27,3),(8,4),(11,4),(16,5),(30,5),(19,6),(20,6),(15,7),(28,7),(32,8),(35,8),(22,11),(31,11);
/*!40000 ALTER TABLE `passengerexcursion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `position` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL,
  `hourly` decimal(5,2) NOT NULL DEFAULT '11.00',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `description` (`description`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,'Accounting & Finance',15.00),(2,'Activities & Fitness',15.00),(3,'Administration',18.00),(4,'Advertising & Marketing',21.00),(5,'Casino',13.00),(6,'Culinary Chef',25.00),(7,'Deck & Engine',18.00),(8,'Engineering',39.00),(9,'Entertainment',22.00),(10,'Food & Beverage',13.00),(11,'Front Desk & Concierge',21.00),(12,'Guest Services',14.00),(13,'Housekeeping',12.00),(14,'HR',15.00),(15,'IT & Internet',20.00),(16,'Legal',40.00),(17,'Mechanic & Maintenance',34.00),(18,'Procurement & Purchasing',18.00),(19,'Retail & Merchandising',24.00),(20,'Sales & Reservations',24.00),(21,'Salon & Spa',25.00),(22,'Security & Surveillance',18.00),(23,'Shore Excursion',20.00),(24,'Travel & Tourism',23.00);
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `exSize` varchar(25) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `exSize` (`exSize`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (4,'Private'),(2,'Small'),(1,'Standard');
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timesheet`
--

DROP TABLE IF EXISTS `timesheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timesheet` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `crewId` int NOT NULL,
  `sun` int NOT NULL DEFAULT '0',
  `mon` int NOT NULL DEFAULT '0',
  `tues` int NOT NULL DEFAULT '0',
  `wed` int NOT NULL DEFAULT '0',
  `thurs` int NOT NULL DEFAULT '0',
  `fri` int NOT NULL DEFAULT '0',
  `sat` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `crewId` (`crewId`),
  CONSTRAINT `timesheet_ibfk_1` FOREIGN KEY (`crewId`) REFERENCES `crew` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timesheet`
--

LOCK TABLES `timesheet` WRITE;
/*!40000 ALTER TABLE `timesheet` DISABLE KEYS */;
INSERT INTO `timesheet` VALUES (41,25,12,0,12,0,4,12,0),(42,13,7,4,9,0,0,10,3),(43,27,0,12,6,10,6,8,0),(44,36,8,8,0,0,8,10,6),(45,12,0,8,8,8,8,8,0),(46,29,12,0,12,0,4,12,0),(47,32,0,12,6,10,6,8,0),(48,4,10,8,0,0,8,10,10),(49,20,8,8,0,0,8,10,6),(50,14,12,0,12,0,4,12,0),(51,21,8,8,0,0,8,10,6),(52,16,12,0,12,0,4,12,0),(53,34,0,8,8,8,8,8,0),(54,7,12,0,12,0,4,12,0),(55,10,6,6,6,6,6,5,0),(56,39,0,8,8,8,8,8,0),(57,30,10,8,0,0,8,10,10),(58,38,7,4,9,0,0,10,3),(59,37,6,6,6,6,6,5,0),(60,5,6,6,6,6,6,5,0),(61,40,10,8,0,0,8,10,10),(62,15,7,4,9,0,0,10,3),(63,31,10,8,0,0,8,10,10),(64,11,10,8,0,0,8,10,10),(65,24,7,4,9,0,0,10,3),(66,35,8,8,0,0,8,10,6),(67,28,12,0,12,0,4,12,0),(68,6,0,8,8,8,8,8,0),(69,17,10,8,0,0,8,10,10),(70,18,0,8,8,8,8,8,0),(71,23,6,6,6,6,6,5,0),(72,1,0,12,6,10,6,8,0),(73,2,0,8,8,8,8,8,0),(74,8,8,8,0,0,8,10,6),(75,9,0,12,6,10,6,8,0),(76,26,0,12,6,10,6,8,0),(77,22,6,6,6,6,6,5,0),(78,33,0,12,6,10,6,8,0),(79,3,6,6,6,6,6,5,0),(80,19,0,8,8,8,8,8,0);
/*!40000 ALTER TABLE `timesheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `timesheetview`
--

DROP TABLE IF EXISTS `timesheetview`;
/*!50001 DROP VIEW IF EXISTS `timesheetview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `timesheetview` AS SELECT 
 1 AS `Crew Member`,
 1 AS `Hours`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `exType` varchar(25) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `exType` (`exType`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES (5,'Active'),(7,'Beach'),(4,'Cuisine'),(2,'Cultural'),(1,'Scenic'),(6,'Water');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cruise'
--
/*!50003 DROP PROCEDURE IF EXISTS `payCheck` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `payCheck`(IN crewNum INT, INOUT salary VARCHAR(4000))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_name`()
BEGIN
  
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `bookedexcursionview`
--

/*!50001 DROP VIEW IF EXISTS `bookedexcursionview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `bookedexcursionview` AS select concat(`c`.`firstName`,' ',`c`.`lastName`) AS `Crew Member`,concat(`p`.`firstName`,' ',`p`.`lastName`) AS `Passenger`,`e`.`name` AS `Excursion`,`fb`.`offering` AS `Food/Beverage`,`e`.`durationMinutes` AS `Duration in Minutes` from (((((`crew` `c` join `passenger` `p`) join `excursion` `e`) join `passengerexcursion` `pe`) join `foodbeverage` `fb`) join `crewexcursion` `ce`) where ((`c`.`ID` = `ce`.`crewId`) and (`p`.`ID` = `pe`.`passengerId`) and (`e`.`foodBeverageId` = `fb`.`ID`) and (`e`.`ID` = `pe`.`excursionId`) and (`e`.`ID` = `ce`.`excursionId`)) order by `e`.`name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `crewpositionview`
--

/*!50001 DROP VIEW IF EXISTS `crewpositionview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `crewpositionview` AS select concat(`c`.`firstName`,' ',`c`.`lastName`) AS `Crew Member`,`c`.`phone` AS `Crew Phone`,`p`.`description` AS `Crew Position` from ((`crew` `c` join `position` `p`) join `crewposition` `cp`) where ((`cp`.`crewId` = `c`.`ID`) and (`cp`.`positionId` = `p`.`ID`)) order by `p`.`description`,`c`.`lastName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `excursionview`
--

/*!50001 DROP VIEW IF EXISTS `excursionview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `excursionview` AS select `e`.`name` AS `Excursion`,`s`.`exSize` AS `Size`,`t`.`exType` AS `Type`,`fb`.`offering` AS `Food/Beverage`,`al`.`exLevel` AS `Activity Level`,`e`.`durationMinutes` AS `Duration in Minutes`,`e`.`price` AS `Price` from ((((`excursion` `e` join `foodbeverage` `fb`) join `type` `t`) join `size` `s`) join `activitylevel` `al`) where ((`e`.`foodBeverageId` = `fb`.`ID`) and (`e`.`sizeId` = `s`.`ID`) and (`e`.`typeId` = `t`.`ID`) and (`e`.`activityLevelId` = `al`.`ID`)) order by `al`.`exLevel` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `timesheetview`
--

/*!50001 DROP VIEW IF EXISTS `timesheetview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `timesheetview` AS select concat(`c`.`firstName`,' ',`c`.`lastName`) AS `Crew Member`,((((((`t`.`sun` + `t`.`mon`) + `t`.`tues`) + `t`.`wed`) + `t`.`thurs`) + `t`.`fri`) + `t`.`sat`) AS `Hours` from (`timesheet` `t` join `crew` `c`) where (`c`.`ID` = `t`.`ID`) order by `c`.`lastName` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-23 18:52:32
