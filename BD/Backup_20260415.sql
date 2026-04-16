CREATE DATABASE  IF NOT EXISTS `sistema_archivo` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sistema_archivo`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: sistema_archivo
-- ------------------------------------------------------
-- Server version	9.3.0

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

--
-- Table structure for table `auditoria`
--

DROP TABLE IF EXISTS `auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) DEFAULT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `tabla_afectada` varchar(50) DEFAULT NULL,
  `registro_id` int DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria`
--

LOCK TABLES `auditoria` WRITE;
/*!40000 ALTER TABLE `auditoria` DISABLE KEYS */;
INSERT INTO `auditoria` VALUES (1,'admin','Carga masiva: 8 carpetas','carpeta_fiscal',0,'2026-04-14 21:58:48'),(2,'admin','Registro de préstamo','prestamo',1,'2026-04-14 21:59:48'),(3,'admin','Carga masiva: 89 carpetas','carpeta_fiscal',0,'2026-04-16 00:18:36');
/*!40000 ALTER TABLE `auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carpeta_fiscal`
--

DROP TABLE IF EXISTS `carpeta_fiscal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carpeta_fiscal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_carpeta` varchar(50) NOT NULL,
  `imputado` varchar(255) NOT NULL,
  `delito` varchar(255) NOT NULL,
  `agraviado` varchar(255) NOT NULL,
  `estado` enum('Activo','Archivado','En Préstamo') DEFAULT 'Activo',
  `ubicacion_fisica` varchar(100) NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_carpeta` (`numero_carpeta`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carpeta_fiscal`
--

LOCK TABLES `carpeta_fiscal` WRITE;
/*!40000 ALTER TABLE `carpeta_fiscal` DISABLE KEYS */;
INSERT INTO `carpeta_fiscal` VALUES (1,'EXP-2024-001','Juan Perez','Hurto Agravado','Empresa X','Activo','Estante A-1','2026-04-14 21:47:27'),(2,'EXP-2026-002','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-3','2026-04-14 21:58:48'),(3,'EXP-2026-003','Juan Caceres','Hurto Agravado','Empresa XX','En Préstamo','Estante A-4','2026-04-14 21:58:48'),(4,'EXP-2026-004','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-5','2026-04-14 21:58:48'),(5,'EXP-2026-005','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-6','2026-04-14 21:58:48'),(6,'EXP-2026-006','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-7','2026-04-14 21:58:48'),(7,'EXP-2026-007','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-8','2026-04-14 21:58:48'),(8,'EXP-2026-008','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-9','2026-04-14 21:58:48'),(9,'EXP-2026-009','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-10','2026-04-14 21:58:48'),(11,'EXP-2026-012','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-13','2026-04-16 00:18:36'),(12,'EXP-2026-013','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-14','2026-04-16 00:18:36'),(13,'EXP-2026-014','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-15','2026-04-16 00:18:36'),(14,'EXP-2026-015','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-16','2026-04-16 00:18:36'),(15,'EXP-2026-016','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-17','2026-04-16 00:18:36'),(16,'EXP-2026-017','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-18','2026-04-16 00:18:36'),(17,'EXP-2026-018','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-19','2026-04-16 00:18:36'),(18,'EXP-2026-019','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-20','2026-04-16 00:18:36'),(19,'EXP-2026-020','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-21','2026-04-16 00:18:36'),(20,'EXP-2026-021','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-22','2026-04-16 00:18:36'),(21,'EXP-2026-022','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-23','2026-04-16 00:18:36'),(22,'EXP-2026-023','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-24','2026-04-16 00:18:36'),(23,'EXP-2026-024','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-25','2026-04-16 00:18:36'),(24,'EXP-2026-025','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-26','2026-04-16 00:18:36'),(25,'EXP-2026-026','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-27','2026-04-16 00:18:36'),(26,'EXP-2026-027','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-28','2026-04-16 00:18:36'),(27,'EXP-2026-028','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-29','2026-04-16 00:18:36'),(28,'EXP-2026-029','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-30','2026-04-16 00:18:36'),(29,'EXP-2026-030','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-31','2026-04-16 00:18:36'),(30,'EXP-2026-031','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-32','2026-04-16 00:18:36'),(31,'EXP-2026-032','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-33','2026-04-16 00:18:36'),(32,'EXP-2026-033','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-34','2026-04-16 00:18:36'),(33,'EXP-2026-034','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-35','2026-04-16 00:18:36'),(34,'EXP-2026-035','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-36','2026-04-16 00:18:36'),(35,'EXP-2026-036','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-37','2026-04-16 00:18:36'),(36,'EXP-2026-037','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-38','2026-04-16 00:18:36'),(37,'EXP-2026-038','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-39','2026-04-16 00:18:36'),(38,'EXP-2026-039','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-40','2026-04-16 00:18:36'),(39,'EXP-2026-040','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-41','2026-04-16 00:18:36'),(40,'EXP-2026-041','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-42','2026-04-16 00:18:36'),(41,'EXP-2026-042','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-43','2026-04-16 00:18:36'),(42,'EXP-2026-043','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-44','2026-04-16 00:18:36'),(43,'EXP-2026-044','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-45','2026-04-16 00:18:36'),(44,'EXP-2026-045','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-46','2026-04-16 00:18:36'),(45,'EXP-2026-046','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-47','2026-04-16 00:18:36'),(46,'EXP-2026-047','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-48','2026-04-16 00:18:36'),(47,'EXP-2026-048','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-49','2026-04-16 00:18:36'),(48,'EXP-2026-049','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-50','2026-04-16 00:18:36'),(49,'EXP-2026-050','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-51','2026-04-16 00:18:36'),(50,'EXP-2026-051','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-52','2026-04-16 00:18:36'),(51,'EXP-2026-052','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-53','2026-04-16 00:18:36'),(52,'EXP-2026-053','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-54','2026-04-16 00:18:36'),(53,'EXP-2026-054','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-55','2026-04-16 00:18:36'),(54,'EXP-2026-055','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-56','2026-04-16 00:18:36'),(55,'EXP-2026-056','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-57','2026-04-16 00:18:36'),(56,'EXP-2026-057','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-58','2026-04-16 00:18:36'),(57,'EXP-2026-058','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-59','2026-04-16 00:18:36'),(58,'EXP-2026-059','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-60','2026-04-16 00:18:36'),(59,'EXP-2026-060','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-61','2026-04-16 00:18:36'),(60,'EXP-2026-061','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-62','2026-04-16 00:18:36'),(61,'EXP-2026-062','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-63','2026-04-16 00:18:36'),(62,'EXP-2026-063','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-64','2026-04-16 00:18:36'),(63,'EXP-2026-064','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-65','2026-04-16 00:18:36'),(64,'EXP-2026-065','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-66','2026-04-16 00:18:36'),(65,'EXP-2026-066','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-67','2026-04-16 00:18:36'),(66,'EXP-2026-067','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-68','2026-04-16 00:18:36'),(67,'EXP-2026-068','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-69','2026-04-16 00:18:36'),(68,'EXP-2026-069','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-70','2026-04-16 00:18:36'),(69,'EXP-2026-070','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-71','2026-04-16 00:18:36'),(70,'EXP-2026-071','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-72','2026-04-16 00:18:36'),(71,'EXP-2026-072','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-73','2026-04-16 00:18:36'),(72,'EXP-2026-073','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-74','2026-04-16 00:18:36'),(73,'EXP-2026-074','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-75','2026-04-16 00:18:36'),(74,'EXP-2026-075','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-76','2026-04-16 00:18:36'),(75,'EXP-2026-076','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-77','2026-04-16 00:18:36'),(76,'EXP-2026-077','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-78','2026-04-16 00:18:36'),(77,'EXP-2026-078','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-79','2026-04-16 00:18:36'),(78,'EXP-2026-079','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-80','2026-04-16 00:18:36'),(79,'EXP-2026-080','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-81','2026-04-16 00:18:36'),(80,'EXP-2026-081','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-82','2026-04-16 00:18:36'),(81,'EXP-2026-082','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-83','2026-04-16 00:18:36'),(82,'EXP-2026-083','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-84','2026-04-16 00:18:36'),(83,'EXP-2026-084','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-85','2026-04-16 00:18:36'),(84,'EXP-2026-085','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-86','2026-04-16 00:18:36'),(85,'EXP-2026-086','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-87','2026-04-16 00:18:36'),(86,'EXP-2026-087','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-88','2026-04-16 00:18:36'),(87,'EXP-2026-088','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-89','2026-04-16 00:18:36'),(88,'EXP-2026-089','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-90','2026-04-16 00:18:36'),(89,'EXP-2026-090','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-91','2026-04-16 00:18:36'),(90,'EXP-2026-091','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-92','2026-04-16 00:18:36'),(91,'EXP-2026-092','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-93','2026-04-16 00:18:36'),(92,'EXP-2026-093','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-94','2026-04-16 00:18:36'),(93,'EXP-2026-094','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-95','2026-04-16 00:18:36'),(94,'EXP-2026-095','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-96','2026-04-16 00:18:36'),(95,'EXP-2026-096','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-97','2026-04-16 00:18:36'),(96,'EXP-2026-097','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-98','2026-04-16 00:18:36'),(97,'EXP-2026-098','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-99','2026-04-16 00:18:36'),(98,'EXP-2026-099','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-100','2026-04-16 00:18:36'),(99,'EXP-2026-100','Juan Caceres','Hurto Agravado','Empresa XX','Activo','Estante A-101','2026-04-16 00:18:36');
/*!40000 ALTER TABLE `carpeta_fiscal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependencia`
--

DROP TABLE IF EXISTS `dependencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dependencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencia`
--

LOCK TABLES `dependencia` WRITE;
/*!40000 ALTER TABLE `dependencia` DISABLE KEYS */;
INSERT INTO `dependencia` VALUES (1,'Fiscalía Penal 1','2026-04-14 21:47:27'),(2,'Fiscalía de Familia','2026-04-14 21:47:27'),(3,'Anticorrupción','2026-04-14 21:47:27');
/*!40000 ALTER TABLE `dependencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_prestamo`
--

DROP TABLE IF EXISTS `detalle_prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_prestamo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prestamo_id` int NOT NULL,
  `carpeta_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prestamo_id` (`prestamo_id`,`carpeta_id`),
  KEY `carpeta_id` (`carpeta_id`),
  CONSTRAINT `detalle_prestamo_ibfk_1` FOREIGN KEY (`prestamo_id`) REFERENCES `prestamo` (`id`) ON DELETE CASCADE,
  CONSTRAINT `detalle_prestamo_ibfk_2` FOREIGN KEY (`carpeta_id`) REFERENCES `carpeta_fiscal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_prestamo`
--

LOCK TABLES `detalle_prestamo` WRITE;
/*!40000 ALTER TABLE `detalle_prestamo` DISABLE KEYS */;
INSERT INTO `detalle_prestamo` VALUES (1,1,3);
/*!40000 ALTER TABLE `detalle_prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `devolucion`
--

DROP TABLE IF EXISTS `devolucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devolucion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prestamo_id` int NOT NULL,
  `fecha_devolucion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `observacion` text,
  PRIMARY KEY (`id`),
  KEY `prestamo_id` (`prestamo_id`),
  CONSTRAINT `devolucion_ibfk_1` FOREIGN KEY (`prestamo_id`) REFERENCES `prestamo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devolucion`
--

LOCK TABLES `devolucion` WRITE;
/*!40000 ALTER TABLE `devolucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `devolucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestamo`
--

DROP TABLE IF EXISTS `prestamo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestamo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `guia_numero` varchar(50) NOT NULL,
  `dependencia_id` int NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `plazo_dias` int DEFAULT '7',
  `fecha_vencimiento` date NOT NULL,
  `estado` enum('Pendiente','Devuelto') DEFAULT 'Pendiente',
  PRIMARY KEY (`id`),
  UNIQUE KEY `guia_numero` (`guia_numero`),
  KEY `dependencia_id` (`dependencia_id`),
  CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`dependencia_id`) REFERENCES `dependencia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestamo`
--

LOCK TABLES `prestamo` WRITE;
/*!40000 ALTER TABLE `prestamo` DISABLE KEYS */;
INSERT INTO `prestamo` VALUES (1,'PREST-003',1,'2026-04-07',7,'2026-04-14','Pendiente');
/*!40000 ALTER TABLE `prestamo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `rol` enum('Administrador','Operador') DEFAULT 'Operador',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'admin','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Administrador Sistema','Administrador','2026-04-14 21:47:27'),(2,'operador','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Operador Sistema','Operador','2026-04-15 23:26:54');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-15 19:26:54
