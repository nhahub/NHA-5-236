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
-- Table structure for table `cources_course`
--

DROP TABLE IF EXISTS `cources_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cources_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `level` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `instructor_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `cources_course_instructor_id_fk_users_instructor_id` (`instructor_id`),
  CONSTRAINT `cources_course_instructor_id_fk_users_instructor_id` FOREIGN KEY (`instructor_id`) REFERENCES `users_instructor` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cources_course`
--

LOCK TABLES `cources_course` WRITE;
/*!40000 ALTER TABLE `cources_course` DISABLE KEYS */;
INSERT INTO `cources_course` VALUES (1,'Kotlin Course','kotlin-course-f2373261','Full Mobile Development course',0.00,'Mobile','beginner','courses/kotlin_logo.png','2026-05-21 09:11:54.656282',1,1),(2,'Flutter course','flutter-course-19a547be','Flutter course from zero to hero',0.00,'Mobile','beginner','courses/flutter-logo.png','2026-05-21 09:48:51.731385',1,1),(7,'Flutter Masterclass - (Dart,Flutter,StateManagment  & Api)','flutter-masterclass-dartflutterstatemanagment-api-','Flutter Masterclass – Dart, Flutter, State Management & API\nMaster Flutter development from scratch and learn how to build high-performance, modern mobile applications for both Android and iOS using a single codebase.\n\nIn this course, you will start with the fundamentals of Dart programming, then move step-by-step into building professional UI designs with Flutter, managing application state efficiently, and integrating real-world APIs.\n\nThis masterclass is designed for beginners and intermediate developers who want practical, hands-on experience through real projects and modern development practices.\n\n? What You’ll Learn\n\nDart programming fundamentals\nBuilding responsive UI with Flutter\nNavigation & Routing\nWorking with Flutter Widgets\nState Management concepts and implementation\nAPI Integration & HTTP Requests\nJSON Parsing\nClean Code & Best Practices\nFirebase & Backend basics\nBuilding real-world applications\nPreparing apps for production and deployment\n\n? By the end of this course, you will be able to create complete Flutter applications with clean architecture and real-world functionality, giving you the skills needed for freelancing or professional mobile app development careers.',0.00,'Flutter','intermediate','courses/dart.png','2026-05-23 02:29:14.752086',1,2),(8,'Flutter - Advanced Course','flutter-advanced-course-b92d2dcc','Flutter – Advanced Course\n\nTake your Flutter skills to the next level and learn how to build scalable, high-performance, and production-ready mobile applications using advanced Flutter concepts and professional development techniques.\n\nThis course is designed for developers who already know the basics of Flutter and want to dive deeper into advanced UI development, clean architecture, state management, API optimization, animations, performance tuning, and real-world app structures used in professional projects.\n\nThrough hands-on projects and practical examples, you’ll gain the experience needed to develop complex applications with confidence and industry-level standards.\n\n? What You’ll Learn\n\nAdvanced Flutter Widgets & Custom UI\nClean Architecture & Project Structure\nAdvanced State Management Techniques\nAPI Integration & Error Handling\nPerformance Optimization\nAnimations & Transitions\nLocal Storage & Caching\nFirebase Integration\nDependency Injection\nResponsive & Adaptive Design\nReal-Time Applications\nAdvanced Debugging Techniques\nProduction-Level Best Practices\n\n? By the end of this course, you’ll be able to build advanced Flutter applications with scalable architecture, optimized performance, and professional-grade code suitable for real-world production environments.',0.00,'Flutter','advanced','courses/flutter_ucd87ya.jpg','2026-05-23 02:30:29.570507',1,2),(9,'Android Jetpack Compose: Complete Beginner\'s Guide [Arabic]','android-jetpack-compose-complete-beginners-guide-a','Android Jetpack Compose: Complete Beginner\'s Guide [Arabic]\n\nStart your Android development journey from scratch and learn how to build modern, beautiful, and fully functional Android applications using Jetpack Compose — Google’s latest UI toolkit for Android development.\n\nThis course is specially designed for Arabic-speaking beginners who want to learn Android app development in a simple, practical, and step-by-step approach without any prior experience.\nYou’ll learn the fundamentals of Kotlin programming, understand how Jetpack Compose works, and build real-world Android applications with modern development practices used by professional developers.\nWhat You’ll Learn\nKotlin Programming Basics\nIntroduction to Android Development\nBuilding Modern UI with Jetpack Compose\nWorking with Composable Functions\nState Management in Compose\nNavigation Between Screens\nLists, Cards & Layouts\nMaterial Design 3\nHandling User Input & Forms\nAPI Integration & JSON Parsing\nMVVM Architecture Basics\nFirebase Integration\nClean Code & Best Practices\nBuilding Real Android Projects\nPreparing Apps for Release\n\nBy the end of this course, you’ll have the skills to create modern Android applications using Jetpack Compose and start your journey as an Android Developer with confidence.',0.00,'Mobile','beginner','courses/kotlen.jpg','2026-05-23 02:31:46.672774',1,2),(10,'API Testing Masterclass','api-testing-masterclass-2b32ad77','Master API Testing from scratch and learn how to test REST APIs professionally using industry-standard tools and real-world workflows.\n\nIn this course, you will learn the fundamentals of APIs, how client-server communication works, and how to perform manual and automated API testing using tools like Postman. You’ll also explore authentication methods, status codes, request handling, and real-world testing scenarios used by QA engineers and backend developers.\n\nThis course is designed for beginners, testers, developers, and anyone who wants to improve their backend testing skills with practical examples and hands-on projects.\n\n? What You’ll Learn\n\nIntroduction to APIs & REST Architecture\nUnderstanding HTTP Methods & Status Codes\nWorking with JSON Data\nAPI Requests & Responses\nTesting APIs using Postman\nAuthentication & Authorization\nHeaders, Params & Environment Variables\nWriting API Test Cases\nAutomated API Testing Basics\nError Handling & Validation\nReal-World API Testing Projects\nBest Practices for API Testing\nBy the end of this course, you’ll be able to test APIs confidently, automate requests, and work with backend services like a professional QA engineer or developer',0.00,'Flutter','intermediate','courses/API.jpg','2026-05-23 02:34:42.557701',1,2),(11,'Dart Masterclass – From Zero to Professional','dart-masterclass-from-zero-to-professional-be72404','Master the Dart programming language from scratch and build a strong foundation for Flutter and modern app development.\n\nThis course is designed for beginners and aspiring developers who want to learn Dart in a simple, practical, and step-by-step approach. You’ll understand programming fundamentals, object-oriented programming concepts, and advanced Dart features through hands-on examples and real coding exercises.\n\nWhether you want to become a Flutter developer or improve your programming skills, this course will give you the knowledge and confidence to write clean and efficient Dart code.\n\n? What You’ll Learn\n\nDart Fundamentals & Syntax\nVariables, Data Types & Operators\nFunctions & Control Flow\nObject-Oriented Programming (OOP)\nClasses, Objects & Constructors\nCollections & Data Structures\nNull Safety in Dart\nAsync Programming & Futures\nStreams & Error Handling\nClean Code Principles\nProblem Solving & Real Examples\nAdvanced Dart Concepts\nPreparing for Flutter Development\n\n? By the end of this course, you’ll have a solid understanding of Dart programming and be fully prepared to start building real-world applications with Flutter confidently.',0.00,'Mobile','beginner','courses/dart2.jpg','2026-05-23 02:36:56.276855',1,2),(12,'Flutter Masterclass – From Zero to Professional','flutter-masterclass-from-zero-to-professional-4335','Become a professional Flutter developer and learn how to build powerful, modern, and cross-platform mobile applications from scratch using Flutter and Dart.\n\nThis course is designed for beginners and aspiring developers who want to master Flutter step by step through practical projects, real-world applications, and industry-standard development practices.\n\nYou’ll start with Dart fundamentals, then move into building beautiful UI designs, managing app state, integrating APIs, and creating complete mobile applications for Android and iOS using a single codebase.\n\n? What You’ll Learn\n\nDart Programming Fundamentals\nFlutter Basics & Project Structure\nBuilding Responsive UI with Flutter\nWorking with Widgets & Layouts\nNavigation & Routing\nState Management Techniques\nAPI Integration & HTTP Requests\nJSON Parsing & Backend Communication\nFirebase Integration\nLocal Storage & Shared Preferences\nClean Architecture & Best Practices\nAnimations & Modern UI Design\nBuilding Real-World Applications\nApp Optimization & Deployment\n By the end of this course, you’ll be able to build complete Flutter applications professionally and confidently start your journey as a mobile app developer or freelancer.',0.00,'Flutter','intermediate','courses/flutter_xLanfbW.jpg','2026-05-23 02:37:57.261743',1,2),(13,'أخلاقيات الحاسب','-642c966c','مادة أخلاقيات الحاسب لسنة أولي الترم الأول',0.00,'university subject','beginner','courses/Screenshot_2026-05-23_070825.png','2026-05-23 04:08:41.485969',1,6),(14,'History of computer','history-of-computer-77c600d3','in this subject explained the history of the computer from the past until today',0.00,'University subject','beginner','courses/Screenshot_2026-05-23_071025.png','2026-05-23 04:10:36.635376',1,6),(15,'Sceintific thinking','sceintific-thinking-b265545c','Learn how to think as professional person',0.00,'University Subject','beginner','courses/Screenshot_2026-05-23_071046.png','2026-05-23 04:11:40.414756',1,6),(16,'Git and Github','git-and-github-473807ac','This course full guide to learn git and github.',0.00,'github','beginner','courses/github_logo.jpg','2026-05-23 04:22:27.909049',1,8),(17,'Database Course','database-course-8045185e','Database course explained during sesson 1 in Support Community',0.00,'fundamentals','beginner','courses/Screenshot_2026-05-23_074337.png','2026-05-23 04:43:51.137601',1,8),(18,'Front-End Course','front-end-course-0ce2fba0','course explained during support session 1',0.00,'front-end','beginner','courses/anti4.webp','2026-05-23 04:50:34.811412',1,8),(19,'fast and fast','fast-and-fast-6343e8ef','This course is a full guide for mastering keyboard shortcuts and typing speed',0.00,'development','advanced','courses/type_thumbnail.jpg','2026-05-23 05:07:31.946103',1,1),(20,'Top Sql 50 Study Plan From Leetcode','top-sql-50-study-plan-from-leetcode-b97cfb1c','Solve SQL problems from leetcode',0.00,'Programming','beginner','courses/course_thumbnail.jpg','2026-05-24 23:38:17.302927',1,10);
/*!40000 ALTER TABLE `cources_course` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:07:33
