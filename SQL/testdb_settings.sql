-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 52.224.216.91    Database: testdb
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `id` varchar(1) NOT NULL,
  `num_rows` int(11) DEFAULT NULL,
  `num_columns` int(11) DEFAULT NULL,
  `num_racks` int(11) DEFAULT NULL,
  `weaning_period` int(11) DEFAULT NULL,
  `breeding_period` int(11) DEFAULT NULL,
  `gestation_period` int(11) DEFAULT NULL,
  `male_lifespan` int(11) DEFAULT NULL,
  `female_lifespan` int(11) DEFAULT NULL,
  `male_cost` decimal(5,2) DEFAULT NULL,
  `female_cost` decimal(5,2) DEFAULT NULL,
  `cage_cost` decimal(5,2) DEFAULT NULL,
  `breeding_alert_advance` int(11) DEFAULT NULL,
  `weaning_alert_advance` int(11) DEFAULT NULL,
  `old_male_alert_advance` int(11) DEFAULT NULL,
  `old_female_alert_advance` int(11) DEFAULT NULL,
  `weaning_period_unit` int(11) DEFAULT NULL,
  `breeding_period_unit` int(11) DEFAULT NULL,
  `gestation_period_unit` int(11) DEFAULT NULL,
  `male_lifespan_unit` int(11) DEFAULT NULL,
  `female_lifespan_unit` int(11) DEFAULT NULL,
  `breeding_alert_advance_unit` int(11) DEFAULT NULL,
  `weaning_alert_advance_unit` int(11) DEFAULT NULL,
  `old_male_alert_advance_unit` int(11) DEFAULT NULL,
  `old_female_alert_advance_unit` int(11) DEFAULT NULL,
  `male_in_cage_color` int(11) DEFAULT NULL,
  `pups_in_cage_color` int(11) DEFAULT NULL,
  `pups_to_wean_color` int(11) DEFAULT NULL,
  `male_too_old_color` int(11) DEFAULT NULL,
  `female_too_old_color` int(11) DEFAULT NULL,
  `cage_with_order_color` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `weaning_period_unit` (`weaning_period_unit`),
  KEY `breeding_period_unit` (`breeding_period_unit`),
  KEY `gestation_period_unit` (`gestation_period_unit`),
  KEY `male_lifespan_unit` (`male_lifespan_unit`),
  KEY `female_lifespan_unit` (`female_lifespan_unit`),
  KEY `breeding_alert_advance_unit` (`breeding_alert_advance_unit`),
  KEY `weaning_alert_advance_unit` (`weaning_alert_advance_unit`),
  KEY `old_male_alert_advance_unit` (`old_male_alert_advance_unit`),
  KEY `old_female_alert_advance_unit` (`old_female_alert_advance_unit`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`weaning_period_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_2` FOREIGN KEY (`breeding_period_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_3` FOREIGN KEY (`gestation_period_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_4` FOREIGN KEY (`male_lifespan_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_5` FOREIGN KEY (`female_lifespan_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_6` FOREIGN KEY (`breeding_alert_advance_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_7` FOREIGN KEY (`weaning_alert_advance_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_8` FOREIGN KEY (`old_male_alert_advance_unit`) REFERENCES `time_units` (`id`),
  CONSTRAINT `settings_ibfk_9` FOREIGN KEY (`old_female_alert_advance_unit`) REFERENCES `time_units` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-03 16:32:44
