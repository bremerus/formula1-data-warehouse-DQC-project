--testing from bronze to silver

													--bronze drivers

--check for duplicates of any column and nulls as " \N "
select top 100 
	driverId,
	count (driverRef)
from bronze.drivers
group by driverId
having count (driverRef) > 1 or driverId = '\N'

--No unwanted spaces detected in any varchar of any column 
select 
	url
from bronze.drivers
where len(url) != len(trim(url))

--check for unwanted "
SELECT driverRef, forename, surname
FROM silver.drivers
WHERE forename LIKE '%"%';

--check for codes less than 3 chars
select
	code
from bronze.drivers
where len(code) > 3 or code is null

--check for age legitimacy
select
	*
from bronze.drivers
where cast(dob as date) > '2008-01-01'




													--bronze races

select
	distinct time
from bronze.races

-- check for valid year
select
	*
from bronze.races
where year < 1950

--check for valid round number
select
	*
from bronze.races
where round <= 0

													--bronze constructors


select * from bronze.constructors

select
	*
from bronze.constructors
where constructorId = '\N'

select
	*
from bronze.constructors
where constructorRef != trim(constructorRef)


													--bronze circuits
select * from bronze.circuits

--check for nulls in any field
select
	*
from bronze.circuits
where name = '\N' or circuitId = '\N' or circuitRef= '\N' or location = '\N' or	country	 = '\N' or lat = '\N' or lng = '\N' or alt= '\N' or	url = '\N' 


--check for valid lng and lat values
select
	*
from bronze.circuits
where not ((cast(lat as float) between -90.0 and 90.0)  or (cast(lng as float) between -189.0 and 180.0) or cast(alt as int) < 3000)


														-- bronze results
select * from bronze.results

select 
distinct fastestLapSpeed
from bronze.results
where fastestLapSpeed = '\N'

select
	*
from bronze.results
where laps < 0 AND grid < 0

select
	*
from bronze.results
where not(case 
		when fastestLapSpeed = '\N' then null
		else cast(trim(replace(fastestLapSpeed, '"', '')) as float)
	end < 265.0)

select
	distinct fastestLapTime
from bronze.results
where fastestLapTime = '\N'
