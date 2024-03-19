-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shopping-cart
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema shopping-cart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shopping-cart` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `shopping-cart` ;

-- -----------------------------------------------------
-- Table `shopping-cart`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`product` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`product` (
  `pid` VARCHAR(45) NOT NULL,
  `pname` VARCHAR(100) NULL DEFAULT NULL,
  `ptype` VARCHAR(20) NULL DEFAULT NULL,
  `pinfo` VARCHAR(350) NULL DEFAULT NULL,
  `pprice` DECIMAL(12,2) NULL DEFAULT NULL,
  `pquantity` INT NULL DEFAULT NULL,
  `image` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `shopping-cart`.`orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`orders` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`orders` (
  `orderid` VARCHAR(45) NOT NULL,
  `prodid` VARCHAR(45) NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  `shipped` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`orderid`, `prodid`),
  INDEX `productid_idx` (`prodid` ASC) VISIBLE,
  CONSTRAINT `productid`
    FOREIGN KEY (`prodid`)
    REFERENCES `shopping-cart`.`product` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `shopping-cart`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`user` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`user` (
  `email` VARCHAR(60) NOT NULL,
  `name` VARCHAR(30) NULL DEFAULT NULL,
  `mobile` BIGINT NULL DEFAULT NULL,
  `address` VARCHAR(250) NULL DEFAULT NULL,
  `pincode` INT NULL DEFAULT NULL,
  `password` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `shopping-cart`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`transactions` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`transactions` (
  `transid` VARCHAR(45) NOT NULL,
  `username` VARCHAR(60) NULL DEFAULT NULL,
  `time` DATETIME NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`transid`),
  INDEX `truserid_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `truserid`
    FOREIGN KEY (`username`)
    REFERENCES `shopping-cart`.`user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `transorderid`
    FOREIGN KEY (`transid`)
    REFERENCES `shopping-cart`.`orders` (`orderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `shopping-cart`.`user_demand`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`user_demand` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`user_demand` (
  `username` VARCHAR(60) NOT NULL,
  `prodid` VARCHAR(45) NOT NULL,
  `quantity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`username`, `prodid`),
  INDEX `prodid_idx` (`prodid` ASC) VISIBLE,
  CONSTRAINT `userdemailemail`
    FOREIGN KEY (`username`)
    REFERENCES `shopping-cart`.`user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prodid`
    FOREIGN KEY (`prodid`)
    REFERENCES `shopping-cart`.`product` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table `shopping-cart`.`usercart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shopping-cart`.`usercart` ;

CREATE TABLE IF NOT EXISTS `shopping-cart`.`usercart` (
  `username` VARCHAR(60) NULL DEFAULT NULL,
  `prodid` VARCHAR(45) NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  INDEX `useremail_idx` (`username` ASC) VISIBLE,
  INDEX `prodidcart_idx` (`prodid` ASC) VISIBLE,
  CONSTRAINT `useremail`
    FOREIGN KEY (`username`)
    REFERENCES `shopping-cart`.`user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prodidcart`
    FOREIGN KEY (`prodid`)
    REFERENCES `shopping-cart`.`product` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`orders` (`orderid`, `prodid`, `quantity`, `amount`, `shipped`) VALUES ('TR10001', 'P20230423082243', 1, 125999, 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`user`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`user` (`email`, `name`, `mobile`, `address`, `pincode`, `password`) VALUES ('guest@gmail.com', 'Guest User', 9876543234, 'K.P Road, Gaya, Something', 879767, 'guest');
INSERT INTO `shopping-cart`.`user` (`email`, `name`, `mobile`, `address`, `pincode`, `password`) VALUES ('admin@gmail.com', 'Admin User', 9876543459, 'ABC Colony, Newtown, Strange', 786890, 'admin');

COMMIT;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`transactions`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`transactions` (`transid`, `username`, `time`, `amount`) VALUES ('TR10001', 'guest@gmail.com', '2023-04-23 09:26:56', 125999);

COMMIT;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`user_demand`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`user_demand` (`username`, `prodid`, `quantity`) VALUES ('guest@gmail.com', 'P20230423084144', 3);

COMMIT;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`usercart`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`usercart` (`username`, `prodid`, `quantity`) VALUES ('guest@gmail.com', 'P20230423082243', 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `shopping-cart`.`product`
-- -----------------------------------------------------
START TRANSACTION;
USE `shopping-cart`;
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423082243', 'APPLE iPhone 13 Pro (Graphite, 512 GB)', 'mobile', 'iPhone 13. boasts an advanced dual-camera system that allows you to click mesmerising pictures with immaculate clarity.', 125999.00, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423083830', 'HP Intel Core i5 11th Gen', 'laptop', 'Hp Laptop (8 GB/512 GB SSD/Windows 11 Home) 15s- fr4000TU Thin and Light Laptop  (15.6 Inch, Natural Silver, 1.69 Kg, With MS Office)', 40990.00, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084143', 'LED Smart Google TV ', 'tv', 'Mi X Pro 125 cm (50 inch) Ultra HD (4K) LED Smart Google TV with Dolby Vision IQ and 30W Dolby Atmos', 41999.00, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084145', 'realme NEO 80 cm (32 inch) HD Ready LED Smart Linux TV  (RMV2101)', 'tv', 'Enjoy watching high-quality entertainment with immersive audio with the realme Smart TV Neo in your home.', 11999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084146', 'REDMI Note 12 Pro 5G', 'mobile', 'Stardust Purple, 128 GB (6 GB RAM) | 16.94 cm (6.67 inch) Full HD Display | 50MP (OIS) + 8MP + 2MP | 16MP Front Camera | 5000 mAh Lithium Polymer Battery', 24999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084147', 'Google Pixel 6a (Charcoal, 128 GB)', 'mobile', 'Experience intuitiveness and enjoy seamless operation with smooth transition with the 5G-ready Google Pixel 6a that comes bundled with a myriad of innovative features.', 27999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084148', 'Infinix Y1 80 cm (32 inch) HD Ready LED Smart Linux TV', 'tv', 'Infinix Y1 80 cm (32 inch) HD Ready LED Smart Linux TV with Wall Mount  (32Y1)', 8499, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084149', 'Canon EOS 1500D DSLR Camera', 'camera', 'This Canon Camera gives you the freedom to explore different ways to shoot subjects. ', 38499, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084150', 'IMPLY GO PRO 4K Full HD Camera', 'camera', 'IMPLY GO PRO 4K Full HD WiFi 30M Waterproof Sports Action Camera Waterproof DV Camcorder 16MP Sports and Action Camera  (Black, 16 MP)', 1999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084151', 'IndusBay Kids Camera', 'camera', 'Kids Digital Camera Video Recorder , Mini 2 Inches Screen Children\'s Camera 8MP Great Gift for Boys (Blue) Instant Camera  (Blue)', 899, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084152', 'ZEBRONICS ZEB-WARRIOR Speaker', 'speaker', '10 W Laptop/Desktop Speaker  (Black, Black, 2.0 Channel)', 899, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084153', 'Mivi Roam2 5 W Bluetooth Speaker', 'speaker', 'Take your music on-the-go with the portable & powerful Mivi Roam 2 wireless bluetooth speaker. A perfect speaker to stir up every mood with stereo quality sound and an extensively punchy bass.', 899, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084154', 'JBL Go Essential Speaker', 'speaker', 'JBL Go Essential with Rich Bass, 5 Hrs Playtime, IPX7 Waterproof, Ultra Portable 3.1 W Bluetooth Speaker  (Black, Mono Channel)', 1699, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084155', 'SAMSUNG Galaxy Tab', 'tablet', 'SAMSUNG Galaxy Tab A8 3 GB RAM 32 GB ROM 10.5 inch with Wi-Fi Only Tablet (Gray)', 16999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084156', 'Realme Pad 3 GB', 'tablet', 'realme Pad 3 GB RAM 32 GB ROM 10.4 inch with Wi-Fi Only Tablet (Grey)', 13999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084157', 'REDMI Pad 6', 'tablet', 'REDMI Pad 6 GB RAM 128 GB ROM 10.61 Inch with Wi-Fi Only Tablet (Graphite Gray)', 18999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084158', 'ASUS Vivobook 15 Core i3 11th Gen', 'laptop', 'ASUS Vivobook 15 Core i3 11th Gen - (8 GB/512 GB SSD/Windows 11 Home) X515EA-EJ322WS | X515EA-EJ328WS Thin and Light Laptop  (15.6 Inch, Transparent Silver, 1.80 kg, With MS Office)', 50999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084159', 'Acer Extensa Core i5 11th Gen', 'laptop', '8 GB/512 GB SSD/Windows 11 Home |  EX 215-54-583M Thin and Light Laptop  (15.6 Inch, Charcoal Black, 1.7 Kg)', 57999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084160', 'Lenovo IdeaPad Slim 3 Intel Core i3 11th Gen', 'laptop', '8 GB/256 GB SSD/Windows 11 Home | 15ITL05 Thin and Light Laptop  (15.6 Inch, Platinum Grey, 1.7 Kg, With MS Office)', 60999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084161', '90 L Desert Air Cooler', 'cooler', 'Powerful Cooling matched with modern aesthetics, Powerful Cool Air Delivery of 4300 cubic m/hr., Suitable for room upto 500 sq. ft.,', 10999, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084162', 'Crest Neo Fan', 'fan', 'BAJAJ Crest Neo 1200 mm Ultra High Speed 3 Blade Ceiling Fan  (Brown, Pack of 1)#JustHere', 1399, 1000);
INSERT INTO `shopping-cart`.`product` (`pid`, `pname`, `ptype`, `pinfo`, `pprice`, `pquantity`) VALUES ('P20230423084144', 'MOTOROLA G32 Mobile', 'mobile', 'With a mind-blowing 16.51 cm (6.5) FHD+ Ultra-wide display and a refresh rate of 90 Hz, this phone makes it possible to multitask while being entertained.', 11999, 1000);

COMMIT;
