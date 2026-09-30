/*
=========================================================================
DDL Script Create Silver Tables
=========================================================================
Script Purpose:
  It's purpose is to create the tables of the bronze layer, which mainly they look like 
as the bronze layer but there are a few modifications which were made for the better
serving of our goals. Moreover one of the main modifications are changing the types of 
the columns.
*/

if object_id('silver.drivers', 'U') is not null
	drop table silver.drivers;

go

create table silver.drivers(
	driverId int not null primary key,
	driverRef nvarchar(50),
	number int,
	code nvarchar(50),
	forename nvarchar(50),
	surname nvarchar(50),
	dob date,
	nationality nvarchar(50),
	url nvarchar(max),
	dwh_creation_date datetime2 default getdate()
);
go



if object_id('silver.races', 'U') is not null
	drop table silver.races;

go

create table silver.races(
	raceId int,
	year int,
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



=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================
=============================================================================================================================================================







if object_id('silver.constructors', 'U') is not null
	drop table silver.constructors;

go

create table silver.constructors(
	constructorId nvarchar(50),
	constructorRef nvarchar(50),
	name nvarchar(50),
	nationality nvarchar(50),
	url nvarchar(max)
);

go

if object_id('silver.circuits', 'U') is not null
	drop table silver.circuits;

go

create table silver.circuits(
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

if object_id('silver.results', 'U') is not null
	drop table silver.results

go

create table silver.results (
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
