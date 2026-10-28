#8)Find rides where fare is more than the average fare of that payment type

#join and cte
#here we are taking 2 columns from original table to be considered as the joining table 
select
    t.payment_type,
    t.tpep_pickup_datetime,
    t.trip_distance,
    t.fare_amount,
    p.avg_fare
from taxi_table t
inner join(
    select
        payment_type,
        avg(fare_amount) as avg_fare
    from taxi_table
    group by payment_type
)p
    on t.payment_type=p.payment_type
where t.fare_amount>p.avg_fare
order by t.fare_amount desc
limit 50;


#Find trips whose total amount is higher than the average total amount for their payment type

#this is similar to previous question but here we are doing it using cte
with payment_summary as (
    select
        payment_type,
        avg(total_amount) as avg_amount,
        count(*) as total_trips
    from taxi_table
    where total_amount>0
    group by payment_type
)
select
    t.vendorid,
    t.tpep_pickup_datetime,
    t.tpep_dropoff_datetime,
    t.payment_type,
    t.total_amount,
    p.avg_amount,
    p.total_trips
from taxi_table t
join payment_summary p
    on t.payment_type=p.payment_type
where t.total_amount>p.avg_amount
order by t.total_amount desc
limit 50;