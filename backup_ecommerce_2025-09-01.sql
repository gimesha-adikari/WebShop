-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: ecommerce
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.1

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
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `lineTotal` decimal(10,2) NOT NULL,
  `quantity` int NOT NULL,
  `unitPrice` decimal(10,2) NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  KEY `FKocimc7dtr037rh4ls4l95nlfi` (`product_id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKocimc7dtr037rh4ls4l95nlfi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,6900.00,1,6900.00,1,20),(2,25900.00,1,25900.00,1,19),(3,89999.00,1,89999.00,1,13),(4,475000.00,1,475000.00,1,10),(5,475000.00,1,475000.00,2,10),(6,139999.00,1,139999.00,3,14);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(6) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-09-01 08:16:51.680559',597799.00,1),(2,'2025-09-01 08:17:05.737856',475000.00,1),(3,'2025-09-01 09:03:23.543156',139999.00,1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'14\" FHD, Ryzen 5 5500U, 8GB RAM, 512GB SSD, Windows 11','/uploads/bd5b87643d2a48ff91d2a7279f28a8ec.jpg','Lenovo IdeaPad Slim 3 14\" (Ryzen 5, 8GB/512GB)',195000.00,10),(2,'6.4\" AMOLED, 50MP, 5G, 128GB storage','/uploads/5dda30f8bf344de28cc97cdfbe3fed86.jpg','Samsung Galaxy S23 FE (128GB)',229000.00,15),(3,'True wireless earbuds with ANC and long battery life','/uploads/0a4c93d1a7864a6391f4b55739dfe262.jpg','Anker Soundcore Life P3',24000.00,50),(4,'Ergonomic gaming mouse, 11 buttons, RGB','/uploads/5f5f7a8d725c40cb8b68d423fa0894e6.jpg','Logitech G502 HERO',17900.00,35),(5,'Hot-swappable mechanical keyboard, backlit','/uploads/95b869dff4634a4db4cfd903e65032eb.jpg','Keychron K2 V2 (Blue Switches)',22500.00,22),(6,'IPS, QHD 144Hz, 1ms, G-Sync Compatible','/uploads/051e1a31f36342f3a6405175e762a77e.jpg','LG 27GN800-B 27',145000.00,8),(7,'Compact 65W fast charger, USB-C PD','/uploads/f3e50e64cee24f59a9c17b804465df65.jpg','Anker 65W GaN Charger (USB-C)',12900.00,40),(8,'USB 3.2 Gen 2, up to 1050MB/s','/uploads/13d3bb64f8d3437b9c114856b57864a8.jpg','Samsung T7 Portable SSD 1TB',52000.00,12),(9,'13.6\" Liquid Retina, Apple M2, 8GB RAM, 256GB SSD','/uploads/aead8ba1aa6d4fb2a8911b7cdad0f918.jpg','Apple MacBook Air 13\" (M2, 8GB/256GB)',389000.00,6),(10,'13.4\" FHD+, Core i7, 16GB RAM, 512GB SSD','/uploads/bbbfc5d3048440098780a11e7e911cf0.png','Dell XPS 13 9315 (i7, 16GB/512GB)',475000.00,4),(11,'15.6\" 144Hz, i5-11400H, RTX 3050, 8GB RAM, 512GB SSD','/uploads/a4a037c77edf470294992d7b33f9975a.jpg','ASUS TUF Gaming F15 (i5 + RTX 3050)',329000.00,7),(12,'10.9\" Liquid Retina, A14 Bionic','/uploads/25ca37cb3a074a1ca1b6cf5d5bba2988.jpg','Apple iPad 10.9\" (64GB)',179000.00,1),(13,'6.67\" AMOLED 120Hz, 108MP camera, 5000 mAh','/uploads/4afcc4f82aea4a349fc796c284c5a761.jpg','Xiaomi Redmi Note 13 (8/256GB)',89999.00,20),(14,'6.7\" AMOLED 120Hz, 50MP camera, 5G','/uploads/9b39c8efb8d146daa0c5b78348b08f01.jpg','OnePlus Nord CE 4 (8/256GB)',139999.00,12),(15,'True wireless earbuds with ANC and MagSafe case','/uploads/cce18d4290d14eecaa36bbd15ccedbfa.jpg','Apple AirPods Pro (2nd Gen, USB-C)',99900.00,18),(16,'Over-ear Bluetooth headphones with active noise canceling','/uploads/b88502d9fade474791ee3faba0e442cf.jpg','Sony WH-CH720N',46990.00,14),(17,'1080p/30fps webcam with stereo mics','/uploads/c29fa10a18da46f08313ed880a59d153.jpg','Logitech C920x HD Pro Webcam',24500.00,25),(18,'Dual-band Wi-Fi 6 router, 4x Gigabit LAN','/uploads/f9d7091b5f5d40da810397531909fc65.jpg','TP-Link Archer AX55 (AX3000)',38990.00,16),(19,'PCIe 4.0 x4 SSD, up to 3500 MB/s','/uploads/b0a8ab23606d44d6b02940d292dc6d6d.jpg','Kingston NV2 1TB NVMe M.2',25900.00,30),(20,'A1, UHS-I, up to 120 MB/s','/uploads/b109a6902a48494d9adf77c0dd42feba.jpg','SanDisk Ultra microSDXC 128GB',6900.00,60);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `createdAt` datetime(6) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fullName` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passwordHash` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2025-09-01 06:50:49.279586','gimesha@gmail.com','gimesha','$2a$10$jvqZlJ7/DvSiqZ7RiQ5fQO0EqSRb1bqzjUguTSqiHsE5oa4/J1z4q');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ecommerce'
--

--
-- Dumping routines for database 'ecommerce'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-01 15:26:45
