-- CREATE TABLE directors (
--    id integer NOT NULL,
--    name text NOT NULL,
--    CONSTRAINT valid_name CHECK (((length(name) >= 1) AND 
-- ("position"(name, ' '::text) > 0)))
--);

-- CREATE TABLE films (
--    id serial PRIMARY KEY,
--    title character varying(255) NOT NULL,
--    year integer NOT NULL,
--    genre character varying(100) NOT NULL,
--    duration integer NOT NULL,
--    director_id integer NOT NULL,
--   CONSTRAINT title_length CHECK ((length((title)::text) >= 1)),
--    CONSTRAINT year_range CHECK (((year >= 1900) AND (year <= 2100)))
--);

-- 2. Write the SQL statement needed to create a join table 
-- that will allow a film to have multiple directors, and 
-- directors to have multiple films. Include an id column 
-- in this table, and add foreign key constraints to the 
-- other columns.

CREATE TABLE directors_films (
  id serial PRIMARY KEY,
  director_id int,
  film_id int,
  FOREIGN KEY (director_id) REFERENCES directors(id),
  FOREIGN KEY (film_id) REFERENCES films(id)
);

-- 3. Write the SQL statements needed to insert data into 
-- the new join table to represent the existing 
-- one-to-many relationships.

INSERT INTO directors_films (id, director_id, film_id) VALUES 
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3),
  (4, 4, 4),
  (5, 5, 5),
  (6, 6, 6),
  (7, 3, 7),
  (8, 7, 8),
  (9, 8, 9),
  (10, 4, 10);

-- 4. Write a SQL statement to remove any unneeded columns 
-- from films.

ALTER TABLE films DROP COLUMN director_id;

-- 5. Write a SQL statement that will return the following
-- result:

--           title           |         name
---------------------------+----------------------
-- 12 Angry Men              | Sidney Lumet
-- 1984                      | Michael Anderson
-- Casablanca                | Michael Curtiz
-- Die Hard                  | John McTiernan
-- Let the Right One In      | Michael Anderson
-- The Birdcage              | Mike Nichols
-- The Conversation          | Francis Ford Coppola
-- The Godfather             | Francis Ford Coppola
-- Tinker Tailor Soldier Spy | Tomas Alfredson
-- Wayne's World             | Penelope Spheeris
-- (10 rows)

SELECT films.title, directors.name FROM films JOIN directors_films
ON films.id = directors_films.film_id
JOIN directors
ON directors.id = directors_films.director_id ORDER BY films.title;

-- 6. Write SQL statements to insert data for the following films 
-- into the database

INSERT INTO films (id, title, "year", genre, duration) VALUES
(11, 'Fargo', 1996, 'comedy', 98),
(12, 'No Country for Old Men', 2007, 'western', 122),
(13, 'Sin City', 2005, 'crime', 124),
(14, 'Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors ("name") VALUES 
('Joel Coen'), 
('Ethan Coen'), 
('Frank Miller'), 
('Robert Rodriguez');

INSERT INTO directors_films (id, film_id, director_id) VALUES
(11, 11, 9),
(12, 12, 9),
(13, 12, 10),
(14, 13, 11),
(15, 13, 12),
(16, 14, 12);

-- 7. Write a SQL statement that determines how many films each 
-- director in the database has directed. Sort the results by number 
-- of films (greatest first) and then name (in alphabetical order).

--				director      | films
----------------------+-------
-- Francis Ford Coppola |     2
-- Joel Coen            |     2
-- Michael Anderson     |     2
-- Robert Rodriguez     |     2
-- Ethan Coen           |     1
-- Frank Miller         |     1
-- John McTiernan       |     1
-- Michael Curtiz       |     1
-- Mike Nichols         |     1
-- Penelope Spheeris    |     1
-- Sidney Lumet         |     1
-- Tomas Alfredson      |     1
-- (12 rows)

-- Assume that every director has at least one film.

SELECT directors.name AS director, count(directors_films.film_id) AS films FROM directors
JOIN directors_films ON directors.id = directors_films.director_id
GROUP BY director ORDER BY films DESC, director ASC;