select 
    date,
    avg(precipitation) OVER 
        (order by date asc 
        range between INTERVAL 3 DAYS PRECEDING 
        and INTERVAL 3 DAYS FOLLOWING)
        as seven_day_prcp_avg
-- from {{ref('stg__central_park_weather')}};
from staging.stg__central_park_weather;