/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
		This script I create a FormulaDataWarehouse after checking if it exists.
		If the database already exists I am droping it and then recreating it,
		also I am creating the schemas 'bronze', 'silver', and 'gold'.

WARNING:
		Running this script will automatically drop all the existing contents of 
		the database and recreate new but EMPTY schemas. Be VERY carefull running 
		this.
*/

if object_id('bronze.drivers', 'U') is not null
	drop table bronze.drivers;

go

create table bronze.drivers(
	driverId nvarchar(50),
	driverRef nvarchar(50),
	number nvarchar(50),
	code nvarchar(50),
	forename nvarchar(50),
	surname nvarchar(50),
	dob nvarchar(50),
	nationality nvarchar(50),
	url nvarchar(max)
);
go

if object_id('bronze.constructors', 'U') is not null
	drop table bronze.constructors;

go

create table bronze.constructors(
	constructorId nvarchar(50),
	constructorRef nvarchar(50),
	name nvarchar(50),
	nationality nvarchar(50),
	url nvarchar(max)
);

go

if object_id('bronze.circuits', 'U') is not null
	drop table bronze.circuits;

go

create table bronze.circuits(
	circuitId nvarchar(50),
	circuitRef nvarchar(50),
	name nvarchar(50),
	location nvarchar(50),
	country nvarchar(50),
	lat nvarchar(50),
	lng nvarchar(50),
	alt nvarchar(50),
	url nvarchar(max)
)

go

if object_id('bronze.races', 'U') is not null
	drop table bronze.races;

go

create table bronze.races(
	raceId nvarchar(50),
	year nvarchar(50),
	round nvarchar(50),
	circuitId nvarchar(50),
	name nvarchar(max),
	date nvarchar(50),
	time nvarchar(50),
	url nvarchar(max),
	fp1_date nvarchar(50),
	fp1_time nvarchar(50),
	fp2_date nvarchar(50),
	fp2_time nvarchar(50),
	fp3_date nvarchar(50),
	fp3_time nvarchar(50),
	quali_date nvarchar(50),
	quali_time nvarchar(50),
	sprint_date nvarchar(50),
	sprint_time nvarchar(50)
)

go

if object_id('bronze.results', 'U') is not null
	drop table bronze.results

go

create table bronze.results (
	resultId nvarchar(50),
	raceId nvarchar(50),
	driverId nvarchar(50),
	constructorId nvarchar(50),
	number nvarchar(50),
	grid nvarchar(50),
	position nvarchar(50),
	positionText nvarchar(50),
	positionOrder nvarchar(50),
	points nvarchar(50),
	laps nvarchar(50),
	time nvarchar(50),
	milliseconds nvarchar(50),
	fastestLap nvarchar(50),
	rank nvarchar(50),
	fastestLapTime nvarchar(50),
	fastestLapSpeed nvarchar(50),
	statusId nvarchar(50)
)
