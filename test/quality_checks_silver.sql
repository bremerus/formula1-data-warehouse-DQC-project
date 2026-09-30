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







--bronze races




select * from bronze.races

