#4)count total no of rides whose trip took more than a day

#Focusing on date functions DATEDIFF and TIMESTAMPDIFF 
  select count(*) 
  from taxi_table 
  where (
  datediff(tpep_pickup_datetime,tpep_dropoff_datetime )>1
  );
#as there is no 1 day long trip i had modified the first query to more than 30 mins ride 
#for more than 30 min i had used timestampdiff and specified the unit as minute 


#count total no of rides whose trip took more than a 30 mins.
  select count(*) 
  from taxi_table 
  where (
  timestampdiff(minute,tpep_dropoff_datetime ,tpep_pickup_datetime)>30
  );
  
  #displaying those ride details
  select 
		 tpep_pickup_datetime as Start_time ,tpep_dropoff_datetime as End_time,
         timestampdiff(minute,tpep_dropoff_datetime ,tpep_pickup_datetime) as time_calculated ,total_amount
         
  from taxi_table 
  where (
  timestampdiff(minute,tpep_dropoff_datetime ,tpep_pickup_datetime)>30
  )
  order by time_calculated;
  