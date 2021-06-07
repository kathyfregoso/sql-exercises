CREATE TABLE students (
    id serial PRIMARY KEY, --UNIQUE NOT NULL
    name character varying(25) NOT NULL,
		age int NOT NULL,
    enrolled boolean DEFAULT true
);

CREATE TABLE tutors (
  student_id int PRIMARY KEY, -- Both a primary and foreign key of tutors
  name varchar(30) NOT NULL,
  subject varchar(30) NOT NULL,
  degree varchar(30) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students (id) ON DELETE CASCADE
);

INSERT INTO students (name, age) VALUES
('Angelica', 7),
('Bradley', 10),
('Xochitl', 12),
('Amanda', 6),
('Kim', 10);

INSERT INTO tutors (student_id, name, subject, degree) VALUES 
(1, 'Kathy Fregoso', 'Computer Science', 'Masters'),
(2, 'Joy Wilfong', 'Science', 'Masters'),
(3, 'Gaby LaFarge', 'Writing', 'Masters'),
(4, 'Grant Mueller', 'English', 'Bachelors'),
(5, 'Rocio Hernandez', 'PE', 'High School Diploma');

-- INNER JOIN
SELECT students.name AS student, tutors.name AS tutor, tutors.subject FROM students
JOIN tutors ON students.id = tutors.student_id;
