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
-- Table structure for table `cources_courserating`
--

DROP TABLE IF EXISTS `cources_courserating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cources_courserating` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `rate` smallint unsigned NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cources_courserating_user_id_course_id_08acf8b0_uniq` (`user_id`,`course_id`),
  KEY `cources_courserating_course_id_af24d82d_fk_cources_course_id` (`course_id`),
  CONSTRAINT `cources_courserating_course_id_af24d82d_fk_cources_course_id` FOREIGN KEY (`course_id`) REFERENCES `cources_course` (`id`),
  CONSTRAINT `cources_courserating_user_id_5c2ee847_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `cources_courserating_chk_1` CHECK ((`rate` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cources_courserating`
--

LOCK TABLES `cources_courserating` WRITE;
/*!40000 ALTER TABLE `cources_courserating` DISABLE KEYS */;
INSERT INTO `cources_courserating` VALUES (1,5,'2026-05-21 09:12:51.978327',1,4),(2,5,'2026-05-21 10:47:49.181463',2,6),(3,3,'2026-05-21 10:49:42.894977',1,6),(5,2,'2026-05-22 13:34:07.643531',2,9),(6,4,'2026-05-22 19:36:42.290371',2,2),(8,3,'2026-05-23 00:35:52.029236',1,3),(10,4,'2026-05-23 05:49:02.927483',19,11),(11,4,'2026-05-23 05:49:21.647805',12,11),(12,5,'2026-05-23 11:39:07.175668',16,11),(13,5,'2026-05-24 08:34:20.694157',10,4),(14,5,'2026-05-25 10:51:41.844370',13,24),(15,5,'2026-05-25 10:51:59.240413',18,24),(16,5,'2026-05-25 10:53:01.979400',2,24),(17,5,'2026-05-25 18:45:11.141936',10,13),(18,5,'2026-05-25 18:47:57.503559',20,13),(19,5,'2026-05-26 21:53:10.563970',16,13),(20,5,'2026-05-29 20:22:01.783289',12,32),(21,5,'2026-05-31 16:36:41.972430',17,4),(22,5,'2026-06-01 01:45:22.583421',16,8),(23,5,'2026-06-02 21:36:04.553834',20,43),(24,5,'2026-06-03 15:33:52.206452',20,3),(25,5,'2026-06-03 15:40:19.608520',19,3),(26,5,'2026-06-07 19:16:40.699240',20,45),(27,5,'2026-06-07 19:17:19.145690',16,45),(28,5,'2026-06-12 15:47:32.708472',19,29),(29,5,'2026-06-25 14:38:47.495128',20,28),(30,5,'2026-08-04 16:40:52.228493',20,32),(31,5,'2026-08-04 16:41:09.052492',19,32);
/*!40000 ALTER TABLE `cources_courserating` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:08:54
