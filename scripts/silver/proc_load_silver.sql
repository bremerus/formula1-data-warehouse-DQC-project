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
	trim(replace(driverRef, '"','')) as driverRef,
	case
		when number = '\N' then null
		else cast(number as int)
	end as number,
	case
		when trim(replace(code, '"','')) = '\N' then null
		else trim(replace(code, '"',''))
	end	as code,
	trim(replace(forename, '"', ''))as forename,
	trim(replace(surname, '"', '')) as surname,
	cast(trim(replace(dob, '"', '')) as date) as dob,
	trim(replace(nationality, '"', '')),
	trim(replace(url, '"', '')) as url
from bronze.drivers
