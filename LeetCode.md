
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

[https://leetcode.com/problems/employees-earning-more-than-their-managers/solutions/7724236/employees-earning-more-than-their-manage-c9wp/
](https://leetcode.com/problems/department-top-three-salaries/)
