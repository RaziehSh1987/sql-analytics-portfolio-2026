#  Day 3 
- Aggregation with global KPIs using CTE + CROSS JOIN + where not exists + inner join + left join +right join + COALESCE

  - ex 1 Business question:
    - Customer name + order amount + order date
<img width="366" height="207" alt="image" src="https://github.com/user-attachments/assets/148f8d14-0ada-4ada-a876-6a6a3c6dd7a1" />


  - ex 2 Business question:
    -  All customers + their total purchases (NULL if no purchases)
	<img width="270" height="246" alt="image" src="https://github.com/user-attachments/assets/fd11dc3a-0b56-443d-9275-614c307065d5" />

  -ex 3 Business question:
  	- "Which customers have registered but haven't placed any orders?"
	<img width="238" height="148" alt="image" src="https://github.com/user-attachments/assets/9eca7909-c9ae-4dc0-8c8e-8427d1f0eec7" />
# or:
	<img width="122" height="152" alt="image" src="https://github.com/user-attachments/assets/ec986aa0-3813-4762-a5a6-52b9f650d542" />
  - ex 4 Business question:
	  - "What is the total purchase of each customer? (Even those who don't make a purchase)"
	
<img width="261" height="241" alt="image" src="https://github.com/user-attachments/assets/9727ffa2-9c78-41d3-a492-98821a125413" />

  - ex 5 Business question:
    - Customer Name, Number of Orders, Total Order Amount 	
<img width="504" height="243" alt="image" src="https://github.com/user-attachments/assets/f0f6c8fd-e553-4561-9917-ab3ccc91ee83" />

  #  or: write 0(zero) instead of null

<img width="513" height="243" alt="image" src="https://github.com/user-attachments/assets/f8e0c5a1-bf0a-4304-835d-bf48b8b6a1bb" />

  - ex 6 Business question:
    -  Customers with 0 orders
<img width="125" height="146" alt="image" src="https://github.com/user-attachments/assets/c92e5262-ef77-4b2d-9c2d-8dcb48c2e886" />
# or
<img width="125" height="142" alt="image" src="https://github.com/user-attachments/assets/7a53419d-1320-48cb-a4d3-77d342d47875" />

  - ex 7 Business question:
    - Only customers who have purchased in the last 6 months

<img width="83" height="58" alt="image" src="https://github.com/user-attachments/assets/8b04f533-f65f-48c7-a341-682f18354385" />

  - ex 8 Business question:
  	-  But also show all customers

<img width="213" height="53" alt="image" src="https://github.com/user-attachments/assets/cb498b1c-f534-494e-ad95-59325b39c009" />


