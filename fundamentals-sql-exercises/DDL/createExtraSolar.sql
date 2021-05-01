- createdb extrasolar

- psql -d extrasolar

CREATE TABLE stars (
  id serial PRIMARY KEY,
  name varchar(25) UNIQUE NOT NULL,
  distance int NOT NULL,
  spectral_type char(1),
  companions int NOT NULL,
  CONSTRAINT distance_not_zero CHECK (distance > 0),
  CONSTRAINT companions_not_neg CHECK (companions >= 0)
);

CREATE TABLE planets (
  id serial PRIMARY KEY,
  designation char(1),
  mass int
);