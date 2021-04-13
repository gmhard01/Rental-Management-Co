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
	user_role varchar(50) NOT NULL,
	phone char(10),
	email varchar(60),
	first_name varchar(30),
	last_name varchar(30)

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
	picture nvarchar (500),
	available bit NOT NULL,
	available_date date,
	property_description varchar(500),
	square_footage int,
	property_type varchar(20),
	pets_allowed bit

	CONSTRAINT PK_properties PRIMARY KEY (property_id)
);

CREATE TABLE addresses (
	address_id int IDENTITY(1,1) NOT NULL,
	street_number int NOT NULL,
	unit_number varchar(20),
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
	paid_date date NOT NULL,
	lease_id int NOT NULL,
	amount_paid decimal(6,2) NOT NULL

	CONSTRAINT PK_payment PRIMARY KEY (payment_id)
);

CREATE TABLE payment_schedule (
	lease_id int NOT NULL,
	due_date date NOT NULL,
	amount_due decimal(6,2) NOT NULL

	CONSTRAINT PK_payment_schedule PRIMARY KEY (lease_id, due_date)
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

CREATE TABLE applications (
	application_id int IDENTITY(1,1) NOT NULL,
	applicant_id int NOT NULL,
	property_id int NOT NULL,
	approval_status varchar(30) NOT NULL,
	applicant_first_name varchar(100) NOT NULL,
	applicant_last_name varchar(100) NOT NULL,
	applicant_phone char(10) NOT NULL

	CONSTRAINT PK_applications PRIMARY KEY (application_id)
);

CREATE TABLE property_photos (
	photo_id int IDENTITY(1000,1) NOT NULL,
	property_id int NOT NULL,
	primary_photo bit NOT NULL

	CONSTRAINT PK_photos PRIMARY KEY (photo_id)
);

ALTER TABLE properties ADD CONSTRAINT FK_property_address FOREIGN KEY (address_id) REFERENCES addresses(address_id);
ALTER TABLE properties ADD CONSTRAINT FK_property_landlord FOREIGN KEY (landlord_id) REFERENCES users(user_id);
ALTER TABLE payments ADD CONSTRAINT FK_payment_lease FOREIGN KEY (lease_id) REFERENCES lease_agreements(lease_id);
ALTER TABLE payment_schedule ADD CONSTRAINT FK_payment_schedule_lease FOREIGN KEY (lease_id) REFERENCES lease_agreements(lease_id);
ALTER TABLE payments ADD CONSTRAINT FK_property_payer FOREIGN KEY (payer_id) REFERENCES users(user_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_landlord FOREIGN KEY (landlord_id) REFERENCES users(user_id);
ALTER TABLE lease_agreements ADD CONSTRAINT FK_lease_renter FOREIGN KEY (renter_id) REFERENCES users(user_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_requester FOREIGN KEY (requester_id) REFERENCES users(user_id);
ALTER TABLE maintenance_requests ADD CONSTRAINT FK_maintenance_worker FOREIGN KEY (maintenance_worker_id) REFERENCES users(user_id);
ALTER TABLE applications ADD CONSTRAINT FK_application_applicant FOREIGN KEY (applicant_id) REFERENCES users(user_id);
ALTER TABLE applications ADD CONSTRAINT FK_application_property FOREIGN KEY (property_id) REFERENCES properties(property_id);
ALTER TABLE property_photos ADD CONSTRAINT FK_property_photos FOREIGN KEY (property_id) REFERENCES properties(property_id);

--create some starting data

INSERT INTO users (username, password_hash, salt, user_role, phone, email)
VALUES ('rob', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'landlord', '1231006789', 'rob@gmail.com'),
	   ('eli', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'renter', NULL, NULL),
	   ('nate', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'renter', NULL, NULL),
	   ('graham', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'landlord', NULL, NULL);

INSERT INTO addresses (street_number, unit_number, street_name, state_abbreviation, city, county, zip_code)
VALUES (6505, '2', 'Hasler Ln', 'OH', 'Cincinnati', NULL, '45216'),
	   (72, NULL, 'Stacy Ln', 'KY', 'Ft. Thomas', NULL, '41075'),
	   (3149, '4', 'Auten Ave', 'OH', 'Cincinnati', NULL, '45213'),
	   (407, NULL, 'Amherst Ave', 'OH', 'Terrace Park', NULL, '45174'),
	   (7862, NULL, 'Martin St', 'OH', 'Cincinnati', NULL, '45231'),
	   (3459, NULL, 'Golf Club Ln', 'TN', 'Nashville', 'Davidson', '37215'),
	   (603, NULL, 'Shadow Glen Dr', 'TN', 'Madison', 'Davidson', '37115'),
	   (238, NULL, 'Klotter Ave.', 'OH', 'Cincinnati', 'Hamilton', '45219'),
	   (1407, '1', 'Main St.', 'OH', 'Cincinnati', 'Hamilton', '45202'),
	   (724, '7', 'Main St.', 'OH', 'Cincinnati', 'Hamilton', '45202'),
	   (3600, Null, 'Mchenry Ave', 'OH', 'Cincinnati', Null, '45255'),
	   (3919, Null, 'Oak St.', 'OH', 'Cincinnati', Null, '45227'),
	   (239, '2', 'Northern Ave', 'OH', 'Cincinnati', Null, '45229'),
	   (1921, 'A', 'Truitt Ave', 'OH', 'Cincinnati', Null, '45212'),
	   (5412, Null, 'Owasco St.', 'OH', 'Cincinnati', Null, '45227'),
	   (1707, '2', 'Mears Ave', 'OH', 'Cincinnati', Null, '45230'),
	   (72, Null, 'Stacy Ln', 'KY', 'Fort Thomas', Null, '41075'),
	   (1, '3', 'Highland Ave', 'KY', 'Fort Mitchell', Null, '41017'),
	   (204, Null, 'Center St', 'KY', 'Erlanger', Null, '41018'),
	   (7308, NULL, 'May Dr', 'OH', 'Cincinnati', NULL, '45229'),
	   (4445, '2', 'Plainville Rd', 'OH', 'Cincinnati', Null, '45227'),
	   (403, Null, 'Mcewing Dr', 'OH', 'Cincinnati', Null, '45215'),
	   (100, Null, 'Bethel Park Dr', 'OH', 'Bethel', Null, '45106'),
	   (205, Null, 'S High St', 'OH', 'Mount Orab', Null, '45154'),
	   (110, Null, 'Homestead Ave', 'OH', 'Oxford', Null, '45056'),
	   (50, Null, 'Peffley St', 'OH', 'Germantown', Null, '45327'),
	   (782, 'A', 'Calderwood Ct', 'OH', 'Lebanon', Null, '45036'),
	   (64, Null, 'Old Stephenson Mill Rd', 'KY', 'Walton', Null, '41094');

INSERT INTO properties (title, address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed)
VALUES ('Hasler Ln Apartment', 1, 900.00, 3, 2, 1, 'https://photos.zillowstatic.com/fp/233b05767ed080fa39329edec4c448be-cc_ft_768.jpg', 1, NULL, 'sweet apartment in cincy', NULL, NULL, NULL),
	   ('House on Stacy Lane!', 2, 1200.00, 2, 1.5, 1, 'https://photos.zillowstatic.com/fp/76d64793c3a9724e8e732c2d3c2429d7-cc_ft_768.jpg', 1, NULL, 'it is a house', 1200, 'House', 1),
	   ('Auten Ave Apartment', 3, 1100.50, 4, 2.5, 1, NULL, 0, '2021-05-01', 'a swanky apartment for all your apartment needs', 1050, 'Apartment', 0),
	   ('House on Amherst', 4, 950.00, 2, 1, 1, NULL, 1, '2021-06-01', 'the nicest house in Terrace Park', 1300, 'House', 0),
	   ('Super nice house in Cincy!', 5, 1400, 4, 3, 1, 'https://photos.zillowstatic.com/fp/b1cc827420d7b1fc94d5d2d2b04ad6b0-cc_ft_768.jpg', 1, NULL, 'house on martin st in cincinnati', 1120, 'House', 1),
	   ('Cozy Townhome Near Green Hills Mall!', 6, 1500, 2, 2.5, 1, 'https://i0.wp.com/movingtips.wpengine.com/wp-content/uploads/2020/08/new-townhouse.jpg?fit=1024%2C684&ssl=1', 1, '2021-05-15', 'Great 2 bedroom, 2.5 bathroom townhome! This unit is located just minutes from Green Hills Mall, The YMCA, and tons of restaurants. Inside features a corner fireplace, decorative columns, spacious living room and dining room, and a laundry area!', 1220, 'Townhome', 1),
	   ('Townhome in Madison!', 7, 1180, 2, 2.5, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkO51xqEzdC0FzdlyZ6Zw4E2LwIehmtSBQOw&usqp=CAU', 1, NULL, 'Two Bedroom, 21/2 bath townhouse available immediately. In-suite bathrooms in both bedrooms, laminate flooring throughout, stainless steel appliances and granite counter tops. Washer/Dryer included! Soaker bath tub. Pets are possible with approval and a non-refundable pet fee.', 1100, 'Townhome', 1),
	   ('Rental Home Near UC!', 8, 2300, 4, 2, 1, 'https://ap.rdcpix.com/897802730/e14b9040603c1d53177d42faec9881b1l-m0xd-w1020_h770_q80.jpg', 1, NULL, 'Large 4 bedroom 2 bath. Recently renovated with new kitchen and baths, windows, flooring (hardwood throughout). Large bed rooms, Central air, laundry in the basement. Off Street Parking.', 2000, 'House', 1),
       ('Rental Property in the heart of OTR!', 9, 2000, 2, 1, 1, 'https://ssl.cdn-redfin.com/photo/158/mbpaddedwide/408/genMid.1507408_1_3.jpg', 1, NULL, 'With the city as your playground, enjoy urban living at its finest in this gorgeous, first floor, industrial style loft! Spacious rooms, soaring ceilings, exposed brick, light filled windows and sleek kitchen & bath all come together to create one amazing place to call home. Tons of storage, ample permit parking, low HOA!', 1050, 'Apartment', 0),
       ('Downtown living right on Main St!', 10, 2200, 2, 1.5, 1, 'https://ap.rdcpix.com/4245192132/59e168b4cdfa45bab510b4782ce54888l-m0xd-w1020_h770_q80.jpg', 1, NULL, 'Spacious luxury two bedroom unit with tons of natural light! First time offered prime top unit in the newly formed 9 unit development. 1, 400+SqFt has urban feel with modern amenities! New LVT flooring. All new paint and carpet. Ultra low $125/m HOA fees. 3 years free parking! In the heart of the city, on the streetcar! Better hurry!', 1100, 'Condo', 0),
       ('McHenry Estates', 11, 545, 1, 1, 1, 'https://photos.zillowstatic.com/fp/6e5531911bdfcff44d7f4818889e78dd-cc_ft_1152.jpg', 1, '2021-04-15', 'This 2400 square foot single family home has 1 bedrooms and 1.0 bathrooms. This home is located at 3600 Mchenry Ave, Cincinnati, OH 45225.', 2400, 'House', 1),
       ('Townhouse in the heart of old Mariemont', 12, 1700, 2, 1, 1, 'https://photos.zillowstatic.com/fp/bd5bd614294cc2624c7371f8cfbd8343-cc_ft_1152.jpg', 1, '2021-06-01', 'Completely renovated townhouse in the heart of old Mariemont square.', 1000, 'Townhome', 0),
       ('2 bedroom apartment in a 2 apartment building.', 13, 985, 2, 1, 1, 'https://photos.zillowstatic.com/fp/18048a0739756f318ee587be9cd2a082-uncropped_scaled_within_1536_1152.webp', 1, NULL, 'This is a 2 bedroom apartment in a 2 apartment building. The apartment is fully carpeted with an enclosed porch and laundry facilities in the basement. Near public transportation and shopping. The apartment is in a fast growing area of Avondale, near Childrens hospital, UC medical center, Cincinnati Zoo and the VA hospital. Pets allowed with owners permission. Call now for an appointment at 832-2493 and ask for Karen', 1300, 'Apartment', 1),
       ('Charming 4 Bed 1 bath w/ garage', 14, 1300, 4, 1, 1, 'https://photos.zillowstatic.com/fp/a4476e1014b688cd701bec1c1cb9b1a8-cc_ft_768.jpg', 1, NULL, 'Charming 4 Bed, 1 bath with garage in a great location more info and bookings on yolocinci.com Beautiful 4 bedroom1 bath unit in a duplex Water, sewage and trash included in the Rent $1300, Deposit $1300 -Stove and fridge included, spacious living area.', 2100, 'House', 1),
       ('Great home with a spacious kitchen', 15, 1680, 3, 1, 1, 'https://photos.zillowstatic.com/fp/17733bbedd990cb3d519bf3d5b202c7e-cc_ft_1152.jpg', 0, '2021-07-01', 'This great home has 3 carpeted bedrooms, a spacious kitchen with stainless steel appliances, granite countertops, and crisp white cabinets. New wood plank and carpet flooring throughout! You will enjoy the front-covered porch and walkup. Extensive storage space with extra closets and an unfinished basement. Great backyard space with patio ready for entertaining.', 1700, 'House', 1),
       ('Mears Ave Suites', 16, 575, 1, 1, 1, 'https://photos.zillowstatic.com/fp/f8dd9998198e63d48b3576576f1a9fef-cc_ft_1152.jpg', 0, '2021-05-15', 'Awesome quiet building on quite street. Stained concrete flooring, open floor plan, ceramic bath, off-street parking. No pets, no smoking building.', 1400, 'Apartment', 0),
       ('Cute Family Home', 17, 1600, 3, 1.5, 1, 'https://photos.zillowstatic.com/fp/9ef655f2f6299b5495f49fadb0bba4eb-uncropped_scaled_within_1536_1152.webp', 1, NULL, 'Freshly painted with new carpeting. Washer, dryer included. Dishwasher, microwave. Deck with wooded view. Johnson elementary, highlands school district. Wet bar and pool table in finished basement.', 1500, 'House', 1),
       ('Beechwood Apartments', 18, 1000, 2, 1, 1, 'https://photos.zillowstatic.com/fp/765bda0f1cd00a4c2fa32614528bbb89-cc_ft_1152.jpg', 0, '2021-03-15', 'Well maintained apartment in Beechwood School district, convenient to church, shopping and eateries. Hardwood floors throughout. Garage parking and laundry hookups available. Landlord pays water.', 1000, 'Apartment', 0),
       ('Family Bungalow for Rent', 19, 1000, 3, 2, 1, 'https://photos.zillowstatic.com/fp/3390fda0adf8bbc09e6b63e649aac24c-cc_ft_1152.jpg', 0, '2021-07-01', 'Single family home located in quiet, walkable neighborhood. ', 1500, 'House', 1),
       ('Renovated home for Rent', 20, 1400, 2, 1, 1, 'https://photos.zillowstatic.com/fp/639355c21fcf379070b86c3a64ac3ea2-cc_ft_1152.jpg', 1, NULL, 'Single family home located in quiet, walkable Madeira neighborhood and Madeira Schools. 2BR, 1BA, 862 sq ft first floor. Extra finished office/storage room in basement.', 862, 'House', 0),
       ('1100 Square Foot Apartment Home', 21, 1200, 2, 1, 1, 'https://photos.zillowstatic.com/fp/a22b5f2101fb66f5fc7c945b2fcf6ee4-cc_ft_576.jpg', 1, '2021-04-15', 'This 1100 square foot apartment home has 2 bedrooms and 1.0 bathrooms. This home is located at 4445 Plainville Rd #2, Cincinnati, OH 45227.', 1100, 'Apartment', 1),
       ('Gorgeous 4 bedroom /2.5 bath home!', 22, 1695, 4, 2.5, 1, 'https://photos.zillowstatic.com/fp/de53a339ba79d39430cb3dc0d517ad36-cc_ft_1152.jpg', 1, NULL, '403 McEwing 4BR/2.5BA (Lockland) - **Coming Soon** Have you ever dreamed of living in a gorgeous brand new home? We can make your dreams come true!! We have newly constructed, beautifully appointed, traditional home that is almost ready for your move in. Gorgeous 4 bedroom /2.5 bath home! Open floor plan, walk in closets in every bedroom, en-suite master bath, laundry on the second floor, two car attached garage, and has a basement!!', 2100, 'House', 1),
       ('1273 square foot multi family home!', 23, 1113, 1, 1, 1, 'https://photos.zillowstatic.com/fp/7384d008a3478420709a2bac9321f990-cc_ft_1152.jpg', 1, '2021-08-03', 'This 1273 square foot multi family home has 1 bedrooms and 1.0 bathrooms. This home is located at 100 Bethel Park Dr, Bethel, OH 45106.', 1273, 'Condo', 1),
       ('1 bedroom, 1.0 bathroom, multi family home.', 24, 795, 1, 1, 1, 'https://photos.zillowstatic.com/fp/b69361b63e8ed1c57746c414ecf552fd-cc_ft_1152.jpg', 1, NULL, 'This is a 1 bedroom, 1.0 bathroom, multi family home. This home is located at 205 S High St, Mount Orab, OH 45154.', 880, 'Apartment', 0),
       ('Renovated Student Living!', 25, 2200, 8, 2, 1, 'https://photos.zillowstatic.com/fp/b69361b63e8ed1c57746c414ecf552fd-cc_ft_1152.jpg', 1, '2021-08-15', 'Over $15,000 in improvements since last year including new flooring on both levels and a new stackable washer and dryer on top floor. Ideally this home would be shared amongst a group of 4 with two separate levels each with 4 bedrooms and 1 bathroom with a huge backyard. 10 minute walk to campus and close to Millet Hall as well as mccullough hyde hospital for any athletes, rotc or nursing students. Semester pricing may vary depending on the # of students.', 2400, 'Apartment', 0),
       ('3 bedroom home in historical Germantown!', 26, 1300, 3, 1, 1, 'https://maps.googleapis.com/maps/api/streetview?location=50+Peffley+St%2C+Germantown%2C+OH+45327&size=1152x864&key=AIzaSyARFMLB1na-BBWf7_R3-5YOQQaHqEJf6RQ&source=outdoor&&signature=IGyjnNz6N0aAYH4-sySvcfYQSzg=', 0, '2021-05-15', 'Welcome home! This 2-story, 3 bedroom home is located in historical Germantown, OH, has a newly remodeled bathroom, large fenced yard, and is in the Valley View School District. Call 937/694-0095 for viewing appointment.', 1600, 'House', 1),
       ('Duplex in a quiet Subdivision.', 27, 1250, 3, 2, 1, 'https://photos.zillowstatic.com/fp/898fe9a4e3e3e1c623ecbf65f571c93f-cc_ft_1152.jpg', 1, '2021-05-15', 'This property is a duplex on a cul-de-sac located in a quiet subdivision. Local shopping is within two miles, and schools are a short commute. The duplex has a large master bedroom with full bath. The unit has an additional two bedrooms and a second full bath. The living area is an open floor plan that adjoins a kitchen fully equipped with all major appliances, a countertop breakfast bar, and tile flooring. Bedrooms and Living Area has one-year-old carpet.', 1900, 'Condo', 1),
       ('What a townhouse!', 28, 995, 3, 1.5, 4, 'https://photos.zillowstatic.com/fp/d7c00225b58741540cdb544ba19c8317-cc_ft_576.jpg', 1, '2021-04-15', 'The 3 bedrooms are spacious. The guest bath and master bath are connected by the toilet and tub area, each has their own sink. The first floor features the living room, 1/2 bath and eat in kitchen.The entire unit has just been painted and has carpet installed on the steps and upstairs and tile flooring throughout the main floor.', 1500, 'Townhome', 1);

INSERT INTO lease_agreements (property_id, landlord_id, renter_id, monthly_rent, lease_start_date, lease_end_date)
VALUES (102, 1, 2, 1100.50, '2020-01-01', '2021-12-31');

INSERT INTO payment_schedule (lease_id, due_date, amount_due)
VALUES (1, '10-01-2021', 1100.50),
	   (1, '09-01-2021', 1100.50),
	   (1, '08-01-2021', 1100.50),
	   (1, '07-01-2021', 1100.50),
	   (1, '06-01-2021', 1100.50),
	   (1, '05-01-2021', 1100.50),
	   (1, '04-01-2021', 1100.50),
	   (1, '03-01-2021', 1100.50),
	   (1, '02-01-2021', 1100.50),
	   (1, '01-01-2021', 1100.50),
	   (1, '12-01-2020', 1100.50),
	   (1, '11-01-2020', 1100.50);

INSERT INTO payments (payer_id, paid_date, lease_id, amount_paid)
VALUES (2, '04-01-2021', 1, 1100.50),
	   (2, '03-01-2021', 1, 1100.50),
	   (2, '02-01-2021', 1, 1100.50),
	   (2, '01-01-2021', 1, 1100.50),
	   (2, '12-01-2020', 1, 1100.50),
	   (2, '11-01-2020', 1, 1100.50);



--create application
INSERT INTO applications (applicant_id, property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone)
VALUES (3, 127, 'Pending', 'Nathan', 'Groehl', '5551238888'),
       (2, 126, 'Pending', 'Elijah', 'Jackson', '1235558080');

--select pending applications for a specific landlord
--SELECT application_id, applicant_id, properties.property_id, approval_status, applicant_name, applicant_phone FROM applications JOIN properties ON applications.property_id = properties.property_id WHERE landlord_id = 1 AND approval_status = 0;

/*
ALTER TABLE properties NOCHECK CONSTRAINT FK_property_address;
ALTER TABLE lease_agreements NOCHECK CONSTRAINT FK_lease_property;
DELETE FROM addresses;
DELETE FROM properties;
ALTER TABLE properties CHECK CONSTRAINT FK_property_address;
ALTER TABLE lease_agreements CHECK CONSTRAINT FK_lease_property;
*/

/*
select * from users;
select * from addresses;
select * from properties;
select * from lease_agreements;
select * from applications;
update users SET user_role = 'renter' where user_id = 1 OR user_id = 3;
SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email FROM properties  JOIN addresses ON properties.address_id = addresses.address_id JOIN users ON properties.landlord_id = users.user_id WHERE available = 1;
*/

/*
SELECT property_id, title, properties.address_id, rent_amount, number_beds, number_baths, landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, phone, email 
FROM properties
JOIN addresses ON properties.address_id = addresses.address_id 
JOIN users ON properties.landlord_id = users.user_id
WHERE available = 1
ORDER BY property_id ASC
OFFSET 5 * 1 ROWS --5 is @PageSize (number of records per page), 1 is @PageNumber (index zero, i.e. 0 = page 1)
FETCH NEXT 5 ROWS ONLY; --5 is @PageSize
*/

/*
INSERT INTO maintenance_requests (property_id, requester_id, request_status, details, date_received)
VALUES (@PropertyId, @RequesterId, @RequestStatus, @Details, @DateReceived); 
*/

/*
SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, properties.landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, users.phone, users.email 
FROM properties
JOIN addresses ON properties.address_id = addresses.address_id
JOIN users ON properties.landlord_id = users.user_id
JOIN lease_agreements ON properties.property_id = lease_agreements.property_id
JOIN users u ON lease_agreements.renter_id = u.user_id
WHERE renter_id = 2;
*/

/*
SELECT payment_id, payer_id, paid_date, lease_id, amount_paid
FROM payments
WHERE payer_id = 2;
*/

--get future payments by lease id
SELECT lease_id, due_date, amount_due
FROM payment_schedule
WHERE due_date >= GETDATE() AND lease_id = 1;

--search bar function, get properties based on state abbr, city, or zip code
SELECT properties.property_id, title, properties.address_id, rent_amount, number_beds, number_baths, properties.landlord_id, picture, available, available_date, property_description, square_footage, property_type, pets_allowed, street_number, unit_number, street_name, state_abbreviation, city, county, zip_code, users.phone, users.email 
FROM properties
JOIN addresses ON properties.address_id = addresses.address_id
JOIN users ON properties.landlord_id = users.user_id
WHERE state_abbreviation LIKE '%TN%' OR city LIKE '%Cincinnati' OR zip_code LIKE '%zip%'

--update property available to 0 (not available) when lease is created
DECLARE @property_id int;
SET @property_id = 113
UPDATE properties SET available = 0 WHERE property_id = @property_id;
