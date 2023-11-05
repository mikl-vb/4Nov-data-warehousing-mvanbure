with source as (

    select * from {{source('main', 'yellow_tripdata') }}

),

-- cleaning helped with chatgpt
-- asked to provide dbt file in clean format based on case values from data source
-- definitions from: https://www.nyc.gov/assets/tlc/downloads/pdf/data_dictionary_trip_records_yellow.pdf
renamed as (
    select 
        vendorid as vendor_id,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        -- can't have more than 5 people in taxi or less than 0
        case cast(passenger_count as int)
            when passenger_count > 5
                then null
            when passenger_count < 0
                then null
            else passenger_count
        end as passenger_count, 
        CASE 
            WHEN trip_distance < 0 
                THEN NULL 
            ELSE trip_distance 
        END AS trip_distance,
        case cast(ratecodeid as INTEGER)
            WHEN 1 THEN 'Standard rate'
            WHEN 2 THEN 'JFK'
            WHEN 3 THEN 'Newark'
            WHEN 4 THEN 'Nassau or Westchester'
            WHEN 5 THEN 'Negotiated fare'
            WHEN 6 THEN 'Group ride'
            ELSE 'Other'
        END AS ratecode_description,
        CASE
            WHEN store_and_fwd_flag = 'Y' THEN TRUE
            WHEN store_and_fwd_flag = 'N' THEN FALSE
            ELSE NULL -- or you can decide how you want to treat other or NULL values
        END AS store_and_fwd_flag,
        pulocationid as pu_location_id,
        dolocationid as do_location_id,
        CASE cast(payment_type as integer)
            WHEN 1 THEN 'Credit card'
            WHEN 2 THEN 'Cash'
            WHEN 3 THEN 'No charge'
            WHEN 4 THEN 'Dispute'
            WHEN 5 THEN 'Unknown'
            WHEN 6 THEN 'Voided trip'
            ELSE 'null'
        END AS payment_type_description,
        CASE 
            WHEN fare_amount < 0 
                THEN NULL 
            ELSE fare_amount 
        END AS fare_amount,
        CASE 
            WHEN extra < 0 
                THEN NULL 
            ELSE extra 
        END AS extra,
        CASE 
            WHEN mta_tax < 0 
                THEN NULL 
            ELSE mta_tax 
        END AS mta_tax,
        CASE 
            WHEN tip_amount < 0 
                THEN NULL 
            ELSE tip_amount 
        END AS tip_amount,
        CASE 
            WHEN tolls_amount < 0 
                THEN NULL 
            ELSE tolls_amount 
        END AS tolls_amount,
        CASE 
            WHEN improvement_surcharge < 0 
                THEN NULL 
            ELSE improvement_surcharge 
        END AS improvement_surcharge,
        CASE 
            WHEN total_amount < 0 
                THEN NULL 
            ELSE total_amount 
        END AS total_amount,
        CASE 
            WHEN congestion_surcharge < 0 
                THEN NULL 
            ELSE congestion_surcharge 
        END AS congestion_surcharge, 
        CASE 
            WHEN airport_fee < 0 
                THEN NULL 
            ELSE airport_fee 
        END AS airport_fee,
        filename

    from source
)

select * from renamed