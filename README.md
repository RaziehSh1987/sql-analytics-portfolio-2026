# SQL Analytics Portfolio

This repository contains SQL projects focused on real business questions:
- joins and relationships
- aggregation and KPIs
- subqueries and filtering logic
- window functions (ranking, latest per group)
- clean query style and explanations

## Structure
- `week-1-sql/` — foundations and daily practice
- `datasets/` — small datasets (if needed)

## How to read
Each `.sql` file includes business questions and the query solutions.

Below is a **clear, structured** that tells you **exactly which SQL commands belong in each file**, 

## 📁 `basic_select.sql`

**Core row-level querying (no aggregation logic focus)**

### Commands / concepts

* `SELECT`
* `FROM`
* `WHERE`
* `ORDER BY`
* `LIMIT`
* `DISTINCT` (non-aggregate)
* comparison operators (`=`, `>`, `<`, `BETWEEN`, `IN`, `LIKE`)
* logical operators (`AND`, `OR`, `NOT`)
* column aliases (`AS`)

### Example

```sql
SELECT name, country
FROM customers
WHERE country = 'Canada'
ORDER BY signup_date DESC
LIMIT 10;
```

---

## 📁 `aggregations.sql`

**Summarizing data**

### Commands / concepts

* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`, `MAX()`
* `GROUP BY`
* `HAVING`
* `COUNT(DISTINCT ...)`
* aggregate aliases

### Example

```sql
SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) > 5;
```

---

## 📁 `joins.sql`

**Combining multiple tables**

### Commands / concepts

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* `FULL JOIN`
* `CROSS JOIN`
* `ON`
* join conditions
* table aliases

### Example

```sql
SELECT c.name, o.amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;
```

---

## 📁 `subqueries.sql`

**Queries inside queries**

### Commands / concepts

* subqueries in `SELECT`
* subqueries in `FROM`
* subqueries in `WHERE`
* `IN`, `EXISTS`
* correlated subqueries
* `WITH` (CTE)

### Example

```sql
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE amount > 500
);
```

---

## 📁 `window_functions.sql`

**Analytics without collapsing rows**

### Commands / concepts

* `OVER()`
* `PARTITION BY`
* `ORDER BY` (inside `OVER`)
* window aggregates: `COUNT() OVER`, `SUM() OVER`
* ranking functions:

  * `ROW_NUMBER()`
  * `RANK()`
  * `DENSE_RANK()`
* `LAG()`, `LEAD()`

### Example

```sql
SELECT
    customer_id,
    amount,
    SUM(amount) OVER (PARTITION BY customer_id) AS total_spent
FROM orders;
```

---

## 🧠 One-line mental model (memorize this)

* **basic_select** → *Which rows?*
* **aggregations** → *How many / how much?*
* **joins** → *Combine tables*
* **subqueries** → *Query inside a query*
* **window_functions** → *Analytics without grouping*

---
enges** based on this structure
