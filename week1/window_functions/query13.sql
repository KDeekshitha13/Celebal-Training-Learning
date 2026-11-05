#13)Diplay top 3 highest paying ride in each payment category

#window function DENSE_RANK()
with ranked_trips as (
    select
        vendorid,
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        payment_type,
        total_amount,
        dense_rank() over (
            partition by payment_type
            order by total_amount desc
        ) as payment_rank
    from taxi_table
    where total_amount>0
      and payment_type is not null
)
select *
from ranked_trips
where payment_rank<=3
order by payment_type, payment_rank;