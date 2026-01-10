-- Day 1 — SELECT & WHERE
-- Business question:
-- How many customers from Canada signed up in the last 6 months?


-- Example 3: Defensive / production-safe version
-- Handles casing and extra spaces in country field
SELECT
    c.name,
    c.signup_date,
    COUNT(*) OVER () AS canada_last_6_months
FROM customers c
WHERE TRIM(LOWER(c.country)) = 'canada'
  AND c.signup_date >= CURRENT_DATE - INTERVAL '6 months';

-- ********************************************************************professional:*********************************
-- Day 4 — Window Function => COUNT(*) or SUM(*) with OVER /<function:ROW_NUMBER() / RANK() / DENSE_RANK()> over(partition by/order by)
	 -- over() means =>all of the rows / over(partition by o.customer_id)=> each customer

--ex1 Business question:
	--Number of orders per customer per row
		-- without Window function
		select c.customer_id,
				c.name,
				count(o.order_id) as total_order
		from customers c  left join orders o
			on c.customer_id=o.customer_id
		group by c.customer_id,c.name;
		
		-- with Window function
		
		select distinct(c.customer_id),
				c.name,
			   count(o.order_id) over (PARTITION by o.customer_id) as total_order
		from customers c  left join orders o
					on c.customer_id=o.customer_id;
	 	
		 -- or (with row number and partition by)

SELECT customer_id, name, total_order
FROM (
  SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) OVER (PARTITION BY c.customer_id) AS total_order,
    ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY c.customer_id) AS rn
  FROM customers c
  LEFT JOIN orders o
    ON c.customer_id = o.customer_id
) t
WHERE rn = 1
ORDER BY customer_id;

--ex2 Business question:
	--Next to each order, Show the total sales  for the system + sales per customer 	
select order_id,
	   order_date,
	   sum(amount) over (partition by customer_id) as customer_sales,
	   sum(amount) over () as totale_sales
from orders;

--ex3 Business question:  [row_number()]
	-- Find the first order of each customer.
	select *
	from (select 
			   o.customer_id,
			   o.order_id,
			   o.order_date,
			   row_number() over(partition by customer_id order by order_date ASC) as customer_orders 
			from orders o) as t
	where customer_orders=1;
--ex4 Business question:
	-- Rank customers based on total purchases:
	-- with RANK()
-- SELECT
--   customer,
--   total_purchase,
--   RANK() OVER (ORDER BY total_purchase DESC) AS rnk
-- FROM sales;

-- 	---- with DENSE_RANK()
-- SELECT
--   customer,
--   total_purchase,
--   DENSE_RANK() OVER (ORDER BY total_purchase DESC) AS dense_rnk
-- FROM sales;

--ex5 Business question:
	--Share of each order from total sales
select 
	 o.customer_id,
	 o.order_id,
	 ROUND((o.amount::numeric / sum(o.amount) over())*100,2) as total_sale
from orders o;

--ex6 Business question: (LAG-LEAD)
	--Compare orders over time
select order_date,
	   sum(amount) as daily_sales,
	   LAG (sum(amount)) over(order by order_date) as prev_day_sales 
from orders
group by order_date
order by order_date;

-- or:

WITH daily AS (
  SELECT
    order_date,
    SUM(amount) AS daily_sales
  FROM orders
  GROUP BY order_date
)
SELECT
  order_date,
  daily_sales,
  LAG(daily_sales) OVER (ORDER BY order_date) AS prev_day_sales
FROM daily
ORDER BY order_date;

--ex6 Business question: (LAG-LEAD)
	--Compare orders in time, difference and percentage of change
WITH daily AS (
  SELECT
    order_date,
    SUM(amount) AS daily_sales
  FROM orders
  GROUP BY order_date
)
SELECT
  order_date,
  daily_sales,
  LAG(daily_sales) OVER (ORDER BY order_date) AS prev_day_sales,
  daily_sales - LAG(daily_sales) OVER (ORDER BY order_date) AS day_change,
  ROUND(
    (daily_sales - LAG(daily_sales) OVER (ORDER BY order_date))::numeric
    / NULLIF(LAG(daily_sales) OVER (ORDER BY order_date), 0) * 100,
    2
  ) AS day_change_pct
FROM daily
ORDER BY order_date;

--ex7 Business question:  row_number() 
	--Last order of each customer + its amount
	select *
	from (select 
			   o.customer_id,
			   o.order_id,
			   o.order_date,
			   row_number() over(partition by customer_id order by order_date DESC) as customer_orders,
			   o.amount
			from orders o) as t
	where customer_orders=1;

--ex8 Business question: [row_number() over(partition by]
	--Top 2 orders per customer based on amount 
select * 
from(  select
		   customer_id,
		   order_id,
		   row_number() over(partition by customer_id order by amount DESC ) as top_orders
	  from orders)
where top_orders<=2
order by customer_id,top_orders;

--ex9 Business question: [row_number() over(partition by]
	--Share of each customer in total sales (percentage)
with customer_total as(
	 select 
	 		 o.customer_id,
			 sum(o.amount::numeric) as customer_purchase
	from orders o
	group by o.customer_id
	)
select 
		customer_id,
		customer_purchase,
 		ROUND(((customer_purchase) 
		 		/ sum(customer_purchase) over())*100
				 ,2) as customer_share_pct
from customer_total
order by  customer_share_pct DESC;
		 
--ex10 Business question: [LAG]
	--Change in sales each day compared to the previous day (difference)
with daily_sale as(
			select 
				order_date,
	 			sum(amount::numeric)  as daily_sale
			 from orders
			 group by order_date)
select 
		order_date,
		daily_sale,
		LAG(daily_sale) over(order by order_date) as previous_day,
		daily_sale - LAG(daily_sale) over(order by order_date) as day_diff,
		ROUND(daily_sale - LAG(daily_sale) over(order by order_date)
		/ nullif(LAG(daily_sale) over(order by order_date),0)
		*100,2) as day_change_pct
from daily_sale
order by order_date
		
