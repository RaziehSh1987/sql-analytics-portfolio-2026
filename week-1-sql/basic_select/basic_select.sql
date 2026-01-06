-- Day 1 — SELECT & WHERE
-- Business question:
-- How many customers from Canada signed up in the last 6 months?

-- Example 1: Basic filtering
SELECT name, signup_date
FROM customers
WHERE country = 'Canada'
  AND signup_date >= '2024-01-01';

-- Example 2: Count customers (dynamic date)
SELECT COUNT(*) AS canada_last_6_months
FROM customers
WHERE country = 'Canada'
  AND signup_date >= CURRENT_DATE - INTERVAL '6 months';

-- Day 2 — DATE 
-- Business question:
-- Example 2 Business question:
-- Number of registrations according to month?
select 
	count(*) as number_of_registeration,
	to_char(signup_date,'month') as month
	--or extract (month from signup_date) as month ==> just number
	--or DATE_TRUNC('month',signup_date) as month ==> complete date+time zone
from customers
group by  month
order by month Desc;
