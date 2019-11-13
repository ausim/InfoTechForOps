# -----
# create_airline_tables.sql - Flights database originally from Tahaghoghi and Williams
# 
# Note that this version ignores foreign key constraints
#
#	Modified by Jeff Smith
# -----

DROP TABLE IF EXISTS Airplane;
CREATE TABLE Airplane (
  RegistrationNumber CHAR(8) NOT NULL,
  ModelNumber        CHAR(8),
  Capacity           SMALLINT,
  PRIMARY KEY (RegistrationNumber)
);

DROP TABLE IF EXISTS Flight;
CREATE TABLE Flight (
  FlightNumber       CHAR(8) NOT NULL,
  Origin             CHAR(20),
  Destination        CHAR(20),
  DepartureDate      DATE,
  DepartureTime      TIME,
  ArrivalDate        DATE,
  ArrivalTime        TIME,
  RegistrationNumber CHAR(10),
  PRIMARY KEY (FlightNumber)
);

DROP TABLE IF EXISTS Passenger;
CREATE TABLE Passenger (
  GivenNames   CHAR(40),
  Surname      CHAR(40),
  EmailAddress CHAR(60) NOT NULL,
  PRIMARY KEY (EmailAddress)
);

DROP TABLE IF EXISTS Booking;
CREATE TABLE Booking (
  FlightNumber CHAR(8) NOT NULL,
  EmailAddress CHAR(60) NOT NULL,
  PRIMARY KEY (FlightNumber, EmailAddress)
);
