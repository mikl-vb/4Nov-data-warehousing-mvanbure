with source as (

    select * from {{source('main', 'fhv_tripdata') }}

),

-- cleaning helped with chatgpt
-- asked to provide dbt file in clean format based on case values from data source
renamed as (
    select 
        -- Assuming the base numbers are alphanumeric, we'll just trim whitespace
        TRIM(dispatching_base_num) AS dispatching_base_num,
        TRIM(Affiliated_base_number) AS affiliated_base_number,
        
        -- Timestamps should be fine, but we might want to handle any potential invalid dates
        -- using a dbt macro or custom SQL logic if needed.
        pickup_datetime,
        dropOff_datetime,

        -- Location IDs should be integers, cast them if they are not already.
        -- Also, handle any potential invalid IDs (like negative values)
        NULLIF(PUlocationID, '')::INT AS PUlocationID,
        NULLIF(DOlocationID, '')::INT AS DOlocationID,
        
        -- SR_Flag is already an INTEGER, so just include as is.
        -- You could add validation or transformation logic here if needed.
        SR_Flag,
        
        -- Clean the filename if needed, or leave as is
        TRIM(filename) AS filename

    from source
)

select * from renamed