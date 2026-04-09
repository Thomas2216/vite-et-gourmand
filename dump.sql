-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: app
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `avis`
--

DROP TABLE IF EXISTS `avis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avis` (
  `id` int NOT NULL AUTO_INCREMENT,
  `note` int NOT NULL,
  `commentaire` longtext,
  `user_id` int DEFAULT NULL,
  `statut` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_8F91ABF0A76ED395` (`user_id`),
  CONSTRAINT `FK_8F91ABF0A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avis`
--

LOCK TABLES `avis` WRITE;
/*!40000 ALTER TABLE `avis` DISABLE KEYS */;
INSERT INTO `avis` VALUES (1,4,'Très bon traiteur, rapide et efficace !',4,'valide');
/*!40000 ALTER TABLE `avis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande`
--

DROP TABLE IF EXISTS `commande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commande` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_commande` int DEFAULT NULL,
  `date_commande` date NOT NULL,
  `date_livraison` date NOT NULL,
  `heure_livraison` time NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `prix_total` double NOT NULL,
  `statut` varchar(50) NOT NULL,
  `avis_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `nombre_personnes` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_6EEAA67D197E709F` (`avis_id`),
  KEY `IDX_6EEAA67DA76ED395` (`user_id`),
  CONSTRAINT `FK_6EEAA67D197E709F` FOREIGN KEY (`avis_id`) REFERENCES `avis` (`id`),
  CONSTRAINT `FK_6EEAA67DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande`
--

LOCK TABLES `commande` WRITE;
/*!40000 ALTER TABLE `commande` DISABLE KEYS */;
INSERT INTO `commande` VALUES (1,1,'2026-03-25','2026-03-26','12:36:00','25 Rue du Port 69000 Lyon',25.9,'en attente',NULL,NULL,0),(2,2,'2026-04-02','2026-04-04','17:14:00','25 Rue du Port 69000 Lyon',329.38,'en attente',NULL,1,7),(3,3,'2026-04-02','2026-04-03','19:40:00','25 Rue du Port 69000 Lyon',329.38,'en attente',NULL,1,6),(4,4,'2026-04-02','2026-04-04','20:30:00','25 Rue du Port 69000 Lyon',329.38,'en attente',NULL,1,4),(5,5,'2026-04-08','2026-04-09','16:30:00','25 Rue du Port 33000 Bordeaux',0,'en_attente',NULL,23,4),(6,6,'2026-04-08','2026-04-10','18:35:00','25 Rue du Port 33000 Bordeaux',0,'en_attente',NULL,4,5);
/*!40000 ALTER TABLE `commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commande_menu`
--

DROP TABLE IF EXISTS `commande_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commande_menu` (
  `commande_id` int NOT NULL,
  `menu_id` int NOT NULL,
  PRIMARY KEY (`commande_id`,`menu_id`),
  KEY `IDX_16693B7082EA2E54` (`commande_id`),
  KEY `IDX_16693B70CCD7E912` (`menu_id`),
  CONSTRAINT `FK_16693B7082EA2E54` FOREIGN KEY (`commande_id`) REFERENCES `commande` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_16693B70CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commande_menu`
--

LOCK TABLES `commande_menu` WRITE;
/*!40000 ALTER TABLE `commande_menu` DISABLE KEYS */;
INSERT INTO `commande_menu` VALUES (1,1);
/*!40000 ALTER TABLE `commande_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20260408085501',NULL,NULL),('DoctrineMigrations\\Version20260408104201','2026-04-08 10:46:01',327);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `prix` double NOT NULL,
  `min_personne` int NOT NULL,
  `stock` int NOT NULL,
  `theme` varchar(255) NOT NULL,
  `regime` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Menu Italien','<div>Spécialités italiennes</div>',3500,2,50,'Italien',NULL),(2,'Menu Healthy','<div>Repas équilibré et léger</div>',3200,1,40,'Healthy','Végétarien'),(3,'Menu Gourmet','<div>Cuisine raffinée</div>',4600,2,30,'Gastronomique',NULL),(4,'Menu Famille','<div>Idéal pour toute la famille</div>',2800,4,60,'Familial',NULL),(5,'Menu Express','<div>Rapide et efficace</div>',1900,1,100,'Rapide',NULL);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_plat`
--

DROP TABLE IF EXISTS `menu_plat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_plat` (
  `menu_id` int NOT NULL,
  `plat_id` int NOT NULL,
  PRIMARY KEY (`menu_id`,`plat_id`),
  KEY `IDX_E8775249CCD7E912` (`menu_id`),
  KEY `IDX_E8775249D73DB560` (`plat_id`),
  CONSTRAINT `FK_E8775249CCD7E912` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_E8775249D73DB560` FOREIGN KEY (`plat_id`) REFERENCES `plat` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_plat`
--

LOCK TABLES `menu_plat` WRITE;
/*!40000 ALTER TABLE `menu_plat` DISABLE KEYS */;
INSERT INTO `menu_plat` VALUES (1,3),(1,7),(1,9),(2,2),(2,8),(2,12),(3,1),(3,5),(3,10),(4,4),(4,6),(4,11),(5,2),(5,4),(5,10);
/*!40000 ALTER TABLE `menu_plat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0E3BD61CE16BA31DBBF396750` (`queue_name`,`available_at`,`delivered_at`,`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
INSERT INTO `messenger_messages` VALUES (2,'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:28:\\\"emails/inscription.html.twig\\\";i:1;N;i:2;a:1:{s:4:\\\"user\\\";O:15:\\\"App\\\\Entity\\\\User\\\":11:{s:19:\\\"\\0App\\\\Entity\\\\User\\0id\\\";i:23;s:22:\\\"\\0App\\\\Entity\\\\User\\0email\\\";s:16:\\\"mailtest@demo.fr\\\";s:25:\\\"\\0App\\\\Entity\\\\User\\0password\\\";s:60:\\\"$2y$13$E3kCcqLaMbZzdZSZn6e1v.92hUBDd/0saf2AS1M/1iT4vQwK7l2ni\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0roles\\\";a:1:{i:0;s:9:\\\"ROLE_USER\\\";}s:20:\\\"\\0App\\\\Entity\\\\User\\0nom\\\";s:4:\\\"mail\\\";s:23:\\\"\\0App\\\\Entity\\\\User\\0prenom\\\";s:4:\\\"test\\\";s:24:\\\"\\0App\\\\Entity\\\\User\\0adresse\\\";s:22:\\\"130 Rue de la Fontaine\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0ville\\\";s:18:\\\"Simandre-sur-Suran\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0telephone\\\";s:10:\\\"0600000000\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0commandes\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}s:21:\\\"\\0App\\\\Entity\\\\User\\0avis\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:26:\\\"no-reply@viteetgourmand.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:15:\\\"Vite & Gourmand\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:16:\\\"mailtest@demo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:31:\\\"Bienvenue sur Vite & Gourmand !\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}','[]','default','2026-04-08 11:25:03','2026-04-08 11:25:03',NULL),(3,'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:25:\\\"emails/commande.html.twig\\\";i:1;N;i:2;a:2:{s:8:\\\"commande\\\";O:19:\\\"App\\\\Entity\\\\Commande\\\":12:{s:23:\\\"\\0App\\\\Entity\\\\Commande\\0id\\\";i:5;s:36:\\\"\\0App\\\\Entity\\\\Commande\\0numero_commande\\\";i:5;s:34:\\\"\\0App\\\\Entity\\\\Commande\\0date_commande\\\";O:8:\\\"DateTime\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-04-08 11:28:53.322818\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:35:\\\"\\0App\\\\Entity\\\\Commande\\0date_livraison\\\";O:8:\\\"DateTime\\\":3:{s:4:\\\"date\\\";s:26:\\\"2026-04-09 00:00:00.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:36:\\\"\\0App\\\\Entity\\\\Commande\\0heure_livraison\\\";O:8:\\\"DateTime\\\":3:{s:4:\\\"date\\\";s:26:\\\"1970-01-01 16:30:00.000000\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}s:28:\\\"\\0App\\\\Entity\\\\Commande\\0adresse\\\";s:29:\\\"25 Rue du Port 33000 Bordeaux\\\";s:31:\\\"\\0App\\\\Entity\\\\Commande\\0prix_total\\\";d:0;s:27:\\\"\\0App\\\\Entity\\\\Commande\\0statut\\\";s:10:\\\"en_attente\\\";s:37:\\\"\\0App\\\\Entity\\\\Commande\\0nombre_personnes\\\";i:4;s:25:\\\"\\0App\\\\Entity\\\\Commande\\0user\\\";O:15:\\\"App\\\\Entity\\\\User\\\":11:{s:19:\\\"\\0App\\\\Entity\\\\User\\0id\\\";i:23;s:22:\\\"\\0App\\\\Entity\\\\User\\0email\\\";s:16:\\\"mailtest@demo.fr\\\";s:25:\\\"\\0App\\\\Entity\\\\User\\0password\\\";s:60:\\\"$2y$13$E3kCcqLaMbZzdZSZn6e1v.92hUBDd/0saf2AS1M/1iT4vQwK7l2ni\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0roles\\\";a:1:{i:0;s:9:\\\"ROLE_USER\\\";}s:20:\\\"\\0App\\\\Entity\\\\User\\0nom\\\";s:4:\\\"mail\\\";s:23:\\\"\\0App\\\\Entity\\\\User\\0prenom\\\";s:4:\\\"test\\\";s:24:\\\"\\0App\\\\Entity\\\\User\\0adresse\\\";s:22:\\\"130 Rue de la Fontaine\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0ville\\\";s:18:\\\"Simandre-sur-Suran\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0telephone\\\";s:10:\\\"0600000000\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0commandes\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:0;}s:21:\\\"\\0App\\\\Entity\\\\User\\0avis\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:0;}}s:25:\\\"\\0App\\\\Entity\\\\Commande\\0menu\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}s:25:\\\"\\0App\\\\Entity\\\\Commande\\0avis\\\";N;}s:4:\\\"user\\\";r:30;}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:26:\\\"no-reply@viteetgourmand.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:15:\\\"Vite & Gourmand\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:16:\\\"mailtest@demo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:35:\\\"Confirmation de votre commande n°5\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}','[]','default','2026-04-08 11:28:53','2026-04-08 11:28:53',NULL),(4,'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:28:\\\"emails/inscription.html.twig\\\";i:1;N;i:2;a:1:{s:4:\\\"user\\\";O:15:\\\"App\\\\Entity\\\\User\\\":11:{s:19:\\\"\\0App\\\\Entity\\\\User\\0id\\\";i:24;s:22:\\\"\\0App\\\\Entity\\\\User\\0email\\\";s:17:\\\"testmail2@demo.fr\\\";s:25:\\\"\\0App\\\\Entity\\\\User\\0password\\\";s:60:\\\"$2y$13$PLTZyv27APOzI6tsz0nDIOnzo90oRjPiiJqMXkOP6EhGPdFeOLBMm\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0roles\\\";a:1:{i:0;s:9:\\\"ROLE_USER\\\";}s:20:\\\"\\0App\\\\Entity\\\\User\\0nom\\\";s:4:\\\"test\\\";s:23:\\\"\\0App\\\\Entity\\\\User\\0prenom\\\";s:5:\\\"mail2\\\";s:24:\\\"\\0App\\\\Entity\\\\User\\0adresse\\\";s:22:\\\"130 Rue de la Fontaine\\\";s:22:\\\"\\0App\\\\Entity\\\\User\\0ville\\\";s:18:\\\"Simandre-sur-Suran\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0telephone\\\";s:10:\\\"0600000000\\\";s:26:\\\"\\0App\\\\Entity\\\\User\\0commandes\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}s:21:\\\"\\0App\\\\Entity\\\\User\\0avis\\\";O:33:\\\"Doctrine\\\\ORM\\\\PersistentCollection\\\":2:{s:13:\\\"\\0*\\0collection\\\";O:43:\\\"Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\\":1:{s:53:\\\"\\0Doctrine\\\\Common\\\\Collections\\\\ArrayCollection\\0elements\\\";a:0:{}}s:14:\\\"\\0*\\0initialized\\\";b:1;}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:26:\\\"no-reply@viteetgourmand.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:15:\\\"Vite & Gourmand\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:17:\\\"testmail2@demo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:31:\\\"Bienvenue sur Vite & Gourmand !\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}','[]','default','2026-04-08 11:40:31','2026-04-08 11:40:31',NULL);
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plat`
--

DROP TABLE IF EXISTS `plat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plat` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `allergene` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plat`
--

LOCK TABLES `plat` WRITE;
/*!40000 ALTER TABLE `plat` DISABLE KEYS */;
INSERT INTO `plat` VALUES (1,'Salade César','Entrée','Oeufs'),(2,'Soupe de légumes','Entrée',NULL),(3,'Bruschetta','Entrée','Gluten'),(4,'Poulet rôti','Plat principal',NULL),(5,'Saumon grillé','Plat principal','Poisson'),(6,'Steak frites','Plat principal',NULL),(7,'Lasagnes','Plat principal','Gluten'),(8,'Risotto champignons','Plat principal',NULL),(9,'Tiramisu','Dessert','Oeufs'),(10,'Mousse au chocolat','Dessert',NULL),(11,'Tarte aux pommes','Dessert','Gluten'),(12,'Salade de fruits','Dessert',NULL);
/*!40000 ALTER TABLE `plat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL,
  `expires_at` datetime NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`),
  CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reset_password_request`
--

LOCK TABLES `reset_password_request` WRITE;
/*!40000 ALTER TABLE `reset_password_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `reset_password_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roles` json NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `ville` varchar(255) NOT NULL,
  `telephone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_ADMIN\"]','Admin','Super','1 rue Admin','Paris','0600000001'),(2,'employe1@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_EMPLOYE\"]','Martin','Julie','2 rue Travail','Lyon','0600000002'),(3,'employe2@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_EMPLOYE\"]','Bernard','Lucas','3 rue Travail','Marseille','0600000003'),(4,'user1@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Durand','Emma','4 rue A','Paris','0600000004'),(5,'user2@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Petit','Louis','5 rue B','Lyon','0600000005'),(6,'user3@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Robert','Chloe','6 rue C','Nice','0600000006'),(7,'user4@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Richard','Hugo','7 rue D','Bordeaux','0600000007'),(8,'user5@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Moreau','Lea','8 rue E','Lille','0600000008'),(9,'user6@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Simon','Nathan','9 rue F','Toulouse','0600000009'),(10,'user7@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Laurent','Manon','10 rue G','Nantes','0600000010'),(11,'user8@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Michel','Enzo','11 rue H','Strasbourg','0600000011'),(12,'user9@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Garcia','Camille','12 rue I','Rennes','0600000012'),(13,'user10@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','David','Theo','13 rue J','Reims','0600000013'),(14,'user11@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Bertrand','Sarah','14 rue K','Dijon','0600000014'),(15,'user12@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Roux','Tom','15 rue L','Angers','0600000015'),(16,'user13@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Vincent','Eva','16 rue M','Grenoble','0600000016'),(17,'user14@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Fournier','Noah','17 rue N','Limoges','0600000017'),(18,'user15@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Morel','Jade','18 rue O','Metz','0600000018'),(19,'user16@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Girard','Lina','19 rue P','Amiens','0600000019'),(20,'user17@demo.fr','$2y$13$nBYq0cXuKAuOXXYaSiFwme3LuSj80tRj7cegWZoZWAmzmgI50NuDS','[\"ROLE_USER\"]','Andre','Milo','20 rue Q','Caen','0600000020'),(21,'testform@email.fr','$2y$13$LE/cwZW7bHvJ3RFyFQ/qXueaKj8pMUokJIDogcKUyrcTM4AWOpEXy','[\"ROLE_USER\"]','testform','testform','3 rue du testform','testformville','0600000000'),(22,'user18@demo.fr','Demo1234!','[\"ROLE_USER\"]','Plantier','Martin','33 route du Chien','Marseille','0600000020'),(23,'mailtest@demo.fr','$2y$13$E3kCcqLaMbZzdZSZn6e1v.92hUBDd/0saf2AS1M/1iT4vQwK7l2ni','[\"ROLE_USER\"]','mail','test','130 Rue de la Fontaine','Simandre-sur-Suran','0600000000'),(24,'testmail2@demo.fr','$2y$13$PLTZyv27APOzI6tsz0nDIOnzo90oRjPiiJqMXkOP6EhGPdFeOLBMm','[\"ROLE_USER\"]','test','mail2','130 Rue de la Fontaine','Simandre-sur-Suran','0600000000');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-09 12:44:29
