-- 1. Set Up the Database using \copy

-- createdb auction
-- psql -d auction

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price decimal(6,2) NOT NULL CHECK (initial_price > 0.01 AND initial_price < 1000.00),
  sales_price decimal(6,2) CHECK (initial_price > 0.01 AND initial_price < 1000.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id int NOT NULL REFERENCES bidders (id) ON DELETE CASCADE,
  item_id int NOT NULL REFERENCES items (id) ON DELETE CASCADE,
  amount decimal(6,2) NOT NULL CHECK (amount > 0.01 AND amount < 1000.00)
);

CREATE INDEX current_bids ON bids (bidder_id, item_id);

-- \copy bidders FROM 'bidders.csv' WITH HEADER CSV;

-- \copy items FROM 'items.csv' WITH HEADER CSV;

-- \copy bids FROM 'bids.csv' WITH HEADER CSV;

-- 2. Conditional Subqueries: IN

SELECT name AS "Bid on Items" FROM items
  WHERE items.id IN
  (SELECT DISTINCT item_id FROM bids);

-- 3. Conditional Subqueries: NOT IN

SELECT name AS "Not Bid On" FROM items
  WHERE items.id NOT IN
  (SELECT DISTINCT item_id FROM bids);

-- 4. Conditional Subqueries: EXISTS

SELECT name FROM bidders
  WHERE EXISTS
  (SELECT FROM bids WHERE bids.bidder_id = bidders.id);

-- 5. Query From a Virtual Table

SELECT max(bid_counts.count) FROM 
(SELECT count(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

-- 6. Scalar Subqueries

SELECT name, (SELECT count(item_id) FROM bids WHERE items.id = bids.item_id) FROM items;

-- further exploration

SELECT items.name, count(bids.item_id) FROM items LEFT OUTER JOIN bids
ON items.id = bids.item_id GROUP BY items.id ORDER BY items.id;

-- 7. Row Comparison

SELECT id FROM items WHERE ROW('Painting', 100.00, 250.00) = 
  ROW(name, initial_price, sales_price);

-- 8. EXPLAIN

-- Here, we use EXPLAIN to return the query plan for the specified query
-- the query isn't executed
-- the query plan is structured like a node-tree, with each element
-- signifying a node. the top node has an estimated cost of 33.38
-- each node has a node type and the estimated cost for that node 
-- (start up cose and then total cost), the estimated number of rows
-- to be output by the node, and the estimated averadge width of rows in bytes
-- cost value estimates the amount of effort/resources
-- needed to execute the query

EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

--                                 QUERY PLAN                                
--------------------------------------------------------------------------
-- Hash Join  (cost=33.38..66.47 rows=635 width=32)
--   Hash Cond: (bidders.id = bids.bidder_id)
--   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
--   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
--         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
--               Group Key: bids.bidder_id
--               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
--(7 rows)

-- EXPLAIN with ANALYZE

-- analyzes a query with actual data by running query
-- returns the same output as EXPLAIN by also includes the real time in ms
-- needed to run the query and its parts, and the actual rows returned
-- by each plan node (not an estimate)

EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

--                                                     QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
-- Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.093..0.097 rows=6 loops=1)
--   Hash Cond: (bidders.id = bids.bidder_id)
--   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.021..0.022 rows=7 loops=1)
--   ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.044..0.045 rows=6 loops=1)
--         Buckets: 1024  Batches: 1  Memory Usage: 9kB
--         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.031..0.033 rows=6 loops=1)
--               Group Key: bids.bidder_id
--               Batches: 1  Memory Usage: 40kB
--               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.016..0.020 rows=26 loops=1)
-- Planning Time: 0.141 ms
-- Execution Time: 0.432 ms
-- (11 rows)

-- 9. Comparing SQL Statements

-- the more effecient statement is actually ORDER BY and LIMIT in my case

-- query type: subquery
-- planning time: 0.144 ms
-- execution time: 0.103
-- total time for execution
-- total costs: 37.16

EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

--                                                  QUERY PLAN                                                   
---------------------------------------------------------------------------------------------------------------
-- Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.041..0.042 rows=1 loops=1)
--   ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.035..0.038 rows=6 loops=1)
--         Group Key: bids.bidder_id
--         Batches: 1  Memory Usage: 40kB
--         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.009..0.013 rows=26 loops=1)
-- Planning Time: 0.144 ms
-- Execution Time: 0.103 ms
--(7 rows)

-- query type: ORDER BY and LIMIT
-- planning time: 0.073 ms
-- execution time: 0.085 ms
-- total time for execution: 
-- total costs: 35.65

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

--                                                      QUERY PLAN                                                      
---------------------------------------------------------------------------------------------------------------------
-- Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.040..0.041 rows=1 loops=1)
--   ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.039..0.040 rows=1 loops=1)
--         Sort Key: (count(bidder_id)) DESC
--         Sort Method: top-N heapsort  Memory: 25kB
--         ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.021..0.023 rows=6 loops=1)
--               Group Key: bidder_id
--               Batches: 1  Memory Usage: 40kB
--               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.009..0.011 rows=26 loops=1)
-- Planning Time: 0.073 ms
-- Execution Time: 0.085 ms
--(10 rows)