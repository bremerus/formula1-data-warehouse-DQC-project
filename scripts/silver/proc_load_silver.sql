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
order by cast(driverId as int)





truncate table silver.races
insert into silver.races(
	raceId,
	year ,
	round ,
	circuitId ,
	name ,
	date ,
	time ,
	url ,
	fp1_date ,
	fp1_time ,
	fp2_date ,
	fp2_time ,
	fp3_date ,
	fp3_time ,
	quali_date ,
	quali_time ,
	sprint_date,
	sprint_time
)
select 
	cast(trim(replace(raceId, '"', '')) as int) as raceId,
	cast(trim(replace(year, '"', '')) as int) as year,
	cast(trim(replace(round, '"', '')) as int) as round,
	cast(trim(replace(circuitid, '"', '')) as int) as circuitid,
	trim(replace(name, '"', '')) as name,
	case
		when date = '\N' then null
		else cast(trim(replace(date, '"', '')) as date)
	end as date,
	case
		when time = '\N' then null
		else cast(trim(replace(time, '"', '')) as time)
	end as time,
	trim(replace(url, '"', '')) as url,

	case
		when fp1_date = '\N' then null
		else cast(trim(replace(fp1_date, '"', '')) as date)
	end as fp1_date,
	case
		when fp1_time = '\N' then null
		else cast(trim(replace(fp1_time, '"', '')) as time)
	end as fp1_time,
	case
		when fp2_date = '\N' then null
		else cast(trim(replace(fp2_date, '"', '')) as date)
	end as fp2_date,
	case
		when fp2_time = '\N' then null
		else cast(trim(replace(fp2_time, '"', '')) as time)
	end as fp2_time,
	case
		when fp3_date = '\N' then null
		else cast(trim(replace(fp3_date, '"', '')) as date)
	end as fp3_date,
	case
		when fp3_time = '\N' then null
		else cast(trim(replace(fp3_time, '"', '')) as time)
	end as fp3_time,
	case
		when quali_date = '\N' then null
		else cast(trim(replace(quali_date , '"', '')) as date)
	end as quali_date,
	case
		when quali_time = '\N' then null
		else cast(trim(replace(quali_time, '"', '')) as time)
	end as quali_time,
	case
		when sprint_date = '\N' then null
		else cast(trim(replace(sprint_date , '"', '')) as date)
	end as sprint_date,
	case
		when sprint_time = '\N' then null
		else cast(trim(replace(sprint_time, '"', '')) as time)
	end as sprint_time
from bronze.races
