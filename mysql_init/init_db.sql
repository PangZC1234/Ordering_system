-- MySQL initialization script for ordering_system database

-- Grant all privileges to admin@''
GRANT ALL PRIVILEGES ON test_ordering_system.* TO 'admin'@'%';
FLUSH PRIVILEGES;

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS ordering_system;
USE ordering_system;

-- Table structure for user_api_appuser
CREATE TABLE IF NOT EXISTS `user_api_appuser` (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_appuser_groups
CREATE TABLE IF NOT EXISTS `user_api_appuser_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appuser_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_appuser_groups_appuser_id_group_id_7bedc5ff_uniq` (`appuser_id`,`group_id`),
  KEY `user_api_appuser_groups_group_id_84f84776_fk_auth_group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_appuser_user_permissions
CREATE TABLE IF NOT EXISTS `user_api_appuser_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `appuser_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_api_appuser_user_pe_appuser_id_permission_id_c7e343e4_uniq` (`appuser_id`,`permission_id`),
  KEY `user_api_appuser_use_permission_id_59ab5764_fk_auth_perm` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_category
CREATE TABLE IF NOT EXISTS `user_api_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_diningtable
CREATE TABLE IF NOT EXISTS `user_api_diningtable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `capacity` int NOT NULL,
  `location` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_invoice
CREATE TABLE IF NOT EXISTS `user_api_invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `archive_flag` tinyint(1) NOT NULL,
  `time_added` datetime(6) NOT NULL,
  `table_id_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_api_invoice_table_id_id_5825c8be_fk_user_api_diningtable_id` (`table_id_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for user_api_menu
CREATE TABLE IF NOT EXISTS `user_api_menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `picture_url` varchar(200) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_api_menu_category_id_5d0b5beb_fk_user_api_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Table structure for table `user_api_order`
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