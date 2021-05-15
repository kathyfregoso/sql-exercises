CREATE TABLE orders (
    id integer,
    customer_name text,
    burger text,
    side text,
    drink text
);

INSERT INTO orders VALUES (1, 'Todd Perez', 'LS Burger', 'Fries', 'Lemonade');
INSERT INTO orders VALUES (2, 'Florence Jordan', 'LS Cheeseburger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (3, 'Robin Barnes', 'LS Burger', 'Onion Rings', 'Vanilla Shake');
INSERT INTO orders VALUES (4, 'Joyce Silva', 'LS Double Deluxe Burger', 'Fries', 'Chocolate Shake');
INSERT INTO orders VALUES (5, 'Joyce Silva', 'LS Chicken Burger', 'Onion Rings', 'Cola');

-- query that returns all of the customer names

SELECT customer_name FROM orders;

-- query that returns all of the orders that include a Chocolate Shake.

SELECT * FROM orders WHERE drink = 'Chocolate Shake';

-- query that returns burger, side, and drink for the order with id of 2.

SELECT burger, side, drink FROM orders WHERE id = 2;

-- query that returns the name of anyone who ordered Onion Rings.

SELECT customer_name FROM orders WHERE side = 'Onion Rings';

-- Create a table in the ls_burger database called orders.

CREATE TABLE orders (
  id serial,
  customer_name varchar(100) NOT NULL,
  burger varchar(50),
  side varchar(50),
  drink varchar(50),
  order_total decimal(4, 2) NOT NULL
);

-- Connect to the ls_burger database.
--  Add columns to the orders table

ALTER TABLE orders 
ADD COLUMN customer_email varchar(50),
ADD COLUMN customer_loyalty_points int DEFAULT 0;

-- Add three columns to the orders table called burger_cost, side_cost, and 
-- drink_cost to 
-- hold monetary values in dollars and cents (assume that all values will be 
-- less than $100). If no value is entered for these columns, a value of 
-- 0 dollars should be used.

ALTER TABLE orders 
ADD COLUMN burger_cost decimal(4, 2) DEFAULT 0,
ADD COLUMN side_cost decimal(4,2) DEFAULT 0,
ADD COLUMN drink_cost decimal(4,2) DEFAULT 0;

-- remove order_total column from orders table

ALTER TABLE orders DROP COLUMN order_total;

-- examine schema for orders table

-- \d orders

INSERT INTO orders 
(customer_name, burger, side, drink, customer_email, 
customer_loyalty_points, burger_cost, side_cost, drink_cost) 
VALUES 
('Natasha O''Shea', 'LS Cheeseburger', 'Fries', NULL, 'natasha@osheafamily.com', 18, 3.50, 0.99, DEFAULT),
('Natasha O''Shea', 'LS Double Deluxe Burger', 'Onion Rings', 'Chocolate Shake', 'natasha@osheafamily.com',
42, 6.00, 1.50, 2.00),
('Aaron Muller', 'LS Burger', NULL, NULL, NULL, 10, 3.00, DEFAULT, DEFAULT),
('James Bergman', 'LS Chicken Burger', 'Fries', 'Cola', 'james1998@email.com', 28, 4.50, .99, 1.50);

-- list all of the burgers that've been ordered, cheapest to most expensive, where the cost of 
-- the burger is less than $5.00.

SELECT burger FROM orders WHERE burger_cost < 5.00 ORDER BY burger_cost;

-- return the customer name and email address and loyalty points from any order worth 20 
-- or more loyalty points. List the results from the highest number of points to the lowest.

SELECT customer_name, customer_email, customer_loyalty_points FROM orders
WHERE customer_loyalty_points >= 20 ORDER BY customer_loyalty_points DESC;

-- return all the burgers ordered by Natasha O'Shea.

SELECT burger FROM orders WHERE customer_name = 'Natasha O''Shea';

-- return the customer name from any order which does not include a drink item

SELECT customer_name FROM orders WHERE drink IS NULL;

-- return the three meal items for any order which does not include fries

SELECT burger, side, drink FROM orders WHERE side != 'Fries' OR side IS NULL;

-- returns the three meal items for any order that includes both a side and a drink

SELECT burger, side, drink FROM orders WHERE (side IS NOT NULL) AND (drink IS NOT NULL);

-- return the average burger cost for all orders that include fries.

SELECT avg(burger_cost) FROM orders WHERE side = 'Fries';

-- return the cost of the cheapest side ordered

SELECT side_cost FROM orders WHERE side_cost > 0 
GROUP BY side_cost ORDER BY min(side_cost) LIMIT 1;

-- or

SELECT min(side_cost) FROM orders WHERE side IS NOT NULL;

-- return the number of orders that include Fries and the number of orders that 
-- include Onion Rings.

SELECT count(side) FROM orders WHERE side = 'Onion Rings' OR side = 'Fries' GROUP BY side;

-- Change the drink on James Bergman's order from a Cola to a Lemonade.

UPDATE orders SET drink = 'Lemonade' WHERE customer_name = 'James Bergman';

-- Add Fries to Aaron Muller's order. Make sure to add the cost ($0.99) 
-- to the appropriate field and add 3 loyalty points to the current total.

UPDATE orders SET side = 'Fries' WHERE customer_name = 'Aaron Muller';

UPDATE orders SET side_cost = '0.99' WHERE customer_name = 'Aaron Muller';

UPDATE orders SET customer_loyalty_points = 13
WHERE customer_name = 'Aaron Muller';

-- The cost of Fries has increased to $1.20. Update the data in the table to reflect this.

UPDATE orders SET side_cost = '1.20' WHERE side = 'Fries';

-- break orders up into multiple tables:
-- customers table 
-- email_addresses table
-- 1:1 relationship

ALTER TABLE orders DROP COLUMN customer_email;
ALTER TABLE orders DROP COLUMN customer_name;

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name varchar(100)
);

CREATE TABLE customer_emails (
  id serial PRIMARY KEY,
  email varchar(50),
  customer_id int REFERENCES customers (id) ON DELETE CASCADE
);

INSERT INTO customers (name) VALUES
('Natasha O''Shea'),
('James Bergman'),
('Aaron Muller');

INSERT INTO customer_emails (email, customer_id) VALUES
('natasha@osheafamily.com', 1),
('james1998@email.com', 2);

-- create products table

CREATE TABLE products (
  id serial PRIMARY KEY,
  name varchar(50),
  cost decimal(4,2),
  type varchar(20),
  loyalty_points int
);

INSERT INTO products (name, cost, type, loyalty_points) VALUES
('LS Burger', 3.00, 'Burger', 10),
('LS Cheeseburger', 3.50, 'Burger', 15),
('LS Chicken Burger', 4.50, 'Burger', 20),
('LS Double Deluxe Burger', 6.00, 'Burger', 30),
('Fries', 1.20, 'Side', 3),
('Onion Rings', 1.50, 'Side', 5),
('Cola', 1.50, 'Drink', 5),
('Lemonade', 1.50, 'Drink', 5),
('Vanilla Shake', 2.00, 'Drink', 7), 
('Chocolate Shake', 2.00, 'Drink', 7), 
('Strawberry Shake', 2.00, 'Drink', 7);


DROP TABLE orders;

CREATE TABLE orders (
  id serial PRIMARY KEY,
  order_status varchar(20),
  customer_id int REFERENCES customers (id) ON DELETE CASCADE
);

CREATE TABLE order_items (
  id serial PRIMARY KEY,
  order_id int REFERENCES orders (id) ON DELETE CASCADE,
  product_id int REFERENCES products (id) ON DELETE CASCADE
);

INSERT INTO orders (order_status, customer_id) VALUES
('In Progress', 2),
('Placed', 1),
('Complete', 1),
('Placed', 3);

INSERT INTO order_items (order_id, product_id) VALUES
(1, 3),
(1, 5),
(1, 8),
(2, 2),
(2, 5),
(2, 7),
(3, 4),
(3, 2),
(3, 5),
(3, 5),
(3, 6),
(3, 10),
(3, 9),
(4, 1),
(4, 5);

-- Return a list of all orders and their associated product items.

SELECT orders.*, products.* FROM orders JOIN order_items
ON orders.id = order_items.order_id
JOIN products
ON products.id = order_items.product_id;

-- Return the id of any order that includes Fries. 
-- Use table aliasing in your query.

SELECT o.id FROM orders AS o 
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p
ON p.id = oi.product_id
WHERE p.name = 'Fries';

-- Build on the above to return the name of any customer who ordered fries. 
-- Return this in a column called 'Customers who like Fries'.
-- Don't repeat the same customer name more than once in the results.

SELECT DISTINCT customers.name AS "Customers who like Fries" FROM customers
JOIN order_items AS oi
ON customers.id = oi.order_id
JOIN products AS p
ON p.id = oi.product_id
WHERE p.name = 'Fries';

-- return the total cost of Natasha O'Shea's orders.

SELECT SUM(p.cost) FROM customers AS c JOIN orders AS o 
ON c.id = o.customer_id
JOIN order_items AS oi
ON o.id = oi.order_id
JOIN products AS p 
ON oi.product_id = p.id 
WHERE c.name = 'Natasha O''Shea';

-- return the name of every product included in an order alongside the number 
-- of times it has been ordered. Sort the results by product name, ascending.

SELECT p.name, count(oi.product_id) FROM products AS p 
JOIN order_items AS oi ON (p.id = oi.product_id)
JOIN orders AS o ON oi.order_id = o.id
GROUP BY p.name
ORDER BY p.name ASC;