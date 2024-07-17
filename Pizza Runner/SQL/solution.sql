1. select count(cus.order_id) from pizza_runner.customer_orders as cus;

2. select count(distinct(cus.customer_id)) from pizza_runner.customer_orders as cus;

3. select ord.runner_id, count(ord.runner_id) from pizza_runner.runner_orders as ord 
   where ord.cancellation is null or ord.cancellation = '' group by runner_id;

4. select pi.pizza_name, count(cu.pizza_id) from pizza_runner.customer_orders as cu
   join pizza_runner.runner_orders as run on cu.order_id = run.order_id join pizza_runner.pizza_names
   as pi on pi.pizza_id = cu.pizza_id where run.cancellation is null or run.cancellation = '' group by pizza_name;

5. select cu.customer_id, 
   sum(case when pi.pizza_name = 'Meatlovers' then 1 else 0 end) as Meatlovers,
   sum(case when pi.pizza_name = 'Vegetarian' then 1 else 0 end) as Vegetarian
   from pizza_runner.customer_orders as cu join pizza_runner.pizza_names as pi on pi.pizza_id = cu.pizza_id group by customer_id;

6. select max(subquery.count_result) from(
   select count(cu.order_id) as count_result, cu.order_id from pizza_runner.customer_orders as cu group by cu.order_id) as subquery;

7. 
8.
9.
10.