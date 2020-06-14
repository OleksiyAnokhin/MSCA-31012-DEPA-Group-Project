-- -----------------------------------------------------
-- DATA ENGINEERING PLATFORMS (MSCA 31012)
-- File: Team1Schema.sql
-- Authors: Team 1 DEPA Spring 2020 - Saturday Class
-- Date: 6/10/20
-- -----------------------------------------------------


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema finalproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `finalproject` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sakila` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `finalproject` ;

-- -----------------------------------------------------
-- Table `finalproject`.`Covid_Phase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Covid_Phase` (
  `idCovid_Phase` INT NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Essential Business Restriction` VARCHAR(3) NULL DEFAULT NULL,
  `Essential Activities Restriction` VARCHAR(3) NULL DEFAULT NULL,
  `Physically Distance` VARCHAR(3) NULL DEFAULT NULL,
  `Face Mask Requirement` VARCHAR(3) NULL DEFAULT NULL,
  `Non Essential Business Restriction` VARCHAR(3) NULL DEFAULT NULL,
  `Social Gathering <10 Restriction` VARCHAR(3) NULL DEFAULT NULL,
  `Physically Distance Vulnerable Pop` VARCHAR(3) NULL DEFAULT NULL,
  `Public Amenities Closed` VARCHAR(3) NULL DEFAULT NULL,
  `Events Restriction` VARCHAR(3) NULL DEFAULT NULL,
  PRIMARY KEY (`idCovid_Phase`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Date_dim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Date_dim` (
  `idDate_dim` INT NOT NULL,
  `Date` DATE NOT NULL,
  `Weekday` VARCHAR(11) NOT NULL,
  `Week_Number` DECIMAL(8,2) NOT NULL,
  `Day` INT NOT NULL,
  `month` INT NOT NULL,
  `year` INT NOT NULL,
  `Covid_Phase_idCovid_Phase` INT NULL DEFAULT NULL,
  `Holiday` TINYINT(1) NULL DEFAULT NULL,
  `Day_Temperature(F)` DECIMAL(6,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idDate_dim`),
  INDEX `fk_Date_dim_Covid_Phase1_idx` (`Covid_Phase_idCovid_Phase` ASC) VISIBLE,
  UNIQUE INDEX `Date_UNIQUE` (`Date` ASC) VISIBLE,
  CONSTRAINT `fk_Date_dim_Covid_Phase1`
    FOREIGN KEY (`Covid_Phase_idCovid_Phase`)
    REFERENCES `finalproject`.`Covid_Phase` (`idCovid_Phase`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Bus_Ridership`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Bus_Ridership` (
  `Bus_Ridekey` INT NOT NULL AUTO_INCREMENT,
  `Route` VARCHAR(45) NOT NULL,
  `Date` DATE NULL DEFAULT NULL,
  `Daytype` VARCHAR(1) NULL DEFAULT NULL,
  `Rides` INT NULL DEFAULT NULL,
  INDEX `fk_Bus_Ridership_Date_dim1_idx` (`Date` ASC) VISIBLE,
  UNIQUE INDEX `Route_UNIQUE` (`Route` ASC) VISIBLE,
  PRIMARY KEY (`Bus_Ridekey`),
  CONSTRAINT `fk_Bus_Ridership_Date_dim1`
    FOREIGN KEY (`Date`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 104379
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Zipcode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Zipcode` (
  `idZipcode` INT NOT NULL,
  `all_industries` INT NULL DEFAULT NULL,
  `agriculture_forestry_fishing_hunting` INT NULL DEFAULT NULL,
  `mining_quarrying_oil_gas` INT NULL DEFAULT NULL,
  `utilities` INT NULL DEFAULT NULL,
  `construction` INT NULL DEFAULT NULL,
  `food_beverage_tobacco_manufacturing` INT NULL DEFAULT NULL,
  `other_manufacturing` INT NULL DEFAULT NULL,
  `wholesale_trade` INT NULL DEFAULT NULL,
  `retail_trade` INT NULL DEFAULT NULL,
  `transportation_warehousing` INT NULL DEFAULT NULL,
  `finance_insurance` INT NULL DEFAULT NULL,
  `real_estate_rental_leasing` INT NULL DEFAULT NULL,
  `professional_scientific_technical_services` INT NULL DEFAULT NULL,
  `management_of_companies_enterprises` INT NULL DEFAULT NULL,
  `administrative_support_waste_management` INT NULL DEFAULT NULL,
  `educational_services` INT NULL DEFAULT NULL,
  `health_care_social_assistance` INT NULL DEFAULT NULL,
  `arts_entertainment_recreation` INT NULL DEFAULT NULL,
  `accommodations_food_services` INT NULL DEFAULT NULL,
  `other_services` INT NULL DEFAULT NULL,
  `information` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idZipcode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Bus_Stops_and_Routes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Bus_Stops_and_Routes` (
  `Bus_Stops_and_Routeskey` INT NOT NULL AUTO_INCREMENT,
  `Bus_Stop_Locations_stop_id` INT NOT NULL,
  `Bus_Ridership_Bus_Ridekey` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  `longitude` DECIMAL(10,6) NULL DEFAULT NULL,
  `latitude` DECIMAL(10,6) NULL DEFAULT NULL,
  `Zipcode_id` INT NOT NULL,
  PRIMARY KEY (`Bus_Stops_and_Routeskey`),
  INDEX `fk_Bus_Stops_and_Routes_Zipcode1_idx` (`Zipcode_id` ASC) VISIBLE,
  INDEX `fk_Bus_Stops_and_Routes_Bus_Ridership1_idx` (`Bus_Ridership_Bus_Ridekey` ASC) VISIBLE,
  CONSTRAINT `fk_Bus_Stops_and_Routes_Zipcode1`
    FOREIGN KEY (`Zipcode_id`)
    REFERENCES `finalproject`.`Zipcode` (`idZipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bus_Stops_and_Routes_Bus_Ridership1`
    FOREIGN KEY (`Bus_Ridership_Bus_Ridekey`)
    REFERENCES `finalproject`.`Bus_Ridership` (`Route`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24507
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`CPD_Facilities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`CPD_Facilities` (
  `CPD_facilitieskey` INT NOT NULL AUTO_INCREMENT,
  `Park_No` VARCHAR(45) NOT NULL,
  `Park_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Facility_Type` VARCHAR(45) NULL DEFAULT NULL,
  `Longitude` DECIMAL(9,6) NULL DEFAULT NULL,
  `Latitude` DECIMAL(9,6) NULL DEFAULT NULL,
  `Zip_codeid` INT NOT NULL,
  PRIMARY KEY (`CPD_facilitieskey`),
  INDEX `fk_CPD_Facilities_Zipcode1_idx` (`Zip_codeid` ASC) VISIBLE,
  UNIQUE INDEX `Park_No_UNIQUE` (`Park_No` ASC) VISIBLE,
  CONSTRAINT `fk_CPD_Facilities_Zipcode1`
    FOREIGN KEY (`Zip_codeid`)
    REFERENCES `finalproject`.`Zipcode` (`idZipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 10539
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Covid_Cases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Covid_Cases` (
  `Covid_Caseskey` INT NOT NULL AUTO_INCREMENT,
  `zip_code` INT NULL,
  `week_number` INT NULL DEFAULT NULL,
  `date_week_start` DATE NULL DEFAULT NULL,
  `date_week_end` DATE NOT NULL,
  `Cases_weekly` INT NULL DEFAULT NULL,
  `Cases_Cumulative` INT NULL DEFAULT NULL,
  `Test_Weekly` INT NULL DEFAULT NULL,
  `Tests_Cumulative` INT NULL DEFAULT NULL,
  `Deaths_weekly` INT NULL DEFAULT NULL,
  `Deaths_Cum` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Covid_Caseskey`),
  UNIQUE INDEX `Covid_Caseskey_UNIQUE` (`Covid_Caseskey` ASC) VISIBLE,
  INDEX `fk_Covid_Cases_Zipcode1_idx` (`zip_code` ASC) VISIBLE,
  INDEX `fk_Covid_Cases_Date_dim1_idx` (`date_week_end` ASC) VISIBLE,
  CONSTRAINT `fk_Covid_Cases_Zipcode1`
    FOREIGN KEY (`zip_code`)
    REFERENCES `finalproject`.`Zipcode` (`idZipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Covid_Cases_Date_dim1`
    FOREIGN KEY (`date_week_end`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 100650
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Events` (
  `Eventskey` INT NOT NULL,
  `Requestor` VARCHAR(45) NULL DEFAULT NULL,
  `Organization` VARCHAR(45) NULL DEFAULT NULL,
  `park_number` VARCHAR(45) NULL DEFAULT NULL,
  `park_facility_name` VARCHAR(45) NULL DEFAULT NULL,
  `reservation_start_date` DATE NULL,
  `reservation_end_date` DATE NOT NULL,
  `event_type` VARCHAR(45) NULL DEFAULT NULL,
  `Attendance` INT NULL DEFAULT NULL,
  `event_description` VARCHAR(45) NULL DEFAULT NULL,
  `permit_status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Eventskey`),
  INDEX `fk_Events_Date_dim1_idx` (`reservation_end_date` ASC) VISIBLE,
  INDEX `fk_Events_CPD_Facilities1_idx` (`park_number` ASC) VISIBLE,
  CONSTRAINT `fk_Events_Date_dim1`
    FOREIGN KEY (`reservation_end_date`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Events_CPD_Facilities1`
    FOREIGN KEY (`park_number`)
    REFERENCES `finalproject`.`CPD_Facilities` (`Park_No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Facts_Tables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Facts_Tables` (
  `idFacts_Tables` INT NOT NULL AUTO_INCREMENT,
  `Date_dim_idDate_dim` DATE NOT NULL,
  `Zipcode_idZipcode` INT NOT NULL,
  `Total_Events` INT NULL DEFAULT NULL COMMENT 'Sum of events in Zipcode on that day.',
  `AVG_Daily_Covid Cases` DECIMAL(2,0) NULL DEFAULT NULL COMMENT 'Avg daily cases of Covid. Weekly Total/7 days',
  `Total_Large_Events` INT NULL DEFAULT NULL COMMENT 'Sum of Events > 10k people',
  `Total_Train_Riders` INT NULL DEFAULT NULL,
  `Total_Bus_Riders` INT NULL DEFAULT NULL,
  `AVG_Daily_Covid_Deaths` DECIMAL(10,0) NULL DEFAULT NULL COMMENT 'Weekly deaths in Zip/7 days',
  PRIMARY KEY (`idFacts_Tables`),
  INDEX `fk_Facts_Tables_Date_dim1_idx` (`Date_dim_idDate_dim` ASC) VISIBLE,
  INDEX `fk_Facts_Tables_Zipcode1_idx` (`Zipcode_idZipcode` ASC) VISIBLE,
  CONSTRAINT `fk_Facts_Tables_Date_dim1`
    FOREIGN KEY (`Date_dim_idDate_dim`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Facts_Tables_Zipcode1`
    FOREIGN KEY (`Zipcode_idZipcode`)
    REFERENCES `finalproject`.`Zipcode` (`idZipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 131075
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Google_Mobility`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Google_Mobility` (
  `Google_Mobility_key` INT NOT NULL,
  `STATE` VARCHAR(45) NULL DEFAULT NULL,
  `county` VARCHAR(45) NULL DEFAULT NULL,
  `date` DATE NOT NULL,
  `retail_and_recreation` INT NULL DEFAULT NULL,
  `grocery_and_pharmacy` INT NULL DEFAULT NULL,
  `parks` INT NULL DEFAULT NULL,
  `transit_stations` INT NULL DEFAULT NULL,
  `workplaces` INT NULL DEFAULT NULL,
  `residential` INT NULL DEFAULT NULL,
  `Date_dim_idDate_dim` INT NOT NULL,
  PRIMARY KEY (`Google_Mobility_key`),
  INDEX `fk_Google_Mobility_Date_dim1_idx` (`date` ASC) VISIBLE,
  CONSTRAINT `fk_Google_Mobility_Date_dim1`
    FOREIGN KEY (`date`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `finalproject`.`Train_Station_Locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproject`.`Train_Station_Locations` (
  `idTrain_key` INT NOT NULL AUTO_INCREMENT,
  `station_id` INT NULL DEFAULT NULL,
  `station_name` VARCHAR(45) NULL DEFAULT NULL,
  `date` DATE NULL DEFAULT NULL,
  `rides` INT NULL DEFAULT NULL,
  `Longitude` DECIMAL(9,6) NULL DEFAULT NULL,
  `Latitude` DECIMAL(9,6) NULL DEFAULT NULL,
  `zip_code` INT NOT NULL,
  `hub` INT NOT NULL,
  PRIMARY KEY (`idTrain_key`),
  INDEX `fk_Train_Station_Locations_Zipcode1_idx` (`zip_code` ASC) VISIBLE,
  INDEX `fk_Train_Station_Locations_Date_dim1_idx` (`date` ASC) VISIBLE,
  CONSTRAINT `fk_Train_Station_Locations_Zipcode1`
    FOREIGN KEY (`zip_code`)
    REFERENCES `finalproject`.`Zipcode` (`idZipcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Train_Station_Locations_Date_dim1`
    FOREIGN KEY (`date`)
    REFERENCES `finalproject`.`Date_dim` (`Date`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 165665
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;