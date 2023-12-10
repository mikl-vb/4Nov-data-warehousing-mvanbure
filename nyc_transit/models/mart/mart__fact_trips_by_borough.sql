select 
	trips.type,
    trips.pickup_datetime,
    trips.dropoff_datetime,
	trips.duration_min,
	trips.duration_sec,
	trips.PUlocationID,
	pu_loc.borough pu_borough,
	pu_loc.zone pu_zone,
	pu_loc.service_zone pu_service_zone,
    trips.dolocationid,
	do_loc.Borough do_borough,
	do_loc.zone do_zone,
	do_loc.service_zone do_service_zone
from
	{{ ref('mart__fact_all_taxi_trips') }} trips
	join {{ ref('mart__dim_locations') }} pu_loc
	    on trips.PUlocationID = pu_loc.locationid
    join {{ ref('mart__dim_locations') }} do_loc
        on trips.dolocationid = do_loc.locationid