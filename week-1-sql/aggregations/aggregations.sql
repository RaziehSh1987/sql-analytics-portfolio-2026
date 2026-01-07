-- Day 2 — -- Aggregation with global KPIs using CTE + CROSS JOIN

--Ex 1: Business question:
-- Total number of customers
-- Number of unique countries
-- Number of customers per country


with stats as(
	select 
		count(*) as total_country,
		count(distinct country) as unique_country
	from customers
)
select 
	c.country,
	count(customer_id) as customer_count,
	s.total_country,
	s.unique_country
from  customers c
cross join stats s
group by c.country , s.total_country , s.unique_country
order by customer_count desc;

--Ex2 Business question:
	-- For each country, give the number of customers who have registered in the last 12 months.

	select 
		country,
		count(*) as number_of_customer
	from customers
	where signup_date > current_date-interval'12 month'
	group by country
	order by number_of_customer DESC;


-- Ex 3: Show countries that have at least 2 customers in the last 12 months
	with stat as (
		select 
			country,
			count(*) as number_of_customer
		from customers
		where signup_date > current_date-interval'12 month'
		group by country)
	select
		country,
		number_of_customer
	from stat
	where number_of_customer>=2
	order by number_of_customer DESC;

-- or
	-- SELECT
	 --country,
	 --COUNT(*) AS number_of_customer
	-- FROM customers
	-- WHERE signup_date >= CURRENT_DATE - INTERVAL '12 months'
	-- GROUP BY country
	-- HAVING COUNT(*) >= 2
	-- ORDER BY number_of_customer DESC;

-- Ex 4:What is the percentage of each country's share of total customers?
with stat as (
	select 
		country,
		count(*) as customer_count 
	from customers
	group by country)
select 
	country,
	customer_count,
	ROUND(
	    	s.customer_count * 100 /sum(customer_count) OVER() , 
			2) as customer_percent
from stat s
order by customer_percent DESC
