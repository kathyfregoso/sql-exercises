ALTER TABLE planets ALTER COLUMN mass TYPE numeric,
ADD CHECK (mass > 0.0);

ALTER TABLE planets ALTER COLUMN designation SET NOT NULL;