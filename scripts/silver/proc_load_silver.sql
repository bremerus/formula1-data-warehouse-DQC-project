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
    execute silver.load_silver;
*/

create or alter procedure silver.load_silver as
begin
	begin try
		declare @start_time datetime, @end_time datetime, @start_batch datetime, @end_batch datetime;
		set @start_batch = getdate();
		print '=============================================';
		print 'Loading Silver Layer';
		print '=============================================';

		set @start_time = getdate();

		print '>> Truncating Table: silver.drivers'
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

		set @end_time = getdate();
		print concat('Load duration ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), ' seconds');
		print '-------------------------------------------------'

		set @start_time = getdate()

		print '>> Truncating Table: silver.races'




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

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: silver.constructors'


		truncate table silver.constructors
		insert into silver.constructors(
			constructorId ,
			constructorRef,
			name ,
			nationality ,
			url 
		)
		select
			cast(constructorId as int) as constructorId,
			trim(replace(constructorRef, '"', '')) as constructorRef,
			trim(replace(name, '"', '')) as name,
			trim(replace(nationality, '"', '')) as nationality,
			trim(replace(url, '"', '')) as url
		from bronze.constructors
		order by cast(constructorId as int)

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: silver.circuits'



		truncate table silver.circuits

		insert into silver.circuits(
			circuitId ,
			circuitRef,
			name,
			location,
			country,
			lat,
			lng,
			alt,
			url
		)
		select
			cast(trim(replace(circuitId, '"', '')) as int) as circuitId,
			trim(replace(circuitRef, '"', '')) as circuitRef,
			trim(replace(name, '"', '')) as name,
			trim(replace(location, '"', '')) as location,
			trim(replace(country, '"', '')) as country,
			cast(trim(replace(lat, '"', '')) as float) as lat,
			cast(trim(replace(lng, '"', '')) as float) as lng,
			cast(trim(replace(alt, '"', '')) as int) as alt,
			trim(replace(url, '"', '')) as url
		from bronze.circuits

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: silver.results'


		truncate table silver.results
		insert into silver.results(
			resultId,
			raceId,
			driverId,
			constructorId,
			number,
			grid,
			position,
			positionText,
			positionOrder,
			points,
			laps,
			time,
			milliseconds,
			fastestLap,
			rank,
			fastestLapTime,
			fastestLapSpeed,
			statusId 
		)
		select
			cast(resultId as int) as resultId,
			cast(raceId as int) as raceId,
			cast(driverId as int) as driverId,
			cast(constructorId as int) as constructorId,
			case 
				when number = '\N' then null
				else cast(trim(replace(number, '"', '')) as int)
			end as number,
			cast(grid as int) as grid,
			case 
				when position = '\N' then null
				else cast(trim(replace(position, '"', '')) as int)
			end as position,
			trim(replace(positionText, '"', '')) as positionText,
			cast(trim(replace(positionOrder, '"', '')) as int) as positionOrder,
			cast(points as float) as points,
			cast(laps as int) as laps,
			case 
				when time = '\N' then null
				else time
			end as time,
			case 
				when milliseconds = '\N' then null
				else cast(trim(replace(milliseconds, '"', '')) as int)
			end as milliseconds,
			case 
				when fastestLap = '\N' then null
				else cast(trim(replace(fastestLap, '"', '')) as int)
			end as fastestLap,
			case 
				when rank = '\N' then null
				else cast(trim(replace(rank, '"', '')) as int)
			end as rank,
			case 
				when fastestLapTime = '\N' then null
				else trim(replace(fastestLapTime, '"', ''))
			end as fastestLapTime,
			case 
				when fastestLapSpeed = '\N' then null
				else cast(trim(replace(fastestLapSpeed, '"', '')) as float)
			end as fastestLapSpeed,
			cast(statusId as int) as statusId
		from bronze.results

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @end_batch = getdate()
		print concat('Load Batch Duration: ', cast(datediff(nanosecond, @start_batch, @end_batch) as nvarchar), 'nanoseconds')


	end try
		begin catch
			print '==============================='
			print 'Error Occured During Loading Bronze Layer'
			print 'Error Message: ' + ERROR_MESSAGE()
			print 'Error Message: ' + cast(ERROR_MESSAGE() as nvarchar)
			print 'Error Message: ' + cast(ERROR_STATE() as nvarchar)
			print '==============================='
		end catch
end

go

exec silver.load_silver
