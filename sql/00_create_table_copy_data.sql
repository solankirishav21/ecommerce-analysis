-- QUERY To Create Tables and copy data from CSV files (Qery tools in PG-Admin)
CREATE TABLE orders(
	order_id VARCHAR(20) PRIMARY KEY,
	order_date DATE,
	customer_name VARCHAR(255),
	state VARCHAR(255),
	CITY VARCHAR(255)
)

CREATE TABLE order_details(
	order_detail_id SERIAL PRIMARY KEY,
    order_id VARCHAR(20) REFERENCES orders(order_id),
	amount NUMERIC(10, 2),
	profit NUMERIC(10, 2),
	quantity INTEGER,
	category VARCHAR(255),
	sub_category VARCHAR(255)
)

CREATE TABLE sales_target(
	order_date DATE,
	category VARCHAR(255),
	target NUMERIC(10,2),
	PRIMARY KEY(order_date, category)
)
-- Copy data from CSV files into the created tables using PSQL tools in PG-Admin or command line
\copy orders FROM 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/raw/list_of_orders.csv' WITH (FORMAT CSV, HEADER);

\copy order_details (order_id, amount, profit, quantity, category, sub_category) FROM 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/raw/order_details.csv' WITH (FORMAT CSV, HEADER);

\copy sales_target (order_date, category, target) FROM 'C:/Users/Rishav Singh Solanki/Desktop/data-analysis/e-commerce/data/raw/sales_target.csv' WITH (FORMAT CSV, HEADER);

-- Query to verify data has been copied successfully
SELECT * FROM orders LIMIT 25;
SELECT * FROM order_details LIMIT 25;
SELECT * FROM sales_target LIMIT 25