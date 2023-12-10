with pu_diff as (
    SELECT 
    zone,
    date_diff('minute', 
                pickup_datetime, 
                LEAD(pickup_datetime, 1)
                OVER (PARTITION BY zone ORDER BY pickup_datetime ASC))
        as pu_diff_mins
    from {{ref('mart__fact_all_taxi_trips')}} taxi 
    inner join {{ref('mart__dim_locations')}} locs_pu 
    on taxi.pulocationid=locs_pu.locationid 
    where zone='Bloomingdale' --added to circumvent OOM error
)
SELECT 
zone,
avg(pu_diff_mins) as avg_mins_between_pickups
from pu_diff
group by zone;