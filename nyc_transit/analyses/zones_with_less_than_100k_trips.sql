select
    t.pu_zone,
    count(*) AS trips
from
    {{ ref('mart__fact_trips_by_borough') }} t
group by all
HAVING trips < 100000