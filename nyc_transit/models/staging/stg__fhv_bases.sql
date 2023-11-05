with source as (

    select * from {{source('main', 'fhv_bases') }}

),

-- cleaning helped with chatgpt
renamed as (
    select 
        -- Trimming whitespace from the VARCHAR fields
        TRIM(base_number) AS base_number,
        TRIM(base_name) AS base_name,
        TRIM(dba) AS dba,
        TRIM(dba_category) AS dba_category,
        TRIM(filename) AS filename
        
    from source
)

select * from renamed