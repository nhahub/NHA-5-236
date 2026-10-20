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
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `otp` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_created_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` VALUES (1,'pbkdf2_sha256$1000000$jzhkXkoCfsJ1kz3xVUjrmN$xJZoUFXqqQVGv23Qi8FrCxQuzd/AxWlOnsuGkboBw7c=','2026-06-06 15:02:45.127956',1,'admin@gmail.com','Omnia','Abdelnasser','','-1f686124','admin',1,1,1,NULL,NULL,'2026-05-21 07:54:08.183351','2026-05-21 14:50:55.206943'),(2,'pbkdf2_sha256$1000000$KCvlcCbc9h2kD0Td4y1cv2$RXr1uvixu4FG8ydNb6ZIXX0DOE06JjZxr4/9nmx/WIw=',NULL,0,'omniaabdelnasser067@gmail.com','Omniya','Abdelnasser','','omnia-f0ecf516','student',1,0,1,NULL,NULL,'2026-05-21 08:18:16.551583','2026-05-21 17:48:46.503522'),(3,'pbkdf2_sha256$1000000$zFo05KBP73XdjSN1j5Raf2$7Go3I1ACOrBujaYvAyQIbjKU7BToWg3df+7mH8tGbh0=',NULL,0,'shahendamoawed@gmail.com','shahnda','abdelrahim','','shahnda-05983aec','student',1,0,1,NULL,NULL,'2026-05-21 08:52:20.768885','2026-05-22 22:35:33.952005'),(4,'pbkdf2_sha256$1000000$ofbN4wu2sc3aj65KCIW32n$rmQqxA04OVC91Kwup8WzKH36oD22cNxaXJA/N9dVtOA=',NULL,0,'rehamahmedfek@gmail.com','Reham','Ahmed','','reham-70936605','student',1,0,1,NULL,NULL,'2026-05-21 08:58:50.728784','2026-05-21 09:02:17.322010'),(5,'pbkdf2_sha256$1000000$AJ1LWfpdvw14XAPIi2SBTv$/d59gfg9TKY3DyfFuOdBgcshotVnF7+F1FMoAdE5kJE=',NULL,0,'abdallahalqiran765@gmail.com','Abdallah','Alqiran','','abdallah-422c8394','instructor',1,0,1,NULL,NULL,'2026-05-21 09:00:22.145493','2026-05-21 14:39:14.703220'),(6,'pbkdf2_sha256$1000000$tmFWL2AnBAyRZVbdwYgcWc$EUyiSIarPAkvBMpVwfm2ronEE+iBxLgehHz+3plWK88=',NULL,0,'rwanalrawy162@gmail.com','Rawan','bahaa','','rawan-ffaaaa6d','student',1,0,1,NULL,NULL,'2026-05-21 10:44:52.963259','2026-05-22 09:49:00.542200'),(7,'pbkdf2_sha256$1000000$M9GXyvgkRC8F1VHnVygIqF$Hh94c4WucRhIZq4VO4LeH73IwJ4fWbwJbbMp6VOlyKQ=',NULL,0,'rana@gmail.com','Rana','Badawy','','rana-b964f446','student',1,0,0,'935447','2026-05-21 10:44:58.690221','2026-05-21 10:44:58.672810','2026-05-21 10:44:58.690351'),(8,'pbkdf2_sha256$1000000$jBmcitXAsYVEExCGRXsWhQ$5cmPT9thXEgiTWkIL+ewHEepyEMVfn216bkZcdPP3FQ=',NULL,0,'ranaeng500238@gmail.com','Rana','Ahmed','','rana-bcd39f65','student',1,0,1,NULL,NULL,'2026-05-21 10:46:18.925499','2026-06-01 02:00:36.587938'),(9,'pbkdf2_sha256$1000000$jZHRz0ZhVf4RjubPHMpdAj$ienTTpCgWmdqet4en/Hcumiy7Ov4QBnJbiQ7vsEgdCQ=',NULL,0,'tahafawy2@gmail.com','Taha','Fawy','','taha-2250f23c','student',1,0,1,NULL,NULL,'2026-05-21 14:13:40.939959','2026-05-21 14:15:17.489138'),(10,'pbkdf2_sha256$1000000$KYNvF2t2LBREmmwzDn86uJ$QARn6s3+WzN2JCm+MgkLvUDYG5ba7Xo1z5DhFHOtOgc=',NULL,0,'tahasaberts1@gmail.com','Taha','Saber','photo/taha_KEyhrBg.jpeg','taha-562f2cf7','instructor',1,0,1,NULL,NULL,'2026-05-21 15:45:16.940179','2026-05-22 05:29:30.568892'),(11,'pbkdf2_sha256$1000000$5xSuQPA81sidWw7takr1y8$m/QuWhKn/TyWU6Zy/VS4ZHsBy2vkyJBdDLP/VXtXLHI=',NULL,0,'eljokerbogarib508@gmail.com','Taha','Saber','','taha-65c323f7','student',1,0,1,NULL,NULL,'2026-05-21 16:28:11.378992','2026-05-22 21:46:35.005445'),(13,'pbkdf2_sha256$1000000$oz10lwjRhxtF95GA6TjeH3$YCfr5bIjc73IwUhVcS4q+rIp/h9xycIDdPvRS5SRoic=',NULL,0,'ranabadawy832005@gmail.com','Rana','Badawy','','rana-10053299','student',1,0,1,NULL,NULL,'2026-05-22 14:57:08.517222','2026-05-26 21:41:22.880423'),(15,'pbkdf2_sha256$1000000$wM1d5MyUTnzOMolEh1YHMm$5/MtlvxBZJRTnUUAJMUCOsk9IYxqu4nLa7L6YgDAVQA=',NULL,0,'tahafawy1@gmail.com','Taha Mo','Fawy','','taha-mo-cf3e640c','instructor',1,0,1,NULL,NULL,'2026-05-22 20:57:50.443152','2026-05-22 20:57:50.457647'),(16,'pbkdf2_sha256$1000000$opLoQA5PkggVjJlBo9vNU9$0rAC2GFnB/veZRVlL6NoVBzI3bhATdPsgrYbpOVC1JQ=',NULL,0,'hfnym072@gmail.com','Hofny','Mohamed','','hofny-e4a87223','student',1,0,1,NULL,NULL,'2026-05-22 22:29:33.290476','2026-05-22 22:30:11.699858'),(18,'pbkdf2_sha256$1000000$BxMa3agG7K6ZJa3I7pcadF$x6I3chhwYzeIjRg+JyVKdynJk3BnaPr8nF0DT+5Gqvw=',NULL,0,'hamzahalqiran1@gmail.com','Hamzah','Mahmoud','','hamzah-b58560c0','instructor',1,0,1,NULL,NULL,'2026-05-23 03:52:33.617695','2026-05-23 04:17:16.198392'),(20,'pbkdf2_sha256$1000000$8rH1lFoJSP8INtlT92cY2g$ZsY4yuHCKta9T0PmfClMpBf83hS6rdjQUx/l3g6S5+8=',NULL,0,'suportqena@gmail.com','Support','Qena','photo/scaled_support.jpg','support-87e5626a','instructor',1,0,1,NULL,NULL,'2026-05-23 04:14:34.406055','2026-05-23 04:47:21.376112'),(21,'pbkdf2_sha256$1000000$azGUKhuUuffexyWhSNw8pB$7TOwLMonuJccdPSxVkq29ECfsZWRsTZyoAoLrj0cgXk=',NULL,0,'randafci@yahoo.com','Ahmed','Mohamed','','ahmed-9b3c1604','student',1,0,1,NULL,NULL,'2026-05-23 09:06:00.828487','2026-05-23 09:06:51.384326'),(22,'pbkdf2_sha256$1000000$bs4c91uTMWHKeNg4Jdg1tH$1m5ZlEM06zG9K5n+D3UCz37Pu1563OxQvuc6ElpYPlA=',NULL,0,'ahmedbelal08117@gmail.com','ahmed','belal','','ahmed-191aed59','instructor',1,0,1,NULL,NULL,'2026-05-23 09:20:58.793228','2026-05-23 09:20:58.799259'),(23,'pbkdf2_sha256$1000000$dLIeJJB9dsbCMIbT0QfUdI$9y8ofgdFKatJ0XXlsMguZW5DVPIxyxqHtTidrxSTEiI=',NULL,0,'husshashiem@gmail.com','Hussein','Hashem','photo/scaled_0000.jpg','hussein-5b701ff4','instructor',1,0,1,NULL,NULL,'2026-05-23 16:57:32.464670','2026-05-24 23:53:52.274816'),(24,'pbkdf2_sha256$1000000$4RpePurPcz9rZRBp9yw3aD$u/wgy3Pv2vxienTeLT9/mJJVHGSvR/bGUKbECXFgRXA=',NULL,0,'ahmedrania342@gmail.com','Rania','Ahmed','','rania-5d52bd44','student',1,0,1,NULL,NULL,'2026-05-25 10:50:10.081838','2026-05-25 10:50:35.633258'),(26,'pbkdf2_sha256$1000000$7zAk9BciH8dqAIgToAq35F$76a8qsRl4Wh8b5FhKRajrIh+VQz9aqpvODGQ4XrASgM=',NULL,0,'legendabdallah11@gmail.com','Abdallah','Mahmoud','','abdallah-87b74363','student',1,0,1,NULL,NULL,'2026-05-27 08:35:00.919816','2026-05-27 08:35:18.278679'),(28,'pbkdf2_sha256$1000000$Y378O2GUcCkQsRMdBZo2sH$0bKWxJR467YUk8pd1aJrlnoAK40vMElZ/fFtKblK53g=',NULL,0,'abdullahalqiran@gmail.com','Abdallah','Mahmoud','','abdallah-cfbc6d7b','student',1,0,1,NULL,NULL,'2026-05-27 10:44:27.049992','2026-05-27 10:45:47.494921'),(29,'pbkdf2_sha256$1000000$1oZQYEvR7PZCWHeiMRdmFd$v9HXE/xQCZ2dqWbuyWUrEQHlzfA/w/1/fQKsSkxq6rk=',NULL,0,'abdallahalqiran76@gmail.com','Abdallah','Alqiran','','abdallah-a25be087','student',1,0,1,NULL,NULL,'2026-05-27 10:59:35.742242','2026-06-12 13:03:45.798255'),(30,'pbkdf2_sha256$1000000$jj188lSjnZJlfzK2VeyCF6$4qWkbYmVa+pgeuIAHBRVxl/SVGBr2PtFAw84+dYNOy0=',NULL,0,'shahdabdalgny123@gmail.com','Shahd','Abdelghany','','shahd-1cf5f40c','student',1,0,1,NULL,NULL,'2026-05-29 13:30:29.182262','2026-05-29 13:31:14.462673'),(31,'pbkdf2_sha256$1000000$c7ZzqsSA2Za6vJvgXsH0Ay$7e7g9YuYnkeD6VSRNMRGLlogViy+anrAFuyUsbQ+0PE=',NULL,0,'ziad1942007@gmail.com','Ziad','Ashraf','','ziad-0b3f3445','student',1,0,1,NULL,NULL,'2026-05-29 13:46:33.382410','2026-06-20 13:28:28.835099'),(32,'pbkdf2_sha256$1000000$1coeLVmAzpkgN0nzTyje8e$uQOZrj7kXGRal3JEorZ88TbG1HBfgCuDenaBuoWqIwY=',NULL,0,'darkzid9@gmail.com','Ziad','Yaseen','','ziad-fa5a8bef','student',1,0,1,NULL,NULL,'2026-05-29 13:52:24.474852','2026-07-16 21:32:21.289569'),(33,'pbkdf2_sha256$1000000$f3UFyf7DQytPTWOs1u0VQJ$uD3BfzWrQ/5ddHNftPpFTCmcmQhxN0R1z5QmX84IPA4=',NULL,0,'0039d12918@emailinbo.live','ABDELRAHEEM','AHMAD','','abdelraheem-2dec54fd','student',1,0,1,NULL,NULL,'2026-05-29 15:17:21.583421','2026-05-29 15:18:28.476961'),(34,'pbkdf2_sha256$1000000$pQkHXbjRwDzqbBSuYDNFJS$K6Zc/TKPziNESCTFpr6owaxJsn21RzHMy3zCioZYP5A=',NULL,0,'kabici.mix@gmail.com','Mostafa','Kabici','','mostafa-606a036f','student',1,0,1,NULL,NULL,'2026-05-29 18:38:41.938397','2026-05-29 18:40:44.937587'),(35,'pbkdf2_sha256$1000000$gqHOGPiet6bMaBhmbA7tLe$GVaDQJuoIb1G+E0w94ZRVQPipPP4nZmFDg+WtNwzVAk=',NULL,0,'ahmedhatembusiness1@gmail.com','Ahmed','Hatem','','ahmed-3edd5738','student',1,0,1,NULL,NULL,'2026-05-29 21:17:36.948257','2026-05-29 21:19:02.942770'),(36,'pbkdf2_sha256$1000000$EXqib5jAlnNfTpcPn5s19y$UJYneKIv5JiplR7LJjwziNNrmx04VG7UeAOd2MJikjY=',NULL,0,'plkog6@gmail.com','....','.....','','-82b5a23d','student',1,0,1,NULL,NULL,'2026-05-29 22:23:46.432128','2026-05-29 22:24:16.677993'),(37,'pbkdf2_sha256$1000000$fp5KU5VrwLRVqvbwevEoHb$U998NMg75cF00YOLztXFg81fayCWMW+cSp7iKSj7Ll0=',NULL,0,'adelmoubatk321@gmail.com','Ahmed','Adel','','ahmed-6566c837','student',1,0,1,NULL,NULL,'2026-05-31 15:28:14.803126','2026-05-31 15:29:55.158753'),(38,'pbkdf2_sha256$1000000$7mkjSyf1qn1YGCrvyEvNlu$6jgsaMwfggODN1vB85BanJXpZ+0/PeLtH8f3GvHHt5A=',NULL,0,'ranaengpro500238@gmail.com','Rana','Badawy','','rana-4ee0af18','student',1,0,1,NULL,NULL,'2026-05-31 17:18:43.269564','2026-05-31 17:19:22.177310'),(39,'pbkdf2_sha256$1000000$tlk0pzKhioDIMNmNqJnaIa$FEcExlqCKA7Ygf24xKFmwPAMQpnMYKNJnBJF/MTqREQ=',NULL,0,'ahmdalmhmwd939@gmail.com','احمد','محمد','','-6f60b340','student',1,0,1,NULL,NULL,'2026-05-31 19:12:53.685726','2026-05-31 19:13:18.462232'),(40,'pbkdf2_sha256$1000000$EuCHjQyOqqX5SY3sn0P20d$N6qYTGxl88QFH8jzRoKoQh//u/1+5xPzjk5GB5pphe4=',NULL,0,'rana832005@gmail.com','Rana','Badawy','','rana-cee76aea','student',1,0,1,NULL,NULL,'2026-05-31 21:39:22.828090','2026-05-31 21:41:17.759569'),(41,'pbkdf2_sha256$1000000$deGImHBwbHx2Ook61tam9Y$d7DYjfVh6T8g9dZA57lO38HNW0p97lBntfYexURHNsc=',NULL,0,'safaa3bdelkhalek@gmail.com','safaa','abdelkhaleq','','safaa-7ccaaaa5','student',1,0,0,'899246','2026-06-01 09:46:06.222516','2026-06-01 09:46:06.196315','2026-06-01 09:46:06.222650'),(42,'pbkdf2_sha256$1000000$mwUlORTyDJ08kBHC1FnZF8$cN7tpIZMlQvtZB0nY6gmk0V0MM3yYDp6nm6UuJKRqQE=',NULL,0,'akrambahy0@gmail.com','Akram','Bahy','','akram-e5c0c531','instructor',1,0,1,NULL,NULL,'2026-06-02 16:26:24.636257','2026-06-02 16:26:24.642734'),(43,'pbkdf2_sha256$1000000$dgRPhyunRgVDNUY0Bzi0g7$t6bKxLPPziJupRYVFJYqrq3lpS5PU3gaiMYzilrLmEM=',NULL,0,'ahmedmahmoudmos@gmail.com','Ahmed','Mahmoud','','ahmed-b5e8030c','student',1,0,1,NULL,NULL,'2026-06-02 21:33:47.526423','2026-06-02 21:34:44.473594'),(44,'pbkdf2_sha256$1000000$jpwKuZxLSw0jvC8Tex8TyA$XrYCVLd+zUU8/09QAABHbzag5K4VeXVmgxZSttQ3KLY=',NULL,0,'zahraaabozaid06@gmail.com','Alzahraa','Abozaid','','alzahraa-6b7e2439','student',1,0,1,NULL,NULL,'2026-06-03 12:51:03.095052','2026-06-03 12:51:34.484712'),(45,'pbkdf2_sha256$1000000$leB5dys5DG3NnKEEKnTaFr$xMUX9OKhcqimhajOwvSrLjg7frOds284biNWXVTusuU=',NULL,0,'bakrm1921@gmail.com','Mohamed','Bakr','','mohamed-73f41b10','student',1,0,1,NULL,NULL,'2026-06-07 11:41:53.615689','2026-06-07 19:17:56.201514'),(49,'pbkdf2_sha256$1000000$ddUWdy7E4lHy0YKBfhLnee$PN6iTo0Ik+/0tPBSRA+xYVkZqc3rAsSjxD+2lfx4d7Y=',NULL,0,'omniaabdelnasser0@gmail.com','12','12','','12-e3bd6194','student',1,0,0,'864670','2026-06-21 09:15:21.759286','2026-06-21 09:14:19.435183','2026-06-21 09:15:21.759404'),(50,'pbkdf2_sha256$1000000$DM9H1s3ejKWVw3POAqgQNp$1P+6N84ivsXdh2VLAxLWunQ+ujJdoNd2qV8CLklXZBk=',NULL,0,'omnia@gmail.com','0','0','','0-bb99bf37','student',1,0,0,'484722','2026-06-21 09:16:01.540011','2026-06-21 09:16:01.509737','2026-06-21 09:16:01.540190'),(51,'pbkdf2_sha256$1000000$2zKCFRhscpDNbmSoEzxqaZ$azQmwmcRap0yeOM2AgVWkXOy1XB3R42x67VVN/AFpS8=',NULL,0,'mohamedbakrcpp@gmail.com','Mohamed','Bakr','','mohamed-152c31b6','student',1,0,0,'994025','2026-06-28 19:24:09.634880','2026-06-28 19:24:09.568534','2026-06-28 19:24:09.635020');
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:10:31
