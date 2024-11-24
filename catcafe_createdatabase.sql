-- ปิดการตรวจสอบ Foreign Key ชั่วคราว
SET FOREIGN_KEY_CHECKS = 0;

-- ลบตารางเดิม (ถ้ามี) ตามลำดับเพื่อหลีกเลี่ยงข้อผิดพลาดของ Constraints
DROP TABLE IF EXISTS `exchange_gift`;
DROP TABLE IF EXISTS `premium_gift`;
DROP TABLE IF EXISTS `enter_work`;
DROP TABLE IF EXISTS `work_schedule`;
DROP TABLE IF EXISTS `cat_schedule`;
DROP TABLE IF EXISTS `health_info`;
DROP TABLE IF EXISTS `cat`;
DROP TABLE IF EXISTS `breed`;
DROP TABLE IF EXISTS `promotion`;
DROP TABLE IF EXISTS `order_detail`;
DROP TABLE IF EXISTS `menu`;
DROP TABLE IF EXISTS `bill`;
DROP TABLE IF EXISTS `employee`;
DROP TABLE IF EXISTS `customer`;

-- เปิดการตรวจสอบ Foreign Key ชั่วคราวอีกครั้ง
SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- สร้างฐานข้อมูลใหม่ (ถ้าไม่มี)
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `catcafemanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `catcafemanagement`;

-- -----------------------------------------------------
-- สร้างตาราง `customer`
-- -----------------------------------------------------
CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `birthDate` DATE NOT NULL,
  `points` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `employee`
-- -----------------------------------------------------
CREATE TABLE `employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `position` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `bill`
-- -----------------------------------------------------
CREATE TABLE `bill` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `billDate` DATE NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `employee_id` INT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `CustomerID` (`customer_id` ASC),
  INDEX `StaffID` (`employee_id` ASC),
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE SET NULL,
  CONSTRAINT `order_ibfk_2`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE SET NULL
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `breed`
-- -----------------------------------------------------
CREATE TABLE `breed` (
  `breed_id` VARCHAR(45) NOT NULL,
  `breedName` VARCHAR(45) NOT NULL,
  `character` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`breed_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `cat`
-- -----------------------------------------------------
CREATE TABLE `cat` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `gender` ENUM('Male', 'Female') NOT NULL,
  `birthDate` DATE NOT NULL,
  `status` ENUM('Available', 'Not Available') NOT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `breed_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cat_id`),
  INDEX `fk_cat_breed1_idx` (`breed_id` ASC),
  CONSTRAINT `fk_cat_breed1`
    FOREIGN KEY (`breed_id`)
    REFERENCES `breed` (`breed_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `cat_schedule`
-- -----------------------------------------------------
CREATE TABLE `cat_schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `day` VARCHAR(45) NOT NULL,
  `timeStart` VARCHAR(45) NOT NULL,
  `timeEnd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `cat_attend`
-- -----------------------------------------------------
CREATE TABLE `cat_attend` (
  `cat_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  PRIMARY KEY (`cat_id`, `schedule_id`),
  INDEX `fk_cat_has_cat_schedule_cat_schedule1_idx` (`schedule_id` ASC),
  INDEX `fk_cat_has_cat_schedule_cat1_idx` (`cat_id` ASC),
  CONSTRAINT `fk_cat_has_cat_schedule_cat1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cat` (`cat_id`),
  CONSTRAINT `fk_cat_has_cat_schedule_cat_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `cat_schedule` (`schedule_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `work_schedule`
-- -----------------------------------------------------
CREATE TABLE `work_schedule` (
  `schedule_id` INT NOT NULL,
  `day` VARCHAR(45) NOT NULL,
  `timeStart` VARCHAR(45) NOT NULL,
  `timeEnd` VARCHAR(45) NOT NULL,
  `workShift` ENUM('Morning', 'Night') NOT NULL,
  PRIMARY KEY (`schedule_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `enter_work`
-- -----------------------------------------------------
CREATE TABLE `enter_work` (
  `employee_id` INT NOT NULL,
  `workschedule_id` INT NOT NULL,
  `workDate` VARCHAR(45) NOT NULL,
  `enter_work_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`enter_work_id`),
  INDEX `fk_employee_has_work_schedule_work_schedule1_idx` (`workschedule_id` ASC),
  INDEX `fk_employee_has_work_schedule_employee1_idx` (`employee_id` ASC),
  CONSTRAINT `fk_employee_has_work_schedule_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`),
  CONSTRAINT `fk_employee_has_work_schedule_work_schedule1`
    FOREIGN KEY (`workschedule_id`)
    REFERENCES `work_schedule` (`schedule_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตารางอื่น ๆ (ตามโครงสร้างที่เหลือ)
-- -----------------------------------------------------
-- สร้างตาราง `premium_gift`
-- -----------------------------------------------------
CREATE TABLE `premium_gift` (
  `gift_id` INT NOT NULL AUTO_INCREMENT,
  `giftName` VARCHAR(45) NOT NULL,
  `point_use` INT NOT NULL,
  `quantityInStock` INT NOT NULL,
  PRIMARY KEY (`gift_id`),
  UNIQUE INDEX `gift_name_UNIQUE` (`giftName` ASC)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `exchange_gift`
-- -----------------------------------------------------
CREATE TABLE `exchange_gift` (
  `exchange_gift_id` INT NOT NULL AUTO_INCREMENT,
  `gift_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`exchange_gift_id`),
  INDEX `fk_exchange_gift_customer_idx` (`customer_id` ASC),
  INDEX `fk_exchange_gift_gift_idx` (`gift_id` ASC),
  CONSTRAINT `fk_exchange_gift_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`),
  CONSTRAINT `fk_exchange_gift_gift`
    FOREIGN KEY (`gift_id`)
    REFERENCES `premium_gift` (`gift_id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `health_info`
-- -----------------------------------------------------
CREATE TABLE `health_info` (
  `catinfo_id` INT NOT NULL AUTO_INCREMENT,
  `cat_id` INT NOT NULL,
  `healthType` ENUM('Vaccination', 'Illness', 'Treatment', 'Normal') NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `appointmentDate` DATE NULL DEFAULT NULL,
  `admissionDate` DATE NOT NULL,
  PRIMARY KEY (`catinfo_id`),
  INDEX `fk_health_info_cat_idx` (`cat_id` ASC),
  CONSTRAINT `fk_health_info_cat`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cat` (`cat_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `menu`
-- -----------------------------------------------------
CREATE TABLE `menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menuName` VARCHAR(100) NOT NULL,
  `category` ENUM('Food', 'Drink', 'Dessert', 'Ticket') NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `order`
-- -----------------------------------------------------
CREATE TABLE `order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `bill_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_order_bill_idx` (`bill_id` ASC),
  INDEX `fk_order_menu_idx` (`menu_id` ASC),
  CONSTRAINT `fk_order_bill`
    FOREIGN KEY (`bill_id`)
    REFERENCES `bill` (`bill_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_order_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `menu` (`menu_id`)
    ON DELETE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- สร้างตาราง `promotion`
-- -----------------------------------------------------
CREATE TABLE `promotion` (
  `promotion_id` INT NOT NULL AUTO_INCREMENT,
  `promotionName` VARCHAR(100) NOT NULL,
  `discountPercent` DECIMAL(5,2) NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`promotion_id`),
  INDEX `fk_promotion_menu_idx` (`menu_id` ASC),
  CONSTRAINT `fk_promotion_menu`
    FOREIGN KEY (`menu_id`)
    REFERENCES `menu` (`menu_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- เปิดการตรวจสอบ Foreign Key อีกครั้ง
SET FOREIGN_KEY_CHECKS = 1;

-- ปิดการตรวจสอบ Foreign Key ชั่วคราว
SET FOREIGN_KEY_CHECKS = 0;

-- ลบตาราง cat_attend และ cat_schedule เดิม
DROP TABLE IF EXISTS `cat_attend`;
DROP TABLE IF EXISTS `cat_schedule`;

-- เปิดการตรวจสอบ Foreign Key อีกครั้ง
SET FOREIGN_KEY_CHECKS = 1;

-- -----------------------------------------------------
-- สร้างตาราง `cat_schedule` ใหม่
-- -----------------------------------------------------
CREATE TABLE `cat_schedule` (
  `cat_schedule_id` INT NOT NULL AUTO_INCREMENT, -- Primary Key
  `schedule_id` INT NOT NULL,                   -- Foreign Key 1
  `cat_id` INT NOT NULL,                        -- Foreign Key 2
  `workDate` DATE NOT NULL,                     -- วันที่ทำงาน
  PRIMARY KEY (`cat_schedule_id`),
  INDEX `fk_cat_schedule_schedule_idx` (`schedule_id`), -- Index สำหรับ schedule_id
  INDEX `fk_cat_schedule_cat_idx` (`cat_id`),           -- Index สำหรับ cat_id
  CONSTRAINT `fk_cat_schedule_schedule`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `work_schedule` (`schedule_id`)          -- เชื่อมกับ work_schedule
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cat_schedule_cat`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cat` (`cat_id`)                         -- เชื่อมกับ cat
    ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE `catcafemanagement`.`bill` 
DROP FOREIGN KEY `order_ibfk_2`;

ALTER TABLE `catcafemanagement`.`bill` 
CHANGE COLUMN `employee_id` `employee_id` INT NOT NULL;

ALTER TABLE `catcafemanagement`.`bill` 
ADD CONSTRAINT `order_ibfk_2`
  FOREIGN KEY (`employee_id`)
  REFERENCES `catcafemanagement`.`employee` (`employee_id`)
  ON DELETE CASCADE;
  
ALTER TABLE `catcafemanagement`.`order` 
RENAME TO  `catcafemanagement`.`order_detail` ;

ALTER TABLE `catcafemanagement`.`enter_work` 
DROP FOREIGN KEY `fk_employee_has_work_schedule_work_schedule1`;
ALTER TABLE `catcafemanagement`.`enter_work` 
CHANGE COLUMN `workschedule_id` `schedule_id` INT NOT NULL ;
ALTER TABLE `catcafemanagement`.`enter_work` 
ADD CONSTRAINT `fk_employee_has_work_schedule_work_schedule1`
  FOREIGN KEY (`schedule_id`)
  REFERENCES `catcafemanagement`.`work_schedule` (`schedule_id`);
  
ALTER TABLE `catcafemanagement`.`work_schedule` 
CHANGE COLUMN `workShift` `workShift` ENUM('Morning', 'Afternoon') NOT NULL ;

  
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
(1, 'John Doe', '0812345678', 'john.doe@example.com', '1990-01-01', 50),
(2, 'Jane Smith', '0823456789', 'jane.smith@example.com', '1992-02-02', 70),
(3, 'Alice Brown', '0834567890', 'alice.brown@example.com', '1993-03-03', 30),
(4, 'Bob White', '0845678901', NULL, '1989-04-04', 40),
(5, 'Chris Black', '0856789012', 'chris.black@example.com', '1991-05-05', 60),
(6, 'Ethan Hunt', '0911234567', 'ethan.hunt@example.com', '1985-07-07', 90),
(7, 'Sophia Green', '0922345678', 'sophia.green@example.com', '1993-08-08', 70),
(8, 'Olivia Clark', '0933456789', 'olivia.clark@example.com', '1995-09-09', 40),
(9, 'Liam Adams', '0944567890', 'liam.adams@example.com', '1987-10-10', 50),
(10, 'Emma Scott', '0955678901', 'emma.scott@example.com', '1990-11-11', 80);

INSERT INTO employee (employee_id, name, position, phone, email, salary) VALUES
(100, 'Eve Adams', 'Manager', '0867890123', 'eve.adams@example.com', 50000),
(200, 'Mike Brown', 'Waiter', '0878901234', 'mike.brown@example.com', 20000),
(300, 'Sara Green', 'Barista', '0889012345', 'sara.green@example.com', 25000),
(400, 'Tom Blue', 'Cashier', '0890123456', 'tom.blue@example.com', 18000),
(500, 'Anna White', 'Cleaner', '0901234567', 'anna.white@example.com', 15000),
(600, 'Lily Adams', 'Chef', '0966789012', 'lily.adams@example.com', 55000),
(700, 'James Clark', 'Waiter', '0977890123', 'james.clark@example.com', 21000),
(800, 'Chris Black', 'Waiter', '0988901234', 'chris.black@example.com', 21000),
(900, 'Sophia Green', 'Barista', '0999012345', 'sophia.green@example.com', 24000);

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

SET FOREIGN_KEY_CHECKS = 0;

INSERT INTO bill (bill_id, billDate, totalAmount, customer_id, employee_id) VALUES
(501, '2023-11-01', 100.00, 1, 100), -- เปลี่ยนจาก 101 เป็น 100
(502, '2023-11-02', 45.00, 2, 200),  -- เปลี่ยนจาก 102 เป็น 200
(503, '2023-11-03', 240.00, 3, 300), -- เปลี่ยนจาก 103 เป็น 300
(504, '2023-11-04', 70.00, 4, 400),  -- เปลี่ยนจาก 104 เป็น 400
(505, '2023-11-05', 55.00, 5, 500),  -- เปลี่ยนจาก 105 เป็น 500
(506, '2023-11-06', 80.00, 6, 600),  -- เปลี่ยนจาก 106 เป็น 600
(507, '2023-11-07', 120.00, 7, 700), -- เปลี่ยนจาก 107 เป็น 700
(508, '2023-11-08', 60.00, 8, 800),  -- เปลี่ยนจาก 108 เป็น 800
(509, '2023-11-09', 90.00, 9, 900),  -- เปลี่ยนจาก 109 เป็น 900
(510, '2023-11-10', 140.00, 10, 900); -- เปลี่ยนจาก 109 เป็น 900 (ใช้ employee คนเดียวกัน)


SET FOREIGN_KEY_CHECKS = 1;


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
(304, 'Cheesecake Lovers', 10.00, '2023-12-01', '2023-12-15', '10% off on cheesecake', 4);
INSERT INTO promotion (promotion_id, promotionName, discountPercent, startDate, endDate, description, menu_id) VALUES
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
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO enter_work (employee_id, schedule_id, workDate, enter_work_id) VALUES
(101, 1, '2023-11-01', 'ENT001'), -- Eve Adams works Monday Morning
(102, 2, '2023-11-01', 'ENT002'), -- Mike Brown works Monday Afternoon
(103, 3, '2023-11-02', 'ENT003'), -- Sara Green works Tuesday Morning
(104, 4, '2023-11-02', 'ENT004'), -- Tom Blue works Tuesday Afternoon
(105, 5, '2023-11-03', 'ENT005'), -- Anna White works Wednesday Morning
(106, 6, '2023-11-03', 'ENT006'), -- Lily Adams works Wednesday Afternoon
(107, 7, '2023-11-04', 'ENT007'), -- James Clark works Thursday Morning
(108, 8, '2023-11-04', 'ENT008'), -- Chris Black works Thursday Afternoon
(109, 9, '2023-11-05', 'ENT009'); -- Sophia Green works Friday Morning
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO enter_work (employee_id, schedule_id, workDate, enter_work_id) VALUES
(100, 1, '2024-11-01', 'ENT0010'),
(200, 2, '2024-11-01', 'ENT0020'), 
(300, 3, '2024-11-02', 'ENT0030');
SELECT m.menuName, p.promotionName, p.discountPercent, p.startDate, p.endDate
FROM menu m
JOIN promotion p ON m.menu_id = p.menu_id
WHERE p.startDate <= CURDATE() 
AND p.endDate >= CURDATE()
ORDER BY p.discountPercent DESC;

SELECT e.name AS EmployeeName, ws.day, 
ws.workShift, ws.timeStart, ws.timeEnd
FROM employee e
JOIN enter_work ew ON 
e.employee_id = ew.employee_id
JOIN work_schedule ws ON 
ew.schedule_id = ws.schedule_id
WHERE ws.day IN ('Monday', 'Tuesday', 'Wednesday')
ORDER BY ws.day, ws.timeStart;

-- คำนวณแต้มจาก bill และอัปเดตคะแนนให้กับลูกค้าใน customer
-- เพิ่ม bill ให้ลูกค้าที่ขาดคะแนน (สร้างใบเสร็จใหม่)
INSERT INTO bill (bill_id, billDate, totalAmount, customer_id, employee_id)
VALUES
(511, '2023-11-11', 200.00, 1, 100),  -- ลูกค้า 1 ได้ 1 แต้ม (200 บาท)
(512, '2023-11-11', 200.00, 2, 200),  -- ลูกค้า 2 ได้ 1 แต้ม
(513, '2023-11-11', 200.00, 3, 300),  -- ลูกค้า 3 ได้ 1 แต้ม
(514, '2023-11-11', 200.00, 4, 400),  -- ลูกค้า 4 ได้ 1 แต้ม
(515, '2023-11-11', 200.00, 5, 500),  -- ลูกค้า 5 ได้ 1 แต้ม
(516, '2023-11-11', 200.00, 6, 600),  -- ลูกค้า 6 ได้ 1 แต้ม
(517, '2023-11-11', 200.00, 7, 700),  -- ลูกค้า 7 ได้ 1 แต้ม
(518, '2023-11-11', 200.00, 8, 800),  -- ลูกค้า 8 ได้ 1 แต้ม
(519, '2023-11-11', 200.00, 9, 900),  -- ลูกค้า 9 ได้ 1 แต้ม
(520, '2023-11-11', 200.00, 10, 900); -- ลูกค้า 10 ได้ 1 แต้ม

UPDATE customer c
JOIN (
    SELECT customer_id, SUM(FLOOR(totalAmount / 200)) AS earned_points
    FROM bill
    GROUP BY customer_id
) b ON c.customer_id = b.customer_id
SET c.points = b.earned_points;

SELECT * FROM customer;


