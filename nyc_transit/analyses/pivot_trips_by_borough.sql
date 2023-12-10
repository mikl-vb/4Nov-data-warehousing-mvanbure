select {{ 
    dbt_utils.pivot('borough',
    dbt_utils.get_column_values (ref('mart__fact_trips_by_borough'), 'borough'),
    then_value='trips'
    )}}
from {{ref('mart__fact_trips_by_borough')}} ;
