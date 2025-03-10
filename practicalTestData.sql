﻿-- DROP DATABASE ALEXMARA2022;

CREATE DATABASE ALEXMARA2022;

USE ALEXMARA2022;

CREATE TABLE Marina
(MarinaNum CHAR(4) PRIMARY KEY,
Name varCHAR(20),
Address varCHAR(15),
City varCHAR(15),
State CHAR(2),
Zip CHAR(5) )engine = innodb;

CREATE TABLE Owner
(OwnerNum CHAR(4) PRIMARY KEY,
LastName varCHAR(50),
FirstName varCHAR(20),
Address varCHAR(15),
City varCHAR(15),
State CHAR(2),
Zip CHAR(5),
TotalRental decimal(10,2) )engine = innodb;

CREATE TABLE MarinaSlip
(SlipID integer  PRIMARY KEY,
MarinaNum CHAR(4),
SlipNum CHAR(4),
Length DECIMAL(4,0),
RentalFee DECIMAL(8,2),
BoatName varCHAR(50),
BoatType varCHAR(50),
OwnerNum CHAR(4),
foreign key (MarinaNum) references Marina (MarinaNum),
foreign key (OwnerNum) references Owner (OwnerNum)
)engine = innodb;


CREATE TABLE ServiceCategory
(CategoryNum DECIMAL(4,0) PRIMARY KEY,
CategoryDescription varCHAR(255)
) engine = innodb;


CREATE TABLE ServiceRequest
(ServiceID DECIMAL(4,0) PRIMARY KEY,
SlipID integer ,
CategoryNum DECIMAL(4,0),
Description varCHAR(255),
Status varCHAR(255),
EstHours DECIMAL(4,2),
SpentHours DECIMAL(4,2),
NextServiceDate DATE,
foreign key (SlipID) references MarinaSlip (SlipID),
foreign key (CategoryNum) references ServiceCategory (CategoryNum)
)engine = innodb;


CREATE TABLE FeeHistory
(SlipID integer,
MarinaNum CHAR(4),
ChangeDate DATE,
OldFee DECIMAL,
NewFee DECIMAL,
primary key (SlipID, MarinaNum)
)engine = innodb;

/* Trigger 1 */

CREATE TRIGGER add_fee_history
after insert on MarinaSlip
if change [RentalFee]
	for change in [RentalFee]
		add row [ChangeDate]




/* Trigger 2 */
 
CREATE TRIGGER total_rental_fee
after insert on MarinaSlip
for each row


/* Trigger 3 */
CREATE TRIGGER difference_in_fee
after insert on MarinaSlip
/* Trigger 4 */
CREATE TRIGGER subtract_fee
after insert on MarinaSlip



/* View 1 */

create view LargeSlip as
SELECT MarinaNum, SlipNum, RentalFee, BoatName, Length, OwnerNum FROM MarinaSlip WHERE Length=40;


/* View 2 */

create view MarinaService as
SELECT SlipID, CategoryNum, Description, EstHours, SpentHours FROM ServiceRequest WHERE SpentHours>=5

/* View 3 */

create view TypesOfBoats as
SELECT BoatType, COUNT(*) FROM MarinaSlip GROUP BY BoatType


DROP PROCEDURE ChangeRentalFee

/* Procedure 1 */
delimiter $$
CREATE PROCEDURE ChangeRentalFee 
(CSlipID integer,CRentalFee DECIMAL(8,2))
BEGIN
UPDATE MarinaSlip
SET RentalFee = CRentalFee
WHERE SlipID=CSlipID;
END
$$
delimiter;
CALL ChangeRentalFee ('3',3700);
SELECT SlipID, RentalFee from MarinaSlip WHERE SlipID ='3'


/* Index 1 */

CREATE INDEX BoatIndex ON MarinaSlip(Length,BoatName)



INSERT INTO Marina
VALUES
('1','Alexamara East','108 2nd Ave','Brinman','FL','32273');
INSERT INTO Marina
VALUES
('2','Alexamara Central','283 Branston','W Brinman','FL','32274');
INSERT INTO Owner
VALUES
('AD57','Adney','Bruce and Jean','208 Citrus','Bowton','FL','31313',0);
INSERT INTO Owner
VALUES
('AN75','Anderson','Bill','18 Wilcox','Glander Bay','FL','31044',0);
INSERT INTO Owner
VALUES
('BL72','Blake','Mary','2672 Commodore','Bowton','FL','31313',0);
INSERT INTO Owner
VALUES
('EL25','Elend','Sandy and Bill','462 Riverside','Rivard','FL','31062',0);
INSERT INTO Owner
VALUES
('FE82','Feenstra','Daniel','7822 Coventry','Kaleva','FL','32521',0);
INSERT INTO Owner
VALUES
('JU92','Juarez','Maria','8922 Oak','Rivard','FL','31062',0);
INSERT INTO Owner
VALUES
('KE22','Kelly','Alyssa','5271 Waters','Bowton','FL','31313',0);
INSERT INTO Owner
VALUES
('NO27','Norton','Peter','2811 Lakewood','Lewiston','FL','32765',0);
INSERT INTO Owner
VALUES
('SM72','Smeltz','Becky and Dave','922 Garland','Glander Bay','FL','31044',0);
INSERT INTO Owner
VALUES
('TR72','Trent','Ashton','922 Crest','Bay Shores','FL','30992',0);

INSERT INTO MarinaSlip
VALUES
(1,'1','A1',40,3800.00,'Anderson II','Sprite 4000','AN75');
INSERT INTO MarinaSlip
VALUES
(2,'1','A2',40,3800.00,'Our Toy','Ray 4025','EL25');
INSERT INTO MarinaSlip
VALUES
(3,'1','A3',40,3600.00,'Escape','Sprite 4000','KE22');
INSERT INTO MarinaSlip
VALUES
(4,'1','B1',30,2400.00,'Gypsy','Dolphin 28','JU92');
INSERT INTO MarinaSlip
VALUES
(5,'1','B2',30,2600.00,'Anderson III','Sprite 3000','AN75');
INSERT INTO MarinaSlip
VALUES
(6,'2','1',25,1800.00,'Bravo','Dolphin 25','AD57');
INSERT INTO MarinaSlip
VALUES
(7,'2','2',25,1800.00,'Chinook','Dolphin 22','FE82');
INSERT INTO MarinaSlip
VALUES
(8,'2','3',25,2000.00,'Listy','Dolphin 25','SM72');
INSERT INTO MarinaSlip
VALUES
(9,'2','4',30,2500.00,'Mermaid','Dolphin 28','BL72');
INSERT INTO MarinaSlip
VALUES
(10,'2','5',40,4200.00,'Axxon II','Dolphin 40','NO27');
INSERT INTO MarinaSlip
VALUES
(11,'2','6',40,4200.00,'Karvel','Ray 4025','TR72');

INSERT INTO ServiceCategory
VALUES
(1,'Routine engine maintenance');
INSERT INTO ServiceCategory
VALUES
(2,'Engine repair');
INSERT INTO ServiceCategory
VALUES
(3,'Air conditioning');
INSERT INTO ServiceCategory
VALUES
(4,'Electrical systems');
INSERT INTO ServiceCategory
VALUES
(5,'Fiberglass repair');
INSERT INTO ServiceCategory
VALUES
(6,'Canvas installation');
INSERT INTO ServiceCategory
VALUES
(7,'Canvas repair');
INSERT INTO ServiceCategory
VALUES
(8,'Electronic systems (radar, GPS, autopilots, etc.)');
INSERT INTO ServiceRequest
VALUES
(1,1,3,'Air conditioner periodically stops with code indicating low coolant level. Diagnose and repair.','Technician has verified the problem. Air conditioning specialist has been called.','4','5','2010-07-12');
INSERT INTO ServiceRequest
VALUES
(2,5,4,'Fuse on port motor blown on two occasions. Diagnose and repair.','Open','2','3','2010-07-12');
INSERT INTO ServiceRequest
VALUES
(3,4,1,'Oil change and general routine maintenance (check fluid levels, clean sea strainers etc.).','Service call has been scheduled.','1','2','2010-07-16');
INSERT INTO ServiceRequest
VALUES
(4,1,2,'Engine oil level has been dropping drastically. Diagnose and repair.','Open','2','4','2010-07-13');
INSERT INTO ServiceRequest
VALUES
(5,3,5,'Open pockets at base of two stantions.','Technician has completed the initial filling of the open pockets. Will complete the job after the initial fill has had sufficient time to dry.','4','2','2010-07-13');
INSERT INTO ServiceRequest
VALUES
(6,11,4,'Electric-flush system periodically stops functioning. Diagnose and repair.','Open','3','5','2020-12-31');
INSERT INTO ServiceRequest
VALUES
(7,6,2,'Engine overheating. Loss of coolant. Diagnose and repair.','Open','2','3','2010-07-13');
INSERT INTO ServiceRequest
VALUES
(8,6,2,'Heat exchanger not operating correctly.','Technician has determined that the exchanger is faulty. New exchanger has been ordered.','4','3','2010-07-17');
INSERT INTO ServiceRequest
VALUES
(9,7,6,'Canvas severely damaged in windstorm. Order and install new canvas.','Open','8','6','2010-07-16');
INSERT INTO ServiceRequest
VALUES
(10,2,8,'Install new GPS and chart plotter.','Scheduled','7','5','2010-07-17');
INSERT INTO ServiceRequest
VALUES
(11,2,3,'Air conditioning unit shuts down with HHH showing on the control panel.','Technician not able to replicate the problem. Air conditioning unit ran fine through multiple tests. Owner to notify technician if the problem recurs.','1','4','2020-12-31');
INSERT INTO ServiceRequest
VALUES
(12,4,8,'Both speed and depth readings on data unit are significantly less than the owner thinks they should be.','Technician has scheduled appointment with owner to attempt to verify the problem.','2','1','2010-07-16');
INSERT INTO ServiceRequest
VALUES
(13,8,2,'Customer describes engine as making a clattering sound.','Technician suspects problem with either propeller or shaft and has scheduled the boat to be pulled from the water for further investigation.','5','7','2010-07-12');
INSERT INTO ServiceRequest
VALUES
(14,7,5,'Owner accident caused damage to forward portion of port side.','Technician has scheduled repair.','6','2','2010-07-13');
INSERT INTO ServiceRequest
VALUES
(15,11,7,'Canvas leaks around zippers in heavy rain. Install overlap around zippers to prevent leaks.','Overlap has been created. Installation has been scheduled.','8','5','2010-07-17');
