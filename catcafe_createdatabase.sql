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