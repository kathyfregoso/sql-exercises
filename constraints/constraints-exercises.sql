-- modify all columns to be NOT NULL

ALTER TABLE films ALTER COLUMN title SET NOT NULL;

ALTER TABLE films ALTER COLUMN year SET NOT NULL;

ALTER TABLE films ALTER COLUMN genre SET NOT NULL;

ALTER TABLE films ALTER COLUMN director SET NOT NULL;

ALTER TABLE films ALTER COLUMN duration SET NOT NULL;

-- add unique constraint to title column

ALTER TABLE films ADD UNIQUE (title);

-- drop unique constraint from title column

ALTER TABLE films DROP CONSTRAINT films_title_key;

-- add a constraint to films req. all rows to have a value for title
-- that's at least 1 char long

ALTER TABLE films ADD CHECK (length(title) >= 1);

-- if violated

INSERT INTO films(title, year, genre, director, duration) VALUES 
('', 2006, 'period piece', 'sofia coppola', 120);

-- we can an error:
-- ERROR:  new row for relation "films" violates check constraint "films_title_check"
-- DETAIL:  Failing row contains (, 2006, period piece, sofia coppola, 120).

-- remove check constriant

ALTER TABLE films DROP CONSTRAINT films_title_check;

ALTER TABLE films ADD CHECK (year BETWEEN 1900 AND 2100);

-- add constraint that requires all rows to have a value for director
-- that's at least 3 chars long and has at least 1 space char

ALTER TABLE films
ADD CHECK (length(director) >= 3 AND (position(' ' IN director) > 0));

-- write UPDATE that leads to error

UPDATE films SET director = 'Johnny';

-- error text:
-- ERROR:  new row for relation "films" violates check constraint "films_director_check"
-- DETAIL:  Failing row contains (Die Hard, 1988, action, Johnny, 132).

-- three ways to use schema to restrict values:
-- constraints
-- check constraints
-- default values

-- Is it possible to define a default value for a column that will be 
-- considered invalid by a constraint? Create a table that tests this.

CREATE TABLE pets (
  id serial,
  name text NOT NULL,
  age decimal(3,1) DEFAULT 0
);

ALTER TABLE pets ADD CHECK (age BETWEEN 1 AND 3);

INSERT INTO pets (name) VALUES ('anabelle');

-- error:
-- ERROR:  new row for relation "pets" violates check constraint "pets_age_check"
-- DETAIL:  Failing row contains (1, anabelle, 0.0).
