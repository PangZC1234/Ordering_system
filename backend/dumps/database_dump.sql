-- MySQL dump 10.13  Distrib 8.0.37, for Linux (x86_64)
--
-- Host: localhost    Database: ordering_system
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.22.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add blacklisted token',6,'add_blacklistedtoken'),(22,'Can change blacklisted token',6,'change_blacklistedtoken'),(23,'Can delete blacklisted token',6,'delete_blacklistedtoken'),(24,'Can view blacklisted token',6,'view_blacklistedtoken'),(25,'Can add outstanding token',7,'add_outstandingtoken'),(26,'Can change outstanding token',7,'change_outstandingtoken'),(27,'Can delete outstanding token',7,'delete_outstandingtoken'),(28,'Can view outstanding token',7,'view_outstandingtoken'),(29,'Can add category',8,'add_category'),(30,'Can change category',8,'change_category'),(31,'Can delete category',8,'delete_category'),(32,'Can view category',8,'view_category'),(33,'Can add dining table',9,'add_diningtable'),(34,'Can change dining table',9,'change_diningtable'),(35,'Can delete dining table',9,'delete_diningtable'),(36,'Can view dining table',9,'view_diningtable'),(37,'Can add invoice',10,'add_invoice'),(38,'Can change invoice',10,'change_invoice'),(39,'Can delete invoice',10,'delete_invoice'),(40,'Can view invoice',10,'view_invoice'),(41,'Can add menu',11,'add_menu'),(42,'Can change menu',11,'change_menu'),(43,'Can delete menu',11,'delete_menu'),(44,'Can view menu',11,'view_menu'),(45,'Can add order',12,'add_order'),(46,'Can change order',12,'change_order'),(47,'Can delete order',12,'delete_order'),(48,'Can view order',12,'view_order'),(49,'Can add app user',13,'add_appuser'),(50,'Can change app user',13,'change_appuser'),(51,'Can delete app user',13,'delete_appuser'),(52,'Can view app user',13,'view_appuser');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_user_api_appuser_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_api_appuser_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_api_appuser` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(5,'sessions','session'),(6,'token_blacklist','blacklistedtoken'),(7,'token_blacklist','outstandingtoken'),(13,'user_api','appuser'),(8,'user_api','category'),(9,'user_api','diningtable'),(10,'user_api','invoice'),(11,'user_api','menu'),(12,'user_api','order');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-06-24 14:17:42.812543'),(2,'contenttypes','0002_remove_content_type_name','2024-06-24 14:17:42.900339'),(3,'auth','0001_initial','2024-06-24 14:17:43.289338'),(4,'auth','0002_alter_permission_name_max_length','2024-06-24 14:17:43.401386'),(5,'auth','0003_alter_user_email_max_length','2024-06-24 14:17:43.418009'),(6,'auth','0004_alter_user_username_opts','2024-06-24 14:17:43.431562'),(7,'auth','0005_alter_user_last_login_null','2024-06-24 14:17:43.446384'),(8,'auth','0006_require_contenttypes_0002','2024-06-24 14:17:43.454244'),(9,'auth','0007_alter_validators_add_error_messages','2024-06-24 14:17:43.470132'),(10,'auth','0008_alter_user_username_max_length','2024-06-24 14:17:43.481370'),(11,'auth','0009_alter_user_last_name_max_length','2024-06-24 14:17:43.492381'),(12,'auth','0010_alter_group_name_max_length','2024-06-24 14:17:43.515205'),(13,'auth','0011_update_proxy_permissions','2024-06-24 14:17:43.525102'),(14,'auth','0012_alter_user_first_name_max_length','2024-06-24 14:17:43.535421'),(15,'user_api','0001_initial','2024-06-24 14:17:44.447898'),(16,'admin','0001_initial','2024-06-24 14:17:44.656649'),(17,'admin','0002_logentry_remove_auto_add','2024-06-24 14:17:44.672792'),(18,'admin','0003_logentry_add_action_flag_choices','2024-06-24 14:17:44.686101'),(19,'sessions','0001_initial','2024-06-24 14:17:44.748449'),(20,'token_blacklist','0001_initial','2024-06-24 14:17:44.978454'),(21,'token_blacklist','0002_outstandingtoken_jti_hex','2024-06-24 14:17:45.015914'),(22,'token_blacklist','0003_auto_20171017_2007','2024-06-24 14:17:45.034392'),(23,'token_blacklist','0004_auto_20171017_2013','2024-06-24 14:17:45.133345'),(24,'token_blacklist','0005_remove_outstandingtoken_jti','2024-06-24 14:17:45.200300'),(25,'token_blacklist','0006_auto_20171017_2113','2024-06-24 14:17:45.238054'),(26,'token_blacklist','0007_auto_20171017_2214','2024-06-24 14:17:45.488103'),(27,'token_blacklist','0008_migrate_to_bigautofield','2024-06-24 14:17:45.817511'),(28,'token_blacklist','0010_fix_migrate_to_bigautofield','2024-06-24 14:17:45.836057'),(29,'token_blacklist','0011_linearizes_history','2024-06-24 14:17:45.843078'),(30,'token_blacklist','0012_alter_outstandingtoken_user','2024-06-24 14:17:45.856981'),(31,'user_api','0002_alter_order_invoice','2024-06-24 14:17:45.868998'),(32,'user_api','0003_rename_table_invoice_table_id','2024-06-24 14:17:45.993049'),(33,'user_api','0004_order_done_flag','2024-06-24 14:17:46.037033'),(34,'user_api','0005_remove_order_done_flag_order_current_quantity','2024-06-24 14:17:46.106223'),(35,'user_api','0006_rename_user_id_appuser_id','2024-06-24 14:17:46.139310');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_blacklistedtoken`
--

DROP TABLE IF EXISTS `token_blacklist_blacklistedtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_blacklistedtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `blacklisted_at` datetime(6) NOT NULL,
  `token_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_id` (`token_id`),
  CONSTRAINT `token_blacklist_blacklistedtoken_token_id_3cc7fe56_fk` FOREIGN KEY (`token_id`) REFERENCES `token_blacklist_outstandingtoken` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_blacklistedtoken`
--

LOCK TABLES `token_blacklist_blacklistedtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_blacklistedtoken` VALUES (1,'2024-06-24 14:19:11.776000',1),(2,'2024-06-24 14:49:16.161000',2),(3,'2024-06-24 14:49:27.040000',3),(4,'2024-06-24 14:52:46.722081',4),(5,'2024-06-27 03:09:44.842016',6),(6,'2024-06-27 03:35:40.729023',7),(10,'2024-06-27 03:35:40.794360',8),(11,'2024-06-27 03:35:40.924866',9),(12,'2024-06-27 03:35:40.929997',10),(14,'2024-06-27 03:41:42.268946',12),(15,'2024-06-27 03:46:57.754714',13),(16,'2024-06-27 03:52:26.238858',14),(17,'2024-06-27 04:04:00.216853',15),(18,'2024-06-27 04:04:30.705819',16),(19,'2024-06-27 04:05:04.818605',17),(20,'2024-06-27 04:09:12.502793',18),(21,'2024-06-27 04:09:18.264070',19),(22,'2024-06-27 04:09:39.639900',20),(23,'2024-06-27 04:17:38.022992',21),(26,'2024-06-27 04:17:38.212191',22),(28,'2024-06-27 04:17:38.356331',24),(29,'2024-06-27 04:17:38.454350',25),(30,'2024-06-27 04:17:38.597479',26),(33,'2024-06-27 04:18:02.785915',30),(34,'2024-06-27 04:19:23.312063',31),(35,'2024-06-27 04:29:56.483298',32),(38,'2024-06-27 04:47:29.206613',33),(41,'2024-06-27 16:00:15.596749',37),(42,'2024-06-27 16:04:01.688397',39),(43,'2024-06-27 16:06:42.059872',40),(44,'2024-06-27 16:09:14.398775',41),(45,'2024-06-27 16:09:52.667155',42),(46,'2024-06-27 16:11:21.233949',43),(47,'2024-06-27 16:17:11.264889',44),(50,'2024-06-27 16:18:44.898447',45),(51,'2024-06-27 16:19:07.071830',46),(52,'2024-06-27 16:19:13.454572',47),(53,'2024-06-27 16:20:47.833514',48),(54,'2024-06-27 16:26:58.683962',49),(57,'2024-06-27 16:32:03.744052',50),(60,'2024-06-27 16:37:08.443033',53),(63,'2024-06-27 16:42:44.986025',56),(65,'2024-06-27 16:48:28.187206',59),(66,'2024-06-27 16:48:28.392931',60),(67,'2024-06-27 16:48:28.569373',63),(68,'2024-06-27 16:51:30.757802',66),(69,'2024-06-27 16:57:00.909269',67),(72,'2024-06-27 17:03:47.391442',68),(75,'2024-06-27 17:10:25.148349',71),(77,'2024-06-27 17:10:25.181623',73),(78,'2024-06-27 17:16:02.910007',74),(81,'2024-06-27 17:21:53.140763',77),(82,'2024-06-27 17:30:23.905721',78),(85,'2024-06-27 17:36:37.348059',81),(88,'2024-06-27 17:41:38.585969',84),(91,'2024-06-28 03:06:19.442755',87),(93,'2024-06-28 03:14:53.165301',90),(94,'2024-06-28 03:14:53.431199',91),(96,'2024-06-28 03:14:53.556263',95),(97,'2024-06-28 03:14:53.590119',96),(99,'2024-06-28 03:14:53.685166',99),(100,'2024-06-28 03:14:53.800571',100),(103,'2024-06-28 03:20:32.618468',103),(106,'2024-06-28 03:25:43.682387',106),(109,'2024-06-28 03:34:21.673524',109),(111,'2024-06-28 03:43:20.963249',112),(113,'2024-06-28 03:48:33.664486',115),(116,'2024-06-28 03:53:48.663067',118),(119,'2024-06-28 04:01:47.669968',121),(122,'2024-06-28 04:08:00.113359',124),(123,'2024-06-28 04:13:27.639740',125),(125,'2024-06-28 04:13:27.802729',127),(127,'2024-06-28 04:13:28.001967',130),(128,'2024-06-28 04:13:28.007603',132),(131,'2024-06-28 04:13:28.155718',134),(132,'2024-06-28 04:28:36.153603',135),(135,'2024-06-28 04:32:51.453124',136),(136,'2024-06-28 04:37:56.339885',137),(137,'2024-06-28 04:42:52.852798',138),(138,'2024-06-28 04:42:56.888013',139),(139,'2024-06-28 04:44:54.887931',140),(140,'2024-06-28 04:50:16.876174',141),(143,'2024-06-28 04:55:15.177018',142),(144,'2024-06-28 04:55:36.723222',143),(145,'2024-06-28 04:55:49.117677',144),(146,'2024-06-28 04:56:58.804385',145),(147,'2024-06-30 15:43:15.524181',147),(150,'2024-06-30 15:43:31.820382',148),(151,'2024-06-30 16:11:03.352889',150);
/*!40000 ALTER TABLE `token_blacklist_blacklistedtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token_blacklist_outstandingtoken`
--

DROP TABLE IF EXISTS `token_blacklist_outstandingtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `token_blacklist_outstandingtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `expires_at` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL,
  `jti` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token_blacklist_outstandingtoken_jti_hex_d9bdf6f7_uniq` (`jti`),
  KEY `token_blacklist_outs_user_id_83bc629a_fk_user_api_` (`user_id`),
  CONSTRAINT `token_blacklist_outs_user_id_83bc629a_fk_user_api_` FOREIGN KEY (`user_id`) REFERENCES `user_api_appuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token_blacklist_outstandingtoken`
--

LOCK TABLES `token_blacklist_outstandingtoken` WRITE;
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` DISABLE KEYS */;
INSERT INTO `token_blacklist_outstandingtoken` VALUES (1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTMyMzc5OSwiaWF0IjoxNzE5MjM3Mzk5LCJqdGkiOiIzMDI5NDc5OWI1ZmE0MTBkOTM5ZjM5NGExYjg3NzBiYyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.PtBeEexMfTbyEjDVtFS3W6oOgU4KJpaCejL-aP-ppKQ',NULL,'2024-06-25 13:56:39.000000',NULL,'30294799b5fa410d939f394a1b8770bc'),(2,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTMyNjIxMywiaWF0IjoxNzE5MjM5ODEzLCJqdGkiOiJiMTRlY2Q1YjY0ZTk0MDQ3OTE1NTQ1NDc3ZWMzZDY0NSIsInVzZXJfaWQiOjF9.F4hwyTE5ivZYsqpRXmAmbWKWiN1OGBx0jcDO8lgStgw','2024-06-24 14:36:53.255000','2024-06-25 14:36:53.000000',1,'b14ecd5b64e94047915545477ec3d645'),(3,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTMyNjk1NywiaWF0IjoxNzE5MjQwNTU3LCJqdGkiOiI3YTgxZTE4YzM1NTY0N2E1YjZkOTRmODM0OWVmZWQ2YiIsInVzZXJfaWQiOjF9.XFPH3gPypOCpb1n5ESenEC-cvByh_YY2QD-Byd-NUjY','2024-06-24 14:49:17.942000','2024-06-25 14:49:17.000000',1,'7a81e18c355647a5b6d94f8349efed6b'),(4,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTMyNjk5MSwiaWF0IjoxNzE5MjQwNTkxLCJqdGkiOiJlOWZlMDI0MTRmMmY0NjE4OWNmNWE5MjhhYjU4YzRhYiIsInVzZXJfaWQiOjF9.MpVu7OVSe2QGLh1K3JCEzwYfITnHFNQMVaEFbRG5YE8','2024-06-24 14:49:51.100000','2024-06-25 14:49:51.000000',1,'e9fe02414f2f46189cf5a928ab58c4ab'),(5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTMyNjk5MSwiaWF0IjoxNzE5MjQwNTkxLCJqdGkiOiJkM2Q4NTVhYTU2OWE0OGJmOWI5YTRkOTE5YmIzZGM3MCIsInVzZXJfaWQiOjF9.7_bIVbXhojvRJlJgL5pGZmzr1GKuxcqYEoBIPBy0NdY','2024-06-24 14:49:51.503000','2024-06-25 14:49:51.000000',1,'d3d855aa569a48bf9b9a4d919bb3dc70'),(6,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NDEzNiwiaWF0IjoxNzE5NDU3NzM2LCJqdGkiOiI2NjZlYjZmNDBiNmU0NTYyYTk5OTBkODFlYTc2NjNiMiIsInVzZXJfaWQiOjF9.8FQt65KL9tNDUrm6RDcFTpYevVpvAcRn7lnHcloYY2I','2024-06-27 03:08:56.397581','2024-06-28 03:08:56.000000',1,'666eb6f40b6e4562a9990d81ea7663b2'),(7,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NTIzNiwiaWF0IjoxNzE5NDU4ODM2LCJqdGkiOiIzMjI3ZWRjZmNjZDI0OGJhODRiMmM1OTQyNzdkM2Y5MiIsInVzZXJfaWQiOjF9.NjNTmWCdFtM7bsHK1q647WnbGi8jSX-7clHkOJG1a9g','2024-06-27 03:27:16.673931','2024-06-28 03:27:16.000000',1,'3227edcfccd248ba84b2c594277d3f92'),(8,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NTc0MCwiaWF0IjoxNzE5NDU5MzQwLCJqdGkiOiJkZjU5M2NjODNkMzA0Y2IzODU5MzBhZTdiMDQ5MzFiOSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.aD6ntaLdy5_n3LjXWr4DxhPeCWbKHxP9NCEnZ7AKL9I',NULL,'2024-06-28 03:35:40.000000',NULL,'df593cc83d304cb385930ae7b04931b9'),(9,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NTc0MCwiaWF0IjoxNzE5NDU5MzQwLCJqdGkiOiI5MmNlNTliNGFkYzM0Y2Y2YTc2NjIyMTI0M2UwNTUwOCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.NGwH5vyTQFdLFUrruj0amFAHDf1AKKbWlOKnZ-czTrQ',NULL,'2024-06-28 03:35:40.000000',NULL,'92ce59b4adc34cf6a766221243e05508'),(10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NTc0MCwiaWF0IjoxNzE5NDU5MzQwLCJqdGkiOiIxMTk5ZGJhMjA0M2Y0MTAzOTA3NjAyZjVkODI3OGVmZiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.k4WoKPBHbE30c3u3oKcPRLOlEhtpsnuXvyJcXaRmmbQ',NULL,'2024-06-28 03:35:40.000000',NULL,'1199dba2043f4103907602f5d8278eff'),(12,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NTc0MiwiaWF0IjoxNzE5NDU5MzQyLCJqdGkiOiI1MjBkMjNkOGM5MmY0ODg3OWU3YmExZjQ3YjRhMmJiMSIsInVzZXJfaWQiOjF9.T-9CCzzt5Lf4uDH3j5vRUjjQ56GWYHhvdMN2i4t1Fz0','2024-06-27 03:35:42.481904','2024-06-28 03:35:42.000000',1,'520d23d8c92f48879e7ba1f47b4a2bb1'),(13,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NjEwMiwiaWF0IjoxNzE5NDU5NzAyLCJqdGkiOiIyNjY5YzMzYzVhNTc0ZDFiODNhNmNjZWM1NTk4MzgyMyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.ecKwhhyprqTXIc7rT2dmlZUQJHhQd6u_oZue8JPOXvo',NULL,'2024-06-28 03:41:42.000000',NULL,'2669c33c5a574d1b83a6ccec55983823'),(14,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NjQxNywiaWF0IjoxNzE5NDYwMDE3LCJqdGkiOiJhN2MyZTVjYTZiZWI0NTZlODBhNTNlY2I1Y2QyMDkzYiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.OJqIZZ6na21sBB1ve0WQnzUjuhd03iC4NShrRVkeqMA',NULL,'2024-06-28 03:46:57.000000',NULL,'a7c2e5ca6beb456e80a53ecb5cd2093b'),(15,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0Njc0NiwiaWF0IjoxNzE5NDYwMzQ2LCJqdGkiOiJmMTZhMzU3ZjVmZDM0OWI2YWE1OTliMWFmYWY0MDc3ZSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.lZqCdg_ViXTVeww1TeuKXxww7yWd9AA1tlOsy5_WMek',NULL,'2024-06-28 03:52:26.000000',NULL,'f16a357f5fd349b6aa599b1afaf4077e'),(16,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NzQ0NCwiaWF0IjoxNzE5NDYxMDQ0LCJqdGkiOiJjZTdlNDU5NzgyMDY0Y2Y1OThmZWJlY2RlMDE5MmYzNiIsInVzZXJfaWQiOjF9.SOJ2UqcdXHXLoMxUqHKy3zHwt8jGNlqzbbeiwOupUI4','2024-06-27 04:04:04.807742','2024-06-28 04:04:04.000000',1,'ce7e459782064cf598febecde0192f36'),(17,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NzQ3MywiaWF0IjoxNzE5NDYxMDczLCJqdGkiOiI0Y2RmMDkzYjdiNTM0OTJmYWJkZTNhYzRlNjEyZTBmNSIsInVzZXJfaWQiOjF9.Ois88oHpWsy4tjUQKK44WobV_z6cl5KH6jhRIpoN-Ig','2024-06-27 04:04:33.151556','2024-06-28 04:04:33.000000',1,'4cdf093b7b53492fabde3ac4e612e0f5'),(18,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0NzUwNywiaWF0IjoxNzE5NDYxMTA3LCJqdGkiOiI0OWZmNmRhNDY0ZTM0NjRhODkwMDA2YWIxZWZlOThhMSIsInVzZXJfaWQiOjF9.BHNMobx0ZSjaEaAYaS648xa_mv3hztQGifUqr8YSJsg','2024-06-27 04:05:07.846411','2024-06-28 04:05:07.000000',1,'49ff6da464e3464a890006ab1efe98a1'),(19,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0Nzc1NiwiaWF0IjoxNzE5NDYxMzU2LCJqdGkiOiI1MDMwOTc4ZDY0YWI0NjY2YjlkOTQxNjU4MmJjYjdiZSIsInVzZXJfaWQiOjF9.6DwG1NDCDk3xH9pjF_FFiexvooysAYdjl4B1dAzsHuk','2024-06-27 04:09:16.638917','2024-06-28 04:09:16.000000',1,'5030978d64ab4666b9d9416582bcb7be'),(20,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0Nzc2MywiaWF0IjoxNzE5NDYxMzYzLCJqdGkiOiI1ZDY4ZTFiYzY2MjE0NjJjYmZjYjhiNjVlNDA5NjllMCIsInVzZXJfaWQiOjF9.wub_IpXti-AFcyOQf2de29vqlguslvU1LU96aJvbONU','2024-06-27 04:09:23.387664','2024-06-28 04:09:23.000000',1,'5d68e1bc6621462cbfcb8b65e40969e0'),(21,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0Nzc4MSwiaWF0IjoxNzE5NDYxMzgxLCJqdGkiOiI4ZjQwYmY4OTcwNTQ0MjU3YTBmMTM1NDUyNDNiMzNjMiIsInVzZXJfaWQiOjF9.CT5KXy7yKu31MweqjE5hrDXjPyOdNjViUzJWoMeJx04','2024-06-27 04:09:41.986805','2024-06-28 04:09:41.000000',1,'8f40bf8970544257a0f13545243b33c2'),(22,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI1OCwiaWF0IjoxNzE5NDYxODU4LCJqdGkiOiJhOTVkOWQyZGQ2ZDg0OTM5YmE2MTQwNWZmYTMzYjQwNyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.40nnfI98vvg0nm7D5rXpdF8SlOaD7tQfL2M14ehsCK8',NULL,'2024-06-28 04:17:38.000000',NULL,'a95d9d2dd6d84939ba61405ffa33b407'),(24,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI1OCwiaWF0IjoxNzE5NDYxODU4LCJqdGkiOiJlMjIxY2FhZTdjYmM0YzI3OWU5Zjc2M2IxZDhjZDIxNyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.-0FfBfwS2JNgDo_y-HNDKAddVpr430cHlLKtK0BzgXY',NULL,'2024-06-28 04:17:38.000000',NULL,'e221caae7cbc4c279e9f763b1d8cd217'),(25,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI1OCwiaWF0IjoxNzE5NDYxODU4LCJqdGkiOiI5MzM1OTE3ZDE0MmY0ODU5OTlmYWYxYTQ4ZDI4ODVmNiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.N_U8TIkWH5L6IFQP3rYvj_glNyidEbDV4jptTUANoNg',NULL,'2024-06-28 04:17:38.000000',NULL,'9335917d142f485999faf1a48d2885f6'),(26,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI1OCwiaWF0IjoxNzE5NDYxODU4LCJqdGkiOiI4NDVmY2U2NWY0Mzg0OTk2YTRmM2U3MTk5ODJjMDU1ZCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.7UhPzs63M4kFM0H-KIM9DLxjeoJzzne2HMUXNDCuscU',NULL,'2024-06-28 04:17:38.000000',NULL,'845fce65f4384996a4f3e719982c055d'),(30,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI3MiwiaWF0IjoxNzE5NDYxODcyLCJqdGkiOiIyMmVjNGYwOTNkYWI0Njc3OWZhNzg0Mjg0ZmRhZTRhNCIsInVzZXJfaWQiOjF9.ZX8Y5UOIsPExkKmFycHtAwvv7xJcDNEIkNlqJNKuCcg','2024-06-27 04:17:52.798340','2024-06-28 04:17:52.000000',1,'22ec4f093dab46779fa784284fdae4a4'),(31,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODI4NCwiaWF0IjoxNzE5NDYxODg0LCJqdGkiOiJjZmJiYTZhMzZmYTk0YzI3YTkyMzc4Y2JhYTY2MGUxNCIsInVzZXJfaWQiOjF9.4YOyQbf80kXx6IX4P9A18ERTbhXl5-0oowuR8tm4d4g','2024-06-27 04:18:04.822353','2024-06-28 04:18:04.000000',1,'cfbba6a36fa94c27a92378cbaa660e14'),(32,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODM2NSwiaWF0IjoxNzE5NDYxOTY1LCJqdGkiOiIyNGU4NGE3NGY2Yjg0OTNjYTZiOTc3YmFmYjkwMzc4MiIsInVzZXJfaWQiOjF9.OaSCxIuvWieDti7gi_Y9_yctCBwOZnUoeqy4PiAif1Y','2024-06-27 04:19:25.182016','2024-06-28 04:19:25.000000',1,'24e84a74f6b8493ca6b977bafb903782'),(33,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU0ODk5NiwiaWF0IjoxNzE5NDYyNTk2LCJqdGkiOiJiYTZmODcyNmNmZjY0NzU4OWY4ODIzZjgyYTcwYjAzMyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.yad5lOE9-G2kJ2Bcn9fdcyZG3mAmezT7mJ39S9XGZr0',NULL,'2024-06-28 04:29:56.000000',NULL,'ba6f8726cff647589f8823f82a70b033'),(37,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU1MDA0OSwiaWF0IjoxNzE5NDYzNjQ5LCJqdGkiOiJmMmU4ODc3MDMxYzg0ZWE1YjljMjdjMjU4ZTNkNjA2OSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.2w7ikApRAhrYdAnsduHVF2Wt7BzGvUQEWISF9Wt7sDk',NULL,'2024-06-28 04:47:29.000000',NULL,'f2e8877031c84ea5b9c27c258e3d6069'),(39,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MDQxNSwiaWF0IjoxNzE5NTA0MDE1LCJqdGkiOiIzMjQ5MmY4OGFmY2Y0YjlkYWYyOWRhZDFiOGQ4MGU0MSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.ZQXzFKJHazauw7N7ABHhb18xayTiyULKoRlpJim7Ybo',NULL,'2024-06-28 16:00:15.000000',NULL,'32492f88afcf4b9daf29dad1b8d80e41'),(40,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MDY0MywiaWF0IjoxNzE5NTA0MjQzLCJqdGkiOiIxNzhjOTljN2ZhMTM0ZjE1OGM3MmIyMDk2NTVmNDgzNCIsInVzZXJfaWQiOjF9.WF8y-w9bugMTD72bVrcXuacYyf_Kb5aZhrCcZEWeG7A','2024-06-27 16:04:03.085839','2024-06-28 16:04:03.000000',1,'178c99c7fa134f158c72b209655f4834'),(41,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MDgwNCwiaWF0IjoxNzE5NTA0NDA0LCJqdGkiOiJmZjUwMGQ0ZWYyNzQ0OWRkYjkyOThhOTUxY2QwMTVhZiIsInVzZXJfaWQiOjF9.LRUd8Jy0PvO26x8Bkq2bnRfilOP8ImBX-ZnMLljsFvs','2024-06-27 16:06:44.063103','2024-06-28 16:06:44.000000',1,'ff500d4ef27449ddb9298a951cd015af'),(42,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MDk2MSwiaWF0IjoxNzE5NTA0NTYxLCJqdGkiOiJiMjcxYjE0MGRiNjY0NWMwODczNTYxNmY0MjI2OWQ1ZiIsInVzZXJfaWQiOjF9.N_Z4JUVwY_qJq5kCupPoljf4vA_U0mrGgWfyjD2FgLQ','2024-06-27 16:09:21.759210','2024-06-28 16:09:21.000000',1,'b271b140db6645c08735616f42269d5f'),(43,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MDk5NCwiaWF0IjoxNzE5NTA0NTk0LCJqdGkiOiJkODIwYTEzOWYyZGM0ZWE0YTdkODQ0NDc0NDU4MmVlNyIsInVzZXJfaWQiOjF9.OeVHCNyPrOyIQL-rDek2XnIb_nsWIxxNyFsw64kjWRM','2024-06-27 16:09:54.445774','2024-06-28 16:09:54.000000',1,'d820a139f2dc4ea4a7d8444744582ee7'),(44,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTA4MywiaWF0IjoxNzE5NTA0NjgzLCJqdGkiOiIxNzk3MWZmYTRmZWY0MGExYjAzZWMyMWRlMjhjM2FhZiIsInVzZXJfaWQiOjF9.ULM2pCV7cBzTgOkxRXjMLdBo6ZA94YNKW3i0aCYCqcg','2024-06-27 16:11:23.134075','2024-06-28 16:11:23.000000',1,'17971ffa4fef40a1b03ec21de28c3aaf'),(45,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTQzMSwiaWF0IjoxNzE5NTA1MDMxLCJqdGkiOiJlYmI2NmEwY2UwNTc0Njg1OWQ3MWIzZTU0NDc5NWRkZSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.0Gc-nwd2M9x3ZjxkKxAmn7FxoA1DYNgEb6GfiXOdZIA',NULL,'2024-06-28 16:17:11.000000',NULL,'ebb66a0ce05746859d71b3e544795dde'),(46,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTUzNiwiaWF0IjoxNzE5NTA1MTM2LCJqdGkiOiIzMThkMjFiOWI2OGI0ZTk0YjM3NzhlMzRjMjQ1YmJmNCIsInVzZXJfaWQiOjJ9.2Sqv3mqmzlOTJFxeJC2d_D301pxXjFZyf9kzM01cOeY','2024-06-27 16:18:56.972684','2024-06-28 16:18:56.000000',2,'318d21b9b68b4e94b3778e34c245bbf4'),(47,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTU1MiwiaWF0IjoxNzE5NTA1MTUyLCJqdGkiOiIwNzE0OWQwNjg0NjQ0MTUwODVhZDc5MGFiMmQ5ZDlmYSIsInVzZXJfaWQiOjJ9.NJSJC-zsLOBBf7vfgDndGyzweFujXaOhOrdNJO2U3bE','2024-06-27 16:19:12.074836','2024-06-28 16:19:12.000000',2,'07149d068464415085ad790ab2d9d9fa'),(48,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTU1NSwiaWF0IjoxNzE5NTA1MTU1LCJqdGkiOiI5MjE3NDFlM2Q1ZDE0ZDg2YTg3NGYyYTgxNGI0ZDczMyIsInVzZXJfaWQiOjJ9.pl5TxixPxj-wvq6oqb6GXLH9bBgkZIyeDkvPzFgeB24','2024-06-27 16:19:15.478480','2024-06-28 16:19:15.000000',2,'921741e3d5d14d86a874f2a814b4d733'),(49,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MTY1MCwiaWF0IjoxNzE5NTA1MjUwLCJqdGkiOiJkZDY4YTZlZmI4NzU0OGY1YmMzMWUyZGE0ZDk1ZTE5MSIsInVzZXJfaWQiOjF9.f6oo71VGIGdIe6mBYwsDW22GL9_1tIoTTRaVqA5p0Ys','2024-06-27 16:20:50.349693','2024-06-28 16:20:50.000000',1,'dd68a6efb87548f5bc31e2da4d95e191'),(50,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MjAxOCwiaWF0IjoxNzE5NTA1NjE4LCJqdGkiOiJiYWYwYWIxYzcxOTM0M2EwOTllMTU0YzkzZDRlMTc0NyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.AZpnQOV-PhO6n0Eo6DOxMIVaLeCUZosz-7Kuev8JHNg',NULL,'2024-06-28 16:26:58.000000',NULL,'baf0ab1c719343a099e154c93d4e1747'),(53,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MjMyMywiaWF0IjoxNzE5NTA1OTIzLCJqdGkiOiI5Yjc1NDFmMzNlNzM0OGNhYjI3Y2YwYzdkZTMwZGI4ZCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.vugL9yDSbFGGWHMDDlPk77znIVkgsxmYXbZhYJT1Jfg',NULL,'2024-06-28 16:32:03.000000',NULL,'9b7541f33e7348cab27cf0c7de30db8d'),(56,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MjYyOCwiaWF0IjoxNzE5NTA2MjI4LCJqdGkiOiIxNmNjOGViZWQ5MTM0ZDc2ODE3OWRjN2MwZTJiNzFjNiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.DsRZdkPxCkU_uhTKPLGyvr0G90Usin41XHnW-PI8uCw',NULL,'2024-06-28 16:37:08.000000',NULL,'16cc8ebed9134d768179dc7c0e2b71c6'),(59,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5Mjk2NCwiaWF0IjoxNzE5NTA2NTY0LCJqdGkiOiIyODM0NDAwMWY0YTY0YTI4OThlMjkwODVlMmYxZmRmMCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.4ZdMFNBs1R9vW1scZh91S3aI0RWWD6qCLcj_5RAZbMQ',NULL,'2024-06-28 16:42:44.000000',NULL,'28344001f4a64a2898e29085e2f1fdf0'),(60,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MzMwOCwiaWF0IjoxNzE5NTA2OTA4LCJqdGkiOiJlOTQ0MTZhZTFkMTA0ZGUyYjdkNDNjZjBlZDhkNjBlNCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.fVP-ll5Z3Pn8euqcYsKlJBkhZ28nxpjP5FNluqqlOLQ',NULL,'2024-06-28 16:48:28.000000',NULL,'e94416ae1d104de2b7d43cf0ed8d60e4'),(63,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MzMwOCwiaWF0IjoxNzE5NTA2OTA4LCJqdGkiOiI3ZDBjMTIzMThiMDU0YWEzOTQwMjBmMGNkYjU1MjdlOCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.GSSOZSST-yhyobsN-HM68ocrxDopK3lkq82pJBOxEiI',NULL,'2024-06-28 16:48:28.000000',NULL,'7d0c12318b054aa394020f0cdb5527e8'),(66,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MzMxMiwiaWF0IjoxNzE5NTA2OTEyLCJqdGkiOiJhZmI3M2QxZjQ2ZmE0NWI2OTFkZTA4YzQ0MDMzNjU4MSIsInVzZXJfaWQiOjF9.QnokEEIo42rX7zf-toUl24lHWtOYcRCiNOOMzGVx9vo','2024-06-27 16:48:32.275032','2024-06-28 16:48:32.000000',1,'afb73d1f46fa45b691de08c440336581'),(67,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MzQ5MiwiaWF0IjoxNzE5NTA3MDkyLCJqdGkiOiIwNzQzNTgyOWMxNzE0YWNkOTUxNWMxZjMzYjViNGExZSIsInVzZXJfaWQiOjF9.bSjyjWIK11omCvl0GUZd0Y-di1v2ro_Z2cWe5UHjVqM','2024-06-27 16:51:32.399923','2024-06-28 16:51:32.000000',1,'07435829c1714acd9515c1f33b5b4a1e'),(68,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5MzgyMCwiaWF0IjoxNzE5NTA3NDIwLCJqdGkiOiI3ZDg1ODY2ZTM2MDM0OWJiOGYyYzI0Nzk3ZWZjMmNlOCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.bs9hZWN79QHWi1Fb_ljO9UsKyAPpxRbrC7tXlowfygE',NULL,'2024-06-28 16:57:00.000000',NULL,'7d85866e360349bb8f2c24797efc2ce8'),(71,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NDIyNywiaWF0IjoxNzE5NTA3ODI3LCJqdGkiOiIzMjE4MjNmY2Y0NTE0YjM0ODVjMmYwMDNiYjY4OTc3NiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.zka9tRAqdOcXXDsRklmu_TMmxU3m1OUw1sv4HqzEHq0',NULL,'2024-06-28 17:03:47.000000',NULL,'321823fcf4514b3485c2f003bb689776'),(73,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NDYyNSwiaWF0IjoxNzE5NTA4MjI1LCJqdGkiOiI3YjAzMTYyMTcwOTk0Zjk0ODJiMTZhNjI1NTFhYTUzZSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.BZR5M6vx9mKjqo9KYaijOQEYMm4USo6ojy5eCixbvOs',NULL,'2024-06-28 17:10:25.000000',NULL,'7b03162170994f9482b16a62551aa53e'),(74,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NDYyNSwiaWF0IjoxNzE5NTA4MjI1LCJqdGkiOiI2OTMzMDg0OTY1NDM0YmViOGY0OTcxYWY3MmE0M2VjYyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.X-juK1sVyvku8H3v0Og3ft_97cmomEOnwYlrlwx3ows',NULL,'2024-06-28 17:10:25.000000',NULL,'6933084965434beb8f4971af72a43ecc'),(77,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NDk2MiwiaWF0IjoxNzE5NTA4NTYyLCJqdGkiOiJjM2EyY2ZlMGU1YmE0OWI1YjYzOTQ4MmZlZjNmZjY5ZiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.JYh0n-acs2QbNZCGbmRQPskbPGDvlFLbYXKy5YeWdkw',NULL,'2024-06-28 17:16:02.000000',NULL,'c3a2cfe0e5ba49b5b639482fef3ff69f'),(78,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NTMxMywiaWF0IjoxNzE5NTA4OTEzLCJqdGkiOiIzYzE5M2RkMjVjNzI0NDQzYmRiNGU4ZGMyNzg4NGEzOSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.y-VLfty89kcgXO5HThNV9gPWbgq4ERVz_vMykwVE6wg',NULL,'2024-06-28 17:21:53.000000',NULL,'3c193dd25c724443bdb4e8dc27884a39'),(81,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NTgyMywiaWF0IjoxNzE5NTA5NDIzLCJqdGkiOiIxNWU5YzE1YmIxOGQ0Nzc4YjhiOTNiZjBmNTQwMWMwNyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.iEuEeS3PHGNdANLs9T-HdfTFjuh2YFMxNtiYlYxwxZo',NULL,'2024-06-28 17:30:23.000000',NULL,'15e9c15bb18d4778b8b93bf0f5401c07'),(84,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NjE5NywiaWF0IjoxNzE5NTA5Nzk3LCJqdGkiOiI4NTZhNDdmMDUwYjk0NDIwOGUyZmE0MTI1ZDI1OWNmOSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.23G3Abxp-vw1lzDCzLLoSS3GVyFvANcb0cwRpdGVoac',NULL,'2024-06-28 17:36:37.000000',NULL,'856a47f050b944208e2fa4125d259cf9'),(87,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTU5NjQ5OCwiaWF0IjoxNzE5NTEwMDk4LCJqdGkiOiJlOTE3ZmU0OTBiNzU0YWZjYWI0Njk5M2JjNjdjMWMwMiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.IIquK1X1fdjZ3X7UpwpRXvQjC0hEAjKzJAKE466TYUY',NULL,'2024-06-28 17:41:38.000000',NULL,'e917fe490b754afcab46993bc67c1c02'),(90,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDM3OSwiaWF0IjoxNzE5NTQzOTc5LCJqdGkiOiI4MWUzNTZjZWU2ZjQ0MmU1OTY1NmFiZjk4ZDk3YjA2ZSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.Fj9LRSLKuzn5StKThEX2VgcJ6OLPlHjeBeoDO4ybU7Q',NULL,'2024-06-29 03:06:19.000000',NULL,'81e356cee6f442e59656abf98d97b06e'),(91,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiIwMmYxZWQxOTQ0MzE0YmI0ODljMTZhMmY3MzMwOTBiMiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.z-K0wPe4eqWa_72ZONMLzmoZb18GdWGK02sLiybX1PA',NULL,'2024-06-29 03:14:53.000000',NULL,'02f1ed1944314bb489c16a2f733090b2'),(95,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiJlNmZlOTEzOTNjY2M0YzIxYTlhNGQyZGFhNTJkNTdkMyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.-4LLg8rF4V-oc3xTIbVfbwUvP5nmfzuIs5SFKKrfyhY',NULL,'2024-06-29 03:14:53.000000',NULL,'e6fe91393ccc4c21a9a4d2daa52d57d3'),(96,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiI1OGQ4MjIwODIyZTU0ZDVlYjhjZGY5NzQ4OTQ0NjJjNyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.jNbqxEaHWE_JBpZ-BkoQzTUy43VRK4tB86JFNSSfTjU',NULL,'2024-06-29 03:14:53.000000',NULL,'58d8220822e54d5eb8cdf974894462c7'),(99,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiJhOTQxMTY2ZDE1MzE0Mjk0YTFiNjNlMzczZmExNzA0OCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.VdlRSB7Cg83Cf6UgS_QC0KsF-42GaUawC0jBs-IDhWY',NULL,'2024-06-29 03:14:53.000000',NULL,'a941166d15314294a1b63e373fa17048'),(100,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiJjM2RhNzNhZmI3ZDQ0MzI3YTllNDAxYzMyODZiNTcxZSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.zYdgO0P7L3p6lr6WPNfZ3UR94SvDMedbphUZOyvM0Kw',NULL,'2024-06-29 03:14:53.000000',NULL,'c3da73afb7d44327a9e401c3286b571e'),(103,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMDg5MywiaWF0IjoxNzE5NTQ0NDkzLCJqdGkiOiJlYTk1YTZhMjdlNDg0Mjc2YjllNmJkNmYyOWYzYzBjMyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.3FfBEC1xjCBbE_LVtDHjPEP7i5gWhME3eF6xYcvjv6g',NULL,'2024-06-29 03:14:53.000000',NULL,'ea95a6a27e484276b9e6bd6f29f3c0c3'),(106,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMTIzMiwiaWF0IjoxNzE5NTQ0ODMyLCJqdGkiOiI4MzI2ZTMyY2YyNGM0YWFiOTUxMGY5ODYwOTkzOGFlMCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.8TQvirB1-WIS3LSSiV76ZWvSyXHUDrBeCCuQgGR74dI',NULL,'2024-06-29 03:20:32.000000',NULL,'8326e32cf24c4aab9510f98609938ae0'),(109,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMTU0MywiaWF0IjoxNzE5NTQ1MTQzLCJqdGkiOiI3MTdmMzk1OTk5NTM0ZjkzYTU4ODhkYjg0ZWQwMTM5YyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.FJmxm0XqtwpNCaTG4wri-VIe9jwyCX8D20wBXyhNVkg',NULL,'2024-06-29 03:25:43.000000',NULL,'717f395999534f93a5888db84ed0139c'),(112,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMjA2MSwiaWF0IjoxNzE5NTQ1NjYxLCJqdGkiOiJiZTMwMGQ3YzgwNGY0ZWY4YTM2MWZlN2QyZGFiYjk2ZiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.fFxzybC7klFKI9ipr-YmekBzdVlbfwgAXhSMlXskb48',NULL,'2024-06-29 03:34:21.000000',NULL,'be300d7c804f4ef8a361fe7d2dabb96f'),(115,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMjYwMCwiaWF0IjoxNzE5NTQ2MjAwLCJqdGkiOiJjYjkwMzZhZWM0MzA0NGUxYWU0OGYxYTY3YjQ5NGM1OCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.KgQKRDZgFALADF9_ZHd9zsE12E7jeabW3u3mV_BXA5g',NULL,'2024-06-29 03:43:20.000000',NULL,'cb9036aec43044e1ae48f1a67b494c58'),(118,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMjkxMywiaWF0IjoxNzE5NTQ2NTEzLCJqdGkiOiIyYjVkNDliNjY3MjI0ZjFlYWUzOGE2Y2ZlMzI4OGZjMCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.z2XBTtIkZjdprou059o-40pJPDh7wA_dOOiULc6AABA',NULL,'2024-06-29 03:48:33.000000',NULL,'2b5d49b667224f1eae38a6cfe3288fc0'),(121,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMzIyOCwiaWF0IjoxNzE5NTQ2ODI4LCJqdGkiOiI1ODU4YjVhY2FjYzk0NTQyYTg4N2NiYmNmNDgwOWMzYSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.oDOVjY2J75X_9qHdlaHzKvFDyJMIPmOYg46LTnFbpjs',NULL,'2024-06-29 03:53:48.000000',NULL,'5858b5acacc94542a887cbbcf4809c3a'),(124,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzMzcwNywiaWF0IjoxNzE5NTQ3MzA3LCJqdGkiOiI3ZjFlMzViNTI3YTg0NDg4YWYwMTIxMGRhMjdiMzRjMiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.b1TtxfNljp5hRV7bEHYvNpPD_hCfKKaGZ8bl_Sd44yA',NULL,'2024-06-29 04:01:47.000000',NULL,'7f1e35b527a84488af01210da27b34c2'),(125,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDA4MCwiaWF0IjoxNzE5NTQ3NjgwLCJqdGkiOiI2NzAyOWUzMDk2OTI0YTdlYTljZTZhMzAwZGI5OTE5NSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.2Sqi5kEHPmMUOzl20S2EwdZeLL50tK9eWQ1D8jZSVZw',NULL,'2024-06-29 04:08:00.000000',NULL,'67029e3096924a7ea9ce6a300db99195'),(127,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDQwNywiaWF0IjoxNzE5NTQ4MDA3LCJqdGkiOiIzYjk2NzdlYjMzOGI0YmZjYTAyYzA1NjQ2NjQ0MDAzOCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.ugSa3IqyLiOnfMx8EpOI1rpAe5a-T2lPVNsrNtY9CeQ',NULL,'2024-06-29 04:13:27.000000',NULL,'3b9677eb338b4bfca02c056466440038'),(130,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDQwNywiaWF0IjoxNzE5NTQ4MDA3LCJqdGkiOiIxZjM5NjBmMDk0ZDg0YTgzODIzN2U3MGEyZDAxYTc1OSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.RqKe-h8ffH7crizxHhW0nXQvHLuL3PHCeqjT7cqgFAQ',NULL,'2024-06-29 04:13:27.000000',NULL,'1f3960f094d84a838237e70a2d01a759'),(132,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDQwNywiaWF0IjoxNzE5NTQ4MDA3LCJqdGkiOiI3Njk5ZDQ4ZWFmNDA0Mzg1OWUzZDA4ZDhiOWMxYjRmMiIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.xHMoqHzEpPmYLb1yVz1xtFwkcULILXnHwimZ8ViZZww',NULL,'2024-06-29 04:13:27.000000',NULL,'7699d48eaf4043859e3d08d8b9c1b4f2'),(134,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDQwNywiaWF0IjoxNzE5NTQ4MDA3LCJqdGkiOiIyNGRkNTRlZGRlOTA0MjMyOTAxNDQ2M2VkODY0ZGQzZCIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.wMQJU8Guj59ja_TP-h0ADokicAIuwcegqARzyGlfSAo',NULL,'2024-06-29 04:13:27.000000',NULL,'24dd54edde9042329014463ed864dd3d'),(135,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNDcwMywiaWF0IjoxNzE5NTQ4MzAzLCJqdGkiOiI2MGFkOWJjNjcwNWY0ZDcwOTI5Y2JmM2MwNzcxOWNmNSIsInVzZXJfaWQiOjF9.Bq9vNyx4jcAI5Ff_0PrzDVXcHbJ6AptCLBHL2N64MY8','2024-06-28 04:18:23.404142','2024-06-29 04:18:23.000000',1,'60ad9bc6705f4d70929cbf3c07719cf5'),(136,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNTMxNiwiaWF0IjoxNzE5NTQ4OTE2LCJqdGkiOiI5OGI4ZWM4ZTRmZjA0NTVjYTg4MzlhZGE2MjU1MTQxMSIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.gKOwxqE70gAQp1dDWZQbZGXPL-lbjTSVixEh_Sd7wUo',NULL,'2024-06-29 04:28:36.000000',NULL,'98b8ec8e4ff0455ca8839ada62551411'),(137,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNTU3NCwiaWF0IjoxNzE5NTQ5MTc0LCJqdGkiOiJmN2VmYTkyNGI3MWI0NTU5YWM2YjEyOThmYzY1MzQ2MSIsInVzZXJfaWQiOjJ9.DPz9cNNjlBHFGe83X2-CpCQwI3HPDlLXEQg_X_mreuc','2024-06-28 04:32:54.463828','2024-06-29 04:32:54.000000',2,'f7efa924b71b4559ac6b1298fc653461'),(138,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNTg3NiwiaWF0IjoxNzE5NTQ5NDc2LCJqdGkiOiJiMmMxM2FiN2MzYTU0YTI1YTVlZmJkNWI1OWMzOWFhNCIsInVzZXJfaWQiOjIsInVzZXJuYW1lIjoidGVzdCIsImlzX3N1cGVydXNlciI6ZmFsc2V9.yLrOhyHOitPDO1Uz6NWSv4WSGpAfxTNqF1KI2f-C1kg',NULL,'2024-06-29 04:37:56.000000',NULL,'b2c13ab7c3a54a25a5efbd5b59c39aa4'),(139,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjE3NCwiaWF0IjoxNzE5NTQ5Nzc0LCJqdGkiOiJkOTQ2N2M0MTc2NDY0ZjVlYTRkMmNmYTQ3MDViOTNlMiIsInVzZXJfaWQiOjJ9.1OaOVQM1MWsrqmphRx6I14h_k5Eqkr0ti9_sdieQt5A','2024-06-28 04:42:54.493184','2024-06-29 04:42:54.000000',2,'d9467c4176464f5ea4d2cfa4705b93e2'),(140,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjE3OCwiaWF0IjoxNzE5NTQ5Nzc4LCJqdGkiOiI2ZmJkMDNlZjhhMDk0YmM5ODczY2U1N2MyZGFjOTQ4NiIsInVzZXJfaWQiOjJ9.rNh3f1EjlTkvtQVQs1lOG8LrRKLwmOFJ0xBizHzW6vw','2024-06-28 04:42:58.214314','2024-06-29 04:42:58.000000',2,'6fbd03ef8a094bc9873ce57c2dac9486'),(141,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjI5OCwiaWF0IjoxNzE5NTQ5ODk4LCJqdGkiOiIzMTVhZDlhMmJiYmY0ZWFmYmZmMWFlZGU3YzAwMzk2ZSIsInVzZXJfaWQiOjF9.aAHLY8nylMzF-kn57-GjM2bd7lhFB-Notwy5c93Z1hQ','2024-06-28 04:44:58.193527','2024-06-29 04:44:58.000000',1,'315ad9a2bbbf4eafbff1aede7c00396e'),(142,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjYxNiwiaWF0IjoxNzE5NTUwMjE2LCJqdGkiOiI3MmU4MzhlNTRkMjM0YmE4OTk4ZDRkZGI4ZDE2M2RhYyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.56AzgQgsco09I6fTY1lptNYAzDFfCUSQPDcWtkekgLQ',NULL,'2024-06-29 04:50:16.000000',NULL,'72e838e54d234ba8998d4ddb8d163dac'),(143,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjkzMSwiaWF0IjoxNzE5NTUwNTMxLCJqdGkiOiI4YzQwNGVmODBlOWE0MmI2OGI2YTcxZjA2YWJiZjc4NiIsInVzZXJfaWQiOjN9.rOZCtdIXsdFl9zBZHULQbPU-c4X0eMmAyvfTKesa8I4','2024-06-28 04:55:31.860179','2024-06-29 04:55:31.000000',3,'8c404ef80e9a42b68b6a71f06abbf786'),(144,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjk0MiwiaWF0IjoxNzE5NTUwNTQyLCJqdGkiOiI2ZTk5YTlkZThkMzk0ODc4OGQwZTJlZDY5NTI4YWE4MiIsInVzZXJfaWQiOjN9.RB2tt9oOL7v3quzk_SleQwqRypeJl3tc1PIIEWWylys','2024-06-28 04:55:42.396373','2024-06-29 04:55:42.000000',3,'6e99a9de8d3948788d0e2ed69528aa82'),(145,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNjk1MSwiaWF0IjoxNzE5NTUwNTUxLCJqdGkiOiJmY2VjMTRmYzMzZDU0NmYxOWQyMTE4MzcwYTI1YmRkOCIsInVzZXJfaWQiOjJ9.9S0F2A-idGsHlpEO0c5LyRADi2jMa3dZrYxkM6dIc3U','2024-06-28 04:55:51.335407','2024-06-29 04:55:51.000000',2,'fcec14fc33d546f19d2118370a25bdd8'),(146,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTYzNzAyMSwiaWF0IjoxNzE5NTUwNjIxLCJqdGkiOiI0NzMyNDNmYjdkNmU0Y2UwYjI1MmU2MGYyZDQyMDZmMyIsInVzZXJfaWQiOjF9.Emt0TiBZGfvmzJObKKycZkj6qM_1bNn3ilKc_18uNFQ','2024-06-28 04:57:01.149996','2024-06-29 04:57:01.000000',1,'473243fb7d6e4ce0b252e60f2d4206f3'),(147,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTg0Nzg3MCwiaWF0IjoxNzE5NzYxNDcwLCJqdGkiOiI1MDMwYjljMjM2YzQ0NTcxYjhmNjNkNzYyMTcwNDQyNiIsInVzZXJfaWQiOjF9.jiOv5DvqAlaCKl7fOByEr1p_rpsEDYfw36x7zCwUUcI','2024-06-30 15:31:10.879631','2024-07-01 15:31:10.000000',1,'5030b9c236c44571b8f63d7621704426'),(148,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTg0ODU5NSwiaWF0IjoxNzE5NzYyMTk1LCJqdGkiOiJhYjJkOGU1MmYxMmE0NWFhYWQ2ZjEyMTY2Y2UwMzQ4YyIsInVzZXJfaWQiOjEsInVzZXJuYW1lIjoicHpjIiwiaXNfc3VwZXJ1c2VyIjp0cnVlfQ.Wgn53sPSSwXbielswsmVgH6FHGKDHYeij6T-0g_4BFo',NULL,'2024-07-01 15:43:15.000000',NULL,'ab2d8e52f12a45aaad6f12166ce0348c'),(149,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTg0ODYxMywiaWF0IjoxNzE5NzYyMjEzLCJqdGkiOiI3NDFjMmQwY2NjZDY0MmE1OTUxZTdlOGZhNDFmZGY0NSIsInVzZXJfaWQiOjF9.98tIR5PXWJULhI6AKxLtGdFMD38m0wxy05E8Wi-5zhc','2024-06-30 15:43:33.133309','2024-07-01 15:43:33.000000',1,'741c2d0cccd642a5951e7e8fa41fdf45'),(150,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTg1MDE4NywiaWF0IjoxNzE5NzYzNzg3LCJqdGkiOiJmYjVmMGJmOGVmYzI0MGMyODAxOGY0MmEyMmFkMmYyMiIsInVzZXJfaWQiOjF9.w29_u0uPewKsfQnDg9O5sruoqhOh8bTA40PlQYDERIw','2024-06-30 16:09:47.285618','2024-07-01 16:09:47.000000',1,'fb5f0bf8efc240c28018f42a22ad2f22'),(151,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcxOTg1MDI2NCwiaWF0IjoxNzE5NzYzODY0LCJqdGkiOiJiYjdkZDU3OWNiZGU0Y2VkOTExZTdlY2JlYjU4YjlmNiIsInVzZXJfaWQiOjF9.na27KDOnirSMqV4QOLcFhZ0H-o01bV3TL51WGg4fPjg','2024-06-30 16:11:04.815359','2024-07-01 16:11:04.000000',1,'bb7dd579cbde4ced911e7ecbeb58b9f6');
/*!40000 ALTER TABLE `token_blacklist_outstandingtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_appuser`
--

DROP TABLE IF EXISTS `user_api_appuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_appuser` (
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_appuser`
--

LOCK TABLES `user_api_appuser` WRITE;
/*!40000 ALTER TABLE `user_api_appuser` DISABLE KEYS */;
INSERT INTO `user_api_appuser` VALUES ('pbkdf2_sha256$390000$hSyoQaUXfiu58qUWg69Wzo$bP8lHfMGP3doNPzKnBDoT3WmpoI7UxsMSQDWMBf2OOg=','2024-06-24 14:36:41.516000',1,1,'pzc@test.com','pzc',1,1,'2024-06-24 14:36:34.391000'),('pbkdf2_sha256$390000$dnjOj8On6IN8MfP6HEhqOq$3NzF3LmM4YwftduyW4C+pjhWLFYcA6PA+1vJIxj6lmg=',NULL,0,2,'test@test.com','test',1,0,'2024-06-27 16:18:56.633955'),('pbkdf2_sha256$390000$R59pARPc08bc9mxTeZQuOJ$6lxbhOhrDeD/RDxZVew/a6xQvdNM5h/rDg53WhJymck=',NULL,0,3,'test2@test.com','test2',1,0,'2024-06-28 04:55:31.538333');
/*!40000 ALTER TABLE `user_api_appuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_appuser_groups`
--

DROP TABLE IF EXISTS `user_api_appuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_appuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appuser_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_appuser_groups_appuser_id_group_id_7bedc5ff_uniq` (`appuser_id`,`group_id`),
  KEY `user_api_appuser_groups_group_id_84f84776_fk_auth_group_id` (`group_id`),
  CONSTRAINT `user_api_appuser_gro_appuser_id_f98426e3_fk_user_api_` FOREIGN KEY (`appuser_id`) REFERENCES `user_api_appuser` (`id`),
  CONSTRAINT `user_api_appuser_groups_group_id_84f84776_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_appuser_groups`
--

LOCK TABLES `user_api_appuser_groups` WRITE;
/*!40000 ALTER TABLE `user_api_appuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_appuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_appuser_user_permissions`
--

DROP TABLE IF EXISTS `user_api_appuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_appuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appuser_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_appuser_user_pe_appuser_id_permission_id_c7e343e4_uniq` (`appuser_id`,`permission_id`),
  KEY `user_api_appuser_use_permission_id_59ab5764_fk_auth_perm` (`permission_id`),
  CONSTRAINT `user_api_appuser_use_appuser_id_4ecba2aa_fk_user_api_` FOREIGN KEY (`appuser_id`) REFERENCES `user_api_appuser` (`id`),
  CONSTRAINT `user_api_appuser_use_permission_id_59ab5764_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_appuser_user_permissions`
--

LOCK TABLES `user_api_appuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `user_api_appuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_api_appuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_category`
--

DROP TABLE IF EXISTS `user_api_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_category`
--

LOCK TABLES `user_api_category` WRITE;
/*!40000 ALTER TABLE `user_api_category` DISABLE KEYS */;
INSERT INTO `user_api_category` VALUES (1,'Main course'),(2,'Drinks'),(3,'Dessert');
/*!40000 ALTER TABLE `user_api_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_diningtable`
--

DROP TABLE IF EXISTS `user_api_diningtable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_diningtable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `capacity` int NOT NULL,
  `location` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_diningtable`
--

LOCK TABLES `user_api_diningtable` WRITE;
/*!40000 ALTER TABLE `user_api_diningtable` DISABLE KEYS */;
INSERT INTO `user_api_diningtable` VALUES (1,4,'1'),(2,4,'2'),(3,4,'3'),(4,2,'4');
/*!40000 ALTER TABLE `user_api_diningtable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_invoice`
--

DROP TABLE IF EXISTS `user_api_invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `archive_flag` tinyint(1) NOT NULL,
  `time_added` datetime(6) NOT NULL,
  `table_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_api_invoice_table_id_id_5825c8be_fk_user_api_diningtable_id` (`table_id_id`),
  CONSTRAINT `user_api_invoice_table_id_id_5825c8be_fk_user_api_diningtable_id` FOREIGN KEY (`table_id_id`) REFERENCES `user_api_diningtable` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_invoice`
--

LOCK TABLES `user_api_invoice` WRITE;
/*!40000 ALTER TABLE `user_api_invoice` DISABLE KEYS */;
INSERT INTO `user_api_invoice` VALUES (1,0,'2024-06-27 03:55:18.202115',1),(2,0,'2024-06-27 03:55:37.321407',2),(3,0,'2024-06-27 03:55:57.008398',3),(4,0,'2024-06-27 03:56:19.790077',4),(5,0,'2024-06-28 04:08:00.176031',4),(6,0,'2024-06-28 04:33:03.875711',4);
/*!40000 ALTER TABLE `user_api_invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_menu`
--

DROP TABLE IF EXISTS `user_api_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `picture_url` varchar(200) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_api_menu_category_id_5d0b5beb_fk_user_api_category_id` (`category_id`),
  CONSTRAINT `user_api_menu_category_id_5d0b5beb_fk_user_api_category_id` FOREIGN KEY (`category_id`) REFERENCES `user_api_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_menu`
--

LOCK TABLES `user_api_menu` WRITE;
/*!40000 ALTER TABLE `user_api_menu` DISABLE KEYS */;
INSERT INTO `user_api_menu` VALUES (1,'Nasi lemak','A dish originating in Malay cuisine that consists of fragrant rice cooked in coconut milk and pandan leaf. It is commonly found in Malaysia, where it is considered as the national dish.',14.00,'https://www.elmundoeats.com/wp-content/uploads/2021/02/FP-Nasi-lemak-with-all-its-trimmings.jpg',1),(2,'Wonton mee','The wonton noodles are tossed with a dark sauce and topped with boiled wontons or fried wontons, char siu and some green leafy choy sum.',10.00,'https://rasamalaysia.com/wp-content/uploads/2012/07/wontonnoodles06.jpg',1),(3,'Ice Kacang/ABC','Popular dessert commonly sold by street vendors in Malaysia.',8.00,'https://rasamalaysia.com/wp-content/uploads/2010/07/ice_kacang2.jpg',3),(4,'Onde-onde','Onde-onde (also spelled as ondeh-ondeh) are made with pandan (screwpine leaf) infused dough and filled with Gula Melaka or palm sugar. Roll them with grated coconut before serving.',5.00,'https://rasamalaysia.com/wp-content/uploads/2021/02/onde-onde8-1024x1536.jpg',3),(5,'Teh tarik','Malaysia\'s national drink, this milk tea is made by pulling a strong black tea and adding condensed milk. It can be served hot or iced.',2.50,'https://www.kuali.com/wp-content/uploads/2016/06/Teh-Tarik-stock-photo.jpg',2),(6,'Barley water','boiled barley grains in water',2.00,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJdg3fr9M6l5ZIsUnmG7hNfJrNTrN5rfQdhA&s',2);
/*!40000 ALTER TABLE `user_api_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_api_order`
--

DROP TABLE IF EXISTS `user_api_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_api_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `quantity` int NOT NULL,
  `invoice_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `current_quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_api_order_invoice_id_afd82ade_fk_user_api_invoice_id` (`invoice_id`),
  KEY `user_api_order_menu_id_30d15a07_fk_user_api_menu_id` (`menu_id`),
  CONSTRAINT `user_api_order_invoice_id_afd82ade_fk_user_api_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `user_api_invoice` (`id`),
  CONSTRAINT `user_api_order_menu_id_30d15a07_fk_user_api_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `user_api_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_api_order`
--

LOCK TABLES `user_api_order` WRITE;
/*!40000 ALTER TABLE `user_api_order` DISABLE KEYS */;
INSERT INTO `user_api_order` VALUES (1,2,1,2,2),(2,2,1,5,2),(3,2,1,1,2),(4,2,1,6,2),(5,1,1,3,1),(6,1,1,4,1),(7,1,2,2,1),(8,1,2,1,1),(9,1,2,5,1),(10,1,2,3,1),(11,1,3,1,1),(12,1,3,2,1),(13,1,3,4,1),(14,1,3,6,1),(15,3,4,1,3),(16,1,4,2,1),(17,1,4,6,1),(18,1,4,5,1),(19,1,4,3,1),(20,1,4,4,1),(21,2,5,1,2),(22,1,5,5,1),(23,1,5,6,1),(24,1,5,4,1),(25,1,6,5,1);
/*!40000 ALTER TABLE `user_api_order` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-01 12:09:58
