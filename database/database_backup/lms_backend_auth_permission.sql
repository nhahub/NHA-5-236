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
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add Outstanding Token',6,'add_outstandingtoken'),(22,'Can change Outstanding Token',6,'change_outstandingtoken'),(23,'Can delete Outstanding Token',6,'delete_outstandingtoken'),(24,'Can view Outstanding Token',6,'view_outstandingtoken'),(25,'Can add Blacklisted Token',7,'add_blacklistedtoken'),(26,'Can change Blacklisted Token',7,'change_blacklistedtoken'),(27,'Can delete Blacklisted Token',7,'delete_blacklistedtoken'),(28,'Can view Blacklisted Token',7,'view_blacklistedtoken'),(29,'Can add user',8,'add_user'),(30,'Can change user',8,'change_user'),(31,'Can delete user',8,'delete_user'),(32,'Can view user',8,'view_user'),(33,'Can add student',9,'add_student'),(34,'Can change student',9,'change_student'),(35,'Can delete student',9,'delete_student'),(36,'Can view student',9,'view_student'),(37,'Can add instructor',10,'add_instructor'),(38,'Can change instructor',10,'change_instructor'),(39,'Can delete instructor',10,'delete_instructor'),(40,'Can view instructor',10,'view_instructor'),(41,'Can add instructor links',11,'add_instructorlinks'),(42,'Can change instructor links',11,'change_instructorlinks'),(43,'Can delete instructor links',11,'delete_instructorlinks'),(44,'Can view instructor links',11,'view_instructorlinks'),(45,'Can add password reset otp',12,'add_passwordresetotp'),(46,'Can change password reset otp',12,'change_passwordresetotp'),(47,'Can delete password reset otp',12,'delete_passwordresetotp'),(48,'Can view password reset otp',12,'view_passwordresetotp'),(49,'Can add course',13,'add_course'),(50,'Can change course',13,'change_course'),(51,'Can delete course',13,'delete_course'),(52,'Can view course',13,'view_course'),(53,'Can add package',14,'add_package'),(54,'Can change package',14,'change_package'),(55,'Can delete package',14,'delete_package'),(56,'Can view package',14,'view_package'),(57,'Can add course rating',15,'add_courserating'),(58,'Can change course rating',15,'change_courserating'),(59,'Can delete course rating',15,'delete_courserating'),(60,'Can view course rating',15,'view_courserating'),(61,'Can add enrollment',16,'add_enrollment'),(62,'Can change enrollment',16,'change_enrollment'),(63,'Can delete enrollment',16,'delete_enrollment'),(64,'Can view enrollment',16,'view_enrollment'),(65,'Can add video',17,'add_video'),(66,'Can change video',17,'change_video'),(67,'Can delete video',17,'delete_video'),(68,'Can view video',17,'view_video'),(69,'Can add video progress',18,'add_videoprogress'),(70,'Can change video progress',18,'change_videoprogress'),(71,'Can delete video progress',18,'delete_videoprogress'),(72,'Can view video progress',18,'view_videoprogress'),(73,'Can add announcement',19,'add_announcement'),(74,'Can change announcement',19,'change_announcement'),(75,'Can delete announcement',19,'delete_announcement'),(76,'Can view announcement',19,'view_announcement'),(77,'Can add notification',20,'add_notification'),(78,'Can change notification',20,'change_notification'),(79,'Can delete notification',20,'delete_notification'),(80,'Can view notification',20,'view_notification'),(81,'Can add Course Material',21,'add_material'),(82,'Can change Course Material',21,'change_material'),(83,'Can delete Course Material',21,'delete_material'),(84,'Can view Course Material',21,'view_material'),(85,'Can add quiz',22,'add_quiz'),(86,'Can change quiz',22,'change_quiz'),(87,'Can delete quiz',22,'delete_quiz'),(88,'Can view quiz',22,'view_quiz'),(89,'Can add question',23,'add_question'),(90,'Can change question',23,'change_question'),(91,'Can delete question',23,'delete_question'),(92,'Can view question',23,'view_question'),(93,'Can add choice',24,'add_choice'),(94,'Can change choice',24,'change_choice'),(95,'Can delete choice',24,'delete_choice'),(96,'Can view choice',24,'view_choice'),(97,'Can add attempt',25,'add_attempt'),(98,'Can change attempt',25,'change_attempt'),(99,'Can delete attempt',25,'delete_attempt'),(100,'Can view attempt',25,'view_attempt'),(101,'Can add student answer',26,'add_studentanswer'),(102,'Can change student answer',26,'change_studentanswer'),(103,'Can delete student answer',26,'delete_studentanswer'),(104,'Can view student answer',26,'view_studentanswer');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:09:51
