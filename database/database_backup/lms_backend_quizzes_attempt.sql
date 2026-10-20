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
-- Table structure for table `quizzes_attempt`
--

DROP TABLE IF EXISTS `quizzes_attempt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_attempt` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `attempt_number` int unsigned NOT NULL,
  `score` int unsigned NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempt_date` datetime(6) NOT NULL,
  `student_id` bigint NOT NULL,
  `quiz_id` bigint NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `quizzes_attempt_student_id_quiz_id_attempt_number_bdeabcfc_uniq` (`student_id`,`quiz_id`,`attempt_number`),
  UNIQUE KEY `slug` (`slug`),
  KEY `quizzes_att_student_eb00a8_idx` (`student_id`,`quiz_id`),
  KEY `quizzes_attempt_quiz_id_5dc3f292_fk_quizzes_quiz_id` (`quiz_id`),
  KEY `quizzes_att_slug_97ed64_idx` (`slug`),
  CONSTRAINT `quizzes_attempt_quiz_id_5dc3f292_fk_quizzes_quiz_id` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes_quiz` (`id`),
  CONSTRAINT `quizzes_attempt_student_id_e3bf362d_fk_users_user_id` FOREIGN KEY (`student_id`) REFERENCES `users_user` (`id`),
  CONSTRAINT `quizzes_attempt_chk_1` CHECK ((`attempt_number` >= 0)),
  CONSTRAINT `quizzes_attempt_chk_2` CHECK ((`score` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes_attempt`
--

LOCK TABLES `quizzes_attempt` WRITE;
/*!40000 ALTER TABLE `quizzes_attempt` DISABLE KEYS */;
INSERT INTO `quizzes_attempt` VALUES (2,1,0,'failed','2026-05-22 09:49:46.940430',6,6,'rwanalrawy162gmailcom-flutte-quiz-1-at-1-e66c','2026-05-22 09:49:46.953458'),(3,2,1,'passed','2026-05-22 09:49:51.508093',6,6,'rwanalrawy162gmailcom-flutte-quiz-1-at-1-7ba2','2026-05-22 09:49:51.511615'),(7,1,0,'failed','2026-05-22 13:31:09.667409',9,7,'tahafawy2gmailcom-flutte-quiz-2-at-1-ba99','2026-05-22 13:31:09.670162'),(8,2,10,'passed','2026-05-22 13:31:23.764850',9,7,'tahafawy2gmailcom-flutte-quiz-2-at-1-6f31','2026-05-22 13:31:23.768573'),(9,1,1,'passed','2026-05-22 13:32:19.790829',9,6,'tahafawy2gmailcom-flutte-quiz-1-at-1-f4d5','2026-05-22 13:32:19.793860'),(10,1,1,'passed','2026-05-22 13:32:33.276830',9,1,'tahafawy2gmailcom-quiz-at-1-e1af','2026-05-22 13:32:33.284452'),(11,1,1,'passed','2026-05-22 13:32:45.694328',9,2,'tahafawy2gmailcom-quiz1-at-1-74d7','2026-05-22 13:32:45.698495'),(12,2,0,'failed','2026-05-22 13:33:02.974939',9,2,'tahafawy2gmailcom-quiz1-at-1-0197','2026-05-22 13:33:02.977606'),(13,1,10,'passed','2026-05-22 15:13:03.474892',13,7,'ranabadawy832005gmailcom-flutte-quiz-2-at-1-0b5c','2026-05-22 15:13:03.483155'),(16,1,10,'failed','2026-05-23 06:00:11.488156',11,13,'eljokerbogarib508gmailcom-advanced-git-project-recovery-at-1-1c7e','2026-05-23 06:00:11.493619'),(17,1,0,'failed','2026-05-23 08:38:39.979871',11,12,'eljokerbogarib508gmailcom-collaboration-pull-requests-open-source-at-1-e6ff','2026-05-23 08:38:39.985261'),(18,1,0,'failed','2026-05-23 09:09:41.014387',21,18,'randafciyahoocom-indexes-views-and-performance-tuning-at-1-54f8','2026-05-23 09:09:41.024146'),(19,2,10,'failed','2026-05-23 11:39:31.818898',11,12,'eljokerbogarib508gmailcom-collaboration-pull-requests-open-source-at-1-4dc6','2026-05-23 11:39:31.827819'),(20,1,1,'passed','2026-05-25 18:50:59.305334',13,6,'ranabadawy832005gmailcom-flutte-quiz-1-at-1-d2b2','2026-05-25 18:50:59.315858'),(21,1,1,'passed','2026-05-25 18:51:22.030063',13,2,'ranabadawy832005gmailcom-quiz1-at-1-320a','2026-05-25 18:51:22.039749'),(22,1,1,'passed','2026-05-25 18:51:40.479220',13,1,'ranabadawy832005gmailcom-quiz-at-1-f0ed','2026-05-25 18:51:40.485975'),(23,1,10,'failed','2026-05-27 11:04:02.323368',29,19,'abdallahalqiran76gmailcom-visual-studio-code-navigation-and-core-editing-at-1-06a6','2026-05-27 11:04:02.342065'),(24,2,10,'failed','2026-05-27 11:11:37.249307',29,19,'abdallahalqiran76gmailcom-visual-studio-code-navigation-and-core-editing-at-1-d036','2026-05-27 11:11:37.261476'),(25,1,20,'failed','2026-05-27 11:11:38.466728',28,19,'abdullahalqirangmailcom-visual-studio-code-navigation-and-core-editing-at-1-5651','2026-05-27 11:11:38.476231'),(26,1,20,'failed','2026-05-27 11:13:00.616088',28,21,'abdullahalqirangmailcom-productivity-applications-and-document-design-at-1-cf87','2026-05-27 11:13:00.624759'),(27,1,20,'failed','2026-05-27 11:13:00.868252',29,20,'abdallahalqiran76gmailcom-windows-system-actions-and-app-management-at-1-edff','2026-05-27 11:13:00.877233'),(28,2,20,'failed','2026-05-27 11:15:36.773253',29,20,'abdallahalqiran76gmailcom-windows-system-actions-and-app-management-at-1-4efa','2026-05-27 11:15:36.783274'),(29,3,20,'failed','2026-05-27 11:16:31.564744',29,20,'abdallahalqiran76gmailcom-windows-system-actions-and-app-management-at-1-fbf6','2026-05-27 11:16:31.569942'),(30,2,40,'passed','2026-05-29 06:53:07.297933',28,19,'abdullahalqirangmailcom-visual-studio-code-navigation-and-core-editing-at-1-1d72','2026-05-29 06:53:07.316762'),(31,1,10,'passed','2026-05-31 22:13:23.638550',8,7,'ranaeng500238gmailcom-flutte-quiz-2-at-1-6bc2','2026-05-31 22:13:23.649741'),(32,1,0,'failed','2026-05-31 22:27:53.508327',8,13,'ranaeng500238gmailcom-advanced-git-project-recovery-at-1-c6b2','2026-05-31 22:27:53.519371'),(33,1,20,'failed','2026-06-01 01:38:13.751447',8,19,'ranaeng500238gmailcom-visual-studio-code-navigation-and-core-editing-at-1-468d','2026-06-01 01:38:13.763274'),(34,2,0,'failed','2026-06-01 01:39:03.415231',8,19,'ranaeng500238gmailcom-visual-studio-code-navigation-and-core-editing-at-1-6b6c','2026-06-01 01:39:03.423072'),(35,3,40,'passed','2026-06-01 01:39:53.477343',8,19,'ranaeng500238gmailcom-visual-studio-code-navigation-and-core-editing-at-1-7f3f','2026-06-01 01:39:53.487479'),(36,1,50,'passed','2026-06-01 01:41:21.368257',8,21,'ranaeng500238gmailcom-productivity-applications-and-document-design-at-1-9d59','2026-06-01 01:41:21.374760'),(37,1,40,'passed','2026-06-03 15:44:22.547449',3,20,'shahendamoawedgmailcom-windows-system-actions-and-app-management-at-1-806f','2026-06-03 15:44:22.583858'),(38,1,10,'failed','2026-06-15 22:16:04.868973',9,21,'tahafawy2gmailcom-productivity-applications-and-document-design-at-1-1207','2026-06-15 22:16:04.904405');
/*!40000 ALTER TABLE `quizzes_attempt` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:10:25
