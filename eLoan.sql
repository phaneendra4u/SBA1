-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema eloan
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema eloan
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eloan` DEFAULT CHARACTER SET utf8mb4 ;
USE `eloan` ;

-- -----------------------------------------------------
-- Table `eloan`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eloan`.`user` (
  `userid` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `eloan`.`loaninfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eloan`.`loaninfo` (
  `applno` INT(11) NOT NULL AUTO_INCREMENT,
  `purpose` VARCHAR(45) NOT NULL,
  `amtrequest` INT(11) NOT NULL,
  `doa` DATE NOT NULL,
  `bstructure` VARCHAR(45) NOT NULL,
  `bindicator` VARCHAR(45) NOT NULL,
  `tindicator` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `mobile` VARCHAR(11) NULL DEFAULT NULL,
  `status` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`applno`),
  INDEX `username` (`username` ASC) VISIBLE,
  CONSTRAINT `loaninfo_ibfk_1`
    FOREIGN KEY (`username`)
    REFERENCES `eloan`.`user` (`username`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `eloan`.`approvedloan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `eloan`.`approvedloan` (
  `approvedLoanid` INT(11) NOT NULL AUTO_INCREMENT,
  `applno` INT(11) NOT NULL,
  `amountsanctioned` DOUBLE NOT NULL,
  `loanterm` INT(11) NOT NULL,
  `paymentstartdate` DATE NOT NULL,
  `loanclosuredate` DATE NOT NULL,
  `loanemi` DOUBLE NOT NULL,
  PRIMARY KEY (`approvedLoanid`),
  INDEX `applno` (`applno` ASC) VISIBLE,
  CONSTRAINT `approvedloan_ibfk_1`
    FOREIGN KEY (`applno`)
    REFERENCES `eloan`.`loaninfo` (`applno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
