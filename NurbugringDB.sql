


DROP TABLE IF EXISTS Test_Org cascade;
DROP TABLE IF EXISTS Independent_Test_Org cascade;
DROP TABLE IF EXISTS Automotive_Press cascade;
DROP TABLE IF EXISTS Driver cascade;
DROP TABLE IF EXISTS Independent_Owner cascade;
DROP TABLE IF EXISTS Parent_Company cascade;
DROP TABLE IF EXISTS Brand cascade;
DROP TABLE IF EXISTS Motor cascade;
DROP TABLE IF EXISTS Tire cascade;
DROP TABLE IF EXISTS Transmission cascade;
DROP TABLE IF EXISTS Car cascade;
DROP TABLE IF EXISTS Lap cascade;
DROP TABLE IF EXISTS LapRecord cascade;
DROP TYPE IF EXISTS motor_type_type;
DROP TYPE IF EXISTS motor_config_type;
DROP TYPE IF EXISTS transtype_type;
DROP TYPE IF EXISTS driven_wheels_type;


/*Table Create Statements */
CREATE TABLE Test_Org(
TestOrgid		INT NOT NULL UNIQUE,
PRIMARY KEY(TestOrgid)
);

CREATE TABLE Independent_Test_Org(
TestOrgid		INT NOT NULL UNIQUE REFERENCES Test_Org(TestOrgid),
PRIMARY KEY(TestOrgid)
);

CREATE TABLE Automotive_Press(
TestOrgid		INT NOT NULL UNIQUE REFERENCES Independent_Test_Org(TestOrgid),
Press_Name		TEXT NOT NULL,
PRIMARY KEY(TestOrgid)
);

CREATE TABLE Driver(
Driverid		INT NOT NULL UNIQUE,
FirstName		TEXT NOT NULL,
LastName		TEXT NOT NULL,
Nationality		TEXT NOT NULL,
PRIMARY KEY(Driverid)
);

CREATE TABLE Independent_Owner(
TestOrgid		INT  NOT NULL UNIQUE REFERENCES Independent_Test_Org(TestOrgid),
FirstName		TEXT NOT NULL,
LastName		TEXT NOT NULL,
Driverid		INT REFERENCES Driver(Driverid),
PRIMARY KEY(TestOrgid)
);

CREATE TABLE Parent_Company (
  Parentid			INT NOT NULL UNIQUE,
  Parent_Name		TEXT NOT NULL,
  TestOrgid			INT UNIQUE REFERENCES Test_Org(TestOrgid),
  PRIMARY KEY(Parentid)
);

CREATE TABLE Brand (
  Brandid		INT NOT NULL UNIQUE,
  Parentid		INT NOT NULL REFERENCES Parent_Company(Parentid),
  Brand_Name	TEXT NOT NULL,
  PRIMARY KEY(Brandid)
);

CREATE TYPE motor_type_type AS ENUM ('Piston', 'Rotary', 'Electric', 'Other');
CREATE TYPE motor_config_type AS ENUM('H4', 'H6', 'I4', 'I6', 'V4', 'V8', 'V10',
						'V12', 'W8', 'W12', 'V16', 'other', 'N/A');
CREATE TABLE Motor (
  Motorid 			INT NOT NULL UNIQUE,
  Motor_Type    	motor_type_type NOT NULL,
  HorsepowerBHP 	SMALLINT NOT NULL CHECK(HorsepowerBHP > 0),
  Torque_lb_ft		SMALLINT NOT NULL CHECK(Torque_lb_ft > 0),
  Turbocharged  	BOOLEAN NOT NULL,
  Supercharged		BOOLEAN NOT NULL,
  Motor_Config 		motor_config_type NOT NULL,
  PRIMARY KEY(Motorid)
);

CREATE TABLE Tire (
  Tireid			INT NOT NULL UNIQUE,
  model				TEXT NOT NULL,
  YearIntroduced    SMALLINT NOT NULL CHECK(YearIntroduced > 1900),
  Treadwear_Rating	SMALLINT NOT NULL,
  Speed_Rating		TEXT NOT NULL,
  PRIMARY KEY(Tireid)
);

CREATE TYPE transtype_type AS ENUM ('double clutch', 'single clutch', 'torque-converter',
							'direct drive', 'manual', 'other');
CREATE TABLE Transmission (
  Transid				INT NOT NULL UNIQUE,
  TransType				transtype_type NOT NULL,
  Num_Gears				SMALLINT NOT NULL CHECK (Num_Gears > 0),
  PRIMARY KEY(Transid)
);

CREATE TYPE driven_wheels_type AS ENUM ('front', 'rear', 'all', 'other');
CREATE TABLE Car (
  Carid 			INT NOT NULL UNIQUE,
  Brandid 			INT NOT NULL REFERENCES Brand(Brandid),
  Model_Name 		TEXT NOT NULL,
  Secondary_Name	TEXT,
  Model_Year 		SMALLINT NOT NULL CHECK(Model_Year > 1900),
  Weightlbs  		INT NOT NULL CHECK(Weightlbs > 0),
  Base_PriceUSD 	INT NOT NULL,
  Driven_Wheels 	driven_wheels_type NOT NULL,
  Tireid 			INT NOT NULL REFERENCES Tire(Tireid),
  Motorid 			INT NOT NULL REFERENCES Motor(Motorid),
  Transid 			INT NOT NULL REFERENCES Transmission(Transid),
  PRIMARY KEY(Carid)
);

CREATE TABLE Lap(
Lapid				INT NOT NULL UNIQUE,
LapTimeSeconds		SMALLINT NOT NULL CHECK(LapTimeSeconds > 0),
LapDate				date NOT NULL CHECK(LapDate > '1900-01-01'),
LapVideoLink		TEXT,
LapLengthFeet		INT NOT NULL CHECK(LapLengthFeet > 0),
Fastest				BOOLEAN NOT NULL,
PRIMARY KEY(Lapid)
);

CREATE TABLE LapRecord(
TestOrgid		INT NOT NULL REFERENCES Test_Org(TestOrgid),
Lapid			INT NOT NULL UNIQUE REFERENCES Lap(Lapid),
Driverid		INT NOT NULL REFERENCES Driver(Driverid),
Carid			INT NOT NULL UNIQUE REFERENCES Car(Carid),
Notes			TEXT,
PRIMARY KEY(Carid)
);

/*Insert Statements */
Insert INTO Driver VALUES(0, 'Alan', 'Labouseur', 'American'),
						 (1, 'Marco', 'Mapelli', 'Italian'),
						 (2, 'Horst', 'Saurma', 'German');

INSERT INTO Test_Org VALUES(0),(1),(2);

INSERT INTO Independent_Test_Org VALUES(1), (2);
						 
Insert INTO Automotive_Press VALUES(2, 'Sport Auto');

INSERT INTO Independent_Owner VALUES(1, 'Alan', 'Labouseur', 0);

INSERT INTO Parent_Company VALUES(0, 'Fiat', NULL),
								 (1, 'Volkswagen Auto Group', 0);
						   
Insert Into Brand VALUES(0, 0, 'Ferrari'),
						(1, 1, 'Lamborghini');
						
INSERT INTO Motor VALUES(0, 'Piston', 550, 500, FALSE, FALSE, 'V8'),
						(1, 'Piston', 640, 490, FALSE, False, 'V10'),
						(2, 'Electric', 650, 700, FALSE, FALSE, 'N/A');

INSERT INTO Tire VALUES(0, 'Pirelli', 2014, 60, 'V'),
					   (1, 'Michelin', 2017, 300, 'H'),
					   (2, 'Bridgestone', 2009, 150, 'Y');
					   
INSERT INTO Transmission VALUES(0, 'double clutch', 7),
							   (1, 'direct drive', 1),
							   (2, 'manual', 6);
							   
INSERT INTO Car VALUES(0, 0, '458', 'italia', '2015',
						3100, 300000, 'rear', 0, 0, 0),
						(1, 0, '458', 'speciale', '2016',
						3000, 400000, 'rear', 2, 2, 2),
						(2, 1, 'huracan', 'performante',
						'2017', 3400, 415000, 'all', 1, 1, 1);
						
INSERT INTO Lap	VALUES(0, 410, '2017-03-05', 'https://www.youtube.com/watch?v=6ULSUcERlQQ',
					   67600, TRUE),
					  (1, 440, '2016-06-11', 'https://www.youtube.com/watch?v=5gEdJmIVqLY',
					  67600, FALSE),
					  (2, 445, '2015-8-01', NULL, 68346, FALSE);						
						
INSERT INTO LapRecord VALUES(1, 0, 0, 1, 'What amazing driving skills!'),
							(0, 1, 1, 0, NULL),
							(2, 2, 2, 2, Null);


							
							
/* Security User Roles */							
CREATE ROLE DBA;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC TO DBA;

CREATE ROLE Viewer;
REVOKE ALL ON ALL TABLES IN SCHEMA PUBLIC FROM Viewer;
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO Viewer;


/* Views */
CREATE VIEW MainTable AS
SELECT LapTimeSeconds, Brand_Name, Model_Name, Secondary_Name
FROM Brand, Car, Lap, LapRecord
Where Car.Brandid = Brand.Brandid AND Lap.lapid=LapRecord.lapid
AND LapRecord.Carid = Car.Carid
ORDER BY LapTimeSeconds ASC;

SELECT * FROM MainTable;

CREATE View VideoTable AS
SELECT LapTimeSeconds, Brand_Name, Model_Name, Secondary_Name, LapVideoLink
FROM Brand, Car, Lap, LapRecord
Where Car.Brandid = Brand.Brandid AND Lap.lapid=LapRecord.lapid
AND LapRecord.Carid = Car.Carid AND LapVideoLink IS NOT NULL
ORDER BY LapTimeSeconds ASC;

SELECT * FROM VideoTable;

/* Stored Procedures */
CREATE OR REPLACE FUNCTION recordSearchByCarNames(TEXT,TEXT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   NameOne 	  TEXT       := $1;
   NameTwo 	  TEXT	 	 := $2;
   resultset  REFCURSOR  := $3;
BEGIN
   OPEN resultset FOR 
      SELECT LapTimeSeconds, Brand_Name, Model_Name, Secondary_Name
      FROM   Brand, Car, Lap, LapRecord
      WHERE  Car.Brandid = Brand.Brandid AND Lap.lapid=LapRecord.lapid
AND LapRecord.Carid = Car.Carid AND Model_Name=NameOne AND Secondary_Name=NameTwo;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

SELECT recordSearchByCarNames('458', 'italia', 'results');
FETCH ALL FROM results;

CREATE OR REPLACE FUNCTION recordSearchByMaxTime(INT, REFCURSOR) RETURNS refcursor AS 
$$
DECLARE
   MaxTime     INT	     := $1;
   resultset   REFCURSOR := $2;
BEGIN
   OPEN resultset FOR 
      SELECT LapTimeSeconds, Brand_Name, Model_Name, Secondary_Name
      FROM   Brand, Car, Lap, LapRecord
      WHERE  Car.Brandid = Brand.Brandid AND Lap.lapid=LapRecord.lapid
AND LapRecord.Carid = Car.Carid AND LapTimeSeconds<=MaxTime;
   RETURN resultset;
END;
$$ 
LANGUAGE plpgsql;

SELECT recordSearchByMaxTime(430, 'results');
FETCH ALL FROM results;
EXECUTE PROCEDURE

/* Triggers */

CREATE OR REPLACE FUNCTION fastestLap() RETURNS TRIGGER AS
$$
BEGIN
IF NEW.LapTimeSeconds <=
	(SELECT LapTimeSeconds
	FROM Lap
	ORDER BY LapTimeSeconds ASC
	Limit 1)
THEN
	UPDATE Lap
	SET Fastest = TRUE
	WHERE Lap.lapid=New.lapid;
	END IF;
	RETURN NEW;
	END;
$$LANGUAGE plpgsql;

CREATE TRIGGER fastestLap
After INSERT ON Lap
FOR EACH ROW
EXECUTE PROCEDURE fastestLap();

CREATE OR REPLACE FUNCTION lastFastestLap() RETURNS TRIGGER AS
$$
BEGIN
IF (Select Fastest
	From Lap
	Order by LapTimeSeconds ASC
	Limit 1) = True
	AND
	(Select Fastest
	From Lap
	Order by LapTimeSeconds ASC
	Offset 1
	Limit 1) = True 
THEN
	UPDATE Lap
	SET Fastest = False
	WHERE Lap.lapid=(Select Lapid
					From Lap
					Order by LapTimeSeconds ASC
					Offset 1
					Limit 1);
	END IF;
	RETURN NEW;
	END;
$$LANGUAGE plpgsql;

CREATE TRIGGER lastFastestLap
After INSERT ON Lap
FOR EACH ROW
EXECUTE PROCEDURE fastestLap();

/*Sample Reports */
SELECT Brand_Name, Model_Name, Secondary_Name, Motor_Type, HorsepowerBHP, Torque_lb_ft,
		Turbocharged, Supercharged, Motor_Config
		FROM Brand, Car, Motor
		WHERE Brand.Brandid=Car.Brandid AND Motor.Motorid=Car.Motorid;
		
Select Independent_Owner.FirstName, Independent_Owner.LastName, Model_Name, Secondary_Name, Base_PriceUSD
	   FROM Independent_Owner, Car, LapRecord, Test_Org, Independent_Test_Org
	   WHERE Car.Carid=LapRecord.Carid AND LapRecord.TestOrgid=Test_Org.TestOrgid
	   AND Test_Org.TestOrgid=Independent_Test_Org.TestOrgid
	   AND Independent_Test_Org.TestOrgid=Independent_Owner.TestOrgid;
	
Select Press_Name, Brand_Name, Model_Name,
		Secondary_Name
		FROM Brand, Car, LapRecord, Test_Org, Independent_Test_Org, Automotive_Press
		WHERE Car.Brandid=Brand.Brandid
		AND Car.Carid=LapRecord.Carid
		AND LapRecord.TestOrgid=Test_Org.TestOrgid
		AND TEST_ORG.TestOrgid=Independent_Test_Org.TestOrgid
		AND Independent_Test_Org.TestOrgid= Automotive_Press.TestOrgid;