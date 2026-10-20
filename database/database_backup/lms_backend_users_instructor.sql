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
-- Table structure for table `users_instructor`
--

DROP TABLE IF EXISTS `users_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_instructor` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bio` longtext COLLATE utf8mb4_unicode_ci,
  `description` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `users_instructor_user_id_7b00976e_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_instructor`
--

LOCK TABLES `users_instructor` WRITE;
/*!40000 ALTER TABLE `users_instructor` DISABLE KEYS */;
INSERT INTO `users_instructor` VALUES (1,'Mobile Developer || Software Engineer || @DEPI Graduate','Mobile Developer focused on building mobile applications using Flutter and Kotlin. I have contributed to multiple real-world apps including Mezan app, serving more than 2000 users. My experience includes freelance work, full-time development, and leading technical communities as Head of Community an',5),(2,'Flutter Developer','I am Taha Saber Taha, a 21-year-old Computer Science student at South Valley University, passionate about App Development and turning ideas into real mobile applications using Flutter. I enjoy learning new technologies, building clean UI designs, and improving my skills through real projects and tea',10),(4,NULL,'',15),(6,'Smart Student','Proffesional in explaining University Subjects, currently I am 6th primary school with 8 years of experience at studying in schools.',18),(8,'Supporting Each other','Support Qena is a student-led community at Qena University (formerly South Valley University – SVU) where we help each other learn and grow together. Our members come from different tracks in computer science and technology, and we share our knowledge through sessions, discussions, and shared resour',20),(9,NULL,'',22),(10,'Software Engineer','i\'m Hussein from Egypt',23),(11,NULL,'',42);
/*!40000 ALTER TABLE `users_instructor` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:10:37
