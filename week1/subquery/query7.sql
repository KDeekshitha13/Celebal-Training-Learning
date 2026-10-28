#7)Find rows where total amount is greater than avg total amount

#subquery 
select
    tpep_pickup_datetime,tpep_dropoff_datetime,total_amount
from taxi_table
where total_amount>(
    select avg(total_amount)
    from taxi_table
)
order by total_amount desc
limit 50;