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
-- Table structure for table `quizzes_quiz`
--

DROP TABLE IF EXISTS `quizzes_quiz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `quizzes_quiz` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quiz_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `total_mark` int NOT NULL,
  `max_attempts` int unsigned NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `course_id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `passing_percentage` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `quizzes_quiz_course_id_6476d9c4_fk_cources_course_id` (`course_id`),
  CONSTRAINT `quizzes_quiz_course_id_6476d9c4_fk_cources_course_id` FOREIGN KEY (`course_id`) REFERENCES `cources_course` (`id`),
  CONSTRAINT `quizzes_quiz_chk_1` CHECK ((`max_attempts` >= 0)),
  CONSTRAINT `quizzes_quiz_chk_2` CHECK ((`passing_percentage` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quizzes_quiz`
--

LOCK TABLES `quizzes_quiz` WRITE;
/*!40000 ALTER TABLE `quizzes_quiz` DISABLE KEYS */;
INSERT INTO `quizzes_quiz` VALUES (1,'quiz','quiz',1,5,'quiz-quiz-01381a4c',2,'2026-05-21 12:05:17.882210','2026-05-21 12:05:17.882237',50),(2,'quiz1','quiz1',1,5,'quiz-quiz1-4412e502',2,'2026-05-21 12:06:16.505005','2026-05-21 12:06:16.505034',50),(6,'Flutte quiz 1','Please answer all questions',1,5,'quiz-flutte-quiz-1-ce9e134e',2,'2026-05-22 08:29:14.510757','2026-05-22 08:29:14.510786',50),(7,'Flutte quiz 2','',10,5,'quiz-flutte-quiz-2-1dababe2',2,'2026-05-22 08:29:39.128688','2026-05-22 08:29:39.128715',50),(9,'Git Basics and Local Version Control','Test your knowledge on core Git concepts including repositories, tracking files, staging, committing, and viewing project history.',100,3,'quiz-git-basics-and-local-version-control-b8982121',16,'2026-05-23 04:34:48.452077','2026-05-23 04:34:48.452104',70),(10,'Branching and Merging','Master isolation of workflows, creating features, safe experimentation, and merging branches together while handling conflicts.',100,3,'quiz-branching-and-merging-f800b7cb',16,'2026-05-23 04:35:04.750084','2026-05-23 04:35:04.750112',70),(11,'Introduction to GitHub & Remotes','Understand the differences between Git and GitHub, linking local repositories to cloud servers, and working with remote aliases.',100,3,'quiz-introduction-to-github-remotes-9a59f0d0',16,'2026-05-23 04:35:18.801494','2026-05-23 04:35:18.801534',75),(12,'Collaboration, Pull Requests, & Open Source','Learn the mechanics of working on shared teams, managing open-source forks, initiating Pull Requests (PRs), and keeping projects in sync.',100,3,'quiz-collaboration-pull-requests-open-source-9e6c8',16,'2026-05-23 04:35:31.611734','2026-05-23 04:35:31.611761',75),(13,'Advanced Git & Project Recovery','Handle complex scenarios: undoing errors, resetting states, stashing uncommitted changes, and reviewing advanced histories.',100,3,'quiz-advanced-git-project-recovery-53ad1755',16,'2026-05-23 04:35:45.870238','2026-05-23 04:35:45.870264',80),(14,'Database Normalization and Relational Architecture','Test your knowledge of core relational database design concepts, structural integrity, and the rules governing 1NF, 2NF, and 3NF.',10,10,'quiz-database-normalization-and-relational-archite',17,'2026-05-23 04:56:45.856081','2026-05-23 04:56:45.856107',50),(16,'Advanced SQL Joins and Aggregations','Test mastery over connecting tables via keys, using aggregate summary calculations, and separating matching criteria.',100,10,'quiz-advanced-sql-joins-and-aggregations-22c8cab0',17,'2026-05-23 04:58:07.918996','2026-05-23 04:58:07.919022',50),(17,'Transaction Management and ACID Properties','Evaluate understanding of database runtime safety, transactional boundaries, locking behaviors, and system error crash protection routines.',100,10,'quiz-transaction-management-and-acid-properties-3a',17,'2026-05-23 04:58:17.760794','2026-05-23 04:58:17.760821',50),(18,'Indexes, Views, and Performance Tuning','Test mechanics of optimizing data retrieval speeds, logical abstraction design, and analyzing execution cost plans.',100,10,'quiz-indexes-views-and-performance-tuning-2076ab52',17,'2026-05-23 04:58:24.004028','2026-05-23 04:58:24.004054',50),(19,'Visual Studio Code Navigation and Core Editing','Test your mastery over VS Code line operations, cursor jumping, block selection, and regional formatting shortcuts.',50,10,'quiz-visual-studio-code-navigation-and-core-editin',19,'2026-05-27 09:46:22.588421','2026-05-27 09:46:22.588446',50),(20,'Windows System Actions and App Management','Evaluate knowledge of global Windows desktop shortcuts, run panels, system status commands, and display adjustments.',70,10,'quiz-windows-system-actions-and-app-management-cc4',19,'2026-05-27 09:46:59.014923','2026-05-27 09:46:59.014950',50),(21,'Productivity Applications and Document Design','Test shortcut workflows for processing tools including Microsoft Excel, Word, Edge, and basic design interfaces.',70,10,'quiz-productivity-applications-and-document-design',19,'2026-05-27 09:47:07.799480','2026-05-27 09:47:07.799505',50);
/*!40000 ALTER TABLE `quizzes_quiz` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:07:13
