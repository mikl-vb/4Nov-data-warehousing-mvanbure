with all_trips as (
    select 
        weekday(pickup_datetime) as weekday,
        count(*) trips
    from mart__fact_all_taxi_trips
    group by all
), 

inter_borough as (
    select 
        weekday(pickup_datetime) as weekday,
        count(*) as trips
    from mart__fact_all_taxi_trips mart1
    join mart__dim_locations mart_pu on mart1.PULocationID =  mart_pu.LocationID
    join mart__dim_locations mart_dl on mart1.PULocationID = mart_dl.LocationID
    where mart_pu.borough != mart_dl.borough
    group by all
)

select 
    all_trips.weekday,
    all_trips.trips as all_trips,
    inter_borough.trips as inter_borough_trips,
    inter_borough.trips / all_trips.trips as percentage_inter_borough
from all_trips
join inter_borough on all_trips.weekday = inter_borough.weekday