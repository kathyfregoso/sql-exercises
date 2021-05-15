-- Update the orders table so that referential integrity will be preserved for
-- the data between orders and products.

ALTER TABLE orders ADD CONSTRAINT orders_product_id_fkey 
FOREIGN KEY (product_id) REFERENCES products(id);

-- insert data

INSERT INTO products (name) VALUES 
('small bolt'), 
('large bolt');

INSERT INTO orders (product_id, quantity) VALUES 
(4, 10),
(4, 25),
(5, 15);

-- return data

SELECT orders.quantity, products.name FROM orders 
JOIN products ON orders.product_id = products.id;

-- insert row into orders without product_id

INSERT INTO orders (quantity) VALUES (25);

-- prevent NULL values from being stored in orders.product_id
-- what happens if you execute this statement?

ALTER TABLE orders ALTER COLUMN product_id SET NOT NULL;

-- we get an error:
-- ERROR:  column "product_id" of relation "orders" contains null values

-- make changes to avoid above error message:

DELETE FROM orders WHERE id = 7;

-- create new table called reviews 

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  description text,
  product_id int REFERENCES products(id)
);

-- insert data

INSERT INTO reviews (description, product_id) VALUES
('a little small', 4),
('very round!', 4),
('could have been smaller', 5);