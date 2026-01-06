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
