SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema catcafemanagement
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `catcafemanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `catcafemanagement` ;

-- -----------------------------------------------------
-- Table `breed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `breed` (
  `breed_id` VARCHAR(45) NOT NULL,
  `breedName` VARCHAR(45) NOT NULL,
  `character` VARCHAR(45) NULL,
  PRIMARY KEY (`breed_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cat` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `gender` ENUM('Male', 'Female') NOT NULL,
  `birthDate` DATE NOT NULL,
  `status` ENUM('Available', 'Not Available') NOT NULL,
  `image` VARCHAR(255) NULL DEFAULT NULL,
  `breed_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cat_id`),
  INDEX `fk_cat_breed1_idx` (`breed_id` ASC) VISIBLE,
  CONSTRAINT `fk_cat_breed1`
    FOREIGN KEY (`breed_id`)
    REFERENCES `breed` (`breed_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `health_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `health_info` (
  `catinfo_id` INT NOT NULL AUTO_INCREMENT,
  `cat_id` INT NOT NULL,
  `healthType` ENUM('Vaccination', 'Illness', 'Treatment', 'normal') NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `appointmentDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`catinfo_id`),
  INDEX `CatID` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `cathealthinfo_ibfk_1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cat` (`cat_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NULL,
  `birthDate` DATE NOT NULL,
  `points` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `position` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` INT NOT NULL AUTO_INCREMENT,
  `menuName` VARCHAR(100) NOT NULL,
  `category` ENUM('Food', 'Drink', 'Dessert', 'Ticket') NOT NULL,
  PRIMARY KEY (`menu_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bill` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `billDate` DATE NOT NULL,
  `TotalAmount` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NULL, -- เปลี่ยนเป็น NULL
  `employee_id` INT NULL, -- เปลี่ยนเป็น NULL
  PRIMARY KEY (`bill_id`),
  INDEX `CustomerID` (`customer_id` ASC) VISIBLE,
  INDEX `StaffID` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `order_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE SET NULL,
  CONSTRAINT `order_ibfk_2`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `bill_id` INT NOT NULL,
  `menu_Id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `OrderID` (`bill_id` ASC) VISIBLE,
  INDEX `MenuID` (`menu_Id` ASC) VISIBLE,
  CONSTRAINT `orderdetail_ibfk_1`
    FOREIGN KEY (`bill_id`)
    REFERENCES `bill` (`bill_id`)
    ON DELETE CASCADE,
  CONSTRAINT `orderdetail_ibfk_2`
    FOREIGN KEY (`menu_Id`)
    REFERENCES `menu` (`menu_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `promotion` (
  `promotion_id` INT NOT NULL AUTO_INCREMENT,
  `promotionName` VARCHAR(100) NOT NULL,
  `discountPercent` DECIMAL(5,2) NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `menu_id` INT NOT NULL,
  PRIMARY KEY (`promotion_id`),
  INDEX `fk_promotion_menu1_idx` (`menu_id` ASC) VISIBLE,
  CONSTRAINT `fk_promotion_menu1`
    FOREIGN KEY (`menu_id`)
    REFERENCES `menu` (`menu_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `premium_gift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `premium_gift` (
  `gift_id` INT NOT NULL,
  `giftName` VARCHAR(45) NOT NULL,
  `point_use` INT NOT NULL,
  `quantityInStock` INT NOT NULL,
  PRIMARY KEY (`gift_id`),
  UNIQUE INDEX `gift_name_UNIQUE` (`giftName` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `exchange_gift`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `exchange_gift` (
  `premiumgift_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`premiumgift_id`, `customer_id`),
  INDEX `fk_premium_gift_has_customer_customer1_idx` (`customer_id` ASC) VISIBLE,
  INDEX `fk_premium_gift_has_customer_premium_gift1_idx` (`premiumgift_id` ASC) VISIBLE,
  CONSTRAINT `fk_premium_gift_has_customer_premium_gift1`
    FOREIGN KEY (`premiumgift_id`)
    REFERENCES `premium_gift` (`gift_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_premium_gift_has_customer_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `work_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `work_schedule` (
  `schedule_id` INT NOT NULL,
  `day` VARCHAR(45) NOT NULL,
  `timeStart` VARCHAR(45) NOT NULL,
  `timeEnd` VARCHAR(45) NOT NULL,
  `workShift` ENUM('Morning', 'Night') NOT NULL,
  PRIMARY KEY (`schedule_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `enter_work`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enter_work` (
  `employee_id` INT NOT NULL,
  `workschedule_id` INT NOT NULL,
  `workDate` VARCHAR(45) NOT NULL,
  `enter_work_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`enter_work_id`),
  INDEX `fk_employee_has_work_schedule_work_schedule1_idx` (`workschedule_id` ASC) VISIBLE,
  INDEX `fk_employee_has_work_schedule_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_work_schedule_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_work_schedule_work_schedule1`
    FOREIGN KEY (`workschedule_id`)
    REFERENCES `work_schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cat_schedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cat_schedule` (
  `schedule_id` INT NOT NULL AUTO_INCREMENT,
  `day` VARCHAR(45) NOT NULL,
  `timeStart` VARCHAR(45) NOT NULL,
  `timeEnd` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`schedule_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cat_attend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cat_attend` (
  `cat_id` INT NOT NULL,
  `schedule_id` INT NOT NULL,
  PRIMARY KEY (`cat_id`, `schedule_id`),
  INDEX `fk_cat_has_cat_schedule_cat_schedule1_idx` (`schedule_id` ASC) VISIBLE,
  INDEX `fk_cat_has_cat_schedule_cat1_idx` (`cat_id` ASC) VISIBLE,
  CONSTRAINT `fk_cat_has_cat_schedule_cat1`
    FOREIGN KEY (`cat_id`)
    REFERENCES `cat` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cat_has_cat_schedule_cat_schedule1`
    FOREIGN KEY (`schedule_id`)
    REFERENCES `cat_schedule` (`schedule_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
