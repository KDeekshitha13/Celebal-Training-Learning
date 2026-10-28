#5)Calculate the share of each passenger in the total amount

#Aggreagate function COUNT()
select 
	tpep_pickup_datetime,tpep_dropoff_datetime,
	total_amount/passenger_count as Share_of_Individual 
from taxi_table
where total_amount/passenger_count>15
limit 10;

#but if we see there are rows with passenger count as 0 
#but i didnt got an error because division by zero is considred as null and MySQL will compute it
select count(*) 
from taxi_table 
where passenger_count=0;

#By addressing the above error of dividion by zero using NULLIF
select 
	tpep_pickup_datetime,tpep_dropoff_datetime,
	total_amount/NULLIF(passenger_count,0) as Share_of_Individual 
from taxi_table
where total_amount/NULLIF(passenger_count,0)>15
limit 10;



  