
--KPI:  Define 3 appropriate KPIs for customer growth + SQL each
--1 New customers (last 3 months)	
Select customer_id,name
From customers
Where signup_date> current_date + interval'-3 months';

--2 Month-over-month growth rate
with counts as (
			select 
				  count(*) filter 
				  (where signup_date> current_date - interval '1 months') as last_month,
				  count(*) filter 
				  (where current_date - interval'2 months'>=signup_date 
				  		  and signup_date< current_date - interval '1 months') as two_last_month
			from customers
				)		 
select 	last_month,
		two_last_month,
		case 
		when two_last_month=0 then null
		else Round(((two_last_month -last_month )::numeric/ two_last_month * 100),2) 
		end as month_growth  
from counts;

-- 3 Country share of new customers
select country,
	   count(*) as number_of_new_customer_each_country,
	   round(count(*)::numeric /sum(count(*))  over() *100,2) as country_share_pct
	   
from customers
where signup_date>= current_date - interval '1 months'
group by country
order by country_share_pct DESC

-- KPI: for Revenue
-- 1 Total Revenue
SELECT
  SUM(amount) AS total_revenue
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- 2 Average Order Value (AOV)
SELECT
  ROUND(SUM(amount)::numeric / NULLIF(COUNT(*), 0), 2) AS avg_order_value
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- 3 Revenue Growth Rate (MoM)
WITH monthly AS (
  SELECT
    DATE_TRUNC('month', order_date)::date AS month_start,
    SUM(amount) AS revenue
  FROM orders
  WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 months'
    AND order_date <  DATE_TRUNC('month', CURRENT_DATE)
  GROUP BY 1
),
vals AS (
  SELECT
    COALESCE(MAX(revenue) FILTER (WHERE month_start = (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month')::date), 0) AS last_month_revenue,
    COALESCE(MAX(revenue) FILTER (WHERE month_start = (DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 months')::date), 0) AS two_last_month_revenue
  FROM monthly
)
SELECT
  last_month_revenue,
  two_last_month_revenue,
  CASE
    WHEN two_last_month_revenue = 0 THEN NULL
    ELSE ROUND(((last_month_revenue - two_last_month_revenue)::numeric / two_last_month_revenue) * 100, 2)
  END AS mom_revenue_growth_pct
FROM vals;

