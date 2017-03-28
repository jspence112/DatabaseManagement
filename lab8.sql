

CREATE TABLE tblMPAA(
    mpaaNum INT NOT NULL,
	name VARCHAR(100) NOT NULL,
	yearReleased INT NOT NULL
	PRIMARY KEY(mpaaNum),
	UNIQUE(mpaaNUM))
	
CREATE TABLE tblSales(
	mpaaNum INT NOT NULL,
	domesticSalesUSD INT NOT NULL,
	foreignSalesUSD INT NOT NULL,
	DVDSalesUSD INT NOT NULL,
	FOREIGN KEY(mpaaNum))

CREATE TABLE tblDirectors(
	did INT NOT NULL,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(30) NOT NULL,
	address VARCHAR(100) NOT NULL,
	city VARCHAR(30) NOT NULL,
	USstate VARCHAR(30) NOT NULL,
	postalCode INT NOT NULL,
	country VARCHAR(30) NOT NULL,
	spouseFName VARCHAR(30) NOT NULL,
	spouseLName VARCHAR(30) NOT NULL,
	filmSchool	VARCHAR(60) NOT NULL,
	dguildDate DATETIME NOT NULL,
	favLensMaker VARCHAR(60) NOT NULL,
	PRIMARY KEY(did))
)

CREATE TABLE tblActors(
	did INT NOT NULL,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(30) NOT NULL,
	bday DATETIME NOT NULL,
	address VARCHAR(100) NOT NULL,
	city VARCHAR(30) NOT NULL,
	USstate VARCHAR(30) NOT NULL,
	postalCode INT NOT NULL,
	country VARCHAR(30) NOT NULL,
	spouseFName VARCHAR(30) NOT NULL,
	spouseLName VARCHAR(30) NOT NULL
	hairColor VARCHAR(15) NOT NULL,
	eyeColor VARCHAR(15) NOT NULL,
	weightLBS INT NOT NULL,
	favoriteColor VARCHAR(10) NOT NULL,
	PRIMARY KEY(aid)
)

CREATE TABLE tblIMDB(
	imdbID INT NOT NULL,
	mpaaNUM INT NOT NULL,
	did INT NOT NULL,
	aid INT NOT NULL,
	PRIMARY KEY(imdbID),
	FOREIGN KEY(mpaaNUM),
	FOREIGN KEY(did),
	FOREIGN KEY(aid)
)	

Sean Connery Query:
Select tblDirectors.fname, tblDirectors.lname from tblIMDB
WHERE aid.fname = 'Sean' AND aid.lname = 'Connery'; 
