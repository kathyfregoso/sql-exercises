-- 1. Set Up Database

CREATE TABLE devices (
  id serial PRIMARY KEY,
  name text NOT NULL,
  created_at timestamp DEFAULT now()
);

CREATE TABLE parts (
  id serial PRIMARY KEY,
  part_number int UNIQUE NOT NULL,
  device_id int REFERENCES devices(id)
);

-- 2. Insert Data for Parts and Devices

INSERT INTO devices (name) VALUES
('Accelerometer'),
('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, NULL),
(10, NULL),
(11, NULL);

-- 3. INNER JOIN

SELECT devices.name, parts.part_number FROM devices 
INNER JOIN parts ON devices.id = parts.device_id;

-- 4. SELECT part_number
SELECT * FROM parts WHERE (CAST (part_number AS text)) LIKE '3%';

-- 5. Aggregate Functions

SELECT devices.name, count(parts.part_number) FROM devices
LEFT JOIN parts ON devices.id = parts.device_id GROUP BY devices.name;

-- 6. ORDER BY

SELECT devices.name, count(parts.part_number) AS count FROM devices
LEFT JOIN parts ON devices.id = parts.device_id GROUP BY devices.name 
ORDER BY devices.name DESC, count DESC;

-- 7. IS NULL and IS NOT NULL

-- generate a listing of parts that currently belong to a device:

SELECT part_number, device_id FROM parts WHERE device_id IS NOT NULL;

-- generate a listing of parts that don't belong to a device:

SELECT part_number, device_id FROM parts
WHERE device_id IS NULL;

-- 8. Oldest Device

INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (42, 3);

SELECT name FROM devices ORDER BY created_at LIMIT 1;

-- 9. UPDATE device_id

UPDATE parts SET device_id = 1 WHERE part_number = 7 OR part_number = 8;

-- 10. Delete Accelerometer

DELETE FROM parts WHERE device_id = 1;

DELETE FROM devices WHERE name = 'Accelerometer';