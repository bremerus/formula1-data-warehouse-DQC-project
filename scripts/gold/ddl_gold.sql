/*

===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the formula warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.
	
	The modifications I added were mainly renaming due to the flexibility givern 
	by the dataset, also there is a view named gold.fact_results that summarizes
	every information that we got in a single table.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================


*/



create view gold.fact_results as
select
	rs.resultId,
	rs.raceId,
	rs.driverId,
	rs.constructorId,
	rs.number,
	rs.grid,
	rs.position,
	rs.positionText,
	rs.positionOrder,
	rs.points,
	rs.laps,
	rs.time,
	rs.milliseconds,
	rs.fastestLap,
	rs.fastestLapSpeed,
	rs.statusId,
	dr.driverRef,
	dr.code as driver_code,
    dr.forename,
    dr.surname,
    dr.date_of_birth,
    dr.nationality as driver_nationality,
    co.constructorRef,
    co.name as constructor_name,
    co.nationality as constructor_nationality,
    ra.year as race_year,
    ra.round as race_round,
    ra.name as race_name,
    ra.date as race_date,
    ci.circuitRef,
    ci.name as circuit_name,
    ci.location as circuit_location,
    ci.country as circuit_country,
    ci.[latitude],
    ci.[longtitude],
    ci.[altitude]
from gold.dim_results as rs
left join gold.dim_drivers as dr
	on rs.driverId = dr.driverId
left join gold.dim_races as ra
	on ra.raceId = rs.raceId
left join gold.dim_constructors as co
	on co.constructorId = rs.constructorId
left join gold.dim_circuits as ci
	on ra.circuitId = ci.circuitId



create view gold.dim_circuits as 
select
	circuitId,
	circuitRef,
	name,
	location,
	country,
	lat as latitude,
	lng as longtitude,
	alt as altitude,
	url
from silver.circuits

create view gold.dim_constructors as
select
	constructorId,
	constructorRef,
	name,
	nationality,
	url
from silver.constructors

create view gold.dim_results as
select
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
from silver.results

create view gold.dim_drivers as 
select
	driverId,
	driverRef,
	number,
	code,
	forename,
	surname,
	dob as date_of_birth,
	nationality,
	url
from silver.drivers

create view gold.dim_races as
select 
	raceId,
	year,
	round,
	circuitId,
	name,
	date,
	time,
	url,
	fp1_date as free_practise_1_date,
	fp1_time as free_practise_1_time,
	fp2_date as free_practise_2_date,
	fp2_time as free_practise_2_time,
	fp3_date as free_practise_3_date,
	fp3_time as free_practise_3_time,
	quali_date as qualifying_date,
	quali_time as qualifying_time,
	sprint_date,
	sprint_time
from silver.races
