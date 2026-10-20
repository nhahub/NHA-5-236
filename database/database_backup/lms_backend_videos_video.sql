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
-- Table structure for table `videos_video`
--

DROP TABLE IF EXISTS `videos_video`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `videos_video` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_url` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int unsigned DEFAULT NULL,
  `course_id` bigint NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_upload` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `duration` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `unique_video_order_per_course` (`course_id`,`order`),
  KEY `idx_course_video_order` (`course_id`,`order`),
  KEY `idx_course_video_status` (`course_id`,`status`),
  KEY `idx_course_video_created` (`course_id`,`created_at`),
  CONSTRAINT `videos_video_course_id_6362c64c_fk_cources_course_id` FOREIGN KEY (`course_id`) REFERENCES `cources_course` (`id`),
  CONSTRAINT `videos_video_chk_2` CHECK ((`order` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `videos_video`
--

LOCK TABLES `videos_video` WRITE;
/*!40000 ALTER TABLE `videos_video` DISABLE KEYS */;
INSERT INTO `videos_video` VALUES (1,'generate pdf','https://www.youtube.com/watch?v=xsOZSfTU-II',1,1,'generate-pdf-05c44432','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(13,'omnia','https://youtube.com/shorts/WdAJoQQMOjk?si=5WDPZG_2c-XEw03T',2,1,'dshdvdj','',NULL,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(18,'install code blocks','',3,1,'install-code-blocks-605cd1a0','videos/codeblocks_install_2.mp4',80000000,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(19,'cubit task','',1,2,'cubit-task-74a9951f','videos/cubit_task.mp4',33000000,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(20,'Abdallah video','https://www.youtube.com/watch?v=ONWNy2K_thU&t=4s',2,2,'abdallah-video-a81f0fbf','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(22,'Introduction to Database','https://www.youtube.com/watch?v=cAyzl7sPtZY&t=61s',1,17,'introduction-to-database-4c2956a1','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(23,'Pointers in C++','https://www.youtube.com/watch?v=QqvwhBICrZo',2,17,'pointers-in-c-29645ab8','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(25,'test1293','https://youtube.com/shorts/WdAJoQQMOjk?si=5WDPZG_2c-XEw03T',4,1,'dhfgjh','',NULL,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(26,'Menaaa','https://youtube.com/shorts/rSSx6nO1igg?si=HRVWSAm7EJt_bPGm',5,1,'menaaa-8fa17a8b','',NULL,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(27,'Recyclable and Low Fat Products #1','https://www.youtube.com/watch?v=7QDUz30goyA&list=PLwly7QEGUW6LqIo4w8V9au9l4xx5ix29C&index=1&pp=iAQBsAgC',1,20,'recyclable-and-low-fat-products-1-8751118e','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(28,'Find Customer Referee #2','https://www.youtube.com/watch?v=eJuWPDdVl28&list=PLwly7QEGUW6LqIo4w8V9au9l4xx5ix29C&index=2&pp=iAQBsAgC',2,20,'find-customer-referee-2-2649e46f','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(29,'Full Git and Github tutorial','https://www.youtube.com/watch?v=XIFeRX1SNog',1,16,'full-git-and-github-tutorial-e00e770c','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(30,'learn fast typing','https://www.youtube.com/watch?v=VEtLyEBNcBg&t=15s',1,19,'learn-fast-typing-7fd5d076','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(31,'vs code shortcuts v1','https://www.youtube.com/watch?v=ZGUG00Ur5kE',2,19,'vs-code-shortcuts-v1-b9a4127c','',0,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(32,'Type fast','',3,19,'type-fast-cf294258','videos/best_typing_video.mp4',509000000,'2026-06-14 19:16:41.829727','processing','2026-06-14 19:16:43.034263'),(33,'code blocks install','',4,19,'code-blocks-install-6a877267d305','videos/codeblocks_install_2_7uLrQrk.mp4',NULL,'2026-06-14 20:32:29.698579','processing','2026-06-14 20:32:29.698621'),(34,'test uploading video','',5,19,'test-uploading-video-cecb6b7936cf','videos/broke_video_QeYooeA.mp4',NULL,'2026-06-14 20:36:52.794848','processing','2026-06-14 20:36:52.794881'),(35,'test uploading video','',6,19,'test-uploading-video-f5b793dd1c10','videos/broke_video_Wvob2C7.mp4',NULL,'2026-06-14 20:38:35.645263','processing','2026-06-14 20:38:35.645418'),(36,'test upload','',7,19,'test-upload-a64dcb1ae84b','videos/test-upload-a64dcb1ae84b_h264.mp4',14007007,'2026-06-14 20:46:10.864889','ready','2026-06-14 20:46:10.864963'),(37,'test upload','',8,19,'test-upload-c50dbaadeebd','videos/test-upload-c50dbaadeebd_h264.mp4',80300000,'2026-06-14 20:49:05.399290','ready','2026-06-14 20:49:05.399371'),(38,'test upload','',9,19,'test-upload-099d5b904461','videos/broke_video_xhAeOG5.mp4',NULL,'2026-06-14 21:14:49.609824','processing','2026-06-14 21:14:49.609898'),(40,'test upload','',10,19,'test-upload-692c4b1f116a','videos/test-upload-692c4b1f116a_h264.mp4',89133333,'2026-06-14 21:19:53.321888','ready','2026-06-14 21:19:53.321972'),(41,'upload to server from the dashboard','',11,19,'upload-to-server-from-the-dashboard-0dd2166d7c24','videos/codeblocks_install_2_V4StbBw.mp4',NULL,'2026-06-14 21:26:32.247593','processing','2026-06-14 21:26:32.247636'),(42,'typing video','',12,19,'typing-video-370d22367451','videos/best_typing_video_NdSL5Fl.mp4',NULL,'2026-06-15 18:25:19.562036','processing','2026-06-15 18:25:19.562488'),(43,'test upload','',13,19,'test-upload-b4d8b67b6b37','videos/codeblocks_install_2_899vqnX.mp4',NULL,'2026-06-15 19:50:54.918946','processing','2026-06-15 19:50:54.918996'),(44,'test upload remote','',14,19,'test-upload-remote-b6af84c06f67','videos/codeblocks_install_2_QeajZAQ.mp4',NULL,'2026-06-15 20:03:55.300193','processing','2026-06-15 20:03:55.300236'),(45,'mezan video','',15,19,'mezan-video-3f13952624c1','videos/mezan_video.mp4',NULL,'2026-06-15 20:12:01.412864','processing','2026-06-15 20:12:01.412943'),(46,'mezan video after cluade modifications','',16,19,'mezan-video-after-cluade-modifications-6bbdaf51dc0','videos/mezan_video_ihEwSGs.mp4',NULL,'2026-06-15 20:42:16.240127','processing','2026-06-15 20:42:16.240191');
/*!40000 ALTER TABLE `videos_video` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:07:38
