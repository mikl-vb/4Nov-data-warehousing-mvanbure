with source as (

    select * from {{source('main', 'bike_data') }}

),

-- cleaning helped with chatgpt
renamed as (
    select 
        tripduration::bigint as trip_duration_mins,
        coalesce(starttime, started_at)::timestamp as trip_start_datetime,
        coalesce(stoptime, ended_at)::timestamp as trip_end_datetime,
        start_station_id::int, 
        start_station_name::int,
        
        -- could not get working
        -- coalesce("start station latitude", start_lat)::double as start_latitude,
        -- coalesce("start station longitue", start_lng)::double as start_longitude,
        
        -- "start station latitude" as start_lat,
        -- "start station longitue" as start_long,
        
        end_station_id, 
        end_station_name,

        -- could not get working
        -- coalesce("end station latitude", end_lat)::double as end_latitude,
        -- coalesce("end station longitude", end_lng)::double as end_longitude,
        
        -- "end station latitude" as end_lat,
        -- "end station longitude" as eng_long,

        
        bikeid as bike_id,
        usertype as user_type,
        "birth year"::int as user_birth_year,
        case cast(gender as int) 
                when gender = 0 then 'unknown'
                when gender = 1 then 'male'
                when gender = 2 then 'female'
                else null
        end as user_gender,
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        case usertype
                --standardize as lower in case there is any variance
                when lower(usertype) = 'subscriber' then 'annual_member' 
                when lower(usertype) = 'customer' then 'casual_customer'
                else null
        end as member_type,
        filename

    from source
)

select * from renamed