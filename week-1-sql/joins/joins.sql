- Day 3 — Aggregation with global KPIs using CTE + CROSS JOIN + where not exists + inner join + left join +right join + COALESCE

-ex 1 Business question:
  - Customer name + order amount + order date
	select
	 c.name,
	 o.amount,
	 o.order_date
	from customers c
		inner join orders o
		on c.customer_id=o.customer_id;

- ex 2 Business question:
  -  All customers + their total purchases (NULL if no purchases)
	select 
		c.name,
		sum(o.amount) as total_purchases
	from customers c
		left join orders o
		on c.customer_id=o.customer_id
	group by c.name
	order by c.name;

-ex 3 Business question:
	- "Which customers have registered but haven't placed any orders?"
	select 
		c.name,
		o.customer_id as purchases
	from customers c
		left join orders o
		on c.customer_id=o.customer_id
	where o.customer_id is null
	order by c.name;

	-- or:==>

	 select
		 c.name
	 from customers c
	 where not exists
		 (select 1 
		 from orders o
		 where o.customer_id = c.customer_id)
	 order by c.name

- ex 4 Business question:
	  - "What is the total purchase of each customer? (Even those who don't make a purchase)"
	
select
	c.name,
	sum(o.amount) as total_purchase
from customers c
  left join orders o
  on c.customer_id=o.customer_id
 group by c.name
 order by c.name;

- ex 5 Business question:
  - Customer Name, Number of Orders, Total Order Amount 	
select
	c.name,
	count(o.order_id) as number_of_total_orders,
	sum(o.amount) as total_orders_amount
from customers c
  left join orders o
  on c.customer_id=o.customer_id
 group by c.name
 order by c.name;

  -  or: write 0(zero) instead of null

SELECT
    c.name,
    COUNT(o.order_id)            AS number_of_total_orders,
    COALESCE (SUM(o.amount), 0)   AS total_orders_amount
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY c.name;
 

- ex 6 Business question:
  -  Customers with 0 orders
select c.name
from customers c
where not exists  (
	select 1 
	from orders o
	where o.customer_id = c.customer_id
)
order by c.name;
- or

select 
	c.name 
from customers c
 left join orders o
 on c.customer_id=o.customer_id
where o.order_id is null 
order by c.name;

- ex 7 Business question:
  	- 	Only customers who have purchased in the last 6 months

select distinct 
	c.name
from customers c  
join orders o
	on c.customer_id=o.customer_id
where o.order_date >= Current_Date-INTERVAL '6 months' 
order by c.name;

- ex 8 Business question:
	-  But also show all customers

SELECT
    c.name,
    MAX(o.order_date) AS last_order_date
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY c.name
ORDER BY last_order_date DESC;
