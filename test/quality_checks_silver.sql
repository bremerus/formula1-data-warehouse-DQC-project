--testing from bronze to silver

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
