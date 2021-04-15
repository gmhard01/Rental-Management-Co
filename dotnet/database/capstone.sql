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
	installment_number int NOT NULL,
	lease_id int NOT NULL,
	due_date date NOT NULL,
	amount_due decimal(6,2) NOT NULL,

	CONSTRAINT PK_payment_schedule PRIMARY KEY (lease_id, due_date)
);


CREATE TABLE lease_agreements (
	lease_id int IDENTITY(1,1) NOT NULL,
	property_id int NOT NULL,
	landlord_id int NOT NULL,
	renter_id int NOT NULL,
	monthly_rent decimal(6,2) NOT NULL,
	lease_start_date date NOT NULL,
	lease_term int NOT NULL

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
	property_id int NOT NULL,
	primary_photo varchar(2) NOT NULL,
	photo_url1 varchar (500) NOT NULL,
	photo_description1 varchar(100),
	photo_url2 varchar (500),
	photo_description2 varchar(100),
	photo_url3 varchar (500),
	photo_description3 varchar(100),
	photo_url4 varchar (500),
	photo_description4 varchar(100)

	CONSTRAINT PK_photos PRIMARY KEY (property_id)
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
INSERT INTO users (username, password_hash, salt, user_role, phone, email, first_name, last_name)
VALUES ('Rob', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'Landlord', '1231006789', 'rob@gmail.com', 'Robby', 'Borchardt'),
	   ('Eli', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'Renter', '2222222222', 'eli@gmail.com', 'Elijah', 'Jackson'),
	   ('Nate', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'Renter', '3333333333', 'nate@gmail.com', 'Nathan', 'Groehl'),
	   ('Graham', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'Landlord', '4444444444', 'graham@gmail.com', 'Graham', 'Hardaway'),
	   ('Joe', '9/T9UumgqmBZWbIjG/SiB4c3IKY=', 'CN+wxEyhAbs=', 'Maintenance', '5555555555', 'joe@gmail.com', 'Joe', 'Riggs');

INSERT INTO addresses (street_number, unit_number, street_name, state_abbreviation, city, county, zip_code)
VALUES (1733, '1', 'Garden Ln', 'OH', 'Cincinnati', NULL, '45237'),
	   (72, NULL, 'Stacy Ln', 'KY', 'Ft. Thomas', NULL, '41075'),
	   (3149, '4', 'Auten Ave', 'OH', 'Cincinnati', NULL, '45213'),
	   (7985, NULL, 'Brill Rd', 'OH', 'Cincinnati', NULL, '45243'),
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

INSERT INTO properties (title, address_id, rent_amount, number_beds, number_baths, landlord_id, available, available_date, property_description, square_footage, property_type, pets_allowed)
VALUES ('Garden Lane Apartments', 1, 925, 3, 2, 1, 1, '2021-07-01', 'NEWLY REMODELED 2 BDRM APTS IN BONDHILL NEWLY REMODELED 2BDRM UNITS, CENTRALLY LOCATED, ON BUSLINE!!', 900, 'Apartment', 0),
	   ('House on Stacy Lane!', 2, 1600, 2, 1.5, 1, 1, '2021-03-01', 'Freshly painted with new carpeting. Washer, dryer included. Dishwasher, microwave. Deck with wooded view. Johnson elementary, highlands school district. Wet bar and pool table in finished basement.', 1550, 'House', 1),
	   ('Auten Ave Apartment', 3, 795, 1, 1, 1, 1, '2021-05-01', '1 bedroom/1 bathroom apartment on great street in Pleasant Ridge. Hardwood floors, off-street parking, laundry and extra storage in basement.', 750, 'Apartment', 0),
	   ('House on Brill Rd', 4, 3000, 5, 3, 1, 1, '2021-06-01', 'Charming Mid-Century Modern home on 6+ acres with a pool. Private backyard with plenty of room to play and woods to explore. Highly desired Central Village location. The home has five bedrooms upstairs, one bedroom/office on first floor and three full baths. New appliances in kitchen being installed. Indian Hill Schools. Immediate occupancy. Tenant is responsible for all utilities and maintenance to the property. Landlord is a licensed real estate agent in the State of Ohio.', 3643, 'House', 0),
	   ('Super nice house in Cincy!', 5, 1400, 4, 3, 1, 1, '2021-02-01', 'Fantastic value in Winton Woods SD. Single story home, 3BR, with updated kitchen, large yard, washer dryer hook ups. Open living and dining area. Close to the YMCA and Winton Woods.', 1120, 'House', 1),
	   ('Cozy Townhome Near Green Hills Mall!', 6, 1500, 2, 2.5, 1, 1, '2021-05-15', 'Great 2 bedroom, 2.5 bathroom townhome! This unit is located just minutes from Green Hills Mall, The YMCA, and tons of restaurants. Inside features a corner fireplace, decorative columns, spacious living room and dining room, and a laundry area!', 1220, 'Townhome', 1),
	   ('Townhome in Madison!', 7, 1180, 2, 2.5, 1, 1, '2021-04-01', 'Two Bedroom, 21/2 bath townhouse available immediately. In-suite bathrooms in both bedrooms, laminate flooring throughout, stainless steel appliances and granite counter tops. Washer/Dryer included! Soaker bath tub. Pets are possible with approval and a non-refundable pet fee.', 1100, 'Townhome', 1),
	   ('Rental Home Near UC!', 8, 2300, 4, 2, 1, 1, '2021-05-01', 'Large 4 bedroom 2 bath. Recently renovated with new kitchen and baths, windows, flooring (hardwood throughout). Large bed rooms, Central air, laundry in the basement. Off Street Parking.', 2000, 'House', 1),
       ('Rental Property in the heart of OTR!', 9, 2000, 2, 1, 1, 1, '2021-04-01', 'With the city as your playground, enjoy urban living at its finest in this gorgeous, first floor, industrial style loft! Spacious rooms, soaring ceilings, exposed brick, light filled windows and sleek kitchen & bath all come together to create one amazing place to call home. Tons of storage, ample permit parking, low HOA!', 1050, 'Apartment', 0),
       ('Downtown living right on Main St!', 10, 2200, 2, 1.5, 1, 1, '2021-03-15', 'Spacious luxury two bedroom unit with tons of natural light! First time offered prime top unit in the newly formed 9 unit development. 1, 400+SqFt has urban feel with modern amenities! New LVT flooring. All new paint and carpet. Ultra low $125/m HOA fees. 3 years free parking! In the heart of the city, on the streetcar! Better hurry!', 1100, 'Condo', 0),
       ('McHenry Estates', 11, 545, 1, 1, 1, 1, '2021-04-15', 'Paramount Square is a $29.9 million revitalization of 8 buildings in Walnut Hills. The buildings consist of 81 apartments, and retail storefronts. This development is home to many current and future businesses, including Just In, Video Archive, Caffe Vivace, Esoteric Brewery, and The Aperture.', 750, 'Apartment', 1),
       ('Townhouse in the heart of old Mariemont', 12, 1700, 2, 1, 1, 1, '2021-06-01', 'Completely renovated townhouse in the heart of old Mariemont square.', 1000, 'Townhome', 0),
       ('2 bedroom apartment in a 2 apartment building.', 13, 985, 2, 1, 1, 1, '2021-04-01', 'This is a 2 bedroom apartment in a 2 apartment building. The apartment is fully carpeted with an enclosed porch and laundry facilities in the basement. Near public transportation and shopping. The apartment is in a fast growing area of Avondale, near Childrens hospital, UC medical center, Cincinnati Zoo and the VA hospital. Pets allowed with owners permission. Call now for an appointment at 832-2493 and ask for Karen', 1300, 'Apartment', 1),
       ('Charming 4 Bed 1 bath w/ garage', 14, 1300, 4, 1, 1, 1, '2021-01-01', 'Charming 4 Bed, 1 bath with garage in a great location more info and bookings on yolocinci.com Beautiful 4 bedroom1 bath unit in a duplex Water, sewage and trash included in the Rent $1300, Deposit $1300 -Stove and fridge included, spacious living area.', 2100, 'House', 1),
       ('Great home with a spacious kitchen', 15, 1680, 3, 1, 1, 1, '2021-07-01', 'This great home has 3 carpeted bedrooms, a spacious kitchen with stainless steel appliances, granite countertops, and crisp white cabinets. New wood plank and carpet flooring throughout! You will enjoy the front-covered porch and walkup. Extensive storage space with extra closets and an unfinished basement. Great backyard space with patio ready for entertaining.', 1700, 'House', 1),
       ('Mears Ave Suites', 16, 575, 1, 1, 1, 1, '2021-05-15', 'Awesome quiet building on quite street. Stained concrete flooring, open floor plan, ceramic bath, off-street parking. No pets, no smoking building.', 1400, 'Apartment', 0),
       ('Cute Family Home', 17, 1600, 3, 1.5, 1, 1, '2021-03-01', 'Freshly painted with new carpeting. Washer, dryer included. Dishwasher, microwave. Deck with wooded view. Johnson elementary, highlands school district. Wet bar and pool table in finished basement.', 1500, 'House', 1),
       ('Beechwood Apartments', 18, 1000, 2, 1, 1, 1, '2021-03-15', 'Well maintained apartment in Beechwood School district, convenient to church, shopping and eateries. Hardwood floors throughout. Garage parking and laundry hookups available. Landlord pays water.', 1000, 'Apartment', 0),
       ('Family Bungalow for Rent', 19, 1000, 3, 2, 1, 1, '2021-07-01', 'Single family home located in quiet, walkable neighborhood. ', 1500, 'House', 1),
       ('Renovated home for Rent', 20, 1400, 2, 1, 1, 1, '2021-04-01', 'Single family home located in quiet, walkable Madeira neighborhood and Madeira Schools. 2BR, 1BA, 862 sq ft first floor. Extra finished office/storage room in basement.', 862, 'House', 0),
       ('1100 Square Foot Apartment Home', 21, 1200, 2, 1, 1, 1, '2021-04-15', 'This 1100 square foot apartment home has 2 bedrooms and 1.0 bathrooms. This home is located at 4445 Plainville Rd #2, Cincinnati, OH 45227.', 1100, 'Apartment', 1),
       ('Gorgeous 4 bedroom /2.5 bath home!', 22, 1695, 4, 2.5, 1, 1, '2021-04-01', '403 McEwing 4BR/2.5BA (Lockland) - **Coming Soon** Have you ever dreamed of living in a gorgeous brand new home? We can make your dreams come true!! We have newly constructed, beautifully appointed, traditional home that is almost ready for your move in. Gorgeous 4 bedroom /2.5 bath home! Open floor plan, walk in closets in every bedroom, en-suite master bath, laundry on the second floor, two car attached garage, and has a basement!!', 2100, 'House', 1),
       ('1273 square foot multi family home!', 23, 1113, 1, 1, 1, 1, '2021-08-03', 'This 1273 square foot multi family home has 1 bedrooms and 1.0 bathrooms. This home is located at 100 Bethel Park Dr, Bethel, OH 45106.', 1273, 'Condo', 1),
       ('1 bedroom, 1.0 bathroom, multi family home.', 24, 795, 1, 1, 1, 1, '2021-04-01', 'This is a 1 bedroom, 1.0 bathroom, multi family home. This home is located at 205 S High St, Mount Orab, OH 45154.', 880, 'Apartment', 0),
       ('Renovated Student Living!', 25, 2200, 8, 2, 1, 1, '2021-08-15', 'Over $15,000 in improvements since last year including new flooring on both levels and a new stackable washer and dryer on top floor. Ideally this home would be shared amongst a group of 4 with two separate levels each with 4 bedrooms and 1 bathroom with a huge backyard. 10 minute walk to campus and close to Millet Hall as well as mccullough hyde hospital for any athletes, rotc or nursing students. Semester pricing may vary depending on the # of students.', 2400, 'Apartment', 0),
       ('3 bedroom home in historical Germantown!', 26, 1300, 3, 1, 1, 0, '2021-05-15', 'Welcome home! This 2-story, 3 bedroom home is located in historical Germantown, OH, has a newly remodeled bathroom, large fenced yard, and is in the Valley View School District. Call 937/694-0095 for viewing appointment.', 1600, 'House', 1),
       ('Duplex in a quiet Subdivision.', 27, 1250, 3, 2, 1, 1, '2021-05-15', 'This property is a duplex on a cul-de-sac located in a quiet subdivision. Local shopping is within two miles, and schools are a short commute. The duplex has a large master bedroom with full bath. The unit has an additional two bedrooms and a second full bath. The living area is an open floor plan that adjoins a kitchen fully equipped with all major appliances, a countertop breakfast bar, and tile flooring. Bedrooms and Living Area has one-year-old carpet.', 1900, 'Condo', 1),
       ('What a townhouse!', 28, 995, 3, 1.5, 4, 1, '2021-04-15', 'The 3 bedrooms are spacious. The guest bath and master bath are connected by the toilet and tub area, each has their own sink. The first floor features the living room, 1/2 bath and eat in kitchen.The entire unit has just been painted and has carpet installed on the steps and upstairs and tile flooring throughout the main floor.', 1500, 'Townhome', 1);


--Create dummy property photos
INSERT INTO property_photos (property_id, primary_photo, photo_url1, photo_description1, photo_url2, photo_description2, photo_url3, photo_description3, photo_url4, photo_description4)
VALUES (100, 1, 'https://photos.zillowstatic.com/fp/2c72d021bcaf75a894fb5785e542a494-cc_ft_768.jpg', 'Courtyard', 'https://photos.zillowstatic.com/fp/81fae264cadeba0adb8e9cee6a633e4b-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/fced11c34a4eb7de3c97ca38e50fed33-cc_ft_576.jpg', 'Living Room', 'https://photos.zillowstatic.com/fp/6f96ad4df57d3c4c093c963d6993b036-cc_ft_576.jpg', 'Bedroom'),
	   (101, 1, 'https://photos.zillowstatic.com/fp/9ef655f2f6299b5495f49fadb0bba4eb-cc_ft_576.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/371e6077843202109a59ddd08c4ddc5a-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/8dddfde3807e5ccfaaedf53e9f1c970a-cc_ft_576.jpg', 'Living Room', 'https://photos.zillowstatic.com/fp/ff3e052d250d0c9a7dfbd907c51a6695-cc_ft_576.jpg', 'Bedroom'),
	   (102, 1, 'https://photos.zillowstatic.com/fp/d40d1816680b4194989c4a2e2a4fac45-cc_ft_1152.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/2beaee5cf6b400e3bdcab755467590a7-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/2a71378ccacf906a56f38057855a57bf-cc_ft_576.jpg', 'Bathroom',  'https://photos.zillowstatic.com/fp/dba4412c454648098ea0fb699eddea80-cc_ft_576.jpg', 'Bedroom'),
	   (103, 1, 'https://photos.zillowstatic.com/fp/72ec58ae15e034adc0f9d5795fdc8be8-cc_ft_576.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/e5921289ed0ab389faa3c8db4ab947d1-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/70d911961650e193468f39af84b585ab-cc_ft_576.jpg', 'Pool in Backyard', Null, Null),
	   (104, 1, 'https://photos.zillowstatic.com/fp/d1152b895baf97f27b1e12b3a6dade26-cc_ft_1152.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/e36909d965c5819067967f0a6e7b62f0-cc_ft_576.jpg', 'Kitchen and Living Room', 'https://photos.zillowstatic.com/fp/8be1a2de8c702eb13724f504ac736cf4-cc_ft_576.jpg', 'Bathroom', Null, Null),
	   (105, 1, 'https://photos.zillowstatic.com/fp/c3ada9177483c709fea48a0c18914d85-cc_ft_1152.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/fe91a73f76b8065c79017cc615ab36a8-cc_ft_576.jpg', 'Bathroom', 'https://photos.zillowstatic.com/fp/08a1293f61a90fef6fae9ad70c966c34-cc_ft_576.jpg', 'Kitchen', Null, Null),
	   (106, 1, 'https://photos.zillowstatic.com/fp/9d8e0d0bc3cc84ecea41e3e5ed4c5c36-cc_ft_1152.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/016bbc5df76c7a307cc6b1b5af032217-cc_ft_576.jpg', 'Rooftop Lounge Area', 'https://photos.zillowstatic.com/fp/7dd276fd04ec37fc6df61553b6d13f4e-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/e253a99211923b9e3dc9c8ef80b346a8-cc_ft_576.jpg', 'Bedroom'),
	   (107, 1, 'https://photos.zillowstatic.com/fp/7e77bf044d473a9eed444c54e0beaef5-cc_ft_384.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/545cd12cfb50ae425840ff3d0bd25f94-cc_ft_384.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/e82ac94a6761578583d94948525ca6a7-cc_ft_384.jpg', 'Living Room',  'https://photos.zillowstatic.com/fp/385b4f64f918ae0421e47bdfd4ef7954-cc_ft_384.jpg', 'Bedroom'),
	   (108, 1, 'https://photos.zillowstatic.com/fp/d5c48085fb5be4250cb09e7ad54c35bb-cc_ft_576.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/5d8102376625f2ceecd1bceb6dbe7e50-cc_ft_384.jpg', 'Living Room',  'https://photos.zillowstatic.com/fp/9e3fe74a1f7637fed08c6e3b7b2c347a-cc_ft_384.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/da5b43163fb6f255c622f44cf379f2e2-cc_ft_384.jpg', 'Master Bedroom'),
	   (109, 1, 'https://photos.zillowstatic.com/fp/cc785d67be7ded86abee7e5943ccb385-cc_ft_576.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/726bb295cbadc7f3e69b5224972cb9ec-cc_ft_384.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/be40ae182f63f7c5e76cd73df7351fde-cc_ft_384.jpg', 'Bedroom', 'https://photos.zillowstatic.com/fp/0fe17efe211b40e82b8df4eec7c0424c-cc_ft_384.jpg', 'Living Room'),
	   (110, 1, 'https://photos.zillowstatic.com/fp/dbc20ab41533823739928cc44adf6200-cc_ft_576.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/37b1545a5d5c5a8cc0037a62b5985590-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/55d2e12b32e2758e0549b46d8117ffb7-cc_ft_576.jpg', 'Bedroom', Null, Null),
	   (111, 1, 'https://photos.zillowstatic.com/fp/3f4f6a7cd868400f105c1bd846029427-cc_ft_768.jpg', 'Living Room',  'https://photos.zillowstatic.com/fp/a583976e21ee8ae34b51df8762f49f3a-cc_ft_576.jpg', 'Kitchen', Null, Null, Null, Null),
	   (112, 1, 'https://photos.zillowstatic.com/fp/1e4134d4492dd9ad22deb4a7f6bc636a-cc_ft_1152.jpg', 'Street View',  'https://photos.zillowstatic.com/fp/416984809dcc47ed1c5fa77e5f0933f3-cc_ft_576.jpg', 'Living Room/Kitchen', Null, Null, Null, Null),
	   (113, 1, 'https://photos.zillowstatic.com/fp/004f7f7160f8f2912cd5a5d7def00f6f-cc_ft_1152.jpg', 'Front Photo',  'https://photos.zillowstatic.com/fp/38e4f0c3a6158fcf274fe3f83c547a5d-cc_ft_576.jpg', 'Kitchen',  'https://photos.zillowstatic.com/fp/b590e410648e6e8ae5d4e4853284a5d2-cc_ft_576.jpg', 'Half Bath/Living Room', Null, Null),
	   (114, 1, 'https://photos.zillowstatic.com/fp/baca0fc0b14099705accf6286d3ab11a-cc_ft_1152.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/2a47f216fcf2c654ce54e10992e1118b-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/92549c7b122c2c6522bf080bd197cc1d-cc_ft_576.jpg', 'Bedroom', Null, Null),
	   (115, 1, 'https://photos.zillowstatic.com/fp/29fb6c717e67f068e29cbafef4b38764-cc_ft_576.jpg', 'Kitchen and Living Room', 'https://photos.zillowstatic.com/fp/1080de63c86326044fcd19f9d006f641-cc_ft_576.jpg', 'Bedroom',  'https://photos.zillowstatic.com/fp/34b23d259d268854a7ea22a0be8aa1dd-cc_ft_576.jpg', 'Bathroom', Null, Null),
	   (116, 1, 'https://photos.zillowstatic.com/fp/a5fdbb3666f82aa892083f7b968abe8a-cc_ft_768.jpg', 'Front Photo', 'https://photos.zillowstatic.com/fp/e9a3a5aee2217a62679f9b1172997623-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/bedbcf9152f1902992c30850d870dc32-cc_ft_576.jpg', 'Bedroom', Null, Null),
	   (117, 1, 'https://photos.zillowstatic.com/fp/17afe77797aa980ee46f6de9298140bd-cc_ft_1152.jpg', 'Street View', 'https://photos.zillowstatic.com/fp/06b42338ed8b046cc9d670b736591bcc-cc_ft_576.jpg', 'Kitchen', 'https://photos.zillowstatic.com/fp/2db5e32144faf7953bf8413db52e06b1-cc_ft_576.jpg', 'Bedroom', Null, Null),
	   (118, 1, 'https://photos.zillowstatic.com/fp/3390fda0adf8bbc09e6b63e649aac24c-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (119, 1, 'https://photos.zillowstatic.com/fp/639355c21fcf379070b86c3a64ac3ea2-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (120, 1, 'https://photos.zillowstatic.com/fp/a22b5f2101fb66f5fc7c945b2fcf6ee4-cc_ft_576.jpg', 'Kitchen and Living Room', Null, Null, Null, Null, Null, Null),
	   (121, 1, 'https://photos.zillowstatic.com/fp/de53a339ba79d39430cb3dc0d517ad36-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (122, 1, 'https://photos.zillowstatic.com/fp/7384d008a3478420709a2bac9321f990-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (123, 1, 'https://photos.zillowstatic.com/fp/b69361b63e8ed1c57746c414ecf552fd-cc_ft_1152.jpg', 'Street View', Null, Null, Null, Null, Null, Null),
	   (124, 1, 'https://photos.zillowstatic.com/fp/7fc0320b729145f767f0a84019b0146d-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (125, 1, 'https://photos.zillowstatic.com/fp/3b8857d0767ff188d4077f2060feefbb-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (126, 1, 'https://photos.zillowstatic.com/fp/898fe9a4e3e3e1c623ecbf65f571c93f-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null),
	   (127, 1, 'https://photos.zillowstatic.com/fp/e4788e39650097c4c7f10d03f173ffa6-cc_ft_1152.jpg', 'Front Photo', Null, Null, Null, Null, Null, Null);

INSERT INTO lease_agreements (property_id, landlord_id, renter_id, monthly_rent, lease_start_date, lease_term)
VALUES (102, 1, 2, 1100.50, '2020-10-01', 12),
	   (101, 1, 3, 1400, '2021-01-01', 12);

INSERT INTO payment_schedule (installment_number, lease_id, due_date, amount_due)
VALUES (1, 1, '2020-10-01', 1100.50),
	   (2, 1, '2020-11-01', 1100.50),
	   (3, 1, '2020-12-01', 1100.50),
	   (4, 1, '2021-01-01', 1100.50),
	   (5, 1, '2021-02-01', 1100.50),
	   (6, 1, '2021-03-01', 1100.50),
	   (7, 1, '2021-04-01', 1100.50),
	   (8, 1, '2021-05-01', 1100.50),
	   (9, 1, '2021-06-01', 1100.50),
	   (10, 1, '2021-07-01', 1100.50),
	   (11, 1, '2021-08-01', 1100.50),
	   (12, 1, '2021-09-01', 1100.50),
	   (1, 2, '2021-01-01', 1400),
	   (2, 2, '2021-02-01', 1400),
	   (3, 2, '2021-03-01', 1400),
	   (4, 2, '2021-04-01', 1400),
	   (5, 2, '2021-05-01', 1400),
	   (6, 2, '2021-06-01', 1400),
	   (7, 2, '2021-07-01', 1400),
	   (8, 2, '2021-08-01', 1400),
	   (9, 2, '2021-09-01', 1400),
	   (10, 2, '2021-10-01', 1400),
	   (11, 2, '2021-11-01', 1400),
	   (12, 2, '2021-12-01', 1400);

INSERT INTO payments (payer_id, paid_date, lease_id, amount_paid)
VALUES (2, '2020-10-01', 1, 1100.50),
	   (2, '2020-11-01', 1, 1100.50),
	   (2, '2020-12-01', 1, 1100.50),
	   (2, '2021-01-01', 1, 1100.50),
	   (3, '2021-01-01', 2, 1400),
	   (2, '2021-02-01', 1, 1100.50),
	   (3, '2021-02-01', 2, 1400),
	   (3, '2021-03-01', 2, 1400),
	   (2, '2021-03-01', 1, 600.50),
	   (2, '2021-03-07', 1, 600),
	   (2, '2021-04-01', 1, 1100.50),
	   (3, '2021-04-01', 2, 1400);
	   

--create application
INSERT INTO applications (applicant_id, property_id, approval_status, applicant_first_name, applicant_last_name, applicant_phone)
VALUES (3, 127, 'Pending', 'Nathan', 'Groehl', '5551238888'),
       (2, 126, 'Pending', 'Elijah', 'Jackson', '1235558080');


--create maintenance requests--

	--completed Request
INSERT INTO maintenance_requests (property_id, requester_id, maintenance_worker_id, request_status, details, date_received, date_completed)
VALUES (100, 2, 5, 'Complete', 'My toilet is clogged. Please help!', '2021-04-10', '2021-04-11');

	--new request
INSERT INTO maintenance_requests (property_id, requester_id, request_status, details, date_received)
VALUES (101, 2, 'New', 'I have a leak in my ceiling above the bathroom toilet.', '2021-04-10');


--SELECT payment_id, payer_id, paid_date, lease_id, amount_paid FROM payments WHERE payer_id = 2 ORDER BY paid_date ASC;


--select pending applications for a specific landlord
--SELECT application_id, applicant_id, properties.property_id, approval_status, applicant_name, applicant_phone FROM applications JOIN properties ON applications.property_id = properties.property_id WHERE landlord_id = 1 AND approval_status = 0;

/*
select * from users;
select * from addresses;
select * from properties;
select * from property_photos;
select * from lease_agreements;
select * from maintenance_requests;
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

/*SELECT installment_number, lease_id, due_date, amount_due, sum(amount_due) OVER (order by due_date rows unbounded preceding) AS lease_aggregate_amount_due*/

/*
--get payment history with current balance due on last row
SELECT ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date, (ps.installment_number * ps.amount_due) AS lease_aggregate_amount_due, sum(p.amount_paid) AS total_paid_to_date, (ps.installment_number * ps.amount_due) - sum(p.amount_paid) AS balance_due
FROM payment_schedule ps
JOIN payments p ON p.lease_id = ps.lease_id
WHERE ps.due_date <= GETDATE() AND ps.lease_id = 1
GROUP BY  ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date
ORDER BY lease_id, ps.due_date;
*/

/*SELECT ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date, (ps.installment_number * ps.amount_due) AS lease_aggregate_amount_due, sum(p.amount_paid) AS total_paid_to_date, (ps.installment_number * ps.amount_due) - sum(p.amount_paid) AS balance_due
FROM payment_schedule ps
JOIN payments p ON p.lease_id = ps.lease_id
WHERE ps.lease_id = 1 AND ps.due_date = (
	SELECT Max(ps.due_date <= GETDATE())  
GROUP BY  ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date
ORDER BY lease_id, ps.due_date;*/

/*
--OVER BY on aggregate amount due ONLY
SELECT ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date, sum(ps.amount_due) OVER (order by due_date rows unbounded preceding) AS lease_aggregate_amount_due, sum(p.amount_paid) AS total_paid_to_date, (ps.installment_number * ps.amount_due) - sum(p.amount_paid) AS balance_due
FROM payment_schedule ps
JOIN payments p ON p.lease_id = ps.lease_id
WHERE ps.due_date <= GETDATE() AND ps.lease_id = 1
GROUP BY  ps.installment_number, ps.lease_id, ps.amount_due, ps.due_date
ORDER BY lease_id, ps.due_date;
*/


/*--get future payments by lease id
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
UPDATE properties SET available = 0 WHERE property_id = @property_id;*/