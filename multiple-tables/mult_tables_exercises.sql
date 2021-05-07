-- https://launchschool.com/lessons/5ae760fa/assignments/285d837e

-- 2. Write a query 
-- that determines how many tickets have been sold.

-- count
-------
-- 3783
-- (1 row)

SELECT count(seat_id) FROM tickets;

-- 3. Write a query that determines how many different 
-- customers purchased tickets to at least one event.

-- count
-------
--  1652
-- (1 row)

SELECT count(DISTINCT customer_id) FROM tickets;

-- 4. Write a query that determines what percentage of the 
-- customers in the database have purchased a ticket to 
-- one or more of the events.

SELECT round((count(DISTINCT tickets.customer_id) / count(DISTINCT customers.id)::decimal) * 100, 2) AS percent 
FROM customers LEFT OUTER JOIN tickets ON tickets.customer_id = customers.id;

-- 5. Write a query that returns the name of each event 
-- and how many tickets were sold for it, in order from 
-- most popular to least popular.

SELECT events.name, count(tickets.event_id) AS popularity FROM events 
LEFT OUTER JOIN tickets ON events.id = tickets.event_id
GROUP BY events.name
ORDER BY popularity DESC;

-- 6. Write a query that returns the user id, email address, 
-- and number of events for all customers that have 
-- purchased tickets to three events.

-- id   |                email                 | count
-- -------+--------------------------------------+-------
--   141  | isac.hayes@herzog.net                |     3
-- ... etc

SELECT customers.id, customers.email, count(DISTINCT tickets.event_id)
FROM customers JOIN tickets 
ON customers.id = tickets.customer_id
GROUP BY customers.id
HAVING count(DISTINCT tickets.event_id) = 3;

-- 7. Write a query to print out a report of all tickets 
-- purchased by the customer with the email address 
-- 'gennaro.rath@mcdermott.co'. The report should include 
-- the event name and starts_at and the seat's section name, 
-- row, and seat number.

SELECT events.name AS event,
events.starts_at, 
sections.name AS section,
seats.row, 
seats.number AS seat
FROM tickets
INNER JOIN events
ON tickets.event_id = events.id
INNER JOIN customers
ON tickets.customer_id = customers.id
INNER JOIN seats
ON tickets.seat_id = seats.id
INNER JOIN sections
ON seats.section_id = sections.id
WHERE customers.email = 'gennaro.rath@mcdermott.co';