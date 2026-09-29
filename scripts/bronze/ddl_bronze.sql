if object_id('bronze.drivers', 'U') is not null
	drop table bronze.drivers;

go

create table bronze.drivers(
	driverId int,
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
	constructorId int,
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
	circuitId int,
	circuitRef nvarchar(50),
	name nvarchar(50),
	location nvarchar(50),
	country nvarchar(50),
	lat nvarchar(50),
	lng nvarchar(50),
	alt nvarchar(50),
	url nvarchar(50)
)

go

if object_id('bronze.races', 'U') is not null
	drop table bronze.races;

go

create table bronze.races(
	raceId int,
	year nvarchar(50),
	round nvarchar(50),
	circuitId nvarchar(50),
	name nvarchar(50),
	date nvarchar(50),
	time nvarchar(50),
	url nvarchar(50),
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
