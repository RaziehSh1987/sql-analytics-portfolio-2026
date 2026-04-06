
Second highest salary:
<img width="451" height="648" alt="image" src="https://github.com/user-attachments/assets/031e984a-25fd-4d3a-af1a-2fecde1ead18" />

## ✅ Solution 1 — Using `DENSE_RANK()` (Window Function)

```sql
SELECT (
    SELECT DISTINCT salary
    FROM (
        SELECT 
            salary,
            DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM Employee
    ) AS tb
    WHERE rnk = 2
) AS SecondHighestSalary;
```

✔️ Explanation
DENSE_RANK() assigns ranks without gaps
ORDER BY salary DESC → highest salary = rank 1
rnk = 2 → second highest salary
Outer SELECT ensures NULL if not found

## ✅ Solution 2 — Using LIMIT + OFFSET
```sql
SELECT (
    SELECT DISTINCT salary
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
) AS SecondHighestSalary;
```
✔️ Explanation
ORDER BY salary DESC → highest first
DISTINCT removes duplicates
OFFSET 1 skips highest salary
LIMIT 1 returns next → second highest

- get Nth highest value:
- <img width="479" height="677" alt="image" src="https://github.com/user-attachments/assets/6e29c60b-16e3-4948-9729-284bf3589410" />
```sql
 select (select distinct(salary)
      from   (select salary , DENSE_RANK() over(order by salary) as rnk
             from employee)as rnk_tbl
      where  rnk=n) as getNHighestSalary
```
<img width="465" height="313" alt="image" src="https://github.com/user-attachments/assets/07f5cacf-3731-4540-9824-23965f7fee7b" />

```sql
select  score, 
        DENSE_RANK() over( Order by score DESC) as 'rank' 
       from Scores
```

## consecutive Number:
<img width="434" height="710" alt="image" src="https://github.com/user-attachments/assets/76162736-f58f-4e15-bf77-2dee2205788d" />

```sql
select distinct num as ConsecutiveNums
from(
        select num, 
            LAG(num) over (order by id) as pre,
            LEAD(num) over (order by id) as nex
        from  Logs
        order by num)as LAG_num_lead
where  pre=num and num=nex

```
<img width="457" height="650" alt="image" src="https://github.com/user-attachments/assets/6f247661-2e49-4074-bd5e-88e9626b25e8" />

```sql
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m
ON e.managerId = m.id
WHERE e.salary > m.salary
```
or

```sql
select name as Employee
from employee as em
where salary > (select salary
                from employee as manag
                where id=em.managerID )

```

# 🧠 185. Department Top Three Salaries - Hard

## Tables

### Employee

| id | name  | salary | departmentId |
|----|------|--------|--------------|
| PK |      |        | FK → Department.id |

---

### Department

| id | name |
|----|------|
| PK |      |

---

## Task

Find employees whose salary is in the **top 3 unique salaries** within each department.

---

## Output

| Department | Employee | Salary |
|------------|----------|--------|

---

## Notes

- Use **top 3 unique salaries (not top 3 employees)**  
- Result can be in **any order**

## 🧠 SQL Solution: Top 3 Salaries per Department

```sql
SELECT 
    d.name AS Department, 
    t.name AS Employee, 
    t.salary AS Salary
FROM (
    SELECT 
        *, 
        DENSE_RANK() OVER (
            PARTITION BY departmentId 
            ORDER BY salary DESC
        ) AS rnk
    FROM Employee
) t
LEFT JOIN Department d
    ON t.departmentId = d.id
WHERE rnk <= 3;
```
# 262. Trips and Users

**Difficulty:** Hard  
**Topics:** SQL  
**Companies:** (Premium)

---

## 📊 Table: Trips

| Column Name | Type |
|------------|------|
| id         | int  |
| client_id  | int  |
| driver_id  | int  |
| city_id    | int  |
| status     | enum |
| request_at | varchar |

- `id` is the primary key.
- Each trip has a unique id.
- `client_id` and `driver_id` are foreign keys to `users_id` in the Users table.
- `status` is one of:
  - `'completed'`
  - `'cancelled_by_driver'`
  - `'cancelled_by_client'`

---

## 📊 Table: Users

| Column Name | Type |
|------------|------|
| users_id   | int  |
| banned     | enum |
| role       | enum |

- `users_id` is the primary key.
- `role` is one of:
  - `'client'`
  - `'driver'`
  - `'partner'`
- `banned` is:
  - `'Yes'`
  - `'No'`

---

## 🧠 Problem

The **cancellation rate** is defined as:

> Number of canceled trips (by client or driver)  
> divided by  
> Total number of trips  

⚠️ Only consider trips where:
- **client is NOT banned**
- **driver is NOT banned**

---

## 📅 Requirement

Find the **daily cancellation rate** for trips between:

---

## ✅ SQL Solution

```sql
WITH valid_trip AS (
    SELECT t.*
    FROM Trips t
    JOIN Users u_c ON t.client_id = u_c.users_id
    JOIN Users u_d ON t.driver_id = u_d.users_id
    WHERE u_c.banned = 'No'
      AND u_d.banned = 'No'
      AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)

SELECT 
    request_at AS Day,
    ROUND(
        SUM(
            CASE 
                WHEN status != 'completed' THEN 1
                ELSE 0
            END
        ) * 1.0 / COUNT(*),
        2
    ) AS "Cancellation Rate"
FROM valid_trip
GROUP BY request_at;
```

https://leetcode.com/problems/trips-and-users/
