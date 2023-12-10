-- compare fares of different areas for yellow taxis

select
	yellow.fare_amount,
	loc.Borough as boro,
	avg(yellow.fare_amount) 
		OVER (PARTITION BY boro)
		as boro_avg,
	loc.zone as zone,
	avg(yellow.fare_amount)
		OVER (PARTITION BY ZONE)
		as zone_avg,
	avg(yellow.fare_amount) 
		OVER (PARTITION BY TRUE)
		as all_trips_avg
from
	{{ ref('stg__yellow_tripdata') }} yel
	-- staging.stg__yellow_tripdata yellow 
	inner join
	{{ ref('mart__dim_locations') }} loc
	-- mart__dim_locations loc 
		on yellow.PULocationID = loc.LocationID
GROUP BY yellow.fare_amount, loc.Borough, loc.zone
ORDER BY boro, zone
limit 100;