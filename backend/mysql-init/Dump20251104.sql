-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: parenting_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES (1,'doctor1','$2b$10$4YGgqvdsp7yURYV7TAiJw.ns8LX.h2zNWJQvFb8hXdM6DLc/80b5.');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `time` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `booked_by` varchar(255) DEFAULT NULL,
  `payment_status` enum('pending','paid') DEFAULT 'pending',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `id` int NOT NULL AUTO_INCREMENT,
  `slot_id` int NOT NULL,
  `available_date` date NOT NULL,
  `is_booked` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `slot_id` (`slot_id`),
  CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`slot_id`) REFERENCES `slots` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `availability`
--

LOCK TABLES `availability` WRITE;
/*!40000 ALTER TABLE `availability` DISABLE KEYS */;
/*!40000 ALTER TABLE `availability` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `availability_id` int NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `payment_status` enum('pending','success','failed') DEFAULT 'pending',
  `meeting_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `availability_id` (`availability_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`availability_id`) REFERENCES `availability` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Dr. Meenakshi','doctor@example.com');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meetings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int DEFAULT NULL,
  `meeting_link` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `slot_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','completed','failed') DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `payment_provider` varchar(50) DEFAULT NULL,
  `provider_payment_id` varchar(255) DEFAULT NULL,
  `note` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,1,174,1500.00,'completed','2025-11-01 13:43:06',NULL,NULL,NULL,NULL),(2,1,184,4000.00,'completed','2025-11-01 13:45:03',NULL,NULL,NULL,NULL),(3,1,520,1500.00,'completed','2025-11-01 13:50:19',NULL,NULL,NULL,NULL),(4,1,178,1500.00,'completed','2025-11-01 14:05:36',NULL,NULL,NULL,NULL),(5,1,197,1500.00,'completed','2025-11-01 14:05:57',NULL,NULL,NULL,NULL),(6,1,230,4000.00,'completed','2025-11-01 14:06:29',NULL,NULL,NULL,NULL),(7,1,225,1500.00,'completed','2025-11-01 18:13:02',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_type` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_type` (`service_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'consultation','Consultation','One-on-one consultation with expert.',1500.00),(2,'consultation_assessment','Consultation + Assessment','Consultation plus detailed assessment',5000.00),(3,'parenting','Parenting Session','Guidance and strategies for your child.',4000.00);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slots`
--

DROP TABLE IF EXISTS `slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `slots` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `doctor_id` int NOT NULL DEFAULT '1',
  `slot_date` date NOT NULL DEFAULT '2025-10-26',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `service_type` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_booked` tinyint(1) DEFAULT '0',
  `is_closed` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `fk_slots_user` (`user_id`),
  CONSTRAINT `fk_slots_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `slots_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=726 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slots`
--

LOCK TABLES `slots` WRITE;
/*!40000 ALTER TABLE `slots` DISABLE KEYS */;
INSERT INTO `slots` VALUES (36,NULL,1,'2025-10-26','09:00:00','10:00:00','consultation',1500.00,0,0),(37,NULL,1,'2025-10-26','10:00:00','11:00:00','consultation',1500.00,0,0),(38,NULL,1,'2025-10-26','11:00:00','12:00:00','consultation',1500.00,0,0),(39,NULL,1,'2025-10-26','12:00:00','13:00:00','consultation',1500.00,0,0),(40,NULL,1,'2025-10-26','13:00:00','14:00:00','consultation',1500.00,0,0),(41,NULL,1,'2025-10-26','14:00:00','15:00:00','consultation',1500.00,0,0),(42,NULL,1,'2025-10-26','15:00:00','16:00:00','consultation',1500.00,0,0),(43,NULL,1,'2025-10-26','16:00:00','17:00:00','consultation',1500.00,0,0),(44,NULL,1,'2025-10-26','17:00:00','18:00:00','consultation',1500.00,0,0),(45,NULL,1,'2025-10-26','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(46,NULL,1,'2025-10-26','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(47,NULL,1,'2025-10-26','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(48,NULL,1,'2025-10-26','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(49,NULL,1,'2025-10-26','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(50,NULL,1,'2025-10-26','09:00:00','10:00:00','parenting',4000.00,0,0),(51,NULL,1,'2025-10-26','10:00:00','11:00:00','parenting',4000.00,0,0),(52,NULL,1,'2025-10-26','11:00:00','12:00:00','parenting',4000.00,0,0),(53,NULL,1,'2025-10-26','12:00:00','13:00:00','parenting',4000.00,0,0),(54,NULL,1,'2025-10-26','13:00:00','14:00:00','parenting',4000.00,0,0),(55,NULL,1,'2025-10-26','14:00:00','15:00:00','parenting',4000.00,0,0),(56,NULL,1,'2025-10-26','15:00:00','16:00:00','parenting',4000.00,0,0),(57,NULL,1,'2025-10-26','16:00:00','17:00:00','parenting',4000.00,0,0),(58,NULL,1,'2025-10-26','17:00:00','18:00:00','parenting',4000.00,0,0),(59,NULL,1,'2025-10-27','09:00:00','10:00:00','consultation',1500.00,0,1),(60,NULL,1,'2025-10-27','10:00:00','11:00:00','consultation',1500.00,0,0),(61,NULL,1,'2025-10-27','11:00:00','12:00:00','consultation',1500.00,0,0),(62,NULL,1,'2025-10-27','12:00:00','13:00:00','consultation',1500.00,0,0),(63,NULL,1,'2025-10-27','13:00:00','14:00:00','consultation',1500.00,0,0),(64,NULL,1,'2025-10-27','14:00:00','15:00:00','consultation',1500.00,0,0),(65,NULL,1,'2025-10-27','15:00:00','16:00:00','consultation',1500.00,0,0),(66,NULL,1,'2025-10-27','16:00:00','17:00:00','consultation',1500.00,0,0),(67,NULL,1,'2025-10-27','17:00:00','18:00:00','consultation',1500.00,0,0),(68,NULL,1,'2025-10-27','22:00:00','12:00:00','consultation_assessment',5000.00,0,0),(69,NULL,1,'2025-10-27','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(70,NULL,1,'2025-10-27','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(71,NULL,1,'2025-10-27','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(72,NULL,1,'2025-10-27','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(73,NULL,1,'2025-10-27','09:00:00','10:00:00','parenting',4000.00,0,0),(74,NULL,1,'2025-10-27','10:00:00','11:00:00','parenting',4000.00,0,0),(75,NULL,1,'2025-10-27','11:00:00','12:00:00','parenting',4000.00,0,0),(76,NULL,1,'2025-10-27','12:00:00','13:00:00','parenting',4000.00,0,0),(77,NULL,1,'2025-10-27','13:00:00','14:00:00','parenting',4000.00,0,0),(78,NULL,1,'2025-10-27','14:00:00','15:00:00','parenting',4000.00,0,0),(79,NULL,1,'2025-10-27','15:00:00','16:00:00','parenting',4000.00,0,0),(80,NULL,1,'2025-10-27','16:00:00','17:00:00','parenting',4000.00,0,0),(81,NULL,1,'2025-10-27','17:00:00','18:00:00','parenting',4000.00,0,0),(82,NULL,1,'2025-10-28','09:00:00','10:00:00','consultation',1500.00,0,0),(83,NULL,1,'2025-10-28','20:00:00','21:00:00','consultation',1500.00,0,0),(84,NULL,1,'2025-10-28','11:00:00','12:00:00','consultation',1500.00,0,0),(85,NULL,1,'2025-10-28','12:00:00','13:00:00','consultation',1500.00,0,0),(86,NULL,1,'2025-10-28','13:00:00','14:00:00','consultation',1500.00,0,0),(87,NULL,1,'2025-10-28','14:00:00','15:00:00','consultation',1500.00,0,0),(88,NULL,1,'2025-10-28','15:00:00','16:00:00','consultation',1500.00,0,0),(89,NULL,1,'2025-10-28','16:00:00','17:00:00','consultation',1500.00,0,0),(90,NULL,1,'2025-10-28','17:00:00','18:00:00','consultation',1500.00,0,0),(91,NULL,1,'2025-10-28','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(92,NULL,1,'2025-10-28','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(93,NULL,1,'2025-10-28','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(94,NULL,1,'2025-10-28','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(95,NULL,1,'2025-10-28','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(96,NULL,1,'2025-10-28','09:00:00','10:00:00','parenting',4000.00,0,0),(97,NULL,1,'2025-10-28','10:00:00','11:00:00','parenting',4000.00,0,0),(98,NULL,1,'2025-10-28','11:00:00','12:00:00','parenting',4000.00,0,0),(99,NULL,1,'2025-10-28','12:00:00','13:00:00','parenting',4000.00,0,0),(100,NULL,1,'2025-10-28','13:00:00','14:00:00','parenting',4000.00,0,0),(101,NULL,1,'2025-10-28','14:00:00','15:00:00','parenting',4000.00,0,0),(102,NULL,1,'2025-10-28','15:00:00','16:00:00','parenting',4000.00,0,0),(103,NULL,1,'2025-10-28','16:00:00','17:00:00','parenting',4000.00,0,0),(104,NULL,1,'2025-10-28','17:00:00','18:00:00','parenting',4000.00,0,0),(105,NULL,1,'2025-10-29','09:00:00','10:00:00','consultation',1500.00,0,0),(106,NULL,1,'2025-10-29','10:00:00','11:00:00','consultation',1500.00,0,0),(107,NULL,1,'2025-10-29','11:00:00','12:00:00','consultation',1500.00,0,0),(108,NULL,1,'2025-10-29','12:00:00','13:00:00','consultation',1500.00,0,0),(109,NULL,1,'2025-10-29','13:00:00','14:00:00','consultation',1500.00,0,0),(110,NULL,1,'2025-10-29','14:00:00','15:00:00','consultation',1500.00,0,0),(111,NULL,1,'2025-10-29','15:00:00','16:00:00','consultation',1500.00,0,0),(112,NULL,1,'2025-10-29','16:00:00','17:00:00','consultation',1500.00,0,0),(113,NULL,1,'2025-10-29','17:00:00','18:00:00','consultation',1500.00,0,0),(114,NULL,1,'2025-10-29','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(115,NULL,1,'2025-10-29','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(116,NULL,1,'2025-10-29','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(117,NULL,1,'2025-10-29','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(118,NULL,1,'2025-10-29','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(119,NULL,1,'2025-10-29','09:00:00','10:00:00','parenting',4000.00,0,0),(120,NULL,1,'2025-10-29','10:00:00','11:00:00','parenting',4000.00,0,0),(121,NULL,1,'2025-10-29','11:00:00','12:00:00','parenting',4000.00,0,0),(122,NULL,1,'2025-10-29','12:00:00','13:00:00','parenting',4000.00,0,0),(123,NULL,1,'2025-10-29','13:00:00','14:00:00','parenting',4000.00,0,0),(124,NULL,1,'2025-10-29','14:00:00','15:00:00','parenting',4000.00,0,0),(125,NULL,1,'2025-10-29','15:00:00','16:00:00','parenting',4000.00,0,0),(126,NULL,1,'2025-10-29','16:00:00','17:00:00','parenting',4000.00,0,0),(127,NULL,1,'2025-10-29','17:00:00','18:00:00','parenting',4000.00,0,0),(128,NULL,1,'2025-10-30','09:00:00','10:00:00','consultation',1500.00,0,0),(129,NULL,1,'2025-10-30','10:00:00','11:00:00','consultation',1500.00,0,0),(130,NULL,1,'2025-10-30','11:00:00','12:00:00','consultation',1500.00,0,0),(131,NULL,1,'2025-10-30','12:00:00','13:00:00','consultation',1500.00,0,0),(132,NULL,1,'2025-10-30','13:00:00','14:00:00','consultation',1500.00,0,0),(133,NULL,1,'2025-10-30','14:00:00','15:00:00','consultation',1500.00,0,0),(134,NULL,1,'2025-10-30','15:00:00','16:00:00','consultation',1500.00,0,0),(135,NULL,1,'2025-10-30','16:00:00','17:00:00','consultation',1500.00,0,0),(136,NULL,1,'2025-10-30','17:00:00','18:00:00','consultation',1500.00,0,0),(137,NULL,1,'2025-10-30','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(138,NULL,1,'2025-10-30','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(139,NULL,1,'2025-10-30','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(140,NULL,1,'2025-10-30','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(141,NULL,1,'2025-10-30','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(142,NULL,1,'2025-10-30','09:00:00','10:00:00','parenting',4000.00,0,0),(143,NULL,1,'2025-10-30','10:00:00','11:00:00','parenting',4000.00,0,0),(144,NULL,1,'2025-10-30','11:00:00','12:00:00','parenting',4000.00,0,0),(145,NULL,1,'2025-10-30','12:00:00','13:00:00','parenting',4000.00,0,0),(146,NULL,1,'2025-10-30','13:00:00','14:00:00','parenting',4000.00,0,0),(147,NULL,1,'2025-10-30','14:00:00','15:00:00','parenting',4000.00,0,0),(148,NULL,1,'2025-10-30','15:00:00','16:00:00','parenting',4000.00,0,0),(149,NULL,1,'2025-10-30','16:00:00','17:00:00','parenting',4000.00,0,0),(150,NULL,1,'2025-10-30','17:00:00','18:00:00','parenting',4000.00,0,0),(151,NULL,1,'2025-10-31','09:00:00','10:00:00','consultation',1500.00,0,0),(152,NULL,1,'2025-10-31','10:00:00','11:00:00','consultation',1500.00,0,0),(153,NULL,1,'2025-10-31','11:00:00','12:00:00','consultation',1500.00,0,0),(154,NULL,1,'2025-10-31','12:00:00','13:00:00','consultation',1500.00,0,0),(155,NULL,1,'2025-10-31','13:00:00','14:00:00','consultation',1500.00,0,0),(156,NULL,1,'2025-10-31','14:00:00','15:00:00','consultation',1500.00,0,0),(157,NULL,1,'2025-10-31','15:00:00','16:00:00','consultation',1500.00,0,0),(158,NULL,1,'2025-10-31','16:00:00','17:00:00','consultation',1500.00,0,0),(159,NULL,1,'2025-10-31','17:00:00','18:00:00','consultation',1500.00,0,0),(160,NULL,1,'2025-10-31','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(161,NULL,1,'2025-10-31','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(162,NULL,1,'2025-10-31','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(163,NULL,1,'2025-10-31','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(164,NULL,1,'2025-10-31','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(165,NULL,1,'2025-10-31','09:00:00','10:00:00','parenting',4000.00,0,0),(166,NULL,1,'2025-10-31','10:00:00','11:00:00','parenting',4000.00,0,0),(167,NULL,1,'2025-10-31','11:00:00','12:00:00','parenting',4000.00,0,0),(168,NULL,1,'2025-10-31','12:00:00','13:00:00','parenting',4000.00,0,0),(169,NULL,1,'2025-10-31','13:00:00','14:00:00','parenting',4000.00,0,0),(170,NULL,1,'2025-10-31','14:00:00','15:00:00','parenting',4000.00,0,0),(171,NULL,1,'2025-10-31','15:00:00','16:00:00','parenting',4000.00,0,0),(172,NULL,1,'2025-10-31','16:00:00','17:00:00','parenting',4000.00,0,0),(173,NULL,1,'2025-10-31','17:00:00','18:00:00','parenting',4000.00,0,0),(174,NULL,1,'2025-11-01','09:00:00','10:00:00','consultation',1500.00,1,0),(175,NULL,1,'2025-11-01','10:00:00','11:00:00','consultation',1500.00,0,0),(176,NULL,1,'2025-11-01','11:00:00','12:00:00','consultation',1500.00,0,0),(177,NULL,1,'2025-11-01','12:00:00','13:00:00','consultation',1500.00,0,0),(178,NULL,1,'2025-11-01','13:00:00','14:00:00','consultation',1500.00,1,0),(179,NULL,1,'2025-11-01','14:00:00','15:00:00','consultation',1500.00,0,0),(180,NULL,1,'2025-11-01','15:00:00','16:00:00','consultation',1500.00,0,0),(181,NULL,1,'2025-11-01','16:00:00','17:00:00','consultation',1500.00,0,0),(182,NULL,1,'2025-11-01','17:00:00','18:00:00','consultation',1500.00,0,0),(183,NULL,1,'2025-11-01','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(184,NULL,1,'2025-11-01','11:00:00','13:00:00','consultation_assessment',5000.00,1,0),(185,NULL,1,'2025-11-01','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(186,NULL,1,'2025-11-01','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(187,NULL,1,'2025-11-01','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(188,NULL,1,'2025-11-01','09:00:00','10:00:00','parenting',4000.00,0,0),(189,NULL,1,'2025-11-01','10:00:00','11:00:00','parenting',4000.00,0,0),(190,NULL,1,'2025-11-01','11:00:00','12:00:00','parenting',4000.00,0,0),(191,NULL,1,'2025-11-01','12:00:00','13:00:00','parenting',4000.00,0,0),(192,NULL,1,'2025-11-01','13:00:00','14:00:00','parenting',4000.00,0,0),(193,NULL,1,'2025-11-01','14:00:00','15:00:00','parenting',4000.00,0,0),(194,NULL,1,'2025-11-01','15:00:00','16:00:00','parenting',4000.00,0,0),(195,NULL,1,'2025-11-01','16:00:00','17:00:00','parenting',4000.00,0,0),(196,NULL,1,'2025-11-01','17:00:00','18:00:00','parenting',4000.00,0,0),(197,NULL,1,'2025-11-02','09:00:00','10:00:00','consultation',1500.00,1,0),(198,NULL,1,'2025-11-02','10:00:00','11:00:00','consultation',1500.00,0,0),(199,NULL,1,'2025-11-02','11:00:00','12:00:00','consultation',1500.00,0,0),(200,NULL,1,'2025-11-02','12:00:00','13:00:00','consultation',1500.00,0,0),(201,NULL,1,'2025-11-02','13:00:00','14:00:00','consultation',1500.00,0,0),(202,NULL,1,'2025-11-02','14:00:00','15:00:00','consultation',1500.00,0,0),(203,NULL,1,'2025-11-02','15:00:00','16:00:00','consultation',1500.00,0,0),(204,NULL,1,'2025-11-02','16:00:00','17:00:00','consultation',1500.00,0,0),(205,NULL,1,'2025-11-02','17:00:00','18:00:00','consultation',1500.00,0,0),(206,NULL,1,'2025-11-02','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(207,NULL,1,'2025-11-02','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(208,NULL,1,'2025-11-02','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(209,NULL,1,'2025-11-02','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(210,NULL,1,'2025-11-02','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(211,NULL,1,'2025-11-02','09:00:00','10:00:00','parenting',4000.00,0,0),(212,NULL,1,'2025-11-02','10:00:00','11:00:00','parenting',4000.00,0,0),(213,NULL,1,'2025-11-02','11:00:00','12:00:00','parenting',4000.00,0,0),(214,NULL,1,'2025-11-02','12:00:00','13:00:00','parenting',4000.00,0,0),(215,NULL,1,'2025-11-02','13:00:00','14:00:00','parenting',4000.00,0,0),(216,NULL,1,'2025-11-02','14:00:00','15:00:00','parenting',4000.00,0,0),(217,NULL,1,'2025-11-02','15:00:00','16:00:00','parenting',4000.00,0,0),(218,NULL,1,'2025-11-02','16:00:00','17:00:00','parenting',4000.00,0,0),(219,NULL,1,'2025-11-02','17:00:00','18:00:00','parenting',4000.00,0,0),(220,NULL,1,'2025-11-03','09:00:00','10:00:00','consultation',1500.00,0,0),(221,NULL,1,'2025-11-03','10:00:00','11:00:00','consultation',1500.00,0,0),(222,NULL,1,'2025-11-03','11:00:00','12:00:00','consultation',1500.00,0,0),(223,NULL,1,'2025-11-03','12:00:00','13:00:00','consultation',1500.00,0,0),(224,NULL,1,'2025-11-03','13:00:00','14:00:00','consultation',1500.00,0,0),(225,NULL,1,'2025-11-03','14:00:00','15:00:00','consultation',1500.00,1,0),(226,NULL,1,'2025-11-03','15:00:00','16:00:00','consultation',1500.00,0,0),(227,NULL,1,'2025-11-03','16:00:00','17:00:00','consultation',1500.00,0,0),(228,NULL,1,'2025-11-03','17:00:00','18:00:00','consultation',1500.00,0,0),(229,NULL,1,'2025-11-03','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(230,NULL,1,'2025-11-03','11:00:00','13:00:00','consultation_assessment',5000.00,1,0),(231,NULL,1,'2025-11-03','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(232,NULL,1,'2025-11-03','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(233,NULL,1,'2025-11-03','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(234,NULL,1,'2025-11-03','09:00:00','10:00:00','parenting',4000.00,0,0),(235,NULL,1,'2025-11-03','10:00:00','11:00:00','parenting',4000.00,0,0),(236,NULL,1,'2025-11-03','11:00:00','12:00:00','parenting',4000.00,0,0),(237,NULL,1,'2025-11-03','12:00:00','13:00:00','parenting',4000.00,0,0),(238,NULL,1,'2025-11-03','13:00:00','14:00:00','parenting',4000.00,0,0),(239,NULL,1,'2025-11-03','14:00:00','15:00:00','parenting',4000.00,0,0),(240,NULL,1,'2025-11-03','15:00:00','16:00:00','parenting',4000.00,0,0),(241,NULL,1,'2025-11-03','16:00:00','17:00:00','parenting',4000.00,0,0),(242,NULL,1,'2025-11-03','17:00:00','18:00:00','parenting',4000.00,0,0),(243,NULL,1,'2025-11-04','09:00:00','10:00:00','consultation',1500.00,0,0),(244,NULL,1,'2025-11-04','10:00:00','11:00:00','consultation',1500.00,0,0),(245,NULL,1,'2025-11-04','11:00:00','12:00:00','consultation',1500.00,0,0),(246,NULL,1,'2025-11-04','12:00:00','13:00:00','consultation',1500.00,0,0),(247,NULL,1,'2025-11-04','13:00:00','14:00:00','consultation',1500.00,0,0),(248,NULL,1,'2025-11-04','14:00:00','15:00:00','consultation',1500.00,0,0),(249,NULL,1,'2025-11-04','15:00:00','16:00:00','consultation',1500.00,0,0),(250,NULL,1,'2025-11-04','16:00:00','17:00:00','consultation',1500.00,0,0),(251,NULL,1,'2025-11-04','17:00:00','18:00:00','consultation',1500.00,0,0),(252,NULL,1,'2025-11-04','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(253,NULL,1,'2025-11-04','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(254,NULL,1,'2025-11-04','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(255,NULL,1,'2025-11-04','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(256,NULL,1,'2025-11-04','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(257,NULL,1,'2025-11-04','09:00:00','10:00:00','parenting',4000.00,0,0),(258,NULL,1,'2025-11-04','10:00:00','11:00:00','parenting',4000.00,0,0),(259,NULL,1,'2025-11-04','11:00:00','12:00:00','parenting',4000.00,0,0),(260,NULL,1,'2025-11-04','12:00:00','13:00:00','parenting',4000.00,0,0),(261,NULL,1,'2025-11-04','13:00:00','14:00:00','parenting',4000.00,0,0),(262,NULL,1,'2025-11-04','14:00:00','15:00:00','parenting',4000.00,0,0),(263,NULL,1,'2025-11-04','15:00:00','16:00:00','parenting',4000.00,0,0),(264,NULL,1,'2025-11-04','16:00:00','17:00:00','parenting',4000.00,0,0),(265,NULL,1,'2025-11-04','17:00:00','18:00:00','parenting',4000.00,0,0),(266,NULL,1,'2025-11-05','09:00:00','10:00:00','consultation',1500.00,0,0),(267,NULL,1,'2025-11-05','10:00:00','11:00:00','consultation',1500.00,0,0),(268,NULL,1,'2025-11-05','11:00:00','12:00:00','consultation',1500.00,0,0),(269,NULL,1,'2025-11-05','12:00:00','13:00:00','consultation',1500.00,0,0),(270,NULL,1,'2025-11-05','13:00:00','14:00:00','consultation',1500.00,0,0),(271,NULL,1,'2025-11-05','14:00:00','15:00:00','consultation',1500.00,0,0),(272,NULL,1,'2025-11-05','15:00:00','16:00:00','consultation',1500.00,0,0),(273,NULL,1,'2025-11-05','16:00:00','17:00:00','consultation',1500.00,0,0),(274,NULL,1,'2025-11-05','17:00:00','18:00:00','consultation',1500.00,0,0),(275,NULL,1,'2025-11-05','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(276,NULL,1,'2025-11-05','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(277,NULL,1,'2025-11-05','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(278,NULL,1,'2025-11-05','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(279,NULL,1,'2025-11-05','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(280,NULL,1,'2025-11-05','09:00:00','10:00:00','parenting',4000.00,0,0),(281,NULL,1,'2025-11-05','10:00:00','11:00:00','parenting',4000.00,0,0),(282,NULL,1,'2025-11-05','11:00:00','12:00:00','parenting',4000.00,0,0),(283,NULL,1,'2025-11-05','12:00:00','13:00:00','parenting',4000.00,0,0),(284,NULL,1,'2025-11-05','13:00:00','14:00:00','parenting',4000.00,0,0),(285,NULL,1,'2025-11-05','14:00:00','15:00:00','parenting',4000.00,0,0),(286,NULL,1,'2025-11-05','15:00:00','16:00:00','parenting',4000.00,0,0),(287,NULL,1,'2025-11-05','16:00:00','17:00:00','parenting',4000.00,0,0),(288,NULL,1,'2025-11-05','17:00:00','18:00:00','parenting',4000.00,0,0),(289,NULL,1,'2025-11-06','09:00:00','10:00:00','consultation',1500.00,0,0),(290,NULL,1,'2025-11-06','10:00:00','11:00:00','consultation',1500.00,0,0),(291,NULL,1,'2025-11-06','11:00:00','12:00:00','consultation',1500.00,0,0),(292,NULL,1,'2025-11-06','12:00:00','13:00:00','consultation',1500.00,0,0),(293,NULL,1,'2025-11-06','13:00:00','14:00:00','consultation',1500.00,0,0),(294,NULL,1,'2025-11-06','14:00:00','15:00:00','consultation',1500.00,0,0),(295,NULL,1,'2025-11-06','15:00:00','16:00:00','consultation',1500.00,0,0),(296,NULL,1,'2025-11-06','16:00:00','17:00:00','consultation',1500.00,0,0),(297,NULL,1,'2025-11-06','17:00:00','18:00:00','consultation',1500.00,0,0),(298,NULL,1,'2025-11-06','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(299,NULL,1,'2025-11-06','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(300,NULL,1,'2025-11-06','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(301,NULL,1,'2025-11-06','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(302,NULL,1,'2025-11-06','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(303,NULL,1,'2025-11-06','09:00:00','10:00:00','parenting',4000.00,0,0),(304,NULL,1,'2025-11-06','10:00:00','11:00:00','parenting',4000.00,0,0),(305,NULL,1,'2025-11-06','11:00:00','12:00:00','parenting',4000.00,0,0),(306,NULL,1,'2025-11-06','12:00:00','13:00:00','parenting',4000.00,0,0),(307,NULL,1,'2025-11-06','13:00:00','14:00:00','parenting',4000.00,0,0),(308,NULL,1,'2025-11-06','14:00:00','15:00:00','parenting',4000.00,0,0),(309,NULL,1,'2025-11-06','15:00:00','16:00:00','parenting',4000.00,0,0),(310,NULL,1,'2025-11-06','16:00:00','17:00:00','parenting',4000.00,0,0),(311,NULL,1,'2025-11-06','17:00:00','18:00:00','parenting',4000.00,0,0),(312,NULL,1,'2025-11-07','09:00:00','10:00:00','consultation',1500.00,0,0),(313,NULL,1,'2025-11-07','10:00:00','11:00:00','consultation',1500.00,0,0),(314,NULL,1,'2025-11-07','11:00:00','12:00:00','consultation',1500.00,0,0),(315,NULL,1,'2025-11-07','12:00:00','13:00:00','consultation',1500.00,0,0),(316,NULL,1,'2025-11-07','13:00:00','14:00:00','consultation',1500.00,0,0),(317,NULL,1,'2025-11-07','14:00:00','15:00:00','consultation',1500.00,0,0),(318,NULL,1,'2025-11-07','15:00:00','16:00:00','consultation',1500.00,0,0),(319,NULL,1,'2025-11-07','16:00:00','17:00:00','consultation',1500.00,0,0),(320,NULL,1,'2025-11-07','17:00:00','18:00:00','consultation',1500.00,0,0),(321,NULL,1,'2025-11-07','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(322,NULL,1,'2025-11-07','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(323,NULL,1,'2025-11-07','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(324,NULL,1,'2025-11-07','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(325,NULL,1,'2025-11-07','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(326,NULL,1,'2025-11-07','09:00:00','10:00:00','parenting',4000.00,0,0),(327,NULL,1,'2025-11-07','10:00:00','11:00:00','parenting',4000.00,0,0),(328,NULL,1,'2025-11-07','11:00:00','12:00:00','parenting',4000.00,0,0),(329,NULL,1,'2025-11-07','12:00:00','13:00:00','parenting',4000.00,0,0),(330,NULL,1,'2025-11-07','13:00:00','14:00:00','parenting',4000.00,0,0),(331,NULL,1,'2025-11-07','14:00:00','15:00:00','parenting',4000.00,0,0),(332,NULL,1,'2025-11-07','15:00:00','16:00:00','parenting',4000.00,0,0),(333,NULL,1,'2025-11-07','16:00:00','17:00:00','parenting',4000.00,0,0),(334,NULL,1,'2025-11-07','17:00:00','18:00:00','parenting',4000.00,0,0),(335,NULL,1,'2025-11-08','09:00:00','10:00:00','consultation',1500.00,0,0),(336,NULL,1,'2025-11-08','10:00:00','11:00:00','consultation',1500.00,0,0),(337,NULL,1,'2025-11-08','11:00:00','12:00:00','consultation',1500.00,0,0),(338,NULL,1,'2025-11-08','12:00:00','13:00:00','consultation',1500.00,0,0),(339,NULL,1,'2025-11-08','13:00:00','14:00:00','consultation',1500.00,0,0),(340,NULL,1,'2025-11-08','14:00:00','15:00:00','consultation',1500.00,0,0),(341,NULL,1,'2025-11-08','15:00:00','16:00:00','consultation',1500.00,0,0),(342,NULL,1,'2025-11-08','16:00:00','17:00:00','consultation',1500.00,0,0),(343,NULL,1,'2025-11-08','17:00:00','18:00:00','consultation',1500.00,0,0),(344,NULL,1,'2025-11-08','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(345,NULL,1,'2025-11-08','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(346,NULL,1,'2025-11-08','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(347,NULL,1,'2025-11-08','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(348,NULL,1,'2025-11-08','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(349,NULL,1,'2025-11-08','09:00:00','10:00:00','parenting',4000.00,0,0),(350,NULL,1,'2025-11-08','10:00:00','11:00:00','parenting',4000.00,0,0),(351,NULL,1,'2025-11-08','11:00:00','12:00:00','parenting',4000.00,0,0),(352,NULL,1,'2025-11-08','12:00:00','13:00:00','parenting',4000.00,0,0),(353,NULL,1,'2025-11-08','13:00:00','14:00:00','parenting',4000.00,0,0),(354,NULL,1,'2025-11-08','14:00:00','15:00:00','parenting',4000.00,0,0),(355,NULL,1,'2025-11-08','15:00:00','16:00:00','parenting',4000.00,0,0),(356,NULL,1,'2025-11-08','16:00:00','17:00:00','parenting',4000.00,0,0),(357,NULL,1,'2025-11-08','17:00:00','18:00:00','parenting',4000.00,0,0),(358,NULL,1,'2025-11-09','09:00:00','10:00:00','consultation',1500.00,0,0),(359,NULL,1,'2025-11-09','10:00:00','11:00:00','consultation',1500.00,0,0),(360,NULL,1,'2025-11-09','11:00:00','12:00:00','consultation',1500.00,0,0),(361,NULL,1,'2025-11-09','12:00:00','13:00:00','consultation',1500.00,0,0),(362,NULL,1,'2025-11-09','13:00:00','14:00:00','consultation',1500.00,0,0),(363,NULL,1,'2025-11-09','14:00:00','15:00:00','consultation',1500.00,0,0),(364,NULL,1,'2025-11-09','15:00:00','16:00:00','consultation',1500.00,0,0),(365,NULL,1,'2025-11-09','16:00:00','17:00:00','consultation',1500.00,0,0),(366,NULL,1,'2025-11-09','17:00:00','18:00:00','consultation',1500.00,0,0),(367,NULL,1,'2025-11-09','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(368,NULL,1,'2025-11-09','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(369,NULL,1,'2025-11-09','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(370,NULL,1,'2025-11-09','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(371,NULL,1,'2025-11-09','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(372,NULL,1,'2025-11-09','09:00:00','10:00:00','parenting',4000.00,0,0),(373,NULL,1,'2025-11-09','10:00:00','11:00:00','parenting',4000.00,0,0),(374,NULL,1,'2025-11-09','11:00:00','12:00:00','parenting',4000.00,0,0),(375,NULL,1,'2025-11-09','12:00:00','13:00:00','parenting',4000.00,0,0),(376,NULL,1,'2025-11-09','13:00:00','14:00:00','parenting',4000.00,0,0),(377,NULL,1,'2025-11-09','14:00:00','15:00:00','parenting',4000.00,0,0),(378,NULL,1,'2025-11-09','15:00:00','16:00:00','parenting',4000.00,0,0),(379,NULL,1,'2025-11-09','16:00:00','17:00:00','parenting',4000.00,0,0),(380,NULL,1,'2025-11-09','17:00:00','18:00:00','parenting',4000.00,0,0),(381,NULL,1,'2025-10-26','09:00:00','10:00:00','consultation',1500.00,0,0),(382,NULL,1,'2025-10-26','10:00:00','11:00:00','consultation',1500.00,0,0),(383,NULL,1,'2025-10-26','11:00:00','12:00:00','consultation',1500.00,0,0),(384,NULL,1,'2025-10-26','12:00:00','13:00:00','consultation',1500.00,0,0),(385,NULL,1,'2025-10-26','13:00:00','14:00:00','consultation',1500.00,0,0),(386,NULL,1,'2025-10-26','14:00:00','15:00:00','consultation',1500.00,0,0),(387,NULL,1,'2025-10-26','15:00:00','16:00:00','consultation',1500.00,0,0),(388,NULL,1,'2025-10-26','16:00:00','17:00:00','consultation',1500.00,0,0),(389,NULL,1,'2025-10-26','17:00:00','18:00:00','consultation',1500.00,0,0),(390,NULL,1,'2025-10-26','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(391,NULL,1,'2025-10-26','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(392,NULL,1,'2025-10-26','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(393,NULL,1,'2025-10-26','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(394,NULL,1,'2025-10-26','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(395,NULL,1,'2025-10-26','09:00:00','10:00:00','parenting',4000.00,0,0),(396,NULL,1,'2025-10-26','10:00:00','11:00:00','parenting',4000.00,0,0),(397,NULL,1,'2025-10-26','11:00:00','12:00:00','parenting',4000.00,0,0),(398,NULL,1,'2025-10-26','12:00:00','13:00:00','parenting',4000.00,0,0),(399,NULL,1,'2025-10-26','13:00:00','14:00:00','parenting',4000.00,0,0),(400,NULL,1,'2025-10-26','14:00:00','15:00:00','parenting',4000.00,0,0),(401,NULL,1,'2025-10-26','15:00:00','16:00:00','parenting',4000.00,0,0),(402,NULL,1,'2025-10-26','16:00:00','17:00:00','parenting',4000.00,0,0),(403,NULL,1,'2025-10-26','17:00:00','18:00:00','parenting',4000.00,0,0),(404,NULL,1,'2025-10-27','09:00:00','10:00:00','consultation',1500.00,0,0),(405,NULL,1,'2025-10-27','10:00:00','11:00:00','consultation',1500.00,0,0),(406,NULL,1,'2025-10-27','11:00:00','12:00:00','consultation',1500.00,0,0),(407,NULL,1,'2025-10-27','12:00:00','13:00:00','consultation',1500.00,0,0),(408,NULL,1,'2025-10-27','13:00:00','14:00:00','consultation',1500.00,0,0),(409,NULL,1,'2025-10-27','14:00:00','15:00:00','consultation',1500.00,0,0),(410,NULL,1,'2025-10-27','15:00:00','16:00:00','consultation',1500.00,0,0),(411,NULL,1,'2025-10-27','16:00:00','17:00:00','consultation',1500.00,0,0),(412,NULL,1,'2025-10-27','17:00:00','18:00:00','consultation',1500.00,0,0),(413,NULL,1,'2025-10-27','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(414,NULL,1,'2025-10-27','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(415,NULL,1,'2025-10-27','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(416,NULL,1,'2025-10-27','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(417,NULL,1,'2025-10-27','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(418,NULL,1,'2025-10-27','09:00:00','10:00:00','parenting',4000.00,0,0),(419,NULL,1,'2025-10-27','10:00:00','11:00:00','parenting',4000.00,0,0),(420,NULL,1,'2025-10-27','11:00:00','12:00:00','parenting',4000.00,0,0),(421,NULL,1,'2025-10-27','12:00:00','13:00:00','parenting',4000.00,0,0),(422,NULL,1,'2025-10-27','13:00:00','14:00:00','parenting',4000.00,0,0),(423,NULL,1,'2025-10-27','14:00:00','15:00:00','parenting',4000.00,0,0),(424,NULL,1,'2025-10-27','15:00:00','16:00:00','parenting',4000.00,0,0),(425,NULL,1,'2025-10-27','16:00:00','17:00:00','parenting',4000.00,0,0),(426,NULL,1,'2025-10-27','17:00:00','18:00:00','parenting',4000.00,0,0),(427,NULL,1,'2025-10-28','09:00:00','10:00:00','consultation',1500.00,0,0),(428,NULL,1,'2025-10-28','10:00:00','11:00:00','consultation',1500.00,0,0),(429,NULL,1,'2025-10-28','11:00:00','12:00:00','consultation',1500.00,0,0),(430,NULL,1,'2025-10-28','12:00:00','13:00:00','consultation',1500.00,0,0),(431,NULL,1,'2025-10-28','13:00:00','14:00:00','consultation',1500.00,0,0),(432,NULL,1,'2025-10-28','14:00:00','15:00:00','consultation',1500.00,0,0),(433,NULL,1,'2025-10-28','15:00:00','16:00:00','consultation',1500.00,0,0),(434,NULL,1,'2025-10-28','16:00:00','17:00:00','consultation',1500.00,0,0),(435,NULL,1,'2025-10-28','17:00:00','18:00:00','consultation',1500.00,0,0),(436,NULL,1,'2025-10-28','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(437,NULL,1,'2025-10-28','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(438,NULL,1,'2025-10-28','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(439,NULL,1,'2025-10-28','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(440,NULL,1,'2025-10-28','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(441,NULL,1,'2025-10-28','09:00:00','10:00:00','parenting',4000.00,0,1),(442,NULL,1,'2025-10-28','10:00:00','11:00:00','parenting',4000.00,0,0),(443,NULL,1,'2025-10-28','11:00:00','12:00:00','parenting',4000.00,0,0),(444,NULL,1,'2025-10-28','12:00:00','13:00:00','parenting',4000.00,0,0),(445,NULL,1,'2025-10-28','13:00:00','14:00:00','parenting',4000.00,0,0),(446,NULL,1,'2025-10-28','14:00:00','15:00:00','parenting',4000.00,0,0),(447,NULL,1,'2025-10-28','15:00:00','16:00:00','parenting',4000.00,0,0),(448,NULL,1,'2025-10-28','16:00:00','17:00:00','parenting',4000.00,0,0),(449,NULL,1,'2025-10-28','17:00:00','18:00:00','parenting',4000.00,0,0),(450,NULL,1,'2025-10-29','09:00:00','10:00:00','consultation',1500.00,0,0),(451,NULL,1,'2025-10-29','10:00:00','11:00:00','consultation',1500.00,0,0),(452,NULL,1,'2025-10-29','11:00:00','12:00:00','consultation',1500.00,0,0),(453,NULL,1,'2025-10-29','12:00:00','13:00:00','consultation',1500.00,0,0),(454,NULL,1,'2025-10-29','13:00:00','14:00:00','consultation',1500.00,0,0),(455,NULL,1,'2025-10-29','14:00:00','15:00:00','consultation',1500.00,0,0),(456,NULL,1,'2025-10-29','15:00:00','16:00:00','consultation',1500.00,0,0),(457,NULL,1,'2025-10-29','16:00:00','17:00:00','consultation',1500.00,0,0),(458,NULL,1,'2025-10-29','17:00:00','18:00:00','consultation',1500.00,0,0),(459,NULL,1,'2025-10-29','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(460,NULL,1,'2025-10-29','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(461,NULL,1,'2025-10-29','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(462,NULL,1,'2025-10-29','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(463,NULL,1,'2025-10-29','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(464,NULL,1,'2025-10-29','09:00:00','10:00:00','parenting',4000.00,0,0),(465,NULL,1,'2025-10-29','10:00:00','11:00:00','parenting',4000.00,0,0),(466,NULL,1,'2025-10-29','11:00:00','12:00:00','parenting',4000.00,0,0),(467,NULL,1,'2025-10-29','12:00:00','13:00:00','parenting',4000.00,0,0),(468,NULL,1,'2025-10-29','13:00:00','14:00:00','parenting',4000.00,0,0),(469,NULL,1,'2025-10-29','14:00:00','15:00:00','parenting',4000.00,0,0),(470,NULL,1,'2025-10-29','15:00:00','16:00:00','parenting',4000.00,0,0),(471,NULL,1,'2025-10-29','16:00:00','17:00:00','parenting',4000.00,0,0),(472,NULL,1,'2025-10-29','17:00:00','18:00:00','parenting',4000.00,0,0),(473,NULL,1,'2025-10-30','09:00:00','10:00:00','consultation',1500.00,0,0),(474,NULL,1,'2025-10-30','10:00:00','11:00:00','consultation',1500.00,0,0),(475,NULL,1,'2025-10-30','11:00:00','12:00:00','consultation',1500.00,0,0),(476,NULL,1,'2025-10-30','12:00:00','13:00:00','consultation',1500.00,0,0),(477,NULL,1,'2025-10-30','13:00:00','14:00:00','consultation',1500.00,0,0),(478,NULL,1,'2025-10-30','14:00:00','15:00:00','consultation',1500.00,0,0),(479,NULL,1,'2025-10-30','15:00:00','16:00:00','consultation',1500.00,0,0),(480,NULL,1,'2025-10-30','16:00:00','17:00:00','consultation',1500.00,0,0),(481,NULL,1,'2025-10-30','17:00:00','18:00:00','consultation',1500.00,0,0),(482,NULL,1,'2025-10-30','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(483,NULL,1,'2025-10-30','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(484,NULL,1,'2025-10-30','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(485,NULL,1,'2025-10-30','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(486,NULL,1,'2025-10-30','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(487,NULL,1,'2025-10-30','09:00:00','10:00:00','parenting',4000.00,0,0),(488,NULL,1,'2025-10-30','10:00:00','11:00:00','parenting',4000.00,0,0),(489,NULL,1,'2025-10-30','11:00:00','12:00:00','parenting',4000.00,0,0),(490,NULL,1,'2025-10-30','12:00:00','13:00:00','parenting',4000.00,0,0),(491,NULL,1,'2025-10-30','13:00:00','14:00:00','parenting',4000.00,0,0),(492,NULL,1,'2025-10-30','14:00:00','15:00:00','parenting',4000.00,0,0),(493,NULL,1,'2025-10-30','15:00:00','16:00:00','parenting',4000.00,0,0),(494,NULL,1,'2025-10-30','16:00:00','17:00:00','parenting',4000.00,0,0),(495,NULL,1,'2025-10-30','17:00:00','18:00:00','parenting',4000.00,0,0),(496,NULL,1,'2025-10-31','09:00:00','10:00:00','consultation',1500.00,0,0),(497,NULL,1,'2025-10-31','10:00:00','11:00:00','consultation',1500.00,0,0),(498,NULL,1,'2025-10-31','11:00:00','12:00:00','consultation',1500.00,0,0),(499,NULL,1,'2025-10-31','12:00:00','13:00:00','consultation',1500.00,0,0),(500,NULL,1,'2025-10-31','13:00:00','14:00:00','consultation',1500.00,0,0),(501,NULL,1,'2025-10-31','14:00:00','15:00:00','consultation',1500.00,0,0),(502,NULL,1,'2025-10-31','15:00:00','16:00:00','consultation',1500.00,0,0),(503,NULL,1,'2025-10-31','16:00:00','17:00:00','consultation',1500.00,0,0),(504,NULL,1,'2025-10-31','17:00:00','18:00:00','consultation',1500.00,0,0),(505,NULL,1,'2025-10-31','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(506,NULL,1,'2025-10-31','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(507,NULL,1,'2025-10-31','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(508,NULL,1,'2025-10-31','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(509,NULL,1,'2025-10-31','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(510,NULL,1,'2025-10-31','09:00:00','10:00:00','parenting',4000.00,0,0),(511,NULL,1,'2025-10-31','10:00:00','11:00:00','parenting',4000.00,0,0),(512,NULL,1,'2025-10-31','11:00:00','12:00:00','parenting',4000.00,0,0),(513,NULL,1,'2025-10-31','12:00:00','13:00:00','parenting',4000.00,0,0),(514,NULL,1,'2025-10-31','13:00:00','14:00:00','parenting',4000.00,0,0),(515,NULL,1,'2025-10-31','14:00:00','15:00:00','parenting',4000.00,0,0),(516,NULL,1,'2025-10-31','15:00:00','16:00:00','parenting',4000.00,0,0),(517,NULL,1,'2025-10-31','16:00:00','17:00:00','parenting',4000.00,0,0),(518,NULL,1,'2025-10-31','17:00:00','18:00:00','parenting',4000.00,0,0),(519,NULL,1,'2025-11-01','09:00:00','10:00:00','consultation',1500.00,0,0),(520,NULL,1,'2025-11-01','10:00:00','11:00:00','consultation',1500.00,1,0),(521,NULL,1,'2025-11-01','11:00:00','12:00:00','consultation',1500.00,0,0),(522,NULL,1,'2025-11-01','12:00:00','13:00:00','consultation',1500.00,0,0),(523,NULL,1,'2025-11-01','13:00:00','14:00:00','consultation',1500.00,0,0),(524,NULL,1,'2025-11-01','14:00:00','15:00:00','consultation',1500.00,0,0),(525,NULL,1,'2025-11-01','15:00:00','16:00:00','consultation',1500.00,0,0),(526,NULL,1,'2025-11-01','16:00:00','17:00:00','consultation',1500.00,0,0),(527,NULL,1,'2025-11-01','17:00:00','18:00:00','consultation',1500.00,0,0),(528,NULL,1,'2025-11-01','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(529,NULL,1,'2025-11-01','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(530,NULL,1,'2025-11-01','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(531,NULL,1,'2025-11-01','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(532,NULL,1,'2025-11-01','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(533,NULL,1,'2025-11-01','09:00:00','10:00:00','parenting',4000.00,0,0),(534,NULL,1,'2025-11-01','10:00:00','11:00:00','parenting',4000.00,0,0),(535,NULL,1,'2025-11-01','11:00:00','12:00:00','parenting',4000.00,0,0),(536,NULL,1,'2025-11-01','12:00:00','13:00:00','parenting',4000.00,0,0),(537,NULL,1,'2025-11-01','13:00:00','14:00:00','parenting',4000.00,0,0),(538,NULL,1,'2025-11-01','14:00:00','15:00:00','parenting',4000.00,0,0),(539,NULL,1,'2025-11-01','15:00:00','16:00:00','parenting',4000.00,0,0),(540,NULL,1,'2025-11-01','16:00:00','17:00:00','parenting',4000.00,0,0),(541,NULL,1,'2025-11-01','17:00:00','18:00:00','parenting',4000.00,0,0),(542,NULL,1,'2025-11-02','09:00:00','10:00:00','consultation',1500.00,0,0),(543,NULL,1,'2025-11-02','10:00:00','11:00:00','consultation',1500.00,0,0),(544,NULL,1,'2025-11-02','11:00:00','12:00:00','consultation',1500.00,0,0),(545,NULL,1,'2025-11-02','12:00:00','13:00:00','consultation',1500.00,0,0),(546,NULL,1,'2025-11-02','13:00:00','14:00:00','consultation',1500.00,0,0),(547,NULL,1,'2025-11-02','14:00:00','15:00:00','consultation',1500.00,0,0),(548,NULL,1,'2025-11-02','15:00:00','16:00:00','consultation',1500.00,0,0),(549,NULL,1,'2025-11-02','16:00:00','17:00:00','consultation',1500.00,0,0),(550,NULL,1,'2025-11-02','17:00:00','18:00:00','consultation',1500.00,0,0),(551,NULL,1,'2025-11-02','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(552,NULL,1,'2025-11-02','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(553,NULL,1,'2025-11-02','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(554,NULL,1,'2025-11-02','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(555,NULL,1,'2025-11-02','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(556,NULL,1,'2025-11-02','09:00:00','10:00:00','parenting',4000.00,0,0),(557,NULL,1,'2025-11-02','10:00:00','11:00:00','parenting',4000.00,0,0),(558,NULL,1,'2025-11-02','11:00:00','12:00:00','parenting',4000.00,0,0),(559,NULL,1,'2025-11-02','12:00:00','13:00:00','parenting',4000.00,0,0),(560,NULL,1,'2025-11-02','13:00:00','14:00:00','parenting',4000.00,0,0),(561,NULL,1,'2025-11-02','14:00:00','15:00:00','parenting',4000.00,0,0),(562,NULL,1,'2025-11-02','15:00:00','16:00:00','parenting',4000.00,0,0),(563,NULL,1,'2025-11-02','16:00:00','17:00:00','parenting',4000.00,0,0),(564,NULL,1,'2025-11-02','17:00:00','18:00:00','parenting',4000.00,0,0),(565,NULL,1,'2025-11-03','09:00:00','10:00:00','consultation',1500.00,0,0),(566,NULL,1,'2025-11-03','10:00:00','11:00:00','consultation',1500.00,0,0),(567,NULL,1,'2025-11-03','11:00:00','12:00:00','consultation',1500.00,0,0),(568,NULL,1,'2025-11-03','12:00:00','13:00:00','consultation',1500.00,0,0),(569,NULL,1,'2025-11-03','13:00:00','14:00:00','consultation',1500.00,0,0),(570,NULL,1,'2025-11-03','14:00:00','15:00:00','consultation',1500.00,0,0),(571,NULL,1,'2025-11-03','15:00:00','16:00:00','consultation',1500.00,0,0),(572,NULL,1,'2025-11-03','16:00:00','17:00:00','consultation',1500.00,0,0),(573,NULL,1,'2025-11-03','17:00:00','18:00:00','consultation',1500.00,0,0),(574,NULL,1,'2025-11-03','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(575,NULL,1,'2025-11-03','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(576,NULL,1,'2025-11-03','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(577,NULL,1,'2025-11-03','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(578,NULL,1,'2025-11-03','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(579,NULL,1,'2025-11-03','09:00:00','10:00:00','parenting',4000.00,0,0),(580,NULL,1,'2025-11-03','10:00:00','11:00:00','parenting',4000.00,0,0),(581,NULL,1,'2025-11-03','11:00:00','12:00:00','parenting',4000.00,0,0),(582,NULL,1,'2025-11-03','12:00:00','13:00:00','parenting',4000.00,0,0),(583,NULL,1,'2025-11-03','13:00:00','14:00:00','parenting',4000.00,0,0),(584,NULL,1,'2025-11-03','14:00:00','15:00:00','parenting',4000.00,0,0),(585,NULL,1,'2025-11-03','15:00:00','16:00:00','parenting',4000.00,0,0),(586,NULL,1,'2025-11-03','16:00:00','17:00:00','parenting',4000.00,0,0),(587,NULL,1,'2025-11-03','17:00:00','18:00:00','parenting',4000.00,0,0),(588,NULL,1,'2025-11-04','09:00:00','10:00:00','consultation',1500.00,0,0),(589,NULL,1,'2025-11-04','10:00:00','11:00:00','consultation',1500.00,0,0),(590,NULL,1,'2025-11-04','11:00:00','12:00:00','consultation',1500.00,0,0),(591,NULL,1,'2025-11-04','12:00:00','13:00:00','consultation',1500.00,0,0),(592,NULL,1,'2025-11-04','13:00:00','14:00:00','consultation',1500.00,0,0),(593,NULL,1,'2025-11-04','14:00:00','15:00:00','consultation',1500.00,0,0),(594,NULL,1,'2025-11-04','15:00:00','16:00:00','consultation',1500.00,0,0),(595,NULL,1,'2025-11-04','16:00:00','17:00:00','consultation',1500.00,0,0),(596,NULL,1,'2025-11-04','17:00:00','18:00:00','consultation',1500.00,0,0),(597,NULL,1,'2025-11-04','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(598,NULL,1,'2025-11-04','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(599,NULL,1,'2025-11-04','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(600,NULL,1,'2025-11-04','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(601,NULL,1,'2025-11-04','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(602,NULL,1,'2025-11-04','09:00:00','10:00:00','parenting',4000.00,0,0),(603,NULL,1,'2025-11-04','10:00:00','11:00:00','parenting',4000.00,0,0),(604,NULL,1,'2025-11-04','11:00:00','12:00:00','parenting',4000.00,0,0),(605,NULL,1,'2025-11-04','12:00:00','13:00:00','parenting',4000.00,0,0),(606,NULL,1,'2025-11-04','13:00:00','14:00:00','parenting',4000.00,0,0),(607,NULL,1,'2025-11-04','14:00:00','15:00:00','parenting',4000.00,0,0),(608,NULL,1,'2025-11-04','15:00:00','16:00:00','parenting',4000.00,0,0),(609,NULL,1,'2025-11-04','16:00:00','17:00:00','parenting',4000.00,0,0),(610,NULL,1,'2025-11-04','17:00:00','18:00:00','parenting',4000.00,0,0),(611,NULL,1,'2025-11-05','09:00:00','10:00:00','consultation',1500.00,0,0),(612,NULL,1,'2025-11-05','10:00:00','11:00:00','consultation',1500.00,0,0),(613,NULL,1,'2025-11-05','11:00:00','12:00:00','consultation',1500.00,0,0),(614,NULL,1,'2025-11-05','12:00:00','13:00:00','consultation',1500.00,0,0),(615,NULL,1,'2025-11-05','13:00:00','14:00:00','consultation',1500.00,0,0),(616,NULL,1,'2025-11-05','14:00:00','15:00:00','consultation',1500.00,0,0),(617,NULL,1,'2025-11-05','15:00:00','16:00:00','consultation',1500.00,0,0),(618,NULL,1,'2025-11-05','16:00:00','17:00:00','consultation',1500.00,0,0),(619,NULL,1,'2025-11-05','17:00:00','18:00:00','consultation',1500.00,0,0),(620,NULL,1,'2025-11-05','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(621,NULL,1,'2025-11-05','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(622,NULL,1,'2025-11-05','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(623,NULL,1,'2025-11-05','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(624,NULL,1,'2025-11-05','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(625,NULL,1,'2025-11-05','09:00:00','10:00:00','parenting',4000.00,0,0),(626,NULL,1,'2025-11-05','10:00:00','11:00:00','parenting',4000.00,0,0),(627,NULL,1,'2025-11-05','11:00:00','12:00:00','parenting',4000.00,0,0),(628,NULL,1,'2025-11-05','12:00:00','13:00:00','parenting',4000.00,0,0),(629,NULL,1,'2025-11-05','13:00:00','14:00:00','parenting',4000.00,0,0),(630,NULL,1,'2025-11-05','14:00:00','15:00:00','parenting',4000.00,0,0),(631,NULL,1,'2025-11-05','15:00:00','16:00:00','parenting',4000.00,0,0),(632,NULL,1,'2025-11-05','16:00:00','17:00:00','parenting',4000.00,0,0),(633,NULL,1,'2025-11-05','17:00:00','18:00:00','parenting',4000.00,0,0),(634,NULL,1,'2025-11-06','09:00:00','10:00:00','consultation',1500.00,0,0),(635,NULL,1,'2025-11-06','10:00:00','11:00:00','consultation',1500.00,0,0),(636,NULL,1,'2025-11-06','11:00:00','12:00:00','consultation',1500.00,0,0),(637,NULL,1,'2025-11-06','12:00:00','13:00:00','consultation',1500.00,0,0),(638,NULL,1,'2025-11-06','13:00:00','14:00:00','consultation',1500.00,0,0),(639,NULL,1,'2025-11-06','14:00:00','15:00:00','consultation',1500.00,0,0),(640,NULL,1,'2025-11-06','15:00:00','16:00:00','consultation',1500.00,0,0),(641,NULL,1,'2025-11-06','16:00:00','17:00:00','consultation',1500.00,0,0),(642,NULL,1,'2025-11-06','17:00:00','18:00:00','consultation',1500.00,0,0),(643,NULL,1,'2025-11-06','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(644,NULL,1,'2025-11-06','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(645,NULL,1,'2025-11-06','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(646,NULL,1,'2025-11-06','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(647,NULL,1,'2025-11-06','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(648,NULL,1,'2025-11-06','09:00:00','10:00:00','parenting',4000.00,0,0),(649,NULL,1,'2025-11-06','10:00:00','11:00:00','parenting',4000.00,0,0),(650,NULL,1,'2025-11-06','11:00:00','12:00:00','parenting',4000.00,0,0),(651,NULL,1,'2025-11-06','12:00:00','13:00:00','parenting',4000.00,0,0),(652,NULL,1,'2025-11-06','13:00:00','14:00:00','parenting',4000.00,0,0),(653,NULL,1,'2025-11-06','14:00:00','15:00:00','parenting',4000.00,0,0),(654,NULL,1,'2025-11-06','15:00:00','16:00:00','parenting',4000.00,0,0),(655,NULL,1,'2025-11-06','16:00:00','17:00:00','parenting',4000.00,0,0),(656,NULL,1,'2025-11-06','17:00:00','18:00:00','parenting',4000.00,0,0),(657,NULL,1,'2025-11-07','09:00:00','10:00:00','consultation',1500.00,0,0),(658,NULL,1,'2025-11-07','10:00:00','11:00:00','consultation',1500.00,0,0),(659,NULL,1,'2025-11-07','11:00:00','12:00:00','consultation',1500.00,0,0),(660,NULL,1,'2025-11-07','12:00:00','13:00:00','consultation',1500.00,0,0),(661,NULL,1,'2025-11-07','13:00:00','14:00:00','consultation',1500.00,0,0),(662,NULL,1,'2025-11-07','14:00:00','15:00:00','consultation',1500.00,0,0),(663,NULL,1,'2025-11-07','15:00:00','16:00:00','consultation',1500.00,0,0),(664,NULL,1,'2025-11-07','16:00:00','17:00:00','consultation',1500.00,0,0),(665,NULL,1,'2025-11-07','17:00:00','18:00:00','consultation',1500.00,0,0),(666,NULL,1,'2025-11-07','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(667,NULL,1,'2025-11-07','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(668,NULL,1,'2025-11-07','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(669,NULL,1,'2025-11-07','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(670,NULL,1,'2025-11-07','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(671,NULL,1,'2025-11-07','09:00:00','10:00:00','parenting',4000.00,0,0),(672,NULL,1,'2025-11-07','10:00:00','11:00:00','parenting',4000.00,0,0),(673,NULL,1,'2025-11-07','11:00:00','12:00:00','parenting',4000.00,0,0),(674,NULL,1,'2025-11-07','12:00:00','13:00:00','parenting',4000.00,0,0),(675,NULL,1,'2025-11-07','13:00:00','14:00:00','parenting',4000.00,0,0),(676,NULL,1,'2025-11-07','14:00:00','15:00:00','parenting',4000.00,0,0),(677,NULL,1,'2025-11-07','15:00:00','16:00:00','parenting',4000.00,0,0),(678,NULL,1,'2025-11-07','16:00:00','17:00:00','parenting',4000.00,0,0),(679,NULL,1,'2025-11-07','17:00:00','18:00:00','parenting',4000.00,0,0),(680,NULL,1,'2025-11-08','09:00:00','10:00:00','consultation',1500.00,0,0),(681,NULL,1,'2025-11-08','10:00:00','11:00:00','consultation',1500.00,0,0),(682,NULL,1,'2025-11-08','11:00:00','12:00:00','consultation',1500.00,0,0),(683,NULL,1,'2025-11-08','12:00:00','13:00:00','consultation',1500.00,0,0),(684,NULL,1,'2025-11-08','13:00:00','14:00:00','consultation',1500.00,0,0),(685,NULL,1,'2025-11-08','14:00:00','15:00:00','consultation',1500.00,0,0),(686,NULL,1,'2025-11-08','15:00:00','16:00:00','consultation',1500.00,0,0),(687,NULL,1,'2025-11-08','16:00:00','17:00:00','consultation',1500.00,0,0),(688,NULL,1,'2025-11-08','17:00:00','18:00:00','consultation',1500.00,0,0),(689,NULL,1,'2025-11-08','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(690,NULL,1,'2025-11-08','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(691,NULL,1,'2025-11-08','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(692,NULL,1,'2025-11-08','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(693,NULL,1,'2025-11-08','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(694,NULL,1,'2025-11-08','09:00:00','10:00:00','parenting',4000.00,0,0),(695,NULL,1,'2025-11-08','10:00:00','11:00:00','parenting',4000.00,0,0),(696,NULL,1,'2025-11-08','11:00:00','12:00:00','parenting',4000.00,0,0),(697,NULL,1,'2025-11-08','12:00:00','13:00:00','parenting',4000.00,0,0),(698,NULL,1,'2025-11-08','13:00:00','14:00:00','parenting',4000.00,0,0),(699,NULL,1,'2025-11-08','14:00:00','15:00:00','parenting',4000.00,0,0),(700,NULL,1,'2025-11-08','15:00:00','16:00:00','parenting',4000.00,0,0),(701,NULL,1,'2025-11-08','16:00:00','17:00:00','parenting',4000.00,0,0),(702,NULL,1,'2025-11-08','17:00:00','18:00:00','parenting',4000.00,0,0),(703,NULL,1,'2025-11-09','09:00:00','10:00:00','consultation',1500.00,0,0),(704,NULL,1,'2025-11-09','10:00:00','11:00:00','consultation',1500.00,0,0),(705,NULL,1,'2025-11-09','11:00:00','12:00:00','consultation',1500.00,0,0),(706,NULL,1,'2025-11-09','12:00:00','13:00:00','consultation',1500.00,0,0),(707,NULL,1,'2025-11-09','13:00:00','14:00:00','consultation',1500.00,0,0),(708,NULL,1,'2025-11-09','14:00:00','15:00:00','consultation',1500.00,0,0),(709,NULL,1,'2025-11-09','15:00:00','16:00:00','consultation',1500.00,0,0),(710,NULL,1,'2025-11-09','16:00:00','17:00:00','consultation',1500.00,0,0),(711,NULL,1,'2025-11-09','17:00:00','18:00:00','consultation',1500.00,0,0),(712,NULL,1,'2025-11-09','09:00:00','11:00:00','consultation_assessment',5000.00,0,0),(713,NULL,1,'2025-11-09','11:00:00','13:00:00','consultation_assessment',5000.00,0,0),(714,NULL,1,'2025-11-09','13:00:00','15:00:00','consultation_assessment',5000.00,0,0),(715,NULL,1,'2025-11-09','15:00:00','17:00:00','consultation_assessment',5000.00,0,0),(716,NULL,1,'2025-11-09','17:00:00','19:00:00','consultation_assessment',5000.00,0,0),(717,NULL,1,'2025-11-09','09:00:00','10:00:00','parenting',4000.00,0,0),(718,NULL,1,'2025-11-09','10:00:00','11:00:00','parenting',4000.00,0,0),(719,NULL,1,'2025-11-09','11:00:00','12:00:00','parenting',4000.00,0,0),(720,NULL,1,'2025-11-09','12:00:00','13:00:00','parenting',4000.00,0,0),(721,NULL,1,'2025-11-09','13:00:00','14:00:00','parenting',4000.00,0,0),(722,NULL,1,'2025-11-09','14:00:00','15:00:00','parenting',4000.00,0,0),(723,NULL,1,'2025-11-09','15:00:00','16:00:00','parenting',4000.00,0,0),(724,NULL,1,'2025-11-09','16:00:00','17:00:00','parenting',4000.00,0,0),(725,NULL,1,'2025-11-09','17:00:00','18:00:00','parenting',4000.00,0,0);
/*!40000 ALTER TABLE `slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tips`
--

DROP TABLE IF EXISTS `tips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tips` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tips`
--

LOCK TABLES `tips` WRITE;
/*!40000 ALTER TABLE `tips` DISABLE KEYS */;
INSERT INTO `tips` VALUES (1,'Maintain a bedtime routine','A consistent bedtime helps your child sleep better.','2025-10-05 06:43:02'),(2,'Encourage outdoor play','Let your child explore nature for better mental and physical growth.','2025-10-05 06:43:02'),(3,'Listen actively','Give full attention when your child speaks—it builds trust.','2025-10-05 06:43:02'),(4,'Limit screen time','Encourage creative activities instead of excessive TV or mobile use.','2025-10-05 06:43:02');
/*!40000 ALTER TABLE `tips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (4,'Ayush Gupta','ayushgupta1092@gmail.com','$2b$10$BLdBKGHowAtM7k8syV4DJecSZwxGl/zUjAydKtOt1.YRniVOzQ72u','2025-10-26 09:10:58');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04  2:25:02
