-- 1. Set Up Database (M:M relationship)

-- NOTES
-- db with info about customers and services each customer uses
-- each customer can have any amount of services, every service can have any amount of customers
-- M:M btw customers and services
-- some customers don't have any services (yet), not every service has to be in use by any customer

-- create billing db:
-- createdb billing
-- psql -d billing

CREATE TABLE customers (
  id serial PRIMARY KEY,
  name text NOT NULL,
  payment_token char(8) NOT NULL UNIQUE CHECK (payment_token = UPPER(payment_token) AND LENGTH(payment_token) = 8)
);

CREATE TABLE services (
  id serial PRIMARY KEY,
  description text NOT NULL,
  price numeric(10,2) CHECK (price >= 0.00)
);

INSERT INTO customers (id, name, payment_token) VALUES
(1, 'Pat Johnson', 'XHGOAHEQ'),
(2, 'Nancy Monreal', 'JKWQPJKL'),
(3, 'Lynn Blake', 'KLZXWEEE'),
(4, 'Chen Ke-Hua', 'KWETYCVX'),
(5, 'Scott Lakso', 'UUEAPQPS'),
(6, 'Jim Pornot', 'XKJEYAZA');

INSERT INTO services (id, description, price) VALUES
(1, 'Unix Hosting', 5.95),
(2, 'DNS', 4.95),
(3, 'Whois Registration', 1.95),
(4, 'High Bandwidth', 15.00),
(5, 'Business Support', 250.00),
(6, 'Dedicated Hosting', 50.00),
(7, 'Bulk Email', 250.00),
(8, 'One-to-one Training', 999.00);

CREATE TABLE customers_services (
  id serial PRIMARY KEY,
  customer_id int NOT NULL,
  service_id int NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE,
  FOREIGN KEY (service_id) REFERENCES services(id),
  UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id) VALUES
(1, 1), (1, 2), (1, 3),
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5),
(4, 1), (4, 4),
(5, 1), (5, 2), (5, 6),
(6, 1), (6, 6), (6, 7);

-- 2. Get Customers With Services

SELECT DISTINCT customers.* FROM customers 
INNER JOIN customers_services ON customers.id = customers_services.customer_id;

-- 3. Get Customers With No Services

SELECT customers.* FROM customers 
LEFT OUTER JOIN customers_services ON customer_id = customers.id 
WHERE (service_id IS NULL);

-- further exploration:

SELECT customers.*, services.* FROM customers 
FULL OUTER JOIN customers_services ON customer_id = customers.id 
FULL OUTER JOIN services ON service_id = services.id
WHERE (service_id IS NULL) OR (customer_id IS NULL);

-- 4. Get Services With No Customers

SELECT (services.description) FROM customers_services 
RIGHT OUTER JOIN services ON service_id = services.id
WHERE (customer_id IS NULL);

-- 5. Services for each Customer

SELECT customers.name, string_agg(services.description, ', ') AS services 
FROM customers
LEFT OUTER JOIN customers_services ON customer_id = customers.id
LEFT OUTER JOIN services ON service_id = services.id
GROUP BY customers.id;

-- 6. Services With At Least 3 Customers

SELECT services.description, COUNT(service_id) FROM services
LEFT OUTER JOIN customers_services ON services.id = service_id 
GROUP BY services.description ORDER BY count LIMIT 2 OFFSET 6;

-- alternative:

SELECT services.description, COUNT(service_id) FROM services
LEFT OUTER JOIN customers_services ON services.id = service_id 
GROUP BY services.description HAVING COUNT(customers_services.customer_id) >= 3
ORDER BY services.description;

-- 7. Total Gross Income

SELECT SUM(price) AS gross FROM services
JOIN customers_services ON services.id = service_id;

-- 8. Add New Customer

INSERT INTO customers (id, name, payment_token) VALUES (7, 'John Doe', 'EYODHLCN');

INSERT INTO customers_services (customer_id, service_id) VALUES (7, 1), (7, 2), (7, 3);

-- 9. Hypothetically

-- current expected income level
SELECT SUM(price) FROM services
JOIN customers_services ON services.id = service_id
WHERE (price > 100.00);

-- hypothetical maximum income level
SELECT SUM(price) FROM customers
CROSS JOIN services
WHERE (price > 100.00);

-- 10. Deleting Rows

DELETE FROM customers_services WHERE (service_id = 7);

DELETE FROM services WHERE (id = 7);

DELETE FROM customers WHERE (name = 'Chen Ke-Hua');
