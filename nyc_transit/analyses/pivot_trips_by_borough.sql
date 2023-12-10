pivot (select
			t.pu_borough,
			count(*) as trips
        -- from mart__fact_trips_by_borough t
		from {{ ref('mart__fact_trips_by_borough') }} t
		group by t.pu_borough)
on pu_borough
using sum(trips)
