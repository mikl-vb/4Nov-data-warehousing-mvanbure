with source as (

    select * from {{source('main', 'fhvhv_tripdata') }}

),

-- clean up helped with chatgpt
renamed as (
    select 
        hvfhs_license_num,
        dispatching_base_num,
        originating_base_num,
        request_datetime,
        on_scene_datetime,
        pickup_datetime,
        dropoff_datetime,
        pulocationid AS pu_location_id,
        dolocationid AS do_location_id,
        trip_miles,
        trip_time,
        CASE
            WHEN base_passenger_fare >= 0 THEN base_passenger_fare
            ELSE NULL -- or some other default value if negative values should be replaced rather than set to NULL
        END AS base_passenger_fare, -- negative fares are now ignored
        tolls,
        bcf,
        sales_tax,
        congestion_surcharge,
        airport_fee,
        tips,
        driver_pay,
        CASE WHEN shared_request_flag = 'Y' THEN TRUE
             WHEN shared_request_flag = 'N' THEN FALSE
             ELSE NULL END AS shared_request_flag,
        CASE WHEN shared_match_flag = 'Y' THEN TRUE
             WHEN shared_match_flag = 'N' THEN FALSE
             ELSE NULL END AS shared_match_flag,
        CASE WHEN access_a_ride_flag = 'Y' THEN TRUE
             WHEN access_a_ride_flag = 'N' THEN FALSE
             ELSE NULL END AS access_a_ride_flag,
        CASE WHEN wav_request_flag = 'Y' THEN TRUE
             WHEN wav_request_flag = 'N' THEN FALSE
             ELSE NULL END AS wav_request_flag, 
        CASE WHEN wav_match_flag = 'Y' THEN TRUE
             WHEN wav_match_flag = 'N' THEN FALSE
             ELSE NULL END AS wav_match_flag,
        filename

    from source
)

select * from renamed