-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: opstrack
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

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
-- Table structure for table `api_tokens`
--

DROP TABLE IF EXISTS `api_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `api_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` json DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_tokens_token_unique` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `api_tokens`
--

LOCK TABLES `api_tokens` WRITE;
/*!40000 ALTER TABLE `api_tokens` DISABLE KEYS */;
INSERT INTO `api_tokens` VALUES (1,'dispatch-dashboard','opstrack-token-securise-2026','[\"tickets:read\", \"tickets:write\", \"weather:read\"]',1,'2026-03-16 12:53:55','2026-03-16 11:37:28','2026-03-16 12:53:55');
/*!40000 ALTER TABLE `api_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES ('opstrack-cache-dashboard.kpis','a:4:{s:11:\"openTickets\";i:2;s:15:\"criticalTickets\";i:1;s:14:\"scheduledToday\";i:2;s:11:\"technicians\";i:2;}',1773672267);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `industry` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_account_code_unique` (`account_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Alto Facilities','ALT-001','Retail','Camille Roy','camille.roy@alto-facilities.test','04 72 11 22 33',1,'2026-03-16 11:37:28','2026-03-16 11:37:28');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interventions`
--

DROP TABLE IF EXISTS `interventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interventions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `ticket_id` bigint unsigned NOT NULL,
  `scheduled_for` timestamp NULL DEFAULT NULL,
  `started_at` timestamp NULL DEFAULT NULL,
  `ended_at` timestamp NULL DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'scheduled',
  `summary` text COLLATE utf8mb4_unicode_ci,
  `external_event_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interventions_ticket_id_foreign` (`ticket_id`),
  CONSTRAINT `interventions_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interventions`
--

LOCK TABLES `interventions` WRITE;
/*!40000 ALTER TABLE `interventions` DISABLE KEYS */;
INSERT INTO `interventions` VALUES (1,1,'2026-03-16 10:37:28','2026-03-16 10:57:28',NULL,'in_progress','Technician is replacing the failing network switch.','evt-ops-001','2026-03-16 11:37:28','2026-03-16 11:37:28'),(2,2,'2026-03-16 14:37:28',NULL,NULL,'scheduled','Preventive maintenance slot approved by the customer.','evt-ops-002','2026-03-16 11:37:28','2026-03-16 11:37:28');
/*!40000 ALTER TABLE `interventions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2026_03_14_183110_create_customers_table',1),(5,'2026_03_14_183111_create_sites_table',1),(6,'2026_03_14_183113_create_tickets_table',1),(7,'2026_03_14_183114_create_api_tokens_table',1),(8,'2026_03_14_183114_create_interventions_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('14PYPr4WJ5UkmxkhxrYCjmyKkv4DWOsrcD8sEk8l',NULL,'91.196.152.158','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZU5xbExpQkRKa3h6Q083dldOa0tkd3dkS2UyNUpvVEdSUHRhcFg2MiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667642),('1WGS6FG2cWm6eRBpVtShGfc6xMDXSiz3j4ir5dWs',NULL,'206.189.2.13','Mozilla/5.0 (l9scan/2.0.6383e22343e2038313e25333; +https://leakix.net)','YTozOntzOjY6Il90b2tlbiI7czo0MDoidEF2cFI1N1F1OFM0UEhQWFE2MUlYMkV2OVo3V0trMXNSTUtDcENzNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9ldmFsLWRmcy1wLXRwbC0yMDI2MS0wNC5pdC1zdHVkZW50cy5mciI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1773665850),('4tJHcFn4Wmi7n0luuqsLUmBZWwOcjz4zWq7lvJIq',NULL,'91.231.89.126','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoibERUN01ReDJKVGhHY2VkQTgwQ3FVSUdSbHV1SGtmbHlZeTJPZEpBSiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667657),('7byIzGYcuITbOA1zbo0ZkegQ6Nv7EY7s62xX9LqH',NULL,'91.196.152.229','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVUVDMEtucmp1emtNMEFxbXYyVEM2bm9VeEtqMnZNckJud3hpOHpocyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667814),('9Qv0aM6LTa4JzfUxJyQq8gicDZp4Gk3v64azoYkY',NULL,'34.122.147.229','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZExFSGFUTUVtQmsyZlpPUXVma3FBVld2NmF0a2RxZnlLa0w1Rk5RdSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9ldmFsLWRmcy1wLXRwbC0yMDI2MS0wNC5pdC1zdHVkZW50cy5mciI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1773665760),('9Z1xqEwwTDkqQ8UI0ElasJGMYVuxz45ID36mjXI8',NULL,'91.231.89.126','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiVFlmYVlnOGdxUjB2VW1tTThSN0NUV2JtVGNleEpIM3FjaG9xZGFkQSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667718),('AuFQKDwKaIZGd8eiMWJqIajBlUGczFMWugqyJ950',NULL,'192.175.111.228','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0hXVEN0UmVSd1ZnQ2VKS3pHZFJQZERXSU52NUN4cHA4TGxZZ1BpQyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773668776),('bozJqXmFrUhcwkcWGmpCSvpi9TEX45ywtbkROaZm',NULL,'185.246.172.242','Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiYzVhMDYzaTRjMWZlN2JvZmlMdUkxakRGaEZ1MEVLUGJPVEdyYTVxZiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773665970),('C78pJFVNSvfp6nrkPWylK31wHDTtmYvEz8pQUevC',NULL,'185.177.72.60','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiRDRUcElhS1o1bW9BYjNSVE9jZ1VESENZcm1sVXprVVp6N2tudVVHUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667146),('eufuDW8Q6A9i4rIZiCfk3p1PlWWGhD5iiI3ytmbH',NULL,'81.29.142.100','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMEg5S21EYTVCM3VyZlpDYUpHWURNZGpnaTR1TmVGYllQbjlwMlltSSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773670489),('eW70CSl9cEBHskA4ZX8m192XUjFc9I5M37Rvb7cI',NULL,'31.172.233.171','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoidnpPTG5PRFNYZGJDcUEzV0pCQXFCUXFpNG54RVZqRE1BaXJBS0RORSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773670181),('ifc3IukIsWTTgdcfzVJ2EC8dIDgR1R1vFihjEngM',NULL,'185.177.72.60','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTnJQWXdybERhdkVISFJNbUZFdjdqQmhjVWczWFVxVEhnWlI5Y2lYYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773666965),('IwagvsPlu5m9c9GI2yWjkrHYL8gDGpuAS6RN14b1',NULL,'196.196.53.117','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ2FGUFF6c2Nxck1vZVZPNFo1cnpVa1lyMHViMnNTMEgzeWdaWVg3YyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9ldmFsLWRmcy1wLXRwbC0yMDI2MS0wNC5pdC1zdHVkZW50cy5mciI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1773665753),('jHGbtD8WFJnh4ta86mzIhLVGlxA92kzWQ0yKraN6',NULL,'185.177.72.60','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36, Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiR05OeXJFMHVLbWFCbkNNd05BNlZEdnlDRFl5N004MFlvMXNCbFNqaCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667036),('kL6zPBYxvLWBJdVe56rcD0vU0vmytosBUQaTD2cM',NULL,'81.29.142.100','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.106 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZTJXOU9jY3NPTHNhR3FtWk5VUXY2bmJrMDkyaVR2cktuYk5FRko1VSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773670469),('KNr6UYTU7WLghTC63yR7JBNTOUTMiOxPRVM3h950',NULL,'81.29.142.6','Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.90 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ2dKelhLeTZYaThsSWhYbEtXTEpPdU4xTk5vQTZrTzBnRUhoeDR1SSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667109),('mENHV53CUeOhP3gmVRZiiGKIp2xuxyodlFJ0biM6',NULL,'81.29.142.100','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.131 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiamliaEk2b3RJNnI3YW9mZjBmS3hLZUVQVVJham1wWFhVR3pES3FrQiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667111),('mgRtXuDnWGNLYDxOVSHNnTKl0AzYWKAZwXNWjvpo',NULL,'34.123.170.104','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiV01kVGF3cDgzRlU3alpucWJnR0FOd2RJZVFlWDhlTGNRWDBFQ2VkdCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDU6Imh0dHA6Ly9ldmFsLWRmcy1wLXRwbC0yMDI2MS0wNC5pdC1zdHVkZW50cy5mciI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19',1773665765),('n0g3spOR8EoWJwNVdK9GRh7Cgo9VVlRMTqn5XUtf',NULL,'91.92.20.65','Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/144.0.7559.95 Mobile/15E148 Safari/604.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZVJQb0NUNlVsckNkcTN0TGZVODdtczMzRmNvQ3V6cm45eXVGVmoyNiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773665978),('nLZIUzb6ExeFR7ULhFjqEFGLYz5Q5KX5p2uRJvbQ',NULL,'78.153.241.4','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiUDlRN3ZFUkVVV3lHdUgwbEtibWIxWEduS3I1a3NlMW5jejNoVEhKRyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MTk6Imh0dHA6Ly8zNS4xODAuNDIuODYiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773665147),('NRoAUjtQkky25eBh6hjPCTF0uZTVPrtQQpnaZc5c',NULL,'81.29.142.6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36 Edg/88.0.705.81','YTozOntzOjY6Il90b2tlbiI7czo0MDoicGJKV0xNanZDNXFtUHZ6djVXSElHRHZVckREeXhTa2VIS1UyenhnWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773670468),('qmcXlbGZ7DENtC7B4eqVXPYpFVNGSyhEmFs2NSuO',NULL,'64.15.129.114','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTMzTjk3WEpwcGxEZmEyMjVYaUFsbXBTb0pDYnBoajNDbTByR3RxWCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773668778),('rVQjLtv8eKKXiprSDD7dQjJFhmYHCXJ18O0wJdO1',NULL,'64.15.129.115','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiZDlNQ2M3UDR3eEpWOVBUWURUbVNCSnVLVHp0RWl0NFA4WmMxaVVhSCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773668778),('t36hxauvkfOUxtlHHhvpzYU4JtCrpJFQ8kPfFoPl',NULL,'64.15.129.116','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoibmhhdE4wa3daYm4wSXpnVjQ2bGtxNDBmelM2Q3hDbTNVa2ZiVm84UiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773668777),('u2AbYj1kj7gtVhMCgCeH0vjNxtqsGJU5ykzr16nA',NULL,'81.29.142.100','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15','YTozOntzOjY6Il90b2tlbiI7czo0MDoiWFFTYUlwTVZRNjRSZE11TEJYRDVlb2F5bjRqSVZna1dHUnk3eDBkaiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667106),('Vsq4P12LTZ14bTKUo42IAC4FBh2J28VJwwqIiERP',NULL,'74.7.227.47','Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)','YTozOntzOjY6Il90b2tlbiI7czo0MDoialBES0JPTHhQb1NhSWFERlRNOWI0ODJVUmthbXFpbWpWbVRDSE83ZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773669539),('xu5CxWReASYrWa9ZRaryLR7TWNMziIllOWl2t4kO',NULL,'81.29.142.6','Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiTGg3QkVJZDdUUjduWE9UUWo3QjVkWlA2RmlRaVhIbTZ5UUZVMFB1TSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773670467),('Y21cRp8FXDmxobi0P8KsBUPHfqKSU6Lr9GCbuSez',NULL,'94.231.206.1','Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:134.0) Gecko/20100101 Firefox/134.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiQU9WY2xXcDVPR2xZa2s5cm5UdWFGaFNxVVFhUEZwMDVVOVJPVUp6SSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjA6Imh0dHBzOi8vMzUuMTgwLjQyLjg2IjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1773667179),('yexugez72EpILXpl42JPnVzNtWtsn5iGz0NuJg9E',NULL,'81.29.142.6','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiMTdSQnNzRXljaEZtZUV6cmVadlRvcWJNUVpLZDl3eERUMGcwV0JNNyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773667109),('yze0lHaUszPbyc10l9ws06g3R1S3MOfhh9muVFBI',NULL,'192.175.111.239','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoidXlUMzBTSTh6cm5qM1cwdU5TUnZkZDIwNkNnN2FQTTJRQTlHNExmZSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDY6Imh0dHBzOi8vZXZhbC1kZnMtcC10cGwtMjAyNjEtMDQuaXQtc3R1ZGVudHMuZnIiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773668775),('ZmiXvYun31YSCpAABge1Mzwe0DIDmuelgfybTl9U',NULL,'188.215.235.51','Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoieWxKcTRlNTVnS3JCSGJMRGVuWnlvb0pqbEk5U0ZXOEVyNVVEakhlRSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly9lYzItMzUtMTgwLTQyLTg2LmV1LXdlc3QtMy5jb21wdXRlLmFtYXpvbmF3cy5jb20iO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1773665753);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sites` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postal_code` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `timezone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Europe/Paris',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sites_customer_id_foreign` (`customer_id`),
  CONSTRAINT `sites_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,'Lyon Confluence','12 quai Perrache','69002','Lyon',45.7433170,4.8157470,'Europe/Paris','2026-03-16 11:37:28','2026-03-16 11:37:28');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tickets` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `site_id` bigint unsigned NOT NULL,
  `opened_by_user_id` bigint unsigned NOT NULL,
  `assigned_to_user_id` bigint unsigned DEFAULT NULL,
  `reference` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'medium',
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'new',
  `sla_due_at` timestamp NULL DEFAULT NULL,
  `closed_at` timestamp NULL DEFAULT NULL,
  `last_synced_weather_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tickets_reference_unique` (`reference`),
  KEY `tickets_site_id_foreign` (`site_id`),
  KEY `tickets_opened_by_user_id_foreign` (`opened_by_user_id`),
  KEY `tickets_assigned_to_user_id_foreign` (`assigned_to_user_id`),
  CONSTRAINT `tickets_assigned_to_user_id_foreign` FOREIGN KEY (`assigned_to_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tickets_opened_by_user_id_foreign` FOREIGN KEY (`opened_by_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `tickets_site_id_foreign` FOREIGN KEY (`site_id`) REFERENCES `sites` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (1,1,1,2,'INC-240301','Intermittent payment terminal outage','Three terminals restart during peak hours and the store asks for a fast onsite intervention.','critical','in_progress','2026-03-16 15:37:28',NULL,NULL,'2026-03-16 11:37:28','2026-03-16 11:37:28'),(2,1,1,3,'INC-240302','Cooling unit maintenance overdue','Preventive maintenance has not been recorded on the dispatch board.','medium','scheduled','2026-03-17 11:37:28',NULL,NULL,'2026-03-16 11:37:28','2026-03-16 11:37:28');
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'technician',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Nora Besson','nora.besson@opstrack.test','supervisor','06 10 22 34 45',NULL,'$2y$12$hm1zAVftxORQf7KfNAAU9uppP08asi3IOSmCXewjPJcjjnxFdGk1q',NULL,'2026-03-16 11:37:28','2026-03-16 11:37:28'),(2,'Lina Perez','lina.perez@opstrack.test','technician','06 22 33 44 55',NULL,'$2y$12$38VRtXI2OEyS9ihJ585iteWNWkx2X/yfOLSRxQYspMOpspehBcW/i',NULL,'2026-03-16 11:37:28','2026-03-16 11:37:28'),(3,'Mathis Leroy','mathis.leroy@opstrack.test','technician','06 99 88 77 66',NULL,'$2y$12$hZGhw8fjzH4Qrk0IiU5IvOZ.UKBuIA2RlBPAMp1iLsTYQMM7w1hmq',NULL,'2026-03-16 11:37:28','2026-03-16 11:37:28');
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

-- Dump completed on 2026-03-16 15:14:52
