CREATE TYPE spectral_type_enumerated 
AS ENUM ('O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars ALTER COLUMN spectral_type
TYPE spectral_type_enumerated 
USING spectral_type::spectral_type_enumerated;