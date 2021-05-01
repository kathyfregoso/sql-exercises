-- createdb workshop
-- psql -d workshop

-- 1. Set Up Database

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number int UNIQUE NOT NULL,
  device_ID int REFERENCES devices(id)
);

-- 2. Insert Data for Parts and Devices

INSERT INTO devices (id, name) 
VALUES (1, 'Accelerometer'), (2, 'Gyroscope');

INSERT INTO parts (part_number, device_ID)
VALUES (1, 1), (2, 1), (3, 1);

INSERT INTO parts (part_number, device_ID)
VALUES (4, 2), (5, 2), (6, 2), (7, 2), (8, 2);

INSERT INTO parts (part_number) 
VALUES (9), (10), (11);

-- 3. INNER JOIN

SELECT devices.name, parts.part_number FROM devices
INNER JOIN parts ON devices.id = parts.device_ID;

--4 SELECT part_number

SELECT * FROM parts WHERE part_number::text LIKE '3%';

-- 5. Aggregate Functions

SELECT devices.name, count(parts.device_ID)
FROM devices LEFT OUTER JOIN parts 
ON devices.id = parts.device_ID GROUP BY devices.name;

-- 6. ORDER BY

SELECT devices.name, count(parts.device_ID)
FROM devices LEFT OUTER JOIN parts 
ON devices.id = parts.device_ID GROUP BY devices.name
ORDER BY devices.name DESC;

-- 7. IS NULL and IS NOT NULL

SELECT part_number, device_ID FROM parts
WHERE device_ID IS NOT NULL;

SELECT part_number, device_ID FROM parts
WHERE device_ID IS NULL;

-- 8. Oldest Device

INSERT INTO devices (id, name) VALUES (3, 'Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);

SELECT name FROM devices 
ORDER BY created_at ASC LIMIT 1;

-- 9. UPDATE device_id

UPDATE parts SET device_id = 1
WHERE part_number = 7 OR part_number = 8;

-- 10. Delete Accelerometer

DELETE FROM parts WHERE device_id = 1;
DELETE FROM devices WHERE id = 1;
