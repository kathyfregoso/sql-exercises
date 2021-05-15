-- create table called people 

CREATE TABLE people (
  id serial PRIMARY KEY,
  name text,
  age int,
  occupation text
);

-- insert data

INSERT INTO people (name, age, occupation) VALUES
('Abby', 34, 'biologist'),
('Mu''nisah', 26, NULL),
('Mirabelle', 40, 'contractor');

-- queries to get 2nd row of table

SELECT * FROM people LIMIT 1 OFFSET 1;

SELECT * FROM people WHERE name = 'Mu''nisah';

SELECT * FROM people WHERE occupation IS NULL;

-- make a table named birds

CREATE TABLE birds (
  id serial PRIMARY KEY,
  name text,
  length decimal(4, 1),
  wingspan decimal(4,1),
  family text,
  extinct boolean
);

-- insert data

INSERT INTO birds (name, length, wingspan, family, extinct) VALUES
('Spotted Towhee', 21.6, 26.7, 'Emberizidae', false),
('American Robin', 25.5, 36.0, 'Turdidae', false),
('Greater Koa Finch', 19.0, 24.0, 'Fringillidae', true),
('Carolina Parakeet', 33.0, 55.8, 'Psittacidae', true),
('Common Kestrel', 35.5, 73.5, 'Falconidea', false);

-- find the names and families for all birds that are not extinct, 
-- in order from longest to shortest (based on the length column's value).

SELECT name, family FROM birds
WHERE extinct != true
ORDER BY length DESC;

-- Use SQL to determine the average, minimum, and maximum wingspan for
--  the birds shown in the table.

SELECT round(avg(wingspan), 1), min(wingspan), max(wingspan) FROM birds;

-- create menu_items table

CREATE TABLE menu_items (
  id serial,
  item text,
  prep_time int,
  ingredient_cost decimal(4,2),
  sales int,
  menu_price decimal(4, 2)
);

-- insert data

INSERT INTO menu_items (item, prep_time, ingredient_cost, sales, menu_price)
VALUES 
('omelette', 10, 1.50, 182, 7.99),
('tacos', 5, 2.00, 254, 8.99),
('oatmeal', 1, 0.50, 79, 5.99);

-- determine which menu item is the most profitable based on the cost of its 
-- ingredients, returning the name of the item and its profit.

SELECT item, max(menu_price - ingredient_cost) FROM menu_items
GROUP BY item LIMIT 1;

-- determine how profitable each item on the menu is based on the amount of 
-- time it takes to prepare one item. Assume that whoever is preparing the 
-- food is being paid $13 an hour. List the most profitable items first. 
-- prep_time is represented in minutes and ingredient_cost and menu_price 
-- are in dollars and cents.

SELECT item, menu_price, ingredient_cost, 
round(prep_time / 60.0 * 13.0, 2) AS labor,
menu_price - ingredient_cost - round(prep_time/60.0 * 13.0, 2) AS profit FROM menu_items
ORDER BY profit DESC;