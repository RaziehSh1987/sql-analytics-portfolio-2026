-- Day 4 — Subquery - select-IN-NOT IN-EXISTS-NOT EXISTS,Correlated 

--ex 1 Business question:
	-- "Customers who spent more than the average of all customers"
	select c.customer_id,c.name
	from customers c  left join orders o
		on c.customer_id=o.customer_id
	group by c.customer_id,c.name
	having sum(o.amount)>= ( 
		select AVG(sum_person_purchase) as AVG_total_purchase
		from(
			select sum(o.amount) as Sum_person_purchase
			from orders
			group by customer_id
			)
		);
		
--ex 2 Business question:
	--Customers who have placed at least one order	
select customer_id, name
from customers
where customer_id in (
	select distinct customer_id 
	from orders
);

-- or
SELECT c.customer_id, c.name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);

--ex 3 Business question:
	--Customers who have not placed any orders
SELECT c.customer_id, c.name
FROM customers c
WHERE not exists (
    SELECT  1
    FROM orders o
	 WHERE o.customer_id = c.customer_id);

-- or

SELECT c.customer_id, c.name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--ex 4 Business question:
	--Next to each customer, show the total purchase for the entire system.
select  c.customer_id, c.name , (
	select sum(o.amount) as  system_total_purchase
	from orders o
	)
from customers c 
order by  c.customer_id;

--ex 3 Business question:
	--Next to each customer, show the total purchase for the entire system.
	-- Total purchases
select  
	c.customer_id,
	c.name , 
	COALESCE(sum(o.amount),0) as  customer_total_purchase, --COALESCE replace null with zero
	(select sum(o2.amount) as  system_total_purchase
	from orders o2)
from customers c left join orders o
	on c.customer_id=o.customer_id
group by c.customer_id,c.name 
order by  c.customer_id;

-- or: Only customers with orders

SELECT
    c.customer_id,
    c.name,
    SUM(o.amount) AS customer_total_purchase,
    (SELECT SUM(o2.amount) FROM orders o2) AS system_total_purchase
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY c.customer_id;

--ex 5 Business question:
	--Customers whose total purchases are greater than the average purchase in their country
    -- Correlation is here: WHERE c2.country = c.country

select c.customer_id,
	   c.name,
	   c.country,
	   COALESCE(sum(o.amount),0) as customer_purchase
from customers c  left join orders o 
on c.customer_id=o.customer_id
group by c.customer_id, c.name,c.country 
having   COALESCE(sum(o.amount),0) >=
(
	select  avg(o2.amount)
	from customers c2 left join orders o2
		on c2.customer_id=o2.customer_id
	where c.country=c2.country
		group by c2.country)
order by c.country,customer_purchase DESC;

-- or (with)
WITH customer_totals AS (
  SELECT
      c.customer_id,
      c.name,
      c.country,
      COALESCE(SUM(o.amount), 0) AS customer_purchase
  FROM customers c
  LEFT JOIN orders o
      ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.name, c.country
),
country_avg AS (
  SELECT
      country,
      AVG(customer_purchase) AS avg_country_purchase
  FROM customer_totals
  GROUP BY country
)
SELECT
    ct.customer_id,
    ct.name,
    ct.country,
    ct.customer_purchase
FROM customer_totals ct
JOIN country_avg ca
    ON ca.country = ct.country
WHERE ct.customer_purchase > ca.avg_country_purchase
ORDER BY ct.country, ct.customer_purchase DESC;
