USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE properties (
	property_id int IDENTITY(100,1) NOT NULL,
	title varchar(80) NOT NULL,
	address_id int NOT NULL,
	rent_amount decimal (6,2) NOT NULL,
	number_beds int NOT NULL,
	number_baths decimal(2,1) NOT NULL,
	landlord_id int NOT NULL,
	picture varchar (200),
	available bit NOT NULL,
	available_date date,
	property_description varchar(200)

	CONSTRAINT PK_properties PRIMARY KEY (property_id)
);

CREATE TABLE addresses (
	address_id int IDENTITY(1,1) NOT NULL,
	street_number int NOT NULL,
	unit_number int,
	street_name varchar(100) NOT NULL,
	state_abbreviation char(2) NOT NULL,
	city varchar(100) NOT NULL,
	county varchar(80),
	zip_code char(5) NOT NULL

	CONSTRAINT PK_addresses PRIMARY KEY (address_id)
);

CREATE TABLE payments (
	payment_id int IDENTITY(1,1) NOT NULL,
	payer_id int NOT NULL,
	due_date date NOT NULL,
	paid_date date NOT NULL,
	property_id int NOT NULL,
	amount decimal(6,2) NOT NULL

	CONSTRAINT PK_payment PRIMARY KEY (payment_id)
);

CREATE TABLE lease_agreements (
	lease_id int IDENTITY(1,1) NOT NULL,
	property_id int NOT NULL,
	landlord_id int NOT NULL,
	renter_id int NOT NULL,
	monthly_rent decimal(6,2) NOT NULL,
	lease_start_date date NOT NULL,
	lease_end_date date NOT NULL

	CONSTRAINT PK_lease PRIMARY KEY (lease_id)
);

CREATE TABLE maintenance_requests (
	request_id int IDENTITY(1,1) NOT NULL,
	property_id int NOT NULL,
	requester_id int NOT NULL,
	maintenance_worker_id int,
	request_status varchar(30) NOT NULL,
	details varchar(200) NOT NULL,
	date_received date NOT NULL,
	date_completed date

	CONSTRAINT PK_maintenance PRIMARY KEY(request_id)
);

ALTER TABLE properties ADD CONSTRAINT FK_property_address FOREIGN KEY (address_id) REFERENCES addresses(address_id);
ALTER TABLE properties ADD CONSTRAINT FK_property_landlord FOREIGN KEY (landlord_id) REFERENCES users(user_id);
ALTER TABLE payments ADD CONSTRAINT FK_payment_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE payments ADD CONSTRAINT FK_property_payer FOREIGN KEY (payer_id) REFERENCES users(user_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_landlord FOREIGN KEY (landlord_id) REFERENCES users(user_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_renter FOREIGN KEY (renter_id) REFERENCES users(user_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_requester FOREIGN KEY (requester_id) REFERENCES users(user_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_worker FOREIGN KEY (maintenance_worker_id) REFERENCES users(user_id);

--create some starting data
INSERT INTO addresses (street_number, unit_number, street_name, state_abbreviation, city, county, zip_code)
VALUES (6505, 2, 'Hasler Ln', 'OH', 'Cincinnati', NULL, '45216'),
	   (72, NULL, 'Stacy Ln', 'KY', 'Ft. Thomas', NULL, '41075'),
	   (3149, 4, 'Auten Ave', 'OH', 'Cincinnati', NULL, '45213'),
	   (407, NULL, 'Amherst Ave', 'OH', 'Terrace Park', NULL, '45174'),
	   (7862, NULL, 'Martin St', 'OH', 'Cincinnati', NULL, '45231');

INSERT INTO properties (title, address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description)
VALUES ('Hasler Ln Apartment', 1, 900.00, 3, 2, 1, NULL, 1, NULL, 'sweet apartment in cincy'),
	   ('House on Stavey Lane!', 2, 1200.00, 2, 1.5, 1, NULL, 1, NULL, 'it is a house'),
	   ('Auten Ave Apartment', 3, 1100.50, 4, 2.5, 1, NULL, 0, '2021-05-01', 'a swanky apartment for all your apartment needs'),
	   ('House on Amherst', 4, 950.00, 2, 1, 1, NULL, 0, '2021-06-01', 'the nicest house in Terrace Park'),
	   ('Super nice house in Cincy!', 5, 1400, 4, 3, 1, NULL, 1, NULL, 'house on martin st in cincinnati');

INSERT INTO lease_agreements (property_id, landlord_id, renter_id, monthly_rent, lease_start_date, lease_end_date)
VALUES (102, 1, 2, 1100.50, '2020-01-01', '2021-12-31');

/*
select * from users;
select * from addresses;
select * from properties;
select * from lease_agreements;
update users SET user_role = 'landlord' where user_id = 1;
update users SET user_role = 'tenant' where user_id = 2;
update users SET user_role = 'maintenance' where user_id = 3;
*/
