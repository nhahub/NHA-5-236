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
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3wh6xh03b3uli3yyl6p2tfjsc15rhig1','.eJxVjEEOwiAQRe_C2hCYAgWX7j0DmRmmUjVtUtqV8e7apAvd_vfef6mM21rz1mTJY1FnZdXpdyPkh0w7KHecbrPmeVqXkfSu6IM2fZ2LPC-H-3dQsdVvzeQiEBjhEPtILsXYuQGRxJrOU0RmsUNia4ETgDdgXUkmgA8BJfXq_QHjXzds:1wQ7UW:6msw5HjeuzVd3eDA4ZHg8ud5keCePF3htu_UquE-YZc','2026-06-04 17:47:28.008871'),('nrzmhqunkznmlm7kt1jto2v69vb7criw','.eJxVjEEOwiAQRe_C2hCYAgWX7j0DmRmmUjVtUtqV8e7apAvd_vfef6mM21rz1mTJY1FnZdXpdyPkh0w7KHecbrPmeVqXkfSu6IM2fZ2LPC-H-3dQsdVvzeQiEBjhEPtILsXYuQGRxJrOU0RmsUNia4ETgDdgXUkmgA8BJfXq_QHjXzds:1wTkLC:DP3Y3KOy4zqPUl3snh96DOsXkCZsb-l8jOssopfJEfM','2026-06-14 17:52:50.384654'),('t4pzzzejej7ev2vhbyhh9tr8889cribv','.eJxVjEEOwiAQRe_C2hCYAgWX7j0DmRmmUjVtUtqV8e7apAvd_vfef6mM21rz1mTJY1FnZdXpdyPkh0w7KHecbrPmeVqXkfSu6IM2fZ2LPC-H-3dQsdVvzeQiEBjhEPtILsXYuQGRxJrOU0RmsUNia4ETgDdgXUkmgA8BJfXq_QHjXzds:1wVsXt:FqekEP1LWRbU2QrGVzjaJicbyUkynXUAgQ7RPCSjAFM','2026-06-20 15:02:45.145811');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:08:34
