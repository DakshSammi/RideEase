SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS RideEase;
CREATE SCHEMA RideEase;
USE RideEase;

CREATE TABLE Driver (
    Driver_ID INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    mname VARCHAR(50),
    lname VARCHAR(50),
    E_mail VARCHAR(100) NOT NULL,
    DriverPassword VARCHAR(50) NOT NULL,
    Driver_rating INT NOT NULL,
    Dr_Status ENUM('active', 'inactive') NOT NULL,
    DOB DATE NOT NULL,
    CHECK (DOB <= '2005-01-01'),
    CHECK (Driver_rating >= '1'
        AND Driver_rating <= '5'),
	UNIQUE (E_mail),
    INDEX driver_id (Driver_ID),
    INDEX email_index (E_mail),
    INDEX dr_status_index (Dr_Status)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE Users (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(50) NOT NULL,
    mname VARCHAR(50),
    lname VARCHAR(50),
    User_Status ENUM('Normal', 'Prime') NOT NULL,
    E_mail VARCHAR(100) NOT NULL,
    UserPassword VARCHAR(50) NOT NULL,
    UNIQUE (E_mail),
    INDEX email_index (E_mail)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE User_phone (
    User_ID INT,
    Phone_number1 VARCHAR(20) NOT NULL,
    Phone_number2 VARCHAR(20),
    PRIMARY KEY (User_ID , Phone_number1,Phone_number2),
    FOREIGN KEY (User_ID)
        REFERENCES Users(User_ID),
    INDEX user_id_index (User_ID)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE DrivesFor (
    DrivID INT,
    UsrID INT,
    Tim DATETIME,
    Distance FLOAT NOT NULL,
    PRIMARY KEY (DrivID , UsrID),
    FOREIGN KEY (DrivID)
        REFERENCES Driver (Driver_ID),
    FOREIGN KEY (UsrID)
        REFERENCES Users (User_ID),
    CHECK (Distance >= 0 AND Distance <= 1000),
    UNIQUE (Tim),
    INDEX driv_id_index (DrivID),
    INDEX usr_id_index (UsrID)
)  ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE Bookings (
    Booking_ID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Dri_ID INT,
    Pickup VARCHAR(50) NOT NULL,
    Dropoff VARCHAR(50) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(User_ID),
    FOREIGN KEY (Dri_ID) REFERENCES Driver(Driver_ID),
    INDEX idx_UserID (UserID),
    INDEX idx_Dri_ID (Dri_ID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Vehicle (
    Vehicle_ID INT AUTO_INCREMENT PRIMARY KEY,
    DriveeID INT,
    License_Platenumber VARCHAR(20) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Make VARCHAR(50) NOT NULL,
    FOREIGN KEY (DriveeID) REFERENCES Driver(Driver_ID),
    UNIQUE (License_Platenumber),
    INDEX idx_DriveeID (DriveeID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Ride (
    VehiclesID INT,
    RideID INT AUTO_INCREMENT,
    Tracking VARCHAR(50),
    R_Type ENUM('Car','Bike', 'Auto') NOT NULL,
    PRIMARY KEY (RideID),
    FOREIGN KEY (VehiclesID) REFERENCES Vehicle(Vehicle_ID),
    CHECK (R_Type IN ('Car', 'Bike', 'Auto')),
    INDEX idx_VehiclesID (VehiclesID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BookieID INT,
    Payment_Amount INT NOT NULL,
    Payment_Method ENUM('Cash', 'Credit Card','Debit Card', 'Wallet/UPI') NOT NULL,
    Payment_Status ENUM('Paid', 'Pending') NOT NULL,
    FOREIGN KEY (BookieID) REFERENCES Bookings(Booking_ID),
    CHECK (Payment_Method IN ('Cash', 'Credit Card', 'Debit Card', 'Wallet/UPI')),
	CHECK (Payment_Status IN ('Paid', 'Pending')),
    INDEX idx_BookieID (BookieID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE DiscountOffers (
	DiscountID INT auto_increment KEY,
    userLID INT NOT NULL,
	Discount_Detail VARCHAR(50),
	Discount_Percentage INT NOT NULL,
    FOREIGN KEY (userLID) REFERENCES Users(User_ID),
    INDEX  idx_DiscountOffers(DiscountID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Tracking (
    Tracking_ID INT AUTO_INCREMENT PRIMARY KEY,
    Latitude varchar(50),
    Longitude varchar(50),
    BookeID INT,
    FOREIGN KEY (BookeID) REFERENCES Bookings(Booking_ID),
    INDEX idx_BookeID (BookeID)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET NAMES utf8mb4;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';
SET @old_autocommit=@@autocommit;

USE RideEase;
#
# TABLE STRUCTURE FOR: Bookings
#

DROP TABLE IF EXISTS `Bookings`;

CREATE TABLE `Bookings` (
  `Booking_ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) DEFAULT NULL,
  `Dri_ID` int(11) DEFAULT NULL,
  `Pickup` varchar(50) NOT NULL,
  `Dropoff` varchar(50) NOT NULL,
  PRIMARY KEY (`Booking_ID`),
  KEY `idx_UserID` (`UserID`),
  KEY `idx_Dri_ID` (`Dri_ID`),
  CONSTRAINT `Bookings_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `Users` (`User_ID`),
  CONSTRAINT `Bookings_ibfk_2` FOREIGN KEY (`Dri_ID`) REFERENCES `Driver` (`Driver_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (1, 15, 94, '8D Isadore Esplanade\nSouth Joel, NSW 7153', '86 / 21 Adrien Pathway\nNew Rahulfurt, WA 6956');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (2, 33, 37, '8D Isadore Esplanade\nSouth Joel, NSW 7153', '115 Kovacek Spur\nEast Quinn, SA 6365');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (3, 33, 80, '8D Isadore Esplanade\nSouth Joel, NSW 7153', '34C Collins Expressway\nKeelingport, NSW 4791');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (4, 92, 104, '91D Haag Brace\nStrosinland, QLD 8794', '09 / 952 Gleichner Lookout\nLake Aleenhaven, WA 532');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (5, 59, 67, '899A Richie Lower\nSt. Sabina, TAS 7979', 'Level 4 88 Halvorson Corso\nNew Adaline, WA 5131');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (6, 18, 12, 'Flat 82 651 Stark Boulevard\nEast Arnold, VIC 7379', 'Level 0 68 Myra Ridge\nEast Giovanny, NT 1325');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (7, 16, 42, '27B Karianne Terrace\nEast Matteo, NSW 1932', '3C Jordan Ridgeway\nLake Dorotheachester, NT 6694');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (8, 23, 44, '27B Karianne Terrace\nEast Matteo, NSW 1932', '1B Eichmann Gardens\nLake Foster, VIC 2799');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (9, 82, 31, '27B Karianne Terrace\nEast Matteo, NSW 1932', '10B Aisha Footway\nLake Lowell, TAS 2801');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (10, 52, 3, '27B Karianne Terrace\nEast Matteo, NSW 1932', '84A Abernathy Quadrangle\nBahringertown, NSW 0138');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (11, 48, 64, 'Apt. 822 73 Susie Track\nHoegerland, NSW 8487', '2 Jacobson Cruiseway\nJohannburgh, TAS 1875');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (12, 1, 32, '715C Elisa Grange\nPort Zoefurt, TAS 4780', 'Apt. 126 0 Hillary Hill\nPort Skylar, TAS 1417');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (13, 8, 113, '054 Alisha Glade\nThompsonport, QLD 7513', '7 / 33 Reichert Colonnade\nSouth Lucindaland, QLD 9');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (14, 56, 117, 'Unit 41 300 Tillman Formation\nPort Felicitaberg, Q', '7 Aufderhar Plateau\nWest Grady, TAS 5985');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (15, 5, 93, 'Flat 82 651 Stark Boulevard\nEast Arnold, VIC 7379', '704 / 946 Gust Wade\nHahnhaven, VIC 1824');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (16, 44, 78, 'Level 9 8 Cartwright Gates\nBaileyfurt, QLD 0954', '2A Ondricka Quadrangle\nSouth Damion, WA 5560');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (17, 82, 105, '515 Hilton Slope\nHoldenhaven, ACT 8199', '729 / 29 Smitham Crossroad\nEast Brandon, TAS 5647');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (18, 75, 58, '106 Zieme Colonnade\nSt. Adrienneville, WA 1676', '843 Wolff Garden\nClevefort, ACT 8550');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (19, 76, 55, 'Flat 13 080 Adrain Crescent\nJonesburgh, QLD 9993', '628A Tressa Grove\nGloverview, QLD 1659');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (20, 2, 62, '615B Eleanore Roads\nSt. Elyssafort, NSW 4152', 'Flat 28 296 Wilson Corner\nGarrisonfurt, NT 9829');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (21, 59, 73, '34 Goodwin Interchange\nDanielmouth, ACT 7558', '8 Julio Beach\nMertzport, WA 8383');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (22, 10, 112, '407 Raymundo Rosebowl\nNew Tomasmouth, TAS 0852', '0D Pouros Tarn\nLake Jovannyfurt, TAS 5399');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (23, 41, 121, '72 / 297 Skye Spur\nQuitzonside, QLD 4387', '08A Peter Round\nBrownberg, NT 1302');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (24, 92, 71, '50C Alize Approach\nDelphineburgh, NT 2688', '651A Jeanie Highroad\nNatashaville, NT 7016');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (25, 63, 59, '410C Kirlin Broadway\nNew Jeffreystad, ACT 2842', '602B Braun Steps\nSchusterburgh, NSW 4851');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (26, 85, 78, '4D Bahringer Bypass\nBotsfordfurt, VIC 9931', '65 / 606 Else Approach\nPort Krystinastad, TAS 0215');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (27, 9, 42, '406 Miller Grove\nCorenemouth, TAS 2922', '056C Thompson Gap\nHermannhaven, NT 4601');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (28, 22, 76, 'Flat 93 4 Torp Laneway\nSouth Sharon, NT 1869', 'Suite 287 0 Metz Brae\nNorth Okeyport, TAS 2429');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (29, 62, 68, '99 Considine Dell\nNorth Alvertaberg, ACT 9985', '27B Beier Roadside\nSamantabury, TAS 6435');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (30, 17, 6, '49D Kreiger Gate\nSouth Ludwigburgh, TAS 8895', '1 Morar Brow\nLake Tamaraberg, ACT 8680');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (31, 5, 129, '04 Tremblay Wynd\nPort Raymundo, ACT 6082', '295A Colleen Copse\nSt. Abigayleburgh, SA 3825');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (32, 18, 51, '476B Rachael Estate\nWest Columbus, WA 6248', 'Apt. 977 570 Treutel Green\nReillymouth, TAS 1136');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (33, 32, 20, '836 / 0 Streich Fire Track\nFeestton, WA 9403', '7C Victoria Grove\nBrakusshire, QLD 8078');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (34, 26, 14, '84A Hagenes Run\nNathanaelbury, NT 5594', 'Unit 26 9 Wuckert Rotary\nNorth Christop, NT 1569');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (35, 93, 80, 'Suite 919 7 Joan Path\nErniestad, NSW 9236', '31 / 564 Cummings Highroad\nPort Hermannborough, AC');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (36, 27, 57, 'Apt. 325 95 Irwin Roads\nRosemaryberg, WA 9942', '93 Rodriguez Cross\nEast Armando, TAS 2989');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (37, 85, 9, 'Unit 84 573 Jadyn Vale\nAnkundingview, NT 4702', '2 Ortiz Crescent\nSt. Cyrilbury, SA 8268');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (38, 6, 45, 'Apt. 578 886 Schultz Close\nRobertshaven, WA 8973', '5 O\'Kon Circuit\nSt. Blanche, QLD 2203');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (39, 43, 118, '377A Ondricka Estate\nMcLaughlinshire, ACT 4244', '21 Triston Corner\nShaniyaville, TAS 0373');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (40, 87, 48, '50C Bins Cross\nEast Khalid, NT 1658', '321 Wilbert Row\nSouth Lexusborough, WA 5256');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (41, 14, 30, '84 Stroman Crossway\nGrahamton, VIC 4071', '4A Marielle Fairway\nSouth Kelvinton, SA 5785');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (42, 69, 27, '7 Michele Lane\nMelissastad, TAS 1587', '862B Gayle Track\nMosciskibury, TAS 6056');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (43, 88, 61, '9 Devon Quay\nDarrinchester, VIC 8406', '8D Laurence Sound\nKohlerhaven, QLD 6707');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (44, 41, 35, '4D Mohammad Ground\nSouth Lauriane, NT 6219', '2A Titus Dale\nHarrismouth, WA 6983');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (45, 29, 71, '391C Lebsack Approach\nHesselchester, VIC 6201', '764D Rosenbaum Crossroad\nStrosinmouth, WA 7754');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (46, 40, 4, '8 / 41 Betty Byway\nWest Arielport, NSW 9324', '956 Isabell Amble\nJarrellborough, NSW 7458');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (47, 69, 10, '71 Kyler Row\nMayeton, SA 0057', '46A Clifton Rosebowl\nConcepcionview, VIC 6892');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (48, 42, 49, 'Apt. 008 5 Olen Spur\nNorth Ciceroside, VIC 3863', '94 Ellie Ring\nVitafurt, TAS 9424');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (49, 19, 81, 'Flat 49 05 Myah Tollway\nLake Blanche, NT 9217', '1D Cassin Pathway\nNorth Elmira, NSW 2419');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (50, 26, 119, 'Flat 19 2 Collier Brow\nGoodwinberg, SA 1503', '96C Ahmed Access\nJohnstonport, VIC 9755');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (51, 16, 116, '276D Suzanne Walk\nStiedemannfurt, VIC 3590', '50D Hilll Street\nAlfchester, SA 8286');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (52, 13, 97, '2 / 3 Maida Causeway\nSchuppeshire, TAS 2633', '287D Lolita Centreway\nTrompshire, QLD 9828');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (53, 87, 89, '439D Virginia Anchorage\nKohlerville, QLD 3442', '5 Charlotte Freeway\nWest Lilyan, WA 0816');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (54, 18, 17, '73 Ortiz Crossing\nPort Rosetta, TAS 7190', 'Flat 61 79 Sauer Edge\nThompsonhaven, VIC 7374');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (55, 14, 63, '823 Jacobson Esplanade\nMakaylaland, NT 7526', '42 Rutherford Expressway\nBessieport, WA 7866');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (56, 10, 23, '822 Hilll Reach\nNorth Nora, NSW 7613', '479 / 20 Tara Interchange\nGoyettefurt, VIC 6695');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (57, 10, 20, '64 Mohr Rise\nSouth Alessandra, TAS 0862', '6D Hiram Bend\nWymantown, ACT 8332');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (58, 64, 120, '58 / 953 Block Road\nQuentinberg, QLD 6242', 'Suite 595 7 Klocko Junction\nFelicitaside, NT 5742');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (59, 74, 58, '1C Borer Ridgeway\nHahntown, TAS 4102', '03 / 6 Noelia Drive\nNorth Jakaylaland, QLD 0195');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (60, 99, 23, '699 Obie Circus\nJohnstonshire, SA 7393', '20C Gulgowski Cruiseway\nRahsaanport, SA 8503');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (61, 30, 106, '8 Bode Mews\nKautzerton, QLD 9646', 'Flat 01 427 Jensen Part\nSt. Sheahaven, WA 0133');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (62, 55, 19, '4 Arvilla Lookout\nNorth Esteban, NT 2310', 'Level 9 62 Natalia Turn\nLawrenceport, NT 5168');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (63, 58, 16, 'Unit 84 9 Ondricka Rise\nBalistrerifort, NSW 7666', '19A Elvie Street\nNew Zora, VIC 1941');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (64, 26, 38, '3 Deshaun Plateau\nNew Jessika, TAS 9984', '768A Zachariah Run\nNorth Uriah, WA 5474');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (65, 22, 101, '16C Phoebe Link\nWhitehaven, VIC 0690', '337 Leon Footway\nBertafort, QLD 9362');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (66, 52, 11, '298 Karianne Ground\nWest Dellview, WA 5215', 'Flat 27 1 Jacobs Mount\nPort Clement, TAS 5872');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (67, 74, 129, 'Suite 329 55 Johnston Outlook\nPort Chelsie, NSW 40', '12 Crona Cul-de-sac\nLake Bernadetteburgh, QLD 3713');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (68, 48, 120, '4B Brianne Way\nHeaneyland, WA 1313', '8 / 04 Powlowski Link\nAnnabelltown, TAS 9253');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (69, 6, 89, '169D Feest Slope\nSwaniawskiberg, WA 8661', '864 Hauck Brae\nNorth Trevorland, SA 6335');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (70, 13, 10, '179D Lance River\nNew Elysefurt, TAS 8769', 'Unit 84 112 Sawayn Entrance\nNorth Jerrell, ACT 729');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (71, 24, 63, '586A Micaela Grange\nElroybury, VIC 6483', '99 Katarina Brace\nDamienview, QLD 2432');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (72, 93, 117, '66 Burdette Quays\nLake Dock, SA 1686', 'Suite 136 9 Merl Ridge\nNorth Daija, TAS 8772');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (73, 35, 114, '58 Dedrick Esplanade\nAbigaylebury, TAS 8704', 'Unit 64 462 Sandy Terrace\nYasminestad, TAS 7207');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (74, 29, 12, 'Level 7 62 Dominic Formation\nWardfurt, NSW 7356', '6 Legros Garden\nLake Vincenzo, ACT 2437');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (75, 51, 87, 'Apt. 873 87 Dashawn Roadway\nNorth Haleigh, QLD 413', 'Flat 97 97 Alyson Access\nWest Groverside, VIC 5390');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (76, 37, 41, '55 Domenica Strand\nFerrybury, SA 1588', '410A Adam Firetrail\nLegrosport, WA 5908');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (77, 41, 3, 'Suite 844 108 Connie Grange\nKariberg, TAS 3744', '28D Tom Highroad\nVictormouth, QLD 7282');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (78, 19, 47, '32 Dayna Ramp\nPort Emmie, VIC 7154', 'Unit 10 0 Osvaldo Vale\nNew Christa, ACT 1404');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (79, 38, 62, '169 Barry Steps\nSt. Shanabury, ACT 9901', 'Level 9 4 Armstrong Expressway\nVelmahaven, ACT 708');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (80, 63, 76, '37 Kub Access\nMaribeltown, NT 8692', '81D Maxine Footway\nWest Leonorshire, QLD 7545');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (81, 90, 102, '77C Lupe Driveway\nLehnerbury, ACT 4425', 'Suite 991 181 Zion Frontage\nRodriguezview, NSW 284');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (82, 53, 127, '610 / 1 Smith Riviera\nSavionborough, TAS 9013', '992A Jany Glade\nWest Camryn, NT 1695');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (83, 17, 15, '7B Jody Riverway\nEast Breanna, SA 9109', '776 / 6 Leanne Lees\nSt. Lorineland, VIC 9568');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (84, 11, 80, 'Apt. 267 890 Stroman Glen\nProsaccofort, NT 0086', 'Suite 952 832 Maxime Circlet\nSouth Demarcus, WA 09');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (85, 42, 102, '010D Yost Close\nBotsfordborough, WA 5792', '4D Olin Round\nGoldenport, ACT 3353');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (86, 34, 15, '1A Glover Drive\nSouth Herman, NSW 1892', 'Apt. 672 094 Randi Follow\nShermanberg, QLD 5285');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (87, 70, 95, '10 Madonna Wynd\nKertzmannfort, SA 2319', '410 / 665 Leonora Dell\nLake Kory, QLD 6380');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (88, 36, 57, '693C Tristin Hill\nJeremiechester, ACT 8542', 'Unit 97 9 West Alley\nJaquelinfurt, SA 3167');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (89, 38, 53, '8 / 117 Heaven Villas\nNorth Stephon, ACT 7898', '199B Macejkovic Alley\nSt. Lacyville, TAS 6254');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (90, 78, 82, '09A Osvaldo Ride\nWilbertberg, SA 2169', 'Apt. 746 28 Malika Vale\nWest Arachester, ACT 2089');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (91, 24, 42, '830 Nickolas Trailer\nNew Elouise, QLD 2456', '0 Donnelly Trunkway\nPhoebeborough, NSW 0543');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (92, 28, 81, '71 / 1 Tromp Mount\nWest Daxberg, WA 6696', '30D Trantow Viaduct\nHauckport, TAS 1712');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (93, 89, 38, '329D Rutherford Boulevard\nKorbinburgh, ACT 8398', '68 Bauch Corner\nLennymouth, NT 3625');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (94, 23, 115, '969 Kling Parklands\nErnieberg, QLD 6124', '486 Otho Gate\nSkyeshire, NSW 1076');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (95, 6, 72, '06 Triston Landing\nEinoborough, NT 7096', 'Flat 41 849 Windler Formation\nMadilynborough, NSW ');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (96, 27, 60, '5B Klein Pathway\nDavishaven, SA 0893', '82 O\'Conner End\nWest Orlando, NSW 2409');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (97, 74, 80, '87 / 1 Roger Footway\nPowlowskiport, NSW 7928', '7 / 660 Robin Riviera\nHeathcoteshire, QLD 5671');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (98, 82, 65, 'Flat 46 806 Crooks Track\nPort Elyse, TAS 8212', '563D Welch Plaza\nWest Clara, ACT 6415');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (99, 73, 44, '8 Brook Ridgeway\nSouth Hector, WA 9562', 'Flat 37 502 Carli Centre\nSt. Christbury, SA 2946');
INSERT INTO `Bookings` (`Booking_ID`, `UserID`, `Dri_ID`, `Pickup`, `Dropoff`) VALUES (100, 39, 14, 'Flat 72 96 Hermina Upper\nNew Alexandreside, ACT 24', '89 Ward Green\nNorth Beverly, ACT 8498');


#
# TABLE STRUCTURE FOR: DiscountOffers
#

DROP TABLE IF EXISTS `DiscountOffers`;

CREATE TABLE `DiscountOffers` (
  `DiscountID` int(11) NOT NULL AUTO_INCREMENT,
  `userLID` int(11) NOT NULL,
  `Discount_Detail` varchar(50) DEFAULT NULL,
  `Discount_Percentage` int(11) NOT NULL,
  PRIMARY KEY (`DiscountID`),
  KEY `userLID` (`userLID`),
  KEY `idx_DiscountOffers` (`DiscountID`),
  CONSTRAINT `DiscountOffers_ibfk_1` FOREIGN KEY (`userLID`) REFERENCES `Users` (`User_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (1, 48, 'Quis unde sit facere est. Sit cupiditate aut adipi', 76);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (2, 53, 'Accusamus earum quo aut cupiditate ut fugit quibus', 50);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (3, 69, 'Optio reprehenderit nihil hic soluta mollitia. Rer', 31);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (4, 38, 'Quia recusandae tenetur est eaque sed omnis. Est n', 67);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (5, 64, 'Dolorem aliquid iusto cumque alias sed nobis quasi', 98);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (6, 81, 'Molestiae molestiae consequatur facilis error dele', 85);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (7, 84, 'Ducimus ea et eaque atque natus iste in. Culpa dol', 48);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (8, 54, 'Cum commodi nostrum ipsam perferendis. Provident a', 15);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (9, 92, 'Impedit voluptatum quia eum quidem dignissimos rem', 69);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (10, 8, 'Corrupti nam culpa fugiat non et. Voluptas quisqua', 79);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (11, 97, 'Libero enim eaque officia. Eaque autem dolor at eu', 88);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (12, 48, 'Qui est voluptas ut consequatur totam commodi aut.', 32);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (13, 61, 'Consequatur maxime expedita aut voluptatem dolores', 72);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (14, 22, 'Aut odit cum a et consequatur. Nisi non eligendi q', 86);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (15, 11, 'Sint ad repellat ut ipsa. Et non illum sit aliquid', 60);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (16, 70, 'Ratione quia repellendus non officiis laudantium. ', 47);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (17, 20, 'Voluptas voluptates aut voluptatibus aut quis et n', 45);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (18, 45, 'Enim in doloribus laudantium in nulla. Ut odio fug', 18);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (19, 13, 'Necessitatibus ratione quis officia doloremque asp', 1);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (20, 79, 'Fugiat ex quas voluptatem qui recusandae. Ratione ', 60);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (21, 9, 'Quia et iusto qui fugit saepe ea vel fuga. Totam s', 78);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (22, 67, 'Perferendis laboriosam dolores dolore dolores quia', 82);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (23, 77, 'Non aspernatur esse deserunt est. Dolores aspernat', 35);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (24, 67, 'Et qui pariatur aut voluptatem. Quibusdam porro no', 74);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (25, 93, 'Necessitatibus dolorem quo officia dolorem. Exerci', 59);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (26, 21, 'Et saepe iusto assumenda soluta mollitia. Consequa', 47);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (27, 45, 'Est tenetur pariatur ipsa et sunt sed. Et nihil ra', 39);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (28, 61, 'Quaerat explicabo sed et dignissimos repellat volu', 92);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (29, 83, 'Blanditiis iste rerum qui consequatur est voluptas', 58);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (30, 45, 'Dolorem provident id expedita dolore praesentium s', 31);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (31, 97, 'Hic doloremque aliquam omnis excepturi et illum do', 23);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (32, 15, 'Esse explicabo aperiam distinctio eveniet alias. D', 10);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (33, 51, 'Voluptas voluptatibus quia vel quae temporibus non', 21);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (34, 40, 'Quia tempora accusantium et occaecati aliquam. Fug', 91);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (35, 77, 'Illo est aliquam nulla atque. Et iure officia dolo', 74);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (36, 85, 'Ipsa unde voluptatem aut eaque qui. Voluptatibus s', 20);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (37, 92, 'Provident quia sit veniam adipisci est illum nemo.', 74);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (38, 96, 'Dolor expedita laborum facere. Qui vitae laborum n', 26);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (39, 29, 'Asperiores totam omnis sint. Qui veritatis ut amet', 58);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (40, 31, 'Voluptas hic consequuntur totam debitis et fugit q', 25);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (41, 75, 'Nobis dolorum maxime iste non nulla. Quos odit qui', 98);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (42, 58, 'Necessitatibus officiis nulla culpa consequuntur. ', 93);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (43, 100, 'Rerum quam repellendus dolorum natus voluptatum ip', 7);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (44, 45, 'Dolore tempore et veritatis beatae deleniti. Sunt ', 28);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (45, 21, 'Inventore tenetur iure autem et. Ut fuga et impedi', 58);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (46, 55, 'Libero quia soluta et quos recusandae placeat. Deb', 18);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (47, 80, 'Corrupti quis fugiat sit dolorum voluptates et qui', 17);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (48, 81, 'Esse eligendi dolorum natus ut voluptate. Adipisci', 70);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (49, 5, 'Omnis est et hic corporis. Sequi molestiae dolorem', 83);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (50, 15, 'Dolores aut ab dolor ratione. Sit cum debitis ulla', 41);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (51, 96, 'Quia quo quia ipsa ullam accusamus. Minus ut omnis', 81);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (52, 7, 'Neque sunt voluptatem consequatur aspernatur. Sequ', 14);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (53, 88, 'Architecto sint dolorem odit magni atque sequi. Vo', 71);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (54, 72, 'Qui corporis molestias nesciunt consectetur et. Od', 93);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (55, 93, 'Dolor aliquid vero doloribus sed aspernatur. Ipsam', 80);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (56, 63, 'Qui sit rem quaerat quae vitae ut cupiditate. Qui ', 64);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (57, 41, 'Suscipit molestiae aliquid dolorem ut nisi. Dolore', 94);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (58, 99, 'Consequuntur est deleniti sed iusto inventore sint', 0);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (59, 47, 'Sed quidem corporis non perspiciatis. Culpa deleni', 55);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (60, 94, 'Rerum molestiae porro non harum voluptas. Sed plac', 33);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (61, 26, 'Ratione id soluta porro neque adipisci. Numquam si', 100);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (62, 96, 'Fuga facilis eos natus dolore est dolore. Quas occ', 56);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (63, 10, 'Illum nobis quo voluptatibus labore ad. Cum delect', 41);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (64, 67, 'Quas corporis ab iure expedita voluptas. Esse dist', 20);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (65, 62, 'Qui vero est est tempora error asperiores. Natus m', 99);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (66, 75, 'In autem ex beatae velit dicta sunt quaerat. Non s', 34);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (67, 19, 'Quia molestiae sint iusto sequi. Natus quia saepe ', 5);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (68, 34, 'Sint ut temporibus consequatur ipsa aperiam tempor', 77);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (69, 58, 'Aut sint voluptatem ut et. Eius cumque maxime haru', 17);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (70, 2, 'Cupiditate explicabo et ut assumenda aliquid magna', 90);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (71, 5, 'Rem libero ex sed fugit. Quos est aut eveniet faci', 69);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (72, 14, 'Autem in consectetur veritatis et blanditiis. Eius', 100);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (73, 25, 'Qui eaque ut quis ut. Dolores tempore repellat est', 60);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (74, 77, 'Doloremque magnam dicta temporibus voluptatum cupi', 97);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (75, 87, 'Incidunt alias dolorem ea animi animi temporibus. ', 26);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (76, 30, 'Et ipsum vitae repellendus qui quis itaque. Laudan', 97);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (77, 11, 'Quae vel sed est eaque et quae. Dolor nulla ipsam ', 36);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (78, 39, 'Adipisci quia voluptates officia accusamus iusto m', 23);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (79, 52, 'Voluptate vel soluta accusamus excepturi voluptate', 91);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (80, 33, 'Aut libero sed deleniti. Aut vitae cupiditate hic ', 20);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (81, 65, 'Illo libero aut sint nostrum eaque atque. Accusant', 18);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (82, 65, 'Mollitia incidunt quis amet qui. Optio quos corrup', 94);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (83, 95, 'Sint molestiae dignissimos itaque rerum quisquam. ', 19);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (84, 74, 'Laudantium corrupti illum est nemo dolorem. Sequi ', 83);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (85, 84, 'Eos voluptate officia repudiandae. Hic minus eos o', 11);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (86, 33, 'Officiis recusandae atque tenetur minima et. Adipi', 95);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (87, 1, 'Dolores non et beatae quia delectus. Rerum quisqua', 14);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (88, 85, 'Mollitia sapiente asperiores voluptates itaque vol', 39);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (89, 5, 'Repellat aut in distinctio. Sed rerum aspernatur f', 24);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (90, 65, 'Dolorum vel qui et aut cum voluptatem illum. Aperi', 42);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (91, 49, 'Voluptatum ipsam fugit optio illum et excepturi. M', 59);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (92, 10, 'Aperiam quod nulla iusto dolorem quis sint. Eius r', 51);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (93, 11, 'Tempore laboriosam temporibus laboriosam. Ea cum m', 61);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (94, 63, 'Odit illo voluptas alias doloribus asperiores quis', 27);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (95, 41, 'Quod ut et et architecto. Ut eveniet minima ipsa e', 49);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (96, 69, 'Et quia molestiae voluptatem ut. Et ea voluptates ', 44);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (97, 43, 'Voluptas porro sit molestiae quas nulla voluptas d', 11);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (98, 82, 'Reprehenderit et reiciendis quisquam deserunt. Ten', 46);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (99, 1, 'Perferendis eos ut qui molestias. Quis sit in quid', 46);
INSERT INTO `DiscountOffers` (`DiscountID`, `userLID`, `Discount_Detail`, `Discount_Percentage`) VALUES (100, 72, 'Et sed et deserunt minima hic. Qui autem amet minu', 7);


#
# TABLE STRUCTURE FOR: Driver
#

DROP TABLE IF EXISTS `Driver`;

CREATE TABLE `Driver` (
  `Driver_ID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `E_mail` varchar(100) NOT NULL,
  `DriverPassword` varchar(50) NOT NULL,
  `Driver_rating` int(11) NOT NULL,
  `Dr_Status` enum('active','inactive') NOT NULL,
  `DOB` date NOT NULL,
  PRIMARY KEY (`Driver_ID`),
  UNIQUE KEY `E_mail` (`E_mail`),
  KEY `driver_id` (`Driver_ID`),
  KEY `email_index` (`E_mail`),
  KEY `dr_status_index` (`Dr_Status`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`DOB` <= '2005-01-01'),
  CONSTRAINT `CONSTRAINT_2` CHECK (`Driver_rating` >= '1' and `Driver_rating` <= '5')
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (1, 'Dakota', 'Fabiola', 'Moore', 'bsimonis@example.com', '27d9d26785a9557baa7eb23b4f50824fbfb88791', 1, 'active', '1989-05-02');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (2, 'Lukas', 'Melba', 'Jacobson', 'hammes.baby@example.net', '32a9a4589a04c8e62c6c694be971f3d6b1eea99e', 5, 'inactive', '1994-11-29');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (3, 'Joany', '', 'Wiegand', 'jast.emma@example.net', '989ee13c8ac15e009eb0c6606888e26fa950514e', 4, 'inactive', '2000-03-18');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (4, 'Isabel', 'Coleman', 'Moore', 'hhintz@example.net', '93d64bfb465f5fc921367bf1c7ccd93d5ec92c92', 4, 'inactive', '1995-07-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (5, 'Kathryne', '', 'Lesch', 'dejah98@example.net', '59ab7665fd40c94735cc59764a70be28131e0ff8', 2, 'active', '1983-09-18');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (6, 'Eulah', 'Earnestine', 'Willms', 'kadin.shields@example.com', '6a6696acbf4d8a58241f00bf0215ed900fe62caa', 4, 'active', '1991-05-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (7, 'Gudrun', 'Oswald', 'Runte', 'everett18@example.com', '0f99cb0642a0d5f52264dc55662d89a144228c3a', 4, 'active', '1990-11-27');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (8, 'Alda', 'Davin', 'Eichmann', 'kuhic.fritz@example.com', '268bd6d69817d99153d592f3d380164e3de32eb2', 5, 'inactive', '1995-04-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (9, 'Warren', 'Graciela', 'Durgan', 'pearline.sanford@example.org', '1cc38921d67def37733c2f05f6ba68d6c60d815c', 5, 'active', '1971-10-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (10, 'Sarah', 'Dusty', 'Lehner', 'ankunding.dillon@example.com', '5d7abdf026f94d7531b5aba4dbf9a938832a2ef9', 1, 'inactive', '1998-09-29');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (11, 'Flavio', '', 'Goyette', 'waino.hansen@example.com', '27cb68d0e376ebde7c74c6d4425cd07515908638', 4, 'inactive', '1997-06-14');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (12, 'Eino', '', 'Cummings', 'santa77@example.org', '0ffbfb7c47c428599f9aeb92bd698852700f5a01', 3, 'inactive', '1971-09-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (13, 'Daryl', 'Rick', 'Rogahn', 'daniella52@example.com', '410d46d97e4ad8c0d4308d1ab7cf5b35d84052c8', 1, 'active', '1988-12-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (14, 'Garland', '', 'Schoen', 'htreutel@example.org', 'edea49be38742d4789dc332f0ec4c95e4b8ae7c3', 1, 'inactive', '1976-12-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (15, 'Christopher', '', 'Smitham', 'corkery.ora@example.com', 'fda77ec466f588d6781d152c9836247507d511cc', 3, 'active', '1989-05-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (16, 'Mazie', '', 'Cole', 'joana31@example.net', 'd3014f080d5c31ad5b93b386faa2ffdc448f9db2', 2, 'inactive', '1997-10-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (17, 'Marlee', '', 'Kerluke', 'darwin.runolfsdottir@example.com', '7fd4088d8ce7ac2894a0eb3f5c4d00210bf26654', 2, 'active', '1980-08-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (18, 'Yvette', '', 'Armstrong', 'cprice@example.com', '26ae0cd22d1ae0c091b0f2189d3a0d1c13ad03a3', 4, 'inactive', '1993-10-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (19, 'Jevon', 'Pedro', 'Welch', 'pbradtke@example.com', 'd0dfb242332e6260f09963a1007432f90381b416', 2, 'inactive', '1984-01-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (20, 'Laney', '', 'Dickens', 'lexi17@example.net', 'f10fd10f59f000f78c12fae10bd33d8c9310f45b', 3, 'inactive', '2001-06-30');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (21, 'Arlie', '', 'Pouros', 'tnitzsche@example.com', '948cbc635be951b052408c52949cce2b07a404fc', 4, 'inactive', '1984-06-23');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (22, 'Berniece', 'Francesco', 'Lemke', 'o\'conner.crawford@example.org', 'e01892c62aaffcc2f6c5dbbad264fbee7be8c750', 2, 'active', '1976-12-03');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (23, 'Dave', 'Misty', 'Lesch', 'orn.estel@example.net', '3b61d5e3a9cbc2b1c1c5887a8d4a3b08f59ce1d2', 2, 'active', '1991-09-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (24, 'Garret', '', 'Ruecker', 'briana.pacocha@example.com', '93be152ae6fc4452f3b4f77655cb1484c3a1ceb3', 4, 'active', '1986-04-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (25, 'Sally', 'Bernadette', 'Schinner', 'xharris@example.com', 'fab9db3c5d97325d674fe50f88a5f2825d93c113', 2, 'inactive', '1980-01-07');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (26, 'Aaron', '', 'Schoen', 'ibrahim.ortiz@example.org', 'b2669d3261ece132d9c17126de5f7b11a76d0dc5', 5, 'active', '1979-06-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (27, 'Brandt', 'Monserrat', 'McLaughlin', 'mcglynn.maudie@example.net', '7bb18c8d1d7019c6d6c0724ce981ef449bc1082d', 3, 'inactive', '1979-03-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (28, 'Elise', '', 'Gusikowski', 'kayla.schmitt@example.net', '98c61e3d6dffa5965727c7d289beb47aba5231e4', 2, 'inactive', '1985-06-08');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (29, 'Jarred', 'Chester', 'Hand', 'doyle.adriana@example.com', 'f6fbd94fd766e8c6839d508cb08bb90437ae1142', 1, 'active', '1995-02-17');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (30, 'Alexys', 'Nathan', 'Ledner', 'mills.berneice@example.net', '30ff49400281fc79abd03487115d1d03cd455cf4', 4, 'inactive', '1975-03-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (31, 'Hardy', 'Bertram', 'Moore', 'golden.blick@example.com', '14602c26e7aaa7213e65925525aee16eed18dd65', 2, 'inactive', '2004-10-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (32, 'Colt', 'Evalyn', 'Fay', 'mterry@example.org', '1de87a1a7be2609d543b5ac3e5a40bf053559357', 5, 'inactive', '1997-08-07');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (33, 'Donnie', '', 'Hilpert', 'mboyle@example.net', '52047330c60d90511f2c0c62ddd554b1a79ab7f3', 2, 'active', '2001-09-10');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (34, 'Libbie', 'Bradley', 'McClure', 'crobel@example.com', '2be476d0b79f77b7cedf5d1a0eaea5fedbecbf55', 2, 'active', '1982-04-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (35, 'Nolan', 'Gage', 'Orn', 'lorenza.erdman@example.org', '30074c2ca31355d7ccc6c3b8a4af16b832c13584', 3, 'active', '1989-02-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (36, 'Jazlyn', '', 'Hauck', 'tschulist@example.org', '61585536986141a0b4f2c2e6965c27ec3147f71d', 5, 'active', '1997-09-14');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (37, 'Brock', '', 'Schinner', 'adubuque@example.net', '5891e6acdc867931c491fe1167225cc782ad828c', 5, 'inactive', '1989-06-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (38, 'Corene', 'Tamara', 'Feeney', 'gbarton@example.org', '0f080f122ac501a7e2d4c82d023a6aba178a2eba', 5, 'active', '1987-10-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (39, 'Mabel', '', 'Hackett', 'treutel.arvid@example.com', '2b8b372613b97aebfa26c0538932cbfd386ee9d9', 2, 'inactive', '1973-07-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (40, 'Ephraim', '', 'Daniel', 'mateo11@example.org', '5edf8f5cc64858bd96e669e58e81d67f509f4d67', 2, 'inactive', '1999-02-02');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (41, 'Alaina', 'Lois', 'Hudson', 'walsh.joany@example.net', 'f526b09a9e6b252298a36430c11c8d90029c2725', 1, 'inactive', '1995-07-02');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (42, 'Sister', 'Isabell', 'Kuvalis', 'donny.wintheiser@example.org', 'ecc96df5624eb22b6ca2030dc6865bc09f4429fc', 3, 'inactive', '1998-10-17');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (43, 'Marjorie', '', 'Spencer', 'abbott.sophia@example.com', '7e9e343ed9b9f1bc1a13ff1e6dc4e2d70146dafe', 5, 'inactive', '1978-04-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (44, 'Antonietta', 'Kyler', 'Brown', 'leilani13@example.org', '8caa447064c4ca8178c44b2fb3448f02fb3c7bc9', 4, 'active', '1991-03-11');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (45, 'Stephania', '', 'Quigley', 'josiah.grant@example.net', '3ca0b8a68651527fa1974cb03b4b92ba43d1d72d', 3, 'active', '1983-05-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (46, 'Carleton', '', 'Heller', 'stamm.merlin@example.com', '7fa8fe3d243f783dd463a0f9a154cf03c1a517c9', 3, 'inactive', '1992-09-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (47, 'Josefa', 'Neil', 'Batz', 'znicolas@example.org', 'bf34d254a41c163f24dafcc46902b4f138413a70', 4, 'active', '2002-07-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (48, 'Ayden', '', 'Stehr', 'ohermann@example.com', '0b2b77907773ce1b88c197e3d0127255a8cabbf5', 5, 'inactive', '1992-07-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (49, 'Betsy', 'Amiya', 'Collins', 'wolf.jayme@example.org', '58c1e91664bb0d33a2340253ed41fc82989cb8d9', 2, 'active', '1989-05-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (50, 'Rosalia', '', 'Ernser', 'price.schiller@example.net', 'eb0b14e6fca135a7efd7ba128adfd21f673b05b9', 3, 'inactive', '2004-02-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (51, 'Deondre', '', 'Haley', 'vleuschke@example.org', '5b6e58307ed6cfc42330b25f57045f067a517220', 1, 'active', '1991-10-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (52, 'Liliana', '', 'Boyer', 'katheryn62@example.org', 'c928b0c026709d68a3774ac8c5f6522c7de59863', 4, 'active', '2003-09-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (53, 'Zackary', 'Jovanny', 'Lesch', 'lubowitz.maribel@example.org', '87d60a573aa0b0593bd90ecdb979872dffa91822', 4, 'active', '1993-09-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (54, 'Logan', 'Nina', 'Lynch', 'maxime80@example.com', 'd6fb711b26524bbeb340b3a298e8469151f040c0', 4, 'active', '1990-02-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (55, 'Hunter', 'Malvina', 'O\'Kon', 'gleichner.tyrese@example.com', '480e0744342c739e97d147fa717db70c13dbd593', 4, 'active', '1996-10-29');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (56, 'Troy', 'Evans', 'Rau', 'chyna34@example.org', '65f25833572ba677d1a6fb9e5644c415d768cc7d', 2, 'active', '1976-12-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (57, 'Kirstin', 'Dena', 'Gorczany', 'jbarton@example.net', '24de740514b6fbf62408a4b6c81414bade6cce89', 4, 'active', '1978-04-08');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (58, 'Bradley', 'Kamren', 'Stokes', 'forest47@example.com', '2604287f18363ae5ae382fc679e3a90beb882cf5', 1, 'active', '1973-05-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (59, 'Catalina', 'Demarcus', 'Oberbrunner', 'akunde@example.net', '30793843d2730423208ee299d71942494f1dd51c', 2, 'active', '2001-01-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (60, 'Sadye', '', 'Murphy', 'tremblay.derek@example.com', 'f760ed9bc1b570c824cb2aceb5b119369bedc38a', 5, 'active', '1997-09-27');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (61, 'Izabella', '', 'Lehner', 'gail39@example.net', 'b386ea654f5b3b15b49f2661a0f16348b16e8dc7', 3, 'inactive', '1976-02-18');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (62, 'Jensen', 'Jamal', 'Donnelly', 'vbraun@example.com', 'b5ac9b2d181baf98890c0ed411e774bc4c890f45', 3, 'active', '1976-11-27');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (63, 'Alessandra', 'Lynn', 'Bayer', 'jmckenzie@example.net', '7df92e3c93fa94c7ae29b231d3f3e08b89100077', 1, 'active', '1977-07-11');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (64, 'Tevin', '', 'Wehner', 'ydietrich@example.com', '8840a7689ab2a8a41e2774c91d7cbf6a054d5b6a', 5, 'active', '1995-07-23');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (65, 'Alessandro', '', 'Bosco', 'jayden.graham@example.net', '4da41fce11fb324818ceddf6c3e1352d40b03001', 1, 'inactive', '1985-06-01');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (66, 'Annamarie', 'Asa', 'Bergnaum', 'lspencer@example.net', 'a06a7279f267f900d6e9cb61d9c9b1385490eb9d', 5, 'active', '1984-05-26');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (67, 'Ernestina', '', 'Rempel', 'lang.elena@example.com', 'c1cfadc67a8fb75832484ed0eeebe2195a8c9b87', 1, 'active', '1994-12-22');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (68, 'Kyleigh', 'Arnaldo', 'Reinger', 'fwolf@example.org', 'b78a4c53d39ef1edbf9f2a1b868a514b8ac3d7fe', 2, 'inactive', '1972-05-11');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (69, 'Rowena', '', 'Emmerich', 'mraz.otilia@example.net', '2a60a638ea80f3d0c6ba6abe42b5b5fc51e1da33', 2, 'inactive', '1971-03-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (70, 'Mariana', '', 'Lemke', 'streich.alivia@example.net', '432f077df7cf3eae9e6ab448d3f28de1dfaff729', 4, 'active', '1997-10-23');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (71, 'Layla', 'Dayton', 'Legros', 'melyna11@example.net', 'bd9d46d9a8e734653c51d2e81d5c720a4db38721', 3, 'active', '1985-04-03');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (72, 'Alexa', 'Mike', 'Hamill', 'denesik.hattie@example.net', 'f4a89b8d9a85b232bf4e30e80e646d92a6a07eaf', 1, 'active', '1985-01-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (73, 'Jaylin', '', 'Sipes', 'mckenzie.heidi@example.net', '233d963f2a7f2d9d0f2cd3e80e992fa8f0f37f7a', 1, 'inactive', '2001-06-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (74, 'Margot', 'Esmeralda', 'Bernhard', 'npfeffer@example.com', 'e9c7265e678e86a80afbd0d3c1ba3a13671a48ba', 1, 'active', '1973-02-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (75, 'Nikki', 'Nathaniel', 'Boyer', 'dnienow@example.org', '274d1bd93a3624f9b9e6d1f0dd971ce9e9122b6a', 5, 'active', '2003-04-22');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (76, 'Cleora', '', 'Cruickshank', 'monahan.nick@example.net', '9824c931956a8b4c5d24b72a7bcc0f242719f992', 3, 'active', '1988-07-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (77, 'Abbey', '', 'Sanford', 'elangosh@example.org', 'f93be29f60d5fdd9051c74bd5a31194f02bc5541', 4, 'active', '1988-10-30');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (78, 'Audreanne', '', 'Stamm', 'dickens.myrtis@example.org', '5dccef5da26fcf8a99e709bd0909fd71137e8210', 4, 'active', '1972-11-03');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (79, 'Lucienne', 'Ena', 'Mraz', 'xgrimes@example.org', '6bc52c472ca6f4f3033144912358c228b21cc23a', 3, 'inactive', '1972-03-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (80, 'Magnus', 'Ariane', 'Von', 'connor.reinger@example.com', '6efa194fdfc8aa34414821dedb4a53b4c0e56a4b', 2, 'active', '2001-03-14');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (81, 'Olga', 'Mikayla', 'Feil', 'krosenbaum@example.com', '29bc79a50131c07789ee8987e04db6638b08740a', 4, 'inactive', '2003-03-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (82, 'Morgan', '', 'Mayert', 'annamarie58@example.com', '440edcd8e7748ad4479377c95f846cbdd044f33d', 2, 'active', '1971-08-04');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (83, 'Marcella', 'Elwin', 'Lind', 'teresa.jerde@example.net', 'c722eb629f968406b036725897c76c13fbd3a66e', 4, 'active', '1993-08-20');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (84, 'Thaddeus', '', 'Abshire', 'theller@example.com', '7bef2af9d93cffc5bf331238d80f5db1050230e9', 5, 'inactive', '1981-01-21');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (85, 'Santos', 'Heather', 'Dare', 'kharvey@example.com', 'b0fdc76d8514517c8ad7494b6580b3291a111cd1', 4, 'active', '1999-11-18');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (86, 'Salma', 'Jodie', 'Tremblay', 'isac.herzog@example.org', '95c300297f52d628aa03b4b1cc787c5098db280e', 5, 'inactive', '1985-03-24');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (87, 'Jaquelin', 'Amber', 'Ratke', 'zulauf.eloise@example.org', '33e0b0331fc431a20b7223fd1202f04f192ed5f0', 2, 'active', '1986-05-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (88, 'Dena', '', 'Hackett', 'elsa.vandervort@example.net', '12f575b069ee449a30b45db6fc6c36802b275995', 4, 'inactive', '1990-02-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (89, 'Buck', '', 'Fahey', 'ezekiel.feeney@example.org', '2b474d8931e5da024673d51eef664034f1e7de9c', 3, 'active', '1988-12-19');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (90, 'German', 'Marie', 'Mitchell', 'md\'amore@example.com', '0ec0e274ffd9805df1b55079688cb4ea3044fb41', 3, 'inactive', '1992-01-10');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (91, 'Rosemarie', 'Delta', 'Romaguera', 'mbruen@example.org', 'ac40e58c090f4e15fbd97a0ae5cdbaa996bcee31', 1, 'active', '1982-06-15');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (92, 'Morris', '', 'Marquardt', 'ebert.sarai@example.net', '19d975e91518227dfd898f948effc2086abaae21', 2, 'active', '1989-04-03');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (93, 'Freeman', 'Bernhard', 'Wunsch', 'reynolds.braeden@example.net', 'a68dc85f2a3f187e9ae17212c0575c5b6e4a124d', 5, 'active', '1988-05-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (94, 'Breanne', 'Karley', 'Bartoletti', 'dallin.botsford@example.com', 'de730b3baad719b32bbf4ee15f220b41c83ea43f', 4, 'inactive', '1978-06-29');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (95, 'Johanna', '', 'Hayes', 'pink.reynolds@example.com', '8716362b4aef497905c389089a95e17f61aed7c9', 2, 'inactive', '1985-08-17');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (96, 'Ardith', 'Otho', 'Herzog', 'deven92@example.org', '24f570238f7a9641f14204d5dc10d3b1faec1b36', 2, 'inactive', '1990-05-14');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (97, 'Merlin', '', 'Robel', 'london.koch@example.net', 'e8194c4700c6ab654715efea6af90f99beda1856', 3, 'active', '1990-12-20');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (98, 'Trenton', 'Abagail', 'Dietrich', 'mcdermott.alexa@example.org', '3bf79471a8ee5e4be9fbc3df6c9adaf78e2ff1c6', 3, 'inactive', '1975-12-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (99, 'Jermain', '', 'Corkery', 'barrows.meda@example.net', 'f1e84dd513447a9ab9c40621aea4734ba8ab86f6', 4, 'inactive', '1976-10-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (100, 'Winifred', '', 'Heidenreich', 'janice56@example.org', '7e1a5e86dfb0d5cb6fa4f9f486a10ef88a26343d', 5, 'inactive', '1978-01-25');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (101, 'Libbie', 'Thad', 'O\'Hara', 'norbert01@example.net', '645b7a1f90b67689a399c8e33d462bc24ad812bb', 5, 'active', '1977-05-19');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (102, 'Ruby', '', 'Beahan', 'jacinto41@example.com', '5f0c352d9049a10ddb73fff57f3243d285c1d37f', 1, 'inactive', '2003-03-31');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (103, 'Brooks', 'Andreane', 'Langosh', 'emerson.gottlieb@example.com', '7581a0aa2f089323a2c474e52d0ecc0b36114919', 2, 'inactive', '1979-12-27');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (104, 'Celestino', '', 'Klein', 'ibarrows@example.net', '1a70ab66b09983266cbe50d04756bed43ea36615', 2, 'inactive', '1976-09-06');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (105, 'Levi', '', 'Tromp', 'cody.jacobs@example.org', 'dcc49f3996034b0bce691764de10c2f297aa67c9', 1, 'active', '1971-11-30');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (106, 'Kelley', 'Garrett', 'Erdman', 'marjory91@example.net', '5b1768b29cf6362aa5545421a93510832db57aaa', 2, 'active', '1973-03-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (107, 'Keven', 'Eveline', 'Durgan', 'kendra32@example.net', '33ae12d1aefc0d3b7675d7ab75308abc112fcc05', 1, 'active', '1994-05-12');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (108, 'Jovani', 'Orrin', 'Bayer', 'icarroll@example.net', 'fe1d2e5fe1951398686813dd9dc2a7d65dbbadee', 3, 'inactive', '1984-02-26');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (109, 'Anderson', '', 'Towne', 'mylene.welch@example.org', '26c21945334617a69c6f0c8e9da2ec4e0944e915', 1, 'active', '1973-11-24');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (110, 'Kaitlyn', 'Adella', 'Murazik', 'jaunita.krajcik@example.com', 'bf84279add9f7d8d7a81768eeca4234353e1008c', 5, 'active', '1985-05-24');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (111, 'Claire', 'Ressie', 'Bechtelar', 'kelli.mccullough@example.org', '25ff63a6fbe532e41e4689e89d9cbca5e212a681', 5, 'active', '1981-02-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (112, 'Johanna', 'Fatima', 'Murray', 'cynthia.robel@example.org', 'c40e1964eba627243a314b80fc829bae4730cd2e', 4, 'active', '2004-03-16');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (113, 'Columbus', '', 'Corkery', 'frieda60@example.net', '1f1b08920df76df5c298e988ce4b7257ac5dd9b8', 5, 'inactive', '1996-08-13');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (114, 'Sally', '', 'Hilll', 'adibbert@example.net', '0941ce3f92b41731e437245adca1f435e696304b', 2, 'active', '1999-07-06');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (115, 'Rodrigo', 'Jude', 'Volkman', 'ypollich@example.com', 'a69986385a8d022e30f24865ba6a12534beb0be9', 1, 'active', '1982-10-06');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (116, 'Nadia', 'Ezra', 'Hilll', 'cwintheiser@example.net', '924f9c855792d5419a63b1482a3fbc6803c552e9', 2, 'inactive', '1995-01-28');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (117, 'Milan', 'Rigoberto', 'Gislason', 'roxane.hegmann@example.com', '20cdd211dcb47b52adaf7bee1168c6141fca6741', 2, 'active', '1980-02-17');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (118, 'Delbert', 'Kassandra', 'Hettinger', 'jalyn.conn@example.net', 'a85763b83e4c673ae2b4cc6951ddfed9ab84da1c', 4, 'inactive', '1985-08-04');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (119, 'Willis', '', 'Mayert', 'koby93@example.com', 'e025d7e7a0c07e10f8d3aa61355152222b58421b', 2, 'active', '1984-10-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (120, 'Lew', 'Edwin', 'Lueilwitz', 'arthur.donnelly@example.org', 'c5f868dddbd6d99d3331259b3d461394d1408c3f', 5, 'inactive', '1991-02-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (121, 'Kaycee', '', 'Wisozk', 'heidenreich.vallie@example.org', 'f2967ca82a8c237176f2e8ff775bd25b084064b6', 5, 'inactive', '2003-07-23');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (122, 'Nakia', '', 'Kozey', 'granville82@example.com', 'e2bf87bc5b3f990e5921a3384bf7ce702a560dd4', 2, 'active', '1990-08-31');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (123, 'Donnie', '', 'Stanton', 'verlie.marvin@example.com', '96557e16684d4df33cf2ff1613729157c1701a8b', 3, 'inactive', '1997-08-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (124, 'Estefania', 'Sherwood', 'Denesik', 'will.rod@example.net', 'a8106ed74cfeb07e614a81bf13fb4f8a6f102b03', 4, 'inactive', '1995-12-06');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (125, 'Duncan', 'Krystel', 'Schneider', 'sabryna07@example.net', '92dbc6016598b9188073f41736aef38070e2463c', 2, 'inactive', '1992-08-09');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (126, 'Tom', 'Antonia', 'Wolf', 'carlie.grimes@example.org', '618c25d0ecf621c7a8ada02abf828d1d83c72c3d', 5, 'active', '1999-01-23');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (127, 'Emery', '', 'Kirlin', 'murazik.rogers@example.org', '1722ff223b5d750300f1b1a1bbbe814be5b0bf8c', 5, 'active', '2004-09-11');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (128, 'Judge', '', 'Herzog', 'ocie.rogahn@example.net', '7a7bfdf15a28241b0b16494ea9ff9e4d6ed3d8fa', 5, 'active', '2004-07-05');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (129, 'Carroll', '', 'Friesen', 'lulu.harvey@example.org', 'bb515f44ca55f187864507dc2d15713f75f3b9c7', 4, 'active', '1985-01-10');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (130, 'Hosea', 'Zola', 'Ledner', 'pmccullough@example.net', '898d04bf488c9e40ae1acd9c3e2d3785602bce76', 4, 'active', '1982-09-18');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (131, 'Halie', 'Lina', 'Ward', 'mmcglynn@example.net', 'e58eb40a7a0c92e1ef44ed3cc41d98cf3da6e7a2', 1, 'inactive', '2003-01-27');
INSERT INTO `Driver` (`Driver_ID`, `fname`, `mname`, `lname`, `E_mail`, `DriverPassword`, `Driver_rating`, `Dr_Status`, `DOB`) VALUES (132, 'Ada', '', 'Batz', 'tressa.klocko@example.com', '525156f190cf2201ccf3ac8b7fcc1c8acfd518d1', 4, 'active', '1988-03-18');

#
# TABLE STRUCTURE FOR: DrivesFor
#

DROP TABLE IF EXISTS `DrivesFor`;

CREATE TABLE `DrivesFor` (
  `DrivID` int(11) NOT NULL,
  `UsrID` int(11) NOT NULL,
  `Tim` datetime DEFAULT NULL,
  `Distance` float NOT NULL,
  PRIMARY KEY (`DrivID`,`UsrID`),
  KEY `driv_id_index` (`DrivID`),
  KEY `usr_id_index` (`UsrID`),
  CONSTRAINT `DrivesFor_ibfk_1` FOREIGN KEY (`DrivID`) REFERENCES `Driver` (`Driver_ID`),
  CONSTRAINT `DrivesFor_ibfk_2` FOREIGN KEY (`UsrID`) REFERENCES `Users` (`User_ID`),
  CONSTRAINT `CONSTRAINT_3` CHECK (`Distance` >= 0 and `Distance` <= 1000),
  UNIQUE KEY `Tim` (`Tim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (1, 24, '2022-11-21 13:47:00', '6');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (4, 61, '2022-06-10 01:54:00', '436');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (5, 7, '2022-04-11 11:34:00', '5');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (6, 38, '2023-11-08 08:34:00', '509');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (7, 18, '2022-11-17 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (7, 40, '2022-05-27 11:27:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (7, 79, '2022-08-11 02:17:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (7, 80, '2022-11-08 05:37:00', '66');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (9, 19, '2022-11-02 21:14:00', '8');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (12, 86, '2022-11-22 01:28:00', '182');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (13, 42, '2023-11-22 01:14:00', '9');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (14, 86, '2023-01-22 01:36:00', '4');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (14, 95, '2023-11-23 01:47:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (15, 98, '2023-11-22 21:48:00', '2');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (16, 13, '2022-02-22 01:50:00', '3');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (16, 21, '2022-01-21 01:50:00', '15');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (17, 33, '2023-09-02 21:14:00', '356');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (18, 21, '2023-11-12 21:18:00', '530');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (19, 42, '2022-10-04 21:14:00', '114');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (19, 60, '2021-01-02 21:16:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (22, 25, '2023-12-02 21:18:00', '260');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (23, 83, '2022-11-02 21:21:00', '371');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (27, 29, '2021-12-02 21:20:00', '4');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (29, 26, '2021-11-02 21:14:00', '7');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (29, 37, '2023-03-02 21:14:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (30, 62, '2022-02-02 21:14:00', '48');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (31, 77, '2022-03-02 21:14:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (36, 28, '2021-08-02 21:14:00', '105');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (37, 89, '2023-07-02 21:14:00', '97');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (39, 6, '2024-01-02 21:14:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (40, 69, '2022-09-04 21:14:00', '773');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (41, 8, '2023-11-17 21:43:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (47, 20, '2020-01-01 21:14:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (49, 87, '2022-11-09 21:20:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (50, 19, '2023-01-08 11:14:00', '42');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (50, 97, '2022-07-02 21:14:00', '969');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (52, 16, '2023-05-19 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (53, 61, '2023-11-20 02:38:00', '67');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (53, 71, '2021-11-17 02:34:00', '7');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (53, 95, '2023-06-20 02:40:00', '799');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (56, 33, '2022-09-17 02:38:00', '67');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (62, 76, '2023-08-18 02:34:00', '746');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (62, 79, '2023-03-17 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (63, 14, '2023-01-17 02:34:00', '433');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (63, 52, '2022-12-04 02:34:00', '133');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (64, 99, '2023-03-03 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (66, 37, '2023-11-17 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (68, 44, '2023-11-17 22:34:00', '322');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (69, 11, '2023-03-16 02:34:00', '92');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (69, 96, '2023-09-17 02:35:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (70, 22, '2022-11-17 05:34:00', '9');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (72, 7, '2023-11-17 02:14:00', '71');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (74, 34, '2022-08-23 02:34:00', '95');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (75, 18, '2023-06-17 02:04:00', '919');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (76, 23, '2023-11-03 02:34:00', '871');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (76, 70, '2020-11-17 02:34:00', '8');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (77, 43, '2022-11-17 03:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (78, 85, '2023-02-15 02:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (79, 96, '2022-11-17 09:34:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (80, 88, '2021-07-01 02:34:00', '28');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (81, 21, '2021-12-13 02:34:00', '1');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (81, 49, '2023-01-01 01:34:00', '3');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (82, 81, '2022-11-17 02:40:00', '1');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (83, 94, '2020-11-17 02:14:00', '824');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (87, 62, '2023-10-03 03:34:00', '9');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (88, 65, '2023-12-13 13:13:13', '39');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (89, 58, '2023-11-17 02:36:00', '11');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (90, 86, '2021-10-17 02:13:13', '65');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (91, 27, '2022-11-17 13:34:13', '49');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (92, 71, '2023-10-03 12:34:00', '41');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (93, 1, '2023-12-12 12:34:12', '40');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (93, 100, '2023-02-18 02:12:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (95, 52, '2023-02-19 02:12:00', '9');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (95, 94, '2023-02-18 02:12:30', '88');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (96, 15, '2022-02-18 02:12:00', '6');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (96, 82, '2022-08-18 02:12:00', '488');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (97, 69, '2023-02-20 00:12:00', '904');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (98, 3, '2023-10-18 02:12:00', '468');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (98, 36, '2023-02-10 02:10:00', '312');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (98, 55, '2022-02-18 02:02:02', '72');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (99, 71, '2020-02-08 02:08:00', '330');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (99, 80, '2023-02-18 02:19:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (1, 35, '2022-04-18 02:12:00', '42');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (2, 61, '2022-02-11 11:12:00', '503');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (3, 96, '2022-02-11 09:12:00', '7');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (8, 74, '2022-02-11 12:12:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (9, 28, '2021-02-11 11:12:00', '8');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (10, 90, '2022-02-11 11:11:11', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (11, 53, '2023-02-11 11:12:00', '33');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (11, 72, '2023-12-12 12:12:00', '31');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (12, 66, '2023-12-12 13:12:13', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (13, 17, '2023-08-10 11:12:08', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (13, 77, '2021-01-10 11:12:12', '635');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (13, 79, '2022-09-09 11:12:00', '6');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (14, 64, '2021-05-10 11:12:10', '692');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (15, 97, '2021-12-12 11:12:12', '485');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (16, 15, '2023-02-18 00:12:02', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (19, 20, '2023-12-11 01:12:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (19, 63, '2023-07-08 08:12:08', '21');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (20, 56, '2023-02-11 14:12:00', '5');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (21, 60, '2022-03-12 11:12:00', '17');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (21, 61, '2023-09-09 11:12:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (22, 34, '2022-01-01 01:12:10', '3');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (25, 7, '2023-09-09 09:12:09', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (26, 87, '2023-08-11 11:12:00','766');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (29, 25, '2022-02-11 18:12:00', '116');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (29, 98, '2022-02-11 11:12:24', '346');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (31, 7, '2023-03-12 11:12:00', '5');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (32, 64, '2022-02-11 11:12:21', '985');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (32, 66, '2022-02-12 21:12:00', '0');
INSERT INTO `DrivesFor` (`DrivID`, `UsrID`, `Tim`, `Distance`) VALUES (32, 82, '2023-01-01 01:01:01', '638');


#
#TABLE STRUCTURE FOR: Payment
#

DROP TABLE IF EXISTS `Payment`;

CREATE TABLE `Payment` (
  `PaymentID` int(11) NOT NULL AUTO_INCREMENT,
  `BookieID` int(11) DEFAULT NULL,
  `Payment_Amount` int(11) NOT NULL,
  `Payment_Method` enum('Cash','Credit Card','Debit Card','Wallet/UPI') NOT NULL,
  `Payment_Status` enum('Paid','Pending') NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `idx_BookieID` (`BookieID`),
  CONSTRAINT `Payment_ibfk_1` FOREIGN KEY (`BookieID`) REFERENCES `Bookings` (`Booking_ID`),
  CONSTRAINT `CONSTRAINT_4` CHECK (`Payment_Method` in ('Cash','Credit Card','Debit Card','Wallet/UPI')),
  CONSTRAINT `CONSTRAINT_5` CHECK (`Payment_Status` in ('Paid','Pending'))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (1, 1, 52, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (2, 2, 4288, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (3, 3, 4073, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (4, 4, 6601, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (5, 5, 968, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (6, 6, 8283, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (7, 7, 3341, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (8, 8, 3100, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (9, 9, 1992, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (10, 10, 2655, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (11, 11, 4879, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (12, 12, 3313, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (13, 13, 620, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (14, 14, 7288, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (15, 15, 3696, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (16, 16, 3584, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (17, 17, 9958, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (18, 18, 9977, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (19, 19, 5879, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (20, 20, 7998, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (21, 21, 2567, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (22, 22, 5038, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (23, 23, 9113, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (24, 24, 4081, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (25, 25, 1844, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (26, 26, 5072, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (27, 27, 2612, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (28, 28, 6833, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (29, 29, 6671, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (30, 30, 6312, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (31, 31, 4470, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (32, 32, 4594, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (33, 33, 7830, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (34, 34, 4366, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (35, 35, 984, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (36, 36, 4521, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (37, 37, 7619, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (38, 38, 1493, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (39, 39, 1280, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (40, 40, 1113, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (41, 41, 6145, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (42, 42, 911, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (43, 43, 9510, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (44, 44, 8856, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (45, 45, 5910, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (46, 46, 7935, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (47, 47, 5164, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (48, 48, 21, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (49, 49, 8716, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (50, 50, 883, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (51, 51, 7954, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (52, 52, 5850, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (53, 53, 6720, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (54, 54, 7819, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (55, 55, 8399, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (56, 56, 7281, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (57, 57, 9686, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (58, 58, 6612, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (59, 59, 8896, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (60, 60, 491, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (61, 61, 4944, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (62, 62, 3716, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (63, 63, 6681, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (64, 64, 5515, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (65, 65, 3423, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (66, 66, 7483, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (67, 67, 91, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (68, 68, 6906, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (69, 69, 3370, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (70, 70, 7643, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (71, 71, 2855, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (72, 72, 6785, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (73, 73, 8334, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (74, 74, 8878, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (75, 75, 6065, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (76, 76, 7243, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (77, 77, 8821, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (78, 78, 1272, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (79, 79, 3522, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (80, 80, 1301, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (81, 81, 4161, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (82, 82, 8386, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (83, 83, 7154, 'Credit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (84, 84, 9204, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (85, 85, 4188, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (86, 86, 2140, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (87, 87, 920, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (88, 88, 4376, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (89, 89, 2817, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (90, 90, 6200, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (91, 91, 1187, 'Debit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (92, 92, 4919, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (93, 93, 2026, 'Wallet/UPI', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (94, 94, 2902, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (95, 95, 4882, 'Cash', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (96, 96, 393, 'Debit Card', 'Paid');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (97, 97, 2222, 'Credit Card', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (98, 98, 6983, 'Cash', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (99, 99, 6695, 'Wallet/UPI', 'Pending');
INSERT INTO `Payment` (`PaymentID`, `BookieID`, `Payment_Amount`, `Payment_Method`, `Payment_Status`) VALUES (100, 100, 6213, 'Credit Card', 'Paid');


#
# TABLE STRUCTURE FOR: Ride
#

DROP TABLE IF EXISTS `Ride`;

CREATE TABLE `Ride` (
  `VehiclesID` int(11) DEFAULT NULL,
  `RideID` int(11) NOT NULL AUTO_INCREMENT,
  `Tracking` varchar(50) DEFAULT NULL,
  `R_Type` enum('Car','Bike','Auto') NOT NULL,
  PRIMARY KEY (`RideID`),
  KEY `idx_VehiclesID` (`VehiclesID`),
  CONSTRAINT `Ride_ibfk_1` FOREIGN KEY (`VehiclesID`) REFERENCES `Vehicle` (`Vehicle_ID`),
  CONSTRAINT `CONSTRAINT_6` CHECK (`R_Type` in ('Car','Bike','Auto'))
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (1, 1, '59 Rebeca Elbow\nWalshport, SA 4248', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (4, 2, '637 Eden Mews\nSouth Bradford, ACT 7947', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (5, 3, '505 Destiny Basin\nSouth Waltonshire, ACT 0318', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (6, 4, '53 Arvid End\nSt. Dawson, SA 0304', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (7, 5, 'Unit 58 0 Dion Ramp\nRoobbury, TAS 1002', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (7, 6, 'Suite 111 71 Joey Distributor\nLake Fernandoberg, Q', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (7, 7, '2 Irving Highway\nPort Archville, ACT 3968', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (7, 8, '1D Hintz Tor\nLouieton, QLD 8180', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (9, 9, '1 Sipes Pathway\nNorth Wilbertchester, WA 3949', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (12, 10, 'Unit 80 925 Connie Tarn\nJovanshire, ACT 3951', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (13, 11, 'Flat 68 7 Bernhard Route\nPort Casey, ACT 8409', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (14, 12, '641 / 881 Kameron Arcade\nRunteville, NT 8046', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (14, 13, 'Suite 053 981 Larkin Cutting\nPearlietown, NT 5223', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (15, 14, '371B Elinore Ramble\nSouth Easterhaven, ACT 7836', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (16, 15, '48 Otis Place\nJarredview, VIC 7865', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (16, 16, '69 / 55 Murazik Centre\nNew Hilariobury, SA 0619', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (17, 17, '468B Myra Walk\nRachaelport, NT 4617', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (18, 18, 'Suite 348 64 Krajcik Glade\nSouth Kolbyshire, NT 11', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (19, 19, '20A Ritchie Fairway\nMuraziktown, NSW 6216', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (19, 20, '742B Chanel Tarn\nLake Kenna, NSW 8442', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (22, 21, '19C Armstrong Firetrail\nNorth Rethamouth, SA 5632', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (23, 22, '8 Enoch Plateau\nJoannyside, WA 8286', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (27, 23, '3 Jaquelin Avenue\nEast Kirstenmouth, NT 1877', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (29, 24, '389 Hahn Brace\nSouth Odie, NSW 2258', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (29, 25, '55C Charley Interchange\nSt. Herman, ACT 3868', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (30, 26, '00 Emmerich Mew\nGarrisonmouth, VIC 8675', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (31, 27, '674C Mante Flat\nHuelberg, NSW 4681', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (36, 28, '24 Mayert Villas\nEast Cedrickstad, WA 3701', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (37, 29, '81C Barton Cross\nVerdieshire, VIC 4588', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (39, 30, '8 Hahn View\nReillyburgh, NT 7800', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (40, 31, '02 Florida Circuit\nHeathcoteland, NT 3024', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (41, 32, 'Suite 240 38 Jammie Road\nBruenberg, TAS 8677', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (47, 33, '0A Blick Causeway\nNew Mohamed, QLD 5869', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (49, 34, '17C Jammie Cul-de-sac\nPort Jordanborough, WA 4083', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (50, 35, '48 Naomie Riverway\nRogahnfurt, VIC 0026', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (50, 36, 'Level 7 25 Gerlach Riverway\nHomenickmouth, QLD 943', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (52, 37, '8 / 4 Dooley Upper\nMartaport, VIC 3608', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (53, 38, '834A Brisa Viaduct\nNorth Esperanzaport, NSW 9921', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (53, 39, 'Suite 974 0 Satterfield Alley\nWunschshire, NT 7338', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (53, 40, '54 Robel Subway\nNew Eliaschester, NT 8404', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (56, 41, '022 Hills Towers\nKurtisborough, SA 3006', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (62, 42, '73 Wisoky Elbow\nJavonteview, WA 1537', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (62, 43, '463 / 457 Ilene Avenue\nEstaburgh, QLD 7138', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (63, 44, '457C Schultz Road\nSouth Sidneyborough, SA 9627', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (63, 45, 'Level 6 5 Gennaro Trail\nSouth Marcella, VIC 8864', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (64, 46, '148C Cristian Concourse\nHeidenreichburgh, QLD 1493', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (66, 47, 'Flat 89 675 Johan Deviation\nWalshhaven, ACT 9363', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (68, 48, '632B Renner Frontage\nEmeraldchester, NSW 8598', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (69, 49, '2C Thiel Drive\nNorth Esteban, NSW 9906', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (69, 50, '05D Norene Lees\nSouth Annabelle, VIC 5392', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (70, 51, '271A Brakus Quay\nEast Bradford, QLD 9246', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (72, 52, '0 Nader Parkway\nDinaville, VIC 2474', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (74, 53, 'Apt. 001 6 River Gardens\nSouth Winston, NT 5639', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (75, 54, '91C Breitenberg Pathway\nLaurineberg, QLD 1466', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (76, 55, '0D Kody Follow\nShermanmouth, WA 5104', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (76, 56, 'Suite 797 781 Friesen Formation\nSt. Terence, VIC 6', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (77, 57, '3 Nathanial Little\nJakaylaland, ACT 2812', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (78, 58, 'Unit 98 25 Erdman Cove\nStromanchester, VIC 9550', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (79, 59, 'Apt. 602 825 Lowe Loop\nZemlakhaven, WA 5458', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (80, 60, '214B Beer Riverway\nMontanaville, QLD 4128', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (81, 61, '3B Eudora Viaduct\nSt. Ethylhaven, WA 2467', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (81, 62, 'Apt. 279 235 Sandrine Upper\nWiegandchester, ACT 38', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (82, 63, '592 Fritsch Lees\nSouth Amybury, TAS 4345', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (83, 64, '27D Ledner Wynd\nPort Tia, SA 9009', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (87, 65, 'Level 0 46 Quigley Courtyard\nChynamouth, TAS 6447', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (88, 66, '21 Stehr Bypass\nSouth Melvina, NT 8478', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (89, 67, '2 Bradtke Centreway\nStoltenbergburgh, NT 6927', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (90, 68, '9A Rick Riviera\nPort Treva, VIC 5788', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (91, 69, '47 Alden Gates\nNorth Hattie, TAS 3206', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (92, 70, '0B Audie Crossway\nPort Jada, SA 1420', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (93, 71, '1B Gabrielle Concourse\nChristellehaven, SA 0214', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (93, 72, '6 Kuhn Arcade\nBashirianfurt, SA 0000', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (95, 73, '0C Gibson Foreshore\nNorth Elias, VIC 7505', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (95, 74, 'Apt. 179 715 Stroman Cutting\nWest Lerahaven, NSW 2', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (96, 75, '344D Coralie Villas\nPort Claraville, ACT 6918', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (96, 76, '97 Brody Path\nWeimannstad, NT 7894', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (97, 77, '88 / 31 Kertzmann Ramble\nZemlakfort, WA 7660', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (98, 78, '76 / 4 Padberg Link\nSouth Wilmerchester, ACT 8610', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (98, 79, 'Unit 03 692 D\'Amore Driveway\nDomenicachester, TAS ', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (98, 80, 'Suite 003 052 Donna Lane\nNorth Amalia, TAS 3874', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (99, 81, '93 Shannon Lower\nBrakushaven, NT 6387', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (99, 82, 'Suite 457 44 Braun Grange\nAnnieshire, NT 9002', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (1, 83, 'Level 2 860 Noemy Turn\nKoeppland, TAS 6892', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (2, 84, 'Level 7 3 Mathias Rotary\nKlingfort, ACT 0286', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (3, 85, '64 Bednar Tarn\nLake Kelsie, QLD 9082', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (8, 86, '2 Raheem Stairs\nKuvalisstad, NT 6122', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (9, 87, '630D Koelpin Distributor\nLake Alexiestad, NT 2664', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (10, 88, '08A Will Slope\nWest Eveline, TAS 3787', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (11, 89, 'Level 8 7 Margie Garden\nEast Valentine, QLD 5637', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (11, 90, '13C Beier Motorway\nDarlenestad, TAS 6981', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (12, 91, '0 / 0 Davis Crossroad\nHettingerport, VIC 1957', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (13, 92, '87 / 43 Kilback Pathway\nNorth Justina, NSW 7258', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (13, 93, '23 Purdy Approach\nSt. Sydnie, NT 3114', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (13, 94, '2 Freeda Motorway\nJackiefurt, ACT 5893', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (14, 95, '85A Nathanael Crossing\nElectabury, TAS 6055', 'Car');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (15, 96, '7 Burdette Gully\nNew Treyview, NT 4801', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (16, 97, '0A Daniel Elbow\nHermistonbury, ACT 7307', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (19, 98, '208 / 56 Altenwerth Glen\nNew Geneshire, VIC 5647', 'Auto');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (19, 99, 'Suite 381 27 Parker Square\nWest Americo, VIC 2443', 'Bike');
INSERT INTO `Ride` (`VehiclesID`, `RideID`, `Tracking`, `R_Type`) VALUES (20, 100, '0A Reilly Right Of Way\nNew Wade, SA 0788', 'Car');


#
# TABLE STRUCTURE FOR: Tracking
#

DROP TABLE IF EXISTS `Tracking`;

CREATE TABLE `Tracking` (
  `Tracking_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Latitude` varchar(50) DEFAULT NULL,
  `Longitude` varchar(50) DEFAULT NULL,
  `BookeID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tracking_ID`),
  KEY `idx_BookeID` (`BookeID`),
  CONSTRAINT `Tracking_ibfk_1` FOREIGN KEY (`BookeID`) REFERENCES `Bookings` (`Booking_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (1, '-14.940662', '-29.966381', 1);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (2, '59.236609', '76.567967', 2);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (3, '-80.977384', '-21.597125', 3);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (4, '8.081699', '151.238380', 4);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (5, '0.830281', '-101.430263', 5);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (6, '72.347428', '-66.883817', 6);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (7, '1.998503', '121.140273', 7);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (8, '-81.891970', '162.506967', 8);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (9, '-46.480398', '144.310670', 9);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (10, '-26.218578', '46.094395', 10);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (11, '65.665364', '9.806325', 11);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (12, '-70.802513', '147.460619', 12);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (13, '-0.724527', '129.601819', 13);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (14, '-48.211048', '-69.715175', 14);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (15, '-71.175086', '-152.265429', 15);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (16, '64.184508', '157.116954', 16);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (17, '-10.924280', '68.587080', 17);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (18, '-43.676550', '-29.912318', 18);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (19, '-25.960756', '171.345906', 19);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (20, '2.850600', '-0.156849', 20);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (21, '-21.118892', '-121.115957', 21);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (22, '-16.773443', '-165.115101', 22);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (23, '-55.579967', '26.669766', 23);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (24, '82.168393', '85.363305', 24);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (25, '38.546092', '-106.475190', 25);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (26, '-49.514738', '-42.680173', 26);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (27, '19.762627', '24.185303', 27);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (28, '-74.641471', '153.050835', 28);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (29, '-23.314638', '4.527372', 29);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (30, '-39.009304', '55.599132', 30);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (31, '9.162526', '144.457976', 31);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (32, '63.584332', '-3.829384', 32);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (33, '69.420806', '19.295102', 33);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (34, '-30.906382', '170.471923', 34);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (35, '-38.414471', '-101.026711', 35);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (36, '88.056438', '-10.365009', 36);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (37, '25.002824', '-133.131021', 37);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (38, '76.394956', '-161.192630', 38);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (39, '-49.666818', '175.371806', 39);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (40, '-70.885916', '84.108851', 40);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (41, '45.373102', '-100.450059', 41);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (42, '21.388013', '-117.622804', 42);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (43, '5.959233', '-104.168463', 43);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (44, '63.760866', '-174.479590', 44);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (45, '8.829092', '150.017717', 45);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (46, '-27.747015', '133.665560', 46);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (47, '30.321258', '166.384294', 47);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (48, '10.694211', '-147.708557', 48);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (49, '88.417931', '102.618305', 49);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (50, '46.580587', '110.090261', 50);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (51, '-15.863549', '-39.112641', 51);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (52, '-20.237790', '-16.718204', 52);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (53, '85.994198', '168.106280', 53);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (54, '58.995908', '-122.231706', 54);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (55, '49.311226', '-21.158723', 55);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (56, '11.459452', '-145.514285', 56);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (57, '17.810604', '-67.164699', 57);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (58, '-77.434487', '92.858688', 58);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (59, '-6.362881', '-150.829627', 59);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (60, '-59.637584', '-91.363326', 60);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (61, '-22.865634', '86.456430', 61);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (62, '72.924280', '157.369810', 62);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (63, '-65.830796', '-165.600927', 63);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (64, '-43.100057', '-37.327924', 64);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (65, '88.690073', '102.885284', 65);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (66, '12.484766', '50.297844', 66);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (67, '-3.193270', '-117.712203', 67);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (68, '-75.412019', '73.810636', 68);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (69, '9.748599', '144.545061', 69);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (70, '-13.374732', '-144.824185', 70);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (71, '-34.570420', '-156.308149', 71);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (72, '82.292187', '168.508525', 72);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (73, '61.822178', '-80.084161', 73);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (74, '-58.350285', '-63.006870', 74);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (75, '70.117193', '-161.232730', 75);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (76, '27.521365', '46.737163', 76);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (77, '-12.138282', '-25.529863', 77);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (78, '-67.143582', '-35.654287', 78);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (79, '-2.152152', '135.928985', 79);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (80, '-10.805448', '-111.208823', 80);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (81, '79.147131', '122.354260', 81);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (82, '-67.169407', '28.910498', 82);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (83, '-4.535797', '-36.966661', 83);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (84, '19.446164', '-123.479397', 84);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (85, '50.416833', '-112.757351', 85);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (86, '51.553079', '-77.456917', 86);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (87, '-58.799457', '24.497449', 87);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (88, '84.029740', '37.893529', 88);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (89, '-40.946212', '-95.475461', 89);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (90, '-3.375024', '85.686582', 90);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (91, '4.499359', '112.821104', 91);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (92, '22.645818', '84.180118', 92);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (93, '89.021186', '68.650368', 93);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (94, '-61.813111', '-19.246820', 94);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (95, '53.038598', '7.730447', 95);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (96, '30.590798', '-152.427331', 96);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (97, '-21.565055', '-70.969596', 97);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (98, '7.725439', '-118.123246', 98);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (99, '37.086193', '-87.444941', 99);
INSERT INTO `Tracking` (`Tracking_ID`, `Latitude`, `Longitude`, `BookeID`) VALUES (100, '-46.485000', '-113.064830', 100);


#
# TABLE STRUCTURE FOR: User_phone
#

DROP TABLE IF EXISTS `User_phone`;

CREATE TABLE `User_phone` (
  `User_ID` int(11) NOT NULL,
  `Phone_number1` varchar(20) NOT NULL,
  `Phone_number2` varchar(20),
  PRIMARY KEY (`User_ID`,`Phone_number1`,`Phone_number2`),
  KEY `user_id_index` (`User_ID`),
  CONSTRAINT `User_phone_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `Users` (`User_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (1, '0827062257','0827062256');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (2, '+61.2.0337.1157','+61.2.0337.1156');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (3, '4244-9766','4244-9768');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (4, '(03)-6754-9441','(03)-6754-9442');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (5, '+61202071684','+61202071685');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (6, '(07)73418002','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (7, '5572.2277','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (8, '+61-3-8421-9698','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (9, '07-4807-4602','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (10, '83635256','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (11, '1120-9618','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (12, '+61-7-9941-5042','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (13, '(02).5959.1116','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (14, '0237 6050','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (15, '0812241532','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (16, '(03)68885411','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (17, '+61.3.6020.4106','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (18, '38664969','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (19, '1239-4728','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (20, '(02).8556.0951','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (21, '(07) 5769 4234','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (22, '7197.6184','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (23, '(03)-1895-3485','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (24, '(07) 5329 9523','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (25, '07-7424-5398','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (26, '07.3144.5732','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (27, '08-7721-7866','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (28, '02-9309-4165','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (29, '(07) 7778 1926','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (30, '07 0248 5525','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (31, '+61-3-8044-2054','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (32, '6579-7435','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (33, '+61.2.0846.2577','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (34, '8095.8280','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (35, '0806910453','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (36, '4042 5339','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (37, '(03) 6166 2507','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (38, '3493.4767','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (39, '3118 2859','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (40, '(03)-1978-1136','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (41, '5244-1158','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (42, '9617.1045','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (43, '73441843','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (44, '+61882828105','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (45, '+61-7-4425-5388','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (46, '03 5222 7540','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (47, '(02).3972.2289','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (48, '0366874362','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (49, '07-7429-7686','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (50, '(03)-3334-2237','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (51, '03-0584-7057','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (52, '2201.8926','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (53, '(03).1926.2950','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (54, '+61-8-9945-9669','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (55, '4522.4949','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (56, '67065776','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (57, '+61203372762','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (58, '+61.7.0257.6657','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (59, '0349557031','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (60, '+61 2 0711 6138','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (61, '07.0389.2922','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (62, '69849732','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (63, '8641.2210','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (64, '(03)54011514','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (65, '4229 7762','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (66, '0225912274','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (67, '76892504','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (68, '07 3677 3130','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (69, '08.4855.8074','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (70, '08-0003-3457','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (71, '07-2056-0680','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (72, '+61.3.0086.5794','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (73, '+61 7 4692 8325','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (74, '(08)-4174-9928','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (75, '+61.8.0565.9812','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (76, '+61833665827','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (77, '+61 3 4980 5795','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (78, '(02)30023017','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (79, '+61 7 7515 7936','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (80, '(02)-9369-7112','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (81, '03 3381 0068','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (82, '1466 1681','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (83, '+61.7.4971.6835','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (84, '07 7361 9534','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (85, '3515-5992','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (86, '+61 8 3943 2973','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (87, '39429502','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (88, '(03)-5981-1861','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (89, '7002.6061','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (90, '(02) 8438 4653','');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (91, '1686 9004','1686 9005');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (92, '(08).5416.2693','(08).5416.2673');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (93, '08-0202-0435','08-0202-0438');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (94, '+61 8 5560 6299','+61 8 5560 6297');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (95, '02 0035 9465','02 0035 9462');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (96, '(07) 8702 2973','(07) 8702 2978');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (97, '4192-8340','4192-8349');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (98, '+61 8 9808 1365','+61 8 9808 1369');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (99, '6192-7922','6192-7928');
INSERT INTO `User_phone` (`User_ID`, `Phone_number1`,`Phone_number2`) VALUES (100, '08 6202 6954','08 6202 6959');


#
# TABLE STRUCTURE FOR: Users
#
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `User_ID` int(11) NOT NULL AUTO_INCREMENT,
  `fname` varchar(50) NOT NULL,
  `mname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `User_Status` enum('Normal','Prime') NOT NULL,
  `E_mail` varchar(100) NOT NULL,
  `UserPassword` varchar(50) NOT NULL,
  PRIMARY KEY (`User_ID`),
  UNIQUE KEY `E_mail` (`E_mail`),
  KEY `email_index` (`E_mail`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (1, 'Annabell', '', 'Hoppe', 'Normal', 'beier.wellington@hotmail.com', 'c5881ebc049223408da0bb04cc44c3390f4c5835');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (2, 'Clotilde', 'Lance', 'Hand', 'Normal', 'adickinson@yahoo.com', 'd5892953bf53f91d4ac00551211cac43468c31e5');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (3, 'Sarai', 'Zachariah', 'Monahan', 'Normal', 'kyler08@yahoo.com', 'f10c7422dc7fa4efcc8d5ff200350bbcea0a3145');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (4, 'Mallie', '', 'Grady', 'Prime', 'lebsack.abby@gmail.com', '82f82ef9d385147b1e8a6c0b192b4f73f9ff49bc');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (5, 'Cornell', 'Jerald', 'Luettgen', 'Normal', 'elta23@gmail.com', '8d44ce4f6e2d0a4780bd02769c26bac42a7c4760');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (6, 'Berniece', 'Delpha', 'Rowe', 'Normal', 'wilfred.white@yahoo.com', '85f95a3934e43184c457ff543e7eb1d70ef28c5b');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (7, 'Candice', '', 'Feeney', 'Normal', 'mccullough.phyllis@hotmail.com', '6ec75f4613019f1c6a232904b596c333823bf958');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (8, 'Gerhard', '', 'Corkery', 'Normal', 'babbott@hotmail.com', '68f513bb01835e38757542d490733354cd545d61');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (9, 'Simeon', '', 'Keebler', 'Prime', 'jaskolski.madisyn@hotmail.com', '4b1b672995f6d7db2a04fcd1159df7ff5ab3b32d');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (10, 'Moshe', 'Carlos', 'Lehner', 'Prime', 'rosenbaum.greyson@hotmail.com', '8fa63697ce683540936cd6a8af95e4d7352a9cee');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (11, 'Caitlyn', 'Doug', 'Walter', 'Prime', 'stroman.hermann@gmail.com', '8363c751aec9f89b691a830c21d0311711991bf7');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (12, 'Delmer', '', 'McCullough', 'Prime', 'larson.winona@gmail.com', 'ade5525e4b6fa63a6b60bf8ec4163febb8c6fe57');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (13, 'Santa', 'Darien', 'Beer', 'Prime', 'kayleigh79@gmail.com', 'efac7fd1f0e674239885afbb8cdb3923567f01b1');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (14, 'Billie', '', 'Franecki', 'Normal', 'amy.wuckert@gmail.com', 'a70fa6fc2d4485afd36fb17690c5e9384afa53b9');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (15, 'Gerry', 'Leo', 'Lueilwitz', 'Prime', 'darlene54@gmail.com', '90f989380d46c3050c4a4c47b7e28fa0eb4afe4f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (16, 'Randi', 'Eunice', 'Walker', 'Prime', 'eframi@gmail.com', '9e97d4f36c6ead909d952fb66314c5c023b1594b');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (17, 'Ana', 'Misael', 'Dietrich', 'Prime', 'streich.myrtice@yahoo.com', '0dab3548cdfe9033d4226184b0bbf52c49ba240b');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (18, 'Tyrese', '', 'Ritchie', 'Normal', 'kasey.herzog@yahoo.com', '6d13d3f3934b3f6ca1897d6d02304631d757ba4e');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (19, 'Timmy', 'Rahul', 'Schumm', 'Normal', 'lilyan.turcotte@yahoo.com', '1cfbd82a3d5cb5f7ed2fd55f56e6ed72a1e3d237');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (20, 'Jeramie', '', 'Hyatt', 'Normal', 'hadams@hotmail.com', '0da85a836a5b36ad7604784c7e4275c7b6136180');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (21, 'Britney', 'Adeline', 'Howe', 'Prime', 'kessler.jedidiah@gmail.com', '9844457ca5aa6af9a2a20efa167d82d5e0455d23');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (22, 'Retta', '', 'Rempel', 'Normal', 'destiney.conroy@hotmail.com', 'd73dcbaa3aff182037c94276bfb8474d6b647ac6');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (23, 'Talon', 'Frederick', 'Cassin', 'Prime', 'benjamin.weber@gmail.com', 'ecb8868c22ea104e85a20764d333e227e11ede47');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (24, 'Boyd', '', 'Reynolds', 'Prime', 'vdavis@yahoo.com', 'ed8be2e3114bba9bfcaf8d868738d5c3c9d90baa');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (25, 'Laila', 'Ocie', 'Gibson', 'Normal', 'rodrigo.larkin@hotmail.com', '4f759f84e8f63c5d16cbbbf6a3b195f28f25d3c1');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (26, 'Ronny', '', 'Spinka', 'Prime', 'thurman.nolan@hotmail.com', 'bb362077f56680a72a97e700ba7a4feb7c07d200');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (27, 'Sonya', 'Dewayne', 'Pouros', 'Prime', 'pkreiger@yahoo.com', 'a41b1172d268c2ce667dc5c25f29de55e92bc428');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (28, 'Kenneth', '', 'Predovic', 'Normal', 'jade07@hotmail.com', 'c0e252ba2911d52152c3dde7a825bba8eeb178a5');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (29, 'Cecil', 'Reese', 'Orn', 'Prime', 'jewell63@yahoo.com', 'da4e3e98e7ee3313716d1b268ce2e1dd6d24b5c3');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (30, 'Devin', '', 'Weimann', 'Normal', 'gerhold.rodrick@hotmail.com', '366bb72ff6cb4cb67e8097f51bceded190623591');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (31, 'Cielo', '', 'Schimmel', 'Normal', 'oma02@yahoo.com', '06da2130450f117005fec2fa1d94eb95b0bd4af3');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (32, 'Frieda', '', 'Cormier', 'Prime', 'broderick.strosin@yahoo.com', 'f6daf0313c55626542cc3852c987a5a76f89ba63');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (33, 'Travon', 'Maria', 'Wilderman', 'Prime', 'heller.kariane@hotmail.com', '9c5af014a169d77483942d361fd758f107454fb5');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (34, 'Muriel', 'Cristal', 'Pollich', 'Normal', 'bgislason@yahoo.com', '0ff4a66e5dde6986969c7de76ab5a66ad5e5fbb8');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (35, 'Theresia', '', 'Daniel', 'Prime', 'ayana01@gmail.com', 'fabd12338f7ad5f6176bf238f5362d31140ed165');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (36, 'Jovany', '', 'O\'Connell', 'Normal', 'runte.howell@yahoo.com', '33f8adac3c10de72d8f22d9d90ba289bee48c555');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (37, 'Alexie', 'Lolita', 'Johns', 'Prime', 'wanda34@gmail.com', 'ed78cd769394ef66da174916c2c38e9c7c7f0b0f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (38, 'Kaci', 'Timothy', 'Gleason', 'Prime', 'smith.richmond@yahoo.com', '3cbb4199260b507db2f9a6eb1a3b38e6b4ebd978');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (39, 'Devante', '', 'Huels', 'Prime', 'arely.cole@hotmail.com', '029f5b1b0f9d54e24146c9a27a9d0b138a3b0261');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (40, 'Anjali', '', 'Marks', 'Normal', 'caterina00@yahoo.com', '00ca27671b6eab8ccd479377fbb4dafde0ba1c3e');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (41, 'Rusty', '', 'Halvorson', 'Normal', 'elise.botsford@gmail.com', '165bc450057dc27fc0529aa51f97b9fcb9ed46b2');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (42, 'Nyasia', 'Everette', 'Rowe', 'Prime', 'padberg.angelica@hotmail.com', '4171ec498122b405ba32e24adcc0678555ade942');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (43, 'Taylor', '', 'Mohr', 'Prime', 'abdullah76@hotmail.com', 'e6793acecc031b87449abf2747c895b560ffa71d');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (44, 'Laurie', 'Beatrice', 'Welch', 'Normal', 'hester.bartell@hotmail.com', '2ed1c2d3426033b5626ec812edb469ccdd32ab62');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (45, 'Dominic', 'Beulah', 'Wuckert', 'Prime', 'keenan95@gmail.com', '155c277690128155aa5cf68157b1f8728bc3c7f5');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (46, 'Sydnee', '', 'Fahey', 'Normal', 'verda.kuhic@gmail.com', '878814d45e6aeef43158a589703f14356c0442e1');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (47, 'Myrtie', '', 'Marks', 'Normal', 'nicolas.moses@hotmail.com', 'ad9c939703bde551fab8ec452e15ad23ab15aeae');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (48, 'Delpha', 'London', 'Medhurst', 'Normal', 'laney03@gmail.com', '88351ee888267855b4c7c5ffb3f1e8d61388b698');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (49, 'Eldred', '', 'Berge', 'Normal', 'demetrius.adams@yahoo.com', 'c59a905a9f0210fa8f5e639bd3f8b20dea4a7e5f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (50, 'Camila', 'Itzel', 'Koelpin', 'Normal', 'hintz.gina@gmail.com', '6acc0989de079647b4b22915c5294936bba2003f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (51, 'Eleazar', 'Lavern', 'Bergnaum', 'Normal', 'eda15@hotmail.com', 'b9ddcc4a4315703432e92250b372a4a8839841e2');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (52, 'Rylan', 'Carissa', 'Ratke', 'Normal', 'garrick54@hotmail.com', '664065f8b13bf23402e9aa2161230d05d7aebc51');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (53, 'Karianne', '', 'Pouros', 'Normal', 'hfunk@gmail.com', '4aa5d25059eb0d71faed0eae418fdd533aa46013');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (54, 'Cecile', '', 'Kovacek', 'Prime', 'heaney.hans@gmail.com', '4cf609ac6725337344fff9e8cf08277a682cac41');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (55, 'Margarett', 'Terrence', 'Purdy', 'Normal', 'ygottlieb@gmail.com', 'b02ed4ff63c3403d3d339e81ea404ee4c6dd7239');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (56, 'Finn', '', 'Hodkiewicz', 'Prime', 'jkautzer@gmail.com', 'be70d0c785f6eb7b9078d57cef684fb44000e8e8');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (57, 'Augustine', '', 'Morar', 'Normal', 'waelchi.mustafa@hotmail.com', 'f9c8c102533d03d0c37a1ee41a6c40b79e04f280');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (58, 'Andreane', 'Alphonso', 'McGlynn', 'Normal', 'goyette.hilma@hotmail.com', 'fa87e7b2e72fc5dbb300982c9d38ad9faadb8725');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (59, 'Hudson', '', 'Orn', 'Prime', 'stroman.sebastian@gmail.com', '2a46325fce048c7d6d0947bb6953a99c3979384d');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (60, 'Nestor', 'Alfred', 'Yundt', 'Prime', 'o\'conner.vicenta@gmail.com', 'dd7acd2f954e23691c6747016639d49167a2aabd');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (61, 'Damaris', 'Kobe', 'Wolff', 'Prime', 'rosa.veum@gmail.com', 'e02d870a4c7bcb199d9f867f06bc845c697ec2ac');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (62, 'Josiane', 'Mossie', 'Gulgowski', 'Prime', 'hermiston.lindsey@gmail.com', '44c196f1528e7d46e3a880834ba9adff010e2669');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (63, 'Linnie', '', 'Waelchi', 'Normal', 'yschiller@gmail.com', 'c54e2290c16c6b6a50064363e05c19062fa6c1ac');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (64, 'Cedrick', '', 'Ledner', 'Prime', 'homenick.velva@gmail.com', '4ca856c60649831ec7ca055ad411ee0a4f450443');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (65, 'Ian', 'Clemmie', 'Dooley', 'Normal', 'johns.magnolia@yahoo.com', 'fd84181847a4049748d17c5cfdf9bc1f3df896f3');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (66, 'Shanel', '', 'Barton', 'Normal', 'dschowalter@hotmail.com', 'f59beda3b7e4725eaafcf56530e73ce37f14b611');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (67, 'Coy', 'Alek', 'Reichel', 'Normal', 'yfay@yahoo.com', 'db50bf56b6b493b5cb3297eaabe20bf50c9024de');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (68, 'Mabelle', '', 'Kunde', 'Prime', 'cleveland.abshire@gmail.com', 'fe7fae7359234f59ef81734fb1a386ac85e21c83');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (69, 'Bernita', 'Barney', 'Christiansen', 'Prime', 'corwin.schuyler@yahoo.com', '147fe74d1a38fca8b5e5588053cf3917bdabd161');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (70, 'Thomas', '', 'Grimes', 'Prime', 'beier.kaitlin@gmail.com', '620fcd0a1a8106750a91880ff065336a81a0cbc0');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (71, 'Elisha', 'Nathanial', 'Kshlerin', 'Normal', 'darryl44@hotmail.com', 'e8ccacaf3b03e8c9b9723920017ea090bd42497e');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (72, 'Kelsie', 'Esteban', 'Funk', 'Prime', 'weber.amir@hotmail.com', 'f9572844489fe6ffd36b8150a9c87beefe94f410');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (73, 'Norene', '', 'Prosacco', 'Normal', 'issac36@gmail.com', 'ca90071037a7e4746b5b671cbe9f8830564979ff');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (74, 'Jermaine', '', 'Hansen', 'Normal', 'aiden61@gmail.com', '85d1c5e4da7fe46eab05dd44708e9fdeaf79b847');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (75, 'Ward', '', 'Jacobson', 'Normal', 'alesch@yahoo.com', 'a41d3c1bcfbeb6f1707810d170366cb68ea6795e');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (76, 'Vada', '', 'Jerde', 'Prime', 'tharber@gmail.com', '20d78c4087265612efb8d5d53592843648990bb9');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (77, 'Alvena', '', 'Collins', 'Normal', 'uhane@yahoo.com', '4d216fda3bc736e20504b433457e231c9420f991');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (78, 'Trevion', 'Xander', 'Renner', 'Prime', 'qkertzmann@yahoo.com', 'f35d408bec383fa3fab1577fae80467cb74f6b1b');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (79, 'Hayley', '', 'Schmitt', 'Normal', 'davis.velva@yahoo.com', 'ff2326dc9d04d1be7d0018f5a9935456752261b1');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (80, 'Arnaldo', 'Skylar', 'Grady', 'Normal', 'brakus.mollie@hotmail.com', '9305136c9e0f5698fe0bfe89c8fe543b9cd44447');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (81, 'Solon', '', 'Little', 'Normal', 'laurence56@hotmail.com', 'a1de71fa7170a86cdada4c1d8c19361c7d40a117');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (82, 'Terry', '', 'Lueilwitz', 'Normal', 'blanda.verdie@yahoo.com', '202d47d93694e379c5d5e1bb808637d52ebc5d98');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (83, 'Camille', '', 'Sauer', 'Prime', 'fsauer@yahoo.com', '6bb3d21cc26d9712c8616ee0d2aaf698458dd263');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (84, 'Margarett', '', 'Gibson', 'Normal', 'uerdman@gmail.com', '9e5144ca8b917bd1f1717c1366d71d7897438e9f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (85, 'Alicia', '', 'Adams', 'Prime', 'schimmel.clifton@gmail.com', '065b4ea1aaec2ea35e65e20594fff88db208b9a2');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (86, 'Tiffany', 'Creola', 'Blick', 'Prime', 'lbechtelar@gmail.com', 'baff1bba2e7066b4bfc27234f2227fbb907fe957');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (87, 'Gennaro', '', 'Gorczany', 'Normal', 'lauriane39@gmail.com', '9e549aae5e22ef8845917eaf8f2d7bb2cc8064f7');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (88, 'Rogelio', 'Faustino', 'Jerde', 'Prime', 'xquigley@yahoo.com', '8ae15db0d0a2f1cfd51d425955c7e6ca71c49a72');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (89, 'Kamren', 'Mercedes', 'Stokes', 'Normal', 'beatty.lora@gmail.com', 'b8201f516ebf15bad55dbcfd1c8aac133cd01621');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (90, 'Jaron', '', 'Walter', 'Prime', 'bkrajcik@yahoo.com', '67e603d6d7818cb485a21f52ad015f5240a9bced');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (91, 'Ricardo', 'Maxwell', 'Ferry', 'Prime', 'jacobs.brendan@hotmail.com', 'efb33abcb8c7621ad7eb704cbcfb7c15a0abb59f');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (92, 'Harold', 'Adaline', 'Doyle', 'Prime', 'qrowe@yahoo.com', 'da02c9c5f1fa835efb2e97c4ba4d47d170291fa3');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (93, 'Taya', 'Karianne', 'Lakin', 'Normal', 'alexandrine.douglas@yahoo.com', '38e0684e2847ec902b6b121e3acff8534b426f71');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (94, 'Hazle', '', 'Borer', 'Normal', 'bennie42@gmail.com', 'af89894f9cf36a65c78d14158c17e672612bee4b');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (95, 'Oscar', 'Vance', 'Trantow', 'Normal', 'conroy.kaden@yahoo.com', '2f95c24bb941299ff90832a2e8a384635c38a5b0');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (96, 'Ally', '', 'Thompson', 'Normal', 'elliott48@gmail.com', '028a160547f1eb0e5a043038dc193b565f0cf359');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (97, 'Guido', 'Alaina', 'Brekke', 'Prime', 'hdaniel@gmail.com', '364d0e125606d2f99f4911877207da37f0674ecd');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (98, 'Ryleigh', '', 'Smitham', 'Normal', 'rempel.kay@hotmail.com', '5dd5c175ea043601461140dac164b317be66dcbf');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (99, 'Juliana', '', 'Rolfson', 'Prime', 'mante.kassandra@gmail.com', '4c95435e54311eae1a3b3023b3b7291b308a0ec1');
INSERT INTO `Users` (`User_ID`, `fname`, `mname`, `lname`, `User_Status`, `E_mail`, `UserPassword`) VALUES (100, 'Ernestina', '', 'Harber', 'Normal', 'alayna74@hotmail.com', 'fedea9b273f378c4d66558d008cedbcb0da6071f');


#
# TABLE STRUCTURE FOR: Vehicle
#

DROP TABLE IF EXISTS `Vehicle`;

CREATE TABLE `Vehicle` (
  `Vehicle_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DriveeID` int(11) DEFAULT NULL,
  `License_Platenumber` varchar(20) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Make` varchar(50) NOT NULL,
  PRIMARY KEY (`Vehicle_ID`),
  UNIQUE KEY `License_Platenumber` (`License_Platenumber`),
  KEY `idx_DriveeID` (`DriveeID`),
  CONSTRAINT `Vehicle_ibfk_1` FOREIGN KEY (`DriveeID`) REFERENCES `Driver` (`Driver_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;

INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (1, 1, '635588407', '#e9997c', 'Stroman, Ratke and Kozey');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (2, 2, '70856', '#f70bf7', 'Mraz-Trantow');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (3, 3, '4570', '#737d78', 'Botsford, Dibbert and Kub');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (4, 4, '65', '#ec15d5', 'Jaskolski Inc');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (5, 5, '27241990', '#de1b05', 'Morissette-Terry');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (6, 6, '63047', '#6f067c', 'West-Denesik');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (7, 7, '46497983', '#afb303', 'Koch Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (8, 8, '9', '#7b8195', 'Zieme, McKenzie and Rohan');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (9, 9, '725080', '#ce6325', 'Torphy PLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (10, 10, '606795', '#657d66', 'Beer-Abernathy');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (11, 11, '5041042', '#12dd74', 'Hirthe Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (12, 12, '786977', '#5d23ea', 'Corwin LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (13, 13, '74', '#1d69b4', 'Rowe-Cummerata');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (14, 14, '638', '#76a1a7', 'White Inc');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (15, 15, '38', '#fd09b3', 'Gislason-Muller');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (16, 16, '142', '#5ef182', 'Graham-Waelchi');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (17, 17, '501677023', '#b0636c', 'Hintz, Muller and Keebler');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (18, 18, '233548', '#458808', 'Hagenes, Yost and Reynolds');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (19, 19, '62507616', '#3ed2db', 'Thiel and Sons');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (20, 20, '2051769', '#725e91', 'Kuhlman-Wilderman');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (21, 21, '2487', '#0086ce', 'Williamson, Ferry and Lang');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (22, 22, '914486', '#29fc82', 'Wehner Inc');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (23, 23, '89001301', '#708a79', 'Mraz-Hansen');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (24, 24, '9123', '#1c6464', 'Monahan-Huels');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (25, 25, '223', '#0bc2b4', 'Gislason-Rosenbaum');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (26, 26, '6749932', '#195463', 'Zboncak LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (27, 27, '5', '#634e65', 'Hudson, Gleason and Terry');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (28, 28, '9254456', '#3bedba', 'Bogisich and Sons');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (29, 29, '185', '#0d50b1', 'Gutmann LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (30, 30, '69', '#f4a4f9', 'Collier-Watsica');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (31, 31, '4285', '#82e1f0', 'Gislason Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (32, 32, '48', '#5a3f7f', 'O\'Keefe, Lesch and Streich');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (33, 33, '6', '#2db7c2', 'Trantow and Sons');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (34, 34, '5203', '#27a73d', 'Auer Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (35, 35, '36562889', '#c788d8', 'Klocko LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (36, 36, '364', '#7391d5', 'Green Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (37, 37, '35080668', '#298f47', 'Pagac-Haag');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (38, 38, '35811', '#a3d037', 'Smitham, Crona and Lynch');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (39, 39, '6300425', '#453b6e', 'Morar-Legros');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (40, 40, '44', '#030dc3', 'O\'Conner, Leffler and Lemke');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (41, 41, '906732674', '#9f5af3', 'Thiel-Block');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (42, 42, '9593', '#c9632a', 'Upton Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (43, 43, '887321557', '#499db6', 'Williamson-Maggio');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (44, 44, '7', '#578d88', 'Bradtke-Keeling');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (45, 45, '2', '#32eb2a', 'Kuphal, Cartwright and Hagenes');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (46, 46, '83', '#13afa4', 'Jast, Swift and Lynch');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (47, 47, '846', '#50f31f', 'Torp-Altenwerth');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (48, 48, '665388432', '#8dadba', 'Emard-Baumbach');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (49, 49, '70431', '#a9c746', 'Kemmer Inc');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (50, 50, '210795558', '#20046d', 'Kuphal LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (51, 51, '3493', '#4cdc1d', 'Gutkowski, Brakus and Schaden');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (52, 52, '3580', '#a02188', 'Kovacek, Turcotte and Goyette');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (53, 53, '47731432', '#4a9331', 'Baumbach, Sporer and Bergnaum');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (54, 54, '358', '#087675', 'Haag PLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (55, 55, '60713', '#8ccae6', 'Rau LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (56, 56, '91273607', '#d2395a', 'Medhurst-Fahey');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (57, 57, '780650', '#0e25e9', 'Skiles-Ryan');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (58, 58, '9556083', '#8561b7', 'Jacobs, Hintz and Jacobs');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (59, 59, '995268', '#e795c5', 'Beer, Mayer and Marquardt');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (60, 60, '738941', '#082c2c', 'Denesik Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (61, 61, '3804016', '#17b288', 'Abbott Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (62, 62, '81', '#f835ab', 'Kilback, Runolfsdottir and Gleichner');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (63, 63, '596', '#21d2a3', 'Durgan, Yost and Haag');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (64, 64, '651', '#961813', 'Bahringer, Stoltenberg and Johnson');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (65, 65, '63936744', '#f63e33', 'Johnston, Walsh and Bednar');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (66, 66, '23', '#72865b', 'Brown Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (67, 67, '29380247', '#ef2e22', 'Kunde, Raynor and Frami');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (68, 68, '331', '#8d02b2', 'Collier-Brown');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (69, 69, '21896426', '#87e332', 'Volkman Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (70, 70, '11242526', '#cee389', 'Jones Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (71, 71, '1574', '#29294a', 'Flatley, Greenholt and Schneider');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (72, 72, '82', '#1348e3', 'Pollich, Thiel and Schulist');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (73, 73, '2185', '#b0425f', 'Langworth-Hahn');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (74, 74, '2755804', '#de7d3b', 'Abbott-Funk');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (75, 75, '41', '#5ff6dc', 'Bechtelar-Larson');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (76, 76, '21', '#37a4fd', 'Welch, Waelchi and Treutel');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (77, 77, '29', '#57a55e', 'Hintz-Hoppe');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (78, 78, '18783', '#3ffee0', 'Carter-Swaniawski');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (79, 79, '6954920', '#9a39af', 'Brakus-Kautzer');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (80, 80, '89', '#a19b3d', 'McCullough-Zulauf');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (81, 81, '1', '#333672', 'Ratke, Lowe and Heathcote');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (82, 82, '81257405', '#73917f', 'Jaskolski-Heathcote');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (83, 83, '4', '#f963c9', 'Roberts LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (84, 84, '199420', '#b3971f', 'Gottlieb Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (85, 85, '11922401', '#aaba19', 'Schultz, Towne and Bosco');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (86, 86, '6527', '#b2d140', 'Olson, Borer and Harber');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (87, 87, '3666265', '#091f10', 'Jaskolski-Hegmann');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (88, 88, '1941279', '#c56354', 'Nikolaus, Davis and Larson');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (89, 89, '214200', '#1e5ed0', 'Nikolaus Group');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (90, 90, '96893', '#cb0289', 'Frami-Crooks');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (91, 91, '63031', '#e6be74', 'Lebsack-Swift');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (92, 92, '1172', '#4a186c', 'Fadel LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (93, 93, '92215', '#af4992', 'Vandervort Ltd');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (94, 94, '167', '#d20a17', 'Orn PLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (95, 95, '7820146', '#625e2d', 'Maggio, Hammes and Ferry');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (96, 96, '398933860', '#0ecada', 'Schaefer, Parker and Greenfelder');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (97, 97, '868', '#913abc', 'Parker LLC');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (98, 98, '676', '#49a826', 'Mosciski, Denesik and Smith');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (99, 99, '17', '#8f1573', 'Hayes-Koss');
INSERT INTO `Vehicle` (`Vehicle_ID`, `DriveeID`, `License_Platenumber`, `Model`, `Make`) VALUES (100, 100, '5877254', '#4fe4dd', 'Crooks-Raynor');

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
SET autocommit=@old_autocommit;

Select * From Bookings;
Select * From Driver;
-- 1) Books a ride and updates the driver status for that ride:
start TRANSACTION;
INSERT INTO Bookings (Booking_ID, UserID, Dri_ID, Pickup, Dropoff) VALUES (111, 15, 5, '8D Isadore Esplanade\nSouth Joel, NSW 7154', '87 / 21 Adrien Pathway\nNew Rahulfurt, WA 6956');
UPDATE Driver SET Dr_Status = 'inactive' WHERE Driver_ID = 5;
COMMIT;
Select * From Bookings;
Select * From Driver;

Select * From Bookings;
Select * From DrivesFor;
Select * From Payment;
-- 2)  A booking is made and correspondingly the payment is calculated:
START TRANSACTION;
INSERT INTO Bookings (Booking_ID, UserID, Dri_ID, Pickup, Dropoff) VALUES (112, 20, 20, '7D Isadore Esplanade\nSouth Joel, NSW 7154', '87 / 21 Adrien Pathway\nNew Rahulfurt, WA 69');
INSERT INTO DrivesFor (DrivID, UsrID, Tim, Distance) VALUES (20, 20, '2022-11-17 13:34:29', '50');
INSERT INTO Payment (PaymentID, BookieID, Payment_Amount, Payment_Method, Payment_Status) VALUES (112, 112, 500, 'Debit Card', 'Paid');
COMMIT;
Select * From Bookings;
Select * From DrivesFor;
Select * From Payment;


Select * From Bookings;
Select * From Users;
-- 3)  Updates the user information and the user further makes booking using the updated info. 
START TRANSACTION;
UPDATE Users set fname='Mike',lname='Beier',UserPassword='c5881ebc049223408da0bb04cc44c3390f4c5777' WHERE User_ID = 1;
INSERT INTO Bookings (Booking_ID, UserID, Dri_ID, Pickup, Dropoff) VALUES (113,1,9,'7D Esplanade\nSouth Joel, NSW 7154', '87 / 21 Pathway\nNew Rahulfurt, WA 69');
Commit;
Select * From Bookings;
Select * From Users;


Select * From Bookings;
Select * From Driver;
-- 4)  Transfers a particular booking from one driver to another.
START TRANSACTION;
UPDATE Bookings SET Dri_ID = 13 WHERE Booking_ID = 4;
UPDATE Driver SET Dr_Status = 'inactive' WHERE Driver_ID = 13;
UPDATE Driver SET Dr_Status = 'active' WHERE Driver_ID = 104;
Commit;
Select * From Bookings;
Select * From Driver;


Select * From Vehicle;
-- 5)  Creates a new vehicle and assigns it to the driver and removes the old vehicle.
START TRANSACTION;
Delete FROM Vehicle where Vehicle_ID=1;
INSERT INTO Vehicle (Vehicle_ID, DriveeID, License_Platenumber, Model, Make) VALUES (101, 1, '635588420', '#e999', 'Ratke and Kozey');
Commit;
Select * From Vehicle;

-- 6) A new User is added into the database. 
Select * From Users;
START TRANSACTION;
INSERT INTO Users (User_ID,fname, mname, lname, User_Status, E_mail, UserPassword) VALUES (101,'John', '', 'Doe', 'Normal', 'john.doe@example.com', 'password123');
Commit;
Select * From Users;