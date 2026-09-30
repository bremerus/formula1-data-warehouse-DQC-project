/*
==================================================================
DDL Script: Load Data to Bronze Tables
==================================================================
Script purpose:
    This Percedure loads the data from the csv Files into our DataBase.
	I modified the insertion due to some string errors.
    It's Two  main functions are:
        -truncateing the al ready existing data in the table
        -inserting the data in the tables
Parameteres: None
  this storage precedure does not take any Parameteres
example execution:
    execute bronze.load_bronze;
*/

create or alter procedure bronze.load_bronze as
begin -- begin procedure
	
	declare @start_time datetime, @end_time datetime, @start_batch datetime, @end_batch datetime;
	
	set @start_batch = getdate()

	begin try
		print '=============================================';
		print 'Loading Bronze Layer';
		print '=============================================';

		set @start_time = getdate()
		print '>> Truncating Table: bronze.drivers'

		truncate table bronze.drivers

		bulk insert bronze.drivers
		from 'C:\Users\user\SQL_projektakia\formula_DW_DQ\drivers.csv'
		with(
			firstrow = 2,
			format = 'CSV',
			fieldquote = '"',
			fieldterminator = ',',
			rowterminator = '0x0a',
			codepage = '65001',
			tablock
		);

		set @end_time = getdate();
		print concat('Load duration ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), ' seconds');
		print '-------------------------------------------------'

		set @start_time = getdate()
		print '>> Truncating Table: bronze.results'


		truncate table bronze.results

		bulk insert bronze.results
		from 'C:\Users\user\SQL_projektakia\formula_DW_DQ\results.csv'
		with(
			firstrow = 2,
			format = 'CSV',
			fieldquote = '"',
			fieldterminator = ',',
			rowterminator = '0x0a',
			codepage = '65001',
			tablock
		);

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: bronze.races'

		truncate table bronze.races

		bulk insert bronze.races
		from 'C:\Users\user\SQL_projektakia\formula_DW_DQ\races.csv'
		with(
			firstrow = 2,
			format = 'CSV',
			fieldquote = '"',
			fieldterminator = ',',
			rowterminator = '0x0a',
			codepage = '65001',
			tablock
		);
		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: bronze.constructors'

		truncate table bronze.constructors

		bulk insert bronze.constructors
		from 'C:\Users\user\SQL_projektakia\formula_DW_DQ\constructors.csv'
		with(
			firstrow = 2,
			format = 'CSV',
			fieldquote = '"',
			fieldterminator = ',',
			rowterminator = '0x0a',
			codepage = '65001',
			tablock
		);

		set @end_time = getdate()
		print concat('Load Duration: ', cast(datediff(nanosecond, @start_time, @end_time) as nvarchar), 'nanoseconds')

		set @start_time = getdate()
		print '>> Truncating Table: bronze.constructors'


		truncate table bronze.circuits

		bulk insert bronze.circuits
		from 'C:\Users\user\SQL_projektakia\formula_DW_DQ\circuits.csv'
		with(
			firstrow = 2,
			format = 'CSV',
			fieldquote = '"',
			fieldterminator = ',',
			rowterminator = '0x0a',
			codepage = '65001',
			tablock
		);

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

end --end procedure

exec bronze.load_bronze
