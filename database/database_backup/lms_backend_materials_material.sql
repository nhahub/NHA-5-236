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
-- Table structure for table `materials_material`
--

DROP TABLE IF EXISTS `materials_material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materials_material` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `Material_Name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `materials_material_course_id_59c21cea_fk_cources_course_id` (`course_id`),
  CONSTRAINT `materials_material_course_id_59c21cea_fk_cources_course_id` FOREIGN KEY (`course_id`) REFERENCES `cources_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materials_material`
--

LOCK TABLES `materials_material` WRITE;
/*!40000 ALTER TABLE `materials_material` DISABLE KEYS */;
INSERT INTO `materials_material` VALUES (1,'Android Topics','mat-android-topics-7c63f60e','courses/materials/Android_Topics.pdf',1,'2026-05-21 09:23:32.320450','2026-05-21 09:23:32.320485'),(2,'Test','mat-test-42ff0bb5','courses/materials/FlutterTask_jXs9wrS.pdf',2,'2026-05-21 12:02:41.209702','2026-05-21 12:02:41.209735'),(4,'XML','mat-xml-c4e7cfb8','courses/materials/XML.pdf',1,'2026-05-22 10:52:51.247080','2026-05-22 10:52:51.247111'),(5,'OOP','mat-oop-b0e9239b','courses/materials/تلخيص_ال_OOP.pdf',2,'2026-05-22 19:31:32.982032','2026-05-22 19:31:32.982066'),(6,'git commands','mat-git-commands-100ed891','courses/materials/git_r9dL5UQ.pdf',16,'2026-05-23 04:24:36.941410','2026-05-23 04:24:36.941444'),(7,'database file','mat-database-file-33d0f778','courses/materials/database.pdf',17,'2026-05-23 04:52:23.685510','2026-05-23 04:52:23.685541'),(8,'keyboard short cuts','mat-keyboard-short-cuts-4ba13fdd','courses/materials/ShortCuts_loyUPtM.pdf',19,'2026-05-23 05:21:41.627257','2026-05-23 05:21:41.627300');
/*!40000 ALTER TABLE `materials_material` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:08:17
