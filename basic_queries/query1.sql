#1)Display rows distance in which toll is 0

#Basic query
select 
	trip_distance,total_amount
from taxi_table
where tolls_amount=0
order by trip_distance
limit 20;

#from the above query we can see the values where trip distance is 0 but total amount is shown
#this might be the problem with data 
#so i am adding extra where condition

select 
	trip_distance,total_amount
from taxi_table
where tolls_amount=0 and trip_distance!=0
order by trip_distance
limit 20;