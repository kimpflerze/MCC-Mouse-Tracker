CREATE DATABASE  IF NOT EXISTS `testdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `testdb`;
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
-- Temporary view structure for view `old_males`
--

DROP TABLE IF EXISTS `old_males`;
/*!50001 DROP VIEW IF EXISTS `old_males`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `old_males` AS SELECT 
 1 AS `id`,
 1 AS `Alert Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cages_to_wean`
--

DROP TABLE IF EXISTS `cages_to_wean`;
/*!50001 DROP VIEW IF EXISTS `cages_to_wean`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `cages_to_wean` AS SELECT 
 1 AS `id`,
 1 AS `Alert Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `statistics`
--

DROP TABLE IF EXISTS `statistics`;
/*!50001 DROP VIEW IF EXISTS `statistics`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `statistics` AS SELECT 
 1 AS `id`,
 1 AS `breeding_males`,
 1 AS `breeding_cages`,
 1 AS `num_litters`,
 1 AS `selling_cages`,
 1 AS `stock_mice`,
 1 AS `stock_males`,
 1 AS `stock_females`,
 1 AS `males_ordered`,
 1 AS `females_ordered`,
 1 AS `orders`,
 1 AS `alerts`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `old_females`
--

DROP TABLE IF EXISTS `old_females`;
/*!50001 DROP VIEW IF EXISTS `old_females`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `old_females` AS SELECT 
 1 AS `current_cage_id`,
 1 AS `Alert Date`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `old_males`
--

/*!50001 DROP VIEW IF EXISTS `old_males`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`novackgm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `old_males` AS select `m`.`id` AS `id`,(`m`.`dob` + interval `s`.`male_lifespan` day) AS `Alert Date` from (`breeding_male` `m` join `settings` `s`) where ((`s`.`id` = 1) and ((to_days(curdate()) - to_days(`m`.`dob`)) >= (`s`.`male_lifespan` - `s`.`old_male_alert_advance`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cages_to_wean`
--

/*!50001 DROP VIEW IF EXISTS `cages_to_wean`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`novackgm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `cages_to_wean` AS select `c`.`id` AS `id`,(`c`.`litter_dob` + interval `s`.`weaning_period` day) AS `Alert Date` from (`breeding_cage` `c` join `settings` `s`) where ((`s`.`id` = 1) and ((to_days(curdate()) - to_days(`c`.`litter_dob`)) >= (`s`.`weaning_period` - `s`.`weaning_alert_advance`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `statistics`
--

/*!50001 DROP VIEW IF EXISTS `statistics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`novackgm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `statistics` AS select (select uuid()) AS `id`,(select count(`male`.`id`) from `breeding_male` `male`) AS `breeding_males`,(select count(`cages`.`id`) from (`breeding_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where (`generic`.`active_flag` = 1)) AS `breeding_cages`,(select count(`cages`.`id`) from (`breeding_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where ((`generic`.`active_flag` = 1) and (`cages`.`litter_dob` is not null))) AS `num_litters`,(select count(`cages`.`id`) from (`selling_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where (`generic`.`active_flag` = 1)) AS `selling_cages`,(select sum(`cages`.`num_mice`) from (`selling_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where (`generic`.`active_flag` = 1)) AS `stock_mice`,(select sum(`cages`.`num_mice`) from (`selling_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where ((`generic`.`active_flag` = 1) and (`cages`.`gender_flag` = 1))) AS `stock_males`,(select sum(`cages`.`num_mice`) from (`selling_cage` `cages` join `generic_cage` `generic` on((`cages`.`id` = `generic`.`id`))) where ((`generic`.`active_flag` = 1) and (`cages`.`gender_flag` = 0))) AS `stock_females`,(select sum(`o`.`number_of_male_mice`) from `orders` `o` where (`o`.`active` = 1)) AS `males_ordered`,(select sum(`o`.`number_of_female_mice`) from `orders` `o` where (`o`.`active` = 1)) AS `females_ordered`,(select count(`o`.`id`) from `orders` `o`) AS `orders`,(select count(`a`.`id`) from `alerts` `a`) AS `alerts` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `old_females`
--

/*!50001 DROP VIEW IF EXISTS `old_females`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`novackgm`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `old_females` AS select distinct `f`.`current_cage_id` AS `current_cage_id`,(`f`.`dob` + interval `s`.`female_lifespan` day) AS `Alert Date` from (`parent_cage_lookup` `f` join `settings` `s`) where ((`s`.`id` = 1) and ((to_days(curdate()) - to_days(`f`.`dob`)) >= (`s`.`female_lifespan` - `s`.`old_female_alert_advance`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Dumping events for database 'testdb'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `generate_alerts` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`novackgm`@`%`*/ /*!50106 EVENT `generate_alerts` ON SCHEDULE EVERY 1 DAY STARTS '2018-02-19 05:47:38' ON COMPLETION NOT PRESERVE ENABLE DO BEGIN
			DELETE FROM alerts;
			CALL generate_wean_alert;
			CALL generate_old_male_alert;
			CALL generate_old_female_alert;
        END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'testdb'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_statistics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`novackgm`@`%` PROCEDURE `add_statistics`()
BEGIN
	insert into statistics values (
		(SELECT UUID()),
		(SELECT 
                COUNT(`male`.`id`)
            FROM
                `breeding_male` `male`),
        (SELECT 
                COUNT(`cages`.`id`)
            FROM
                (`breeding_cage` `cages`
                JOIN `generic_cage` `generic` ON ((`cages`.`id` = `generic`.`id`)))
            WHERE
                (`generic`.`active_flag` = 1)),
		(SELECT 
                COUNT(`cages`.`id`)
            FROM
                (`selling_cage` `cages`
                JOIN `generic_cage` `generic` ON ((`cages`.`id` = `generic`.`id`)))
            WHERE
                (`generic`.`active_flag` = 1)),
		(SELECT 
                SUM(`cages`.`num_mice`)
            FROM
                (`selling_cage` `cages`
                JOIN `generic_cage` `generic` ON ((`cages`.`id` = `generic`.`id`)))
            WHERE
                (`generic`.`active_flag` = 1)),
		(SELECT 
                COUNT(`o`.`id`)
            FROM
                `orders` `o` WHERE `o`.`delivery_date` >= CURDATE()),
		(SELECT 
                COUNT(`a`.`id`)
            FROM
                `alerts` `a`),
		(SELECT CURDATE())
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_old_female_alert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`novackgm`@`%` PROCEDURE `generate_old_female_alert`()
BEGIN

	#Declare variables
	DECLARE i INT DEFAULT  1;
	DECLARE cage_count INT DEFAULT (select COUNT(*) from old_females);


	SET @row_num = 0;
	#Create temp table
	CREATE TABLE IndexedCagesOldFemale
	SELECT current_cage_id, (@row_num:=@row_num + 1) AS row_number, `Alert Date` AS alert_date
	FROM old_females;

	#Loop through each cage in cages_to_wean
	WHILE i <= cage_count DO
		
        #Insert into the alerts table
		INSERT INTO alerts VALUES (null, 3, (SELECT current_cage_id FROM IndexedCagesOldFemale WHERE i = row_number), (SELECT alert_date FROM IndexedCagesOldFemale WHERE i = row_number));
		
        #Increment the index
        SET i = i + 1;
        
	END WHILE;
		
	#Drop the temp table
	DROP TABLE IndexedCagesOldFemale;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_old_male_alert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`novackgm`@`%` PROCEDURE `generate_old_male_alert`()
BEGIN

	#Declare variables
	DECLARE i INT DEFAULT  1;
	DECLARE cage_count INT DEFAULT (select COUNT(*) from old_males);


	SET @row_num = 0;
	#Create temp table
	CREATE TABLE IndexedCagesOldMale
	SELECT id, (@row_num:=@row_num + 1) AS row_number, `Alert Date` as alert_date
	FROM old_males;

	#Loop through each cage in cages_to_wean
	WHILE i <= cage_count DO
		
        #Insert into the alerts table
		INSERT INTO alerts VALUES (null, 2, (SELECT id FROM IndexedCagesOldMale WHERE i = row_number), (SELECT alert_date FROM IndexedCagesOldMale WHERE i = row_number));
		
        #Increment the index
        SET i = i + 1;
        
	END WHILE;
		
	#Drop the temp table
	DROP TABLE IndexedCagesOldMale;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generate_wean_alert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`novackgm`@`%` PROCEDURE `generate_wean_alert`()
BEGIN

	#Declare variables
	DECLARE i INT DEFAULT  1;
	DECLARE cage_count INT DEFAULT (select COUNT(*) from cages_to_wean);


	SET @row_num = 0;
	#Create temp table
	CREATE TABLE IndexedCagesToWean
	SELECT id, (@row_num:=@row_num + 1) AS row_number, `Alert Date` AS alert_date
	FROM cages_to_wean;

	#Loop through each cage in cages_to_wean
	WHILE i <= cage_count DO
		
        #Insert into the alerts table
		INSERT INTO alerts VALUES (null, 1, (SELECT id FROM IndexedCagesToWean WHERE i = row_number), (SELECT alert_date FROM IndexedCagesToWean WHERE i = row_number));
		
        #Increment the index
        SET i = i + 1;
        
	END WHILE;
		
	#Drop the temp table
	DROP TABLE IndexedCagesToWean;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-24 13:04:38
