CREATE TABLE employees (
    first_name character varying(100),
    last_name character varying(100),
    department character varying(100),
    vacation_remaining integer
);

INSERT INTO employees VALUES ('Leonardo', 'Ferreira', 'finance', 14);
INSERT INTO employees VALUES ('Sara', 'Mikaelsen', 'operations', 14);
INSERT INTO employees VALUES ('Lian', 'Ma', 'marketing', 13);

INSERT INTO employees (first_name, last_name) VALUES ('Haiden', 'Smith');

DELETE FROM employees WHERE vacation_remaining IS NULL;

ALTER TABLE employees ALTER COLUMN vacation_remaining SET DEFAULT 0;

-- set default value of column department to "unassigned"
-- then set department column to "unassigned" for any rows where it
-- has a NULL value
-- then add a NOT NULL constraint to the department column

ALTER TABLE employees ALTER COLUMN department SET DEFAULT 'unassigned';

UPDATE employees SET department = 'unassigned'
WHERE department IS NULL;

ALTER TABLE employees ALTER COLUMN department SET NOT NULL;

-- create temperatures table

CREATE TABLE temperatures (
  id serial,
  date date NOT NULL,
  low int NOT NULL,
  high int NOT NULL
);

-- insert data

INSERT INTO temperatures (date, low, high) VALUES
('2016-03-01', 34, 43),
('2016-03-02', 32, 44),
('2016-03-03', 31, 47),
('2016-03-04', 33, 42),
('2016-03-05', 39, 46),
('2016-03-06', 32, 43),
('2016-03-07', 29, 32),
('2016-03-08', 23, 31),
('2016-03-09', 17, 28);

-- determine avg (mean) temp - devide sum of high and low temps by two
-- for each day from march 2 to march 8 2016. round to one decimal place

SELECT date, round((high + low) / 2, 1) AS average FROM temperatures
WHERE date BETWEEN '2016-03-02' AND '2016-03-08';

-- add a new column named rainfall

ALTER TABLE temperatures ADD COLUMN rainfall int DEFAULT 0;

--update data tp reflect that it rains one mm for every degree
-- the avg temp goes above 35

UPDATE temperatures SET rainfall = (((high + low) / 2)) - 35
WHERE ((high + low) / 2) > 35;

-- modify rainfall to reflect data in inches not mm

ALTER TABLE temperatures ALTER COLUMN rainfall TYPE decimal(4, 3);

UPDATE temperatures SET rainfall = rainfall * 0.039370;

-- change name of temperatures to weather

ALTER TABLE temperatures RENAME TO weather;