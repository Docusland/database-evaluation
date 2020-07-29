-- MySQL Script generated by MySQL Workbench
-- Wed Jul 29 15:06:55 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`address` ;

CREATE TABLE IF NOT EXISTS `mydb`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `street` VARCHAR(100) NOT NULL,
  `zip` INT NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`owner` ;

CREATE TABLE IF NOT EXISTS `mydb`.`owner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `genred` INT NOT NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_owner_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_owner_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`status` ;

CREATE TABLE IF NOT EXISTS `mydb`.`status` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`service_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`service_type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`service_type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`type` (
  `id` SMALLINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`housing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`housing` ;

CREATE TABLE IF NOT EXISTS `mydb`.`housing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nb_unit` INT NOT NULL,
  `nb_room` INT NOT NULL,
  `surface` INT NOT NULL,
  `tariff` FLOAT NOT NULL,
  `description` TEXT NOT NULL,
  `reference` VARCHAR(45) NOT NULL,
  `energetic_performance` VARCHAR(100) NOT NULL,
  `ghg_emission` VARCHAR(100) NOT NULL,
  `created_at` DATE NOT NULL,
  `owner_id` INT NOT NULL,
  `status_id` SMALLINT NOT NULL,
  `address_id` INT NOT NULL,
  `service_type_id` SMALLINT NOT NULL,
  `type_id` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_housing_owner1_idx` (`owner_id` ASC),
  INDEX `fk_housing_status1_idx` (`status_id` ASC),
  INDEX `fk_housing_address1_idx` (`address_id` ASC),
  INDEX `fk_housing_benefit_type1_idx` (`service_type_id` ASC),
  INDEX `fk_housing_type1_idx` (`type_id` ASC),
  CONSTRAINT `fk_housing_owner1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `mydb`.`owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housing_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `mydb`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housing_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `mydb`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housing_benefit_type1`
    FOREIGN KEY (`service_type_id`)
    REFERENCES `mydb`.`service_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_housing_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`photo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`photo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(255) NOT NULL,
  `comment` TEXT NULL,
  `created_at` DATE NOT NULL,
  `housing_id` INT NOT NULL,
  INDEX `fk_photo_housing_idx` (`housing_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_photo_housing`
    FOREIGN KEY (`housing_id`)
    REFERENCES `mydb`.`housing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`staff` ;

CREATE TABLE IF NOT EXISTS `mydb`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment_housing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comment_housing` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comment_housing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `created_at` DATE NOT NULL,
  `housing_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_housing1_idx` (`housing_id` ASC),
  INDEX `fk_comment_staff1_idx` (`staff_id` ASC),
  CONSTRAINT `fk_comment_housing1`
    FOREIGN KEY (`housing_id`)
    REFERENCES `mydb`.`housing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `mydb`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`comment_owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`comment_owner` ;

CREATE TABLE IF NOT EXISTS `mydb`.`comment_owner` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `text` TEXT NOT NULL,
  `created_at` DATE NOT NULL,
  `owner_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comment_owner1_idx` (`owner_id` ASC),
  INDEX `fk_comment_staff1_idx` (`staff_id` ASC),
  CONSTRAINT `fk_comment_owner10`
    FOREIGN KEY (`owner_id`)
    REFERENCES `mydb`.`owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_staff10`
    FOREIGN KEY (`staff_id`)
    REFERENCES `mydb`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`histo_housing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`histo_housing` ;

CREATE TABLE IF NOT EXISTS `mydb`.`histo_housing` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tariff` FLOAT NOT NULL,
  `created_at` DATE NOT NULL,
  `housing_id` INT NOT NULL,
  `status_id` SMALLINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_hito_status_housing1_idx` (`housing_id` ASC),
  INDEX `fk_histo_housing_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_hito_status_housing1`
    FOREIGN KEY (`housing_id`)
    REFERENCES `mydb`.`housing` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_histo_housing_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `mydb`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
