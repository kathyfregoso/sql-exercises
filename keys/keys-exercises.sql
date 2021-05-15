-- make a new sequence called counter

CREATE SEQUENCE counter;

-- Write a SQL statement to retrieve the next value from the sequence counter

SELECT nextval('counter');

-- removes a sequence called "counter".

DROP SEQUENCE counter;

-- Is it possible to create a sequence that returns only even numbers?

CREATE SEQUENCE counter INCREMENT BY 2 MINVALUE 2;

-- what is the name of sequence in this statement?

CREATE TABLE regions (
	id serial PRIMARY KEY, 
	name text, 
	area integer
	);

-- regions_id_seq (check with \ds)

--add an auto-incrementing integer primary key column to the films table.

ALTER TABLE films ADD COLUMN id serial PRIMARY KEY;

-- error if you attempt to update value for id already used by a row?

UPDATE films SET id = 3 WHERE title = 'Die Hard';

-- ERROR:  duplicate key value violates unique constraint "films_pkey"
-- DETAIL:  Key (id)=(3) already exists.

-- What error do you receive if you attempt to add another primary key
-- column to the films table?

ALTER TABLE films ADD COLUMN time int PRIMARY KEY;

-- ERROR:  multiple primary keys for table "films" are not allowed

-- modify the table films to remove its primary key while preserving the
-- id column and the values it contains.

ALTER TABLE films DROP CONSTRAINT films_pkey;