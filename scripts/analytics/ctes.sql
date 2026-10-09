/*
Analytics

*/

--running total point
with running_totals_round as(
	select
		driverId,
		forename,
		raceId,
		race_year,
		points,
		sum(points) over(partition by driverId, race_year order by raceId) as running_total_per_cust_year
	from gold.fact_results
),
ranked as (
	
	select
		*,
		rank() over(partition by driverId, race_year order by running_total_per_cust_year desc) as final_rank
	from running_totals_round 
)

select
	*
from ranked 
where final_rank = 1

/*
	In the CTE I am trying to find the driver with the most total streaks
*/


with info_prev_rank as (
	select
		resultId,
		raceId,
		driverId,
		forename,
		surname,
		race_date,
		position,
		positionText,
		race_round,
		ROW_NUMBER() over(partition by driverId order by race_date) as row_nums_rank
	from gold.fact_results
), podium_only as(
	select
		*,
		ROW_NUMBER() over(partition by driverId order by race_date) as pondium_rank
	from info_prev_rank
	where position in (1 , 2, 3)
), rank_clusters as (
	select
		*,
		row_nums_rank - pondium_rank as clusters
	from podium_only 
), count_clusters as (
	select
		driverId,
		count(clusters) as rounds_in_cluster
	from rank_clusters 
	group by driverId, clusters
)

select
	driverId,
	sum(rounds_in_cluster)
from count_clusters 
where rounds_in_cluster > 1
group by driverId
order by sum(rounds_in_cluster) desc

--This query is about the performance of the driver per season

with avg_per_year as (
	select
		driverId,
		race_year,
		avg(milliseconds) as avg_milisec
	from gold.fact_results
	group by race_year,
		driverId
	
)

select
	*,
	lag(avg_milisec) over(partition by driverId order by driverId, race_year) prev_year_avg,
	case
		when lag(avg_milisec) over(partition by driverId order by driverId, race_year) < avg_milisec then 'Increse'
		when lag(avg_milisec) over(partition by driverId order by driverId, race_year) > avg_milisec then 'Decrease'
		else 'first year'
	end as performance
from avg_per_year 
order by driverId



--moving average for position of last 3 races per season

select
	resultId,
	raceId,
	driverId,
	milliseconds,
	position,
	race_date,
	avg(position) over(partition by driverId order by race_date rows between 2 preceding and current row) as avg_of_last_3
from gold.fact_results
order by driverId, race_year

--Top 3 constructors per season

with cte_const_points_season as (
select
	constructorId,
	constructor_name,
	race_year,
	sum(points) as total_points
from gold.fact_results
group by constructorId,
	constructor_name,
	race_year
), cte_ranks as (
select 
	*,
	dense_rank() over(partition by race_year order by total_points desc) as ranking
from cte_const_points_season 
)

select
	*
from cte_ranks 
where ranking <= 3


--first victory and number of races until that

with cte_ranks as (
	select
		raceId,
		driverId,
		race_date,
		position,
		row_number() over(partition by driverId order by race_date) as seira_agonwn
	from gold.fact_results
), cte_order as (
select
	*,
	ROW_NUMBER() over(partition by driverId order by race_date) as race_order
from cte_ranks
where position = 1
)

select
	driverId,
	race_date,
	seira_agonwn,
	seira_agonwn - 1 as races_until_1
from cte_order 
where race_order = 1

--best point and position difference between 2

with cte_prev as (
	select
		driverId,
		raceId,
		points,
		points - lag(points) over(partition by driverId order by race_date) as diff_previous_point,
		position,
		position - lag(position) over(partition by driverId order by race_date) as diff_previous_position
	from gold.fact_results
)

select
	driverId,
	max(diff_previous_point),
	min(diff_previous_position)
from cte_prev
group by driverId

-- percantage of points per season

with cte_points_per_year as (
	select
		raceId,
		driverId,
		points,
		race_year,
		sum(points) over(partition by race_year) total_points_yearly
	from gold.fact_results
)

select
	raceId,
	driverId,
	points,
	total_points_yearly,
	concat(round((points * 100.0 )/ total_points_yearly, 2), '%') as percentage
from cte_points_per_year 

--Most succesfull constructor per circuit

with cte_num_1 as (
	select
		constructorId,
		constructor_name,
		circuit_name,
		circuit_country,
		position,
		COUNT(constructorId) as total_victories_per_circuit
	from gold.fact_results
	where position = 1
	group by constructorId,
		constructor_name,
		circuit_name,
		circuit_country,
		position
), ranks as (
select
	*,
	rank() over(partition by circuit_name order by total_victories_per_circuit desc) as ranking_victories
from cte_num_1
)

select
	constructorId,
		constructor_name,
		circuit_name,
		circuit_country,
		position,
		total_victories_per_circuit
from ranks
where ranking_victories = 1


