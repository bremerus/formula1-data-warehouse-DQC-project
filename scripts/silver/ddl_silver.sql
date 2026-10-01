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
	raceId int not null primary key,
	year int not null,
	round int not null,
	circuitId int not null,
	name nvarchar(max),
	date date not null,
	time time,
	url nvarchar(max),
	fp1_date date,
	fp1_time time,
	fp2_date date,
	fp2_time time,
	fp3_date date,
	fp3_time time,
	quali_date date,
	quali_time time,
	sprint_date date,
	sprint_time time,
	dwh_creation_date datetime2 default getdate()
)
go

if object_id('silver.constructors', 'U') is not null
	drop table silver.constructors;

go

create table silver.constructors(
	constructorId int not null primary key,
	constructorRef nvarchar(50),
	name nvarchar(50) not null,
	nationality nvarchar(50) not null,
	url nvarchar(max),
	dwh_creation_date datetime2 default getdate()
);

go

if object_id('silver.circuits', 'U') is not null
	drop table silver.circuits;

go

create table silver.circuits(
	circuitId int not null primary key,
	circuitRef nvarchar(50),
	name nvarchar(50),
	location nvarchar(50),
	country nvarchar(50),
	lat float,
	lng float,
	alt int,
	url nvarchar(max),
	dwh_creation_date datetime2 default getdate()
)

go

if object_id('silver.results', 'U') is not null
	drop table silver.results

go

create table silver.results (
	resultId int not null primary key,
	raceId int not null,
	driverId int not null,
	constructorId int not null,
	number int,
	grid int,
	position int,
	positionText nvarchar(50),
	positionOrder int,
	points float,
	laps int,
	time nvarchar(50),
	milliseconds int,
	fastestLap int,
	rank int,
	fastestLapTime nvarchar(50),
	fastestLapSpeed float,
	statusId int,
	dwh_creation_date datetime2 default getdate()
)
