-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Oct 24, 2012 at 08:03 AM
-- Server version: 5.5.24-log
-- PHP Version: 5.3.13

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ospos`
--

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_app_config`
--

DROP TABLE IF EXISTS `mlkh_app_config`;
CREATE TABLE IF NOT EXISTS `mlkh_app_config` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mlkh_app_config`
--

INSERT INTO `mlkh_app_config` (`key`, `value`) VALUES
('address', 'PO Box 1278 - 00515\nNairobi'),
('company', 'Mama Lucy Kibaki Hospital'),
('currency_symbol', 'KES'),
('default_tax_1_name', '0'),
('default_tax_1_rate', '0'),
('default_tax_2_name', '0'),
('default_tax_2_rate', '0'),
('default_tax_rate', '8'),
('email', 'medsupnedh@yahoo.com'),
('fax', ''),
('language', 'english'),
('phone', '020 2352455 / 020 8022676'),
('print_after_sale', '0'),
('return_policy', '0'),
('timezone', 'Africa/Nairobi'),
('website', '');

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_collections`
--

DROP TABLE IF EXISTS `mlkh_collections`;
CREATE TABLE IF NOT EXISTS `mlkh_collections` (
  `collections_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount` double NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`collections_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_customers`
--

DROP TABLE IF EXISTS `mlkh_customers`;
CREATE TABLE IF NOT EXISTS `mlkh_customers` (
  `person_id` int(10) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `queued` int(11) NOT NULL DEFAULT '0',
  `taxable` int(1) NOT NULL DEFAULT '1',
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Stand-in structure for view `mlkh_customer_history`
--
DROP VIEW IF EXISTS `mlkh_customer_history`;
CREATE TABLE IF NOT EXISTS `mlkh_customer_history` (
`sale_time` timestamp
,`quantity_purchased` double(15,2)
,`name` varchar(255)
,`first_name` varchar(255)
,`last_name` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_employees`
--

DROP TABLE IF EXISTS `mlkh_employees`;
CREATE TABLE IF NOT EXISTS `mlkh_employees` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `username` (`username`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mlkh_employees`
--

INSERT INTO `mlkh_employees` (`username`, `password`, `person_id`, `deleted`) VALUES
('admin', '439a6de57d475c1a0ba9bcb1c39f0af6', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_giftcards`
--

DROP TABLE IF EXISTS `mlkh_giftcards`;
CREATE TABLE IF NOT EXISTS `mlkh_giftcards` (
  `giftcard_id` int(11) NOT NULL AUTO_INCREMENT,
  `giftcard_number` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `value` double(15,2) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`giftcard_id`),
  UNIQUE KEY `giftcard_number` (`giftcard_number`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `mlkh_history`
--
DROP VIEW IF EXISTS `mlkh_history`;
CREATE TABLE IF NOT EXISTS `mlkh_history` (
`customer_id` int(10)
,`sale_time` timestamp
,`quantity_purchased` double(15,2)
,`name` varchar(255)
,`first_name` varchar(255)
,`last_name` varchar(255)
);
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_inventory`
--

DROP TABLE IF EXISTS `mlkh_inventory`;
CREATE TABLE IF NOT EXISTS `mlkh_inventory` (
  `trans_id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_items` int(11) NOT NULL DEFAULT '0',
  `trans_user` int(11) NOT NULL DEFAULT '0',
  `trans_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `trans_comment` text NOT NULL,
  `trans_inventory` int(11) NOT NULL DEFAULT '0',
  `trans_batchno` varchar(255) DEFAULT NULL,
  `trans_expirydate` date DEFAULT NULL,
  `trans_supplier` int(5) DEFAULT NULL,
  PRIMARY KEY (`trans_id`),
  KEY `mlkh_inventory_ibfk_1` (`trans_items`),
  KEY `mlkh_inventory_ibfk_2` (`trans_user`),
  KEY `trans_supplier` (`trans_supplier`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70 ;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_invoices`
--

DROP TABLE IF EXISTS `mlkh_invoices`;
CREATE TABLE IF NOT EXISTS `mlkh_invoices` (
  `invoice_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `invoice_id` int(10) NOT NULL AUTO_INCREMENT,
  `amount` double DEFAULT NULL,
  `processed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_invoices_items`
--

DROP TABLE IF EXISTS `mlkh_invoices_items`;
CREATE TABLE IF NOT EXISTS `mlkh_invoices_items` (
  `invoice_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`),
  KEY `description` (`description`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_items`
--

DROP TABLE IF EXISTS `mlkh_items`;
CREATE TABLE IF NOT EXISTS `mlkh_items` (
  `name` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `item_number` varchar(255) DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `cost_price` double(15,2) DEFAULT NULL,
  `unit_price` double(15,2) NOT NULL,
  `quantity` double(15,2) NOT NULL DEFAULT '1.00',
  `reorder_level` double(15,2) NOT NULL DEFAULT '0.00',
  `location` varchar(255) DEFAULT NULL,
  `item_id` int(10) NOT NULL AUTO_INCREMENT,
  `allow_alt_description` tinyint(1) DEFAULT NULL,
  `is_quantifiable` int(11) NOT NULL DEFAULT '0',
  `is_serialized` tinyint(1) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `dosage` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_number` (`item_number`),
  KEY `mlkh_items_ibfk_1` (`supplier_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=548 ;

--
-- Dumping data for table `mlkh_items`
--

INSERT INTO `mlkh_items` (`name`, `category`, `supplier_id`, `item_number`, `description`, `cost_price`, `unit_price`, `quantity`, `reorder_level`, `location`, `item_id`, `allow_alt_description`, `is_quantifiable`, `is_serialized`, `deleted`, `dosage`) VALUES
('Registration', 'Registration', NULL, 'HS006', '', 100.00, 100.00, 1.00, 0.00, '0', 10, 0, 0, 1, 0, NULL),
('Ward Deposit (Pediatric)', 'Wards', NULL, 'PED001', '', 1000.00, 1000.00, 1.00, 0.00, '0', 13, 0, 0, 0, 0, NULL),
('Ward Deposit (Adult)', 'Wards', 0, 'HS001', '', 2000.00, 2000.00, 1.00, 0.00, '', 14, 0, 0, 0, 0, NULL),
('Ward Deposit (ICU)', 'Wards', NULL, 'ICU001', '', 50000.00, 50000.00, 1.00, 0.00, '0', 15, 0, 0, 0, 0, NULL),
('Inpatient (Bed)', 'Inpatient', 0, 'HS002', '', 300.00, 300.00, 1.00, 0.00, '', 16, 0, 0, 0, 0, NULL),
('Inpatient (File)', 'File', 0, 'HS003', '', 300.00, 300.00, 1.00, 0.00, '', 17, 0, 0, 0, 0, NULL),
('Inpatient (Caretaker)', 'Inpatient', 0, 'HS004', '', 300.00, 300.00, 1.00, 0.00, '', 18, 0, 0, 0, 0, NULL),
('Internship/Attachment (non-go)', 'HS', 0, 'ADMIN', '', 1000.00, 1000.00, 1.00, 0.00, '', 19, 0, 0, 0, 0, NULL),
('Surgery', 'Theatre', 0, 'HS005', '', 5000.00, 5000.00, 1.00, 0.00, '', 20, 0, 0, 0, 0, NULL),
('GOPC', 'GOPC', NULL, 'CONS001', '', 300.00, 300.00, 1.00, 0.00, '0', 21, 0, 0, 0, 0, NULL),
('MOPC', 'MOPC', NULL, 'CONS002', '', 300.00, 300.00, 1.00, 0.00, '0', 22, 0, 0, 0, 0, NULL),
('SOPC', 'HS', 0, 'CONS003', '', 300.00, 300.00, 1.00, 0.00, '', 23, 0, 0, 0, 0, NULL),
('DOPC', 'DOPC', NULL, 'CONS004', '', 400.00, 400.00, 1.00, 0.00, '0', 24, 0, 0, 0, 0, NULL),
('OBS/GYN High Risk', 'HS', 0, 'CONS005', '', 300.00, 300.00, 1.00, 0.00, '', 25, 0, 0, 0, 0, NULL),
('Orthopaedic Clinic', 'Orthopaedics', NULL, 'CONS006', '', 300.00, 300.00, 1.00, 0.00, '0', 26, 0, 0, 0, 0, NULL),
('Maxillofacial', 'HS', 0, 'CONS007', '', 300.00, 300.00, 1.00, 0.00, '', 27, 0, 0, 0, 0, NULL),
('ENT', 'ENT', NULL, 'CONS008', '', 300.00, 300.00, 1.00, 0.00, '0', 28, 0, 0, 0, 0, NULL),
('Psychiatry', 'HS', 0, 'CONS009', '', 300.00, 300.00, 1.00, 0.00, '', 29, 0, 0, 0, 0, NULL),
('Opthalmology', 'HS', 0, 'CONS010', '', 300.00, 300.00, 1.00, 0.00, '', 30, 0, 0, 0, 0, NULL),
('POPC', 'HS', 0, 'CONS011', '', 300.00, 300.00, 1.00, 0.00, '', 31, 0, 0, 0, 0, NULL),
('Counselling', 'HS', 0, 'CLINIC001', '', 100.00, 100.00, 1.00, 0.00, '', 32, 0, 0, 0, 0, NULL),
('Physiotherapy', 'Orthopaedics', NULL, 'CLINIC002', '', 100.00, 100.00, 1.00, 0.00, '0', 33, 0, 0, 0, 0, NULL),
('Occupational Therapy', 'HS', 0, 'CLINIC003', '', 100.00, 100.00, 1.00, 0.00, '', 34, 0, 0, 0, 0, NULL),
('Plaster', 'Plaster', 0, 'CLINIC004', '', 100.00, 100.00, 1.00, 0.00, '', 35, 0, 0, 0, 0, NULL),
('Dental', 'Dental', NULL, 'CLINIC005', '', 100.00, 100.00, 1.00, 0.00, '0', 36, 0, 0, 0, 0, NULL),
('Diabetic', 'HS', 0, 'CLINIC006', '', 100.00, 100.00, 1.00, 0.00, '', 37, 0, 0, 0, 0, NULL),
('Tooth Extraction', 'Dental', 0, 'DEN001', '', 200.00, 200.00, 1.00, 0.00, '', 38, 0, 0, 0, 0, NULL),
('Closed Disipaction', 'Dental', 0, 'DEN002', '', 500.00, 500.00, 1.00, 0.00, '', 39, 0, 0, 0, 0, NULL),
('Open Disempaction', 'Dental', 0, 'DEN003', '', 1000.00, 1000.00, 1.00, 0.00, '', 40, 0, 0, 0, 0, NULL),
('Dry Socket Management', 'Dental', 0, 'DEN004', '', 100.00, 100.00, 1.00, 0.00, '', 41, 0, 0, 0, 0, NULL),
('Age Assessment', 'Dental', NULL, 'DEN005', '', 200.00, 200.00, 1.00, 0.00, '', 42, 0, 0, 0, 0, NULL),
('Excisional Biopsy Outpatient ', 'Dental', 0, 'DEN006', '', 1000.00, 1000.00, 1.00, 0.00, '', 43, 0, 0, 0, 0, NULL),
('Opeculactomy', 'Dental', 0, 'DEN007', '', 500.00, 500.00, 1.00, 0.00, '', 44, 0, 0, 0, 0, NULL),
('Incision and Drainage (I/D)', 'Dental', 0, 'DEN008', '', 500.00, 500.00, 1.00, 0.00, '', 45, 0, 0, 0, 0, NULL),
('Dental MOS Outpatient', 'Dental', 0, 'DEN009', '', 1500.00, 1500.00, 1.00, 0.00, '', 46, 0, 0, 0, 0, NULL),
('Frenectomy', 'Dental', 0, 'DEN010', '', 200.00, 200.00, 1.00, 0.00, '', 47, 0, 0, 0, 0, NULL),
('Change of Dressing', 'Dental', 0, 'DEN011', '', 150.00, 150.00, 1.00, 0.00, '', 48, 0, 0, 0, 0, NULL),
('Temporary Filling', 'Dental', 0, 'DEN012', '', 300.00, 300.00, 1.00, 0.00, '', 49, 0, 0, 0, 0, NULL),
('Silver Filling ', 'Dental', 0, 'DEN013', '', 800.00, 800.00, 1.00, 0.00, '', 50, 0, 0, 0, 0, NULL),
('Composite Filling', 'Dental', 0, 'DEN014', '', 800.00, 800.00, 1.00, 0.00, '', 51, 0, 0, 0, 0, NULL),
('Anterior Root Canal', 'Dental', NULL, 'DEN015', '', 1000.00, 1000.00, 1.00, 0.00, '', 52, 0, 0, 0, 0, NULL),
('Premolar Root Canal', 'Dental', 0, 'DEN016', '', 1500.00, 1500.00, 1.00, 0.00, '', 53, 0, 0, 0, 0, NULL),
('Molar Root Canal', 'Dental', 0, 'DEN017', '', 2500.00, 2500.00, 1.00, 0.00, '', 54, 0, 0, 0, 0, NULL),
('Apicectomy', 'Dental', NULL, 'DEN018', '', 1000.00, 1000.00, 1.00, 0.00, '', 55, 0, 0, 0, 0, NULL),
('Mental Porcelain Crown', 'Dental', 0, 'DEN019', '', 5000.00, 5000.00, 1.00, 0.00, '', 56, 0, 0, 0, 0, NULL),
('Splinting (per Arc)', 'Dental', 0, 'DEN020', '', 1000.00, 1000.00, 1.00, 0.00, '', 57, 0, 0, 0, 0, NULL),
('Intermaxillary Fixation (IMF)', 'Dental', 0, 'DEN021', '', 2000.00, 2000.00, 1.00, 0.00, '', 58, 0, 0, 0, 0, NULL),
('Removal of IMF/Splint/Stitch', 'Dental', 0, 'DEN022', '', 200.00, 200.00, 1.00, 0.00, '', 59, 0, 0, 0, 0, NULL),
('Prophylaxis Dental', 'Dental', 0, 'DEN023', '', 600.00, 600.00, 1.00, 0.00, '', 60, 0, 0, 0, 0, NULL),
('Full Mouth Scaling', 'Dental', 0, 'DEN024', '', 1000.00, 1000.00, 1.00, 0.00, '', 61, 0, 0, 0, 0, NULL),
('1st Tooth', 'Dental', NULL, 'DEN025', '', 1000.00, 1000.00, 1.00, 0.00, '', 62, 0, 0, 0, 0, NULL),
('Any Addition (Dental)', 'Dental', NULL, 'DEN026', '', 200.00, 200.00, 1.00, 0.00, '', 63, 0, 0, 0, 0, NULL),
('Complete Dentures', 'Dental', 0, 'DEN027', '', 5000.00, 5000.00, 1.00, 0.00, '', 64, 0, 0, 0, 0, NULL),
('Single Complete Denture', 'Dental', 0, 'DEN028', '', 3000.00, 3000.00, 1.00, 0.00, '', 65, 0, 0, 0, 0, NULL),
('Denture Repair', 'Dental', 0, 'DEN029', '', 1000.00, 1000.00, 1.00, 0.00, '', 66, 0, 0, 0, 0, NULL),
('Braces Cron Cutting', 'Dental', 0, 'DEN030', '', 1200.00, 1200.00, 1.00, 0.00, '', 67, 0, 0, 0, 0, NULL),
('Braces Orthodontic Appliances', 'Dental', 0, 'DEN031', '', 3000.00, 3000.00, 1.00, 0.00, '', 68, 0, 0, 0, 0, NULL),
('Orthodontic Appliance Adjust', 'Dental', 0, 'DEN032', '', 200.00, 200.00, 1.00, 0.00, '', 69, 0, 0, 0, 0, NULL),
('Urinalysis (Maternity)', 'Maternity', 0, 'MAT001', '', 100.00, 100.00, 1.00, 0.00, '', 70, 0, 0, 0, 0, NULL),
('Episitiomy/Tear Repair', 'Maternity', 0, 'MAT002', '', 500.00, 500.00, 1.00, 0.00, '', 71, 0, 0, 0, 0, NULL),
('Vaginal Examination', 'Maternity', 0, 'MAT003', '', 100.00, 100.00, 1.00, 0.00, '', 72, 0, 0, 0, 0, NULL),
('Speculum Examination', 'Maternity', 0, 'MAT004', '', 200.00, 200.00, 1.00, 0.00, '', 73, 0, 0, 0, 0, NULL),
('Normal Delivery', 'Maternity', 0, 'MAT005', '', 3500.00, 3500.00, 1.00, 0.00, '', 74, 0, 0, 0, 0, NULL),
('Vacuum Extraction ', 'Maternity', 0, 'MAT006', '', 3500.00, 3500.00, 1.00, 0.00, '', 75, 0, 0, 0, 0, NULL),
('Caeserian Section', 'Maternity', 0, 'MAT007', '', 5000.00, 5000.00, 1.00, 0.00, '', 76, 0, 0, 0, 0, NULL),
('Maternity Bed Charges', 'Maternity', 0, 'MAT008', '', 250.00, 250.00, 1.00, 0.00, '', 77, 0, 0, 0, 0, NULL),
('BBA (Born Before Arrival)', 'Maternity', 0, 'MAT009', '', 500.00, 500.00, 1.00, 0.00, '', 78, 0, 0, 0, 0, NULL),
('MVA (Maternity)', 'MVA', NULL, 'MAT010', '', 1500.00, 1500.00, 1.00, 0.00, '0', 79, 0, 0, 0, 0, NULL),
('C/S Package', 'Maternity', 0, 'MAT011', '', 7000.00, 7000.00, 1.00, 0.00, '', 80, 0, 0, 0, 0, NULL),
('Normal Delivery Package', 'Maternity', 0, 'MAT012', '', 4500.00, 4500.00, 1.00, 0.00, '', 81, 0, 0, 0, 0, NULL),
('Hysterectomy (TAH,TVA, LAVH)', 'Gynaecology', 0, 'GYNAE001', '', 5000.00, 5000.00, 1.00, 0.00, '', 82, 0, 0, 0, 0, NULL),
('Radical Hysterectomy', 'Gynaecology', 0, 'GYNAE002', '', 5000.00, 5000.00, 1.00, 0.00, '', 83, 0, 0, 0, 0, NULL),
('Tuboplasty', 'Gynaecology', 0, 'GYNAE003', '', 5000.00, 5000.00, 1.00, 0.00, '', 84, 0, 0, 0, 0, NULL),
('Myomectomy', 'Gynaecology', 0, 'GYNAE004', '', 5000.00, 5000.00, 1.00, 0.00, '', 85, 0, 0, 0, 0, NULL),
('TAH /BSO', 'Gynaecology', 0, 'GYNAE005', '', 5000.00, 5000.00, 1.00, 0.00, '', 86, 0, 0, 0, 0, NULL),
('Vulvectomy', 'Gynaecology', 0, 'GYNAE006', '', 5000.00, 5000.00, 1.00, 0.00, '', 87, 0, 0, 0, 0, NULL),
('Explorative Laparatomy', 'Gynaecology', 0, 'GYNAE007', '', 5000.00, 5000.00, 1.00, 0.00, '', 88, 0, 0, 0, 0, NULL),
('Ovarian Cystectomy', 'Gynaecology', 0, 'GYNAE008', '', 3000.00, 3000.00, 1.00, 0.00, '', 89, 0, 0, 0, 0, NULL),
('Ovarian Drilling', 'Gynaecology', 0, 'GYNAE009', '', 3000.00, 3000.00, 1.00, 0.00, '', 90, 0, 0, 0, 0, NULL),
('Colporrhapy', 'Gynaecology', 0, 'GYNAE010', '', 3000.00, 3000.00, 1.00, 0.00, '', 91, 0, 0, 0, 0, NULL),
('Perineorrhapy', 'Gynaecology', 0, 'GYNAE011', '', 3000.00, 3000.00, 1.00, 0.00, '', 92, 0, 0, 0, 0, NULL),
('VVF Repair', 'Gynaecology', 0, 'GYNAE012', '', 0.00, 0.00, 1.00, 0.00, '', 93, 0, 0, 0, 0, NULL),
('BTL under GA', 'Gynaecology', 0, 'GYNAE013', '', 3000.00, 3000.00, 1.00, 0.00, '', 94, 0, 0, 0, 0, NULL),
('Cryotherapy/LEEP/LLETZ', 'Gynaecology', 0, 'GYNAE014', '', 3000.00, 3000.00, 1.00, 0.00, '', 95, 0, 0, 0, 0, NULL),
('Dilation & Curattage', 'Gynaecology', 0, 'GYNAE015', '', 3000.00, 3000.00, 1.00, 0.00, '', 96, 0, 0, 0, 0, NULL),
('Examination Under Anasth (EUA)', 'Gynaecology', 0, 'GYNAE016', '', 3000.00, 3000.00, 1.00, 0.00, '', 97, 0, 0, 0, 0, NULL),
('MVA (Gynae)', 'Gynaecology', NULL, 'GYNAE017', '', 1500.00, 1500.00, 1.00, 0.00, '0', 98, 0, 0, 0, 0, NULL),
('Mursupialization', 'Gynaecology', 0, 'GYNAE018', '', 2000.00, 2000.00, 1.00, 0.00, '', 99, 0, 0, 0, 0, NULL),
('BTL under LA', 'Gynaecology', 0, 'GYNAE019', '', 500.00, 500.00, 1.00, 0.00, '', 100, 0, 0, 0, 0, NULL),
('Mac Donalds Stitch', 'Gynaecology', 0, 'GYNAE020', '', 500.00, 500.00, 1.00, 0.00, '', 101, 0, 0, 0, 0, NULL),
('Viideostrobosopy', 'ENT', 0, 'ENT001', '', 500.00, 500.00, 1.00, 0.00, '', 102, 0, 0, 0, 0, NULL),
('Rigid Nasal Endosiopy', 'ENT', 0, 'ENT002', '', 500.00, 500.00, 1.00, 0.00, '', 103, 0, 0, 0, 0, NULL),
('Aural Toilet', 'ENT', 0, 'ENT003', '', 500.00, 500.00, 1.00, 0.00, '', 104, 0, 0, 0, 0, NULL),
('Foreign Body (Ear, Nose)', 'ENT', 0, 'ENT004', '', 500.00, 500.00, 1.00, 0.00, '', 105, 0, 0, 0, 0, NULL),
('Chemical Cautery', 'ENT', 0, 'ENT005', '', 500.00, 500.00, 1.00, 0.00, '', 106, 0, 0, 0, 0, NULL),
('Packaging of the Nose', 'ENT', 0, 'ENT006', '', 300.00, 300.00, 1.00, 0.00, '', 107, 0, 0, 0, 0, NULL),
('Pure Tone Audiometry', 'ENT', 0, 'ENT007', '', 400.00, 400.00, 1.00, 0.00, '', 108, 0, 0, 0, 0, NULL),
('Tympanometry', 'ENT', 0, 'ENT008', '', 400.00, 400.00, 1.00, 0.00, '', 109, 0, 0, 0, 0, NULL),
('Punch Biopsy', 'ENT', 0, 'ENT009', '', 500.00, 500.00, 1.00, 0.00, '', 110, 0, 0, 0, 0, NULL),
('Exam Under Microscope (ENT)', 'ENT', 0, 'ENT010', '', 400.00, 400.00, 1.00, 0.00, '', 111, 0, 0, 0, 0, NULL),
('Ear Syringing', 'ENT', 0, 'ENT011', '', 200.00, 200.00, 1.00, 0.00, '', 112, 0, 0, 0, 0, NULL),
('Functional Endoscopic Sinus Sergus', 'ENT', 0, 'ENT012', '', 7000.00, 7000.00, 1.00, 0.00, '', 113, 0, 0, 0, 0, NULL),
('Superfual Parotidectomy', 'ENT', 0, 'ENT013', '', 7000.00, 7000.00, 1.00, 0.00, '', 114, 0, 0, 0, 0, NULL),
('Glossectomy', 'ENT', 0, 'ENT014', '', 7000.00, 7000.00, 1.00, 0.00, '', 115, 0, 0, 0, 0, NULL),
('Neck Dissecions', 'ENT', 0, 'ENT015', '', 7000.00, 7000.00, 1.00, 0.00, '', 116, 0, 0, 0, 0, NULL),
('Maxillectomy', 'ENT', 0, 'ENT016', '', 7000.00, 7000.00, 1.00, 0.00, '', 117, 0, 0, 0, 0, NULL),
('Total Paotidectomy', 'ENT', 0, 'ENT017', '', 7000.00, 7000.00, 1.00, 0.00, '', 118, 0, 0, 0, 0, NULL),
('Tonsilectomy (Adults)', 'ENT', 0, 'ENT018', '', 5000.00, 5000.00, 1.00, 0.00, '', 119, 0, 0, 0, 0, NULL),
('Turbinoplasty', 'ENT', 0, 'ENT019', '', 5000.00, 5000.00, 1.00, 0.00, '', 120, 0, 0, 0, 0, NULL),
('Tymplanoplasty', 'ENT', 0, 'ENT020', '', 5000.00, 5000.00, 1.00, 0.00, '', 121, 0, 0, 0, 0, NULL),
('Excision of Submalibular Gland', 'ENT', 0, 'ENT021', '', 5000.00, 5000.00, 1.00, 0.00, '', 122, 0, 0, 0, 0, NULL),
('Thyroglosal Duct Cyst Excision', 'ENT', 0, 'ENT022', '', 5000.00, 5000.00, 1.00, 0.00, '', 123, 0, 0, 0, 0, NULL),
('Microlaryngeal Excision of Polyp/Nodule', 'ENT', 0, 'ENT023', '', 5000.00, 5000.00, 1.00, 0.00, '', 124, 0, 0, 0, 0, NULL),
('Lateralization of Vocal Chords', 'ENT', 0, 'ENT024', '', 5000.00, 5000.00, 1.00, 0.00, '', 125, 0, 0, 0, 0, NULL),
('Mastoidectomy', 'ENT', 0, 'ENT025', '', 5000.00, 5000.00, 1.00, 0.00, '', 126, 0, 0, 0, 0, NULL),
('Adenotonsillectomy', 'ENT', NULL, 'ENT026', '', 3000.00, 3000.00, 1.00, 0.00, '', 127, 0, 0, 0, 0, NULL),
('Adenotonlectomy', 'ENT', NULL, 'ENT027', '', 3000.00, 3000.00, 1.00, 0.00, '', 128, 0, 0, 0, 0, NULL),
('Tonsillectomy (Paed)', 'ENT', 0, 'ENT028', '', 3000.00, 3000.00, 1.00, 0.00, '', 129, 0, 0, 0, 0, NULL),
('Lymph Node Biopsy', 'ENT', 0, 'ENT029', '', 3000.00, 3000.00, 1.00, 0.00, '', 130, 0, 0, 0, 0, NULL),
('Bilateral Maxillary WashOut (BAVO)', 'ENT', 0, 'ENT030', '', 3000.00, 3000.00, 1.00, 0.00, '', 131, 0, 0, 0, 0, NULL),
('Rigid Nasal Endoscopy & Biopsy', 'ENT', 0, 'ENT031', '', 3000.00, 3000.00, 1.00, 0.00, '', 132, 0, 0, 0, 0, NULL),
('Neck Mass Surgery', 'ENT', 0, 'ENT032', '', 3000.00, 3000.00, 1.00, 0.00, '', 133, 0, 0, 0, 0, NULL),
('Insertion of Grommet', 'ENT', 0, 'ENT033', '', 3000.00, 3000.00, 1.00, 0.00, '', 134, 0, 0, 0, 0, NULL),
('Cervical Abscess Drainage', 'ENT', 0, 'ENT034', '', 3000.00, 3000.00, 1.00, 0.00, '', 135, 0, 0, 0, 0, NULL),
('Drainage of Parotid Abscess', 'ENT', 0, 'ENT035', '', 3000.00, 3000.00, 1.00, 0.00, '', 136, 0, 0, 0, 0, NULL),
('Excision of Preanular Sinus', 'ENT', 0, 'ENT036', '', 3000.00, 3000.00, 1.00, 0.00, '', 137, 0, 0, 0, 0, NULL),
('Tracheosectomy', 'ENT', 0, 'ENT037', '', 3000.00, 3000.00, 1.00, 0.00, '', 138, 0, 0, 0, 0, NULL),
('Refashioning of the Tracheostoma', 'ENT', 0, 'ENT038', '', 3000.00, 3000.00, 1.00, 0.00, '', 139, 0, 0, 0, 0, NULL),
('Eosophegoscopy & Removal of FB', 'ENT', 0, 'ENT039', '', 3000.00, 3000.00, 1.00, 0.00, '', 140, 0, 0, 0, 0, NULL),
('Removal of FB Nose/Ear Under GA', 'ENT', 0, 'ENT040', '', 3000.00, 3000.00, 1.00, 0.00, '', 141, 0, 0, 0, 0, NULL),
('Skull Ap/Lateral', 'X-Ray', 0, 'XR001', '', 550.00, 550.00, 1.00, 0.00, '', 142, 0, 0, 0, 0, NULL),
('Skull Paranosal Sinuses', 'X-Ray', 0, 'XR002', '', 550.00, 550.00, 1.00, 0.00, '', 143, 0, 0, 0, 0, NULL),
('Skull Pituitary Fossa', 'X-Ray', 0, 'XR003', '', 550.00, 550.00, 1.00, 0.00, '', 144, 0, 0, 0, 0, NULL),
('Skull Orbits', 'X-Ray', 0, 'XR004', '', 550.00, 550.00, 1.00, 0.00, '', 145, 0, 0, 0, 0, NULL),
('Skull Optic Foramen', 'X-Ray', 0, 'XR005', '', 550.00, 550.00, 1.00, 0.00, '', 146, 0, 0, 0, 0, NULL),
('Skull Occipital Mental', 'X-Ray', 0, 'XR006', '', 550.00, 550.00, 1.00, 0.00, '', 147, 0, 0, 0, 0, NULL),
('Skull Townes View', 'X-Ray', 0, 'XR007', '', 550.00, 550.00, 1.00, 0.00, '', 148, 0, 0, 0, 0, NULL),
('Skull Nasal Bones', 'X-Ray', 0, 'XR008', '', 550.00, 550.00, 1.00, 0.00, '', 149, 0, 0, 0, 0, NULL),
('Skull Mastiods', 'X-Ray', 0, 'XR009', '', 550.00, 550.00, 1.00, 0.00, '', 150, 0, 0, 0, 0, NULL),
('Temporal-Mandibular Joints A-P', 'X-Ray', 0, 'XR010', '', 550.00, 550.00, 1.00, 0.00, '', 151, 0, 0, 0, 0, NULL),
('Temporal-Mandibular Joints Bilateral', 'X-Ray', 0, 'XR011', '', 1000.00, 1000.00, 1.00, 0.00, '', 152, 0, 0, 0, 0, NULL),
('Mandible P-A/LAT', 'X-Ray', 0, 'XR012', '', 550.00, 550.00, 1.00, 0.00, '', 153, 0, 0, 0, 0, NULL),
('Mandible Bilateral', 'X-Ray', 0, 'XR01', '', 1000.00, 1000.00, 1.00, 0.00, '', 154, 0, 0, 0, 0, NULL),
('Cervical Spine Ap/Lateral/Oblique/open Mouth/Flexion', 'X-Ray', 0, 'XR013', '', 550.00, 550.00, 1.00, 0.00, '', 155, 0, 0, 0, 0, NULL),
('Thoracic Spine AP/LAT/Thoraco-Lumbar AP/Lat', 'X-Ray', 0, 'XR014', '', 550.00, 550.00, 1.00, 0.00, '', 156, 0, 0, 0, 0, NULL),
('Thoracic Spine Myelogram', 'X-Ray', 0, 'XR015', '', 2000.00, 2000.00, 1.00, 0.00, '', 157, 0, 0, 0, 0, NULL),
('Lumbar Spine AP/LAT', 'X-Ray', 0, 'XR016', '', 550.00, 550.00, 1.00, 0.00, '', 158, 0, 0, 0, 0, NULL),
('Thoraco-Lumbar AP/LAT', 'X-Ray', 0, 'XR017', '', 550.00, 550.00, 1.00, 0.00, '', 159, 0, 0, 0, 0, NULL),
('Myelogram', 'X-Ray', 0, 'XR018', '', 2000.00, 2000.00, 1.00, 0.00, '', 160, 0, 0, 0, 0, NULL),
('Pelvis AP', 'X-Ray', 0, 'XR019', '', 550.00, 550.00, 1.00, 0.00, '', 161, 0, 0, 0, 0, NULL),
('Hips AP', 'X-Ray', 0, 'XR020', '', 550.00, 550.00, 1.00, 0.00, '', 162, 0, 0, 0, 0, NULL),
('Lateral(Bilateral)', 'X-Ray', 0, 'XR021', '', 1000.00, 1000.00, 1.00, 0.00, '', 163, 0, 0, 0, 0, NULL),
('Urethrograms Micturating/Ascending', 'X-Ray', 0, 'XR022', '', 2000.00, 2000.00, 1.00, 0.00, '', 164, 0, 0, 0, 0, NULL),
('Femur AP/LAT', 'X-Ray', 0, 'XR023', '', 450.00, 450.00, 1.00, 0.00, '', 165, 0, 0, 0, 0, NULL),
('Femur Bilateral', 'X-Ray', 0, 'XR024', '', 800.00, 800.00, 1.00, 0.00, '', 166, 0, 0, 0, 0, NULL),
('Femur Venogram', 'X-Ray', 0, 'XR025', '', 2000.00, 2000.00, 1.00, 0.00, '', 167, 0, 0, 0, 0, NULL),
('Femur Arteriogram', 'X-Ray', 0, 'XR026', '', 2000.00, 2000.00, 1.00, 0.00, '', 168, 0, 0, 0, 0, NULL),
('Knee Joint AP/LAT/Patella/Skyline', 'X-Ray', 0, 'XR027', '', 450.00, 450.00, 1.00, 0.00, '', 169, 0, 0, 0, 0, NULL),
('Knee Joint Bilateral', 'X-Ray', 0, 'XR028', '', 800.00, 800.00, 1.00, 0.00, '', 170, 0, 0, 0, 0, NULL),
('Knee Joint Arterioram', 'X-Ray', 0, 'XR029', '', 2000.00, 2000.00, 1.00, 0.00, '', 171, 0, 0, 0, 0, NULL),
('Tibia-Fibular AP/LAT', 'X-Ray', 0, 'XR030', '', 450.00, 450.00, 1.00, 0.00, '', 172, 0, 0, 0, 0, NULL),
('Tibia-Fibular Bilateral', 'X-Ray', 0, 'XR031', '', 900.00, 900.00, 1.00, 0.00, '', 173, 0, 0, 0, 0, NULL),
('Tibia-Fibular Arteriogram', 'X-Ray', 0, 'XR032', '', 2000.00, 2000.00, 1.00, 0.00, '', 174, 0, 0, 0, 0, NULL),
('Tibia-Fibular Venogram', 'X-Ray', 0, 'XR033', '', 2000.00, 2000.00, 1.00, 0.00, '', 175, 0, 0, 0, 0, NULL),
('Ankle AP/LAT', 'X-Ray', 0, 'XR034', '', 450.00, 450.00, 1.00, 0.00, '', 176, 0, 0, 0, 0, NULL),
('Ankle Bilateral', 'X-Ray', 0, 'XR035', '', 800.00, 800.00, 1.00, 0.00, '', 177, 0, 0, 0, 0, NULL),
('Abdomen Plain', 'X-Ray', NULL, 'XR036', '', 450.00, 450.00, 1.00, 0.00, '', 178, 0, 0, 0, 0, NULL),
('Abdomen Double Contrast', 'X-Ray', NULL, 'XR037', '', 550.00, 550.00, 1.00, 0.00, '', 179, 0, 0, 0, 0, NULL),
('Abdomen Erect Dorsal Decubitus', 'X-Ray', NULL, 'XR038', '', 550.00, 550.00, 1.00, 0.00, '', 180, 0, 0, 0, 0, NULL),
('Barium Swallow', 'X-Ray', 0, 'XR039', '', 1500.00, 1500.00, 1.00, 0.00, '', 181, 0, 0, 0, 0, NULL),
('Barium Meal', 'X-Ray', 0, 'XR040', '', 1500.00, 1500.00, 1.00, 0.00, '', 182, 0, 0, 0, 0, NULL),
('Barium Follow Through', 'X-Ray', 0, 'XR041', '', 2000.00, 2000.00, 1.00, 0.00, '', 183, 0, 0, 0, 0, NULL),
('Barium Enema', 'X-Ray', 0, 'XR042', '', 2000.00, 2000.00, 1.00, 0.00, '', 184, 0, 0, 0, 0, NULL),
('Foot Ap/Oblique/LAT', 'X-Ray', 0, 'XR043', '', 450.00, 450.00, 1.00, 0.00, '', 185, 0, 0, 0, 0, NULL),
('Foot Bilateral', 'X-Ray', 0, 'XR044', '', 800.00, 800.00, 1.00, 0.00, '', 186, 0, 0, 0, 0, NULL),
('Clavicle AP', 'X-Ray', 0, 'XR045', '', 450.00, 450.00, 1.00, 0.00, '', 187, 0, 0, 0, 0, NULL),
('Clavicle Bilateral ', 'X-Ray', 0, 'XR046', '', 800.00, 800.00, 1.00, 0.00, '', 188, 0, 0, 0, 0, NULL),
('Scapula AP/LAT', 'X-Ray', 0, 'XR047', '', 450.00, 450.00, 1.00, 0.00, '', 189, 0, 0, 0, 0, NULL),
('Scapula Bilateral', 'X-Ray', 0, 'XR048', '', 800.00, 800.00, 1.00, 0.00, '', 190, 0, 0, 0, 0, NULL),
('Humerus AP/LAT', 'X-Ray', 0, 'XR049', '', 450.00, 450.00, 1.00, 0.00, '', 191, 0, 0, 0, 0, NULL),
('Humerus Bilateral', 'X-Ray', 0, 'XR050', '', 800.00, 800.00, 1.00, 0.00, '', 192, 0, 0, 0, 0, NULL),
('Shoulder Joint AP/LAT/Axial', 'X-Ray', 0, 'XR051', '', 450.00, 450.00, 1.00, 0.00, '', 193, 0, 0, 0, 0, NULL),
('Shoulder Joint Bilateral', 'X-Ray', 0, 'XR052', '', 800.00, 800.00, 1.00, 0.00, '', 194, 0, 0, 0, 0, NULL),
('Elbow Joint AP/LAT', 'X-Ray', 0, 'XR053', '', 450.00, 450.00, 1.00, 0.00, '', 195, 0, 0, 0, 0, NULL),
('Elbow Joint Bilateral', 'X-Ray', 0, 'XR054', '', 800.00, 800.00, 1.00, 0.00, '', 196, 0, 0, 0, 0, NULL),
('Radius-Ulna AP/LAT', 'X-Ray', 0, 'XR055', '', 450.00, 450.00, 1.00, 0.00, '', 197, 0, 0, 0, 0, NULL),
('Radius-Ulna Radio-Ulna Joint', 'X-Ray', 0, 'XR056', '', 450.00, 450.00, 1.00, 0.00, '', 198, 0, 0, 0, 0, NULL),
('Wrist Joint AP/LAT', 'X-Ray', 0, 'XR057', '', 450.00, 450.00, 1.00, 0.00, '', 199, 0, 0, 0, 0, NULL),
('Wrist Joint Bilateral', 'X-Ray', 0, 'XR058', '', 800.00, 800.00, 1.00, 0.00, '', 200, 0, 0, 0, 0, NULL),
('Chest PA/AP/Oblique', 'X-Ray', 0, 'XR059', '', 450.00, 450.00, 1.00, 0.00, '', 201, 0, 0, 0, 0, NULL),
('Chest PA & Oblique', 'X-Ray', 0, 'XR060', '', 800.00, 800.00, 1.00, 0.00, '', 202, 0, 0, 0, 0, NULL),
('Chest Sternum AP/LAT', 'X-Ray', 0, 'XR061', '', 450.00, 450.00, 1.00, 0.00, '', 203, 0, 0, 0, 0, NULL),
('Chest Thoracic Inlet', 'X-Ray', 0, 'XR062', '', 450.00, 450.00, 1.00, 0.00, '', 204, 0, 0, 0, 0, NULL),
('Chest Lordotic View', 'X-Ray', 0, 'XR063', '', 450.00, 450.00, 1.00, 0.00, '', 205, 0, 0, 0, 0, NULL),
('Hand AP/LAT/Oblique', 'X-Ray', 0, 'XR064', '', 450.00, 450.00, 1.00, 0.00, '', 206, 0, 0, 0, 0, NULL),
('Hand Bilateral', 'X-Ray', 0, 'XR065', '', 800.00, 800.00, 1.00, 0.00, '', 207, 0, 0, 0, 0, NULL),
('Ultra Sound Examination', 'X-Ray', 0, 'XR066', '', 1500.00, 1500.00, 1.00, 0.00, '', 208, 0, 0, 0, 0, NULL),
('Sacrum & Coccyx AP/LAT', 'X-Ray', 0, 'XR067', '', 550.00, 550.00, 1.00, 0.00, '', 209, 0, 0, 0, 0, NULL),
('Sacro-Illiac Joint AP/Oblique', 'X-Ray', 0, 'XR068', '', 550.00, 550.00, 1.00, 0.00, '', 210, 0, 0, 0, 0, NULL),
('Sacro-Illiac Joint Bilateral', 'X-Ray', 0, 'XR069', '', 1000.00, 1000.00, 1.00, 0.00, '', 211, 0, 0, 0, 0, NULL),
('Dental Intra Oral Peri-apical', 'X-Ray', 0, 'XR070', '', 200.00, 200.00, 1.00, 0.00, '', 212, 0, 0, 0, 0, NULL),
('Dental Occlusals', 'X-Ray', 0, 'XR071', '', 300.00, 300.00, 1.00, 0.00, '', 213, 0, 0, 0, 0, NULL),
('Dental Bitewings', 'X-Ray', 0, 'XR072', '', 200.00, 200.00, 1.00, 0.00, '', 214, 0, 0, 0, 0, NULL),
('Blood Slide for Malaria', 'Lab', 0, 'LAB001', '', 100.00, 100.00, 1.00, 0.00, '', 215, 0, 0, 0, 0, NULL),
('Stool for O/C/Trophozoites', 'Lab', 0, 'LAB002', '', 100.00, 100.00, 1.00, 0.00, '', 216, 0, 0, 0, 0, NULL),
('Sputum for AAFB', 'Lab', 0, 'LAB003', '', 0.00, 0.00, 1.00, 0.00, '', 217, 0, 0, 0, 0, NULL),
('Culture & Sensitivity for any specimen', 'Lab', 0, 'LAB004', '', 400.00, 400.00, 1.00, 0.00, '', 218, 0, 0, 0, 0, NULL),
('Wet Preparations', 'Lab', 0, 'LAB005', '', 100.00, 100.00, 1.00, 0.00, '', 219, 0, 0, 0, 0, NULL),
('Gram Staining', 'Lab', 0, 'LAB006', '', 200.00, 200.00, 1.00, 0.00, '', 220, 0, 0, 0, 0, NULL),
('Syphilis Test', 'Lab', 0, 'LAB007', '', 200.00, 200.00, 1.00, 0.00, '', 221, 0, 0, 0, 0, NULL),
('ASOT', 'Lab', NULL, 'LAB008', '', 200.00, 200.00, 1.00, 0.00, '', 222, 0, 0, 0, 0, NULL),
('Widal Test', 'Lab', 0, 'LAB009', '', 200.00, 200.00, 1.00, 0.00, '', 223, 0, 0, 0, 0, NULL),
('Brucella', 'Lab', 0, 'LAB010', '', 200.00, 200.00, 1.00, 0.00, '', 224, 0, 0, 0, 0, NULL),
('Rheumatoid Factor (RHF)', 'Lab', 0, 'LAB011', '', 200.00, 200.00, 1.00, 0.00, '', 225, 0, 0, 0, 0, NULL),
('Cryptococcal Antigen', 'Lab', 0, 'LAB012', '', 400.00, 400.00, 1.00, 0.00, '', 226, 0, 0, 0, 0, NULL),
('Helicobacter Pylory(H. Pylory)', 'Lab', 0, 'LAB013', '', 500.00, 500.00, 1.00, 0.00, '', 227, 0, 0, 0, 0, NULL),
('Hepatitis', 'Lab', 0, 'LAB014', '', 200.00, 200.00, 1.00, 0.00, '', 228, 0, 0, 0, 0, NULL),
('CD 4', 'Lab', 0, 'LAB015', '', 0.00, 0.00, 1.00, 0.00, '', 229, 0, 0, 0, 0, NULL),
('Viral Load', 'Lab', 0, 'LAB016', '', 4500.00, 4500.00, 1.00, 0.00, '', 230, 0, 0, 0, 0, NULL),
('HIV Screening Long Elisa', 'Lab', 0, 'LAB017', '', 400.00, 400.00, 1.00, 0.00, '', 231, 0, 0, 0, 0, NULL),
('UEC', 'Lab', 0, 'LAB018', '', 1000.00, 1000.00, 1.00, 0.00, '', 232, 0, 0, 0, 0, NULL),
('Blood Grouping', 'Lab', 0, 'LAB019', '', 150.00, 150.00, 1.00, 0.00, '', 233, 0, 0, 0, 0, NULL),
('Grouping & Cross Match', 'Lab', 0, 'LAB020', '', 400.00, 400.00, 1.00, 0.00, '', 234, 0, 0, 0, 0, NULL),
('Sickle cell Screening', 'Lab', 0, 'LAB021', '', 200.00, 200.00, 1.00, 0.00, '', 235, 0, 0, 0, 0, NULL),
('Reticulocyte Count', 'Lab', 0, 'LAB022', '', 200.00, 200.00, 1.00, 0.00, '', 236, 0, 0, 0, 0, NULL),
('WBC Count', 'Lab', 0, 'LAB023', '', 200.00, 200.00, 1.00, 0.00, '', 237, 0, 0, 0, 0, NULL),
('Full Haemogram & ESR', 'Lab', 0, 'LAB024', '', 400.00, 400.00, 1.00, 0.00, '', 238, 0, 0, 0, 0, NULL),
('HB', 'Lab', 0, 'LAB025', '', 100.00, 100.00, 1.00, 0.00, '', 239, 0, 0, 0, 0, NULL),
('ESR', 'Lab', 0, 'LAB026', '', 150.00, 150.00, 1.00, 0.00, '', 240, 0, 0, 0, 0, NULL),
('ANC Profile', 'Lab', NULL, 'LAB027', '', 600.00, 600.00, 1.00, 0.00, '', 241, 0, 0, 0, 0, NULL),
('Urinalysis/Microscopy', 'Lab', 0, 'LAB028', '', 100.00, 100.00, 1.00, 0.00, '', 242, 0, 0, 0, 0, NULL),
('Pregnancy Test', 'Lab', 0, 'LAB029', '', 200.00, 200.00, 1.00, 0.00, '', 243, 0, 0, 0, 0, NULL),
('Random/Fasting Blood Sugar', 'Lab', 0, 'LAB030', '', 100.00, 100.00, 1.00, 0.00, '', 244, 0, 0, 0, 0, NULL),
('OGTT', 'Lab', 0, 'LAB031', '', 500.00, 500.00, 1.00, 0.00, '', 245, 0, 0, 0, 0, NULL),
('Acid Phosphatase test', 'Lab', NULL, 'LAB032', '', 200.00, 200.00, 1.00, 0.00, '', 246, 0, 0, 0, 0, NULL),
('Calcium', 'Lab', 0, 'LAB033', '', 200.00, 200.00, 1.00, 0.00, '', 247, 0, 0, 0, 0, NULL),
('Uric Acid', 'Lab', 0, 'LAB034', '', 200.00, 200.00, 1.00, 0.00, '', 248, 0, 0, 0, 0, NULL),
('Bence Jones Protein', 'Lab', 0, 'LAB035', '', 300.00, 300.00, 1.00, 0.00, '', 249, 0, 0, 0, 0, NULL),
('Occult Blood', 'Lab', 0, 'LAB037', '', 200.00, 200.00, 1.00, 0.00, '', 250, 0, 0, 0, 0, NULL),
('C-Reactive Protein', 'Lab', 0, 'LAB038', '', 500.00, 500.00, 1.00, 0.00, '', 251, 0, 0, 0, 0, NULL),
('Urea', 'Lab', 0, 'LAB039', '', 200.00, 200.00, 1.00, 0.00, '', 252, 0, 0, 0, 0, NULL),
('Creatinine', 'Lab', 0, 'LAB040', '', 200.00, 200.00, 1.00, 0.00, '', 253, 0, 0, 0, 0, NULL),
('Sodium', 'Lab', 0, 'LAB041', '', 200.00, 200.00, 1.00, 0.00, '', 254, 0, 0, 0, 0, NULL),
('Potassium ', 'Lab', 0, 'LAB042', '', 200.00, 200.00, 1.00, 0.00, '', 255, 0, 0, 0, 0, NULL),
('Chloride', 'Lab', 0, 'LAB043', '', 200.00, 200.00, 1.00, 0.00, '', 256, 0, 0, 0, 0, NULL),
('Liver Function Test (LFTS)', 'Lab', 0, 'LAB044', '', 1000.00, 1000.00, 1.00, 0.00, '', 257, 0, 0, 0, 0, NULL),
('Serum Protein', 'Lab', 0, 'LAB045', '', 200.00, 200.00, 1.00, 0.00, '', 258, 0, 0, 0, 0, NULL),
('Direct & Total Bilirubin', 'Lab', 0, 'LAB046', '', 200.00, 200.00, 1.00, 0.00, '', 259, 0, 0, 0, 0, NULL),
('ALT (SGBT)', 'Lab', NULL, 'LAB047', '', 200.00, 200.00, 1.00, 0.00, '', 260, 0, 0, 0, 0, NULL),
('AST (SGOT)', 'Lab', NULL, 'LAB049', '', 200.00, 200.00, 1.00, 0.00, '', 261, 0, 0, 0, 0, NULL),
('Albumin', 'Lab', NULL, 'LAB050', '', 200.00, 200.00, 1.00, 0.00, '', 262, 0, 0, 0, 0, NULL),
('Alkaline Phosphatase', 'Lab', NULL, 'LAB051', '', 200.00, 200.00, 1.00, 0.00, '', 263, 0, 0, 0, 0, NULL),
('Gamma GT', 'Lab', 0, 'LAB052', '', 200.00, 200.00, 1.00, 0.00, '', 264, 0, 0, 0, 0, NULL),
('Lipid Profile', 'Lab', 0, 'LAB053', '', 1000.00, 1000.00, 1.00, 0.00, '', 265, 0, 0, 0, 0, NULL),
('Total Cholesterol', 'Lab', 0, 'LAB054', '', 200.00, 200.00, 1.00, 0.00, '', 266, 0, 0, 0, 0, NULL),
('Triglycerides', 'Lab', 0, 'LAB055', '', 200.00, 200.00, 1.00, 0.00, '', 267, 0, 0, 0, 0, NULL),
('HDL', 'Lab', 0, 'LAB056', '', 200.00, 200.00, 1.00, 0.00, '', 268, 0, 0, 0, 0, NULL),
('LDL', 'Lab', 0, 'LAB057', '', 200.00, 200.00, 1.00, 0.00, '', 269, 0, 0, 0, 0, NULL),
('Amylase', 'Lab', NULL, 'LAB058', '', 200.00, 200.00, 1.00, 0.00, '', 270, 0, 0, 0, 0, NULL),
('Glucose', 'Lab', 0, 'LAB059', '', 200.00, 200.00, 1.00, 0.00, '', 271, 0, 0, 0, 0, NULL),
('CSF', 'Lab', 0, 'LAB060', '', 600.00, 600.00, 1.00, 0.00, '', 272, 0, 0, 0, 0, NULL),
('Blood Culture', 'Lab', 0, 'LAB061', '', 1000.00, 1000.00, 1.00, 0.00, '', 273, 0, 0, 0, 0, NULL),
('Enzyme Assay', 'Lab', 0, 'LAB062', '', 500.00, 500.00, 1.00, 0.00, '', 274, 0, 0, 0, 0, NULL),
('T3', 'Lab', 0, 'LAB063', '', 400.00, 400.00, 1.00, 0.00, '', 275, 0, 0, 0, 0, NULL),
('T4', 'Lab', 0, 'LAB064', '', 400.00, 400.00, 1.00, 0.00, '', 276, 0, 0, 0, 0, NULL),
('TSH', 'Lab', 0, 'LAB065', '', 400.00, 400.00, 1.00, 0.00, '', 277, 0, 0, 0, 0, NULL),
('PSA', 'Lab', 0, 'LAB066', '', 400.00, 400.00, 1.00, 0.00, '', 278, 0, 0, 0, 0, NULL),
('HCG', 'Lab', 0, 'LAB067', '', 400.00, 400.00, 1.00, 0.00, '', 279, 0, 0, 0, 0, NULL),
('Histology Investigations', 'Lab', 0, 'LAB068', '', 500.00, 500.00, 1.00, 0.00, '', 280, 0, 0, 0, 0, NULL),
('Cytology Investigations', 'Lab', 0, 'LAB069', '', 500.00, 500.00, 1.00, 0.00, '', 281, 0, 0, 0, 0, NULL),
('Immunology Investigations', 'Lab', 0, 'LAB070', '', 500.00, 500.00, 1.00, 0.00, '', 282, 0, 0, 0, 0, NULL),
('Direct Coombs & Indirect Coomb', 'Lab', 0, 'LAB071', '', 200.00, 200.00, 1.00, 0.00, '', 283, 0, 0, 0, 0, NULL),
('Bleeding Time', 'Lab', 0, 'LAB072', '', 500.00, 500.00, 1.00, 0.00, '', 284, 0, 0, 0, 0, NULL),
('Peripheral Blood Films (PBF)', 'Lab', 0, 'LAB073', '', 200.00, 200.00, 1.00, 0.00, '', 285, 0, 0, 0, 0, NULL),
('KOH Test', 'Lab', 0, 'LAB074', '', 100.00, 100.00, 1.00, 0.00, '', 286, 0, 0, 0, 0, NULL),
('Semen Analysis', 'Lab', 0, 'LAB076', '', 500.00, 500.00, 1.00, 0.00, '', 287, 0, 0, 0, 0, NULL),
('Assisted Feed', 'HS', 0, 'NURS001', '', 40.00, 40.00, 1.00, 0.00, '', 288, 0, 0, 0, 0, NULL),
('Nasogastric Tube Fixing (NGT)', 'HS', 0, 'NURS002', '', 40.00, 40.00, 1.00, 0.00, '', 289, 0, 0, 0, 0, NULL),
('Nasogastric Tube Feeding (NGT)', 'HS', 0, 'NURS003', '', 100.00, 100.00, 1.00, 0.00, '', 290, 0, 0, 0, 0, NULL),
('Nasogastric Sunctioning', 'HS', 0, 'NURS004', '', 100.00, 100.00, 1.00, 0.00, '', 291, 0, 0, 0, 0, NULL),
('Tracheostomy Care', 'HS', 0, 'NURS005', '', 100.00, 100.00, 1.00, 0.00, '', 292, 0, 0, 0, 0, NULL),
('Gastrostomy Tube Feed', 'HS', 0, 'NURS006', '', 100.00, 100.00, 1.00, 0.00, '', 293, 0, 0, 0, 0, NULL),
('Gastric (Stomach) wash out', 'HS', 0, 'NURS007', '', 300.00, 300.00, 1.00, 0.00, '', 294, 0, 0, 0, 0, NULL),
('Fixing Foleys Catheter', 'HS', 0, 'NURS008', '', 100.00, 100.00, 1.00, 0.00, '', 295, 0, 0, 0, 0, NULL),
('Fixing a Condom Catheter', 'HS', 0, 'NURS009', '', 50.00, 50.00, 1.00, 0.00, '', 296, 0, 0, 0, 0, NULL),
('Wound Dressing', 'HS', 0, 'NURS010', '', 150.00, 150.00, 1.00, 0.00, '', 297, 0, 0, 0, 0, NULL),
('Wound Dressing (Minor Theatre)', 'HS', 0, 'NURS011', '', 500.00, 500.00, 1.00, 0.00, '', 298, 0, 0, 0, 0, NULL),
('Dressing of Burns (Ward)', 'HS', 0, 'NURS012', '', 200.00, 200.00, 1.00, 0.00, '', 299, 0, 0, 0, 0, NULL),
('Endotracheal Tube Sunctioning', 'HS', 0, 'NURS013', '', 150.00, 150.00, 1.00, 0.00, '', 300, 0, 0, 0, 0, NULL),
('Blood Transfusion Service', 'HS', 0, 'NURS014', '', 100.00, 100.00, 1.00, 0.00, '', 301, 0, 0, 0, 0, NULL),
('Removal of Stitches/Staples/Clips', 'HS', 0, 'NURS015', '', 100.00, 100.00, 1.00, 0.00, '', 302, 0, 0, 0, 0, NULL),
('Nebulization', 'HS', 0, 'NURS016', '', 300.00, 300.00, 1.00, 0.00, '', 303, 0, 0, 0, 0, NULL),
('Injection', 'HS', 0, 'NURS017', '', 50.00, 50.00, 1.00, 0.00, '', 304, 0, 0, 0, 0, NULL),
('Incision and Drainage', 'HS', 0, 'NURS018', '', 500.00, 500.00, 1.00, 0.00, '', 305, 0, 0, 0, 0, NULL),
('Circumcission', 'HS', 0, 'NURS019', '', 2000.00, 2000.00, 1.00, 0.00, '', 306, 0, 0, 0, 0, NULL),
('Enema', 'HS', 0, 'NURS020', '', 100.00, 100.00, 1.00, 0.00, '', 307, 0, 0, 0, 0, NULL),
('Bed Bath', 'HS', 0, 'NURS021', '', 100.00, 100.00, 1.00, 0.00, '', 308, 0, 0, 0, 0, NULL),
('Assisted Bed Bath', 'HS', 0, 'NURS022', '', 50.00, 50.00, 1.00, 0.00, '', 309, 0, 0, 0, 0, NULL),
('Daily Bed Charges', 'HS', 0, 'NURS023', '', 300.00, 300.00, 1.00, 0.00, '', 310, 0, 0, 0, 0, NULL),
('Lumbar Puncture', 'HS', 0, 'NURS024', '', 200.00, 200.00, 1.00, 0.00, '', 311, 0, 0, 0, 0, NULL),
('Last Offices (in the ward)', 'HS', 0, 'NURS025', '', 100.00, 100.00, 1.00, 0.00, '', 312, 0, 0, 0, 0, NULL),
('Mouth Toilet', 'HS', 0, 'NURS026', '', 40.00, 40.00, 1.00, 0.00, '', 313, 0, 0, 0, 0, NULL),
('Shaving', 'HS', 0, 'NURS027', '', 40.00, 40.00, 1.00, 0.00, '', 314, 0, 0, 0, 0, NULL),
('Gastric Lavage', 'HS', 0, 'NURS028', '', 200.00, 200.00, 1.00, 0.00, '', 315, 0, 0, 0, 0, NULL),
('Skin Care', 'HS', 0, 'NURS029', '', 100.00, 100.00, 1.00, 0.00, '', 316, 0, 0, 0, 0, NULL),
('Resuscitation', 'HS', 0, 'NURS030', '', 200.00, 200.00, 1.00, 0.00, '', 317, 0, 0, 0, 0, NULL),
('Vulva Toilet', 'HS', 0, 'NURS031', '', 100.00, 100.00, 1.00, 0.00, '', 318, 0, 0, 0, 0, NULL),
('Stitching (in minor theatre)', 'HS', 0, 'NURS032', '', 500.00, 500.00, 1.00, 0.00, '', 319, 0, 0, 0, 0, NULL),
('Bags, Colostomy', 'HS', 0, 'NURS033', '', 500.00, 500.00, 1.00, 0.00, '', 320, 0, 0, 0, 0, NULL),
('Blood Giving Sets', 'HS', 0, 'NURS034', '', 80.00, 80.00, 1.00, 0.00, '', 321, 0, 0, 0, 0, NULL),
('Catheter Folleys', 'HS', 0, 'NURS035', '', 70.00, 70.00, 1.00, 0.00, '', 322, 0, 0, 0, 0, NULL),
('Gynaecological Gloves  ', 'HS', 0, 'NURS036', '', 50.00, 50.00, 1.00, 0.00, '', 323, 0, 0, 0, 0, NULL),
('Cord Clumps', 'HS', 0, 'NURS037', '', 10.00, 10.00, 1.00, 0.00, '', 324, 0, 0, 0, 0, NULL),
('Crepe Bandages', 'HS', 0, 'NURS038', '', 80.00, 80.00, 1.00, 0.00, '', 325, 0, 0, 0, 0, NULL),
('Examination Gloves(Disposable)', 'HS', 0, 'NURS039', '', 10.00, 10.00, 1.00, 0.00, '', 326, 0, 0, 0, 0, NULL),
('Surgeon Gloves', 'HS', 0, 'NURS040', '', 30.00, 30.00, 1.00, 0.00, '', 327, 0, 0, 0, 0, NULL),
('I.V. Cannulas', 'HS', 0, 'NURS041', '', 50.00, 50.00, 1.00, 0.00, '', 328, 0, 0, 0, 0, NULL),
('Identification Bands', 'HS', 0, 'NURS042', '', 10.00, 10.00, 1.00, 0.00, '', 329, 0, 0, 0, 0, NULL),
('Infusion Giving Sets', 'HS', 0, 'NURS043', '', 30.00, 30.00, 1.00, 0.00, '', 330, 0, 0, 0, 0, NULL),
('Insulin Syringe', 'HS', 0, 'NURS044', '', 10.00, 10.00, 1.00, 0.00, '', 331, 0, 0, 0, 0, NULL),
('Intercostal Drainage Tubes', 'HS', 0, 'NURS046', '', 80.00, 80.00, 1.00, 0.00, '', 332, 0, 0, 0, 0, NULL),
('Syringe (50cc,60cc)', 'HS', 0, 'NURS047', '', 80.00, 80.00, 1.00, 0.00, '', 333, 0, 0, 0, 0, NULL),
('Nasogastric Feeding Tubes', 'HS', 0, 'NURS048', '', 20.00, 20.00, 1.00, 0.00, '', 334, 0, 0, 0, 0, NULL),
('Plaster of Paris', 'HS', 0, 'NURS049', '', 250.00, 250.00, 1.00, 0.00, '', 335, 0, 0, 0, 0, NULL),
('Solusets for Blood', 'HS', 0, 'NURS050', '', 250.00, 250.00, 1.00, 0.00, '', 336, 0, 0, 0, 0, NULL),
('Solusets for Fluids', 'HS', 0, 'NURS051', '', 150.00, 150.00, 1.00, 0.00, '', 337, 0, 0, 0, 0, NULL),
('Spinal Needle', 'HS', 0, 'NURS052', '', 70.00, 70.00, 1.00, 0.00, '', 338, 0, 0, 0, 0, NULL),
('Suction Catheter', 'HS', 0, 'NURS053', '', 50.00, 50.00, 1.00, 0.00, '', 339, 0, 0, 0, 0, NULL),
('Surgical Blades', 'HS', 0, 'NURS054', '', 10.00, 10.00, 1.00, 0.00, '', 340, 0, 0, 0, 0, NULL),
('Syringes with Needles (2cc,5cc,10cc,20cc)', 'HS', 0, 'NURS056', '', 10.00, 10.00, 1.00, 0.00, '', 341, 0, 0, 0, 0, NULL),
('Urine Bags', 'HS', 0, 'NURS057', '', 50.00, 50.00, 1.00, 0.00, '', 342, 0, 0, 0, 0, NULL),
('Sutures Vicryl', 'HS', 0, 'NURS058', '', 250.00, 250.00, 1.00, 0.00, '', 343, 0, 0, 0, 0, NULL),
('Sutures Nylon', 'HS', 0, 'NURS059', '', 50.00, 50.00, 1.00, 0.00, '', 344, 0, 0, 0, 0, NULL),
('Sutures Silk', 'HS', 0, 'NURS060', '', 50.00, 50.00, 1.00, 0.00, '', 345, 0, 0, 0, 0, NULL),
('Embalmment ', 'Mortuary', 0, 'MORT001', '', 1000.00, 1000.00, 1.00, 0.00, '', 346, 0, 0, 0, 0, NULL),
('Embalmment (BID)', 'Mortuary', 0, 'MORT002', '', 1500.00, 1500.00, 1.00, 0.00, '', 347, 0, 0, 0, 0, NULL),
('Embalmment (Under 5)', 'Mortuary', 0, 'MORT003', '', 500.00, 500.00, 1.00, 0.00, '', 348, 0, 0, 0, 0, NULL),
('Last Offices (Mortuary)', 'Mortuary', 0, 'MORT004', '', 6000.00, 6000.00, 1.00, 0.00, '', 349, 0, 0, 0, 0, NULL),
('Post Mortem', 'Mortuary', 0, 'MORT005', '', 1000.00, 1000.00, 1.00, 0.00, '', 350, 0, 0, 0, 0, NULL),
('Mortuary Charges (per day)', 'Mortuary', 0, 'MORT006', '', 500.00, 500.00, 1.00, 0.00, '', 351, 0, 0, 0, 0, NULL),
('Reduction of Dislocations', 'Orthopaedics', 0, 'ORTH001', '', 500.00, 500.00, 1.00, 0.00, '', 352, 0, 0, 0, 0, NULL),
('Full Length POP', 'Orthopaedics', 0, 'ORTH002', '', 2000.00, 2000.00, 1.00, 0.00, '', 353, 0, 0, 0, 0, NULL),
('Cylinder POP', 'Orthopaedics', 0, 'ORTH003', '', 2000.00, 2000.00, 1.00, 0.00, '', 354, 0, 0, 0, 0, NULL),
('Below Knee POP', 'Orthopaedics', 0, 'ORTH004', '', 1500.00, 1500.00, 1.00, 0.00, '', 355, 0, 0, 0, 0, NULL),
('Boot POP', 'Orthopaedics', 0, 'ORTH005', '', 1200.00, 1200.00, 1.00, 0.00, '', 356, 0, 0, 0, 0, NULL),
('Above Knee/Back Slab Above Knee POP', 'Orthopaedics', NULL, 'ORTH006', '', 1400.00, 1400.00, 1.00, 0.00, '', 357, 0, 0, 0, 0, NULL),
('Back Slab Below Knee POP', 'Orthopaedics', 0, 'ORTH007', '', 1200.00, 1200.00, 1.00, 0.00, '', 358, 0, 0, 0, 0, NULL),
('U/Slab POP', 'Orthopaedics', 0, 'ORTH008', '', 1150.00, 1150.00, 1.00, 0.00, '', 359, 0, 0, 0, 0, NULL),
('Above Elbow/Back Slab Above Elbow POP', 'Orthopaedics', NULL, 'ORTH009', '', 900.00, 900.00, 1.00, 0.00, '', 360, 0, 0, 0, 0, NULL),
('Scaphoid POP', 'Orthopaedics', 0, 'ORTH010', '', 800.00, 800.00, 1.00, 0.00, '', 361, 0, 0, 0, 0, NULL),
('Above Elbow POP', 'Orthopaedics', NULL, 'ORTH011', '', 1000.00, 1000.00, 1.00, 0.00, '', 362, 0, 0, 0, 0, NULL),
('Below Elbow POP', 'Orthopaedics', 0, 'ORTH012', '', 900.00, 900.00, 1.00, 0.00, '', 363, 0, 0, 0, 0, NULL),
('Orthopaedic Service Charge', 'Orthopaedics', 0, 'ORTH014', '', 300.00, 300.00, 1.00, 0.00, '', 364, 0, 0, 0, 0, NULL),
('Crepe Bandage Application', 'Orthopaedics', 0, 'ORTH015', '', 200.00, 200.00, 1.00, 0.00, '', 365, 0, 0, 0, 0, NULL),
('POP Removal', 'Orthopaedics', 0, 'ORTH016', '', 400.00, 400.00, 1.00, 0.00, '', 366, 0, 0, 0, 0, NULL),
('POP Removal (Under 5 years)', 'Orthopaedics', 0, 'ORTH017', '', 0.00, 0.00, 1.00, 0.00, '', 367, 0, 0, 0, 0, NULL),
('CTEV', 'Orthopaedics', 0, 'ORTH018', '', 150.00, 150.00, 1.00, 0.00, '', 368, 0, 0, 0, 0, NULL),
('Skin Traction', 'Orthopaedics', 0, 'ORTH019', '', 2000.00, 2000.00, 1.00, 0.00, '', 369, 0, 0, 0, 0, NULL),
('Skeletal Traction', 'Orthopaedics', 0, 'ORTH020', '', 4000.00, 4000.00, 1.00, 0.00, '', 370, 0, 0, 0, 0, NULL),
('Arm Sling Application', 'Orthopaedics', 0, 'ORTH021', '', 150.00, 150.00, 1.00, 0.00, '', 371, 0, 0, 0, 0, NULL),
('Knee Support', 'Orthopaedics', 0, 'ORTH022', '', 800.00, 800.00, 1.00, 0.00, '', 372, 0, 0, 0, 0, NULL),
('Ankle Support', 'Orthopaedics', 0, 'ORTH023', '', 800.00, 800.00, 1.00, 0.00, '', 373, 0, 0, 0, 0, NULL),
('Wrist Support', 'Orthopaedics', 0, 'ORTH024', '', 800.00, 800.00, 1.00, 0.00, '', 374, 0, 0, 0, 0, NULL),
('Skeletal Traction Removal', 'Orthopaedics', 0, 'ORTH025', '', 500.00, 500.00, 1.00, 0.00, '', 375, 0, 0, 0, 0, NULL),
('Skin Traction Removal', 'Orthopaedics', 0, 'ORTH026', '', 300.00, 300.00, 1.00, 0.00, '', 376, 0, 0, 0, 0, NULL),
('POP Reinforcement ', 'Orthopaedics', 0, 'ORTH027', '', 300.00, 300.00, 1.00, 0.00, '', 377, 0, 0, 0, 0, NULL),
('Occupational Therapy (Under 5 1st Visit)', 'HS', 0, 'OCT001', '', 100.00, 100.00, 1.00, 0.00, '', 378, 0, 0, 0, 0, NULL),
('Sensory Stimulation-Stroking,Happing/Rubbing,Massage', 'HS', 0, 'OCT002', '', 150.00, 150.00, 1.00, 0.00, '', 379, 0, 0, 0, 0, NULL),
('Therapeutic Activities', 'HS', 0, 'OCT003', '', 150.00, 150.00, 1.00, 0.00, '', 380, 0, 0, 0, 0, NULL),
('Training in Delayed Developmental Milestones', 'HS', 0, 'OCT004', '', 50.00, 50.00, 1.00, 0.00, '', 381, 0, 0, 0, 0, NULL),
('Training in ADLS', 'HS', 0, 'OCT005', '', 150.00, 150.00, 1.00, 0.00, '', 382, 0, 0, 0, 0, NULL),
('Correction of CTEV (POP)', 'HS', 0, 'OCT006', '', 150.00, 150.00, 1.00, 0.00, '', 383, 0, 0, 0, 0, NULL),
('Orthoplast (Dynamic)', 'HS', 0, 'OCT007', '', 2500.00, 2500.00, 1.00, 0.00, '', 384, 0, 0, 0, 0, NULL),
('Orthoplast (Static)', 'HS', 0, 'OCT008', '', 2000.00, 2000.00, 1.00, 0.00, '', 385, 0, 0, 0, 0, NULL),
('POP', 'HS', 0, 'OCT009', '', 500.00, 500.00, 1.00, 0.00, '', 386, 0, 0, 0, 0, NULL),
('Calcaneal Spur Pads BIL(MCR)', 'Orthopaedics', 0, 'ORTH028', '', 1200.00, 1200.00, 1.00, 0.00, '', 387, 0, 0, 0, 0, NULL),
('Wedges BIL', 'Orthopaedics', 0, 'ORTH029', '', 1200.00, 1200.00, 1.00, 0.00, '', 388, 0, 0, 0, 0, NULL),
('Surgical Boot', 'Orthopaedics', 0, 'ORTH030', '', 1200.00, 1200.00, 1.00, 0.00, '', 389, 0, 0, 0, 0, NULL),
('Ankle Foot Orthosis (Metallic)', 'Orthopaedics', 0, 'ORTH031', '', 2000.00, 2000.00, 1.00, 0.00, '', 390, 0, 0, 0, 0, NULL),
('Ankle Foot Orthosis (Plastic)', 'Orthopaedics', 0, 'ORTH032', '', 1800.00, 1800.00, 1.00, 0.00, '', 391, 0, 0, 0, 0, NULL),
('Above Knee Brace (KAFO) without joint bill', 'Orthopaedics', NULL, 'ORTH033', '', 6000.00, 6000.00, 1.00, 0.00, '', 392, 0, 0, 0, 0, NULL),
('Above Knee Brace (KAFO) with joint bill', 'Orthopaedics', NULL, 'ORTH034', '', 12000.00, 12000.00, 1.00, 0.00, '', 393, 0, 0, 0, 0, NULL),
('Knee Cap', 'Orthopaedics', 0, 'ORTH035', '', 400.00, 400.00, 1.00, 0.00, '', 394, 0, 0, 0, 0, NULL),
('T-Strap', 'Orthopaedics', 0, 'ORTH036', '', 250.00, 250.00, 1.00, 0.00, '', 395, 0, 0, 0, 0, NULL),
('Stirrup', 'Orthopaedics', 0, 'ORTH037', '', 450.00, 450.00, 1.00, 0.00, '', 396, 0, 0, 0, 0, NULL),
('Axillary Crutches (Wooden)', 'Orthopaedics', 0, 'ORTH038', '', 1500.00, 1500.00, 1.00, 0.00, '', 397, 0, 0, 0, 0, NULL),
('Elbow Crutches (Wooden)', 'Orthopaedics', 0, 'ORTH039', '', 1500.00, 1500.00, 1.00, 0.00, '', 398, 0, 0, 0, 0, NULL),
('Cervical Collar (Rigid)', 'Orthopaedics', 0, 'ORTH040', '', 2000.00, 2000.00, 1.00, 0.00, '', 399, 0, 0, 0, 0, NULL),
('Cervical Collar (Soft)', 'Orthopaedics', 0, 'ORTH041', '', 600.00, 600.00, 1.00, 0.00, '', 400, 0, 0, 0, 0, NULL),
('Spinal Brace (Child)', 'Orthopaedics', 0, 'ORTH042', '', 6500.00, 6500.00, 1.00, 0.00, '', 401, 0, 0, 0, 0, NULL),
('Spinal Brace (Adult)', 'Orthopaedics', 0, 'ORTH043', '', 13000.00, 13000.00, 1.00, 0.00, '', 402, 0, 0, 0, 0, NULL),
('Spinal Cosert (Child)', 'Orthopaedics', 0, 'ORTH044', '', 2000.00, 2000.00, 1.00, 0.00, '', 403, 0, 0, 0, 0, NULL),
('Spinal Cosert (Adult)', 'Orthopaedics', 0, 'ORTH045', '', 3000.00, 3000.00, 1.00, 0.00, '', 404, 0, 0, 0, 0, NULL),
('Walking Cane', 'Orthopaedics', 0, 'ORTH046', '', 1000.00, 1000.00, 1.00, 0.00, '', 405, 0, 0, 0, 0, NULL),
('Adjustment/Repair(Orthopaedic)', 'Orthopaedics', NULL, 'ORTH047', '', 500.00, 500.00, 1.00, 0.00, '', 406, 0, 0, 0, 0, NULL),
('Shoe Raise (per inch)', 'Orthopaedics', 0, 'ORTH048', '', 600.00, 600.00, 1.00, 0.00, '', 407, 0, 0, 0, 0, NULL),
('Insole Bill', 'Orthopaedics', 0, 'ORTH049', '', 500.00, 500.00, 1.00, 0.00, '', 408, 0, 0, 0, 0, NULL),
('Arch Support (Mounded)', 'Orthopaedics', 0, 'ORTH050', '', 3000.00, 3000.00, 1.00, 0.00, '', 409, 0, 0, 0, 0, NULL),
('Sech Foot', 'Orthopaedics', 0, 'ORTH051', '', 7000.00, 7000.00, 1.00, 0.00, '', 410, 0, 0, 0, 0, NULL),
('BK Prosthesis', 'Orthopaedics', 0, 'ORTH052', '', 13000.00, 13000.00, 1.00, 0.00, '', 411, 0, 0, 0, 0, NULL),
('TK Prosthesis', 'Orthopaedics', 0, 'ORTH053', '', 15000.00, 15000.00, 1.00, 0.00, '', 412, 0, 0, 0, 0, NULL),
('A/K Prosthesis', 'Orthopaedics', NULL, 'ORTH054', '', 25000.00, 25000.00, 1.00, 0.00, '', 413, 0, 0, 0, 0, NULL),
('Suspension - Prosthetic', 'Orthopaedics', 0, 'ORTH055', '', 800.00, 800.00, 1.00, 0.00, '', 414, 0, 0, 0, 0, NULL),
('Stump Sock', 'Orthopaedics', 0, 'ORTH056', '', 1000.00, 1000.00, 1.00, 0.00, '', 415, 0, 0, 0, 0, NULL),
('Knee Joint Unit (Prosthesis)', 'Orthopaedics', 0, 'ORTH057', '', 16000.00, 16000.00, 1.00, 0.00, '', 416, 0, 0, 0, 0, NULL),
('Physiotherapy Session', 'Orthopaedics', 0, 'HS007', '', 200.00, 200.00, 1.00, 0.00, '', 417, 0, 0, 0, 0, NULL),
('Nutrition Session', 'HS', 0, 'HS008', '', 100.00, 100.00, 1.00, 0.00, '', 418, 0, 0, 0, 0, NULL),
('Public Health Consultation', 'HS', 0, 'HS009', '', 0.00, 0.00, 1.00, 0.00, '', 419, 0, 0, 0, 0, NULL),
('Food Handlers Certificate (Excluding Lab Tests)', 'HS', 0, 'HS010', '', 200.00, 200.00, 1.00, 0.00, '', 420, 0, 0, 0, 0, NULL),
('Medical Report/Form', 'HS', 0, 'HS011', '', 1000.00, 1000.00, 1.00, 0.00, '', 421, 0, 0, 0, 0, NULL),
('General Anaesthesia', 'Theatre', 0, 'THEATRE001', '', 1000.00, 1000.00, 1.00, 0.00, '', 422, 0, 0, 0, 0, NULL),
('Local Anaesthesia', 'Theatre', 0, 'THEATRE002', '', 500.00, 500.00, 1.00, 0.00, '', 423, 0, 0, 0, 0, NULL),
('Spinal Anaesthesia', 'Theatre', 0, 'THEATRE003', '', 500.00, 500.00, 1.00, 0.00, '', 424, 0, 0, 0, 0, NULL),
('Sedation/LA (Minor Theatre)', 'Theatre', 0, 'THEATRE004', '', 300.00, 300.00, 1.00, 0.00, '', 425, 0, 0, 0, 0, NULL),
('Nitrous Oxide (1 hour)', 'Theatre', 0, 'THEATRE005', '', 400.00, 400.00, 1.00, 0.00, '', 426, 0, 0, 0, 0, NULL),
('Nitrous Oxide (more than 1 hour)', 'Theatre', 0, 'THEATRE006', '', 600.00, 600.00, 1.00, 0.00, '', 427, 0, 0, 0, 0, NULL),
('Halothane (per hour)', 'Theatre', 0, 'THEATRE007', '', 100.00, 100.00, 1.00, 0.00, '', 428, 0, 0, 0, 0, NULL),
('Isoflurane (per hour)', 'Theatre', 0, 'THEATRE008', '', 400.00, 400.00, 1.00, 0.00, '', 429, 0, 0, 0, 0, NULL),
('Loop Procedures ', 'Theatre', 0, 'THEATRE009', '', 5000.00, 5000.00, 1.00, 0.00, '', 430, 0, 0, 0, 0, NULL),
('Laparatomy', 'Theatre', 0, 'THEATRE010', '', 5000.00, 5000.00, 1.00, 0.00, '', 431, 0, 0, 0, 0, NULL),
('Thyroidectomy', 'Theatre', 0, 'THEATRE011', '', 5000.00, 5000.00, 1.00, 0.00, '', 432, 0, 0, 0, 0, NULL),
('Prostatectomy', 'Theatre', 0, 'THEATRE012', '', 5000.00, 5000.00, 1.00, 0.00, '', 433, 0, 0, 0, 0, NULL),
('Mastectomy', 'Theatre', 0, 'THEATRE013', '', 5000.00, 5000.00, 1.00, 0.00, '', 434, 0, 0, 0, 0, NULL),
('ORIF', 'Theatre', 0, 'THEATRE014', '', 5000.00, 5000.00, 1.00, 0.00, '', 435, 0, 0, 0, 0, NULL),
('Amputation', 'Theatre', NULL, 'THEATRE015', '', 5000.00, 5000.00, 1.00, 0.00, '0', 436, 0, 0, 0, 0, NULL),
('Hernia Mesh Repair', 'Theatre', 0, 'THEATRE016', '', 5000.00, 5000.00, 1.00, 0.00, '', 437, 0, 0, 0, 0, NULL),
('Cleft Repair', 'Theatre', 0, 'THEATRE017', '', 5000.00, 5000.00, 1.00, 0.00, '', 438, 0, 0, 0, 0, NULL),
('Orchidopexy', 'Theatre', 0, 'THEATRE018', '', 5000.00, 5000.00, 1.00, 0.00, '', 439, 0, 0, 0, 0, NULL),
('Skin Grafting/Flaps', 'Theatre', 0, 'THEATRE019', '', 5000.00, 5000.00, 1.00, 0.00, '', 440, 0, 0, 0, 0, NULL),
('Herniorraphy (Under GA)', 'Theatre', 0, 'THEATRE020', '', 3000.00, 3000.00, 1.00, 0.00, '', 441, 0, 0, 0, 0, NULL),
('Herniorraphy (Under LA)', 'Theatre', 0, 'THEATRE021', '', 2000.00, 2000.00, 1.00, 0.00, '', 442, 0, 0, 0, 0, NULL),
('Herniotomy (Under GA)', 'Theatre', 0, 'THEATRE022', '', 3000.00, 3000.00, 1.00, 0.00, '', 443, 0, 0, 0, 0, NULL),
('Lumpectomy (Under GA)', 'Theatre', 0, 'THEATRE023', '', 3000.00, 3000.00, 1.00, 0.00, '', 444, 0, 0, 0, 0, NULL),
('Lumpectomy (Under LA)', 'Theatre', 0, 'THEATRE024', '', 2000.00, 2000.00, 1.00, 0.00, '', 445, 0, 0, 0, 0, NULL),
('Spincterotomy (Under GA)', 'Theatre', 0, 'THEATRE025', '', 3000.00, 3000.00, 1.00, 0.00, '', 446, 0, 0, 0, 0, NULL),
('Hemorroidectomy (Under GA)', 'Theatre', 0, 'THEATRE027', '', 3000.00, 3000.00, 1.00, 0.00, '', 447, 0, 0, 0, 0, NULL),
('Appendicectomy (Under GA)', 'Theatre', 0, 'THEATRE026', '', 3000.00, 3000.00, 1.00, 0.00, '', 448, 0, 0, 0, 0, NULL),
('Hydrocelectomy/ Scrotal Exploration (Under GA)', 'Theatre', 0, 'THEATRE028', '', 3000.00, 3000.00, 1.00, 0.00, '', 449, 0, 0, 0, 0, NULL),
('Hydrocelectomy/ Scrotal Exploration (Under LA)', 'Theatre', 0, 'THEATRE029', '', 2000.00, 2000.00, 1.00, 0.00, '', 450, 0, 0, 0, 0, NULL),
('Surgical Debridement(Under GA)', 'Theatre', 0, 'THEATRE030', '', 3000.00, 3000.00, 1.00, 0.00, '', 451, 0, 0, 0, 0, NULL),
('Excisions/Biopsy (Under GA)', 'Theatre', 0, 'THEATRE031', '', 3000.00, 3000.00, 1.00, 0.00, '', 452, 0, 0, 0, 0, NULL),
('Excisions/Biopsy (Under LA)', 'Theatre', 0, 'THEATRE032', '', 2000.00, 2000.00, 1.00, 0.00, '', 453, 0, 0, 0, 0, NULL),
('Eye Consultation(General)', 'Eye', 0, 'EYE001', '', 100.00, 100.00, 1.00, 0.00, '', 454, 0, 0, 0, 0, NULL),
('Eye Consultation(Consultant)', 'Eye', 0, 'EYE002', '', 300.00, 300.00, 1.00, 0.00, '', 455, 0, 0, 0, 0, NULL),
('Eye Consultation(Under 5)', 'Eye', 0, 'EYE003', '', 0.00, 0.00, 1.00, 0.00, '', 456, 0, 0, 0, 0, NULL),
('Conjunctival/Lid Growth Excision (LA)', 'Eye', 0, 'EYE004', '', 500.00, 500.00, 1.00, 0.00, '', 457, 0, 0, 0, 0, NULL),
('Conjunctival/Lid Growth Excision (GA)', 'Eye', 0, 'EYE005', '', 1500.00, 1500.00, 1.00, 0.00, '', 458, 0, 0, 0, 0, NULL),
('Conjunctival Flap (Under LA)', 'Eye', 0, 'EYE006', '', 500.00, 500.00, 1.00, 0.00, '', 459, 0, 0, 0, 0, NULL),
('Conjunctival Flap (Under GA)', 'Eye', 0, 'EYE007', '', 1500.00, 1500.00, 1.00, 0.00, '', 460, 0, 0, 0, 0, NULL),
('Tarsal Plate Rotation (LA)', 'Eye', 0, 'EYE008', '', 500.00, 500.00, 1.00, 0.00, '', 461, 0, 0, 0, 0, NULL),
('Tarsal Plate Rotation (GA)', 'Eye', 0, 'EYE009', '', 1500.00, 1500.00, 1.00, 0.00, '', 462, 0, 0, 0, 0, NULL),
('Foreign Body Removal (LA)', 'Eye', 0, 'EYE010', '', 300.00, 300.00, 1.00, 0.00, '', 463, 0, 0, 0, 0, NULL),
('Foreign Body Removal (GA)', 'Eye', 0, 'EYE011', '', 1500.00, 1500.00, 1.00, 0.00, '', 464, 0, 0, 0, 0, NULL),
('Stitching/Lid Repair (LA)', 'Eye', 0, 'EYE012', '', 500.00, 500.00, 1.00, 0.00, '', 465, 0, 0, 0, 0, NULL),
('Stitching/Lid Repair (GA)', 'Eye', 0, 'EYE013', '', 1500.00, 1500.00, 1.00, 0.00, '', 466, 0, 0, 0, 0, NULL),
('Eye Incision & Drainage (LA)', 'Eye', 0, 'EYE014', '', 500.00, 500.00, 1.00, 0.00, '', 467, 0, 0, 0, 0, NULL),
('Eye Incision & Drainage (GA)', 'Eye', 0, 'EYE015', '', 1500.00, 1500.00, 1.00, 0.00, '', 468, 0, 0, 0, 0, NULL),
('Eye Probing & Syringing (LA)', 'Eye', 0, 'EYE017', '', 500.00, 500.00, 1.00, 0.00, '', 469, 0, 0, 0, 0, NULL),
('Eye Probing & Syringing (GA)', 'Eye', 0, 'EYE018', '', 1500.00, 1500.00, 1.00, 0.00, '', 470, 0, 0, 0, 0, NULL),
('Eye Removal of Stitches (LA)', 'Eye', 0, 'EYE019', '', 100.00, 100.00, 1.00, 0.00, '', 471, 0, 0, 0, 0, NULL),
('Eye Removal of Stitches (GA)', 'Eye', 0, 'EYE020', '', 1000.00, 1000.00, 1.00, 0.00, '', 472, 0, 0, 0, 0, NULL),
('Eye Irrigation (LA)', 'Eye', 0, 'EYE021', '', 500.00, 500.00, 1.00, 0.00, '', 473, 0, 0, 0, 0, NULL),
('Eye Irrigation (GA)', 'Eye', 0, 'EYE022', '', 1000.00, 1000.00, 1.00, 0.00, '', 474, 0, 0, 0, 0, NULL),
('Eye Epilation (LA)', 'Eye', 0, 'EYE023', '', 300.00, 300.00, 1.00, 0.00, '', 475, 0, 0, 0, 0, NULL),
('Eye Epilation (GA)', 'Eye', 0, 'EYE024', '', 1000.00, 1000.00, 1.00, 0.00, '', 476, 0, 0, 0, 0, NULL),
('Eye Padding', 'Eye', 0, 'EYE025', '', 100.00, 100.00, 1.00, 0.00, '', 477, 0, 0, 0, 0, NULL),
('Eye Prothesis Insertion (LA)', 'Eye', 0, 'EYE026', '', 1000.00, 1000.00, 1.00, 0.00, '', 478, 0, 0, 0, 0, NULL),
('Eye Prothesis Insertion (GA)', 'Eye', 0, 'EYE027', '', 1500.00, 1500.00, 1.00, 0.00, '', 479, 0, 0, 0, 0, NULL),
('Occular Injection (LA)', 'Eye', 0, 'EYE028', '', 1000.00, 1000.00, 1.00, 0.00, '', 480, 0, 0, 0, 0, NULL),
('Occular Injection (GA)', 'Eye', 0, 'EYE029', '', 1500.00, 1500.00, 1.00, 0.00, '', 481, 0, 0, 0, 0, NULL),
('Subconjunctival Injection (LA)', 'Eye', 0, 'EYE030', '', 500.00, 500.00, 1.00, 0.00, '', 482, 0, 0, 0, 0, NULL),
('Subconjunctival Injection (GA)', 'Eye', 0, 'EYE031', '', 1000.00, 1000.00, 1.00, 0.00, '', 483, 0, 0, 0, 0, NULL);
INSERT INTO `mlkh_items` (`name`, `category`, `supplier_id`, `item_number`, `description`, `cost_price`, `unit_price`, `quantity`, `reorder_level`, `location`, `item_id`, `allow_alt_description`, `is_quantifiable`, `is_serialized`, `deleted`, `dosage`) VALUES
('Intravirtreal Injection (LA)', 'Eye', 0, 'EYE032', '', 1000.00, 1000.00, 1.00, 0.00, '', 484, 0, 0, 0, 0, NULL),
('Intravirtreal Injection (GA)', 'Eye', 0, 'EYE033', '', 1500.00, 1500.00, 1.00, 0.00, '', 485, 0, 0, 0, 0, NULL),
('Retrobulbar/Parabulbar Injection (LA)', 'Eye', 0, 'EYE034', '', 500.00, 500.00, 1.00, 0.00, '', 486, 0, 0, 0, 0, NULL),
('Retrobulbar/Parabulbar Injection (GA)', 'Eye', 0, 'EYE035', '', 1000.00, 1000.00, 1.00, 0.00, '', 487, 0, 0, 0, 0, NULL),
('Subtenon Injection (LA)', 'Eye', 0, 'EYE036', '', 500.00, 500.00, 1.00, 0.00, '', 488, 0, 0, 0, 0, NULL),
('Subtenon Injection (GA)', 'Eye', 0, 'EYE037', '', 1000.00, 1000.00, 1.00, 0.00, '', 489, 0, 0, 0, 0, NULL),
('Eye EUA (GA)', 'Eye', 0, 'EYE038', '', 3000.00, 3000.00, 1.00, 0.00, '', 490, 0, 0, 0, 0, NULL),
('Eye Exenteration (GA)', 'Eye', 0, 'EYE039', '', 3000.00, 3000.00, 1.00, 0.00, '', 491, 0, 0, 0, 0, NULL),
('Eye Orbitotomy (GA)', 'Eye', 0, 'EYE040', '', 5000.00, 5000.00, 1.00, 0.00, '', 492, 0, 0, 0, 0, NULL),
('Cataract Surgery (SICS)+IOL (LA)', 'Eye', 0, 'EYE041', '', 3000.00, 3000.00, 1.00, 0.00, '', 493, 0, 0, 0, 0, NULL),
('Cataract Surgery (SICS)+IOL (GA)', 'Eye', 0, 'EYE042', '', 5000.00, 5000.00, 1.00, 0.00, '', 494, 0, 0, 0, 0, NULL),
('Cataract Surgery (PHACO)+IOL (LA)', 'Eye', 0, 'EYE043', '', 25000.00, 25000.00, 1.00, 0.00, '', 495, 0, 0, 0, 0, NULL),
('Cataract Surgery (PHACO)+IOL (GA)', 'Eye', 0, 'EYE044', '', 23000.00, 23000.00, 1.00, 0.00, '', 496, 0, 0, 0, 0, NULL),
('Glaucoma Surgery (LA)', 'Eye', 0, 'EYE045', '', 1000.00, 1000.00, 1.00, 0.00, '', 497, 0, 0, 0, 0, NULL),
('Glaucoma Surgery (GA)', 'Eye', 0, 'EYE046', '', 3000.00, 3000.00, 1.00, 0.00, '', 498, 0, 0, 0, 0, NULL),
('Trabeculectomy (GA)', 'Eye', 0, 'EYE047', '', 3000.00, 3000.00, 1.00, 0.00, '', 499, 0, 0, 0, 0, NULL),
('Trabeculotomy(GA)', 'Eye', 0, 'EYE048', '', 3000.00, 3000.00, 1.00, 0.00, '', 500, 0, 0, 0, 0, NULL),
('Goniotomy (LA)', 'Eye', 0, 'EYE049', '', 3000.00, 3000.00, 1.00, 0.00, '', 501, 0, 0, 0, 0, NULL),
('Goniotomy (GA)', 'Eye', 0, 'EYE050', '', 5000.00, 5000.00, 1.00, 0.00, '', 502, 0, 0, 0, 0, NULL),
('Eye drainage Implants (GA)', 'Eye', 0, 'EYE051', '', 5000.00, 5000.00, 1.00, 0.00, '', 503, 0, 0, 0, 0, NULL),
('Corneal Repair (LA)', 'Eye', 0, 'EYE052', '', 1000.00, 1000.00, 1.00, 0.00, '', 504, 0, 0, 0, 0, NULL),
('Corneal Repair (GA)', 'Eye', 0, 'EYE053', '', 3000.00, 3000.00, 1.00, 0.00, '', 505, 0, 0, 0, 0, NULL),
('Eye Anterior Chamber washout (LA)', 'Eye', 0, 'EYE054', '', 1000.00, 1000.00, 1.00, 0.00, '', 506, 0, 0, 0, 0, NULL),
('Eye Anterior Chamber washout (GA)', 'Eye', 0, 'EYE055', '', 3000.00, 3000.00, 1.00, 0.00, '', 507, 0, 0, 0, 0, NULL),
('Lens washout without IOL (LA)', 'Eye', 0, 'EYE056', '', 1000.00, 1000.00, 1.00, 0.00, '', 508, 0, 0, 0, 0, NULL),
('Lens washout without IOL (GA)', 'Eye', 0, 'EYE057', '', 3000.00, 3000.00, 1.00, 0.00, '', 509, 0, 0, 0, 0, NULL),
('Lens washout with IOL (LA)', 'Eye', 0, 'EYE058', '', 3000.00, 3000.00, 1.00, 0.00, '', 510, 0, 0, 0, 0, NULL),
('Lens washout with IOL (GA)', 'Eye', 0, 'EYE059', '', 5000.00, 5000.00, 1.00, 0.00, '', 511, 0, 0, 0, 0, NULL),
('Pars Plana Capsulotomy (LA)', 'Eye', 0, 'EYE060', '', 1000.00, 1000.00, 1.00, 0.00, '', 512, 0, 0, 0, 0, NULL),
('Pars Plana Capsulotomy (GA)', 'Eye', 0, 'EYE061', '', 3000.00, 3000.00, 1.00, 0.00, '', 513, 0, 0, 0, 0, NULL),
('Enucleation (GA)', 'Eye', 0, 'EYE062', '', 3000.00, 3000.00, 1.00, 0.00, '', 514, 0, 0, 0, 0, NULL),
('Evisceration (LA)', 'Eye', 0, 'EYE063', '', 1000.00, 1000.00, 1.00, 0.00, '', 515, 0, 0, 0, 0, NULL),
('Evisceration (GA)', 'Eye', 0, 'EYE064', '', 3000.00, 3000.00, 1.00, 0.00, '', 516, 0, 0, 0, 0, NULL),
('DCR (LA)', 'Eye', 0, 'EYE065', '', 3000.00, 3000.00, 1.00, 0.00, '', 517, 0, 0, 0, 0, NULL),
('DCR (GA)', 'Eye', 0, 'EYE066', '', 5000.00, 5000.00, 1.00, 0.00, '', 518, 0, 0, 0, 0, NULL),
('Ptosis Surgery (LA)', 'Eye', 0, 'EYE067', '', 3000.00, 3000.00, 1.00, 0.00, '', 519, 0, 0, 0, 0, NULL),
('Ptosis Surgery (GA)', 'Eye', 0, 'EYE068', '', 5000.00, 5000.00, 1.00, 0.00, '', 520, 0, 0, 0, 0, NULL),
('Lid Surgery (LA)', 'Eye', 0, 'EYE069', '', 3000.00, 3000.00, 1.00, 0.00, '', 521, 0, 0, 0, 0, NULL),
('Lid Surgery (GA)', 'Eye', 0, 'EYE070', '', 5000.00, 5000.00, 1.00, 0.00, '', 522, 0, 0, 0, 0, NULL),
('Squint Surgery (LA)', 'Eye', 0, 'EYE071', '', 3000.00, 3000.00, 1.00, 0.00, '', 523, 0, 0, 0, 0, NULL),
('Squint Surgery (GA)', 'Eye', 0, 'EYE072', '', 5000.00, 5000.00, 1.00, 0.00, '', 524, 0, 0, 0, 0, NULL),
('Vitreoretinal Surgery (GA)', 'Eye', 0, 'EYE073', '', 5000.00, 5000.00, 1.00, 0.00, '', 525, 0, 0, 0, 0, NULL),
('Vitreoretinal Surgery with Sclera Buckie (GA)', 'Eye', 0, 'EYE074', '', 10000.00, 10000.00, 1.00, 0.00, '', 526, 0, 0, 0, 0, NULL),
('Eye Cryotherapy (LA)', 'Eye', 0, 'EYE075', '', 1000.00, 1000.00, 1.00, 0.00, '', 527, 0, 0, 0, 0, NULL),
('Eye Cryotherapy (GA)', 'Eye', 0, 'EYE076', '', 3000.00, 3000.00, 1.00, 0.00, '', 528, 0, 0, 0, 0, NULL),
('Humphreys Visual Field Analysis', 'Eye', 0, 'EYE077', '', 1000.00, 1000.00, 1.00, 0.00, '', 529, 0, 0, 0, 0, NULL),
('Ocular Photography', 'Eye', 0, 'EYE078', '', 1000.00, 1000.00, 1.00, 0.00, '', 530, 0, 0, 0, 0, NULL),
('Flouroscene Angiography (FLA)', 'Eye', 0, 'EYE079', '', 1000.00, 1000.00, 1.00, 0.00, '', 531, 0, 0, 0, 0, NULL),
('Optical Coherent Tomography', 'Eye', 0, 'EYE080', '', 2500.00, 2500.00, 1.00, 0.00, '', 532, 0, 0, 0, 0, NULL),
('Pachymetry', 'Eye', 0, 'EYE081', '', 1500.00, 1500.00, 1.00, 0.00, '', 533, 0, 0, 0, 0, NULL),
('Corneal Topography', 'Eye', 0, 'EYE082', '', 1500.00, 1500.00, 1.00, 0.00, '', 534, 0, 0, 0, 0, NULL),
('Biometry', 'Eye', 0, 'EYE083', '', 1000.00, 1000.00, 1.00, 0.00, '', 535, 0, 0, 0, 0, NULL),
('Ocular Ultrasound', 'Eye', 0, 'EYE084', '', 1000.00, 1000.00, 1.00, 0.00, '', 536, 0, 0, 0, 0, NULL),
('Spectacles (Glass on Budget Frames)', 'Eye', 0, 'EYE085', '', 2000.00, 2000.00, 1.00, 0.00, '', 537, 0, 0, 0, 0, NULL),
('Spectacles (Plastic on Budget Frame)', 'Eye', 0, 'EYE086', '', 3000.00, 3000.00, 1.00, 0.00, '', 538, 0, 0, 0, 0, NULL),
('Spectacles (Bifocal on Budget Frame)', 'Eye', 0, 'EYE087', '', 5000.00, 5000.00, 1.00, 0.00, '', 539, 0, 0, 0, 0, NULL),
('Spectacles (Progressive Lenses)', 'Eye', 0, 'EYE088', '', 10000.00, 10000.00, 1.00, 0.00, '', 540, 0, 0, 0, 0, NULL),
('Spectacles (Bandage Contact Lenses)', 'Eye', 0, 'EYE089', '', 2000.00, 2000.00, 1.00, 0.00, '', 541, 0, 0, 0, 0, NULL),
('Stand Magnifier', 'Eye', 0, 'EYE090', '', 2000.00, 2000.00, 1.00, 0.00, '', 542, 0, 0, 0, 0, NULL),
('Spectacle Magnifier', 'Eye', 0, 'EYE091', '', 1500.00, 1500.00, 1.00, 0.00, '', 543, 0, 0, 0, 0, NULL),
('Hand Held Magnifier', 'Eye', 0, 'EYE092', '', 1000.00, 1000.00, 1.00, 0.00, '', 544, 0, 0, 0, 0, NULL),
('Dome Magnifier', 'Eye', 0, 'EYE093', '', 1500.00, 1500.00, 1.00, 0.00, '', 545, 0, 0, 0, 0, NULL),
('Telescope', 'Eye', 0, 'EYE094', '', 2500.00, 2500.00, 1.00, 0.00, '', 546, 0, 0, 0, 0, NULL),
('Pharmacy', 'Pharmacy', 0, 'HS012', '', 0.00, 0.00, 1.00, 0.00, '', 547, 0, 0, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_items_taxes`
--

DROP TABLE IF EXISTS `mlkh_items_taxes`;
CREATE TABLE IF NOT EXISTS `mlkh_items_taxes` (
  `item_id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`item_id`,`name`,`percent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_item_kits`
--

DROP TABLE IF EXISTS `mlkh_item_kits`;
CREATE TABLE IF NOT EXISTS `mlkh_item_kits` (
  `item_kit_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`item_kit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_item_kit_items`
--

DROP TABLE IF EXISTS `mlkh_item_kit_items`;
CREATE TABLE IF NOT EXISTS `mlkh_item_kit_items` (
  `item_kit_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `quantity` double(15,2) NOT NULL,
  PRIMARY KEY (`item_kit_id`,`item_id`,`quantity`),
  KEY `mlkh_item_kit_items_ibfk_2` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_modules`
--

DROP TABLE IF EXISTS `mlkh_modules`;
CREATE TABLE IF NOT EXISTS `mlkh_modules` (
  `name_lang_key` varchar(255) NOT NULL,
  `desc_lang_key` varchar(255) NOT NULL,
  `sort` int(10) NOT NULL,
  `module_id` varchar(255) NOT NULL,
  PRIMARY KEY (`module_id`),
  UNIQUE KEY `desc_lang_key` (`desc_lang_key`),
  UNIQUE KEY `name_lang_key` (`name_lang_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mlkh_modules`
--

INSERT INTO `mlkh_modules` (`name_lang_key`, `desc_lang_key`, `sort`, `module_id`) VALUES
('module_admissions', 'module_admissions_desc', 10, 'admissions'),
('module_config', 'module_config_desc', 120, 'config'),
('module_customers', 'module_customers_desc', 70, 'customers'),
('module_dispense', 'module_dispense_desc', 20, 'dispense'),
('module_employees', 'module_employees_desc', 90, 'employees'),
('module_invoices', 'module_invoices_desc', 10, 'invoices'),
('module_items', 'module_items_desc', 50, 'items'),
('module_item_kits', 'module_item_kits_desc', 60, 'item_kits'),
('module_prescribe', 'module_prescribe_desc', 30, 'prescribe'),
('module_receivings', 'module_receivings_desc', 30, 'receivings'),
('module_reports', 'module_reports_desc', 100, 'reports'),
('module_sales', 'module_sales_desc', 20, 'sales'),
('module_suppliers', 'module_suppliers_desc', 80, 'suppliers'),
('module_waivers', 'module_waivers_desc', 45, 'waivers');

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_people`
--

DROP TABLE IF EXISTS `mlkh_people`;
CREATE TABLE IF NOT EXISTS `mlkh_people` (
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `civil_status` varchar(255) DEFAULT NULL,
  `blood_group` enum('A','B','AB','O') DEFAULT NULL,
  `national_id` varchar(255) DEFAULT NULL,
  `nhif` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address_1` varchar(255) NOT NULL,
  `address_2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `zip` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `comments` text NOT NULL,
  `person_id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `mlkh_people`
--

INSERT INTO `mlkh_people` (`first_name`, `middle_name`, `last_name`, `gender`, `civil_status`, `blood_group`, `national_id`, `nhif`, `phone_number`, `email`, `address_1`, `address_2`, `city`, `state`, `zip`, `country`, `comments`, `person_id`) VALUES
('John', '', 'Doe', 'male', '', '', '', '', '', '', '', '0', '', '0', '', '', '0', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_permissions`
--

DROP TABLE IF EXISTS `mlkh_permissions`;
CREATE TABLE IF NOT EXISTS `mlkh_permissions` (
  `module_id` varchar(255) NOT NULL,
  `person_id` int(10) NOT NULL,
  PRIMARY KEY (`module_id`,`person_id`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mlkh_permissions`
--

INSERT INTO `mlkh_permissions` (`module_id`, `person_id`) VALUES
('config', 1),
('customers', 1),
('dispense', 1),
('employees', 1),
('invoices', 1),
('items', 1),
('item_kits', 1),
('prescribe', 1),
('receivings', 1),
('reports', 1),
('sales', 1),
('waivers', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_receivings`
--

DROP TABLE IF EXISTS `mlkh_receivings`;
CREATE TABLE IF NOT EXISTS `mlkh_receivings` (
  `receiving_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `supplier_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `receiving_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`receiving_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_receivings_items`
--

DROP TABLE IF EXISTS `mlkh_receivings_items`;
CREATE TABLE IF NOT EXISTS `mlkh_receivings_items` (
  `receiving_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL,
  `quantity_purchased` int(10) NOT NULL DEFAULT '0',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`receiving_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales`
--

DROP TABLE IF EXISTS `mlkh_sales`;
CREATE TABLE IF NOT EXISTS `mlkh_sales` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_items`
--

DROP TABLE IF EXISTS `mlkh_sales_items`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_items_taxes`
--

DROP TABLE IF EXISTS `mlkh_sales_items_taxes`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_payments`
--

DROP TABLE IF EXISTS `mlkh_sales_payments`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_suspended`
--

DROP TABLE IF EXISTS `mlkh_sales_suspended`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_suspended` (
  `sale_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_id` int(10) DEFAULT NULL,
  `employee_id` int(10) NOT NULL DEFAULT '0',
  `comment` text NOT NULL,
  `sale_id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_suspended_items`
--

DROP TABLE IF EXISTS `mlkh_sales_suspended_items`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_suspended_items` (
  `sale_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL DEFAULT '0',
  `description` varchar(30) DEFAULT NULL,
  `serialnumber` varchar(30) DEFAULT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `quantity_purchased` double(15,2) NOT NULL DEFAULT '0.00',
  `item_cost_price` decimal(15,2) NOT NULL,
  `item_unit_price` double(15,2) NOT NULL,
  `discount_percent` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`sale_id`,`item_id`,`line`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_suspended_items_taxes`
--

DROP TABLE IF EXISTS `mlkh_sales_suspended_items_taxes`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_suspended_items_taxes` (
  `sale_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `line` int(3) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `percent` double(15,3) NOT NULL,
  PRIMARY KEY (`sale_id`,`item_id`,`line`,`name`,`percent`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sales_suspended_payments`
--

DROP TABLE IF EXISTS `mlkh_sales_suspended_payments`;
CREATE TABLE IF NOT EXISTS `mlkh_sales_suspended_payments` (
  `sale_id` int(10) NOT NULL,
  `payment_type` varchar(40) NOT NULL,
  `payment_amount` decimal(15,2) NOT NULL,
  PRIMARY KEY (`sale_id`,`payment_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_sessions`
--

DROP TABLE IF EXISTS `mlkh_sessions`;
CREATE TABLE IF NOT EXISTS `mlkh_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(16) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
-- --------------------------------------------------------

--
-- Table structure for table `mlkh_suppliers`
--

DROP TABLE IF EXISTS `mlkh_suppliers`;
CREATE TABLE IF NOT EXISTS `mlkh_suppliers` (
  `person_id` int(10) NOT NULL,
  `company_name` varchar(255) NOT NULL,
  `account_number` varchar(255) DEFAULT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  UNIQUE KEY `account_number` (`account_number`),
  KEY `person_id` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mlkh_waivers`
--

DROP TABLE IF EXISTS `mlkh_waivers`;
CREATE TABLE IF NOT EXISTS `mlkh_waivers` (
  `waiver_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `employee_id` int(11) NOT NULL,
  `serial` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `value` double(15,2) NOT NULL,
  `reason` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `waiver_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int(11) NOT NULL DEFAULT '0',
  `deleted` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`waiver_id`),
  UNIQUE KEY `serial` (`serial`),
  KEY `customer_id` (`customer_id`),
  KEY `employee_id` (`employee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;
-- --------------------------------------------------------

--
-- Structure for view `mlkh_customer_history`
--
DROP TABLE IF EXISTS `mlkh_customer_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mlkh_customer_history` AS select distinct `mlkh_sales`.`sale_time` AS `sale_time`,`mlkh_sales_items`.`quantity_purchased` AS `quantity_purchased`,`mlkh_items`.`name` AS `name`,`mlkh_people`.`first_name` AS `first_name`,`mlkh_people`.`last_name` AS `last_name` from (((((`mlkh_sales` join `mlkh_invoices`) join `mlkh_sales_items`) join `mlkh_customers`) join `mlkh_items`) join `mlkh_people`) where ((`mlkh_people`.`person_id` = `mlkh_customers`.`person_id`) and (`mlkh_sales`.`customer_id` = `mlkh_customers`.`person_id`) and (`mlkh_sales`.`sale_id` = `mlkh_sales_items`.`sale_id`) and (`mlkh_invoices`.`customer_id` = `mlkh_customers`.`person_id`) and (`mlkh_items`.`item_id` = `mlkh_sales_items`.`item_id`) and (`mlkh_invoices`.`processed` = 1));

-- --------------------------------------------------------

--
-- Structure for view `mlkh_history`
--
DROP TABLE IF EXISTS `mlkh_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mlkh_history` AS select distinct `mlkh_sales`.`customer_id` AS `customer_id`,`mlkh_sales`.`sale_time` AS `sale_time`,`mlkh_sales_items`.`quantity_purchased` AS `quantity_purchased`,`mlkh_items`.`name` AS `name`,`mlkh_people`.`first_name` AS `first_name`,`mlkh_people`.`last_name` AS `last_name` from (((((`mlkh_sales` join `mlkh_invoices`) join `mlkh_sales_items`) join `mlkh_customers`) join `mlkh_items`) join `mlkh_people`) where ((`mlkh_people`.`person_id` = `mlkh_customers`.`person_id`) and (`mlkh_sales`.`customer_id` = `mlkh_customers`.`person_id`) and (`mlkh_sales`.`sale_id` = `mlkh_sales_items`.`sale_id`) and (`mlkh_invoices`.`customer_id` = `mlkh_customers`.`person_id`) and (`mlkh_items`.`item_id` = `mlkh_sales_items`.`item_id`) and (`mlkh_invoices`.`processed` = 1));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `mlkh_collections`
--
ALTER TABLE `mlkh_collections`
  ADD CONSTRAINT `mlkh_collections_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_customers`
--
ALTER TABLE `mlkh_customers`
  ADD CONSTRAINT `mlkh_customers_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `mlkh_people` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlkh_employees`
--
ALTER TABLE `mlkh_employees`
  ADD CONSTRAINT `mlkh_employees_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `mlkh_people` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlkh_inventory`
--
ALTER TABLE `mlkh_inventory`
  ADD CONSTRAINT `mlkh_inventory_ibfk_5` FOREIGN KEY (`trans_items`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_inventory_ibfk_6` FOREIGN KEY (`trans_user`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_invoices`
--
ALTER TABLE `mlkh_invoices`
  ADD CONSTRAINT `mlkh_invoices_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `mlkh_customers` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_invoices_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_invoices_items`
--
ALTER TABLE `mlkh_invoices_items`
  ADD CONSTRAINT `mlkh_invoices_items_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `mlkh_invoices` (`invoice_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_invoices_items_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_items`
--
ALTER TABLE `mlkh_items`
  ADD CONSTRAINT `mlkh_items_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `mlkh_suppliers` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_items_taxes`
--
ALTER TABLE `mlkh_items_taxes`
  ADD CONSTRAINT `mlkh_items_taxes_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_item_kit_items`
--
ALTER TABLE `mlkh_item_kit_items`
  ADD CONSTRAINT `mlkh_item_kit_items_ibfk_3` FOREIGN KEY (`item_kit_id`) REFERENCES `mlkh_item_kits` (`item_kit_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_item_kit_items_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_permissions`
--
ALTER TABLE `mlkh_permissions`
  ADD CONSTRAINT `mlkh_permissions_ibfk_3` FOREIGN KEY (`module_id`) REFERENCES `mlkh_modules` (`module_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_permissions_ibfk_4` FOREIGN KEY (`person_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlkh_receivings`
--
ALTER TABLE `mlkh_receivings`
  ADD CONSTRAINT `mlkh_receivings_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `mlkh_suppliers` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_receivings_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_receivings_items`
--
ALTER TABLE `mlkh_receivings_items`
  ADD CONSTRAINT `mlkh_receivings_items_ibfk_3` FOREIGN KEY (`receiving_id`) REFERENCES `mlkh_receivings` (`receiving_id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_receivings_items_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales`
--
ALTER TABLE `mlkh_sales`
  ADD CONSTRAINT `mlkh_sales_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `mlkh_customers` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_sales_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_items`
--
ALTER TABLE `mlkh_sales_items`
  ADD CONSTRAINT `mlkh_sales_items_ibfk_3` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_sales_items_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_items_taxes`
--
ALTER TABLE `mlkh_sales_items_taxes`
  ADD CONSTRAINT `mlkh_sales_items_taxes_ibfk_3` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales_items` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_sales_items_taxes_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_payments`
--
ALTER TABLE `mlkh_sales_payments`
  ADD CONSTRAINT `mlkh_sales_payments_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlkh_sales_suspended`
--
ALTER TABLE `mlkh_sales_suspended`
  ADD CONSTRAINT `mlkh_sales_suspended_ibfk_3` FOREIGN KEY (`customer_id`) REFERENCES `mlkh_customers` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `mlkh_sales_suspended_ibfk_4` FOREIGN KEY (`employee_id`) REFERENCES `mlkh_employees` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_suspended_items`
--
ALTER TABLE `mlkh_sales_suspended_items`
  ADD CONSTRAINT `mlkh_sales_suspended_items_ibfk_3` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales_suspended` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_sales_suspended_items_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_suspended_items_taxes`
--
ALTER TABLE `mlkh_sales_suspended_items_taxes`
  ADD CONSTRAINT `mlkh_sales_suspended_items_taxes_ibfk_3` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales_suspended_items` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `mlkh_sales_suspended_items_taxes_ibfk_4` FOREIGN KEY (`item_id`) REFERENCES `mlkh_items` (`item_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `mlkh_sales_suspended_payments`
--
ALTER TABLE `mlkh_sales_suspended_payments`
  ADD CONSTRAINT `mlkh_sales_suspended_payments_ibfk_2` FOREIGN KEY (`sale_id`) REFERENCES `mlkh_sales_suspended` (`sale_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mlkh_suppliers`
--
ALTER TABLE `mlkh_suppliers`
  ADD CONSTRAINT `mlkh_suppliers_ibfk_2` FOREIGN KEY (`person_id`) REFERENCES `mlkh_people` (`person_id`) ON DELETE CASCADE ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
