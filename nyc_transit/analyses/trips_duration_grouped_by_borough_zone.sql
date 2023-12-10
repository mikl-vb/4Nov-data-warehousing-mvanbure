select
    trips.pu_borough,
    trips.pu_zone,
    sum(trips.duration_min) as total_trip_duration_mins,
    avg(trips.duration_min) as avg_trip_duration_mins
from
    {{ ref('mart__fact_trips_by_borough') }} trips
    -- mart__fact_trips_by_borough trips
group by all
order by trips.pu_borough, trips.pu_zone;