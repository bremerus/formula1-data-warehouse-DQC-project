/*
==================================================================
DDL Script: Load Data to Silver Tables
==================================================================
Script purpose:
    This Percedure loads the data from the bronze layer into our silver
    It's Two  main functions are:
        -truncateing the already existing data in the bronze tables
        -inserting the data in the silver tables
Parameteres: None
  this storage precedure does not take any Parameteres
example execution:
    execute silver.load_bronze;
*/


truncate table silver.drivers

insert into silver.drivers (
	driverId,
	driverRef,
	number,
	code,
	forename,
	surname,
	dob,
	nationality,
	url
)

select
	cast(driverId as int) as driverId,
	driverRef,
	case
		when number = '\N' then null
		else cast(number as int)
	end as number,
	case
		when code = '\N' then null
		else code
	end	as code,
	forename,
	surname,
	cast(dob as date) as dob,
	nationality,
	url
from bronze.drivers
