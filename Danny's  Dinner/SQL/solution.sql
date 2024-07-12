1. select sa.customer_id, sum(me.price) from dannys_diner.sales as sa
   join dannys_diner.menu as me on sa.product_id = me.product_id 
   group by 1 order by sa.customer_id;

2. select sa.customer_id,count(distinct(sa.order_date))
   from dannys_diner.sales as sa group by 1 order by sa.customer_id;

3. select subquery2.customer_id, subquery2.product_name from (
   select *, ROW_NUMBER() over (partition by subquery.customer_id) as row_num from (
   select sa.customer_id, me.product_name from dannys_diner.sales as sa 
   join dannys_diner.menu as me on sa.product_id = me.product_id order by sa.order_date)
   as subquery) as subquery2 where row_num = 1 ;

4. select me.product_name, count(sa.product_id) as most_purchased from dannys_diner.sales as sa
   join dannys_diner.menu as me on sa.product_id = me.product_id group by me.product_name
   order by most_purchased desc limit 1;

5. select subquery2.customer_id, subquery2.product_name, subquery2.most_purchased from (
   select *, RANK() over (partition by subquery.customer_id order by most_purchased desc) as row_num from (
   select sa.customer_id, me.product_name, count(sa.product_id) as most_purchased from dannys_diner.sales as sa
   join dannys_diner.menu as me on sa.product_id = me.product_id group by sa.customer_id, me.product_name )
   as subquery) as subquery2 where row_num =1;

6. select subquery2.customer_id, subquery2.product_name from (
   select *, RANK() over (partition by subquery.customer_id order by subquery.order_date) as row_num from (
   select sa.customer_id, me.product_name, sa.order_date from dannys_diner.sales as sa join dannys_diner.members as mem
   on sa.customer_id = mem.customer_id join dannys_diner.menu as me on sa.product_id = me.product_id where mem.join_date < sa.order_date) as subquery)
   as subquery2 where row_num =1;

7. select subquery2.customer_id, subquery2.product_name from (
   select *, RANK() over (partition by subquery.customer_id order by subquery.order_date desc) as row_num from (
   select sa.customer_id, me.product_name, sa.order_date from dannys_diner.sales as sa join dannys_diner.members as mem 
   on sa.customer_id = mem.customer_id join dannys_diner.menu as me on sa.product_id = me.product_id where mem.join_date > sa.order_date) as subquery)
   as subquery2 where row_num =1;

8. select sa.customer_id, sum(me.price), count(sa.product_id) from dannys_diner.sales as sa join 
   dannys_diner.menu as me on me.product_id = sa.product_id group by sa.customer_id;

9. select subquery.customer_id, sum(subquery.customer_point) from(
   select sa.customer_id, 
        case 
            when me.product_name != 'sushi' then me.price * 10
            else 2 * me.price
        end as customer_point 
   from dannys_diner.sales as sa join dannys_diner.menu as me on me.product_id = sa.product_id) as subquery group by subquery.customer_id 
   order by subquery.customer_id;

10. select subquery.customer_id, sum(subquery.customer_point) from(
    select sa.customer_id, 
        case 
            when me.product_name != 'sushi' then me.price * 10
        end as customer_point 
    from dannys_diner.sales as sa join dannys_diner.menu as me on me.product_id = sa.product_id join dannys_diner.members as mem
    on mem.customer_id = sa.customer_id where mem.join_date <= sa.order_date) as subquery group by subquery.customer_id order by subquery.customer_id;