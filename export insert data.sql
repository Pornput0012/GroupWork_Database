use catcafemanagement;
INSERT INTO breed (breed_id, breedName, `character`) VALUES
('BR001', 'Persian', 'Friendly'),
('BR002', 'Siamese', 'Playful'),
('BR003', 'Maine Coon', 'Gentle'),
('BR004', 'Bengal', 'Active'),
('BR005', 'Ragdoll', 'Affectionate'),
('BR006', 'Scottish Fold', 'Curious'),
('BR007', 'Sphynx', 'Affectionate'),
('BR008', 'British Shorthair', 'Calm'),
('BR009', 'American Shorthair', 'Active'),
('BR010', 'Norwegian Forest', 'Adventurous');

INSERT INTO customer (customer_id, name, phone, email, birthDate, points) VALUES
(1, 'John Doe', '0812345678', 'john.doe@example.com', '1990-01-01', 1),
(2, 'Jane Smith', '0823456789', 'jane.smith@example.com', '1992-02-02', 1),
(3, 'Alice Brown', '0834567890', 'alice.brown@example.com', '1993-03-03', 2),
(4, 'Bob White', '0845678901', NULL, '1989-04-04', 1),
(5, 'Chris Black', '0856789012', 'chris.black@example.com', '1991-05-05', 1),
(6, 'Ethan Hunt', '0911234567', 'ethan.hunt@example.com', '1985-07-07', 1),
(7, 'Sophia Green', '0922345678', 'sophia.green@example.com', '1993-08-08', 1),
(8, 'Olivia Clark', '0933456789', 'olivia.clark@example.com', '1995-09-09', 1),
(9, 'Liam Adams', '0944567890', 'liam.adams@example.com', '1987-10-10', 1),
(10, 'Emma Scott', '0955678901', 'emma.scott@example.com', '1990-11-11', 1);

INSERT INTO employee (employee_id, name, position, phone, email, salary) VALUES
(101, 'Alex Taylor', 'Manager', '0811234567', 'alex.taylor@example.com', 60000),
(102, 'Jordan White', 'Waiter', '0812345678', 'jordan.white@example.com', 20000),
(103, 'Taylor Green', 'Barista', '0813456789', 'taylor.green@example.com', 25000),
(104, 'Charlie Blue', 'Cashier', '0814567890', 'charlie.blue@example.com', 18000),
(105, 'Morgan Brown', 'Cleaner', '0815678901', 'morgan.brown@example.com', 15000),
(106, 'Riley Black', 'Chef', '0816789012', 'riley.black@example.com', 55000),
(107, 'Jamie Clark', 'Waiter', '0817890123', 'jamie.clark@example.com', 21000),
(108, 'Peyton Adams', 'Waiter', '0818901234', 'peyton.adams@example.com', 21000),
(109, 'Casey Scott', 'Barista', '0819012345', 'casey.scott@example.com', 24000),
(100, 'Eve Adams', 'Manager', '0867890123', 'eve.adams@example.com', 50000),
(200, 'Mike Brown', 'Waiter', '0878901234', 'mike.brown@example.com', 20000),
(300, 'Sara Green', 'Barista', '0889012345', 'sara.green@example.com', 25000);

INSERT INTO menu (menu_id, menuName, category) VALUES
(1, 'Latte', 'Drink'),
(2, 'Cappuccino', 'Drink'),
(3, 'Espresso', 'Drink'),
(4, 'Brownie', 'Dessert'),
(5, 'Cheesecake', 'Dessert'),
(6, 'Club Sandwich', 'Food'),
(7, 'Pasta', 'Food'),
(8, 'Burger', 'Food'),
(9, 'Ice Cream', 'Dessert'),
(10, 'Green Tea', 'Drink');

INSERT INTO cat (cat_id, name, gender, birthDate, status, image, breed_id) VALUES
(901, 'Kitty', 'Female', '2020-01-15', 'Available', NULL, 'BR001'),
(902, 'Tom', 'Male', '2019-06-20', 'Not Available', NULL, 'BR002'),
(903, 'Bella', 'Female', '2018-03-10', 'Available', NULL, 'BR003'),
(904, 'Max', 'Male', '2021-05-25', 'Available', NULL, 'BR004'),
(905, 'Luna', 'Female', '2022-07-18', 'Not Available', NULL, 'BR005'),
(906, 'Whiskers', 'Male', '2021-03-15', 'Available', NULL, 'BR006'),
(907, 'Shadow', 'Male', '2020-11-11', 'Not Available', NULL, 'BR007'),
(908, 'Mittens', 'Female', '2021-09-09', 'Available', NULL, 'BR008'),
(909, 'Tiger', 'Male', '2019-12-12', 'Not Available', NULL, 'BR009'),
(910, 'Coco', 'Female', '2020-02-20', 'Available', NULL, 'BR010');

INSERT INTO bill (bill_id, billDate, totalAmount, customer_id, employee_id) VALUES
(501, '2023-11-01', 100.00, 1, 101), 
(502, '2023-11-02', 45.00, 2, 102),  
(503, '2023-11-03', 240.00, 3, 103), 
(504, '2023-11-04', 70.00, 4, 104),  
(505, '2023-11-05', 55.00, 5, 105),  
(506, '2023-11-06', 80.00, 6, 106),  
(507, '2023-11-07', 120.00, 7, 107), 
(508, '2023-11-08', 60.00, 8, 108), 
(509, '2023-11-09', 90.00, 9, 109),  
(510, '2023-11-10', 140.00, 10, 100),
(511, '2023-11-12', 200.00, 1, 200),
(512, '2023-11-13', 200.00, 2, 300), 
(513, '2023-11-14', 200.00, 3, 109),  
(514, '2023-11-15', 200.00, 4, 108),  
(515, '2023-11-16', 200.00, 5, 107),
(516, '2023-11-17', 200.00, 6, 106), 
(517, '2023-11-18', 200.00, 7, 105),  
(518, '2023-11-19', 200.00, 8, 104), 
(519, '2023-11-20', 200.00, 9, 103), 
(520, '2023-11-21', 200.00, 10, 102); 

INSERT INTO order_detail (order_id, bill_id, menu_id, quantity, price) VALUES
(401, 501, 1, 2, 100.00),
(402, 502, 4, 1, 45.00),
(403, 503, 2, 3, 240.00),
(404, 504, 6, 2, 70.00),
(405, 505, 3, 1, 55.00),
(406, 506, 5, 1, 80.00),
(407, 507, 8, 2, 120.00),
(408, 508, 9, 3, 60.00),
(409, 509, 7, 1, 100.00),
(410, 510, 10, 2, 140.00);

INSERT INTO promotion (promotion_id, promotionName, discountPercent, startDate, endDate, description, menu_id) VALUES
(301, 'Holiday Special', 10.00, '2023-12-20', '2023-12-31', '10% off on all latte', 1),
(302, 'Early Bird', 10.00, '2023-12-01', '2023-12-10', '10% off on morning menu', 6),
(303, 'Spicy Deal', 20.00, '2023-12-01', '2023-12-31', '20% off on spicy dishes', 7),
(304, 'Cheesecake Lovers', 10.00, '2023-12-01', '2023-12-15', '10% off on cheesecake', 4),
(305, 'Winter Wonderland', 15.00, '2024-11-10', '2024-12-15', '15% off on winter specials', 2),
(306, 'Morning Bliss', 12.00, '2024-11-01', '2024-12-10', '12% off on morning coffee', 6),
(307, 'Festive Feast', 20.00, '2024-11-15', '2024-12-25', '20% off on main dishes', 7),
(308, 'Sweet December', 10.00, '2024-11-20', '2024-12-31', '10% off on desserts', 4),
(309, 'November Delight', 18.00, '2024-11-05', '2024-12-05', '18% off on all drinks', 1),
(310, 'Cheesecake Wonderland', 15.00, '2024-11-12', '2024-12-20', '15% off on cheesecake', 4),
(311, 'Holiday Cheers', 10.00, '2024-11-25', '2024-12-30', '10% off on all latte', 1),
(312, 'Spice Up Your Holidays', 25.00, '2024-11-18', '2024-12-24', '25% off on spicy dishes', 7);

INSERT INTO premium_gift (gift_id, giftName, point_use, quantityInStock) VALUES
(601, 'Coffee Mug', 100, 50),
(602, 'Keychain', 50, 100),
(603, 'T-shirt', 200, 30),
(604, 'Notebook', 150, 40),
(605, 'Pen', 75, 80),
(606, 'Backpack', 250, 20),
(607, 'Water Bottle', 80, 60),
(608, 'Hat', 120, 50),
(609, 'Sticker Pack', 30, 150),
(610, 'Gift Card', 500, 10);


INSERT INTO exchange_gift (exchange_gift_id, gift_id, customer_id, quantity) VALUES
(701, 601, 1, 10),
(702, 602, 2, 20),
(703, 603, 3, 10),
(704, 604, 4, 30),
(705, 605, 5, 20),
(706, 606, 6, 10),
(707, 607, 7, 20),
(708, 608, 8, 10),
(709, 609, 9, 30),
(710, 610, 10, 20);

INSERT INTO health_info (catinfo_id, cat_id, healthType, description, appointmentDate, admissionDate) VALUES
(9001, 902, 'Vaccination', 'Rabies vaccine', '2023-01-15', '2023-01-15'),
(9002, 905, 'Illness', 'Minor cold', '2023-02-20', '2023-02-20'),
(9003, 907, 'Treatment', 'Deworming', '2023-03-10', '2023-03-10'),
(9004, 909, 'Normal', 'Routine check-up', '2023-04-18', '2023-04-18');

INSERT INTO work_schedule (schedule_id, day, timeStart, timeEnd, workShift) VALUES
(1, 'Monday', '10:00', '15:00', 'Morning'),
(2, 'Monday', '15:00', '20:00', 'Afternoon'),
(3, 'Tuesday', '10:00', '15:00', 'Morning'),
(4, 'Tuesday', '15:00', '20:00', 'Afternoon'),
(5, 'Wednesday', '10:00', '15:00', 'Morning'),
(6, 'Wednesday', '15:00', '20:00', 'Afternoon'),
(7, 'Thursday', '10:00', '15:00', 'Morning'),
(8, 'Thursday', '15:00', '20:00', 'Afternoon'),
(9, 'Friday', '10:00', '15:00', 'Morning'),
(10, 'Friday', '15:00', '20:00', 'Afternoon'),
(11, 'Saturday', '10:00', '16:00', 'Morning'),
(12, 'Saturday', '16:00', '22:00', 'Afternoon'),
(13, 'Sunday', '10:00', '16:00', 'Morning'),
(14, 'Sunday', '16:00', '22:00', 'Afternoon');

INSERT INTO cat_schedule (cat_schedule_id, schedule_id, cat_id, workDate) VALUES
(1, 1, 901, '2023-11-01'), -- Kitty works Monday Morning
(2, 2, 902, '2023-11-01'), -- Tom works Monday Afternoon
(3, 3, 903, '2023-11-02'), -- Bella works Tuesday Morning
(4, 4, 904, '2023-11-02'), -- Max works Tuesday Afternoon
(5, 5, 905, '2023-11-03'), -- Luna works Wednesday Morning
(6, 6, 906, '2023-11-03'), -- Whiskers works Wednesday Afternoon
(7, 7, 907, '2023-11-04'), -- Shadow works Thursday Morning
(8, 8, 908, '2023-11-04'), -- Mittens works Thursday Afternoon
(9, 9, 909, '2023-11-05'), -- Tiger works Friday Morning
(10, 10, 910, '2023-11-05'); -- Coco works Friday Afternoon

INSERT INTO enter_work (employee_id, schedule_id, workDate, enter_work_id) VALUES
(101, 1, '2023-11-01', 'ENT001'),
(102, 2, '2023-11-01', 'ENT002'), 
(103, 3, '2023-11-02', 'ENT003'), 
(104, 4, '2023-11-02', 'ENT004'), 
(105, 5, '2023-11-03', 'ENT005'), 
(106, 6, '2023-11-03', 'ENT006'),
(107, 7, '2023-11-04', 'ENT007'), 
(108, 8, '2023-11-04', 'ENT008'), 
(109, 9, '2023-11-05', 'ENT009'),
(100, 1, '2024-11-01', 'ENT0010'),
(200, 2, '2024-11-01', 'ENT0020'), 
(300, 3, '2024-11-02', 'ENT0030');


SELECT * FROM customer;