with source as (

    select * from {{source('main', 'central_park_weather') }}

),

-- cleaning helped with chatgpt
renamed as (
    select 
        station,
        name,
        date,
        awnd::double as awnd,
        prcp::double as prcp,
        snow::double as snow,
        snwd::double as snwd,
        tmax::int as tmax,
        tmin::int as tmin,
        trim(filename) as filename

    from source
)

select * from renamed