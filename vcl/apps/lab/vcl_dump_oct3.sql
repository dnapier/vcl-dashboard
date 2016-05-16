-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: vcl
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.12.04.1

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add computerlab',7,'add_computerlab'),(20,'Can change computerlab',7,'change_computerlab'),(21,'Can delete computerlab',7,'delete_computerlab'),(22,'Can add registration profile',8,'add_registrationprofile'),(23,'Can change registration profile',8,'change_registrationprofile'),(24,'Can delete registration profile',8,'delete_registrationprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$0CkO0DbzZAXX$cbWZFKLPGRlcYcAMk9RzOfPQd+FwAalHxSlUO1bCwS0=','2015-10-04 00:25:59',1,'infoadmin','','','cmvora@gmail.com',1,1,'2014-05-27 19:39:48'),(2,'pbkdf2_sha256$12000$xGcDO5s7XeTo$PXsaKt2PXhQi2ZM1VgD7jsffH3FN4xvGIyAuRZYPT48=','2014-08-11 15:19:33',0,'Chintan','','','',0,1,'2014-05-27 21:32:03'),(3,'pbkdf2_sha256$20000$iFH8bt8kbJsc$HfPeSUuT+mbX1mk2ymKwn46DYMVfsavISjBweDQF2kQ=','2015-10-04 00:20:29',1,'Dave','','','',1,1,'2014-05-27 22:08:14'),(4,'pbkdf2_sha256$12000$xg9kHR1ahF24$hCtBEsy6bxwKp9ol3gw5CKdJbuJcn05MR6fHCisL8H0=','2014-05-31 08:48:11',0,'James','','','',0,1,'2014-05-28 13:22:23'),(9,'pbkdf2_sha256$12000$Jee0DMVHiBzp$389uhm9lRJlRlB8/9yAhqIlbQv+25dcjs1s8Cp7/W/8=','2014-08-19 23:20:29',0,'Erik','','','',0,1,'2014-05-28 14:32:32'),(11,'pbkdf2_sha256$12000$7M4670IIkMlv$1altWUkhSpliIY3A1jkA9btqqhl/BZNtJ+e3hEMLKj4=','2014-08-03 04:18:05',0,'admin','','','',0,1,'2014-06-07 20:22:41'),(12,'pbkdf2_sha256$12000$WWEoLnfWmAkH$hNyLSTyTatLb0fKgxIeyJvRK1mheqbagnP85iqX8nec=','2014-07-11 04:23:42',0,'admin1','','','',0,1,'2014-07-09 23:45:25'),(13,'pbkdf2_sha256$12000$nZjYCN9skhLW$ZNSM7uTF0VQQvVANWU8ahVxla0/HOzBG0n/q3SPnvpo=','2014-07-11 04:23:59',0,'admin2','','','',0,1,'2014-07-10 00:31:55'),(14,'pbkdf2_sha256$12000$LKwUqr1hR3qi$02GRlWmgO3q/d2HJG/oRFymmfNVKLS7e2q3V2LpV4ro=','2014-07-11 04:29:29',0,'Jimmy','','','',0,1,'2014-07-11 04:29:12'),(15,'pbkdf2_sha256$20000$m0TBKbJDiSmD$Hez4/D2GyciVcQsVa1Dao04HM3mw/Hxmv9+BMTYSwP4=','2015-09-30 05:42:57',1,'cvora','','','',1,1,'2014-08-13 00:49:58'),(16,'!1vTLV2hV87acpvMkeuybXa21gyzl1kf0Y6HrcBGP','2014-11-05 21:26:20',0,'bhardwaj','','','',0,1,'2014-08-13 16:42:05'),(17,'!PjASLRj7wwOUruVT5ErIknWMPQpymPQVDXZ7zOKp','2015-07-20 12:20:03',0,'dbaugh','','','',0,1,'2014-08-16 00:01:02'),(18,'pbkdf2_sha256$12000$8Mz784Sn25BG$zVLDT4h9XK8j2m1K0W/n2djyd641PVcq9u/yN7EgT+s=','2014-09-02 16:50:19',0,'chintanvora','','','',0,1,'2014-09-02 16:12:53'),(19,'pbkdf2_sha256$12000$mxPLRVMQUcM5$W7z5qnSxfcDMU5j4B62PJz90++kvnZi/LEdYMKsAsWE=','2014-09-02 16:14:10',0,'user1','','','',0,1,'2014-09-02 16:14:10'),(20,'!2f1nL9J4ihDxnJnetkGAdsnpTZolHRn4cDZdfBex','2014-10-27 16:04:54',0,'shrawan','','','',0,1,'2014-09-13 21:07:30'),(21,'!tg2PhdDii6eMYDhaPxzeLY1kFEZFLmM199J9rqFE','2014-11-02 05:41:58',0,'jshah','','','',0,1,'2014-10-06 16:02:51'),(22,'!vVXPsEQpt4S9xAI61dsS7Mp7ELmaF4yAUrHwXuVz','2015-05-06 14:03:23',0,'diliprao','','','',0,1,'2014-10-13 17:34:52'),(23,'!fLzQ8ftuMmterPsjvic2nkOPHNEaTYnVDihCKIY5','2015-06-10 23:47:08',0,'marciano','','','',0,1,'2014-10-13 17:36:07'),(24,'!fYZjMj1dBvEDDXfWQp1NOHX4FDy6CM9uqs3YzUr8','2014-10-29 12:49:01',0,'jimmylin','','','',0,1,'2014-10-13 17:39:32'),(25,'!L4EGT8988lG9kJhYf1FBx4NK1VbbP8HAyrX9fFPl','2014-10-24 20:47:27',0,'ranusha','','','',0,1,'2014-10-24 20:47:27'),(26,'!FsYHhiJMsXCoHP9ryaxHz107Zn4Ss6HL2Rqi4o0v','2014-11-18 19:18:34',0,'melisb','','','',0,1,'2014-11-18 19:18:34'),(27,'!RllssVXEUVIs01tS8o4gGAbpcb9be1Wiy93Ev5ju','2014-11-18 19:46:23',0,'daltman1','','','',0,1,'2014-11-18 19:18:48'),(28,'!2ye0B6KS9jU9xV2LUlO9ORqp5oONaeLKyjkDS0Xl','2014-12-09 19:11:32',0,'abarker2','','','',0,1,'2014-11-18 19:18:52'),(29,'!gBPIbEu3oyE6abH34g0TjWoDsWk2GDIp99g1rUyZ','2014-11-18 19:18:54',0,'lsisson','','','',0,1,'2014-11-18 19:18:54'),(30,'!rDr2fEf7JzAMip1MDuaHkuok3J4StctBKwChDqpy','2014-11-18 19:18:57',0,'petrozzi','','','',0,1,'2014-11-18 19:18:57'),(31,'!wfFEnXnaU8CVe5J930LPyNHVzU5zRBQHi7EflqAQ','2014-12-04 19:16:51',0,'agunn','','','',0,1,'2014-11-18 19:19:01'),(32,'!xthsU7k8OGU2nVzPj41MhOBa6GZTChnqpP1vkBLf','2014-11-18 19:19:01',0,'etobey','','','',0,1,'2014-11-18 19:19:01'),(33,'!LlhVEDukUuUT1T092v5T34VIlFF2fyVDG74abNJX','2014-11-18 19:19:02',0,'kroussey','','','',0,1,'2014-11-18 19:19:02'),(34,'!LseNRJ8E3RcDawREpBIdiPAEUO1HZyn8UpolhODd','2014-11-19 01:48:55',0,'jjlee10','','','',0,1,'2014-11-18 19:19:04'),(35,'!jv4OP4fL2r8NW4vwaDk9sLY8fbSgAWdZqmSOPJXz','2014-11-18 19:19:13',0,'keith22e','','','',0,1,'2014-11-18 19:19:13'),(36,'!DveZe4K6psX5AaThDBq2nmOTswzHABhc2ZF02LSW','2014-11-18 19:19:23',0,'kstavish','','','',0,1,'2014-11-18 19:19:23'),(37,'!c1ChPAhXzX7jNX9RKa00IgmEaCsclVZQMymJE84D','2014-11-18 19:19:34',0,'mcurrens','','','',0,1,'2014-11-18 19:19:34'),(38,'!HxydeSmMnvVWMy6iKTjabQS44ApgB0G5Nv1eOt72','2014-11-18 19:21:50',0,'klnolte','','','',0,1,'2014-11-18 19:21:50'),(39,'!DjTPDPQEfR2d5Lya0rAvkKfIc5vZNBjp5RYIZc0x','2014-12-01 20:00:16',0,'tstump','','','',0,1,'2014-11-18 19:21:50'),(40,'!p6oDDHU6pslCcra0EYmYTV01tVM2zFSMVCCNk29Z','2014-12-16 13:38:26',0,'tguzman','','','',0,1,'2014-11-18 19:21:50'),(41,'!3QZnE5UrsamWjWrsqDKip6dHAJAlnxN4QSgTS9Q7','2014-11-18 19:21:54',0,'fkatz','','','',0,1,'2014-11-18 19:21:54'),(42,'!z8BGuAMvTVA0PlVziaYI1mfjdAObatlhAq9eP3xy','2014-12-02 19:35:16',0,'hcorrada','','','',0,1,'2014-11-18 19:22:38'),(43,'!TrlRUGqfRLTs8pYMcG6moArxkmF2Du8zldg6X8vu','2014-11-18 19:24:46',0,'cbucklin','','','',0,1,'2014-11-18 19:24:46'),(44,'!7zmH2lrnVJPudFdLNyBR500KQCMNbZoabK5DReCx','2014-12-05 15:42:22',0,'jmarien','','','',0,1,'2014-11-18 19:24:49'),(45,'!rzJpKAQKojEcBs11qGbiNeX8aEtK5yslt8XEhbg0','2014-11-19 16:05:59',0,'ezerhus','','','',0,1,'2014-11-18 19:25:53'),(46,'!UHRJjt8ijJY1wvRI5mpSf9oBjmoqzO4ITLfqnDg8','2014-11-18 19:27:13',0,'sprael','','','',0,1,'2014-11-18 19:27:13'),(47,'!8uhxO1wIogzeVwN1WGoce57OZXsfCUR6cVw1QMS2','2014-11-18 19:28:25',0,'mtrunnel','','','',0,1,'2014-11-18 19:28:25'),(48,'!QqSaUL49ePGfBxiERdqkcz0aeUbOiFKQJk2xlbfU','2014-12-09 19:17:19',0,'eanders2','','','',0,1,'2014-11-18 21:55:21'),(49,'!Pxe8MQmYc50vTqGIjkezIDsXfSikNSy0Ns6sDVNQ','2014-11-19 16:05:11',0,'jcoffin','','','',0,1,'2014-11-19 16:05:11'),(50,'!hm1LmJZo0TRa0nKDkWg5MaqtjiMIMPb5C0OBpVkB','2014-12-15 14:09:02',0,'jmears','','','',0,1,'2014-12-12 14:46:12'),(51,'!Xs3p0C7oIyImq3m0hCA1L6sKxxC5dOjQKJ402MRy','2015-01-21 16:10:21',0,'brual','','','',0,1,'2015-01-21 16:10:21'),(52,'!y0clTwM8q0bifYl9lmI4QQgGqsgRfdwBbVLOknNM','2015-03-27 18:44:33',0,'rkspang','','','',0,1,'2015-03-26 13:42:38'),(53,'!QM2cW3FO889dujMBc6jjVEqAXloHg7Sk6g0No5se','2015-04-05 16:35:38',0,'abha','','','',0,1,'2015-04-05 16:35:38'),(54,'!2NDm1PEGTC3PQfuSClYADdt6mF3lRi2h6MxPymwB','2015-09-10 14:47:13',0,'jansen','','','',0,1,'2015-05-18 15:26:10'),(55,'pbkdf2_sha256$20000$fbkujJEohfM3$W60JYV9dx8ilWUgM8gWp4sBShYrTEEaoZNv3Mrd57H8=','2015-10-04 00:54:38',1,'ssachar','','','',1,1,'2015-06-09 16:05:03'),(56,'pbkdf2_sha256$12000$B3k5pJewPjKw$7roDs0bC64XEUzuUhW0tSc06dePBOUmYTCrMNxPHjdk=','2015-06-09 18:08:02',0,'newuser','','','',0,1,'2015-06-09 18:08:02'),(57,'!K4ZIQOqQs8s7xwMoKnC3OTLTto0vx29QUka5GWFo','2015-06-12 16:24:08',0,'donovant','','','',0,1,'2015-06-12 16:24:08'),(58,'!e4IOKqEMsAeveYGVeMaFOt93cbJsSHkOXnDE2CqH','2015-08-31 18:08:56',0,'jgolbeck','','','',0,1,'2015-08-25 00:00:23'),(59,'!bt9VdXx4DJzKjFHHAZVyuJRf1e828vE3d1ssERMG','2015-09-02 04:09:20',0,'rlbaker0','','','',0,1,'2015-08-25 18:03:34'),(60,'!j92nMklbTTqCT2dUlmrVUwFUYyofRKnXzAQIBjr1','2015-08-25 18:30:33',0,'kchen117','','','',0,1,'2015-08-25 18:30:33'),(61,'!eaBN4CThmjFyjo5mU9y1nAPAyx5Wwtc8ZFM67jda','2015-08-26 01:43:34',0,'focolman','','','',0,1,'2015-08-26 01:43:34'),(62,'!uteGm7kiZsozr38xRTUzriBIKnveSR3SfpK4Rwka','2015-08-26 03:38:52',0,'song851','','','',0,1,'2015-08-26 03:38:52'),(63,'!sYneaCGczEj9aWrg59rUwceh4CmKJ79kkcdWgrJg','2015-08-26 15:38:55',0,'gopu','','','',0,1,'2015-08-26 15:38:55'),(64,'!GPqjgErSxPUQJnEGpWcPNh3UgLpgqRBVfNMm8gGT','2015-08-29 19:27:09',0,'jessej','','','',0,1,'2015-08-27 19:30:50'),(65,'!6z9DGZzCAlF6SSrCGJBCs6FO76onWuO4JBsEQOVu','2015-08-31 22:08:05',0,'ashorter','','','',0,1,'2015-08-29 16:42:43'),(66,'!waZUur0NqLILlRdOi4HrSNUy5ToDXVe3bHzYobvM','2015-09-02 00:52:47',0,'rkahn','','','',0,1,'2015-08-29 22:26:52'),(67,'!49imLFbU8NSj7a4Jpfp279r8EgoKOzQaLjEmWaVD','2015-09-10 00:17:01',0,'ageller1','','','',0,1,'2015-08-30 17:52:56'),(68,'!pi5YZMqIgUGH04Ss5zjHv34NHkkjOv9VqSVeCEas','2015-08-30 21:20:58',0,'dqi2','','','',0,1,'2015-08-30 21:20:58'),(69,'!Ap2zRG8trdWWfud5YeOUphkUpN3hfxhaqGDwxcaY','2015-09-02 18:38:37',0,'rocolman','','','',0,1,'2015-08-31 02:26:54'),(70,'!2ferq7A7TJk3wKc5AI8gasrI65wGcAeeuhUDRhI9','2015-08-31 10:42:49',0,'jengel','','','',0,1,'2015-08-31 10:42:49'),(71,'!4zPxX5BkAxs51B13JNG4o2hmEWyy79hjdP6PGAKc','2015-08-31 23:22:07',0,'bhagyak','','','',0,1,'2015-08-31 18:26:21'),(72,'!UMS8WiWKsV94BNBQVryXbGwRGPf7K2nVftoG5Fd4','2015-09-06 00:51:42',0,'mpaulo','','','',0,1,'2015-08-31 19:17:22'),(73,'!yGCKRWFMjefV5TkUG9Il4hJkEMulIyDeOoEIqDGb','2015-09-04 17:17:06',0,'bgharala','','','',0,1,'2015-08-31 21:27:22'),(74,'!8T7UvPjHuSaeTE48O2LOC9r6y6zHYn5eX6Y7UQNQ','2015-08-31 22:09:11',0,'mukulhci','','','',0,1,'2015-08-31 22:09:11'),(75,'!uZQYfIJy8aao6vMlGZmbqDicleK1gySsYlglAD5I','2015-09-07 04:02:52',0,'prakriti','','','',0,1,'2015-08-31 22:09:18'),(76,'!6Pxta297HolKlCBGfEu9MkVxvh05f4H8SoswSY4Q','2015-08-31 22:09:33',0,'gavish','','','',0,1,'2015-08-31 22:09:33'),(77,'!XD55AUrpbpAt0yRtuZSP2b7bJLRmtLeQVUSV58h1','2015-09-01 20:46:47',0,'cbuntain','','','',0,1,'2015-09-01 20:46:47'),(78,'!G1L8X4L8YslaoHNQHrGHc3LOF1UzXoXEbi7aqtN2','2015-09-02 03:41:54',0,'wadhwani','','','',0,1,'2015-09-02 03:41:54');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,2,1),(2,2,2),(3,2,3),(4,2,4),(5,2,5),(6,2,6),(7,2,7),(8,2,8),(9,2,9),(10,2,10),(11,2,11),(12,2,12),(13,2,13),(14,2,14),(15,2,15),(16,2,16),(17,2,17),(18,2,18),(19,2,19),(20,2,20),(21,2,21),(22,2,22),(23,2,23),(24,2,24),(25,18,1),(26,18,2),(27,18,3),(28,18,4),(29,18,5),(30,18,6),(31,18,7),(32,18,8),(33,18,9),(34,18,10),(35,18,11),(36,18,12),(37,18,13),(38,18,14),(39,18,15),(40,18,16),(41,18,17),(42,18,18),(43,18,19),(44,18,20),(45,18,21),(46,18,22),(47,18,23),(48,18,24);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-05-27 21:24:46',1,7,'1','HCI P2PU workshop',1,''),(2,'2014-05-27 21:27:37',1,7,'2','INST737',1,''),(3,'2014-05-27 21:32:03',1,4,'2','Chintan',1,''),(4,'2014-05-27 21:32:31',1,4,'2','Chintan',2,'Changed user_permissions.'),(5,'2014-05-27 22:08:14',1,4,'3','Dave',1,''),(6,'2014-05-27 22:08:19',1,4,'3','Dave',2,'No fields changed.'),(7,'2014-05-28 13:22:23',1,4,'4','James',1,''),(8,'2014-05-28 13:22:28',1,4,'4','James',2,'No fields changed.'),(9,'2014-05-28 14:32:32',1,4,'9','Erik',1,''),(10,'2014-05-28 14:32:34',1,4,'9','Erik',2,'No fields changed.'),(11,'2014-05-29 02:39:04',1,4,'10','Jimmy',1,''),(12,'2014-05-29 02:39:12',1,4,'10','Jimmy',2,'No fields changed.'),(13,'2014-06-07 20:22:41',1,4,'11','admin',1,''),(14,'2014-06-23 01:16:09',1,7,'3','BMGT 301',1,''),(15,'2014-06-23 01:16:35',1,7,'1','HCI P2PU workshop',3,''),(16,'2014-06-24 02:29:23',1,7,'4','INST 733',1,''),(17,'2014-07-09 23:45:25',1,4,'12','admin1',1,''),(18,'2014-07-09 23:45:29',1,4,'12','admin1',2,'No fields changed.'),(19,'2014-07-10 00:10:24',1,7,'3','BMGT 301',2,'Changed amazonami.'),(20,'2014-07-10 00:11:26',1,7,'3','BMGT 301',2,'Changed amazonami.'),(21,'2014-07-10 00:31:55',1,4,'13','admin2',1,''),(22,'2014-07-10 00:32:00',1,4,'13','admin2',2,'No fields changed.'),(23,'2014-07-11 04:28:59',1,4,'10','Jimmy',3,''),(24,'2014-07-11 04:29:13',1,4,'14','Jimmy',1,''),(25,'2014-09-02 16:12:53',1,4,'18','chintanvora',1,''),(26,'2014-09-02 16:14:10',1,4,'19','user1',1,''),(27,'2014-09-02 16:14:16',1,4,'19','user1',2,'No fields changed.'),(28,'2014-09-02 16:15:12',1,4,'18','chintanvora',2,'Changed user_permissions.'),(29,'2014-09-02 16:17:09',1,7,'3','BMGT 301',2,'Changed amazonami.'),(30,'2014-09-02 16:17:38',1,7,'3','BMGT 301',2,'Changed lab_auth_info.'),(31,'2014-09-02 16:26:42',1,7,'2','INST737',2,'No fields changed.'),(32,'2014-09-02 16:31:22',1,7,'2','INST737',2,'Changed lab_auth_info.'),(33,'2014-09-02 16:54:44',1,7,'3','BMGT 301',2,'Changed coursesemester.'),(34,'2014-09-02 16:56:48',1,7,'5','INST 734',1,''),(35,'2014-10-13 03:16:59',1,7,'2','INST737',2,'Changed lab_auth_info and coursesemester.'),(36,'2014-10-13 19:32:06',1,7,'6','Windows Lab',1,''),(37,'2014-10-15 00:01:20',1,7,'6','Windows Lab',2,'Changed amazonami.'),(38,'2014-10-27 22:18:48',1,7,'7','Windows ArcGIS Lab',1,''),(39,'2014-10-27 22:19:39',1,7,'7','Windows ArcGIS Lab',2,'Changed labdescription.'),(40,'2014-11-12 19:30:29',1,7,'8','Digital Curation - ARCGIS Unlocked',1,''),(41,'2014-11-18 16:22:01',1,7,'5','INST 734',3,''),(42,'2014-11-18 16:23:06',1,7,'8','Digital Curation - ARCGIS Unlocked',2,'Changed labdescription.'),(43,'2014-11-18 16:28:10',1,7,'6','Windows Lab',3,''),(44,'2015-01-29 15:21:53',1,7,'9','Big Data - INST 767',1,''),(45,'2015-01-29 15:50:19',1,7,'9','Big Data - INST 767',2,'Changed amazonami.'),(46,'2015-01-29 15:52:04',1,7,'7','Windows ArcGIS Lab',3,''),(47,'2015-01-29 15:52:17',1,7,'3','BMGT 301',3,''),(48,'2015-06-09 17:56:29',1,7,'10','Demo WIN',1,''),(49,'2015-06-09 18:08:02',1,4,'56','newuser',1,''),(50,'2015-06-09 18:08:06',1,4,'56','newuser',2,'No fields changed.'),(51,'2015-07-09 02:25:36',1,7,'11','Development of Internet Applications - INST 743',1,''),(52,'2015-09-01 20:13:24',1,7,'11','Development of Internet Applications - INST 743',2,'Changed amazonami.'),(53,'2015-09-05 05:00:41',1,7,'12','Ubuntu Characterization Test',1,''),(54,'2015-09-29 20:26:17',1,7,'2','INST737',2,'Changed instructor_id.'),(55,'2015-09-30 05:39:41',1,4,'15','cvora',2,'Changed password.'),(56,'2015-09-30 05:40:53',1,4,'3','Dave',2,'Changed password.'),(57,'2015-09-30 05:41:52',1,4,'15','cvora',2,'Changed is_staff and is_superuser.'),(58,'2015-09-30 05:42:23',1,4,'3','Dave',2,'Changed is_staff and is_superuser.'),(59,'2015-09-30 05:44:53',3,7,'4','INST 733',2,'Changed instructor_id.'),(60,'2015-09-30 06:01:08',1,4,'55','ssachar',2,'Changed is_staff and is_superuser.'),(61,'2015-09-30 06:02:00',1,4,'55','ssachar',2,'Changed password.'),(62,'2015-09-30 06:02:10',1,4,'55','ssachar',2,'No fields changed.'),(63,'2015-10-03 22:10:04',55,7,'11','Development of Internet Applications - INST 743',2,'Changed instructor_id.');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'computerlab','lab','computerlab'),(8,'registration profile','registration','registrationprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('01iaxt800jlesh8nqtscsfu0roe0qqll','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-18 17:20:26'),('0i9bqgrmhsnrv9ch03j6vur3nu3aasbj','NGQxYjM3OTMyN2YwYjBmMzFiNWYyMjUyZGYxZTJlOGYzZDg4ODRhMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY1fQ==','2015-09-14 22:08:05'),('0n5k6yum2kdvzs3p8vss2ycu86rykqp2','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-10-27 03:55:32'),('1690f604qdwqf7epgtf49dte7bhkkb2y','NTlmNTJkNzZmNTYxMGVhNGNiOGY4ZjYwMjJhYTM5NWY2MzlmNmNiNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE2fQ==','2014-08-27 16:42:05'),('1cymki7v3u1fi2o669gof15fgw0i0syf','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 19:46:56'),('1ki9a5d6fhr6z04rvtnpypqff570fvqy','NTlmNTJkNzZmNTYxMGVhNGNiOGY4ZjYwMjJhYTM5NWY2MzlmNmNiNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE2fQ==','2014-11-19 21:26:20'),('1viq5sooepafvl89j86210kcyaa8b0k0','ZjRjZDExZDI2ZjdmZjFkYTU5MmFkYWE2YjNlM2I3ODhiODg2MTY3ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6NH0=','2014-06-13 13:30:24'),('235ca80wggmdmgw0dxm1eqvxdf4xu12h','YjgxZDdhODk5MDNhZTVmNzEyMDk2ZjkxN2U3NGQwMDIyN2Y0ZDk2ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMxfQ==','2014-12-02 19:19:01'),('26sh73vxiqsn30uctrkuyd3ahc2ft79i','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-02-09 17:15:57'),('29dvvp4thix8l8o785wmes52t6mz4hox','MmU2ZGIwOWI3ZDRkNWY5ZTUwZmMzZTVlNzA1MzRmNzEzMThjMjJmZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIxfQ==','2014-10-20 16:05:45'),('2ajgyomz09iideiitzac235nz2rwq45e','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-01-21 20:04:18'),('2f6okxd5d406tmtvf59qhzy7y0niufj9','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-22 18:35:55'),('2hbmyicqsekwfzwrbsrmpk68zcletve4','OTUxNzk4OWMzNzg2Y2I0ZThhMjRmNDU1MjNiYTNkNjdlOGJjNzU3Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQzfQ==','2014-12-02 19:24:46'),('2s7dkn7l28ysw20ln6uy1exopbthomw2','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-03 16:05:41'),('2wbc8atkiavv0stt5on909vqzipcq5tb','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-02 16:29:33'),('30m93ofrmoh9wm2ipm6do02v1yfwd6r8','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-08-25 12:47:17'),('33f2yes66o1eduskffv3164945l2ytec','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-03-05 17:59:24'),('3cqnvlihcs3la55yrqjnl48edndqwpv5','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-09-27 03:35:43'),('3gdcetmzlsn1luhauz6lro40bjxe8sdw','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2014-10-27 17:34:52'),('3o60g5ptsjrvph98ez7tt5coq7i8nui3','NWY2NWRmNzQxNjlhY2UyNWYwMGMwYWEwMzNhNmRkYmE3MTcxYWU2Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjYxfQ==','2015-09-09 01:43:34'),('3sdn0btf6uxzupl6tqdr7uqd9ghaeqmx','YTQyOWE5YTQ0MDkxMjZmZjBkNWMzZTNlNjAzODVhMTkwODVkMWJkODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY4fQ==','2015-09-13 21:20:58'),('3w110n37g6nmta00srorw4fuil9nfeom','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-11-18 23:16:26'),('42c4u7jp6itq4sgiw9mx8z00n3w6ow4q','NmYwYzUwZTM4ODdjNjZjOWZmZWIwMTFkZTIyMDYwYTQwYTEwOTZhYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjcyfQ==','2015-09-14 19:17:22'),('4b6pmhu8yu8ao1hs5o55tvhvxv0c6hdd','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-15 23:07:48'),('4o9vvwce4bfvgizfahe0dxxbl9lfwq2g','NzM5MDRiYmJhODA2NDc5MTMwNmQyNzJhMmFkMDZmODM5Njk0ZjdhYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc1fQ==','2015-09-16 21:11:38'),('4qkg91nuwdyk2jm2uypquaftifyuibjy','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-08 23:38:47'),('4rdcaa8nm9wg2sy6yb69dw4agjnr86i7','MGVmODcxZTE2MDc1YTY1NDk3OWYxYTkxNTcwNWNkOWRlZDEyYzNmNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTR9','2014-07-25 04:29:29'),('4rz9g4ectbfgww73hc5ynnc8zvjvzg4i','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-09-16 17:56:05'),('5391tci25zg7q2cs1kbcqomj1o5p9cir','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 18:56:51'),('53nybipzddc06cq34d3g6ck26rsm72lg','ODc2OTU1NDRlN2Q2YTQ3NDQ3ZTRlZjI3MzVmNDI5NjdiYjBlYmFkZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI0fQ==','2014-11-12 12:49:01'),('5cefvk9eo5m43gyze283s0olwqaaqi2c','ZjM3NjMwMzljYTlmMmNmZmZiODBiMWE1Yzk1NWViZjY3YmVhOTFjMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQwfQ==','2014-12-02 19:21:50'),('5k5auf2x6lii1ggnz1zqajlp9k6s2mvc','ZGZjMDA2MGE5NGMxZGE4NDBlOTMyODJmNGJjMmEyZDIyOTQ3Y2NiNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ0fQ==','2014-12-02 19:24:49'),('5nr4akqzumsy2y7a51ae17eto656z1wh','YzUzMmFmMjIzNGUxYzBkZmViY2I3NmYzYTE5MTgyM2U2MTEzMGJmODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY5fQ==','2015-09-14 02:26:54'),('5p1gz9nwwtcikvooyfovmdfrucsyo6g3','NmYwYzUwZTM4ODdjNjZjOWZmZWIwMTFkZTIyMDYwYTQwYTEwOTZhYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjcyfQ==','2015-09-16 03:30:24'),('62ur2j1rgbw23m4mcz2h6ya4yzg367tr','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-05 08:42:09'),('6b1j10qcy8lwq2o1yuddcmh3nybnpf6v','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-08-27 01:15:20'),('6n8pmqy06r640efaa69zvb5t9zwquo5u','MDY0MTMxNzEzYzQzNzQzZjE3NmVmY2YzYTg1ZmU4NDgzM2NmZmRkNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OX0=','2014-06-20 02:39:50'),('6qx279681otfwcbsw3tw98fli6k58yx2','YjgxZDdhODk5MDNhZTVmNzEyMDk2ZjkxN2U3NGQwMDIyN2Y0ZDk2ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMxfQ==','2014-12-03 20:09:15'),('6tbc8bid5ygym29mhtfoed6q6y3813lr','YjgxZDdhODk5MDNhZTVmNzEyMDk2ZjkxN2U3NGQwMDIyN2Y0ZDk2ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMxfQ==','2014-12-18 19:16:51'),('76489plu31pr5dfp6hab6cx3njzbcqi7','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-09 01:31:18'),('76xmfmppzqii9i8lzps3ym7lyoeuoanc','YTJmNmFhNGYwMTdkNTgzNDIyMmNhOWJjODNjMDk2ZWU3MTNkMzQ1ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIwfQ==','2014-09-27 21:07:30'),('7701vop1ro2y9oy41l7qlvdv36yc0xi4','YzUzMmFmMjIzNGUxYzBkZmViY2I3NmYzYTE5MTgyM2U2MTEzMGJmODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY5fQ==','2015-09-14 23:15:15'),('77iye1akddkjhz57jr98oxtwjlge1n5z','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-22 18:16:05'),('7gtp5krkfbh2q4mqwcrrbz4zlceeonw9','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-09-21 19:38:55'),('7i6dwhfj824vlprg2kio7alsn3gtu4xj','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-08 00:49:50'),('7jvvh9f9udhuvrp0gkkuft6wi200lu7m','YTY0NTdjMTNjZDc4Njk0MTcwNWYyOTllZGE1YjNmZjIzMDJkMjQ2YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjUxfQ==','2015-02-04 16:10:21'),('7nbzl9q8m2cc5c1n3o4jks7c0ma11k3q','OGM3NDUzOWYzNTZhMmFjYWNmNTkxYzQ4OTQ5ZTliYjI4NTNmMDhmMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE3fQ==','2014-08-30 00:01:02'),('7ukup9hn2zgi0fqunbwqkhe1vddvhpls','MjFhMDc4NzNmZmEyOWRiMDk5NjYzMjZkNDdiMWE0NTIxNzFkOWM4Njp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM5fQ==','2014-12-02 19:21:50'),('848y1jywteyh8a27h6oec1ev47uswosm','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-12 21:30:20'),('88e168o9snuby2nhsgr7nvu84n35s8le','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-14 22:13:19'),('8axc669mxln3ff84qbgt6qv3jtcfemtc','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-22 16:28:08'),('8z0gsng3glry6mc6p67x6aomohqqy3zr','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-21 02:37:33'),('9ayjehbvzng83l16bh7xiaym8wk2c8l5','N2E1YjVmMzBkYWVlMDljODllZGUyOWYxOWZhOTg3MTBiMzg2NGU1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU0fQ==','2015-09-24 14:47:13'),('9gdhtyyfhqkz3gfe75q5541qo9d1ep2f','NjY4ZGM1MDgwMDc0YzMzNDRiZjljNGM1ZGNlMGI0ZDA4ZTIxODlmODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTF9','2014-08-02 17:30:37'),('9k4o93o9znckr3yni2m5zelior5ye7x0','YTJmNmFhNGYwMTdkNTgzNDIyMmNhOWJjODNjMDk2ZWU3MTNkMzQ1ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIwfQ==','2014-09-28 03:52:50'),('a1s3lde6q45lr294vcwd92upnh2rnui6','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-03-23 15:43:42'),('a2s7dd9j3krxzb0df8j4h2eaepkppjwq','MmU2ZGIwOWI3ZDRkNWY5ZTUwZmMzZTVlNzA1MzRmNzEzMThjMjJmZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIxfQ==','2014-10-23 21:13:19'),('ajjdsqc8ew3qft1e7htcfi0j0uknyxay','NzM5MDRiYmJhODA2NDc5MTMwNmQyNzJhMmFkMDZmODM5Njk0ZjdhYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc1fQ==','2015-09-21 04:02:52'),('aqh7i14s48478q8sy2nta81g66wn6nfw','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-14 20:20:19'),('arnb14zz24lg8bgjqwlxzg8b785bpzg0','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2014-12-22 19:34:42'),('asv752ubxx5ot8mti35dyv9blho18xoa','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-01 20:51:19'),('bep5z9560skx43irzl0h5l4sgodk5lm4','ODU3NTY2Y2FhOWYwMDg3Y2I3NzUxZTU4Njk3ZWY4MDhmMWE2YmEwZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjYyfQ==','2015-09-09 03:38:52'),('bfr0cgo1wgn3zhcw27klp38hzz2y2wy3','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-01 16:48:04'),('blbu4qtvs1dwqbbmmbovcy5xickmu2sh','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-30 01:02:19'),('bmmcr42qxc3sipuiwab8wtitk3kk80jp','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-08-03 14:35:32'),('bqief2hair9t9dkstz2amhf0kqk4n909','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-07-23 02:29:19'),('btcn7rladrbqzcxtdfn1u128qf5u7z4f','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-16 02:03:57'),('buw0kxrt8zmfevcos2z89nwfnlzljl8d','OTcyNGUxYmJlODUzODhlNmYyOTZjOTcyYmNhOTZkZDk3NzRmNDc0ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-12 15:52:08'),('cc3yr86hs4mjbqcm5sphismufodob2ad','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-02-12 15:55:37'),('chwb3fdiiucr6sbv4xkm9l6xs079h3so','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-09-23 02:38:40'),('cx500izztyktct64m4dm4jnox679yk5t','NmYwYzUwZTM4ODdjNjZjOWZmZWIwMTFkZTIyMDYwYTQwYTEwOTZhYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjcyfQ==','2015-09-14 22:10:01'),('cxbwyd31rqu4p1rsuxo2zjl8k1g2ving','OTIzNWFlY2UxZTM3YzVkNTZkMTVkMTlkZjJjYzEyYjdjZDA4YTgxODp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1MmM2YTE4MTBjNGZlNWU0YjY1ZDU1YjU2Zjc0OWQ5OWI4OTJiZmEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJjYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI1NSJ9','2015-10-14 06:04:35'),('czkigjn92853uetnfctm5oq5nxqxgbyu','ZGZjMDA2MGE5NGMxZGE4NDBlOTMyODJmNGJjMmEyZDIyOTQ3Y2NiNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ0fQ==','2014-12-04 01:16:52'),('d85iir35zk9f8ysdftqoa9cnfxrse0bu','Y2JkY2U4MmVjZmExYTU4OWJmOGY1MjI1Y2M3ZTFlZjM1YjU3ODExMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ3fQ==','2014-12-02 19:28:25'),('deonoppjegjzrk3x3iiieuixxvw07e09','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-04-06 13:25:51'),('djqgpuyxbhf5s2owbtfag9u5elqanjyf','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-09-26 23:13:40'),('djuzq6mmmpfeoxfdppalvny89jwu7piz','NzM5MDRiYmJhODA2NDc5MTMwNmQyNzJhMmFkMDZmODM5Njk0ZjdhYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc1fQ==','2015-09-14 22:09:18'),('dlzenh9tndpn3ostg4su8m9wutqvqpz1','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-21 16:41:53'),('dmx0d62rb92rrv45ngh5nyz6a9ybxhjk','ZmRiM2I2N2UyMmY0YzAzMDMyN2ViZGFjOTAyNjRjN2YxMWE2OWExNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM1fQ==','2014-12-02 19:19:13'),('drqmyx6z4y1af1ymqkggu33a1lua81z1','YjY2OTVhNmZmMTMyOTc1NDc3NDQzNmU5ZjQ3OTBlNmY4NDI2MmE0Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI4fQ==','2014-12-02 19:18:52'),('dxw4vlhfx9uisl1df71gpyf5yddg43ql','ZDhiMzBiOTk4ZmNkYjI3MDVjZWQ5ZGYxNWU2NjIyNGRmZDJmZmI5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjUyfQ==','2015-04-10 18:44:33'),('e59ee8qk2qladu20t19uuo84x9o8w0mc','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-06-23 18:13:06'),('eb9bbktuuzf34g6c9frylfmqu6s2afns','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-04 19:03:32'),('ed6tl2s8aqf152mdxe3dqj2qzipyj391','ZGU1NWQ4ZmMwYmY2NzFmZWY0NWMyMDNjMWVjNjI4YTQ4NDg2NzM4Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-07-08 13:16:35'),('ek6ieyivv1v36xnetx1hc42c8px9cgf7','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-01-02 16:48:35'),('eqxw0m3zv9mo4c9wayxvteg4kcnwhh0k','N2E1YjVmMzBkYWVlMDljODllZGUyOWYxOWZhOTg3MTBiMzg2NGU1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU0fQ==','2015-06-01 15:26:10'),('f09eahljm079dp2scxa2xq3rzl5br81j','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 21:39:04'),('faqs8xuzj7lb586im8vrymp1gmvyyo14','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-08 18:03:34'),('fmrv9oze06f15vx5xt8l0n1x6rvcs51p','ODc2OTU1NDRlN2Q2YTQ3NDQ3ZTRlZjI3MzVmNDI5NjdiYjBlYmFkZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI0fQ==','2014-10-27 17:39:32'),('fui3j1syb3x9rjnlx0y9u2zrb0fakyo8','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-02-12 15:53:54'),('fv4v1p5j6pmfh80umiz34vxkxuauukzu','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2014-11-11 05:53:37'),('fypx2gqw5posawyea9jl7txfomdmvnat','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-02-25 21:06:33'),('g3jiur1bdcaahm46ucjq4du5oulzxzrx','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-14 00:29:21'),('ghlpzasmbkjbnm6ljv8sehlnnqajbcxn','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-11-10 16:06:37'),('gzm1hwwlun7zr2pzs5sjg2bzs7ewic1p','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-08-12 15:30:13'),('hg3dp2m25hnnhmg38khgqgu5r5hmatqb','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-11 21:48:47'),('hkindpm9a65l3h5sp8lu1vi50biekgi0','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-08-11 14:20:50'),('hvtmxvzptwbg4h7hfs2perpzsmc3z9q2','YjY2OTVhNmZmMTMyOTc1NDc3NDQzNmU5ZjQ3OTBlNmY4NDI2MmE0Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI4fQ==','2014-12-02 19:27:02'),('hze8l2ez9e9sldqmgd6jqi9nv87o6utg','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-02-10 03:10:52'),('icfp6iwzk2v6z4mm7lg1zgcu8lqsuhax','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-03-23 17:50:47'),('ij9hf6eh5djo2pmbq7o9fl42fqlqcpru','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-29 01:50:12'),('ilzo91lbm24ld36k0svz3um3r36zo3ro','NTUwMzczNjE3ODcyNzE4YmRhMDY5YjVhNmEwZWZmNTQ1YTc3MWQ1ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQyfQ==','2014-12-16 19:35:16'),('j08jvinlzrpz8nm54oylq1hs3mlx73et','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-04-07 21:29:41'),('j76x6wbgtnt4x4v42omsf4tmtbx8r0wk','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-01-23 12:46:43'),('ju395sg1gg7nfzkxm6xjv43fmbxdax02','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2015-02-23 18:53:43'),('k1nirxp661lypzuxdod6th0g48kt8gt9','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2014-11-28 20:40:54'),('k1tcektzsw2a2vt9oqi0m0cl30uaq7hm','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-12 16:11:45'),('k4xu1ifjop6kse25smr2tep7ymrrmhq6','MWQ1YzJhMzdmNGRiYWUzYTgzYzNlNmFkZGFlZGY1MTVmY2ZmMjMzODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMwfQ==','2014-12-02 19:18:57'),('k7vum2yuovkmsg8rygdnczv77ojzlm1t','ZTY4NTk0Nzg2M2ZlOGNjOTY2YmI1MTA3Y2FiNDk5NzI5NWVkOWZhOTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjYwfQ==','2015-09-08 18:30:33'),('kam5kvfpgyaefrzvvm47ghcet87o41oo','NmYwYzUwZTM4ODdjNjZjOWZmZWIwMTFkZTIyMDYwYTQwYTEwOTZhYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjcyfQ==','2015-09-20 00:51:42'),('kozw5ttyuvrvt0j3x515633mqbsdwu1l','ZGZjMDA2MGE5NGMxZGE4NDBlOTMyODJmNGJjMmEyZDIyOTQ3Y2NiNDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ0fQ==','2014-12-19 15:42:22'),('kzsbtfsqn57vux7g5f1uta9bq9ka6xse','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-08-27 16:40:09'),('lin4fm6xwpb1x6tu9ozglycri3q6u9xx','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-07 15:29:23'),('ln5wl36zb2ow7ihmac1pfhh3krsey9i5','YTJmNmFhNGYwMTdkNTgzNDIyMmNhOWJjODNjMDk2ZWU3MTNkMzQ1ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIwfQ==','2014-10-29 01:31:05'),('lpc3jcpxbh7kkcpk2jdzhhqdyhu477id','OTIzZGZlZWFlNzMzY2U5ZWM2NjA0YzM5ZmRmMTc5MzJhZDA2YzhiZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM0fQ==','2014-12-02 19:19:04'),('lwbktigbfob3qi16gm7w6t3ih4noh0mg','ODQ4YTcxZDZlNjc2MzU2NzEwY2ExMTM2NWJkNTI5OTZkYjI1NThhZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU3fQ==','2015-06-26 16:24:08'),('m1pco38amfpsmn4s0sdxmmwuo4d1qmjv','Nzc1ZjkyNDExYTgzYTc5MjMzZTk2MTA4M2I3MDJmZTQzZmFiNDY2Mjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU4fQ==','2015-09-08 00:00:23'),('m29g9ggas0h8eh76haaci8gisesbnzyt','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-06-17 13:23:05'),('m30t5ekzlcmg8j9lk6g8o3tmzk484eq2','OTcyNGUxYmJlODUzODhlNmYyOTZjOTcyYmNhOTZkZDk3NzRmNDc0ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-06-17 20:34:22'),('ma196ojaocc31cmqh2kdweyukj26d97k','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-06-17 18:37:01'),('mew35chklrw395hpqp8798i3c4t03uxo','NTlmNTJkNzZmNTYxMGVhNGNiOGY4ZjYwMjJhYTM5NWY2MzlmNmNiNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE2fQ==','2014-11-19 21:15:42'),('mgd7qywhyab2mtqca5fypiotjout7mfl','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-07-08 14:20:13'),('mk7k6ieqamwmqnmlvoj99wtor496v51h','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-17 02:01:25'),('mmtl6wweupj21h08elr5fl3bwl1m0jt1','MDY0MTMxNzEzYzQzNzQzZjE3NmVmY2YzYTg1ZmU4NDgzM2NmZmRkNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6OX0=','2014-06-20 14:01:48'),('ms24p6k81gc4gpxs8z4xe0jl8do6xilb','MDQxM2JhYWRjMWEyZTMxNjQ4ZTcyMTdlZjgwMmUxZDVhNjIwZDQzNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ1fQ==','2014-12-02 19:25:53'),('msizuimosv1umlla3cxxk3fwa1idaz6t','MmU2ZGIwOWI3ZDRkNWY5ZTUwZmMzZTVlNzA1MzRmNzEzMThjMjJmZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIxfQ==','2014-11-13 21:35:09'),('mzhmes3znxnp1ojpvszy6tfucl63vdtn','MzVlMWJjNjVhZDNjZTlkZDJkMjc5NjRhMzA5ZmQ3ZjA5Y2E5NDQyNTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMzfQ==','2014-12-02 19:19:02'),('n63241z22m3bxqgb4b62kryrq9j4uo49','NDZjMDY4NThmMzE1NmVlZjhiNzNjNWU4ZjRkMWQ2YTJkODM2Nzk1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6M30=','2014-06-12 02:38:17'),('n6p063g952m8mhivg65z2dddfee2e1ut','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 19:42:38'),('nbbo4auku5omk18etfub31cl5kxjfjtm','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-30 23:42:10'),('ngjv48ivdvofq97oyfxpni3d7eefoinb','NTUwMzczNjE3ODcyNzE4YmRhMDY5YjVhNmEwZWZmNTQ1YTc3MWQ1ZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQyfQ==','2014-12-02 19:22:38'),('ngyx4tc8p5vhvw0nh4nbzb39s2pwyxjv','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-01 20:53:32'),('npnuxe2tui5cdwlu7eeyg27r3jof1f95','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-13 13:26:05'),('nppqs6almjdcg7e3x526fju13mm2j5kh','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-04-12 19:48:03'),('nsbvpx2dlkko4au4hls8q80vwm90puie','YzUzMmFmMjIzNGUxYzBkZmViY2I3NmYzYTE5MTgyM2U2MTEzMGJmODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY5fQ==','2015-09-16 18:38:37'),('nwa0o4qopv2fuv84dfef2jzsak1kaivl','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-03-27 18:08:48'),('nwtd0lctpmkm34wc174rs2rhki8xz24o','ZTMzYjljNDk4MjViNmRhZGM5ZmI5YmYzOTg5NjQ1OTBiYjQ0ODk5Zjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM4fQ==','2014-12-02 19:21:50'),('o5ipz5u2rvpwasua06b0zkw8vdmr9cdo','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-04-16 01:39:00'),('o8khuoutbk48ap5dis6xakv8s6lvmsiu','OGM3NDUzOWYzNTZhMmFjYWNmNTkxYzQ4OTQ5ZTliYjI4NTNmMDhmMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE3fQ==','2015-08-03 12:20:03'),('o906mbd0hvsqf5lqk92anbjjxo8v1kk1','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 19:41:38'),('odtgryh3zf9i4r58kh8ezkua2lt8nzxt','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-30 02:28:20'),('ongzp7fplhho7sgfnlubj7acaz36qgir','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-06-10 23:46:28'),('oxiuxrxh01vpa01j9v1otyzmdky54c2a','YjcxOTgxZGE3ODU1YjQ4Y2ZiZmE1YzVkMWQ3NzQzZDU4YzYzOGJmMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjUwfQ==','2014-12-28 16:10:02'),('pcbtkuf2i9pnvwdet5595sy9mvvul2qe','Y2FhNGU0MzEyY2RmNDlmZDY5MGM1NWU4N2VlZjNmOTllYTVlMzBlZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM2fQ==','2014-12-02 19:19:23'),('pqs7afpllnfk6qb11tepzs9q41oz0pre','ZGU1NWQ4ZmMwYmY2NzFmZWY0NWMyMDNjMWVjNjI4YTQ4NDg2NzM4Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-07-09 02:09:48'),('psv1ozs6phdhqsa3tupk4o3afu4moyy2','YzFmNGNmYjI4YzNkMDRmODNkNzg0OWQ2NmY3YWE3NjBjMDc0NGNiYjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc2fQ==','2015-09-14 22:09:33'),('pzoebjjoejfk4abkpgkzav1sucz6wcal','ZThlOGU0MWExNjhkNTI4N2NhZjYzMzgzYWRiZmM3YmFjM2YxODhhMTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ4fQ==','2014-12-02 21:55:21'),('q0lkg7vjsxvquc3v5sid0mdeuu6nfzy0','YjcxOTgxZGE3ODU1YjQ4Y2ZiZmE1YzVkMWQ3NzQzZDU4YzYzOGJmMzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjUwfQ==','2014-12-29 14:09:02'),('q2ffdwxpy6ejlcmytywh494bx68z094l','ZGU1NWQ4ZmMwYmY2NzFmZWY0NWMyMDNjMWVjNjI4YTQ4NDg2NzM4Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-07-09 03:20:49'),('qc8nu8efv2a7ebxoaoe20axzn6tczgew','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-16 04:09:20'),('qgf65dgn170ebc19wrjuouqfrhdgft5f','ZDNiZjgxZDA3YzFhYTcxZTQ3ZmQzNTEwNzViNWY1N2Q5YmY5Nzc2ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQxfQ==','2014-12-02 19:21:54'),('qn0aklvqe6pjmzc0yjkubbdygvcq9u71','YjgxZDdhODk5MDNhZTVmNzEyMDk2ZjkxN2U3NGQwMDIyN2Y0ZDk2ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMxfQ==','2014-12-03 01:04:40'),('qnqh4ntzxb88msquj32sf5922b2ci5hy','MDQxM2JhYWRjMWEyZTMxNjQ4ZTcyMTdlZjgwMmUxZDVhNjIwZDQzNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ1fQ==','2014-12-03 16:05:59'),('qpr0r1qe53nc27vnqpetfpqj58ef9mxj','YjY2OTVhNmZmMTMyOTc1NDc3NDQzNmU5ZjQ3OTBlNmY4NDI2MmE0Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI4fQ==','2014-12-23 19:11:32'),('qrp85jcqfd1741h3op3hya8e5fyllhg1','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 18:58:30'),('qu72tkkv1q07nzlb2xx9gweulrft005s','ZThlOGU0MWExNjhkNTI4N2NhZjYzMzgzYWRiZmM3YmFjM2YxODhhMTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ4fQ==','2014-12-23 19:17:19'),('qysek54mnk2ixkcpch19am9u03unuse5','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-03-19 18:30:59'),('r73zf7091m60031vc8hh4a8darhpapcw','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-07-21 20:55:17'),('rigitdr3tbch17ds2imy7xc1nhsrs3rt','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-30 23:45:33'),('rmgiy3xd447wpvail7bvu77opdgkmf01','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2014-12-30 21:58:15'),('rubnu8gn0vj4gq3tzd4d6o7qaqraj6wu','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-06-23 17:13:15'),('rvq315eqdnew2vj3vy77llare7ztwdkh','NjY4ZGM1MDgwMDc0YzMzNDRiZjljNGM1ZGNlMGI0ZDA4ZTIxODlmODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTF9','2014-08-08 21:48:12'),('sab4652frlc42f9kj24wpgkuughxy3zo','YTA4YzU0OThlODI2N2NkZWExMzY2NmUxMDI2MGNhMWU0NzFlYTU1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY3fQ==','2015-09-24 00:17:01'),('sew1sis2c3xt235m2ckugc7xor7zxkvi','YTA4YzU0OThlODI2N2NkZWExMzY2NmUxMDI2MGNhMWU0NzFlYTU1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY3fQ==','2015-09-13 17:52:56'),('sf2xq3xhsmki0j167ih06amy6wrxxd39','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-29 07:20:05'),('sr6q3c728n2apx7kgfgih009agtrphts','ODRhOTJhZjRlNWQ4NTEzZTJjMjg1Y2JlYmFiNGIwZjk5NzMyYWUyOTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTN9','2014-07-24 00:47:47'),('ssjpcbdahcdqum49l1mwoa778ps8ey04','OTIzNWFlY2UxZTM3YzVkNTZkMTVkMTlkZjJjYzEyYjdjZDA4YTgxODp7Il9hdXRoX3VzZXJfaGFzaCI6IjI1MmM2YTE4MTBjNGZlNWU0YjY1ZDU1YjU2Zjc0OWQ5OWI4OTJiZmEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJjYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI1NSJ9','2015-10-18 00:54:38'),('syqnl46v6nrl6oixpemmux4bwkgkehby','ZDhiMzBiOTk4ZmNkYjI3MDVjZWQ5ZGYxNWU2NjIyNGRmZDJmZmI5MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjUyfQ==','2015-04-09 13:45:47'),('t6l2xkqsmmdpydl6r2jkb8ic579ocal7','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-12 22:33:10'),('tgfuphyagycfwhh2s7xccnckvp0ndhpz','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-04-27 15:26:13'),('thmdjeerwuhqaq25ophxr8sa1qy3m25g','NTNkNWM2ZWJiNzBjNTE4NWVhNGQ4ZjNmN2M3ZDliNDY3N2RhOTI3ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU5fQ==','2015-09-14 17:34:32'),('twyd7zzlioexa0wwz86i5y8vsytnvurn','YTJmNmFhNGYwMTdkNTgzNDIyMmNhOWJjODNjMDk2ZWU3MTNkMzQ1ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIwfQ==','2014-10-29 14:41:22'),('u17uut9ynuikpiv07l1wp6f5689zz4pe','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-05-13 17:12:23'),('u3d8km243u650qziz3xrrufmp5cj8zvb','MTM5MTA0NzVmMjIxZTYwZjQyMDUwYTg2MTJlNmMyNjhhYTRlZjEwZjp7Il9hdXRoX3VzZXJfaWQiOjIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2014-07-09 01:37:17'),('u7t6kpuuz5ggn7ptvl4a0g9n6jimvc0g','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-06-01 04:07:55'),('u8drckz023yvagvao6jh35z5bn8c9b6q','MjM2ZmNhOWM5NzYzMjE5NjM0NWMyNThjNTZmNDA2YTE1MTE5OTZhZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM3fQ==','2014-12-02 19:19:34'),('u8mqtep4w8k4jd6kxhbakwo3oev7gggi','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-03-19 17:23:32'),('uamjmbwttf7cmwgl12c4ag60335ld3hw','YjgxZDdhODk5MDNhZTVmNzEyMDk2ZjkxN2U3NGQwMDIyN2Y0ZDk2ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjMxfQ==','2014-12-18 03:11:13'),('ubsfjj3mmarcunsott1sj6d0se70me9l','NTU4YmE4ZmY5NTU5OGY5ZDg3NDFlMTdkMGFiNTIxN2I0MjkyYjNjNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY2fQ==','2015-09-14 21:56:41'),('ufhkpmd7six50b69b136ytjp9kzyrdsg','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-03-05 04:01:12'),('uhg7nlorhhrsvmn01tbiof9w788rraia','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2014-10-27 17:36:07'),('umqwvx0h1oo0jyjgpcw3753axrupf74i','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-08-25 15:19:33'),('uncbyj8pg25f7zjaojro6d16d1brc0ld','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-08-27 03:22:57'),('uwywgi1iszak7twdzfu74epauer7adz6','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-09-06 05:42:49'),('v2s6i5hubstpoevy98xgz55zgshsidd4','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-09-08 00:17:28'),('vdzapc8331y2zq8sl900idy56m5tmtd6','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2014-12-02 21:40:45'),('vg91ngaqxylvnr5y9y07auydjs033pfs','OTIzZGZlZWFlNzMzY2U5ZWM2NjA0YzM5ZmRmMTc5MzJhZDA2YzhiZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM0fQ==','2014-12-03 01:48:55'),('vgz9ow5juhtdm6aaip6e7m2ymabilcwx','MDM0NDlkY2Y4MTg0NjMwODFlMmJkYjAxM2FmOGZkZjM3YTY3YWEwZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQ2fQ==','2014-12-02 19:27:13'),('vin69ud6fzuk895zinqqgsuvnbskh84f','Nzc1ZjkyNDExYTgzYTc5MjMzZTk2MTA4M2I3MDJmZTQzZmFiNDY2Mjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU4fQ==','2015-09-14 18:08:56'),('vwo1boyal4am6tgoa58tgtj3xhamexnq','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-04-21 13:51:02'),('w21nhj8iz1vpw8jpuytt07b03dgaddy8','YTA4YzU0OThlODI2N2NkZWExMzY2NmUxMDI2MGNhMWU0NzFlYTU1MTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY3fQ==','2015-09-23 23:01:49'),('w2gkmxv1ysbmbwg0g9vh31zio53r0s80','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2015-06-24 23:47:08'),('w8ktf71snn9sc8e13zi5s4lub3r8q75j','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-17 19:06:22'),('wls5mab1c7yh81v6q1v3w865p0230uil','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-08-28 15:04:14'),('wn0dyqteb8pixb542jtgjpw7ibqc3tp2','ZGU1NWQ4ZmMwYmY2NzFmZWY0NWMyMDNjMWVjNjI4YTQ4NDg2NzM4Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-07-07 01:14:39'),('wrrrmj09ge1bvgesvv4ai9gaig69u5hz','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-18 16:03:40'),('x2wxyh2le1u1xdbui70riwxlyhkcscje','NTU4YmE4ZmY5NTU5OGY5ZDg3NDFlMTdkMGFiNTIxN2I0MjkyYjNjNzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjY2fQ==','2015-09-16 00:52:47'),('xdmekp3uov3mosqczx56jzz1e2mh38ox','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-11-30 23:40:00'),('xfi8g87b9d0r8d89r30wk4pnkkusazwz','MTJmM2VmOWUxM2U0MGIwNmFhMzRkNDVkMzkzODRlMWI0Y2QzZDMzZjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjcwfQ==','2015-09-14 10:42:49'),('xmbk6tphkqn4p3deg3c9r0xtjydp92dh','N2E1YjVmMzBkYWVlMDljODllZGUyOWYxOWZhOTg3MTBiMzg2NGU1Mzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU0fQ==','2015-09-10 18:25:35'),('xtnveq5dyernpivnmplhpuqrwt7ljxia','NjdmYjliN2FiMGQ0YzdlYTYwODYyMTAzNTQ5MGEyZjc0NjljMzAyZTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIyfQ==','2015-05-20 14:03:23'),('xuefm02nuchh5j07ubiskyyrnuh6a9d9','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-08-16 20:31:29'),('xxhaxcc8kb0j65kls7beir8l9ydbasst','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-02-09 15:56:42'),('y18dzomyhrgv71c975us5515hp16tgjq','ZDgwMGZmYTNjMzNlZGNkYjUxNzVkMTUzZTUxOTlhMTgxMTlmNTQ2NTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc0fQ==','2015-09-14 22:09:11'),('y2q06ibg07vj420rzwggx4q0rjrsjjco','ZGU1NWQ4ZmMwYmY2NzFmZWY0NWMyMDNjMWVjNjI4YTQ4NDg2NzM4Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MTB9','2014-07-07 02:29:34'),('y6xp7bupmbq3omx2js2xnyw9indaxlrh','YmIxYTNkMDMxMWM1MzA2ODY2ZTAxNTk2MmIzYTIzNjJlMzUzODY2Yzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6Mn0=','2014-06-10 22:25:51'),('yc5blrt8aqujej43xzjd7ecjzqlyyhmx','NWYxNDBiNTlkOTc1ZGFlYTJjOTFkZTgzOWI5ZDYwYjY3OWE3ODI1Zjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjI2fQ==','2014-12-02 19:18:34'),('yovpqmc4yak1kxi5cdrq8ycdcgjqz6fr','NDg2YjI3NmI4MGE4MjExYjVlZDEyODc0OWYwMjFhM2IzMGE3NGJkNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjU1fQ==','2015-09-19 05:02:45'),('ypbnwbsj6ybq7pu5lk177abktgzu9enq','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2014-12-18 19:16:45'),('yq46wag1q7qmb97ccd98jxd1w7hx0q6q','YTJmNmFhNGYwMTdkNTgzNDIyMmNhOWJjODNjMDk2ZWU3MTNkMzQ1ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIwfQ==','2014-10-29 14:34:15'),('yyj37mpf655q8itr8qowg40r88eqwxvi','ZjM3NjMwMzljYTlmMmNmZmZiODBiMWE1Yzk1NWViZjY3YmVhOTFjMjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjQwfQ==','2014-12-30 13:38:26'),('yz0btsu3va266agl7bndwqd27dnd17kq','OTcyNGUxYmJlODUzODhlNmYyOTZjOTcyYmNhOTZkZDk3NzRmNDc0ZDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-08-02 17:33:24'),('z4kuaeuyc39h2h7hyf4t54w07kppbl4l','MjFhMDc4NzNmZmEyOWRiMDk5NjYzMjZkNDdiMWE0NTIxNzFkOWM4Njp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjM5fQ==','2014-12-15 20:00:16'),('z7n8e7mvkyagsv1tzpahi6fkmqdf1err','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-09-16 03:45:51'),('z7vt00iy40qebyjvomjr5zj0xlmcovwi','ZGVjYWE5MjI4N2ZmMWQ4MDc3NmM5NjZkNmY3MDU1NjFiYzEzZDA0Njp7fQ==','2015-04-19 16:36:06'),('z99euiw92nw7pyztwk54iqrmxfslos85','Mjc0NDE1NDY3NmNhNTkyOWIxMWM5YmMzNGQ0YWMyMWE3YTUzMWUxYTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjE1fQ==','2015-04-27 15:46:59'),('zh6anrx6246da8g8a4up2fiawsc3l2m2','NjhhOTBlNGU4YmE0OWUzODkxNWFmOGM4ZDcyMzQ4ZDljOTI1Njk3NTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjc3fQ==','2015-09-15 20:46:47'),('znzzmh7egmox2loz0a41se0fmwm8kn7q','MWQ2OGQyM2FhNWVhMzU3MWMzYzI4OTdmZWNlMTg1MzZjOTA1MWY3ODp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjIzfQ==','2014-11-14 14:50:11'),('zvg3kpzcdf8r43meb3vdrltl930v1e4c','ZDU4OTM4NmFmOTk3OTI3N2FjMDRkNWZhNzM5YTNiZDZmNWU3OTM4MDp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjl9','2014-09-02 23:20:29'),('zvxhll7mndfmtqo6o6amx28wh6e2n5bx','ZDBkNDY1ZjhkOWJhMzY5MDhjZTg1MDQ1Njk0YTI4MmZhYzk1ZWFhNjp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nb19jYXMuYmFja2VuZHMuQ0FTQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjYzfQ==','2015-09-09 15:38:55');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_computerlab`
--

DROP TABLE IF EXISTS `lab_computerlab`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_computerlab` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `labname` varchar(100) NOT NULL,
  `labdescription` varchar(100) NOT NULL,
  `coursename` varchar(100) NOT NULL,
  `coursecode` varchar(100) NOT NULL,
  `coursesemester` varchar(100) NOT NULL,
  `courseinstructor` varchar(100) NOT NULL,
  `instructor_id` varchar(20) DEFAULT NULL,
  `amazonami` varchar(100) NOT NULL,
  `date_created` datetime NOT NULL,
  `lab_auth_info` varchar(100) NOT NULL,
  `lab_connection_options` varchar(100) NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `instance_type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_computerlab`
--

LOCK TABLES `lab_computerlab` WRITE;
/*!40000 ALTER TABLE `lab_computerlab` DISABLE KEYS */;
INSERT INTO `lab_computerlab` VALUES (2,'INST737','Computer lab for INST 737','Digging into Data','INST737_Spring2013','Spring 2015','Jordan Boyd-Graber','ssachar','ami-ddb239b4','2014-05-27 17:27:37','Username = inst737, password = datascience','RDP, SSH, NX Viewer','vcl_lab','ti.micro'),(4,'INST 733','Computer Lab for Database Design INST 733','Database Design','INST733_Spring2013','Spring 2013','Vedat Diker','Dave','ami-dfd347b6','2014-06-23 22:30:04','Username = inst733, password = norelation','RDP, SSH, NX Viewer','vcl_lab','ti.micro'),(8,'Digital Curation - ARCGIS Unlocked','Computer Lab for INST640 - Unlocked','Digital Curation','INST640','Fall 2014','Richard Marciano',NULL,'ami-d48f07bc','2014-11-12 14:34:47','Username = Administrator, Password = Dclab@umd','RDP, SSH, NX Viewer','vcl_lab','ti.micro'),(9,'Big Data - INST 767','Computer Lab for INST 767','Big Data Infrastructure','INST767_Spring2015','Spring 2015','Jimmy Lin',NULL,'ami-1cca8d74','2015-01-29 10:28:06','Username = inst737, password = datascience','RDP, SSH, NX Viewer','vcl_lab','ti.micro'),(10,'Demo WIN','DEMO FOR WIN','WINDOWS RAW IMAGE','WIN','FALL 20165','XYZ',NULL,'ami-c76e84ac','2015-06-09 13:58:34','Username = inst737, password = datascience','RDP, SSH, NX Viewer','vcl_lab','ti.micro'),(11,'Development of Internet Applications - INST 743','Computer Lab for INST 743','Development of Internet Applications','INST743_Fall2015','Fall 2015','Jen Golbeck','ssachar','ami-276bec4c','2015-07-08 22:27:50','Username = inst743, password = perl','RDP, SSH','vcl_lab','ti.micro'),(12,'Ubuntu Characterization Test','Ubuntu Characterization Test','Ubuntu Characterization Test','TEST-UB','Fall 2015','Allison',NULL,'ami-c9c5a6ac','2015-09-05 01:03:46','no yet defined','RDP, SSH','vcl_lab','ti.micro');
/*!40000 ALTER TABLE `lab_computerlab` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lab_instructor`
--

DROP TABLE IF EXISTS `lab_instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lab_instructor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` varchar(50) NOT NULL,
  `instance_id` varchar(50) DEFAULT NULL,
  `course_id` varchar(50) NOT NULL,
  `student_id` varchar(50) NOT NULL,
  `student_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_course` (`instructor_id`,`course_id`,`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lab_instructor`
--

LOCK TABLES `lab_instructor` WRITE;
/*!40000 ALTER TABLE `lab_instructor` DISABLE KEYS */;
INSERT INTO `lab_instructor` VALUES (2,'ssachar','i-181f42b8','INST737_Spring2013','infoadmin',''),(6,'ssachar','i-773964d7','INST737_Spring2013','ssachar',''),(7,'ssachar','i-3c35699c','INST737_Spring2013','Dave',''),(8,'ssachar','i-67ad86c7','INST743_Fall2015','ssachar','');
/*!40000 ALTER TABLE `lab_instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `user_id_refs_id_954d2985` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_registrationprofile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-04  2:52:39
