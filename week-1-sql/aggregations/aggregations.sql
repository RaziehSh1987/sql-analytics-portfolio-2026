-- Day 2 — -- Aggregation with global KPIs using CTE + CROSS JOIN

-- Business question:
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

