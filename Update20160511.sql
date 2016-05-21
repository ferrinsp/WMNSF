CREATE DATABASE  IF NOT EXISTS `wmnsffunds` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `wmnsffunds`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win64 (x86_64)
--
-- Host: localhost    Database: wmnsffunds
-- ------------------------------------------------------
-- Server version	5.6.26-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `balance`
--

DROP TABLE IF EXISTS `balance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `balance` (
  `user_id` int(11) NOT NULL,
  `fund_type_id` int(11) NOT NULL,
  `balance` decimal(12,2) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `fund_type_id` (`fund_type_id`),
  CONSTRAINT `balance_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `balance_ibfk_2` FOREIGN KEY (`fund_type_id`) REFERENCES `fund_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `balance`
--

LOCK TABLES `balance` WRITE;
/*!40000 ALTER TABLE `balance` DISABLE KEYS */;
INSERT INTO `balance` VALUES (2,1,1000),(2,2,500),(12,1,1000),(12,2,400);
/*!40000 ALTER TABLE `balance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `description`
--

DROP TABLE IF EXISTS `description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `description` (
  `description` int(11),
  `id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `description`
--

LOCK TABLES `description` WRITE;
/*!40000 ALTER TABLE `description` DISABLE KEYS */;
/*!40000 ALTER TABLE `description` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `error_log`
--

DROP TABLE IF EXISTS `error_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `error_log` (
  `id` int(11) NOT NULL,
  `class` varchar(50) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `error_log`
--

LOCK TABLES `error_log` WRITE;
/*!40000 ALTER TABLE `error_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `error_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund_type`
--

DROP TABLE IF EXISTS `fund_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fund_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `effective_start` datetime DEFAULT NULL,
  `effective_end` datetime DEFAULT NULL,
  `unallocted_funds` int DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund_type`
--

LOCK TABLES `fund_type` WRITE;
/*!40000 ALTER TABLE `fund_type` DISABLE KEYS */;
INSERT INTO `fund_type` VALUES (1,'HIDTA15','2015-01-01 00:00:00','2016-12-31 23:59:59','4000'),
(2,'15N01','2014-07-01 00:00:00','2016-06-30 23:59:59','2000'),
(3,'test','2015-12-07 00:00:00','2016-12-23 00:00:00','3000');
/*!40000 ALTER TABLE `fund_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission`
--

DROP TABLE IF EXISTS `permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permission` (
  `id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission`
--

LOCK TABLES `permission` WRITE;
/*!40000 ALTER TABLE `permission` DISABLE KEYS */;
INSERT INTO `permission` VALUES (1,'ADMIN'),(2,'USER');
/*!40000 ALTER TABLE `permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transfer_transaction`
--

DROP TABLE IF EXISTS `transfer_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transfer_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `description` varchar(250),
  `debit_user_id` int(11) DEFAULT NULL,
  `credit_user_id` int(11) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `operator_user_id` int(11) DEFAULT NULL,
  `fund_type_id` int(11) DEFAULT NULL,
  `check_number` int(16) DEFAULT NULL,
  `case_number` varchar(45) DEFAULT NULL,
  `ci_number` varchar(45) DEFAULT NULL,
  `transaction_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_ibfk_1` (`fund_type_id`),
  KEY `fk_debit_user` (`debit_user_id`),
  KEY `fk_credit_user` (`credit_user_id`),
  KEY `fk_operator_user` (`operator_user_id`),
  CONSTRAINT `fk_credit_user` FOREIGN KEY (`credit_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_debit_user` FOREIGN KEY (`debit_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_operator_user` FOREIGN KEY (`operator_user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `transfer_transaction_ibfk_1` FOREIGN KEY (`fund_type_id`) REFERENCES `fund_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer_transaction`
--

LOCK TABLES `transfer_transaction` WRITE;
/*!40000 ALTER TABLE `transfer_transaction` DISABLE KEYS */;
INSERT INTO `transfer_transaction` VALUES (1,'2014-05-09','Test Description',2,12,89222.00,2,1,123,'1111','WC-1111','Deposit'),
(2,'2013-05-26','fun things',12,4,3499.00,23,1,234,'1112','WC-1112','Transfer'),
(3,'2014-04-16','New Transaction',23,24,39888.00,25,2,NULL,'1114','WC-1114','Expenditure'),
(4,'2014-04-16','New Transaction',2,4,3988.00,12,1,NULL,'1115','WC-1115','Expenditure'),
(5,'2015-03-24','TestDB',12,23,100.00,12,2,321,'1116','WC-1116','Deposit'),
(6,'2015-04-14','Test transaction',24,2,150.00,2,2,NULL,'1113','WC-1113','Expenditure'),
(7,'2015-04-14','Test transaction at office',4,12,200.00,2,2,NULL,'1113','WC-1113','Expenditure'),
(8,'2015-04-16','testDate',23,24,1.00,2,1,NULL,NULL,NULL,'Expenditure'),
(9,'2015-04-18','testType 2',2,4,2.00,2,1,NULL,NULL,NULL,'Deposit'),
(10,'2015-04-18','testtype 3',12,23,15.00,2,2,NULL,NULL,NULL,'Expenditure'),
(11,'2015-06-01','test insert from sql',12,12,100.00,12,2,NULL,NULL,NULL,'Deposit'),
(12,'2015-06-28','End of month transfer',4,12,100.00,12,1,NULL,NULL,NULL,'Expenditure'),
(13,'2015-06-30','True end of month, please delete entry on 06/28',4,12,100.00,12,1,NULL,NULL,NULL,'Transfer'),
(14,'2015-06-29','testing transaction password',4,12,250.00,12,1,NULL,NULL,NULL,'Transfer'),
(15,'2015-12-07','test 1',12,23,50.00,23,1,12345,'543210','55','Transfer'),
(16,'2015-10-19','test 2',NULL,12,55.00,23,1,123456,'6543210','testHibernate','Deposit');
/*!40000 ALTER TABLE `transfer_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `balance` int(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Tate','Taylor',2,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','tatetaylor@mail.com',0,20),
	('Yong','Zhang',4,'$2a$10$lJSRlsBEPyDhSn2dCivsTuLl7CugUPqDhHw0N912OHMHM.jvfdhGS','yongzhang@weber.edu',0,0),
	('Caleb','New',12,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','calebnew@mail.com',1,5),
	('Spencer','Ferrin',23,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','ferrinsp@mail.com',1,50),
	('test','user',24,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','test@user.com',0,0),
	('Steven','Hoffman',25,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','stevenhoffman@mail.com',1,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permission`
--

DROP TABLE IF EXISTS `user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_permission` (
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `permission_id` (`permission_id`),
  CONSTRAINT `user_permission_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `user_permission_ibfk_2` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permission`
--

LOCK TABLES `user_permission` WRITE;
/*!40000 ALTER TABLE `user_permission` DISABLE KEYS */;
INSERT INTO `user_permission` VALUES (12,1),(12,2),(23,1),(2,1),(25,1),(4,2),(24,2);
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-14 15:32:47
