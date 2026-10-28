#3)Calculate the toatl amount paid by different methods of payment and their category 

#case statements
select 
	payment_type, sum(total_amount) as Total,
    case
      when sum(total_amount)>1000000 then "High"
      when sum(total_amount)<1000000 and sum(total_amount)>100000 then "Mid"
      else "Low"
	end as Category
from taxi_table
group by payment_type
having sum(total_amount)!=0;
