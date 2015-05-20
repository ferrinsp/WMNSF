-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: localhost    Database: sfcbdb
-- ------------------------------------------------------
-- Server version 5.6.23

CREATE DATABASE `WmnsfFunds` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `WmnsfFunds`;


--
-- Table structure for table `description`
--

DROP TABLE IF EXISTS `description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `description` (
  `description` int(11) NOT NULL,
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
  `id` int(11) NOT NULL DEFAULT '0',
  `Description` varchar(255) DEFAULT NULL,
  `effective_start` datetime DEFAULT NULL,
  `effective_end` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund_type`
--

LOCK TABLES `fund_type` WRITE;
/*!40000 ALTER TABLE `fund_type` DISABLE KEYS */;
INSERT INTO `fund_type` VALUES (1,'HIDTA15','2015-01-01 00:00:00','2015-12-31 23:59:59'),(2,'15N01','2014-07-01 00:00:00','2015-06-30 23:59:59');
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
  `id` int(11) NOT NULL DEFAULT '0',
  `date` date NOT NULL,
  `description` varchar(250) NOT NULL,
  `debit_user_id` int(11) DEFAULT NULL,
  `credit_user_id` int(11) DEFAULT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `operator_user_id` int(11) DEFAULT NULL,
  `fund_type` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_ibfk_1` (`fund_type`),
  CONSTRAINT `transfer_transaction_ibfk_1` FOREIGN KEY (`fund_type`) REFERENCES `fund_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transfer_transaction`
--

LOCK TABLES `transfer_transaction` WRITE;
/*!40000 ALTER TABLE `transfer_transaction` DISABLE KEYS */;
INSERT INTO `transfer_transaction` VALUES (1,'2014-05-09','baby time',4,5,89222.00,6,1),(2,'2013-05-26','fun things',3,3,3499.00,6,1),(3,'2014-04-16','new trans',4,3,39888.00,6,1),(4,'2014-04-16','new trans',4,3,39888.00,6,1),(5,'2015-03-24','testDB',6,2,100.00,6,1),(6,'2015-04-14','Test transaction',2,12,150.00,2,1),(7,'2015-04-14','Test transaction at office',2,12,200.00,2,1),(8,'2015-04-16','testDate',12,6,1.00,12,1),(9,'2015-04-18','testType 2',12,6,2.00,12,1),(10,'2015-04-18','testtype 3',12,6,15.00,12,2);
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Kevin','Glines',2,'$2a$10$nzwfh5e0oDtewwwfynqHKOBxZ8jEijrqS1eaVuuie62x4cgeZXPN.','kevinglines@mail.weber.edu',0),('Yong','Zhang',4,'$2a$10$0U2QzAiHofApEPHKXb3qU.WMrs2qS8yCfsEoRlUvKibPRkyHRyafa','yongzhang@weber.edu',0),('Tyler','Evans',12,'$2a$10$AwgpfisBtTaPGhQA5zA.l.VKTGZdf2hijEGyiypMc5f8laCixhHhK','tyler',1),('editHibernate','testHibernate',23,'$2a$10$bK7.syct87P.ifrBr6c0yOKABpvYbiJdQiayZcCX5cDjmS0N3xJXy','testHibernate',1);
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
INSERT INTO `user_permission` VALUES (12,1),(12,2),(23,2),(4,2),(2,2);
/*!40000 ALTER TABLE `user_permission` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40000 ALTER TABLE `balance` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping routines for database 'sfcbdb'
--

-- Dump completed on 2015-05-20 15:20:25
