
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
