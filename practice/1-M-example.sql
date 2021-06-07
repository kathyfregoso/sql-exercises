CREATE TABLE mayors (
  id serial PRIMARY KEY,
  name varchar(100) NOT NULL,
  party varchar(100) NOT NULL,
  income decimal(6,2) NOT NULL,
	govt_id int,
  UNIQUE (govt_id)
);

ALTER TABLE mayors ADD COLUMN city varchar(50) NOT NULL;
ALTER TABLE mayors ALTER COLUMN govt_id SET DEFAULT 0;
ALTER TABLE mayors ALTER COLUMN income TYPE decimal(9,2);
ALTER TABLE mayors DROP CONSTRAINT mayors_govt_id_key;
ALTER TABLE mayors DROP COLUMN govt_id;

/*
 one-to-many: mayor has many constituent_residents
*/

CREATE TABLE constituent_residents (
  id serial PRIMARY KEY,
  mayor_id integer NOT NULL,
  resident_name varchar(255) NOT NULL,
  party varchar(50) DEFAULT 'n/a',
  dob date NOT NULL,
  address varchar(255),
  FOREIGN KEY (mayor_id) REFERENCES mayors(id) ON DELETE CASCADE
);

INSERT INTO mayors (name, party, income, city) VALUES
  ('James T. Butts', 'Democrat', 500000.00, 'Inglewood'),
  ('Eric Garcetti', 'Democrat', 300000.00, 'Los Angeles'),
  ('Tasha Cerda', 'Democrat', 250000.00, 'Gardena');


INSERT INTO constituent_residents (mayor_id, resident_name, party, dob, address) VALUES
  (5, 'Christie Lothrop', 'Democrat', '1985-04-30', '830 Glenway Drive'),
  (6, 'Alex Dishal', 'Democrat', '1993-09-04', '3459 Ashland Ave'),
  (7, 'Ali Marken', 'Democrat', '1994-07-07', '123 Lomita St');

  INSERT INTO constituent_residents (mayor_id, resident_name, party, dob, address) VALUES
  (6, 'Ramiro Hernandez', 'Democrat', '1956-05-01', '55 Avalon Blvd');