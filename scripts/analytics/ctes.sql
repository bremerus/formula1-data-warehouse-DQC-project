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
