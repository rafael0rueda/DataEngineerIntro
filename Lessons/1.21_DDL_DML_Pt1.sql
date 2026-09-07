-- From insde the folder of lessons: .read 1.21_DDL_DML_Pt1.sql

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

/*
Delete a database
DROP DATABASES IF EXISTS jobs_mart;
*/

SELECT *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

SELECT *
FROM information_schema.schemata
WHERE catalog_name = 'jobs_mart';

/*
Delete SCHEMA
DROP SCHEMA IF EXISTS staging;
*/

CREATE TABLE IF NOT EXISTS staging.preferred_roles(
   role_id INTEGER PRIMARY KEY,
   role_name VARCHAR 
); 

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

/*
Delete table:
DROP TABLE preferred_roles;
*/

INSERT INTO staging.preferred_roles (role_id, role_name)
VALUES
   (1, 'Data Engineer'),
   (2, 'Senior Data Engineer'),
   (3, 'Software Engineer');

SELECT * FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

SELECT * FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT * FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;

-- Check the type of data, not all data can not be convert form one to the other
ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT * FROM staging.priority_roles;
