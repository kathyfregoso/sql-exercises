CREATE TABLE birds (
  id serial PRIMARY KEY,
  name varchar(25),
  age int,
  species varchar(15)
);

INSERT INTO birds (name, age, species) VALUES
('Charlie', 3, 'Finch'),
('Allie', 4, 'Owl'),
('Jennifer', 3, 'Magpie'),
('Jamie', 4, 'Owl'),
('Roy', 8, 'Crow');

SELECT * FROM birds;

SELECT * FROM birds WHERE age < 5;

UPDATE birds SET species = 'Raven' WHERE name = 'Roy';

DELETE FROM birds WHERE species = 'Finch';

ALTER TABLE birds ADD CHECK (age > 0);

INSERT INTO birds (name, age, species) VALUES
('delilah', -3, 'flamingo');

-- ERROR:  new row for relation "birds" violates check constraint "birds_age_check"
-- DETAIL:  Failing row contains (6, delilah, -3, flamingo).

DROP TABLE birds;