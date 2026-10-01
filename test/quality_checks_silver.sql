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
