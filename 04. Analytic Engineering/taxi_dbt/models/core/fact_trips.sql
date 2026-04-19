with green_trips as (
    select
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,
        pickup_datetime,
        dropoff_datetime,
        store_and_fwd_flag,
        passenger_count,
        trip_distance,
        trip_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        improvement_surcharge,
        total_amount,
        payment_type,
        'Green' as service_type
    from {{ ref('stg_staging__green_tripdata_2019_01') }}
),

yellow_trips as (
    select
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,
        pickup_datetime,
        dropoff_datetime,
        store_and_fwd_flag,
        passenger_count,
        trip_distance,
        cast(1 as integer) as trip_type,  -- Yellow taxis only do street-hail (code 1)
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        cast(0 as numeric) as ehail_fee,  -- Yellow taxis don't have ehail_fee
        improvement_surcharge,
        total_amount,
        payment_type,
        'Yellow' as service_type
    from {{ ref('stg_staging__yellow_taxi_trips') }}
)

trip_unioned as (
    
select * from green_trips
union all
select * from yellow_trips

)


dim_zones as (

    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)


select * 
from trip_unioned
inner join dim_zones as pickup_zone
on trip_unioned.pickup_location_id = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trip_unioned.dropoff_location_id = dropoff_zone.locationid
