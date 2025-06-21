/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `smile`;
CREATE DATABASE IF NOT EXISTS `smile` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `smile`;

DROP TABLE IF EXISTS `addon_account`;
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

REPLACE INTO `addon_account` (`name`, `label`, `shared`) VALUES
	('bank_savings', 'Savings account', 0),
	('caution', 'caution', 0),
	('society_ambulance', 'EMS', 1),
	('society_banker', 'Bank', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1);

DROP TABLE IF EXISTS `addon_account_data`;
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

REPLACE INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
	(1, 'society_cardealer', 0, NULL),
	(2, 'society_police', 0, NULL),
	(3, 'society_ambulance', 0, NULL),
	(4, 'society_mechanic', 0, NULL),
	(5, 'society_taxi', 0, NULL);

--  Table smile.addon_inventory
DROP TABLE IF EXISTS `addon_inventory`;
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.addon_inventory: ~5 rows (approximately)
REPLACE INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'EMS', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1);

--  Table smile.addon_inventory_items
DROP TABLE IF EXISTS `addon_inventory_items`;
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.addon_inventory_items: ~0 rows (approximately)

--  Table smile.af_composts
DROP TABLE IF EXISTS `af_composts`;
CREATE TABLE IF NOT EXISTS `af_composts` (
  `farmId` int(11) DEFAULT NULL,
  `compostStrid` varchar(128) DEFAULT NULL,
  `shitAmount` int(11) DEFAULT NULL,
  KEY `farmId` (`farmId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.af_composts: ~6 rows (approximately)
REPLACE INTO `af_composts` (`farmId`, `compostStrid`, `shitAmount`) VALUES
	(16, 'compost-2', 0),
	(16, 'compost-1', 0),
	(17, 'compost-1', 0),
	(17, 'compost-2', 0),
	(18, 'compost-1', 0),
	(18, 'compost-2', 0);

--  Table smile.af_farms_base
DROP TABLE IF EXISTS `af_farms_base`;
CREATE TABLE IF NOT EXISTS `af_farms_base` (
  `farmId` int(11) NOT NULL AUTO_INCREMENT,
  `ownerIdentifier` varchar(255) DEFAULT NULL,
  `ownerName` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `x` int(11) DEFAULT NULL,
  `y` int(11) DEFAULT NULL,
  `z` int(11) DEFAULT NULL,
  `img` text DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `locked` tinyint(4) DEFAULT NULL,
  `milk` int(11) DEFAULT 0,
  `egg` int(11) DEFAULT 0,
  `meal` int(11) DEFAULT 0,
  KEY `id` (`farmId`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.af_farms_base: ~3 rows (approximately)
REPLACE INTO `af_farms_base` (`farmId`, `ownerIdentifier`, `ownerName`, `price`, `x`, `y`, `z`, `img`, `name`, `locked`, `milk`, `egg`, `meal`) VALUES
	(16, 'char1:11000013e99abb8', 'Newbie tập chơi', 10000, 2130, 4794, 41, 'https://fauto.vn/wp-content/uploads/2022/05/chup-anh-sexy-4-600x570.jpg', 'Bo may day', 0, 0, 12, 0),
	(17, 'char1:11000013d1db9cb', 'Minh Mèo', 50000, 2051, 4810, 41, '', 'cua ai day', 1, 0, 23, 0),
	(18, 'char1:11000015533e38b', 'H', 5000, 2027, 4833, 41, '', 'ahahah', 0, 0, 0, 0);

--  Table smile.af_paddock_animals
DROP TABLE IF EXISTS `af_paddock_animals`;
CREATE TABLE IF NOT EXISTS `af_paddock_animals` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `farmId` int(11) NOT NULL,
  `paddockStrid` varchar(128) NOT NULL,
  `hunger` int(11) DEFAULT NULL,
  `age` double DEFAULT NULL,
  `thirst` int(11) DEFAULT NULL,
  `animalType` varchar(128) DEFAULT NULL,
  `milk` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `health` int(11) DEFAULT NULL,
  `extra` double DEFAULT NULL,
  PRIMARY KEY (`aid`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=187 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.af_paddock_animals: 37 rows
/*!40000 ALTER TABLE `af_paddock_animals` DISABLE KEYS */;
REPLACE INTO `af_paddock_animals` (`aid`, `farmId`, `paddockStrid`, `hunger`, `age`, `thirst`, `animalType`, `milk`, `weight`, `health`, `extra`) VALUES
	(150, 16, 'paddock-2', 0, 0, 0, 'COW', 87, NULL, 0, 0.722),
	(151, 16, 'paddock-2', 0, 0, 0, 'PIG', NULL, 17, 0, 0.729),
	(152, 16, 'paddock-3', 0, 0, 0, 'COW', 100, NULL, 0, 0.748),
	(153, 16, 'paddock-3', 0, 0, 0, 'PIG', NULL, 20, 0, 0.642),
	(154, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.97),
	(155, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.768),
	(156, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.847),
	(157, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.875),
	(158, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.738),
	(159, 16, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.784),
	(160, 17, 'paddock-1', 0, 0, 0, 'PIG', NULL, 20, 0, 0.847),
	(161, 17, 'paddock-1', 0, 0, 0, 'COW', 100, NULL, 0, 0.655),
	(162, 17, 'paddock-1', 0, 0, 0, 'PIG', NULL, 20, 0, 0.944),
	(163, 17, 'paddock-1', 0, 0, 0, 'PIG', NULL, 22, 0, 0.729),
	(164, 17, 'paddock-2', 0, 0, 0, 'PIG', NULL, 15, 0, 0.876),
	(165, 17, 'paddock-2', 0, 0, 0, 'PIG', NULL, 15, 0, 0.836),
	(166, 17, 'paddock-2', 0, 0, 0, 'PIG', NULL, 18, 0, 0.662),
	(167, 17, 'paddock-2', 0, 0, 0, 'PIG', NULL, 17, 0, 0.763),
	(168, 17, 'paddock-2', 0, 0, 0, 'PIG', NULL, 15, 0, 0.837),
	(169, 17, 'paddock-3', 0, 0, 0, 'PIG', NULL, 17, 0, 0.917),
	(170, 17, 'paddock-3', 0, 0, 0, 'COW', 83, NULL, 0, 0.687),
	(171, 17, 'paddock-3', 0, 0, 0, 'COW', 85, NULL, 0, 0.609),
	(172, 17, 'paddock-3', 17, 0, 0, 'COW', 78, NULL, 0, 0.79),
	(173, 17, 'paddock-3', 6, 0, 0, 'COW', 81, NULL, 0, 0.734),
	(174, 17, 'paddock-3', 20, 0, 0, 'COW', 71, NULL, 0, 0.986),
	(175, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.754),
	(176, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.725),
	(177, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.628),
	(178, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.985),
	(179, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.761),
	(180, 17, 'chicken-paddock-1', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.993),
	(181, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.779),
	(182, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.822),
	(183, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.949),
	(184, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.719),
	(185, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.678),
	(186, 17, 'chicken-paddock-2', 0, 0, 0, 'CHICKEN', NULL, NULL, 0, 0.984);
/*!40000 ALTER TABLE `af_paddock_animals` ENABLE KEYS */;

--  Table smile.af_paddock_upgrades
DROP TABLE IF EXISTS `af_paddock_upgrades`;
CREATE TABLE IF NOT EXISTS `af_paddock_upgrades` (
  `farmId` int(11) DEFAULT NULL,
  `paddockStrid` varchar(128) DEFAULT NULL,
  `upgradeStrid` varchar(128) DEFAULT NULL,
  `foodAmount` int(11) DEFAULT NULL,
  `waterAmount` int(11) DEFAULT NULL,
  KEY `farmId` (`farmId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.af_paddock_upgrades: ~24 rows (approximately)
REPLACE INTO `af_paddock_upgrades` (`farmId`, `paddockStrid`, `upgradeStrid`, `foodAmount`, `waterAmount`) VALUES
	(16, 'paddock-1', 'water-2', NULL, 0),
	(17, 'paddock-2', 'water-1', NULL, 0),
	(17, 'chicken-paddock-2', 'water-1', NULL, 0),
	(17, 'chicken-paddock-2', 'trough-1', 0, NULL),
	(17, 'chicken-paddock-2', 'trough-2', 0, NULL),
	(17, 'paddock-1', 'water-2', NULL, 0),
	(17, 'paddock-1', 'water-3', NULL, 0),
	(17, 'paddock-1', 'water-1', NULL, 0),
	(17, 'paddock-1', 'trough-1', 0, NULL),
	(17, 'paddock-1', 'trough-2', 0, NULL),
	(17, 'paddock-2', 'water-2', NULL, 0),
	(17, 'paddock-2', 'water-3', NULL, 0),
	(17, 'paddock-2', 'trough-1', 0, NULL),
	(17, 'paddock-2', 'trough-2', 0, NULL),
	(17, 'paddock-3', 'water-1', NULL, 0),
	(17, 'paddock-3', 'water-2', NULL, 0),
	(17, 'paddock-3', 'water-3', NULL, 0),
	(17, 'paddock-3', 'water-4', NULL, 0),
	(17, 'paddock-3', 'trough-1', 0, NULL),
	(17, 'paddock-3', 'trough-2', 0, NULL),
	(17, 'paddock-3', 'trough-3', 0, NULL),
	(17, 'chicken-paddock-1', 'water-1', NULL, 0),
	(17, 'chicken-paddock-1', 'trough-1', 0, NULL),
	(17, 'chicken-paddock-1', 'trough-2', 0, NULL);

--  Table smile.aircrafts
DROP TABLE IF EXISTS `aircrafts`;
CREATE TABLE IF NOT EXISTS `aircrafts` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.aircrafts: ~11 rows (approximately)
REPLACE INTO `aircrafts` (`name`, `model`, `price`, `category`) VALUES
	('Frogger', 'frogger', 1500000, 'heli'),
	('Luxor', 'luxor', 1500000, 'plane'),
	('Luxor Deluxe ', 'luxor2', 1750000, 'plane'),
	('Ultra Light', 'microlight', 100000, 'plane'),
	('Nimbus', 'nimbus', 900000, 'plane'),
	('Sea Breeze', 'seabreeze', 850000, 'plane'),
	('Shamal', 'shamal', 1150000, 'plane'),
	('Swift Deluxe', 'swift2', 4000000, 'heli'),
	('Velum', 'velum2', 450000, 'plane'),
	('Vestra', 'vestra', 950000, 'plane'),
	('Volatus', 'volatus', 1000000, 'heli');

--  Table smile.aircraft_categories
DROP TABLE IF EXISTS `aircraft_categories`;
CREATE TABLE IF NOT EXISTS `aircraft_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.aircraft_categories: ~2 rows (approximately)
REPLACE INTO `aircraft_categories` (`name`, `label`) VALUES
	('heli', 'Helicopters'),
	('plane', 'Planes');

--  Table smile.ak4y_fishing
DROP TABLE IF EXISTS `ak4y_fishing`;
CREATE TABLE IF NOT EXISTS `ak4y_fishing` (
  `citizenid` varchar(255) DEFAULT NULL,
  `currentXP` int(11) DEFAULT NULL,
  `tasks` longtext DEFAULT NULL,
  `time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.ak4y_fishing: ~0 rows (approximately)

--  Table smile.allhousing
DROP TABLE IF EXISTS `allhousing`;
CREATE TABLE IF NOT EXISTS `allhousing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(46) DEFAULT NULL,
  `ownername` varchar(50) NOT NULL,
  `owned` tinyint(4) NOT NULL,
  `price` int(11) NOT NULL,
  `resalepercent` int(11) NOT NULL,
  `resalejob` varchar(50) NOT NULL,
  `entry` longtext DEFAULT NULL,
  `garage` longtext DEFAULT NULL,
  `furniture` longtext DEFAULT NULL,
  `shell` varchar(50) NOT NULL,
  `interior` varchar(50) NOT NULL,
  `shells` longtext DEFAULT NULL,
  `doors` longtext DEFAULT NULL,
  `housekeys` longtext DEFAULT NULL,
  `wardrobe` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL,
  `inventorylocation` longtext DEFAULT NULL,
  `mortgage_owed` int(11) NOT NULL DEFAULT 0,
  `last_repayment` int(11) NOT NULL DEFAULT 0,
  `cannangkhodo` int(11) NOT NULL DEFAULT 10000000,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.allhousing: ~0 rows (approximately)

--  Table smile.baninfo
DROP TABLE IF EXISTS `baninfo`;
CREATE TABLE IF NOT EXISTS `baninfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(100) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `playername` varchar(32) DEFAULT NULL,
  `hwid` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--  Data of table smile.baninfo: ~2 rows (approximately)
REPLACE INTO `baninfo` (`id`, `license`, `identifier`, `liveid`, `xblid`, `discord`, `playerip`, `playername`, `hwid`) VALUES
	(1, 'license:c62d288446a7502bf5ebd6f3e485067f3f9b1ca5', 'steam:11000013e621c8b', 'live:1055518906763301', 'xbl:2535414487300931', 'discord:1002718140020568104', 'ip:192.168.1.99', 'Bun', '["3:ce0dbc0917fc5c81c048dc5d5f7d4d63302de098823c3b216fc94793712e852f","2:e9ccd73b9ce38a858bfab284817f7905007f34b2422f7a431243ae41dad1e158","4:d0395f0400a8c21066e85fe2cbf99695cdced8194b44291d888f06e95abf138b","4:9ae6986cf762e3b3fa73cd0f0ceede59fd896530ed6ed38280e555f9fd8c9e7f","4:36701e7f2b8b4573adb85567fac4c5cb3bb6f2461463e236b52464c14d59dbb1"]'),
	(2, 'license:6b13b294a2e7ef1d332f4083d6b08da12112dbdc', 'steam:1100001147e8c1c', NULL, NULL, 'discord:847739460988174336', 'ip:118.69.77.73', 'Bin', '["2:47ba6880235f3c012c5ee7496cd9f8b5e4cc38ceb12d9408821fa9e227e76ae2","3:fa6a965c38aa2b4f7d1a1b88ff415b68d82113743055eb63971c5f99016b9e76","5:fd596430d90c9a70c757334ec3eb3e4ba2ffd7e54566229a7c77d48be036cf75","4:7f45cef7456e080bca515f6f1b3f394a900003eea779f78b1783ea7452702966","4:3b8ea81a71d65fb982978b02ad9e3cea3214af7918da209e74418aae0cfbdd3e","4:137ce2cc9be0904d831bcfccd67390b25c1c1b80a979fada9d6280c73e98ea2e"]');

--  Table smile.banking
DROP TABLE IF EXISTS `banking`;
CREATE TABLE IF NOT EXISTS `banking` (
  `identifier` varchar(46) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `amount` int(64) DEFAULT NULL,
  `time` bigint(20) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `balance` int(11) DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.banking: ~0 rows (approximately)

--  Table smile.banlist
DROP TABLE IF EXISTS `banlist`;
CREATE TABLE IF NOT EXISTS `banlist` (
  `license` varchar(100) NOT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` varchar(50) NOT NULL,
  `expiration` varchar(50) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  `hwid` longtext NOT NULL,
  PRIMARY KEY (`license`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--  Data of table smile.banlist: ~0 rows (approximately)

--  Table smile.banlisthistory
DROP TABLE IF EXISTS `banlisthistory`;
CREATE TABLE IF NOT EXISTS `banlisthistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `license` varchar(50) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `liveid` varchar(21) DEFAULT NULL,
  `xblid` varchar(21) DEFAULT NULL,
  `discord` varchar(30) DEFAULT NULL,
  `playerip` varchar(25) DEFAULT NULL,
  `targetplayername` varchar(32) DEFAULT NULL,
  `sourceplayername` varchar(32) DEFAULT NULL,
  `reason` varchar(255) NOT NULL,
  `timeat` int(11) NOT NULL,
  `added` varchar(40) NOT NULL,
  `expiration` int(11) NOT NULL,
  `permanent` int(1) NOT NULL DEFAULT 0,
  `hwid` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

--  Data of table smile.banlisthistory: ~0 rows (approximately)

--  Table smile.billing
DROP TABLE IF EXISTS `billing`;
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `sender` varchar(60) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.billing: ~0 rows (approximately)

--  Table smile.blacklistch
DROP TABLE IF EXISTS `blacklistch`;
CREATE TABLE IF NOT EXISTS `blacklistch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext DEFAULT NULL,
  `target` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `byPlayer` longtext DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.blacklistch: ~0 rows (approximately)

--  Table smile.blacklistmed
DROP TABLE IF EXISTS `blacklistmed`;
CREATE TABLE IF NOT EXISTS `blacklistmed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` longtext DEFAULT NULL,
  `target` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `byPlayer` longtext DEFAULT NULL,
  `reason` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.blacklistmed: ~0 rows (approximately)

--  Table smile.cardealer_vehicles
DROP TABLE IF EXISTS `cardealer_vehicles`;
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.cardealer_vehicles: ~0 rows (approximately)

--  Table smile.darkchat_messages
DROP TABLE IF EXISTS `darkchat_messages`;
CREATE TABLE IF NOT EXISTS `darkchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` text NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT '',
  `messages` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.darkchat_messages: ~0 rows (approximately)

--  Table smile.datastore
DROP TABLE IF EXISTS `datastore`;
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.datastore: ~9 rows (approximately)
REPLACE INTO `datastore` (`name`, `label`, `shared`) VALUES
	('property', 'Property', 0),
	('society_ambulance', 'EMS', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1),
	('user_ears', 'Ears', 0),
	('user_glasses', 'Glasses', 0),
	('user_helmet', 'Helmet', 0),
	('user_mask', 'Mask', 0);

--  Table smile.datastore_data
DROP TABLE IF EXISTS `datastore_data`;
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.datastore_data: ~5 rows (approximately)
REPLACE INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(1, 'society_police', NULL, '{}'),
	(2, 'society_ambulance', NULL, '{}'),
	(3, 'society_mechanic', NULL, '{}'),
	(4, 'society_taxi', NULL, '{}'),
	(5, 'property', NULL, '{}');

--  Table smile.fine_types
DROP TABLE IF EXISTS `fine_types`;
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.fine_types: ~52 rows (approximately)
REPLACE INTO `fine_types` (`id`, `label`, `amount`, `category`) VALUES
	(1, 'Misuse of a horn', 30, 0),
	(2, 'Illegally Crossing a continuous Line', 40, 0),
	(3, 'Driving on the wrong side of the road', 250, 0),
	(4, 'Illegal U-Turn', 250, 0),
	(5, 'Illegally Driving Off-road', 170, 0),
	(6, 'Refusing a Lawful Command', 30, 0),
	(7, 'Illegally Stopping a Vehicle', 150, 0),
	(8, 'Illegal Parking', 70, 0),
	(9, 'Failing to Yield to the right', 70, 0),
	(10, 'Failure to comply with Vehicle Information', 90, 0),
	(11, 'Failing to stop at a Stop Sign ', 105, 0),
	(12, 'Failing to stop at a Red Light', 130, 0),
	(13, 'Illegal Passing', 100, 0),
	(14, 'Driving an illegal Vehicle', 100, 0),
	(15, 'Driving without a License', 1500, 0),
	(16, 'Hit and Run', 800, 0),
	(17, 'Exceeding Speeds Over < 5 mph', 90, 0),
	(18, 'Exceeding Speeds Over 5-15 mph', 120, 0),
	(19, 'Exceeding Speeds Over 15-30 mph', 180, 0),
	(20, 'Exceeding Speeds Over > 30 mph', 300, 0),
	(21, 'Impeding traffic flow', 110, 1),
	(22, 'Public Intoxication', 90, 1),
	(23, 'Disorderly conduct', 90, 1),
	(24, 'Obstruction of Justice', 130, 1),
	(25, 'Insults towards Civilans', 75, 1),
	(26, 'Disrespecting of an LEO', 110, 1),
	(27, 'Verbal Threat towards a Civilan', 90, 1),
	(28, 'Verbal Threat towards an LEO', 150, 1),
	(29, 'Providing False Information', 250, 1),
	(30, 'Attempt of Corruption', 1500, 1),
	(31, 'Brandishing a weapon in city Limits', 120, 2),
	(32, 'Brandishing a Lethal Weapon in city Limits', 300, 2),
	(33, 'No Firearms License', 600, 2),
	(34, 'Possession of an Illegal Weapon', 700, 2),
	(35, 'Possession of Burglary Tools', 300, 2),
	(36, 'Grand Theft Auto', 1800, 2),
	(37, 'Intent to Sell/Distrube of an illegal Substance', 1500, 2),
	(38, 'Frabrication of an Illegal Substance', 1500, 2),
	(39, 'Possession of an Illegal Substance ', 650, 2),
	(40, 'Kidnapping of a Civilan', 1500, 2),
	(41, 'Kidnapping of an LEO', 2000, 2),
	(42, 'Robbery', 650, 2),
	(43, 'Armed Robbery of a Store', 650, 2),
	(44, 'Armed Robbery of a Bank', 1500, 2),
	(45, 'Assault on a Civilian', 2000, 3),
	(46, 'Assault of an LEO', 2500, 3),
	(47, 'Attempt of Murder of a Civilian', 3000, 3),
	(48, 'Attempt of Murder of an LEO', 5000, 3),
	(49, 'Murder of a Civilian', 10000, 3),
	(50, 'Murder of an LEO', 30000, 3),
	(51, 'Involuntary manslaughter', 1800, 3),
	(52, 'Fraud', 2000, 2);

--  Table smile.impound
DROP TABLE IF EXISTS `impound`;
CREATE TABLE IF NOT EXISTS `impound` (
  `officer` varchar(50) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `plate` varchar(50) DEFAULT NULL,
  `fine` int(11) DEFAULT 0,
  `reason` longtext DEFAULT NULL,
  `date` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.impound: ~0 rows (approximately)

--  Table smile.instagram_account
DROP TABLE IF EXISTS `instagram_account`;
CREATE TABLE IF NOT EXISTS `instagram_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `verify` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.instagram_account: ~0 rows (approximately)

--  Table smile.instagram_followers
DROP TABLE IF EXISTS `instagram_followers`;
CREATE TABLE IF NOT EXISTS `instagram_followers` (
  `username` varchar(50) NOT NULL,
  `followed` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.instagram_followers: ~0 rows (approximately)

--  Table smile.instagram_posts
DROP TABLE IF EXISTS `instagram_posts`;
CREATE TABLE IF NOT EXISTS `instagram_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `description` varchar(255) NOT NULL,
  `location` varchar(50) NOT NULL DEFAULT 'Los Santos',
  `filter` varchar(50) NOT NULL,
  `created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `likes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.instagram_posts: ~0 rows (approximately)

--  Table smile.instagram_stories
DROP TABLE IF EXISTS `instagram_stories`;
CREATE TABLE IF NOT EXISTS `instagram_stories` (
  `owner` varchar(50) NOT NULL,
  `data` text DEFAULT NULL,
  PRIMARY KEY (`owner`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=armscii8 COLLATE=armscii8_bin;

--  Data of table smile.instagram_stories: ~0 rows (approximately)

--  Table smile.insta_stories
DROP TABLE IF EXISTS `insta_stories`;
CREATE TABLE IF NOT EXISTS `insta_stories` (
  `username` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `filter` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.insta_stories: ~0 rows (approximately)

--  Table smile.items
DROP TABLE IF EXISTS `items`;
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.items: ~0 rows (approximately)

--  Table smile.jobs
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  `SecondaryJob` tinyint(1) NOT NULL DEFAULT 0,
  `inventory_pos` tinyint(4) DEFAULT NULL,
  `society_data` longtext DEFAULT NULL,
  `job_logo` longtext DEFAULT NULL,
  `job_slogan` longtext DEFAULT NULL,
  `job_type` int(11) NOT NULL DEFAULT 2,
  `level` int(11) DEFAULT 0,
  `point` int(11) DEFAULT 0,
  `jobPoint` int(11) DEFAULT 0,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.jobs: ~27 rows (approximately)
REPLACE INTO `jobs` (`name`, `label`, `whitelisted`, `SecondaryJob`, `inventory_pos`, `society_data`, `job_logo`, `job_slogan`, `job_type`, `level`, `point`, `jobPoint`) VALUES
	('admin', 'Chính Phủ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('ambulance', 'Ngành', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('daumo', 'Dầu Mỏ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('dj', 'DJ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('electric', 'Thợ Điện', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangctb', 'Cục Tình Báo', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangdv', 'Crew Devil', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangfr', 'Fruit King', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangma', 'Magic Gang', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangmxc', 'Gang MAFIA 4G', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangop', 'Crew One Piece', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangptg', 'Part Time Gang', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('gangunc', 'Unicorn ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('garbage', 'Đổ Rác', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('giaoga', 'Đồ Tể', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('langbam', 'Lang Băm', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('lumberjack', 'Thợ Mộc', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('maidam', 'Bán rau', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('mechanic', 'Cứu Hộ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('miner', 'Đào Mỏ', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('ngudan', 'Ngư dân', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('nogang', 'Băng Đảng', 0, 1, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('police', 'Police', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 2980, 2980),
	('prisoner', 'Prison', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('realestate', 'Builder', 1, 1, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('tailor', 'Thợ May', 0, 0, NULL, NULL, NULL, NULL, 2, 0, 0, 0),
	('unemployed', 'Thất Nghiệp', 0, 1, NULL, NULL, NULL, NULL, 2, 0, 0, 0);

--  Table smile.job_grades
DROP TABLE IF EXISTS `job_grades`;
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(255) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.job_grades: ~74 rows (approximately)
REPLACE INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Thất Nghiệp', 100, '{}', '{}'),
	(2, 'nogang', 0, 'nogang', 'Chưa Gia Nhập', 0, '{}', '{}'),
	(3, 'maidam', 0, 'maidam', 'Đứng đường', 0, '', ''),
	(4, 'ngudan', 0, 'ngudan', 'Thợ câu', 0, '', ''),
	(12, 'admin', 0, 'ADMIN', 'Chính Phủ', 0, '{}', '{}'),
	(18, 'miner', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(19, 'garbage', 0, 'employee', 'Công Nhân', 0, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"glasses_1":19,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"glasses_2":0,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"glasses_1":19,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"glasses_1":15,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"glasses_2":0,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"glasses_1":15,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}'),
	(20, 'electric', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(21, 'giaoga', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(22, 'daumo', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(23, 'lumberjack', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(24, 'tailor', 0, 'employee', 'Công Nhân', 0, '{}', '{}'),
	(25, 'realestate', 0, 'employee', 'Xây Nhà', 0, '{}', '{}'),
	(45, 'langbam', 0, 'employee', 'Thầy Lang', 0, '{}', '{}'),
	(51, 'dj', 0, 'employee', 'DJ', 0, '{}', '{}'),
	(74, 'police', 0, 'hocvien', 'Học Viên', 1500, '', ''),
	(75, 'police', 1, 'congan', 'Công An', 2500, '', ''),
	(76, 'police', 2, 'trungsi', 'Trung Sĩ', 3000, '', ''),
	(78, 'police', 3, 'swat', 'Swat', 3500, '', ''),
	(82, 'police', 4, 'lieutenant', 'Quản Lí', 4500, '{}', '{}'),
	(83, 'police', 5, 'phogiamdoc', 'Phó Giám Đốc', 5500, '{}', '{}'),
	(84, 'police', 6, 'boss', 'Giám Đốc', 7000, '{}', '{}'),
	(85, 'mechanic', 0, 'recrue', 'Học Viên', 2000, '{}', '{}'),
	(86, 'mechanic', 1, 'novice', 'Thợ Phụ', 3200, '{}', '{}'),
	(87, 'mechanic', 2, 'experimente', 'Thợ Chính', 4500, '{}', '{}'),
	(89, 'mechanic', 3, 'lieutenant', 'Quản Lí', 5500, '', ''),
	(90, 'mechanic', 4, 'phogiamdoc', 'Phó Giám Đốc', 6000, '{}', '{}'),
	(91, 'mechanic', 5, 'boss', 'Giám Đốc', 7000, '{}', '{}'),
	(94, 'ambulance', 0, 'ambulance', 'Học Viên', 2000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(95, 'ambulance', 1, 'doctor', 'Nhân Viên', 3200, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(96, 'ambulance', 2, 'quany', 'Quân Y', 4500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(97, 'ambulance', 3, 'lieutenant', 'Quản lí', 5500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(98, 'ambulance', 4, 'phogiamdoc', 'Phó Giám Đốc', 6000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(99, 'ambulance', 5, 'boss', 'Giám Đốc', 7000, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(141, 'gangma', 0, 'linh', 'Lính', 0, '', ''),
	(142, 'gangma', 1, 'danem', 'Đàn em', 0, '', ''),
	(143, 'gangma', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(144, 'gangma', 3, 'daica', 'Đại ca', 0, '', ''),
	(145, 'gangma', 4, 'boss', 'Ông trùm', 0, '', ''),
	(151, 'gangptg', 0, 'linh', 'Lính', 0, '', ''),
	(152, 'gangptg', 1, 'danem', 'Đàn em', 0, '', ''),
	(153, 'gangptg', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(154, 'gangptg', 3, 'daica', 'Đại ca', 0, '', ''),
	(155, 'gangptg', 4, 'boss', 'Ông trùm', 0, '', ''),
	(166, 'gangunc', 0, 'linh', 'Lính', 0, '', ''),
	(167, 'gangunc', 1, 'danem', 'Đàn em', 0, '', ''),
	(168, 'gangunc', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(169, 'gangunc', 3, 'daica', 'Đại ca', 0, '', ''),
	(170, 'gangunc', 4, 'boss', 'Ông trùm', 0, '', ''),
	(181, 'gangmxc', 0, 'linh', 'Lính', 0, '', ''),
	(182, 'gangmxc', 1, 'danem', 'Đàn em', 0, '', ''),
	(183, 'gangmxc', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(184, 'gangmxc', 3, 'daica', 'Đại ca', 0, '', ''),
	(185, 'gangmxc', 4, 'boss', 'Ông trùm', 0, '', ''),
	(206, 'gangctb', 0, 'linh', 'Lính', 0, '', ''),
	(207, 'gangctb', 1, 'danem', 'Đàn em', 0, '', ''),
	(208, 'gangctb', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(209, 'gangctb', 3, 'daica', 'Đại ca', 0, '', ''),
	(210, 'gangctb', 4, 'boss', 'Ông trùm', 0, '', ''),
	(211, 'gangfr', 0, 'linh', 'Lính', 0, '', ''),
	(212, 'gangfr', 1, 'danem', 'Đàn em', 0, '', ''),
	(213, 'gangfr', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(214, 'gangfr', 3, 'daica', 'Đại ca', 0, '', ''),
	(215, 'gangfr', 4, 'boss', 'Ông trùm', 0, '', ''),
	(216, 'gangdv', 0, 'linh', 'Lính', 0, '', ''),
	(217, 'gangdv', 1, 'danem', 'Đàn em', 0, '', ''),
	(218, 'gangdv', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(219, 'gangdv', 3, 'daica', 'Đại ca', 0, '', ''),
	(220, 'gangdv', 4, 'boss', 'Ông trùm', 0, '', ''),
	(221, 'gangop', 0, 'linh', 'Lính', 0, '', ''),
	(222, 'gangop', 1, 'danem', 'Đàn em', 0, '', ''),
	(223, 'gangop', 2, 'dananh', 'Đàn anh', 0, '', ''),
	(224, 'gangop', 3, 'daica', 'Đại ca', 0, '', ''),
	(225, 'gangop', 4, 'boss', 'Ông trùm', 0, '', '');

--  Table smile.licenses
DROP TABLE IF EXISTS `licenses`;
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.licenses: ~7 rows (approximately)
REPLACE INTO `licenses` (`type`, `label`) VALUES
	('boat', 'Boat License'),
	('dmv', 'Driving Permit'),
	('drive', 'Drivers License'),
	('drive_bike', 'Motorcycle License'),
	('drive_truck', 'Commercial Drivers License'),
	('weapon', 'Weapon License'),
	('weed_processing', 'Weed Processing License');

--  Table smile.management_outfits
DROP TABLE IF EXISTS `management_outfits`;
CREATE TABLE IF NOT EXISTS `management_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `minrank` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT 'Cool Outfit',
  `gender` varchar(50) NOT NULL DEFAULT 'male',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.management_outfits: ~0 rows (approximately)

--  Table smile.market
DROP TABLE IF EXISTS `market`;
CREATE TABLE IF NOT EXISTS `market` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `amount` int(11) DEFAULT 1,
  `weight` varchar(10) DEFAULT '0',
  `price` varchar(10) DEFAULT NULL,
  `owner` varchar(46) DEFAULT NULL,
  `identifier` varchar(46) DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.market: ~0 rows (approximately)

--  Table smile.multicharacter_slots
DROP TABLE IF EXISTS `multicharacter_slots`;
CREATE TABLE IF NOT EXISTS `multicharacter_slots` (
  `identifier` varchar(46) NOT NULL,
  `slots` int(11) NOT NULL,
  PRIMARY KEY (`identifier`) USING BTREE,
  KEY `slots` (`slots`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.multicharacter_slots: ~0 rows (approximately)

--  Table smile.nhanqua_online
DROP TABLE IF EXISTS `nhanqua_online`;
CREATE TABLE IF NOT EXISTS `nhanqua_online` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `online` int(50) DEFAULT 0,
  `day1` varchar(150) NOT NULL,
  `day2` varchar(150) NOT NULL,
  `day3` varchar(150) NOT NULL,
  `day4` varchar(150) NOT NULL,
  `day5` varchar(150) NOT NULL,
  `day6` varchar(150) NOT NULL,
  `day7` varchar(150) NOT NULL,
  `day8` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.nhanqua_online: ~2 rows (approximately)
REPLACE INTO `nhanqua_online` (`identifier`, `online`, `day1`, `day2`, `day3`, `day4`, `day5`, `day6`, `day7`, `day8`) VALUES
	('steam:11000013e621c8b', 20, '', '', '', '', '', '', '', ''),
	('steam:1100001147e8c1c', 30, '', '', '', '', '', '', '', '');

--  Table smile.occupation
DROP TABLE IF EXISTS `occupation`;
CREATE TABLE IF NOT EXISTS `occupation` (
  `name` char(50) DEFAULT NULL,
  `gang_name` char(50) DEFAULT NULL,
  `lastcapture` int(11) NOT NULL DEFAULT 0,
  `nameCD` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--  Data of table smile.occupation: ~0 rows (approximately)

--  Table smile.occupation_point
DROP TABLE IF EXISTS `occupation_point`;
CREATE TABLE IF NOT EXISTS `occupation_point` (
  `gang_name` char(50) DEFAULT NULL,
  `point` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--  Data of table smile.occupation_point: ~6 rows (approximately)
REPLACE INTO `occupation_point` (`gang_name`, `point`) VALUES
	('gangptg', 0),
	('gangmxc', 0),
	('gangfr', 0),
	('gangma', 0),
	('gangunc', 0),
	('gangctb', 0);

--  Table smile.onduty
DROP TABLE IF EXISTS `onduty`;
CREATE TABLE IF NOT EXISTS `onduty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` longtext DEFAULT NULL,
  `job` longtext DEFAULT NULL,
  `steam` longtext DEFAULT NULL,
  `time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.onduty: ~4 rows (approximately)
REPLACE INTO `onduty` (`id`, `name`, `job`, `steam`, `time`) VALUES
	(1, 'Bin', 'mechanic', 'steam:1100001147e8c1c', 5),
	(2, 'Bun', 'mechanic', 'steam:11000013e621c8b', 5),
	(3, 'Bun', 'ambulance', 'steam:11000013e621c8b', 1),
	(4, 'Bin', 'ambulance', 'steam:1100001147e8c1c', 8);

--  Table smile.outfit
DROP TABLE IF EXISTS `outfit`;
CREATE TABLE IF NOT EXISTS `outfit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `steam` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_vietnamese_ci;

--  Data of table smile.outfit: ~0 rows (approximately)

--  Table smile.owned_vehicles
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `owner` varchar(46) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(4) NOT NULL DEFAULT 0,
  `parking` varchar(60) DEFAULT NULL,
  `pound` varchar(60) DEFAULT NULL,
  `glovebox` longtext DEFAULT NULL,
  `trunk` longtext DEFAULT NULL,
  `label` longtext DEFAULT NULL,
  `soluong` int(11) NOT NULL DEFAULT 2,
  `impound` int(11) NOT NULL DEFAULT 0,
  `mileage` float DEFAULT 0,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.owned_vehicles: ~0 rows (approximately)
REPLACE INTO `owned_vehicles` (`owner`, `model`, `plate`, `vehicle`, `type`, `job`, `stored`, `parking`, `pound`, `glovebox`, `trunk`, `label`, `soluong`, `impound`, `mileage`) VALUES
	('11000013e621c8b', 'SANCHEZ02', 'BDD 526', '{"modHood":-1,"modDial":-1,"fuelLevel":63.1,"modRightFender":-1,"modOrnaments":-1,"modHydrolic":-1,"modArchCover":-1,"modTrimA":-1,"modAerials":-1,"modDoorR":-1,"color1":2,"modFender":-1,"modEngineBlock":-1,"tankHealth":1000.0,"neonEnabled":[false,false,false,false],"doorsBroken":{"0":false,"1":false},"modSideSkirt":-1,"modSuspension":-1,"modPlateHolder":-1,"windowTint":-1,"dirtLevel":11.2,"modSpeakers":-1,"tyreBurst":{"4":false,"0":false},"modExhaust":-1,"modAPlate":-1,"tyreSmokeColor":[255,255,255],"modFrontBumper":-1,"model":-1453280962,"interiorColor":0,"xenonColor":255,"modStruts":-1,"modHorns":-1,"modShifterLeavers":-1,"neonColor":[255,0,255],"modTrimB":-1,"modTurbo":false,"pearlescentColor":2,"modRearBumper":-1,"extras":[],"modArmor":-1,"modSeats":-1,"modGrille":-1,"plateIndex":4,"modTrunk":-1,"modFrontWheels":-1,"modAirFilter":-1,"bodyHealth":1000.0,"modLightbar":-1,"engineHealth":1000.0,"dashboardColor":0,"modBrakes":-1,"wheels":6,"modSteeringWheel":-1,"modXenon":false,"modDoorSpeaker":-1,"modTransmission":-1,"modLivery":-1,"modTank":-1,"modBackWheels":-1,"modVanityPlate":-1,"wheelColor":0,"modEngine":-1,"color2":2,"modFrame":-1,"modSmokeEnabled":1,"windowsBroken":{"4":true,"5":true,"2":true,"3":true,"0":true,"1":true,"6":true,"7":true},"modDashboard":-1,"plate":"BDD 526","modRoof":-1,"modSpoilers":-1}', 'car', NULL, 0, NULL, NULL, NULL, NULL, NULL, 2, 0, 0);

--  Table smile.ox_doorlock
DROP TABLE IF EXISTS `ox_doorlock`;
CREATE TABLE IF NOT EXISTS `ox_doorlock` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.ox_doorlock: ~0 rows (approximately)

--  Table smile.ox_inventory
DROP TABLE IF EXISTS `ox_inventory`;
CREATE TABLE IF NOT EXISTS `ox_inventory` (
  `owner` varchar(46) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `data` longtext DEFAULT NULL,
  `lastupdated` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  UNIQUE KEY `owner` (`owner`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.ox_inventory: ~0 rows (approximately)
REPLACE INTO `ox_inventory` (`owner`, `name`, `data`, `lastupdated`) VALUES
	('', 'police1', NULL, '2024-01-28 15:05:46');

--  Table smile.phone_accounts
DROP TABLE IF EXISTS `phone_accounts`;
CREATE TABLE IF NOT EXISTS `phone_accounts` (
  `app` varchar(50) NOT NULL,
  `id` varchar(80) NOT NULL,
  `name` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `birthdate` varchar(50) NOT NULL,
  `gender` varchar(50) NOT NULL,
  `interested` text NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_accounts: ~0 rows (approximately)

--  Table smile.phone_alertjobs
DROP TABLE IF EXISTS `phone_alertjobs`;
CREATE TABLE IF NOT EXISTS `phone_alertjobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(255) NOT NULL,
  `alerts` longtext DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `job` (`job`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_alertjobs: ~0 rows (approximately)

--  Table smile.phone_chatrooms
DROP TABLE IF EXISTS `phone_chatrooms`;
CREATE TABLE IF NOT EXISTS `phone_chatrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_code` varchar(10) NOT NULL,
  `room_name` varchar(15) NOT NULL,
  `room_owner_id` varchar(50) DEFAULT NULL,
  `room_owner_name` varchar(60) DEFAULT NULL,
  `room_members` text DEFAULT NULL,
  `room_pin` varchar(50) DEFAULT NULL,
  `unpaid_balance` decimal(10,2) DEFAULT 0.00,
  `is_masked` tinyint(1) DEFAULT 0,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_code` (`room_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_chatrooms: ~0 rows (approximately)

--  Table smile.phone_chatroom_messages
DROP TABLE IF EXISTS `phone_chatroom_messages`;
CREATE TABLE IF NOT EXISTS `phone_chatroom_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` int(10) unsigned DEFAULT NULL,
  `member_id` varchar(50) DEFAULT NULL,
  `member_name` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `created` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_chatroom_messages: ~0 rows (approximately)

--  Table smile.phone_chats
DROP TABLE IF EXISTS `phone_chats`;
CREATE TABLE IF NOT EXISTS `phone_chats` (
  `app` varchar(50) NOT NULL,
  `author` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_chats: ~0 rows (approximately)

--  Table smile.phone_invoices
DROP TABLE IF EXISTS `phone_invoices`;
CREATE TABLE IF NOT EXISTS `phone_invoices` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `society` tinytext DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--  Data of table smile.phone_invoices: ~0 rows (approximately)

--  Table smile.phone_messages
DROP TABLE IF EXISTS `phone_messages`;
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) DEFAULT NULL,
  `number` varchar(50) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `messages` text NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `read` int(11) DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_messages: ~0 rows (approximately)

--  Table smile.phone_news
DROP TABLE IF EXISTS `phone_news`;
CREATE TABLE IF NOT EXISTS `phone_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.phone_news: ~0 rows (approximately)

--  Table smile.phone_notifies
DROP TABLE IF EXISTS `phone_notifies`;
CREATE TABLE IF NOT EXISTS `phone_notifies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `msg_content` text NOT NULL,
  `msg_head` varchar(50) NOT NULL DEFAULT '',
  `app_name` text NOT NULL,
  `msg_time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2472 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.phone_notifies: ~0 rows (approximately)

--  Table smile.playerskins
DROP TABLE IF EXISTS `playerskins`;
CREATE TABLE IF NOT EXISTS `playerskins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(255) NOT NULL,
  `model` varchar(255) NOT NULL,
  `skin` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--  Data of table smile.playerskins: ~0 rows (approximately)

--  Table smile.player_contacts
DROP TABLE IF EXISTS `player_contacts`;
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` varchar(50) DEFAULT NULL,
  `iban` varchar(50) NOT NULL DEFAULT '0',
  `display` varchar(50) DEFAULT NULL,
  `note` text NOT NULL,
  `pp` text NOT NULL,
  `isBlocked` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_contacts: ~112 rows (approximately)
REPLACE INTO `player_contacts` (`id`, `identifier`, `name`, `number`, `iban`, `display`, `note`, `pp`, `isBlocked`) VALUES
	(38, '553237203', 'GỖ', '553310299', '0', NULL, '', './img/app_details/default.png', NULL),
	(39, '9999', 'Bạch Long | Momo', '03191951', '0', NULL, '', './img/app_details/default.png', NULL),
	(41, '03217219', 'bloom', '650099', '0', NULL, '', './img/app_details/default.png', NULL),
	(42, '03342791', 'quynh', '9999', '0', NULL, '', './img/app_details/default.png', NULL),
	(43, '9999', 'CA hung`', '03342791', '0', NULL, '', './img/app_details/default.png', NULL),
	(44, '9999', 'Lee Vui', '03358128', '0', NULL, '', './img/app_details/default.png', NULL),
	(45, '03356128', 'chị quỳnh', '9999', '0', NULL, 'trum bu da', './img/app_details/default.png', NULL),
	(46, '03509579', 'đáng iu số 1', '650099', '0', NULL, '', './img/app_details/default.png', NULL),
	(48, '9999', 'Bạch Long | Kito', '553279570', '0', NULL, '', './img/app_details/default.png', NULL),
	(49, '9999', 'SIMTE', '03503760', '0', NULL, '', './img/app_details/default.png', NULL),
	(50, '1', ' bo ngu', '03115586', '0', NULL, '', '', NULL),
	(51, '9999', '03', '03384645', '0', NULL, '', './img/app_details/default.png', NULL),
	(52, '553803872', 'Ngừi iu\n', '03960013', '0', NULL, '', './img/app_details/default.png', NULL),
	(53, '03515880', 'Tommy', '039774293', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1160486196145823824/screenshot.jpgNULLex=6534d5fd&is=652260fd&hm=ecb57b7f1abd4be5389c78fcb364c422d1a73d9fc0a31a118711b4d2758e71cf&', NULL),
	(54, '03377233', ' Eddie Nguyen', '03186690', '0', NULL, '', '', NULL),
	(55, '03186690', ' Tiay', '03377233', '0', NULL, '', '', NULL),
	(56, '03367321', 'xanh xanh', '03834303', '0', NULL, '', './img/app_details/default.png', NULL),
	(57, '03834303', 'Duc TRoc', '03367321', '0', NULL, '', './img/app_details/default.png', NULL),
	(58, '03367321', 'Momo', '03191951', '0', NULL, '', './img/app_details/default.png', NULL),
	(59, '03415615', ' Sang', '03971050', '0', NULL, '', '', NULL),
	(60, '03971050', 'Thuấn Nè', '03415615', '0', NULL, '', './img/app_details/default.png', NULL),
	(61, '03395390', 'Cau ba', '03395336', '0', NULL, '', './img/app_details/default.png', NULL),
	(62, '1', 'fen coder', '03114113', '0', NULL, '', './img/app_details/default.png', NULL),
	(63, '03162549', 'ml bin', '03319497', '0', NULL, '03319497', './img/app_details/default.png', NULL),
	(64, '03319497', 'kid', '03162549', '0', NULL, '03162549', './img/app_details/default.png', NULL),
	(65, '03632282', 'Hau', '03554731', '0', NULL, '', './img/app_details/default.png', NULL),
	(66, '03497845', 'bán tiền đen', '03769467', '0', NULL, '', './img/app_details/default.png', NULL),
	(67, '03968062', 'Thong', '03497845', '0', NULL, '', './img/app_details/default.png', NULL),
	(68, '03497845', 'cứu hộ bán tiền đen', '03968062', '0', NULL, 'nhân viên nhà nước', './img/app_details/default.png', NULL),
	(69, '03497845', 'quang', '03206106', '0', NULL, '', './img/app_details/default.png', NULL),
	(70, '03195621', 'BI', '03167509', '0', NULL, '', './img/app_details/default.png', NULL),
	(71, '03162549', 'quan', '03612367', '0', NULL, '', './img/app_details/default.png', NULL),
	(72, '03319497', 'ahip', '03612367', '0', NULL, 'hip', './img/app_details/default.png', NULL),
	(73, '03720955', 'ban than ', '03516494', '0', NULL, '', './img/app_details/default.png', NULL),
	(74, '03516494', 'ke huy  diet tuoi tho', '03720955', '0', NULL, '', './img/app_details/default.png', NULL),
	(75, '03206106', 'thong', '03497845', '0', NULL, '', './img/app_details/default.png', NULL),
	(76, '03656850', '7 ga', '03994601', '0', NULL, '', './img/app_details/default.png', NULL),
	(77, '03656850', 'dung', '03330162', '0', NULL, '', './img/app_details/default.png', NULL),
	(78, '03994601', 'Dung', '03330162', '0', NULL, '', './img/app_details/default.png', NULL),
	(79, '03330162', 'Phu', '03656850', '0', NULL, '', './img/app_details/default.png', NULL),
	(80, '03994601', 'Phú', '03656850', '0', NULL, '', './img/app_details/default.png', NULL),
	(81, '03330162', 'Tu', '03994601', '0', NULL, '', './img/app_details/default.png', NULL),
	(82, '03463040', 'THONG PTG', '03497845', '0', NULL, '', './img/app_details/default.png', NULL),
	(83, '03497845', 'Nam', '03463040', '0', NULL, '', './img/app_details/default.png', NULL),
	(84, '03463040', 'BAY GA', '03994601', '0', NULL, '', './img/app_details/default.png', NULL),
	(85, '03585090', 'ThanhTienBroo', '03195621', '0', NULL, '', './img/app_details/default.png', NULL),
	(86, '03195621', 'huy', '03585090', '0', NULL, '', './img/app_details/default.png', NULL),
	(87, '03994601', 'Hius', '03835807', '0', NULL, '', './img/app_details/default.png', NULL),
	(88, '03656850', 'hiu', '0383587', '0', NULL, '', './img/app_details/default.png', NULL),
	(89, '03330162', 'Hieu', '03835807', '0', NULL, '', './img/app_details/default.png', NULL),
	(90, '03564570', 'Qúi', '03329173', '0', NULL, '', './img/app_details/default.png', NULL),
	(91, '03549483', 'tien', '03195621', '0', NULL, '', './img/app_details/default.png', NULL),
	(92, '03569764', 'a binh ga', '03296007', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1173923778355535922/screenshot.jpgNULLex=6565b8b7&is=655343b7&hm=23a3ff88baa9b26d33bc7a9fa96aaca90d637ee5987fc1aac41a6fd0653832ea&', NULL),
	(93, '03516494', 'dung hai can', '03330162', '0', NULL, '', './img/app_details/default.png', NULL),
	(94, '03330162', 'NguoiHuongNoi\n', '03516494', '0', NULL, '', './img/app_details/default.png', NULL),
	(95, '03921342', 'nguyen ha', '03444074', '0', NULL, '\n', './img/app_details/default.png', NULL),
	(96, '03921342', 'billy', '03171560', '0', NULL, '', './img/app_details/default.png', NULL),
	(97, '03171560', 'sarah', '03921342', '0', NULL, '', './img/app_details/default.png', NULL),
	(98, '03835807', 'Tu', '03994601', '0', NULL, '', './img/app_details/default.png', NULL),
	(99, '03497845', 'Chí', '03668471', '0', NULL, '', './img/app_details/default.png', NULL),
	(100, '03544873', 'Cubin', '03459104', '0', NULL, '', './img/app_details/default.png', NULL),
	(101, '03956361', 'Duy bò', '03778552', '0', NULL, '', './img/app_details/default.png', NULL),
	(102, '03778552', 'PhatHanSome', '03956361', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1174731420678242444/screenshot.jpgNULLex=6568a8e4&is=655633e4&hm=5927c92f09d7bf3eb0e39357cddd75c042d4bbb39b94de6bb4f7d9988dff2661&', NULL),
	(103, '03956361', 'Tí-PGT', '03544873', '0', NULL, '', './img/app_details/default.png', NULL),
	(104, '03587510', 'bo gia mxc', '03463040', '0', NULL, '', './img/app_details/default.png', NULL),
	(105, '03330162', 'Khanh', '03237466', '0', NULL, '', './img/app_details/default.png', NULL),
	(106, '03994601', 'khanh', '03237466', '0', NULL, '', './img/app_details/default.png', NULL),
	(107, '03974413', 'Khánh', '03237466', '0', NULL, '', './img/app_details/default.png', NULL),
	(108, '03207609', 'tuan', '03429156\n', '0', NULL, '', './img/app_details/default.png', NULL),
	(109, '03892683', 'Long mat L', '03429156', '0', NULL, '', './img/app_details/default.png', NULL),
	(110, '03594314', 'jun mua ga', '03289931', '0', NULL, '', './img/app_details/default.png', NULL),
	(111, '03289931', 'phu quy', '03594314', '0', NULL, '', './img/app_details/default.png', NULL),
	(112, '03544873', 'Bố Già MeXiCo', '03463040', '0', NULL, '', './img/app_details/default.png', NULL),
	(113, '03594314', 'bogia', '03463040', '0', NULL, '', './img/app_details/default.png', NULL),
	(114, '03860156', 'Teddy', '03337517', '0', NULL, '', './img/app_details/default.png', NULL),
	(115, '03830199', 'mua cần', '03591702', '0', NULL, '', './img/app_details/default.png', NULL),
	(116, '03367833', 'thay giao ti hon', '03640399', '0', NULL, '', './img/app_details/default.png', NULL),
	(117, '03640399', 'Bin hue', '03367833', '0', NULL, '', './img/app_details/default.png', NULL),
	(118, '03367833', 'qlca', '03226606', '0', NULL, '', './img/app_details/default.png', NULL),
	(119, '03367833', ' ca 6 luu dan\n', '03342024', '0', NULL, '', './img/app_details/default.png', NULL),
	(120, '03162549', 'moi', '03394639', '0', NULL, '', './img/app_details/default.png', NULL),
	(121, '03394639', 'A Trường', '03987323', '0', NULL, '', './img/app_details/default.png', NULL),
	(122, '03987323', 'An Hen', '03394639', '0', NULL, '', './img/app_details/default.png', NULL),
	(123, '03637228', 'HOANG khai', '03465126', '0', NULL, '', './img/app_details/default.png', NULL),
	(124, '03465126', 'NGOC', '03637228', '0', NULL, '', './img/app_details/default.png', NULL),
	(125, '03167509', 'HELA ', '03248923', '0', NULL, '', './img/app_details/default.png', NULL),
	(127, '03735277', 'bin hue\n', '03367833', '0', NULL, '', './img/app_details/default.png', NULL),
	(128, '03367833', '4 cut', '03735277', '0', NULL, '', './img/app_details/default.png', NULL),
	(129, '03654318', 'Chú Dưa', '03738227', '0', NULL, 'Chú Synn Chú Dưa', './img/app_details/default.png', NULL),
	(130, '03465126', 'bin', '03367833', '0', NULL, '', './img/app_details/default.png', NULL),
	(131, '03979066', 'thuong', '1', '0', NULL, '090909\n', './img/app_details/default.png', NULL),
	(132, '03167509', 'Bao Hat ', '03309539', '0', NULL, '', './img/app_details/default.png', NULL),
	(133, '03195621', 'anh bao PTG', '03309539', '0', NULL, '', './img/app_details/default.png', NULL),
	(134, '03167509', 'Milim', '03208317', '0', NULL, '', './img/app_details/default.png', NULL),
	(135, '03195621', 'milim PTG', '03208317', '0', NULL, '', './img/app_details/default.png', NULL),
	(136, '03606745', 'thinhj ', '03748021', '0', NULL, '', './img/app_details/default.png', NULL),
	(137, '03748021', 'lighblue', '03606745', '0', NULL, '', './img/app_details/default.png', NULL),
	(138, '03462037', 'Susuhjhj', '03784375', '0', NULL, 'Goi cai deo gi', 'https://media.discordapp.net/attachments/1156642595494178916/1189615328108486786/screenshot.jpgNULLex=659ece9c&is=658c599c&hm=cb5ab0aae46551dfe4abc05496f4e3d87194db11e533bb645c5ce9cfe0659996&', NULL),
	(139, '03784375', 'Bean', '03462037', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1189615603288387635/screenshot.jpgNULLex=659ecedd&is=658c59dd&hm=b6729e57ae011e9ce389b92f1935cc9459d2d8f7d6e85ee2d738e2306adf85f6&', NULL),
	(140, '03220992', 'moi', '03473560', '0', NULL, '', './img/app_details/default.png', NULL),
	(141, '03784375', 'Bronci', '03265106', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1189759577827319848/screenshot.jpgNULLex=659f54f4&is=658cdff4&hm=802124906bf97812b2c8182d28310d8f37ce761066cbcd2c80e804edf121af88&', NULL),
	(142, '03462037', 'Bronci', '03265106', '0', NULL, 'Bo ron xi hoi', 'https://media.discordapp.net/attachments/1156642595494178916/1189759601411891280/screenshot.jpgNULLex=659f54f9&is=658cdff9&hm=f07d231ab212422250b26d4f0a9e0f1980c227b4a0e680a5a2023d7b8bca992c&', NULL),
	(143, '03265106', 'Bean', '03462037', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1189759877791358996/screenshot.jpgNULLex=659f553b&is=658ce03b&hm=758be876a44122dc5b718352464ee0e135136cb69b972ab840f6f62e413dff68&', NULL),
	(144, '03265106', 'Su Em Iu <3', '03784375', '0', NULL, '', 'https://media.discordapp.net/attachments/1156642595494178916/1189760230003855441/screenshot.jpgNULLex=659f558f&is=658ce08f&hm=e2e75f001b23b2d04c98a51c9ecdd0591ef6cd88da69cc97de8baec169313e4c&', NULL),
	(145, '03114113', 'Sep 9 ', '03827108', '0', NULL, '', './img/app_details/default.png', NULL),
	(146, '03473365', 'a9 bịp', '03827108', '0', NULL, 'asd', './img/app_details/default.png', NULL),
	(147, '03827108', 'chi chay', '03114113\n', '0', NULL, '', './img/app_details/default.png', NULL),
	(148, '03827108', '5 mu`\n', '03473365', '0', NULL, '', './img/app_details/default.png', NULL),
	(149, '03220992', 'ban hop kim ', '03552275', '0', NULL, '', './img/app_details/default.png', NULL),
	(150, '03259689', ' long', '03606745', '0', NULL, '', '', NULL),
	(151, '03514788', 'cc', '03366726', '0', NULL, '', './img/app_details/default.png', NULL),
	(152, '03695437', ' hong bt ', '03220992', '0', NULL, '', '', NULL);

--  Table smile.player_gallery
DROP TABLE IF EXISTS `player_gallery`;
CREATE TABLE IF NOT EXISTS `player_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `resim` text NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_gallery: ~0 rows (approximately)

--  Table smile.player_mails
DROP TABLE IF EXISTS `player_mails`;
CREATE TABLE IF NOT EXISTS `player_mails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `sender` varchar(50) DEFAULT NULL,
  `subject` varchar(50) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `read` tinyint(4) DEFAULT NULL,
  `mailid` int(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp(),
  `button` text DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `identifier` (`identifier`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_mails: ~0 rows (approximately)

--  Table smile.player_notes
DROP TABLE IF EXISTS `player_notes`;
CREATE TABLE IF NOT EXISTS `player_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` text NOT NULL,
  `baslik` text NOT NULL,
  `aciklama` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_notes: ~2 rows (approximately)
REPLACE INTO `player_notes` (`id`, `identifier`, `baslik`, `aciklama`) VALUES
	(5, '11000011691ce4f', 'Vay Tien ', 'WAP -600K\n'),
	(6, '1100001588a38bb', 'awdwa', 'Description...');

--  Table smile.player_outfits
DROP TABLE IF EXISTS `player_outfits`;
CREATE TABLE IF NOT EXISTS `player_outfits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `outfitname` varchar(50) NOT NULL DEFAULT '0',
  `model` varchar(50) DEFAULT NULL,
  `props` varchar(1000) DEFAULT NULL,
  `components` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `citizenid_outfitname_model` (`citizenid`,`outfitname`,`model`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_outfits: ~0 rows (approximately)

--  Table smile.player_outfit_codes
DROP TABLE IF EXISTS `player_outfit_codes`;
CREATE TABLE IF NOT EXISTS `player_outfit_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outfitid` int(11) NOT NULL,
  `code` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_player_outfit_codes_player_outfits` (`outfitid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.player_outfit_codes: ~0 rows (approximately)

--  Table smile.poker_stats
DROP TABLE IF EXISTS `poker_stats`;
CREATE TABLE IF NOT EXISTS `poker_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `winner_name` varchar(255) DEFAULT NULL,
  `winner_id` varchar(255) DEFAULT NULL,
  `pot` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.poker_stats: ~0 rows (approximately)

--  Table smile.pug_paintball
DROP TABLE IF EXISTS `pug_paintball`;
CREATE TABLE IF NOT EXISTS `pug_paintball` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `gameitems` text DEFAULT NULL,
  `kills` int(11) DEFAULT NULL,
  `deaths` int(11) DEFAULT NULL,
  `wins` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.pug_paintball: ~0 rows (approximately)

--  Table smile.rented_vehicles
DROP TABLE IF EXISTS `rented_vehicles`;
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.rented_vehicles: ~0 rows (approximately)

--  Table smile.society_moneywash
DROP TABLE IF EXISTS `society_moneywash`;
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) DEFAULT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.society_moneywash: ~0 rows (approximately)

--  Table smile.tiktok_users
DROP TABLE IF EXISTS `tiktok_users`;
CREATE TABLE IF NOT EXISTS `tiktok_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL DEFAULT '0',
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `bio` text NOT NULL,
  `birthday` varchar(50) NOT NULL DEFAULT '0',
  `videos` text,
  `followers` text,
  `following` text,
  `liked` text,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.tiktok_users: ~0 rows (approximately)

--  Table smile.tiktok_videos
DROP TABLE IF EXISTS `tiktok_videos`;
CREATE TABLE IF NOT EXISTS `tiktok_videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userID` int(11) DEFAULT NULL,
  `created` varchar(50) NOT NULL DEFAULT '00:00:00',
  `data` text DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.tiktok_videos: ~0 rows (approximately)

--  Table smile.tinder_accounts
DROP TABLE IF EXISTS `tinder_accounts`;
CREATE TABLE IF NOT EXISTS `tinder_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL DEFAULT '0',
  `pp` text NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `gender` varchar(50) NOT NULL,
  `targetGender` varchar(50) NOT NULL DEFAULT '0',
  `hobbies` varchar(50) NOT NULL DEFAULT '0',
  `age` varchar(50) NOT NULL DEFAULT '0',
  `description` varchar(50) NOT NULL DEFAULT '0',
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.tinder_accounts: ~0 rows (approximately)

--  Table smile.tinder_likes
DROP TABLE IF EXISTS `tinder_likes`;
CREATE TABLE IF NOT EXISTS `tinder_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(1024) NOT NULL,
  `likeds` mediumtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.tinder_likes: ~0 rows (approximately)

--  Table smile.tinder_messages
DROP TABLE IF EXISTS `tinder_messages`;
CREATE TABLE IF NOT EXISTS `tinder_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` longtext NOT NULL,
  `messages` longtext,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.tinder_messages: ~0 rows (approximately)

--  Table smile.trucker_available_contracts
DROP TABLE IF EXISTS `trucker_available_contracts`;
CREATE TABLE IF NOT EXISTS `trucker_available_contracts` (
  `contract_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `contract_type` tinyint(3) NOT NULL DEFAULT 0,
  `contract_name` varchar(50) NOT NULL DEFAULT '',
  `coords_index` smallint(6) unsigned NOT NULL DEFAULT 0,
  `price_per_km` int(10) unsigned NOT NULL DEFAULT 0,
  `cargo_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fragile` tinyint(3) NOT NULL DEFAULT 0,
  `valuable` tinyint(3) NOT NULL DEFAULT 0,
  `fast` tinyint(3) NOT NULL DEFAULT 0,
  `truck` varchar(50) DEFAULT NULL,
  `trailer` varchar(50) NOT NULL,
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=255852 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.trucker_available_contracts: ~59 rows (approximately)
REPLACE INTO `trucker_available_contracts` (`contract_id`, `contract_type`, `contract_name`, `coords_index`, `price_per_km`, `cargo_type`, `fragile`, `valuable`, `fast`, `truck`, `trailer`) VALUES
	(255792, 1, 'Vận chuyển gỗ tinh chế', 98, 2939, 0, 0, 0, 0, NULL, 'docktrailer'),
	(255793, 0, 'Vận chuyển sản phẩm nhập khẩu', 176, 1553, 0, 0, 1, 0, 'phantom', 'docktrailer'),
	(255794, 1, 'Vận chuyển vật liệu xây dựng', 40, 2870, 0, 0, 0, 0, NULL, 'trailers'),
	(255795, 0, 'Vận chuyển chất độc', 52, 1540, 5, 0, 0, 0, 'phantom', 'liquide1'),
	(255796, 1, 'Stork', 99, 2871, 0, 1, 1, 0, NULL, 'tr4'),
	(255797, 0, 'Boat trailer', 15, 1770, 0, 1, 1, 0, 'phantom', 'trailers4'),
	(255798, 1, 'Vận chuyển vũ khí', 89, 2675, 0, 0, 1, 0, NULL, 'docktrailer'),
	(255799, 0, 'Vận chuyển thuốc trừ sâu', 60, 1804, 5, 0, 0, 0, 'phantom', 'liquide1'),
	(255800, 1, 'Vận chuyển thịt bò tươi sống', 82, 2334, 0, 0, 0, 0, NULL, 'trailers2'),
	(255801, 0, 'Vận chuyển thủy tinh', 180, 1419, 0, 1, 0, 0, 'phantom', 'docktrailer'),
	(255802, 1, 'Trailer empty', 189, 2807, 0, 0, 0, 0, NULL, 'armytrailer'),
	(255803, 0, 'Vận chuyển khoai tây', 102, 1621, 0, 0, 0, 0, 'phantom', 'trailers2'),
	(255804, 1, 'Stork', 58, 2775, 0, 1, 1, 0, NULL, 'tr4'),
	(255805, 0, 'Vận chuyển thịt đông lạnh', 118, 1661, 0, 0, 0, 0, 'phantom', 'trailers2'),
	(255806, 1, 'Vận chuyển thịt bò tươi sống', 182, 2925, 0, 0, 0, 0, NULL, 'trailers2'),
	(255807, 0, 'Vận chuyển bàn ghế', 52, 1946, 0, 0, 0, 0, 'phantom', 'docktrailer'),
	(255808, 1, 'Vận chuyển vật liệu nổ', 128, 2462, 1, 1, 0, 1, NULL, 'trailers4'),
	(255809, 0, 'Vận chuyển thịt đông lạnh', 145, 1725, 0, 0, 0, 0, 'phantom', 'trailers2'),
	(255810, 1, 'Vận chuyển Lavie đóng chai', 185, 2315, 0, 0, 0, 0, NULL, 'trailers2'),
	(255811, 0, 'Vận chuyển vật tư cho sự kiện', 133, 1855, 0, 1, 1, 0, 'phantom', 'tvtrailer'),
	(255812, 1, 'Boat trailer', 8, 2865, 0, 1, 1, 0, NULL, 'trailers4'),
	(255813, 0, 'Vận chuyển thủy tinh', 51, 1443, 0, 1, 0, 1, 'phantom', 'docktrailer'),
	(255814, 1, 'Vận chuyển pháo hoa', 60, 2282, 1, 1, 0, 0, NULL, 'trailers4'),
	(255815, 0, 'Vận chuyển cao su', 73, 1938, 0, 0, 0, 0, 'phantom', 'trailers'),
	(255816, 1, 'Vận chuyển khoai tây', 167, 2132, 0, 0, 0, 0, NULL, 'trailers2'),
	(255817, 0, 'Vận chuyển đá', 63, 1750, 0, 0, 0, 0, 'phantom', 'docktrailer'),
	(255818, 1, 'Vận chuyển nho', 59, 2768, 0, 0, 0, 0, NULL, 'trailers2'),
	(255819, 0, 'Vận chuyển nho', 170, 1453, 0, 0, 0, 0, 'phantom', 'trailers2'),
	(255820, 1, 'Vận chuyển giấm', 64, 2835, 0, 0, 0, 0, NULL, 'trailers2'),
	(255821, 0, 'Vận chuyển pháo hoa', 84, 1577, 1, 1, 0, 0, 'phantom', 'trailers4'),
	(255822, 1, 'Vận chuyển vật tư cho sự kiện', 68, 2748, 0, 1, 1, 0, NULL, 'tvtrailer'),
	(255823, 0, 'Boat trailer', 179, 1669, 0, 1, 1, 0, 'phantom', 'trailers4'),
	(255824, 1, 'Vận chuyển vật liệu xây dựng', 3, 2559, 0, 0, 0, 1, NULL, 'trailers'),
	(255825, 0, 'Vận chuyển tủ đông', 146, 1565, 0, 1, 0, 0, 'phantom', 'docktrailer'),
	(255826, 1, 'Vận chuyển gỗ', 82, 2513, 0, 0, 0, 0, NULL, 'trailerlogs'),
	(255827, 0, 'Vận chuyển chất độc', 172, 1959, 5, 0, 0, 0, 'phantom', 'liquide1'),
	(255828, 1, 'Vận chuyển đường sắt', 48, 2322, 0, 0, 0, 0, NULL, 'trailers3'),
	(255829, 0, 'Vận chuyển vật liệu ăn mòn cho quân đội', 102, 1560, 6, 0, 1, 0, 'phantom', 'armytanker'),
	(255830, 1, 'Vận chuyển pháo hoa', 120, 2511, 1, 1, 0, 0, NULL, 'trailers4'),
	(255831, 0, 'Nước sạch cho quân đội', 143, 1967, 0, 0, 0, 0, 'phantom', 'armytanker'),
	(255832, 1, 'Vận chuyển gỗ tinh chế', 106, 2580, 0, 0, 0, 1, NULL, 'docktrailer'),
	(255833, 0, 'Vận chuyển quần áo', 171, 1555, 0, 0, 0, 0, 'phantom', 'docktrailer'),
	(255834, 1, 'Vận chuyển nước chanh', 1, 2738, 0, 0, 0, 0, NULL, 'trailers2'),
	(255835, 0, 'Vận chuyển phô mai', 146, 1866, 0, 0, 0, 1, 'phantom', 'trailers2'),
	(255836, 1, 'Bồn chứa dầu hoả', 114, 2892, 3, 0, 0, 1, NULL, 'tanker2'),
	(255837, 0, 'Bồn chứa dầu hoả', 105, 1905, 3, 0, 0, 0, 'phantom', 'tanker2'),
	(255838, 1, 'Vận chuyển thuốc trừ sâu', 52, 2124, 5, 0, 0, 0, NULL, 'liquide1'),
	(255839, 0, 'Vận chuyển nhựa', 38, 1614, 0, 0, 0, 0, 'phantom', 'docktrailer'),
	(255840, 1, 'Vận chuyển đường sắt', 112, 2124, 0, 0, 0, 0, NULL, 'trailers3'),
	(255841, 0, 'Vận chuyển đồ đạc', 104, 1673, 0, 0, 0, 1, 'phantom', 'docktrailer'),
	(255842, 1, 'Vận chuyển pháo hoa', 30, 2858, 1, 1, 0, 0, NULL, 'trailers4'),
	(255843, 0, 'Vận chuyển vật liệu ăn mòn cho quân đội', 63, 1989, 6, 0, 1, 0, 'phantom', 'armytanker'),
	(255844, 1, 'Vận chuyển Kali Clorua', 86, 2661, 5, 0, 0, 0, NULL, 'liquide1'),
	(255845, 0, 'Vận chuyển thủy tinh', 175, 1610, 0, 1, 0, 0, 'phantom', 'docktrailer'),
	(255846, 1, 'Vận chuyển đạn dược', 35, 2274, 1, 0, 0, 0, NULL, 'docktrailer'),
	(255847, 0, 'Vận chuyển nước chanh', 177, 1500, 0, 0, 0, 0, 'phantom', 'trailers2'),
	(255848, 0, 'Vận chuyển quần áo', 115, 1630, 0, 0, 0, 0, 'phantom', 'docktrailer'),
	(255849, 1, 'Vận chuyển đường sắt', 162, 2390, 0, 0, 0, 0, NULL, 'trailers3'),
	(255850, 0, 'Vận chuyển vật liệu nổ', 185, 1464, 1, 1, 0, 0, 'phantom', 'trailers4'),
	(255851, 1, 'Vận chuyển thủy tinh', 4, 2318, 0, 1, 0, 0, NULL, 'docktrailer');

--  Table smile.trucker_drivers
DROP TABLE IF EXISTS `trucker_drivers`;
CREATE TABLE IF NOT EXISTS `trucker_drivers` (
  `driver_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `product_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `distance` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `valuable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fragile` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fast` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `price` int(10) unsigned NOT NULL DEFAULT 0,
  `price_per_km` int(10) unsigned NOT NULL DEFAULT 0,
  `img` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`driver_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3515 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.trucker_drivers: ~19 rows (approximately)
REPLACE INTO `trucker_drivers` (`driver_id`, `user_id`, `name`, `product_type`, `distance`, `valuable`, `fragile`, `fast`, `price`, `price_per_km`, `img`) VALUES
	(3495, NULL, 'Jordan Hyde', 3, 1, 5, 0, 1, 15209, 771, 'https://bootdey.com/img/Content/avatar/avatar8.png'),
	(3496, NULL, 'Spencer Camacho', 2, 5, 3, 2, 3, 18419, 1040, 'https://bootdey.com/img/Content/avatar/avatar4.png'),
	(3497, NULL, 'Gabriela Azevedo', 5, 6, 3, 0, 0, 18625, 971, 'https://bootdey.com/img/Content/avatar/avatar3.png'),
	(3498, NULL, 'Kimberley Whitney', 5, 4, 4, 1, 5, 21122, 1168, 'https://bootdey.com/img/Content/avatar/avatar4.png'),
	(3499, NULL, 'Hurley Black', 2, 0, 4, 6, 2, 17502, 935, 'https://bootdey.com/img/Content/avatar/avatar8.png'),
	(3500, NULL, 'Angela Mayer', 0, 5, 1, 3, 6, 19093, 1040, 'https://bootdey.com/img/Content/avatar/avatar2.png'),
	(3501, NULL, 'Mclean Warner', 6, 0, 1, 3, 5, 18564, 992, 'https://bootdey.com/img/Content/avatar/avatar7.png'),
	(3502, NULL, 'Alba Warren', 3, 3, 0, 0, 2, 14455, 724, 'https://bootdey.com/img/Content/avatar/avatar4.png'),
	(3503, NULL, 'Craig Watts', 1, 1, 3, 1, 0, 13699, 742, 'https://bootdey.com/img/Content/avatar/avatar2.png'),
	(3504, NULL, 'Leigh Durham', 4, 0, 3, 5, 0, 17454, 901, 'https://bootdey.com/img/Content/avatar/avatar5.png'),
	(3505, NULL, 'Whitaker Mason', 3, 4, 3, 4, 2, 18292, 1067, 'https://bootdey.com/img/Content/avatar/avatar1.png'),
	(3506, NULL, 'Iris Christensen', 0, 2, 1, 6, 0, 15907, 769, 'https://bootdey.com/img/Content/avatar/avatar6.png'),
	(3507, NULL, 'Isabela Castro', 1, 1, 2, 0, 5, 14564, 729, 'https://bootdey.com/img/Content/avatar/avatar3.png'),
	(3508, NULL, 'Holman Dixon', 5, 3, 1, 1, 4, 18686, 1012, 'https://bootdey.com/img/Content/avatar/avatar8.png'),
	(3509, NULL, 'Goff Raymond', 2, 5, 0, 4, 4, 19191, 1001, 'https://bootdey.com/img/Content/avatar/avatar8.png'),
	(3510, NULL, 'Eduarda Barbosa', 1, 5, 5, 1, 2, 17585, 869, 'https://bootdey.com/img/Content/avatar/avatar3.png'),
	(3511, NULL, 'Munoz Crosby', 3, 0, 5, 1, 3, 16176, 830, 'https://bootdey.com/img/Content/avatar/avatar1.png'),
	(3512, NULL, 'Velez Terry', 0, 3, 6, 1, 3, 17726, 842, 'https://bootdey.com/img/Content/avatar/avatar1.png'),
	(3513, NULL, 'Mari Brady', 2, 6, 0, 6, 6, 20414, 1108, 'https://bootdey.com/img/Content/avatar/avatar8.png'),
	(3514, NULL, 'Candice Patterson', 6, 5, 4, 1, 2, 20566, 992, 'https://bootdey.com/img/Content/avatar/avatar6.png');

--  Table smile.trucker_loans
DROP TABLE IF EXISTS `trucker_loans`;
CREATE TABLE IF NOT EXISTS `trucker_loans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `loan` int(10) unsigned NOT NULL DEFAULT 0,
  `remaining_amount` int(10) unsigned NOT NULL DEFAULT 0,
  `day_cost` int(10) unsigned NOT NULL DEFAULT 0,
  `taxes_on_day` int(10) unsigned NOT NULL DEFAULT 0,
  `timer` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.trucker_loans: ~0 rows (approximately)

--  Table smile.trucker_trucks
DROP TABLE IF EXISTS `trucker_trucks`;
CREATE TABLE IF NOT EXISTS `trucker_trucks` (
  `truck_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `truck_name` varchar(50) NOT NULL,
  `driver` int(10) unsigned DEFAULT NULL,
  `body` smallint(5) unsigned NOT NULL DEFAULT 1000,
  `engine` smallint(5) unsigned NOT NULL DEFAULT 1000,
  `transmission` smallint(5) unsigned NOT NULL DEFAULT 1000,
  `wheels` smallint(5) unsigned NOT NULL DEFAULT 1000,
  PRIMARY KEY (`truck_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.trucker_trucks: ~0 rows (approximately)

--  Table smile.trucker_users
DROP TABLE IF EXISTS `trucker_users`;
CREATE TABLE IF NOT EXISTS `trucker_users` (
  `user_id` varchar(50) NOT NULL,
  `money` int(10) unsigned NOT NULL DEFAULT 0,
  `total_earned` int(10) unsigned NOT NULL DEFAULT 0,
  `finished_deliveries` int(10) unsigned NOT NULL DEFAULT 0,
  `exp` int(10) unsigned NOT NULL DEFAULT 0,
  `traveled_distance` double unsigned NOT NULL DEFAULT 0,
  `skill_points` int(10) unsigned NOT NULL DEFAULT 0,
  `product_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `distance` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `valuable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fragile` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fast` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `loan_notify` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.trucker_users: ~0 rows (approximately)
REPLACE INTO `trucker_users` (`user_id`, `money`, `total_earned`, `finished_deliveries`, `exp`, `traveled_distance`, `skill_points`, `product_type`, `distance`, `valuable`, `fragile`, `fast`, `loan_notify`) VALUES
	('1100001147e8c1c', 3953, 3953, 1, 19, 2.29, 0, 0, 0, 0, 0, 0, b'0');

--  Table smile.twitter_account
DROP TABLE IF EXISTS `twitter_account`;
CREATE TABLE IF NOT EXISTS `twitter_account` (
  `id` varchar(90) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.twitter_account: ~0 rows (approximately)

--  Table smile.twitter_hashtags
DROP TABLE IF EXISTS `twitter_hashtags`;
CREATE TABLE IF NOT EXISTS `twitter_hashtags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `created` varchar(50) NOT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.twitter_hashtags: ~0 rows (approximately)

--  Table smile.twitter_mentions
DROP TABLE IF EXISTS `twitter_mentions`;
CREATE TABLE IF NOT EXISTS `twitter_mentions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tweet` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `mentioned` text NOT NULL,
  `created` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.twitter_mentions: ~0 rows (approximately)

--  Table smile.twitter_tweets
DROP TABLE IF EXISTS `twitter_tweets`;
CREATE TABLE IF NOT EXISTS `twitter_tweets` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) NOT NULL,
  `message` longtext NOT NULL,
  `hashtags` varchar(50) NOT NULL,
  `mentions` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `likes` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.twitter_tweets: ~0 rows (approximately)

--  Table smile.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(46) NOT NULL,
  `name` longtext DEFAULT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `job2` varchar(20) DEFAULT 'nogang',
  `job2_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `isDead` tinyint(1) DEFAULT 0,
  `disabled` tinyint(1) DEFAULT 0,
  `last_property` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `last_seen` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `phone_number` varchar(20) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `tattoos` longtext DEFAULT NULL,
  `apps` text DEFAULT NULL,
  `widget` text DEFAULT NULL,
  `bt` text DEFAULT NULL,
  `charinfo` text DEFAULT NULL,
  `metadata` mediumtext DEFAULT NULL,
  `cryptocurrency` longtext DEFAULT NULL,
  `cryptocurrencytransfers` text DEFAULT NULL,
  `truyna` tinyint(4) DEFAULT NULL,
  `saotruyna` tinyint(4) DEFAULT 0,
  `gift` int(11) DEFAULT 0,
  `jail` int(11) NOT NULL DEFAULT 0,
  `camchat` tinyint(4) DEFAULT NULL,
  `phonePos` text DEFAULT NULL,
  `spotify` text DEFAULT NULL,
  `ringtone` text DEFAULT NULL,
  `first_screen_showed` int(11) DEFAULT NULL,
  `eventpoint` int(11) NOT NULL DEFAULT 0,
  `eventtime` int(50) NOT NULL DEFAULT 0,
  `eventpremium` int(1) NOT NULL DEFAULT 0,
  `eventdata` longtext,
  `eventdaily` longtext,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.users: ~2 rows (approximately)
REPLACE INTO `users` (`id`, `identifier`, `name`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `job2`, `job2_grade`, `loadout`, `position`, `firstname`, `lastname`, `dateofbirth`, `sex`, `height`, `skin`, `status`, `isDead`, `disabled`, `last_property`, `created_at`, `last_seen`, `phone_number`, `pincode`, `tattoos`, `apps`, `widget`, `bt`, `charinfo`, `metadata`, `cryptocurrency`, `cryptocurrencytransfers`, `truyna`, `saotruyna`, `gift`, `jail`, `camchat`, `phonePos`, `spotify`, `ringtone`, `first_screen_showed`, `eventpoint`, `eventtime`, `eventpremium`, `eventdata`, `eventdaily`) VALUES
	(2, '1100001147e8c1c', 'Bin', '{"black_money":0,"money":0,"bank":62200}', 'user', '[]', 'ambulance', 4, 'nogang', 0, '[]', '{"x":725.037353515625,"heading":181.41732788085938,"z":11.3853759765625,"y":-2671.503173828125}', NULL, NULL, NULL, NULL, NULL, '{"model":"mp_m_freemode_01","tattoos":[],"props":[{"prop_id":0,"drawable":-1,"texture":-1},{"prop_id":1,"drawable":-1,"texture":-1},{"prop_id":2,"drawable":-1,"texture":-1},{"prop_id":6,"drawable":-1,"texture":-1},{"prop_id":7,"drawable":-1,"texture":-1}],"components":[{"drawable":0,"texture":0,"component_id":0},{"drawable":0,"texture":0,"component_id":1},{"drawable":0,"texture":0,"component_id":2},{"drawable":0,"texture":0,"component_id":3},{"drawable":0,"texture":0,"component_id":4},{"drawable":0,"texture":0,"component_id":5},{"drawable":0,"texture":0,"component_id":6},{"drawable":0,"texture":0,"component_id":7},{"drawable":0,"texture":0,"component_id":8},{"drawable":0,"texture":0,"component_id":9},{"drawable":0,"texture":0,"component_id":10},{"drawable":0,"texture":0,"component_id":11}],"eyeColor":-1,"headBlend":{"thirdMix":0,"skinThird":0,"shapeMix":0,"shapeSecond":0,"shapeThird":0,"skinSecond":0,"shapeFirst":0,"skinFirst":0,"skinMix":0},"faceFeatures":{"nosePeakHigh":0,"nosePeakSize":0,"nosePeakLowering":0,"cheeksWidth":0,"chinHole":0,"lipsThickness":0,"jawBoneWidth":0,"chinBoneSize":0,"eyeBrownHigh":0,"noseWidth":0,"neckThickness":0,"noseBoneHigh":0,"chinBoneLowering":0,"cheeksBoneWidth":0,"cheeksBoneHigh":0,"chinBoneLenght":0,"noseBoneTwist":0,"jawBoneBackSize":0,"eyeBrownForward":0,"eyesOpening":0},"hair":{"texture":0,"style":0,"highlight":0,"color":0},"headOverlays":{"blemishes":{"opacity":0,"style":0,"color":0,"secondColor":0},"beard":{"opacity":0,"style":0,"color":0,"secondColor":0},"lipstick":{"opacity":0,"style":0,"color":0,"secondColor":0},"chestHair":{"opacity":0,"style":0,"color":0,"secondColor":0},"eyebrows":{"opacity":0,"style":0,"color":0,"secondColor":0},"bodyBlemishes":{"opacity":0,"style":0,"color":0,"secondColor":0},"blush":{"opacity":0,"style":0,"color":0,"secondColor":0},"complexion":{"opacity":0,"style":0,"color":0,"secondColor":0},"makeUp":{"opacity":0,"style":0,"color":0,"secondColor":0},"sunDamage":{"opacity":0,"style":0,"color":0,"secondColor":0},"moleAndFreckles":{"opacity":0,"style":0,"color":0,"secondColor":0},"ageing":{"opacity":0,"style":0,"color":0,"secondColor":0}}}', '[{"percent":12.2235,"val":122235,"name":"hunger"},{"percent":12.2235,"val":122235,"name":"thirst"}]', 0, 0, NULL, '2024-01-28 14:42:40', '2024-01-28 15:15:26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '{"itemrewarded":[],"missionrewarded":[],"items":{"trash":0,"pizza":0,"heroin":0,"clothe":0,"copper":0,"xang":0,"fish":0,"cutted_wood":0,"coca":0,"cannabis":0,"diamond":0,"slaughtered_chicken":0}}', '{"items":{"trash":0,"pizza":0,"heroin":0,"clothe":0,"copper":0,"xang":0,"fish":0,"cutted_wood":0,"coca":0,"cannabis":0,"diamond":0,"slaughtered_chicken":0},"missionrewarded":[],"missiondata":[{"rank":1,"mission":5},{"rank":2,"mission":1},{"rank":3,"mission":3}],"missiondate":28}'),
	(1, '11000013e621c8b', 'Bun', '{"black_money":0,"bank":53900,"money":0}', 'user', '[{"count":1,"metadata":{"resource":"từ admin","serial":"212500QMX723254","components":[],"registered":"steam:11000013e621c8b","time":"21:34:20 - 01/28/24","durability":100,"ammo":0},"name":"WEAPON_ASSAULTRIFLE","slot":1},{"count":1,"name":"balo","slot":2},{"count":1,"name":"hifi","slot":3}]', 'unemployed', 0, 'police', 3, '[]', '{"y":-351.73187255859377,"z":46.8037109375,"heading":294.80316162109377,"x":403.015380859375}', NULL, NULL, NULL, NULL, NULL, '{"components":[{"texture":0,"drawable":0,"component_id":0},{"texture":0,"drawable":0,"component_id":1},{"texture":0,"drawable":0,"component_id":2},{"texture":0,"drawable":0,"component_id":3},{"texture":0,"drawable":0,"component_id":4},{"texture":0,"drawable":0,"component_id":5},{"texture":0,"drawable":0,"component_id":6},{"texture":0,"drawable":0,"component_id":7},{"texture":0,"drawable":0,"component_id":8},{"texture":0,"drawable":0,"component_id":9},{"texture":0,"drawable":0,"component_id":10},{"texture":0,"drawable":0,"component_id":11}],"headOverlays":{"chestHair":{"secondColor":0,"opacity":0,"style":0,"color":0},"makeUp":{"secondColor":0,"opacity":0,"style":0,"color":0},"moleAndFreckles":{"secondColor":0,"opacity":0,"style":0,"color":0},"sunDamage":{"secondColor":0,"opacity":0,"style":0,"color":0},"bodyBlemishes":{"secondColor":0,"opacity":0,"style":0,"color":0},"lipstick":{"secondColor":0,"opacity":0,"style":0,"color":0},"ageing":{"secondColor":0,"opacity":0,"style":0,"color":0},"complexion":{"secondColor":0,"opacity":0,"style":0,"color":0},"eyebrows":{"secondColor":0,"opacity":0,"style":0,"color":0},"blush":{"secondColor":0,"opacity":0,"style":0,"color":0},"blemishes":{"secondColor":0,"opacity":0,"style":0,"color":0},"beard":{"secondColor":0,"opacity":0,"style":0,"color":0}},"headBlend":{"shapeMix":0,"shapeFirst":0,"shapeSecond":0,"skinFirst":0,"skinThird":0,"shapeThird":0,"skinSecond":0,"skinMix":0,"thirdMix":0},"props":[{"drawable":-1,"texture":-1,"prop_id":0},{"drawable":-1,"texture":-1,"prop_id":1},{"drawable":-1,"texture":-1,"prop_id":2},{"drawable":-1,"texture":-1,"prop_id":6},{"drawable":-1,"texture":-1,"prop_id":7}],"model":"mp_m_freemode_01","faceFeatures":{"eyeBrownForward":0,"eyeBrownHigh":0,"cheeksWidth":0,"chinBoneSize":0,"chinBoneLenght":0,"nosePeakLowering":0,"lipsThickness":0,"eyesOpening":0,"noseWidth":0,"noseBoneTwist":0,"nosePeakHigh":0,"cheeksBoneHigh":0,"cheeksBoneWidth":0,"chinBoneLowering":0,"jawBoneWidth":0,"noseBoneHigh":0,"jawBoneBackSize":0,"nosePeakSize":0,"chinHole":0,"neckThickness":0},"hair":{"highlight":0,"texture":0,"color":0,"style":0},"eyeColor":-1,"tattoos":[]}', '[{"val":988890,"name":"hunger","percent":98.88900000000001},{"val":988890,"name":"thirst","percent":98.88900000000001}]', 0, 0, NULL, '2024-01-28 14:30:16', '2024-01-29 08:44:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, '{"missionrewarded":[],"items":{"cannabis":0,"cutted_wood":0,"diamond":0,"heroin":0,"xang":0,"trash":0,"fish":0,"copper":0,"clothe":0,"coca":0,"slaughtered_chicken":0,"pizza":0},"itemrewarded":[]}', '{"missionrewarded":[],"missiondata":[{"rank":1,"mission":8},{"rank":2,"mission":7},{"rank":3,"mission":1}],"missiondate":29,"items":{"cannabis":0,"cutted_wood":0,"diamond":0,"heroin":0,"xang":0,"trash":0,"fish":0,"copper":0,"clothe":0,"coca":0,"pizza":0,"slaughtered_chicken":0}}');

--  Table smile.user_licenses
DROP TABLE IF EXISTS `user_licenses`;
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(46) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.user_licenses: ~0 rows (approximately)

--  Table smile.vehicles
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `imglink` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.vehicles: ~93 rows (approximately)
REPLACE INTO `vehicles` (`name`, `model`, `price`, `category`, `imglink`) VALUES
	('Adder', 'adder', 900000, 'super', 'https://i.imgur.com/7z3EWHn.jpg'),
	('Akuma', 'AKUMA', 7500, 'motorcycles', 'https://i.imgur.com/7N4bxxm.jpg'),
	('Alpha', 'alpha', 60000, 'sports', 'https://i.imgur.com/2WmCYoy.jpg'),
	('Autarch', 'autarch', 1955000, 'super', 'https://i.imgur.com/G7cTxsB.jpg'),
	('Baller Sport', 'baller3', 60000, 'suvs', 'https://i.imgur.com/6Y0qpMo.jpg'),
	('Banshee', 'banshee', 70000, 'sports', 'https://i.imgur.com/DEqa9p5.jpg'),
	('Bati 801RR', 'bati2', 19000, 'motorcycles', 'https://i.imgur.com/VQiQKLY.jpg'),
	('Bestia GTS', 'bestiagts', 55000, 'sports', 'https://i.imgur.com/V3DijVh.jpg'),
	('Bison', 'bison', 45000, 'vans', 'https://i.imgur.com/2PiveGT.jpg'),
	('Blazer', 'blazer', 6500, 'offroad', 'https://i.imgur.com/eOx7N4Z.jpg'),
	('Blista', 'blista', 8000, 'compacts', 'https://i.imgur.com/wL0HoeH.jpg'),
	('Bobcat XL', 'bobcatxl', 32000, 'vans', 'https://i.imgur.com/Uz5mqI5.jpg'),
	('Brawler', 'brawler', 45000, 'offroad', 'https://i.imgur.com/JVR8JPy.jpg'),
	('Brioso R/A', 'brioso', 18000, 'compacts', 'https://i.imgur.com/OjYXoj2.png'),
	('Buffalo', 'buffalo', 12000, 'sports', 'https://i.imgur.com/KAEpGMs.jpg'),
	('Bullet', 'bullet', 90000, 'super', 'https://i.imgur.com/GNJ5eb2.jpg'),
	('Burrito', 'burrito3', 19000, 'vans', 'https://i.imgur.com/gVWanDX.jpg'),
	('Camper', 'camper', 42000, 'vans', 'https://i.imgur.com/GyQ7Sm0.jpg'),
	('Carbonizzare', 'carbonizzare', 75000, 'sports', 'https://i.imgur.com/p0cuo9E.jpg'),
	('Carbon RS', 'carbonrs', 18000, 'motorcycles', 'https://i.imgur.com/TrlJmoe.jpg'),
	('Casco', 'casco', 30000, 'sportsclassics', 'https://i.imgur.com/Vti3qBQ.png'),
	('Cavalcade', 'cavalcade2', 55000, 'suvs', 'https://i.imgur.com/rSDBWmM.png'),
	('Cheetah', 'cheetah', 375000, 'super', 'https://i.imgur.com/yjtco11.png'),
	('Cognoscenti', 'cognoscenti', 55000, 'sedans', 'https://i.imgur.com/Jyoc16R.png'),
	('Coquette', 'coquette', 65000, 'sports', 'https://i.imgur.com/t5CTclE.png'),
	('Cruiser (velo)', 'cruiser', 510, 'motorcycles', 'https://i.imgur.com/pnJsPCt.png'),
	('Cyclone', 'cyclone', 1890000, 'super', 'https://i.imgur.com/ohjbp3Z.png'),
	('Dominator', 'dominator', 35000, 'muscle', 'https://i.imgur.com/R1Wf0Zf.png'),
	('Double T', 'double', 28000, 'motorcycles', 'https://i.imgur.com/CFWnf88.png'),
	('Dubsta Luxuary', 'dubsta2', 60000, 'suvs', 'https://i.imgur.com/wfvcKiJ.png'),
	('Dune Buggy', 'dune', 8000, 'offroad', 'https://i.imgur.com/cMQtX3e.png'),
	('Elegy', 'elegy2', 38500, 'sports', 'https://i.imgur.com/E5bT1V4.png'),
	('Faggio', 'faggio', 1900, 'motorcycles', 'https://i.imgur.com/aVCU0JT.png'),
	('Fixter (velo)', 'fixter', 225, 'motorcycles', 'https://i.imgur.com/gWMDdI0.png'),
	('FMJ', 'fmj', 185000, 'super', 'https://i.imgur.com/t85ZBkY.png'),
	('Gang Burrito', 'gburrito', 45000, 'vans', 'https://i.imgur.com/qMWIN3P.png'),
	('Burrito', 'gburrito2', 29000, 'vans', 'https://i.imgur.com/3bJRH90.png'),
	('Gresley', 'gresley', 47500, 'suvs', 'https://i.imgur.com/pQQe8f8.png'),
	('Hermes', 'hermes', 535000, 'muscle', 'https://i.imgur.com/jNHGYOn.png'),
	('Huntley S', 'huntley', 40000, 'suvs', 'https://i.imgur.com/BBxcxtB.png'),
	('Intruder', 'intruder', 7500, 'sedans', 'https://i.imgur.com/EIbncoR.png'),
	('Journey', 'journey', 6500, 'vans', 'https://i.imgur.com/36leVi9.png'),
	('Khamelion', 'khamelion', 38000, 'sports', 'https://i.imgur.com/hMIse67.png'),
	('The Liberator', 'monster', 210000, 'offroad', 'https://i.imgur.com/zRvd2ZI.png'),
	('Neon', 'neon', 1500000, 'sports', 'https://i.imgur.com/BsovfO7.jpg'),
	('9F', 'ninef', 65000, 'sports', 'https://i.imgur.com/L4sj4iM.png'),
	('9F Cabrio', 'ninef2', 80000, 'sports', 'https://i.imgur.com/PXsNQQW.png'),
	('Omnis', 'omnis', 35000, 'sports', 'https://i.imgur.com/ogfig97.png'),
	('Osiris', 'osiris', 160000, 'super', 'https://i.imgur.com/vMtk5xV.jpg'),
	('Panto', 'panto', 10000, 'compacts', 'https://i.imgur.com/631C2Kz.png'),
	('Paradise', 'paradise', 19000, 'vans', 'https://i.imgur.com/PIp0H3K.png'),
	('Patriot', 'patriot', 55000, 'suvs', 'https://i.imgur.com/psiBnnu.png'),
	('Penumbra', 'penumbra', 28000, 'sports', 'https://i.imgur.com/bCakfdw.png'),
	('X80 Proto', 'prototipo', 2500000, 'super', 'https://i.imgur.com/SLBbNGB.png'),
	('raiden', 'raiden', 1375000, 'sports', 'https://i.imgur.com/cUamAuA.jpg'),
	('Reaper', 'reaper', 150000, 'super', 'https://i.imgur.com/jmeIr3M.jpg'),
	('Rebel', 'rebel2', 35000, 'offroad', 'https://i.imgur.com/Gt3OWnf.png'),
	('Rumpo Trail', 'rumpo3', 19500, 'vans', 'https://i.imgur.com/XKcTT6A.png'),
	('Sanchez Sport', 'sanchez2', 5300, 'motorcycles', 'https://i.imgur.com/kACyEZH.png'),
	('Sanctus', 'sanctus', 25000, 'motorcycles', 'https://i.imgur.com/1MmdadJ.png'),
	('Scorcher (velo)', 'scorcher', 280, 'motorcycles', 'https://i.imgur.com/dVatTPD.png'),
	('Seven 70', 'seven70', 39500, 'sports', 'https://i.imgur.com/keEb4hP.png'),
	('Shotaro Concept', 'shotaro', 320000, 'motorcycles', 'https://i.imgur.com/NQn7i5E.png'),
	('Stretch', 'stretch', 90000, 'sedans', 'https://i.imgur.com/6huOLeo.png'),
	('Surano', 'surano', 50000, 'sports', 'https://i.imgur.com/wUVuokH.png'),
	('Surfer', 'surfer', 12000, 'vans', 'https://i.imgur.com/SjMh0am.png'),
	('T20', 't20', 300000, 'super', 'https://i.imgur.com/2Fw1g1v.jpg'),
	('Thrust', 'thrust', 24000, 'motorcycles', 'https://i.imgur.com/fAW9wpz.png'),
	('Tri bike (velo)', 'tribike3', 520, 'motorcycles', 'https://i.imgur.com/6uVcYF4.png'),
	('Trophy Truck', 'trophytruck', 60000, 'offroad', 'https://i.imgur.com/bXPMJJe.png'),
	('Turismo R', 'turismor', 350000, 'super', 'https://i.imgur.com/tuBMgse.jpg'),
	('Vacca', 'vacca', 120000, 'super', 'https://i.imgur.com/ihxEh5y.png'),
	('Vader', 'vader', 7200, 'motorcycles', 'https://i.imgur.com/tDz1SgF.jpg'),
	('Visione', 'visione', 2250000, 'super', 'https://i.imgur.com/m0h1Bup.jpg'),
	('Vortex', 'vortex', 9800, 'motorcycles', 'https://i.imgur.com/xBtxqBT.jpg'),
	('Youga', 'youga', 10800, 'vans', 'https://i.imgur.com/kcLdrJn.png'),
	('Zentorno', 'zentorno', 1500000, 'super', 'https://i.imgur.com/oYpwLMw.jpg'),
	(' Mercedes-AMG C63 S  ', 'c63ig', 5000000, 'abc', 'https://i.imgur.com/SN8D7Ns.png'),
	('Kawasaki Ninja H2', 'h2carb', 12000000, 'abc', 'https://i.imgur.com/1rlS29b.png'),
	('Chino', 'chino2', 400000, 'muscle', 'https://i.imgur.com/QqWmwh5.png'),
	('Clique', 'clique', 400000, 'muscle', 'https://i.imgur.com/iZTItpU.png'),
	('Deviant', 'deviant', 350000, 'muscle', 'https://i.imgur.com/Nhivcfw.png'),
	('Tailgater S', 'tailgater2', 2000000, 'sedans', 'https://i.imgur.com/z75ENqw.png'),
	('Flash GT', 'flashgt', 3000000, 'sports', 'https://i.imgur.com/YRRCetd.png'),
	('Omnis', 'omnis', 1500000, 'sports', 'https://i.imgur.com/JBLgLBT.png'),
	('Revolter', 'revolter', 2000000, 'sports', 'https://i.imgur.com/rniyEZp.png'),
	('Furia', 'furia', 3000000, 'sports', 'https://i.imgur.com/IpSAdsX.png'),
	('Krieger', 'krieger', 1500000, 'sports', 'https://i.imgur.com/usMyqOb.png'),
	('Zorrusso', 'zorrusso', 2500000, 'sports', 'https://i.imgur.com/lnx2XRp.png'),
	('Sultan', 'sultan3', 3000000, 'sports', 'https://i.imgur.com/ukC3bkP.png'),
	('Sultan RS', 'sultanrs', 4000000, 'sports', 'https://i.imgur.com/ukC3bkP.png'),
	('BMW S1000RR', 's1000rr', 15999999, 'abc', 'https://i.imgur.com/yU1qp7h.png'),
	('BMW M3 Hycade', 'm3ig', 7999999, 'abc', 'https://i.imgur.com/w1nIsgt.png');

--  Table smile.vehicle_categories
DROP TABLE IF EXISTS `vehicle_categories`;
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.vehicle_categories: ~12 rows (approximately)
REPLACE INTO `vehicle_categories` (`name`, `label`) VALUES
	('abc', 'Xe Custom'),
	('compacts', 'Compacts'),
	('coupes', 'Coupés'),
	('motorcycles', 'Motos'),
	('muscle', 'Muscle'),
	('offroad', 'Off Road'),
	('sedans', 'Sedans'),
	('sports', 'Sports'),
	('sportsclassics', 'Sports Classics'),
	('super', 'Super'),
	('suvs', 'SUVs'),
	('vans', 'Vans');

--  Table smile.vehicle_sold
DROP TABLE IF EXISTS `vehicle_sold`;
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.vehicle_sold: ~0 rows (approximately)

--  Table smile.whatsapp_accounts
DROP TABLE IF EXISTS `whatsapp_accounts`;
CREATE TABLE IF NOT EXISTS `whatsapp_accounts` (
  `id` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `avatar` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.whatsapp_accounts: ~0 rows (approximately)

--  Table smile.whatsapp_chats
DROP TABLE IF EXISTS `whatsapp_chats`;
CREATE TABLE IF NOT EXISTS `whatsapp_chats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `messages` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.whatsapp_chats: ~0 rows (approximately)

--  Table smile.whatsapp_chats_messages
DROP TABLE IF EXISTS `whatsapp_chats_messages`;
CREATE TABLE IF NOT EXISTS `whatsapp_chats_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_chat` int(11) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `created` varchar(50) NOT NULL,
  `message` mediumtext NOT NULL,
  `readed` int(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.whatsapp_chats_messages: ~0 rows (approximately)

--  Table smile.whatsapp_groups
DROP TABLE IF EXISTS `whatsapp_groups`;
CREATE TABLE IF NOT EXISTS `whatsapp_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `number` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.whatsapp_groups: ~0 rows (approximately)

--  Table smile.whatsapp_groups_messages
DROP TABLE IF EXISTS `whatsapp_groups_messages`;
CREATE TABLE IF NOT EXISTS `whatsapp_groups_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_group` varchar(50) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  `message` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `read` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.whatsapp_groups_messages: ~0 rows (approximately)

--  Table smile.whatsapp_groups_users
DROP TABLE IF EXISTS `whatsapp_groups_users`;
CREATE TABLE IF NOT EXISTS `whatsapp_groups_users` (
  `number_group` varchar(50) NOT NULL,
  `admin` int(11) NOT NULL,
  `phone` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--  Data of table smile.whatsapp_groups_users: ~0 rows (approximately)

--  Table smile.whatsapp_stories
DROP TABLE IF EXISTS `whatsapp_stories`;
CREATE TABLE IF NOT EXISTS `whatsapp_stories` (
  `phone` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `created` varchar(50) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `filter` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.whatsapp_stories: ~0 rows (approximately)

--  Table smile.whitelist
DROP TABLE IF EXISTS `whitelist`;
CREATE TABLE IF NOT EXISTS `whitelist` (
  `identifier` varchar(46) NOT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--  Data of table smile.whitelist: ~0 rows (approximately)

--  Table smile.yellowpages_posts
DROP TABLE IF EXISTS `yellowpages_posts`;
CREATE TABLE IF NOT EXISTS `yellowpages_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `number` varchar(20) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--  Data of table smile.yellowpages_posts: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
