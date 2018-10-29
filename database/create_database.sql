-- --------------------------------------------------------------------------------
-- create_database.sql
-- Create the initial datbase and set the user
-- --------------------------------------------------------------------------------

DROP DATABASE IF EXISTS insy6500;
CREATE DATABASE insy6500;

CREATE USER IF NOT EXISTS 'insy6500'@'localhost' IDENTIFIED BY 'insy6500';

GRANT ALL ON insy6500.* TO 'insy6500'@'localhost';

FLUSH PRIVILEGES;
