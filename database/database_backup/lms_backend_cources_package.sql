-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: lms-restored.cmtq6ucsmyy0.us-east-1.rds.amazonaws.com    Database: lms_backend
-- ------------------------------------------------------
-- Server version	8.4.8

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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `cources_package`
--

DROP TABLE IF EXISTS `cources_package`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cources_package` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `instructor_id` bigint DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `cources_package_instructor_id_f3328bb6_fk_users_instructor_id` (`instructor_id`),
  CONSTRAINT `cources_package_instructor_id_f3328bb6_fk_users_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `users_instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cources_package`
--

LOCK TABLES `cources_package` WRITE;
/*!40000 ALTER TABLE `cources_package` DISABLE KEYS */;
INSERT INTO `cources_package` VALUES (1,'Mobile Development Package','mobile-development-package-f513aa',0.00,'2026-05-21 12:02:30.652352',1,'Contain all mobile packages created with Eng Abdallah Alqiran.'),(2,'Kotlin Courses','kotlin-courses-13ec7b',0.00,'2026-05-21 12:02:59.503591',1,'Kotlin Series from beginner to advances.'),(3,'Flutter Courses','flutter-courses-a616ec',0.00,'2026-05-21 12:03:21.269568',1,'Flutter Series from beginner to advances.'),(4,'Flutter course','simplistic-apropos-against-whenever-oh-conservativ',0.00,'2026-05-20 23:03:32.988000',1,'Beginner Flutter course'),(9,'Mobile Development Bootcamp','mobile-development-bootcamp-1b6d5c',0.00,'2026-05-23 02:39:45.899525',2,'learning bundle.\n\nThis package combines everything you need to start and grow your journey in mobile development — from programming fundamentals to building real-world Android and Flutter applications using modern technologies and professional development practices.\n\nWhether you are a complete beginner or an aspiring developer looking to level up your skills, this bundle will guide you step by step through practical projects, clean architecture, UI design, state management, APIs, and advanced mobile app concepts.\n\n? Included Courses\n\nDart Masterclass\nFlutter Masterclass\nFlutter Advanced Course\nAndroid Jetpack Compose\nAPI Testing Masterclass\nReal-World Projects & Practice\n\n? What You’ll Learn\n\nMobile App Development Fundamentals\nBuilding Android & Flutter Applications\nModern UI/UX Design\nState Management\nAPI Integration\nFirebase & Backend Basics\nClean Architecture\nPerformance Optimization\nReal-World Development Workflow\nPublishing & Deployment\n\n? By the end of this bundle, you’ll have the skills and practical experience needed to build professional mobile applications and start your career as a mobile developer or freelancer with confidence.'),(10,'The Ultimate Mobile Development Bundle','the-ultimate-mobile-development-bundle-be1ee4',0.00,'2026-05-23 02:42:30.738781',2,'learning bundle.\n\nThis package combines everything you need to start and grow your journey in mobile development — from programming fundamentals to building real-world Android and Flutter applications using modern technologies and professional development practices.\n\nWhether you are a complete beginner or an aspiring developer looking to level up your skills, this bundle will guide you step by step through practical projects, clean architecture, UI design, state management, APIs, and advanced mobile app concepts.\n\n? Included Courses\n\nDart Masterclass\nFlutter Masterclass\nFlutter Advanced Course\nAndroid Jetpack Compose\nAPI Testing Masterclass\nReal-World Projects & Practice\n\n? What You’ll Learn\n\nMobile App Development Fundamentals\nBuilding Android & Flutter Applications\nModern UI/UX Design\nState Management\nAPI Integration\nFirebase & Backend Basics\nClean Architecture\nPerformance Optimization\nReal-World Development Workflow\nPublishing & Deployment\n\n? By the end of this bundle, you’ll have the skills and practical experience needed to build professional mobile applications and start your career as a mobile developer or freelancer with confidence.'),(11,'مواد سنة أولي الترم الأول','-960991',0.00,'2026-05-23 04:12:18.314403',6,'شرح لجميع مواد سنة أولي الترم الأول'),(12,'Fundamentals','fundamentals-3cd5c1',0.00,'2026-05-23 04:51:02.406914',8,'ما لا يسع المبرمج جهلة');
/*!40000 ALTER TABLE `cources_package` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-25 21:08:40
