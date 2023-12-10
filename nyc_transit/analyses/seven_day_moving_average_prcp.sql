-- find moving avg of precipitation for central park

select 
    date,
    AVG(prcp) OVER (
        ORDER BY date
        RANGE BETWEEN INTERVAL 3 DAYS PRECEDING AND INTERVAL 3 DAYS FOLLOWING
    ) AS seven_day_moving_avg_prcp
from {{ ref('stg__central_park_weather') }} wx
-- from staging.stg__central_park_weather 
limit 100;