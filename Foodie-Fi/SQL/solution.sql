1. select count(distinct(sub.customer_id)) from foodie_fi.subscriptions as sub;

2. select TO_CHAR(sub.start_date, 'Month') as months, count(sub.customer_id) from 
   foodie_fi.plans as pl join foodie_fi.subscriptions as sub on pl.plan_id = sub.plan_id
   where pl.plan_name = 'trial' group by months;

3. select pl.plan_name , count(sub.customer_id) from foodie_fi.plans as pl
   join foodie_fi.subscriptions as sub on pl.plan_id = sub.plan_id  where 
   EXTRACT(YEAR FROM sub.start_date) > 2020 group by pl.plan_name;


5. with joined_table as (
      select * from foodie_fi.subscriptions AS sub
      join foodie_fi.plans AS pl ON sub.plan_id = pl.plan_id
   )


   select sum(count_of_customers), Round((sum(count_of_customers)/(select count(*) from foodie_fi.subscriptions)) * 100) as percentage from (
   select customer_id, plan_name, count(customer_id) as count_of_customers from joined_table where customer_id not in (
      select customer_id from joined_table where plan_name in ('basic monthly', 'pro monthly', 'pro annual') 
   ) group by customer_id, plan_name) as subquery;

6. with joined_table as (
      select * from foodie_fi.subscriptions AS sub
      join foodie_fi.plans AS pl ON sub.plan_id = pl.plan_id
   )

   select plan_name, sum(count_of_customers), Round((sum(count_of_customers)/(select count(*) from foodie_fi.subscriptions)) * 100) as percentage from (
   select customer_id, plan_name, count(customer_id) as count_of_customers from joined_table where plan_name in ('basic monthly', 'pro monthly', 'pro annual', 'churn') 
   group by customer_id, plan_name) as subquery group by plan_name;

7.