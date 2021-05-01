CREATE TABLE animals (
    id serial,
    name varchar(100) NOT NULL,
    binomial_name varchar(100) NOT NULL,
    max_weight_kg decimal(8,3),
    max_age_years INT,
    conservation_status varchar(2)
);

INSERT INTO animals VALUES (1, 'Lion', 'Pantera leo', 250, 20, 'VU');
INSERT INTO animals VALUES (2, 'Killer Whale', 'Orcinus orca', 6,000, 60, 'DD');
INSERT INTO animals VALUES (3, 'Golden Eagle', 'Aquila chrysaetos', 6.35, 24, 'LC');