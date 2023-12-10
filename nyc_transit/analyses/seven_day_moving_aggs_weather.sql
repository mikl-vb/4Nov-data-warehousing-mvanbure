select 
    date,
    avg(precipitation) OVER seven_days as seven_day_prcp_avg,
    min(precipitation) OVER seven_days as seven_day_prcp_min,
    max(precipitation) OVER seven_days as seven_day_prcp_max,
    sum(precipitation) OVER seven_days as seven_day_prcp_sum,
    avg(snow_fall) OVER seven_days as seven_day_snow_avg,
    min(snow_fall) OVER seven_days as seven_day_snow_min,
    max(snow_fall) OVER seven_days as seven_day_snow_max,
    sum(snow_fall) OVER seven_days as seven_day_snow_sum,
from staging.stg__central_park_weather--{{ref('stg__central_park_weather')}}
WINDOW seven_days AS (
    ORDER BY date ASC 
    RANGE BETWEEN INTERVAL 3 DAYS PRECEDING 
    AND INTERVAL 3 DAYS FOLLOWING);