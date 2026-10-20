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
-- Table structure for table `videos_videoprogress`
--

DROP TABLE IF EXISTS `videos_videoprogress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos_videoprogress` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `is_completed` tinyint(1) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `student_id` bigint NOT NULL,
  `video_id` bigint NOT NULL,
  `watched_seconds` double NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_student_video_progress` (`student_id`,`video_id`),
  KEY `videos_videoprogress_video_id_91839c1b_fk_videos_video_id` (`video_id`),
  KEY `videos_videoprogress_student_id_2a3fac78` (`student_id`),
  CONSTRAINT `videos_videoprogress_student_id_2a3fac78_fk_users_student_id` FOREIGN KEY (`student_id`) REFERENCES `users_student` (`id`),
  CONSTRAINT `videos_videoprogress_video_id_91839c1b_fk_videos_video_id` FOREIGN KEY (`video_id`) REFERENCES `videos_video` (`id`),
  CONSTRAINT `progress_watched_seconds_non_negative` CHECK ((`watched_seconds` >= 0.0e0))
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_videoprogress`
--

LOCK TABLES `videos_videoprogress` WRITE;
/*!40000 ALTER TABLE `videos_videoprogress` DISABLE KEYS */;
INSERT INTO `videos_videoprogress` VALUES (1,1,'2026-05-22 04:00:25.323794',2,1,200,'2026-06-14 19:16:43.849545'),(5,1,'2026-05-22 03:13:56.720955',1,1,0,'2026-06-14 19:16:43.849545'),(7,1,'2026-05-22 19:18:14.214924',2,13,0,'2026-06-14 19:16:43.849545'),(8,0,'2026-05-22 19:22:41.030584',1,18,0,'2026-06-14 19:16:43.849545'),(9,0,'2026-05-22 19:41:05.195472',4,19,0,'2026-06-14 19:16:43.849545'),(10,0,'2026-05-23 07:18:27.020094',2,18,0,'2026-06-14 19:16:43.849545'),(22,0,'2026-05-23 07:30:25.404586',2,19,0,'2026-06-14 19:16:43.849545'),(23,1,'2026-05-23 07:29:22.463761',2,20,0,'2026-06-14 19:16:43.849545'),(24,1,'2026-05-23 07:37:26.190765',1,20,0,'2026-06-14 19:16:43.849545'),(25,1,'2026-05-23 07:38:49.361009',1,26,0,'2026-06-14 19:16:43.849545'),(27,1,'2026-05-23 08:06:47.687109',7,19,233,'2026-06-14 19:16:43.849545'),(30,1,'2026-05-27 08:35:42.578670',15,27,136,'2026-06-14 19:16:43.849545'),(32,1,'2026-05-27 10:47:26.270932',17,30,719,'2026-06-14 19:16:43.849545'),(33,1,'2026-05-27 11:00:39.656374',18,32,709,'2026-06-14 19:16:43.849545'),(34,1,'2026-06-12 13:29:00.629692',18,18,280,'2026-06-14 19:16:43.849545'),(35,1,'2026-06-12 17:16:16.168108',18,30,719,'2026-06-14 19:16:43.849545'),(36,1,'2026-06-13 12:38:57.866186',18,1,200,'2026-06-14 19:16:43.849545'),(37,1,'2026-06-13 12:40:04.769164',18,13,200,'2026-06-14 19:16:43.849545');
/*!40000 ALTER TABLE `videos_videoprogress` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:10:05
