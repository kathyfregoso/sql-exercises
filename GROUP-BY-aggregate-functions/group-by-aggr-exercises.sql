-- insert data into table films

INSERT INTO films (title, year, genre, director, duration) VALUES
('Wayne''s World', 1992, 'comedy', 'Penelope Spheeris', 95),
('Bourne Identity', 2002, 'espionage', 'Doug Liman', 118);

--  list all genres for which there is a movie in the films table.

SELECT DISTINCT genre FROM films;

-- do the same without DISTINCT

SELECT genre FROM films GROUP BY genre;

-- get avg duration of all movies rounded to nearest minute

SELECT round(avg(duration)) FROM films;

-- determine the average duration for each genre
-- in the films table, rounded to the nearest minute.

SELECT genre, round(avg(duration)) AS average_duration 
FROM films GROUP BY genre;

--determine the average duration of movies for each decade represented in
--  the films table rounded to the nearest minute and listed in chronological 
-- order.

SELECT year / 10 * 10 AS decade, round(avg(duration)) AS average_duration
FROM films GROUP BY decade ORDER BY decade ASC;

-- find all films whose director has the first name John

SELECT * FROM films WHERE director LIKE 'John%';

-- return data

SELECT DISTINCT genre, count(genre) 
FROM films GROUP BY genre ORDER BY count DESC;

-- return data

SELECT year / 10 * 10 AS decade, genre, 
string_agg(title, ', ') AS films FROM films
GROUP BY decade, genre ORDER BY decade ASC, genre ASC, films DESC;

-- return data

SELECT DISTINCT genre, sum(duration) AS total_duration FROM films
GROUP BY genre ORDER BY total_duration ASC;