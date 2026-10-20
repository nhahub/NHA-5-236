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
-- Table structure for table `RECOVER_YOUR_DATA_info`
--

DROP TABLE IF EXISTS `RECOVER_YOUR_DATA_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `RECOVER_YOUR_DATA_info` (
  `READ_ME` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RECOVER_YOUR_DATA_info`
--

LOCK TABLES `RECOVER_YOUR_DATA_info` WRITE;
/*!40000 ALTER TABLE `RECOVER_YOUR_DATA_info` DISABLE KEYS */;
INSERT INTO `RECOVER_YOUR_DATA_info` VALUES ('Dear Sir/Madam,\r\n\r\nWe hope this message finds you well.\r\n\r\nWe would like to inform you that we have backed up your databases/tables. We keep them for 30 days and then will be publicly disclosed and permanently delete them from our servers.\r\n\r\nWe offer two options:\r\n\r\nOption 1.: recovery service + leak protection\r\n\r\nif you want to recover your corrupted or incomplete databases/tables and you want to prevent it from being leaked, simply transfer 0.018 BTC to this address:\r\n\r\n1GfkC4Tfc4cKfaYdctYpmE9XZ7Mn3nYqLs\r\n\r\nThis address is assigned to your database credentials (host + user: 52.204.125.193 + admin). We will know when you have paid.\r\n\r\nAfter payment confirmation, our program will restore the entire databases/tables automatically, so please do not change your database login details and make sure the database is still accessible from outside the local network. Don not worry. All your databases and tables will be restored. (If the restore fails the current field will be modified and provide links for you to download your datas). The saved files will be immediately deleted from our servers.\r\n\r\nOption 2.: leak protection only\r\n\r\nIf you don not need to restore your databases but you want to prevent it from being leaked, send 0.005 BTC to this address:\r\n\r\n1GfkC4Tfc4cKfaYdctYpmE9XZ7Mn3nYqLs\r\n\r\nIn this case, your datas will not be made public and will be deleted from our servers without any recovery service.\r\n\r\n-------------\r\nPlease take note of the following:\r\n\r\nAfter 30 days, we cannot guarantee the restoration of your data.\r\n\r\nThe only way to recover your data (and prevent it from being leaked) is by making the payment.\r\n\r\nData leaks can have serious consequences. Rest assured, your data is protected.\r\n\r\nWe have already exposed over 40TB of data. You do not want yours to add to that number, do you?\r\n\r\nOnce your payment is completed, all your data will be deleted from our servers. Currently, government agencies, competitors, contractors, and local media remain unaware of the incident. Upon receiving your payment, we guarantee that these entities will not be contacted about this matter, ensuring your privacy and the confidentiality of the situation are maintained.\r\n\r\nPay now, and we guarantee that your data will not be sold on dark web resources or used to attack your company, employees, or counterparties in the future. The full database dump will be restored, and all other data will be immediately deleted from our servers.\r\n\r\nIf you do not send the requested amount within 30 days from the date of the incident, we will consider the transaction incomplete. Your data will then be sent to any interested parties. This is your responsibility.\r\n\r\nAfter payment confirmation, our system will automatically restore the entire databases/tables, so please do not change your database login details and make sure the database is still accessible from outside the local network.\r\n\r\n-------------\r\nThe only accepted payment method is Bitcoin. To the wallet specified above.\r\n\r\nBe advised: PayPal, WeTransfer, Alipay, credit cards, and other methods will not be accepted.\r\n\r\nIf you do not have Bitcoin, you can purchase it using a credit card from the following websites:\r\n\r\nCoinbase: https://www.coinbase.com/\r\nMoonPay: https://www.moonpay.com/buy\r\nPaybis: https://paybis.com/\r\nChangelly: https://changelly.com/buy\r\nAqua: https://aqua.net/\r\nCEX: https://cex.io/\r\nHodlHodl: https://hodlhodl.com\r\n\r\nAlternatively, you can buy Bitcoin using other payment methods from the following platforms (some of them work in China):\r\n\r\nCoinbase: https://www.coinbase.com/\r\nPaxful: https://paxful.com/\r\nBinance: https://www.binance.com/\r\nCrypto.com: https://www.crypto.com/\r\nHuobi: https://www.huobi.com/\r\nOKCoin: https://www.okcoin.com/\r\nBTCC: https://www.btcc.com/\r\nPaybis: https://paybis.com/\r\nCoinmama: https://coinmama.com/\r\nBitfinex: https://www.bitfinex.com/\r\n\r\nFor users in China, Bitcoin can be purchased with Alipay from:\r\n\r\nCoinCola: https://www.coincola.com/?lang=zh-HK\r\nBitValve: https://www.bitvalve.com/buy-bitcoin/alipay \r\n\r\nThank you for your time and consideration. Good luck.\r\n\r\n');
/*!40000 ALTER TABLE `RECOVER_YOUR_DATA_info` ENABLE KEYS */;
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

-- Dump completed on 2026-09-25 21:07:52
