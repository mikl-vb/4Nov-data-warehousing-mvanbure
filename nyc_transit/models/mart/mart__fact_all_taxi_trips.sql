with trips_renamed as (
  select
    'Yellow' as type,
    tpep_pickup_datetime as pickup_datetime,
    tpep_dropoff_datetime as dropoff_datetime,
    date_diff('minute', tpep_pickup_datetime, tpep_dropoff_datetime) as duration_min,
    date_diff('second', tpep_pickup_datetime, tpep_dropoff_datetime) as duration_sec,
    pulocationid,
    dolocationid
  from {{ ref('stg__yellow_tripdata') }}
  union all    
  select
    'Green' as type,
    lpep_pickup_datetime as pickup_datetime,
    lpep_dropoff_datetime as dropoff_datetime,
    date_diff('minute', lpep_pickup_datetime, lpep_dropoff_datetime) as duration_min,
    date_diff('second', lpep_pickup_datetime, lpep_dropoff_datetime) as duration_sec,
    pulocationid,
    dolocationid
  from {{ ref('stg__green_tripdata') }}
  union all
  select
    'FHV' as type,
    pickup_datetime,
    dropoff_datetime,
    date_diff('minute', pickup_datetime, dropoff_datetime) as duration_min,
    date_diff('second', pickup_datetime, dropoff_datetime) as duration_sec,
    pulocationid,
    dolocationid
  from {{ ref('stg__fhv_tripdata') }}
  union all
  select
    'FHVHV' as type,
    pickup_datetime,
    dropoff_datetime,
    date_diff('minute', pickup_datetime, dropoff_datetime) as duration_min,
    date_diff('second', pickup_datetime, dropoff_datetime) as duration_sec,
    pulocationid,
    dolocationid
  from {{ ref('stg__fhvhv_tripdata') }}
)

  select
    type,
    pickup_datetime,
    dropoff_datetime,
    date_diff('minute', pickup_datetime, dropoff_datetime) as duration_min,
    date_diff('second', pickup_datetime, dropoff_datetime) as duration_sec,
    pulocationid,
    dolocationid
  from trips_renamed