# Day 4 — Subquery - select-IN-NOT IN-EXISTS-NOT EXISTS,Correlated 

- ex 1 Business question: (select)
	-"Customers who spent more than the average of all customers"
<img width="215" height="164" alt="image" src="https://github.com/user-attachments/assets/6812b083-c1ea-4743-b177-6880a4042496" />
	
		
- ex 2 Business question: (IN)
	- Customers who have placed at least one order	
<img width="202" height="160" alt="image" src="https://github.com/user-attachments/assets/f365407b-78a3-4f97-9dff-903793f9ebcf" />
# or
- (WHERE Exist )
<img width="193" height="155" alt="image" src="https://github.com/user-attachments/assets/26041f64-76aa-4cf6-b818-f11ce2f465d7" />

- ex 3 Business question: (NOT EXISTS)
	- Customers who have not placed any orders
<img width="200" height="148" alt="image" src="https://github.com/user-attachments/assets/1701c097-70d2-4454-b321-94d7c710c96c" />

# or (IS NULL)

<img width="183" height="144" alt="image" src="https://github.com/user-attachments/assets/aff215b3-c971-4ced-8fe4-14d9e11eb6df" />

- ex 4 Business question: (SUBQUERY)
	- Next to each customer, show the total purchase for the entire system.
<img width="394" height="243" alt="image" src="https://github.com/user-attachments/assets/e91c8012-90e2-4c6f-895e-dd0a9f4b10a0" />

- ex 3 Business question:
	- Next to each customer, show the total purchase for the entire system.
	-  Total purchases
<img width="596" height="250" alt="image" src="https://github.com/user-attachments/assets/17a43f02-d7fa-42b7-a273-8204602e037a" />


# or: 
- Only customers with orders

<img width="603" height="160" alt="image" src="https://github.com/user-attachments/assets/75243ccc-73bd-4d13-9ef3-dcf0ae1337d7" />


- ex 5 Business question:(CORELLATED SUBQUERY)
	- Customers whose total purchases are greater than the average purchase in their country
       Correlation is here: WHERE c2.country = c.country

<img width="459" height="162" alt="image" src="https://github.com/user-attachments/assets/4311a436-c49b-43b1-8aec-12a333d6ac05" />


# or
- (WITH ... AS)
<img width="451" height="143" alt="image" src="https://github.com/user-attachments/assets/a9e1c4ff-75ed-49bd-8cf8-4534d4f41b79" />

    ON ca.country = ct.country
WHERE ct.customer_purchase > ca.avg_country_purchase
ORDER BY ct.country, ct.customer_purchase DESC;
