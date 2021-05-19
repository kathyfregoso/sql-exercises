-- 1. ser up db using \copy

CREATE TABLE bidders (
  id serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE items (
  id serial PRIMARY KEY,
  name text NOT NULL,
  initial_price numeric(6, 2) NOT NULL CHECK (initial_price BETWEEN 0.01 AND 1000.00),
  sales_price numeric(6,2) CHECK (sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id serial PRIMARY KEY,
  bidder_id int NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
  item_id int NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  amount numeric(6,2) NOT NULL CHECK (amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX bidder_item_ids ON bids (bidder_id, item_id);

-- \copy bidders FROM 'bidders.csv' WITH CSV HEADER;

--  \copy items FROM 'items.csv' WITH CSV HEADER;

-- \copy bids FROM 'bids.csv' WITH CSV HEADER;

-- 2. conditional subqueries IN

SELECT name AS "Bid on Items" FROM items WHERE id IN
  (SELECT item_id FROM bids);

-- 3. NOT IN subquery

SELECT name AS "Not Bid On" FROM items WHERE id NOT IN
  (SELECT item_id FROM bids);

-- 4. EXISTS

SELECT name FROM bidders WHERE EXISTS (SELECT 1 FROM bids WHERE bidders.id = bids.bidder_id);

-- further exploration

SELECT name FROM bidders JOIN bids ON bidders.id = bids.bidder_id GROUP BY bidders.id ORDER BY bidders.id;

-- 5. Query From a Virtual Table

SELECT max(total_bids.count) FROM 
 (SELECT count(bidder_id) FROM bids GROUP BY bidder_id) AS total_bids;

-- 6. Scalar Subqueries

SELECT name, (SELECT count(item_id) FROM bids WHERE items.id = item_id) FROM items;

-- 7. Row Comparison

SELECT id FROM items WHERE row('Painting', 100.00, 250.00) = row(name, initial_price, sales_price);

-- 8. EXPLAIN

EXPLAIN SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

EXPLAIN ANALYZE SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- 9. comparing SQL statements

EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;