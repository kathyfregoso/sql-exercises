-- 1. Write a SQL statement to add the following call data to the database:

INSERT INTO calls ("when", duration, contact_id) VALUES
('2016-01-18 14:47:00', 632, 6);

-- 2. Write a SQL statement to retrieve the call times, duration, and first 
-- name for all calls not made to William Swift.

SELECT calls.when, calls.duration, contacts.first_name FROM calls
JOIN contacts ON calls.contact_id = contacts.id 
WHERE contacts.first_name != 'William';

-- 3. Write SQL statements to add call data to the database

INSERT INTO contacts (first_name, last_name, number) VALUES
('Merve', 'Elk', 6343511126),
('Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls ("when", duration, contact_id) VALUES
('2016-01-17 11:52:00', 175, 27),
('2016-01-18 21:22:00', 79, 28);

-- 4. Add a constraint to contacts that prevents a 
-- duplicate value being added in the column number.

ALTER TABLE contacts ADD CONSTRAINT unique_number UNIQUE (number);

-- 5. Write a SQL statement that attempts to insert a duplicate number for 
-- a new contact but fails. What error is shown?

INSERT INTO contacts (first_name, last_name, number) VALUES
('Kathy', 'Liv', 6343511126);

-- ERROR:  duplicate key value violates unique constraint "unique_number"
-- DETAIL:  Key (number)=(6343511126) already exists.

-- 6. "when" needs to be quoted because it is a reserved keyword in psql

-- 7. 