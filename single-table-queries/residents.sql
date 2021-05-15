-- list 10 states with most rows in people table in desc order

SELECT state, count(*) FROM people GROUP BY state
ORDER BY count(*) DESC LIMIT 10;

-- list each domain used in an email address and how many people in db
-- have an email address with that domain (most popular first)

SELECT DISTINCT substr(email, strpos(email, '@') + 1) AS domain,
count(*)
FROM people GROUP BY domain
ORDER BY count(*) DESC;

-- delete person with id 3399

DELETE FROM people WHERE id = 3399;

-- delete all users located in CA

DELETE FROM people WHERE state = 'CA';

-- update given_name to uppercase for users with teleworm.us email

UPDATE people SET given_name = upper(given_name)
WHERE email LIKE '%teleworm.us';

-- delete all rows