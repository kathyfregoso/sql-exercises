DROP TABLE IF EXISTS public.films;
CREATE TABLE films (title varchar(255), "year" integer, genre varchar(100));

INSERT INTO films(title, "year", genre) VALUES ('Die Hard', 1988, 'action');  
INSERT INTO films(title, "year", genre) VALUES ('Casablanca', 1942, 'drama');  
INSERT INTO films(title, "year", genre) VALUES ('The Conversation', 1974, 'thriller');  

-- 1. this file creates a table called films and inserts 3 rows of data
-- 2. psql -d movies < films1.sql outputs:
  -- DROP TABLE
  -- CREATE TABLE
  -- INSERT 0 1
  -- INSERT 0 1
  -- INSERT 0 1
  --
-- 3. checks if a films table already exists, if it does, it deletes it

-- return all rows in films

SELECT * FROM films;

-- return rows with title < 12 letters

SELECT title FROM films WHERE length(title) < 12;

-- add 2 extra columns to films: director and duration

ALTER TABLE films ADD COLUMN director text,
ADD COLUMN duration int;

-- update existing rows to add new values

UPDATE films SET director = 'John McTiernan', duration = 132 
  WHERE title = 'Die Hard';

UPDATE films SET director = 'Michael Curtiz', duration = 102 
  WHERE title = 'Casablanca';

UPDATE films SET director = 'Francis Ford Coppola', duration = 113 
  WHERE title = 'The Conversation';

-- insert more data:

INSERT INTO films (title, year, genre, director, duration) VALUES
('1984', 1956, 'scifi', 'Michael Anderson', 90),
('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);

-- return title and age in years of each movie, newest movies listed first

SELECT title, extract("year" FROM current_date) - "year" AS age FROM films
ORDER BY age;

-- return title and duration for movies > 2 hrs, longest first

SELECT title, duration FROM films
WHERE duration > 120
ORDER BY duration DESC;

-- return title of longest film

SELECT title FROM films
ORDER BY duration DESC LIMIT 1;