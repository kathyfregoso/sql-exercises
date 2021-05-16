-- there is Data Definition Language (DDL), which is used to manage the schema of a database.
-- this includes creating and deleting databases, tables, adding or removing constraints, managing data types, etc.
-- some examples of DDL statements are ALTER, CREATE, DROP, etc
-- There is also Data Manipulation Language (DML), which manages the content of a table or db. This includes
-- UPDATE, DELETE, INSERT, SELECT etc

SELECT column_name FROM my_table; -- DML statement

CREATE TABLE things ( -- DDL statement 
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
); 

ALTER TABLE things -- this is DDL because you are changing the data characteristics, not the content
DROP CONSTRAINT things_item_key;

INSERT INTO things VALUES (3, 'Scissors', 'Metal'); -- this is DML because it changes the table content/data

UPDATE things -- this is DML, it updates the data in a table
SET material = 'plastic'
WHERE item = 'Cup';

-- \d things
-- \d is a psql console command, so it's not part of SQL, so it's not technically a sublanguage, like DDL.

DELETE FROM things WHERE item = 'Cup'; -- DML because you remove row(s) of content

DROP DATABASE xyzzy; -- DDL manipulates how data is structured

CREATE SEQUENCE part_number_sequence; -- DDL