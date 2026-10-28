#12)Display trips in pickup-time order and calculate the cumulative total amount as you move through the trips

#window function and aggregate function 
select
    tpep_pickup_datetime,
    trip_distance,
    fare_amount,
    tip_amount,
    total_amount,
    sum(total_amount) over (
        order by tpep_pickup_datetime
        rows between unbounded preceding and current row
    ) as running_revenue
from taxi_table
where tpep_pickup_datetime is not null
order by tpep_pickup_datetime
limit 50;