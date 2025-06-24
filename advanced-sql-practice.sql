drop table if exists orders;
drop table if exists customers;


create table customers (
 id int primary key auto_increment,
 first_name varchar(50),
 last_name varchar(50)
);

create table orders (
 id int primary key,
 customer_id int null,
 order_date date,
 total_amount decimal(10, 2),
 foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

-- Verify that the data was created correctly
SELECT * FROM customers;
SELECT * FROM orders;

-- Task 1: Use JOIN statements
SELECT orders.id, customers.last_name, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

SELECT orders.id, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

SELECT customers.id, customers.first_name, customers.last_name, orders.total_amount
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;

-- Task 2: Write GROUP BY queries with aggregate functions like SUM, MAX, and MIN
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT customer_id, MAX(total_amount) AS max_spent
FROM orders
GROUP BY customer_id;

SELECT order_date, MIN(total_amount) AS min_spent
FROM orders
GROUP BY order_date;

-- Task 3: Apply WHERE and HAVING clauses to filter data
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount < 250
GROUP BY customer_id;

SELECT customer_id, MAX(total_amount) AS max_spent
FROM orders
GROUP BY customer_id
HAVING MAX(total_amount) < 250;

-- Task 4: Practice using SubQueries to create dynamic filters
-- Scalar SubQueries
SELECT id, total_amount
FROM orders
WHERE total_amount <= (SELECT AVG(total_amount) FROM orders);

-- Column SubQueries
SELECT id, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE first_name = 'Bob');

SELECT id, first_name, last_name
FROM customers
WHERE id IN (SELECT customer_id FROM orders WHERE total_amount <= 200);

-- Table SubQueries
SELECT total_amount
FROM (SELECT id, order_date, total_amount FROM orders) 
AS order_summary;

SELECT first_name, last_name
FROM (SELECT id, first_name, last_name FROM customers)
AS customer_list;
