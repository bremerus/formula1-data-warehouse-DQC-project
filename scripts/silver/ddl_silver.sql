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
	driverId int,
	driverRef nvarchar(50),
	number int,
	code nvarchar(50),
	forename nvarchar(50),
	surname nvarchar(50),
	dob date,
	nationality nvarchar(50),
	url nvarchar(max)
);
go

