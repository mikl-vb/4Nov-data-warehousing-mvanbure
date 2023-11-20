select
    count(*) as total_trips_ending_at_airports
from 
    mart__fact_all_taxi_trips as taxi_trips
        join 'taxi+_zone_lookup' as zones
        on taxi_trips.dolocationid = zones.locationid
where zones.service_zone in ('Airports', 'EWR')