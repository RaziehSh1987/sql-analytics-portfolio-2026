# Day 1  : Practice basic SQL filtering and counting with real business questions.

- Business Question:  string normalization (LOWER, TRIM)
  - How many customers from Canada signed up in the last 6 months?
<img width="446" height="165" alt="image" src="https://github.com/user-attachments/assets/3a43e1ae-61d6-4371-a716-0f264209408a" />

# Day 4 — Window Function => COUNT(*) or SUM(*) with OVER /<function:ROW_NUMBER() / RANK() / DENSE_RANK()> over(partition by/order by)
- over() means =>all of the rows / over(partition by o.customer_id)=> each customer

- ex1 Business question:
	- Number of orders per customer per row
		-  without Window function
	<img width="354" height="237" alt="image" src="https://github.com/user-attachments/assets/e4104f7a-a71f-4e25-a693-f6eff2b12449" />

		- with Window function
		<img width="350" height="242" alt="image" src="https://github.com/user-attachments/assets/b5d1e1ff-ef61-4e6b-be53-5c61d75a9d67" />
    - or (with row number and partition by)
<img width="359" height="249" alt="image" src="https://github.com/user-attachments/assets/91f48a6c-e0a1-43e5-be3c-95eeb186a542" />

-ex2 Business question:
	- Next to each order, Show the total sales  for the system + sales per customer 	
<img width="548" height="210" alt="image" src="https://github.com/user-attachments/assets/19a6897d-cb27-44a5-b2ce-b3e9709f462a" />
- ex3 Business question:  [row_number()]
	-  Find the first order of each customer.
<img width="564" height="151" alt="image" src="https://github.com/user-attachments/assets/96b7208b-7b5c-4185-b889-5e8b2899e771" />

- ex4 Business question:
	-  Rank customers based on total purchases:
	  -  with RANK()
<img width="521" height="300" alt="image" src="https://github.com/user-attachments/assets/7aa30c87-5173-44e5-b818-9b0cd4d521ef" />
   - with DENSE_RANK()
<img width="534" height="303" alt="image" src="https://github.com/user-attachments/assets/06435c27-f9a1-4f6a-9c25-b7652196773f" />

- ex5 Business question:
	- Share of each order from total sales
<img width="398" height="210" alt="image" src="https://github.com/user-attachments/assets/35b197f5-d002-4bd7-aa8d-17aceb14aef0" />
- ex6 Business question: (LAG-LEAD)
	- Compare orders over time
<img width="419" height="207" alt="image" src="https://github.com/user-attachments/assets/0deb66df-eb22-42f4-be32-6560db7efea2" />
# or:
<img width="425" height="208" alt="image" src="https://github.com/user-attachments/assets/61273933-7814-4cca-ad34-0f7b1f35ef29" />

- ex6 Business question: (LAG-LEAD)
	- Compare orders in time, difference and percentage of change
<img width="684" height="216" alt="image" src="https://github.com/user-attachments/assets/fd2ecd1c-da0f-44d7-ac7c-06b22bf6ed1d" />

- ex7 Business question:  row_number() 
	- Last order of each customer + its amount
	<img width="687" height="150" alt="image" src="https://github.com/user-attachments/assets/44f7df35-56c8-4139-8f63-61864f3aa429" />

- ex8 Business question: [row_number() over(partition by]
	- Top 2 orders per customer based on amount 
<img width="402" height="209" alt="image" src="https://github.com/user-attachments/assets/a626c20a-4424-4bcd-b04f-cb9b160e6b46" />

- ex9 Business question: [row_number() over(partition by]
	- Share of each customer in total sales (percentage)
<img width="524" height="149" alt="image" src="https://github.com/user-attachments/assets/b927a553-2fea-47c9-a4c6-77d12f9c04dd" />
	 
- ex10 Business question: [LAG]
	- Change in sales each day compared to the previous day (difference)
<img width="635" height="204" alt="image" src="https://github.com/user-attachments/assets/6aa5abf7-008a-413a-9b01-912704474263" />

		
