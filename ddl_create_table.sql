-- สร้างฐานข้อมูล
CREATE DATABASE IF NOT EXISTS `catcafemanagement`;

USE `catcafemanagement`;

-- สร้างตาราง customer
CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `birthDate` DATE NOT NULL,
  `points` INT NOT NULL DEFAULT '0',
  PRIMARY KEY (`customer_id`)
);

-- สร้างตาราง employee
CREATE TABLE `employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `position` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`employee_id`)
);

-- สร้างตาราง bill
CREATE TABLE `bill` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `billDate` DATE NOT NULL,
  `totalAmount` DECIMAL(10,2) NOT NULL,
  `customer_id` INT DEFAULT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  CONSTRAINT `fk_bill_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_bill_employee`
    FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`) ON DELETE CASCADE
);

-- สร้างตาราง breed
CREATE TABLE `breed` (
  `breed_id` VARCHAR(45) NOT NULL,
  `breedName` VARCHAR(45) NOT NULL,
  `character` VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (`breed_id`)
);

-- สร้างตาราง cat
CREATE TABLE `cat` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `gender` ENUM('Male', 'Female') NOT NULL,
  `birthDate` DATE NOT NULL,
  `status` ENUM('Available', 'Not Available') NOT NULL,
  `image` VARCHAR(255) DEFAULT NULL,
  `breed_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cat_id`),
  CONSTRAINT `fk_cat_breed`
    FOREIGN KEY (`breed_id`) REFERENCES `breed` (`breed_id`)
);

-- สร้างตาราง work_schedule
CREATE TABLE `work_schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `day` VARCHAR(45) NOT NULL,
  `timeStart` VARCHAR(45) NOT NULL,
  `timeEnd` VARCHAR(45) NOT NULL,
  `workShift` ENUM('Morning', 'Afternoon') NOT NULL,
  PRIMARY KEY (`schedule_id`)
);

-- สร้างตาราง enter_work
CREATE TABLE `employee_schedule` (
  `employee_schedule_id` VARCHAR(45) NOT NULL,
  `employee_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  `workDate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_schedule_id`),
  CONSTRAINT `fk_employee_schedule_employee`
    FOREIGN KEY (`employee_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `fk_employee_schedule_schedule`
    FOREIGN KEY (`schedule_id`) REFERENCES `work_schedule` (`schedule_id`)
);

-- สร้างตาราง premium_gift
CREATE TABLE `premium_gift` (
  `gift_id` INT NOT NULL AUTO_INCREMENT,
  `giftName` VARCHAR(45) NOT NULL UNIQUE,
  `point_use` INT NOT NULL,
  `quantityInStock` INT NOT NULL,
  PRIMARY KEY (`gift_id`)
);

-- สร้างตาราง exchange_gift
CREATE TABLE `exchange_gift` (
  `exchange_gift_id` INT NOT NULL AUTO_INCREMENT,
  `gift_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`exchange_gift_id`),
  CONSTRAINT `fk_exchange_gift_gift`
    FOREIGN KEY (`gift_id`) REFERENCES `premium_gift` (`gift_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exchange_gift_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
);

-- สร้างตาราง menu
CREATE TABLE `menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menuName` VARCHAR(100) NOT NULL,
  `category` ENUM('Food', 'Drink', 'Dessert') NOT NULL,
  PRIMARY KEY (`menu_id`)
);

-- สร้างตาราง order_detail
CREATE TABLE `order_detail` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `bill_id` INT NOT NULL,
  `menu_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `fk_order_detail_bill`
    FOREIGN KEY (`bill_id`) REFERENCES `bill` (`bill_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_detail_menu`
    FOREIGN KEY (`menu_id`) REFERENCES `menu` (`menu_id`) ON DELETE CASCADE
);

-- สร้างตาราง health_info
CREATE TABLE `health_info` (
  `health_info_id` INT NOT NULL AUTO_INCREMENT,
  `cat_id` INT NOT NULL,
  `healthType` ENUM('Vaccination', 'Illness', 'Treatment') NOT NULL,
  `description` TEXT DEFAULT NULL,
  `appointmentDate` DATE DEFAULT NULL,
  `admissionDate` DATE NOT NULL,
  PRIMARY KEY (`health_info_id`),
  CONSTRAINT `fk_health_info_cat`
    FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE
);

-- สร้างตาราง cat_schedule
CREATE TABLE `cat_schedule` (
  `cat_schedule_id` INT NOT NULL AUTO_INCREMENT,
  `schedule_id` INT NOT NULL,
  `cat_id` INT NOT NULL,
  `workDate` DATE NOT NULL,
  PRIMARY KEY (`cat_schedule_id`),
  CONSTRAINT `fk_cat_schedule_schedule`
    FOREIGN KEY (`schedule_id`) REFERENCES `work_schedule` (`schedule_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_cat_schedule_cat`
    FOREIGN KEY (`cat_id`) REFERENCES `cat` (`cat_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

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
    REFERENCES menu (`menu_id`)
);
