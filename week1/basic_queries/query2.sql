#2)display the details where store_and_fwd_flag is yes

#Usage of like,wild card operators and string function UPPER()
select
    vendorid,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    UPPER(store_and_fwd_flag) as flag,
    payment_type,
    total_amount
from taxi_table
where store_and_fwd_flag like 'y%'
limit 20;