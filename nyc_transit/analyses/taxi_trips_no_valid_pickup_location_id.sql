select 
	trips.*
from
	{{ ref('mart__fact_all_taxi_trips') }} trips
	-- mart__fact_all_taxi_trips trips
	left join
	{{ ref('mart__dim_locations') }} locs
	-- mart__dim_locations locs
		on trips.pulocationid = locs.locationid
where locs.locationid is null
limit 1000