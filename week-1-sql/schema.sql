-- Schema definition for customers table

CREATE TABLE IF NOT EXISTS customers(
	customer_id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	country TEXT NOT NULL,
	signup_date DATE NOT NULL
);
