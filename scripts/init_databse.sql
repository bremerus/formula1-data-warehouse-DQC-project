/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
		This script I create a FormulaDataWarehouse after checking if it exists.
		If the database already exists I am droping it and then recreating it,
		also I am creating the schemas 'bronze', 'silver', and 'gold'.

WARNING:
		Running this script will automatically drop all the existing contents of 
		the database and recreate new but EMPTY schemas. Be VERY carefull running 
		this.
*/


use master 

go 

if exists (
	select
		1
	from sys.databases
	where name = 'FormulaDataWarehouse')
	begin
		alter database FormulaDataWarehouse set single_user with rollback immediate
		drop database FormulaDataWarehouse
	end;
go

create database FormulaDataWarehouse

go 

use FormulaDataWarehouse 
go

create schema bronze;
go

create schema silver;
go

create schema gold;
go
