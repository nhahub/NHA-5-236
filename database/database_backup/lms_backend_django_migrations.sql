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
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-03-26 10:28:15.556829'),(2,'contenttypes','0002_remove_content_type_name','2026-03-26 10:28:16.955532'),(3,'auth','0001_initial','2026-03-26 10:28:19.757180'),(4,'auth','0002_alter_permission_name_max_length','2026-03-26 10:28:20.283537'),(5,'auth','0003_alter_user_email_max_length','2026-03-26 10:28:20.790964'),(6,'auth','0004_alter_user_username_opts','2026-03-26 10:28:21.402741'),(7,'auth','0005_alter_user_last_login_null','2026-03-26 10:28:21.645726'),(8,'auth','0006_require_contenttypes_0002','2026-03-26 10:28:21.906742'),(9,'auth','0007_alter_validators_add_error_messages','2026-03-26 10:28:22.281043'),(10,'auth','0008_alter_user_username_max_length','2026-03-26 10:28:22.972241'),(11,'auth','0009_alter_user_last_name_max_length','2026-03-26 10:28:23.650916'),(12,'auth','0010_alter_group_name_max_length','2026-03-26 10:28:24.403479'),(13,'auth','0011_update_proxy_permissions','2026-03-26 10:28:26.287170'),(14,'auth','0012_alter_user_first_name_max_length','2026-03-26 10:28:26.558640'),(15,'users','0001_initial','2026-03-26 10:28:33.833492'),(16,'admin','0001_initial','2026-03-26 10:28:36.192936'),(17,'admin','0002_logentry_remove_auto_add','2026-03-26 10:28:36.756620'),(18,'admin','0003_logentry_add_action_flag_choices','2026-03-26 10:28:37.066056'),(19,'cources','0001_initial','2026-03-26 10:28:39.207503'),(20,'cources','0002_initial','2026-03-26 10:28:45.447863'),(21,'cources','0003_package_description','2026-03-26 10:28:46.375851'),(22,'materials','0001_initial','2026-03-26 10:28:48.319014'),(23,'notifications','0001_initial','2026-03-26 10:28:53.241646'),(24,'notifications','0002_alter_notification_notification_type','2026-03-26 10:28:53.766332'),(25,'notifications','0003_alter_notification_notification_type','2026-03-26 10:28:54.177271'),(26,'quizzes','0001_initial','2026-03-26 10:29:04.453044'),(27,'quizzes','0002_remove_studentanswer_quizzes_stu_attempt_8d8ff7_idx_and_more','2026-03-26 10:29:08.499389'),(28,'sessions','0001_initial','2026-03-26 10:29:10.131392'),(29,'token_blacklist','0001_initial','2026-03-26 10:29:12.286418'),(30,'token_blacklist','0002_outstandingtoken_jti_hex','2026-03-26 10:29:13.508609'),(31,'token_blacklist','0003_auto_20171017_2007','2026-03-26 10:29:15.155537'),(32,'token_blacklist','0004_auto_20171017_2013','2026-03-26 10:29:16.503445'),(33,'token_blacklist','0005_remove_outstandingtoken_jti','2026-03-26 10:29:17.298949'),(34,'token_blacklist','0006_auto_20171017_2113','2026-03-26 10:29:17.818079'),(35,'token_blacklist','0007_auto_20171017_2214','2026-03-26 10:29:20.796375'),(36,'token_blacklist','0008_migrate_to_bigautofield','2026-03-26 10:29:23.692973'),(37,'token_blacklist','0010_fix_migrate_to_bigautofield','2026-03-26 10:29:24.108440'),(38,'token_blacklist','0011_linearizes_history','2026-03-26 10:29:24.508606'),(39,'token_blacklist','0012_alter_outstandingtoken_user','2026-03-26 10:29:24.813777'),(40,'token_blacklist','0013_alter_blacklistedtoken_options_and_more','2026-03-26 10:29:25.204699'),(41,'users','0002_instructorlinks','2026-03-26 10:29:26.624346'),(42,'videos','0001_initial','2026-03-26 10:29:29.798895'),(43,'videos','0002_remove_videoprogress_watched_seconds','2026-03-26 10:29:30.509604'),(44,'videos','0003_remove_video_duration_video_slug','2026-03-26 10:29:32.045110'),(45,'cources','0004_remove_course_instructor','2026-03-27 01:40:34.337400'),(46,'videos','0004_video_video_upload','2026-04-09 18:10:23.320267'),(47,'videos','0005_alter_video_order','2026-04-09 20:26:32.456110'),(48,'videos','0006_video_duration_videoprogress_watched_seconds','2026-04-10 16:49:42.508447'),(49,'videos','0007_alter_videoprogress_watched_seconds','2026-04-10 17:19:54.559613'),(50,'quizzes','0003_question_question_type','2026-04-12 00:42:24.822388'),(51,'quizzes','0004_add_timestamps','2026-04-12 11:07:14.167321'),(52,'materials','0002_add_timestamps','2026-04-12 11:15:47.586934'),(53,'quizzes','0005_alter_quiz_options_attempt_updated_at_and_more','2026-04-15 12:20:25.094651'),(54,'cources','0005_course_instructor','2026-04-15 14:38:29.798801'),(55,'materials','0003_alter_material_options','2026-04-26 10:56:34.750984'),(56,'quizzes','0002_quiz_passing_percentage','2026-04-28 01:45:02.275551'),(57,'videos','0008_alter_video_options_and_more','2026-06-14 19:16:49.316297');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:07:20
