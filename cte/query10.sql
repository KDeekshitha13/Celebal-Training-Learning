#10)Return trip details along with the speed 

#CTE
with trip_details as (
    select
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        trip_distance,
        total_amount,
        timestampdiff(
            second,
            tpep_pickup_datetime,
            tpep_dropoff_datetime
        )/3600.0 as trip_hours
    from taxi_table
    where tpep_pickup_datetime is not null
      and tpep_dropoff_datetime is not null
      and tpep_dropoff_datetime>tpep_pickup_datetime
      and trip_distance>0
)
select
    *,
    trip_distance/trip_hours as avg_speed_mph
from trip_details
where trip_hours>=0.5
  and trip_distance/trip_hours<10
order by avg_speed_mph
limit 50;

#The problem here is like there are some long trips some might be real and some might be incorrect data 
#so i am considering trips  whose trip hours are between 1 min and 3 hours

with trip_details as (
    select
        tpep_pickup_datetime,
        tpep_dropoff_datetime,
        trip_distance,
        total_amount,
        timestampdiff(
            second,
            tpep_pickup_datetime,
            tpep_dropoff_datetime
        )/3600.0 as trip_hours
    from taxi_table
    where tpep_pickup_datetime is not null
      and tpep_dropoff_datetime is not null
      and tpep_dropoff_datetime>tpep_pickup_datetime
      and trip_distance>0
),
valid_trips as (
    select *
    from trip_details
    where trip_hours>=1.0/60
      and trip_hours<=3
)
select
    *,
    trip_distance/trip_hours as avg_speed_mph
from valid_trips
where trip_distance/trip_hours<10
order by avg_speed_mph
limit 15;