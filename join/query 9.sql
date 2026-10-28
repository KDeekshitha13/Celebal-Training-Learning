#9)Display trip details along with a readable vendor name using a join

#join
select
    t.vendorid,
    v.vendor_name,
    t.tpep_pickup_datetime,
    t.tpep_dropoff_datetime,
    t.fare_amount
from taxi_table t
inner join (
    select 1 as vendorid,'CMT' as vendor_name
    union all
    select 2,'VeriFone'
) v
    on t.vendorid = v.vendorid
limit 20;