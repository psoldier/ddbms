-- MySQL dump 10.13  Distrib 5.5.41, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ddbms_development
-- ------------------------------------------------------
-- Server version	5.5.41-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_info` (
  `version` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_info`
--

LOCK TABLES `schema_info` WRITE;
/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` VALUES (2);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slaves`
--

DROP TABLE IF EXISTS `slaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slaves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adapter` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `database` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slaves`
--

LOCK TABLES `slaves` WRITE;
/*!40000 ALTER TABLE `slaves` DISABLE KEYS */;
INSERT INTO `slaves` VALUES (1,'mysql','localhost','root','root','slave_1','2015-04-07 20:33:38',NULL);
/*!40000 ALTER TABLE `slaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `crypted_password` text NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'pablo@pablo.com','72e779daa0d143ac2246d56fbb663f0d8552d3de288bec6f269dd892e3df101020a6c449821f29e4c320e115a54fedb147f28f58b2e498e18c06f45717bab6ed4f0e65c9f8001a09058fd0f177b24e7bee0c65589c1e86c2c614f889365ea2c4','Psoldier',0,'2015-04-07 20:33:35',NULL),(2,'mariel@mariel.com','b815b2beb88c47c13eb992b4eb76583862e3095410830bb339c32998455f3cff2de4377c86e241a21120ad78ae04c608d6e690ffba37835d3de8119a36a96cef93c08966a7f92788af46a90b35c6df14f5945eac0e0dc5e53b85ade9ee629b50','Mama',0,'2015-04-07 20:33:35',NULL),(3,'mario@mario.com','47a4d5071fb1f6f35544410adc7bfa2ea38e7b944a80895dcae61cbad1ad920cc91dce8da269082a2f034dcc4f1acef06189dd66696e769e403df357c7618acdc66bbd33af90eea1627b6c930d855d4201e3facd444e5b9df88e6c4adcf75ab5','Msoldier',0,'2015-04-07 20:33:35',NULL),(4,'juan@juan.com','1ffe6aeda7d5c619dc652b723f3a1679600f8ae03bb5dac5eac704369502c98ec0913ab499715c3840cda53e8926e88dc848fbb55fc894ba0a8d93cf1087d0c9f077f2bcdaee68e9ff9a9103b14b36a0f62feb0d81c438e1afd2c573cfdd6ff6','Jsoldier',0,'2015-04-07 20:33:36',NULL),(5,'pedro@pedro.com','fb90430063717da0e55f3845415c81f345ed9dba159b54e6534a009df815537c5f1be0be447f6e404bf53b778d080fedf0740b40a4ba953f7291ef589e075f1e8349737f1b632ab9d40a0d6e79e70d9b47c895ffca3bbf911434ee34b8ed3022','Pesoldier',0,'2015-04-07 20:33:36',NULL),(6,'santiago@santiago.com','e5c225466bd0a157e9f206a53368bcdb08671249ccd7f57743f0c953ae6014e41edad4c7bf5c27ad457f09d20dcc6672bf72db24d72a4d3592fdb4bd7d9293d18b20416e8efaf1493f675e0005206e1e126010008a63ee8866232b4e51cc8e67','Ssoldier',0,'2015-04-07 20:33:36',NULL),(7,'emilio@emilio.com','c65808a0dbb65e38fcc36ed48432f22aabcd0855d24817a517a474edcbe2311986c01af90546b14bd049fd2f24dc043be2b65551639689836008f79987f4cb14187fdd8b61d03499943df49a8336c4fd20b6a216ba8c7465849b130c89fb2357','Esoldier',0,'2015-04-07 20:33:36',NULL),(8,'daniel@daniel.com','bb1836b8a798c7cb25ef2b0c3555cb8ca7817ef93367281c86d8d958e84aca4e117a8959168a50c794f7ba1a4ba8fa8271aa803789653d231a6978b950c9aff8392ecf499aac4e98e6bdbc8c8fd09e9dbc35f16deffba369910cd6748d8d920e','Dsoldier',0,'2015-04-07 20:33:36',NULL),(9,'ana@ana.com','264a69898d536023d838b6c719f8cf9c39fbde824d1ba02d624637bd027d4c201e41a4ac2860f31a4825730b299d80b83a0ccf7ed96e8335a91c5ffa1ed15d6172a243da6eaf788c6aa583b89abe8abd8e4fd583b6d6c2583ecba5d46b923e8d','Asoldier',0,'2015-04-07 20:33:36',NULL),(10,'elsa@elsa.com','4ce1b5452f974c786f88544a67a78403c852aa70178de2670e5a794c920d5db4aac5da7d10123b9d6f51882f0f9d6255f2e3b4bb87589f4dd08efdcd1e7351c32a163b298838528b616447929d01485c35f38dc0493ddbd0b195b3165ddc7fa4','Esoldier',0,'2015-04-07 20:33:37',NULL),(11,'juancito@juancito.com','1c7ffe420373747a7a54d13f0909a8cea55a2a39f1f7f3252050c2acaabad24f7c6bc3cbc6c76bfc7b99c737ffabebee3a123b13a45025757c0e23678edd52be04f9924e17f3a586b3f4bdc6ea835b925498448d34297c67001f47b7c7a95a92','JAsoldier',0,'2015-04-07 20:33:37',NULL),(12,'mali@mali.com','0ab231fe049127478d0ec6b9c34ae66ec407d0ae1dae51d5e437cd99ae98c3d74169ae1f8087c22e68c56f155560924da52e974a8df56d455dd2a81e184242d31c079eddd0b0a35db6ef550d1e65b317419d1a9a2b0ff91ccf98a754e0d81328','Mmovi',0,'2015-04-07 20:33:37',NULL),(13,'miga@miga.com','15f34c46283bbcf399070f01e56a8a048f171ce8f6dbae58bb8059ca1cd959119b62a7200d8c169827ef706ff5c70b1f627fe4d4e73da4f6a5a808a6cb602fccc8138b731219cfb3b2bdc2275a11138d0a03fb9a1a7607a8a65d4fabb99770f8','Mimovi',0,'2015-04-07 20:33:37',NULL),(14,'cecil@cecil.com','84f1fd6ea63f482ac945c02bd5773123619b3495adcef992fcfec225436a7965a1b3781cf5bd2f79abdeb6c392148852daedd8a1d9b2b3b0519cf04dd6b119b92b6648807f64ca5a4b633878b884ff881d5e82d9c69c52e658cd0accca350142','Cpibo',0,'2015-04-07 20:33:37',NULL),(15,'valen@valen.com','add7a0d4647a12fc499354ba01fa1371f6f8795fc82da606fc0f5e5cf7b3b5bceefa662d1757a26760853600027e8aceb9b06a00e094af7a2929977c3e46e769122e5e5ae5dfd6a8e516a53457a59791eae5068acf20593d716a1e18ae124f55','Vort',0,'2015-04-07 20:33:38',NULL),(16,'oscar@oscar.com','a47f083474d2805e45ad381090460c9317ec5fb01aa29e8fa3a2daf6ea7c10ed809c00e5aef0b4247701d9a8d190cb8cb35b28f8cfb0bd78c58773fa38fe22f023f346ea493f58692d9fd726180cbbf1ae83e04d47dcdd60eaf189c78fce1b65','Oort',0,'2015-04-07 20:33:38',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-07 20:33:38
