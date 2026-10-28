#6)count no of trips per hour in the first week of jan 2015

#covering both date and aggregate functions
select
    hour(tpep_pickup_datetime) as pickup_hour,
    count(*) as total_trips
from taxi_table
where tpep_pickup_datetime>='2015-01-01' and tpep_pickup_datetime<'2015-01-08'
group by hour(tpep_pickup_datetime)
order by pickup_hour;