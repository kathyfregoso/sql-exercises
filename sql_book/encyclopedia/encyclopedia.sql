-- Create table called countries

CREATE TABLE countries (
  id serial,
  name varchar(50) UNIQUE NOT NULL,
  capital varchar(50) NOT NULL,
  population integer
);

-- Create a table called famous_people

CREATE TABLE famous_people (
  id serial,
  name varchar(100) NOT NULL,
  occupation varchar(150),
  date_of_birth varchar(50),
  deceased boolean DEFAULT false
);

-- create a table called animals

CREATE TABLE animals (
  id serial,
  animal varchar(100) NOT NULL,
  binomial_name varchar(100) NOT NULL,
  max_weight_kg decimal(8, 3),
  max_age_yrs int,
  conservation_status char(2)
);

-- connect to the encyclopedia database. 

-- Rename the famous_people table to celebrities.

ALTER TABLE famous_people RENAME TO celebrities;

-- Change the name of the name column in the celebrities table to first_name, 
-- and change its data type to varchar(80).

ALTER TABLE celebrities RENAME COLUMN name TO first_name;

ALTER TABLE celebrities ALTER COLUMN first_name TYPE varchar(80);

-- Create a new column in the celebrities table called last_name. 
-- It should be able to hold strings of lengths up to 100 characters. 
-- This column should always hold a value.

ALTER TABLE celebrities ADD COLUMN last_name varchar(100) NOT NULL;

-- Change the celebrities table so that the date_of_birth column uses a 
-- data type that holds an actual date value rather than a string. 
-- Also ensure that this column must hold a value.

ALTER TABLE celebrities 
ALTER COLUMN date_of_birth TYPE date USING date_of_birth::date;

ALTER TABLE celebrities 
ALTER COLUMN date_of_birth SET NOT NULL;

-- Change the max_weight_kg column in the animals table so that it can hold
-- values in the range 0.0001kg to 200,000kg

ALTER TABLE animals ALTER COLUMN max_weight_kg TYPE decimal(10, 2);

-- Change the animals table so that the binomial_name column cannot contain 
-- duplicate values.

ALTER TABLE animals ADD UNIQUE (binomial_name);

-- Add data to the countries table

INSERT INTO countries (name, capital, population) VALUES
('France', 'Paris', 67158000);

INSERT INTO countries (name, capital, population) VALUES
('USA', 'Washington D.C.', 325365189),
('Germany', 'Berlin', 82349400),
('Japan', 'Tokyo', 126672000);

-- Add entries to the famous_people table

INSERT INTO celebrities (name, occupation, date_of_birth, deceased)
VALUES ('Bruce Springsteen', 'singer/songwriter', '09-23-1949', DEFAULT);

INSERT INTO celebrities (name, occupation, date_of_birth, deceased)
VALUES ('Scarlett Johansson', 'actress', '11-22-1984', DEFAULT);

INSERT INTO celebrities (name, occupation, date_of_birth, deceased)
VALUES ('Frank Sinatra', 'singer/actor', '12-12-1915', true),
('Tom Cruise', 'actor', '07-03-1962', DEFAULT);

-- update last_name column and add data

ALTER TABLE celebrities ALTER COLUMN last_name DROP NOT NULL;

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
VALUES ('Madonna', 'singer/actress', '08-16-1958', DEFAULT),
('Prince', 'singer, songwriter, musician, actor', '06-07-1958', false);

UPDATE celebrities SET first_name = 'Bruce' WHER

-- Check the schema of the celebrities table. What would happen if we specify 
-- a NULL value for deceased column

INSERT INTO celebrities (first_name, occupation, date_of_birth, deceased)
VALUES ('Elvis Presley', 'singer, musician, actor', '01-08-1935', NULL);

-- the data is inserted to table, since we removed the NOT NULL constraint

-- Check the schema of the animals table

-- \d animals

-- if we try to input that data, we get an error because of the UNIQUE constraint

-- to remove the UNIQUE constraint:

ALTER TABLE animals DROP CONSTRAINT animals_binomial_name_key;

INSERT INTO animals (animal, binomial_name, max_weight_kg, max_age_yrs, conservation_status)
             VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
                    ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
                    ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
                    ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
                    ('Kakapo', 'Strigops habroptila', 4, 60,'CR');

-- in countries table, write a query to retrieve the population of the USA.

SELECT population FROM countries WHERE name = 'USA';

-- query to return the population and the capital (in that order) of all the countries in the table.

SELECT population, capital FROM countries;

-- query to return the names of all the countries ordered alphabetically

SELECT name FROM countries ORDER BY name;

-- query to return the names and the capitals of all the countries in order of population, 
-- from lowest to highest.

SELECT name, capital FROM countries ORDER BY population;

-- same info as above, ordered from highest to lowest.

SELECT name, capital FROM countries ORDER BY population DESC;

-- query on the animals table, using ORDER BY, that will return output

SELECT animal, binomial_name, max_weight_kg, max_age_yrs FROM animals
ORDER BY max_age_yrs, max_weight_kg, animal DESC;

-- query that returns the names of all the countries with a population > 70 million.

SELECT name FROM countries WHERE population > 70000000;

-- query that returns the names of all the countries with a population greater than 
-- 70 million but less than 200 million.

SELECT name FROM countries WHERE population > 70000000 AND population < 200000000;

-- query that will return the first name and last name of all entries in 
-- the celebrities table where the value of the deceased column is not true.

SELECT first_name, last_name FROM celebrities
WHERE deceased IS NULL OR deceased != true;

-- query all first and last names of all celebrities that sing

SELECT first_name, last_name FROM celebrities 
WHERE occupation ILIKE '%sing%';

-- return the first and last names of all the celebrities who act

SELECT first_name, last_name FROM celebrities 
WHERE occupation ILIKE '%act%';

-- return the first and last names of all the celebrities who both sing and act

SELECT first_name, last_name FROM celebrities 
WHERE occupation ILIKE '%act%' AND occupation ILIKE '%sing%';

-- retrieve the first row of data from the countries table

SELECT * FROM countries LIMIT 1;

-- retrieve the name of the country with the largest population.

SELECT name FROM countries ORDER BY population DESC LIMIT 1;

-- retrieve the name of the country with the second largest population

SELECT name FROM countries ORDER BY population DESC LIMIT 1 OFFSET 1;

-- retrieve all of the unique values from the binomial_name column of the animals table

SELECT DISTINCT binomial_name FROM animals;

-- return the longest binomial name from the animals table.

SELECT binomial_name FROM animals ORDER BY length(binomial_name) DESC LIMIT 1;

--  return the first name of any celebrity born in 1958.

SELECT first_name FROM celebrities WHERE extract(year FROM date_of_birth) = '1958';

-- return the highest maximum age from the animals table

SELECT max_age_yrs FROM animals ORDER BY max_age_yrs DESC LIMIT 1;

-- or

SELECT max(max_age_yrs) FROM animals;

-- return the average maximum weight from the animals table. 

SELECT avg(max_weight_kg) FROM animals;

-- return the number of rows in the countries table

SELECT count(*) FROM countries;

-- return the total population of all the countries in the countries table

SELECT sum(population) FROM countries;

-- return each unique conservation status code and the number of animals 
-- that have that code.

SELECT DISTINCT conservation_status, count(animal) FROM animals GROUP BY conservation_status;

-- Add a column to the animals table called class to hold strings of up to 100 characters.
-- Update all the rows in the table so that this column holds the value Aves.

ALTER TABLE animals ADD COLUMN class varchar(100);

UPDATE animals SET class = 'Aves';

-- Add two more columns to the animals table called phylum and kingdom. 
-- Both should hold strings of up to 100 characters.
-- Update all the rows in the table so that phylum holds the value 
-- Chordata and kingdom holds Animalia for all the rows in the table.

ALTER TABLE animals ADD COLUMN phylum varchar(100),
ADD COLUMN kingdom varchar(100);

UPDATE animals SET phylum = 'Chordata';
UPDATE animals SET kingdom = 'Animalia';

-- Add a column to the countries table called continent to hold strings of up to 
-- 50 characters.
-- Update all the rows in the table so France and Germany have a value of Europe 
-- for this column, Japan has a value of Asia and the USA has a value of North America.

ALTER TABLE countries ADD COLUMN continent varchar(50);

UPDATE countries SET continent = 'Europe' WHERE name = 'France' OR name = 'Germany';

UPDATE countries SET continent = 'Asia' WHERE name = 'Japan';

UPDATE countries SET continent = 'North America' WHERE name = 'USA';

-- In the celebrities table, update the Elvis row so that the value in the 
-- deceased column is true. Then change the column so that it no longer allows NULL values.

UPDATE celebrities SET deceased = true WHERE first_name ILIKE 'Elvis%';

ALTER TABLE celebrities ALTER COLUMN deceased SET NOT NULL;

-- Remove Tom Cruise from the celebrities table.

DELETE FROM celebrities WHERE first_name = 'Tom Cruise';

-- Change the name of the celebrities table to singers, and remove anyone who isn't a singer.

ALTER TABLE celebrities RENAME TO singers;

DELETE FROM singers WHERE occupation NOT ILIKE 'singer%';

-- Remove all the rows from the countries table.

DELETE FROM countries;

-- move continent data into a separate table from the country data

CREATE TABLE continents (
  id serial PRIMARY KEY,
  continent_name varchar(50)
);

ALTER TABLE countries DROP COLUMN continent;

ALTER TABLE countries ADD COLUMN continent_id int REFERENCES continents (id);

-- add data to the countries and continents tables. Add both the countries and the 
-- continents to their respective tables in alphabetical order.

INSERT INTO continents (continent_name) VALUES
('Europe'),
('North America'),
('Asia'),
('Africa'),
('South America');

INSERT INTO countries (name, capital, population, continent_id) VALUES 
('France', 'Paris', 67158000, 1),
('USA', 'Washington D.C.', 325365189, 2),
('Germany', 'Berlin', 82349400, 1),
('Japan', 'Tokyo', 126672000, 3),
('Egypt', 'Cairo', 96308900, 4),
('Brazil', 'Brasilia', 208385000, 5);

-- create albums table to hold album data except singer name
-- reference from the albums table to singers table to link each album to singer.
-- populate table with data.  Assume Album Name, Genre, and Label can hold strings 
-- up to 100 characters. Include an auto-incrementing id column in the albums table.

ALTER TABLE singers ADD PRIMARY KEY (id);

CREATE TABLE albums (
  id serial PRIMARY KEY,
  album_name varchar(100),
  released date,
  genre varchar(100),
  label varchar(100),
  singer_id int REFERENCES singers (id)
);


INSERT INTO albums (album_name, released, genre, label, singer_id) VALUES
('Born to Run', '08-25-1975', 'rock and roll', 'Columbia', 1),
('Purple Rain', '06-25-1984', 'pop, R&B, rock', 'WB', 6),
('Born in the USA', '06-04-1984', 'rock and roll, pop', 'Columbia', 1),
('Madonna', '07-27-1983', 'dance-pop', 'WB', 5),
('True Blue', '06-30-1986', 'dance-pop', 'WB', 5),
('Elvis', '10-19-1956', 'rock and roll, rhythm and blues', 'RCA Victor', 7),
('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);

-- return all of the country names along with their appropriate continent names.

SELECT countries.name, continents.continent_name FROM countries
LEFT OUTER JOIN continents ON countries.continent_id = continents.id;

-- return all the names and capitals of european countries

SELECT countries.name, countries.capital FROM countries
JOIN continents ON countries.continent_id = continents.id
WHERE continents.continent_name = 'Europe';

-- return the first name of any singer who had an album released under 
-- the Warner Bros label.

SELECT DISTINCT singers.first_name FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE albums.label = 'WB';

--  return the first name and last name of any singer who released an album 
-- in the 80s and who is still living, along with the names of the album that 
-- was released and the release date. Order the results by youngest to oldest 
-- age.

SELECT singers.first_name, albums.album_name, albums.released 
FROM singers JOIN albums
ON singers.id = albums.singer_id
WHERE albums.released >= '1980-01-01'
AND albums.released <= '1989-12-31'
AND singers.deceased = false
ORDER BY singers.date_of_birth DESC;

-- return the first name and last name of any celebrity without an 
-- associated album entry.

SELECT singers.first_name FROM singers LEFT JOIN albums
ON singers.id = albums.singer_id
WHERE albums.id IS NULL;

-- rewrite the query for previous as subquery

SELECT singers.first_name FROM singers
WHERE singers.id NOT IN (SELECT albums.singer_id FROM albums);
