CREATE TABLE library_users (
  id serial PRIMARY KEY,
  name varchar(100)
);

CREATE TABLE books (
  id serial PRIMARY KEY,
  name varchar(100),
  author varchar(100),
  isbn int
);

INSERT INTO library_users (name) VALUES
 ('Linda Phillips'),
 ('Natalie Bradley'),
 ('Javier Dean'),
 ('Alma Flores'),
 ('Jessie Meyer');

 INSERT INTO books (name, author, isbn) VALUES
 ('On the Road', 'Jack Kerouac', 9780140),
 ('A Game of Thrones', 'George RR Martin', 9780553),
 ('The Da Vinci Code', 'Dan Brown', 9780307),
 ('The Handmaid''s Tale', 'Margaret Atwood', 978038),
 ('Jazz', 'Toni Morrison', 9781400),
 ('1Q84', 'Haruki Murakami', 9780307);

CREATE TABLE checkouts (
  id serial PRIMARY KEY,
  user_id int REFERENCES library_users(id),
  book_id int REFERENCES books(id),
  checkout_date date,
  return_date date
);

INSERT INTO checkouts (user_id, book_id, checkout_date, return_date) VALUES
(3, 1, '2016-02-15', '2016-03-11'),
(3, 2, '2016-03-11', '2016-05-02'),
(5, 5, '2017-11-25', '2017-12-18'),
(1, 4, '2017-12-22', NULL),
(4, 6, '2018-01-02', NULL);

-- get the name of any user who had ever checked out a book

SELECT DISTINCT library_users.name FROM library_users RIGHT JOIN
checkouts ON library_users.id = checkouts.user_id;

-- alternative 

SELECT DISTINCT library_users.name
  FROM library_users INNER JOIN checkouts
  ON library_users.id = checkouts.user_id;

-- alternative

SELECT DISTINCT library_users.name
  FROM library_users JOIN checkouts
  ON library_users.id = checkouts.user_id
  JOIN books ON books.id = checkouts.book_id;

-- subquery alternative to above:

SELECT name FROM library_users WHERE id IN -- matches ids with those in
-- subquery table
(SELECT user_id FROM checkouts); -- returns all user_id numbers

-- what does this query return?

SELECT library_users.name AS "User Name",
  count(checkouts.id) AS "Books Checked Out"
  FROM library_users JOIN checkouts
  ON library_users.id = checkouts.user_id
  GROUP BY "User Name"
  ORDER BY "User Name" ASC;

  -- The query uses JOIN (aka INNER JOIN) and
  -- would only return rows from library_users if there was a matching row in 
  -- checkouts.
  -- The query specifies an ascending order using the values in User Name column

-- query to return all rows from the two tables, even if there are no matches

  SELECT library_users.name AS "User Name",
    books.name AS "Books Checked Out"
    FROM library_users 
    LEFT OUTER JOIN checkouts
    ON library_users.id = checkouts.user_id
    FULL OUTER JOIN books
    ON checkouts.book_id = books.id;

    -- alternative

    SELECT lu.name AS "User Name", b.name AS "Books Checked Out"
  FROM library_users AS lu FULL OUTER JOIN checkouts c
  ON lu.id = c.user_id
  FULL OUTER JOIN books b
  ON b.id = c.book_id;