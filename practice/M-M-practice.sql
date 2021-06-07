CREATE TABLE professors (
  id serial PRIMARY KEY,
	name varchar(200)
);

ALTER TABLE professors ADD COLUMN department varchar(200);

CREATE TABLE courses (
  id serial PRIMARY KEY,
	course_name varchar(200)
);

CREATE TABLE courses_professors (
	id serial PRIMARY KEY,
  professor_id integer REFERENCES professors (id) ON DELETE CASCADE NOT NULL,
  course_id integer REFERENCES courses (id) ON DELETE CASCADE NOT NULL
);

INSERT INTO professors (name, department) VALUES
('Alexis Sandoval', 'Russian Studies'),
('Erik Miller', 'Economics'),
('Cal Newport', 'Computer Science');

INSERT INTO professors (name, department) VALUES
('Francisco Polya', 'Chicano Studies');

INSERT INTO professors (name, department) VALUES
('Fran Weiss', 'Economics');

INSERT INTO courses (id, course_name) VALUES
(1, '19th Century Russian History'),
(2, 'Economics 1'),
(3, 'Intro to Data Structures and Algorithms');

INSERT INTO courses (id, course_name) VALUES
(4, 'Russian Literature'),
(5, 'Intro to Java'),
(6, 'Discrete Mathematics'),
(7, 'Macroeconomics'),
(8, 'Community Organizing 101');

INSERT INTO courses_professors (professor_id, course_id) VALUES
(1, 1),
(1, 4),
(2, 2),
(2, 7),
(3, 3),
(3, 5),
(3, 6),
(5, 2);

SELECT courses_professors.id, professors.name, courses.course_name FROM professors INNER JOIN
courses_professors ON courses_professors.professor_id = professors.id
INNER JOIN courses ON courses_professors.course_id = courses.id;


SELECT professors.name, courses.course_name FROM professors FULL OUTER JOIN
courses_professors ON courses_professors.professor_id = professors.id
FULL OUTER JOIN courses ON courses_professors.course_id = courses.id;