#11)Rank rides based on the total amount

#window function RANK()

select
    tpep_pickup_datetime,
    trip_distance,
    passenger_count,
    total_amount,
    rank() over (
        order by total_amount desc
    ) as fare_rank
from taxi_table
where total_amount>0
limit 50;