-- phpMyAdmin SQL Dump
-- version 4.9.5deb2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 02, 2023 at 08:09 PM
-- Server version: 8.0.32-0ubuntu0.20.04.2
-- PHP Version: 7.4.3-4ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `baf_inspection_management_service`
--

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint UNSIGNED NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `demand_no` int NOT NULL,
  `date` date DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `item_name`, `demand_no`, `date`, `quantity`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(14, 'MODERN PAINTING BOOTH', 790, '2023-04-06', NULL, NULL, NULL, '2023-03-21 11:27:03', '2023-04-06 12:53:47'),
(15, 'CNC BORING MACHINE', 505, '2023-04-11', 10, NULL, NULL, '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(18, 'Binocular', 341, '2023-04-16', 250, NULL, NULL, '2023-04-16 14:21:13', '2023-04-16 14:42:30'),
(19, 'Auxiliary  Power Unit (small capacity)', 192, '2023-04-16', 2, NULL, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `item_specifications`
--

CREATE TABLE `item_specifications` (
  `id` bigint UNSIGNED NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `s_description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `s_specified` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_child` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `has_blank_row` tinyint DEFAULT '0',
  `blank_row_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_specifications`
--

INSERT INTO `item_specifications` (`id`, `item_id`, `parent_id`, `s_description`, `s_specified`, `has_child`, `has_blank_row`, `blank_row_text`, `created_at`, `updated_at`) VALUES
(611, 14, NULL, 'Name and complete address of local agent', 'Details to be mentioned', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(612, 14, NULL, 'Name and complete address of principal and manufacturer ', 'Details to be mentioned', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(613, 14, NULL, 'Year of production', 'Not before the year of contract ', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(614, 14, NULL, 'Brand ', 'To be mentioned', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(615, 14, NULL, 'Model ', 'To be mentioned', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(616, 14, NULL, 'Country of origin', 'Group A countries', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(617, 14, NULL, 'Country of Manufacturer ', 'Group A countries', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(618, 14, NULL, 'Country of Assembly ', 'Group A countries', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(619, 14, NULL, 'a. Wind speed and uniform wind flow facilities ', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(620, 14, NULL, 'b. The ceiling filter which determines the excellence of the painting booth is installed over the entire ceiling surface a uniform and soft wind flow', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(621, 14, NULL, 'c. The newly developed filter stopper makes in possible to replace the filter without holding a tool', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(622, 14, NULL, 'The control panel is a touch panel specification', 'a. All control functions except buzzer and internal pressure adjustment are built into the LCD touch panel.\nb. Adopting a color LCD touch panel makes visual confirmation easy and intuitive.', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(623, 14, NULL, 'Front large door with excellent visibility ', 'a. The emblem at the top of the front is also renewed and the new Zero Nano is a new face.\nb. A vertically long glass window with excellent visibility is used to achieve both function and design. An optional panic door is also available. ', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(624, 14, NULL, 'Ventilation Method', 'Push-pull type vertical flow uniform ventilation system', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(625, 14, NULL, 'Body Dimension (LxWxH)', '30 Ft x 15 Ft x 15 Ft', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(626, 14, NULL, 'Indoor effective dimension (L x W x H)', '7220mm x 4520mm x 2700mm', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(627, 14, NULL, 'Vehicle Entrance/Exit (W x H)', '2900mm x 2670mm x 3 door open', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(628, 14, NULL, 'Small door for workers (W x H)', '15 Ft x 15 Ft, front', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(629, 14, NULL, 'IIIumination ', 'Upper: 40W x 4 light, 10 units Lower: 40 W x 2 light, 10 units, Total 2400 W (Power consumption 2010W)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(630, 14, NULL, 'Main Panel', 'Insulation sandwich panel 35mm thick (Galvanized ground copper plate 0.5t)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(631, 14, NULL, 'Supply primary filter (L x H)', 'Bag filter 484mm x 646mm x 3 sets', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(632, 14, NULL, 'Ceiling filter (L x H)', '1060mm x 1675mm x 16 sheets', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(633, 14, NULL, 'Exhaust filter (L x H)', '750mm x 1000mm, 6 sheets', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(634, 14, NULL, 'Supply/Exhaust unit', 'Air supply fan/sirocco fan specification three phase 220V, 7.5 kw high efficiency motor air flow/420-440m3/min.', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(635, 14, NULL, 'Heat source ', 'Fuel/gas (Propane/city gas) or kerosene gun type burner  250000 kcal/h (gas burner) gun type burner 240000kcal/h (kerosene burner)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(636, 14, NULL, 'Maximum set temperature ', 'Max 80 Degree Celsius ', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(637, 14, NULL, 'Control method ', 'Paint-dry after purge mode switching and internal pressure automatic control original control box (touch panel type)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(638, 14, NULL, 'Safety device ', 'Vibration sensor, after purge, inverter abnormal thermal trip, misfire alarm (gas pressure drop, wind pressure drop, high temperature abnormality)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(639, 14, NULL, 'Capacitance ', 'Three phase 220V 16 to 18 kw single phase 220V 2.5-3.5 kw', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(640, 14, NULL, 'Body color', 'Dex blue undeck thread noble brown ', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(641, 14, NULL, 'Option', 'Transformer box (1 source pressure, 1 pressure regulation auto drain) Outlet box (100 V x 2, 200V 20A, 200V 30A) Parts hanger (moveable to the centre of the booth) lighting window panic door horizontal storage box (medium) 1 (light weight)', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(642, 14, NULL, 'Outstanding combustion efficiency with the original new heat exchanger', 'The new original heat exchanger has larger hear transfer area, has the same heating calories as the conventional type and has a faster heating time, saving 15% energy.', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(643, 14, NULL, 'Energy saving fluorescent ballast is used for lighting ', 'The new fluorescent ballast is used for indoor lighting, reducing power consumption by 11.5 W per 40 W type compared to conventional steel ballast (approximately 25%=Hf stable period + equivalent to Hf dedicated lamp) the new ballast uses a conventional fluorescent lamp and is economical.', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(644, 14, NULL, 'Protection ', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(645, 14, NULL, 'Smoke musk with oxygen cyl', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(646, 14, NULL, 'Painting cap1', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(647, 14, NULL, 'Overall combination ', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(648, 14, NULL, 'Painting glove', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(649, 14, NULL, 'Painting boot', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(650, 14, NULL, 'Units and filters with excellent Exhaust Efficiency ', 'This exhaust unit created as a result of thoroughly pursuing the easy of cleaning and replacement of the exhaust filter. An exhaust fan is also built in the unit.', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(651, 14, NULL, 'Paint gun-1 with flexible pipe', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(652, 14, NULL, 'Hurnerd Licker Gun-1 with flexible pipe', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(653, 14, NULL, 'Compressor air facility (if any)', 'To be provided', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(654, 14, NULL, 'Software', 'All type of software required for the machine to be supplied and updated online free of cost for ever', 0, 0, NULL, '2023-04-10 12:31:56', '2023-04-10 12:31:56'),
(655, 15, NULL, 'Name and complete address of local agent', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(656, 15, NULL, 'Name and complete address of principal and manufacturer', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(657, 15, NULL, 'Year of production', 'Not before the year of contract', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(658, 15, NULL, 'Brand', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(659, 15, NULL, 'Model', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(660, 15, NULL, 'Country of origin', 'Group A countries', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(661, 15, NULL, 'Country of manufacturer', 'Group A countries', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(662, 15, NULL, 'Country of Assembly', 'Group A countries', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(663, 15, NULL, 'Chip shield and dust collector', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(664, 15, NULL, 'Offset square insert indexable tool holders', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(665, 15, NULL, 'Special tool bits', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(666, 15, NULL, 'V-Block fixture multiple angle 15 degree, 30 degree, 60 degree and 90 degree', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(667, 15, NULL, 'Block handle', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(668, 15, NULL, 'In-line block adapter', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(669, 15, NULL, 'Large diesel V block fixture', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(670, 15, NULL, 'Coolant system and tank capacity', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(671, 15, NULL, 'Block Clamp Arm', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(672, 15, NULL, 'CNC Touch Screen Control', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(673, 15, NULL, 'Windows operating system with intel processor, internet connection to the machine computer must be provided for training support & service', 'Must be included', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(674, 15, NULL, 'Automatic Vertical Cycles for Cylinder Boring', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(675, 15, NULL, 'Resleeving and counter boring programming and machine operation thru extra bright touch screen', 'Details to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(676, 15, NULL, 'Electronic Hand wheel for manual operation', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(677, 15, NULL, 'Precision Digital Readout', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(678, 15, NULL, 'Spindle Travel by Precision Ball Screen & AC Servo Motor', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(679, 15, NULL, 'Movement- Z Axis-Up and Down', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(680, 15, NULL, 'Machine work head floats on Air Cushion for precision centering controlled from the touch screen', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(681, 15, NULL, 'Heavy Duty Spindle', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(682, 15, NULL, 'Precision angle contact bearing supported in adjustable outer bearing quick change cutting head system speed', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(683, 15, NULL, 'Features', 'Accuracy- The machine uses a precision ground ball screen to control feed rate and cutter position. This allows the machines to repeat cutter position accuracy to .0002\" (.005mm)', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(684, 15, NULL, 'Increase spindle feed rates', 'Facility to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(685, 15, NULL, 'Decrease feed rates', 'Facility to be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(686, 15, NULL, 'Boring Range', '38-228mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(687, 15, NULL, 'Max vertical travel of the head', '370 to 390 mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(688, 15, NULL, 'Table size', 'L= 1250 to 1400 mm W= 500 to 600 mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(689, 15, NULL, 'Travel-spindle nose to table', '600 to 700 mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(690, 15, NULL, 'Spindle rotation speed', '100 to 1200', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(691, 15, NULL, 'RPM Feed per Revolution', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(692, 15, NULL, 'Feed rates', '.025-.003mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(693, 15, NULL, 'Spindle- Motor', '2.9 to 3.3 HP (2.5 to 3 kw)', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(694, 15, NULL, 'Machine height', '1900 to 2100 mm', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(695, 15, NULL, 'Control', 'Automatic CNC', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(696, 15, NULL, 'Dimensions', 'Machine: W= 1143 mm (min) x L= 1549 mm (min) x H= 2032 mm (min)', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(697, 15, NULL, 'Electrical requirements', '208-240V, 30A, 50/60Hz 3Ph', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(698, 15, NULL, 'Universal heavy duty T-Soltparalles', '5.2\" (132.08mm)', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(699, 15, NULL, 'Universal economy automotive block fixture', 'Requires 7219W Paralles. Dual axis level assembly.', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(700, 15, NULL, 'Production stub cutter head diameter', '2.319-4.1\" (55.6mm-104mm)', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(701, 15, NULL, 'Universal Micrometer Assembly', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(702, 15, NULL, 'Holder assembly', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(703, 15, NULL, 'Torque wrench', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(704, 15, NULL, 'Diameter', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(705, 15, NULL, 'Tool holder', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(706, 15, NULL, 'Triangular indexable insert tool holder', 'To be mentioned', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(707, 15, NULL, 'Software', 'All type of software required for the machine to be supplied and updated online free of cost for ever', 0, 0, '', '2023-04-11 10:12:57', '2023-04-11 10:12:57'),
(838, 18, NULL, 'Nomenclature', 'Binocular', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(839, 18, NULL, 'Brand', 'To be mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(840, 18, NULL, 'Model', 'To be mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(841, 18, NULL, 'Country of Origin', 'Group A Countries', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(842, 18, NULL, 'Country of Manufacture', 'Group A Countries', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(843, 18, NULL, 'Country of Assembly', 'To be Mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(844, 18, NULL, 'Name & Complete address of Manufacture', 'To be Mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(845, 18, NULL, 'Name & Complete address of Principal', 'To be mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(846, 18, NULL, 'Name & Complete address of Local Agent', 'To be mentioned', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(847, 18, NULL, 'Year of Production', 'Brand new and not earlier than the year of contract', 0, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(848, 18, NULL, 'Optical Details ', '', 1, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(849, 18, 848, 'Magnification', 'Minimum 8x', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(850, 18, 848, 'Objective Lens Diameter', 'Minimum 30 mm', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(851, 18, 848, 'Field of view (Degree)', 'Minimum 8 degree ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(852, 18, 848, 'Field of view at 1000 m', 'Minimum 140 m', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(853, 18, 848, 'Exit Pupil', 'Minimum 3.75 mm', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(854, 18, 848, 'Eye relief', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(855, 18, 848, 'Prism', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(856, 18, 848, 'Coating of Lens', 'To be available (Standard)', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(857, 18, 848, 'Dioptric adjustment /correction', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(858, 18, 848, 'Focus', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(859, 18, 848, 'Brightness', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(860, 18, 848, 'Inter pupillary adjustment distance', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(861, 18, 848, 'Reticle', 'Reticle: Reticles inside the binocular should have scale from 0 miles up to min 50 mils with 05 mils graduation on either side both horizontally and vertically  ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(862, 18, 848, 'Reticle type', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(863, 18, 848, 'Viewing Range', 'To be mentioned (Minimum a man size target  to be viewed form 1000 m) ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(864, 18, NULL, 'Physical', '', 1, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(865, 18, 864, 'Dimension (L x W x H)', 'To be mentioned', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(866, 18, 864, 'Weight', 'Not more than 1 kg', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(867, 18, 864, 'Color', 'Middle Bronze Green (MB Green) ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(868, 18, NULL, 'Environmental Standards', '', 1, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(869, 18, 868, 'Immersion', 'Military Standard 810 E/F/G', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(870, 18, 868, 'Drop', 'Military Standard 810 E/F/G', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(871, 18, 868, 'Fog and Dust', 'Military Standard 810 E/F/G', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(872, 18, 868, 'Vibration ', 'Military Standard 810 E/F/G', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(873, 18, 868, 'Operating Temperature', '-10 degree Celsius to +55 degree Celsius ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(874, 18, 868, 'Storage Temperature', '-20 degree Celsius to +65 degree Celsius ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(875, 18, NULL, 'List of Standard Items/ Accessories (for full range of operation of the equipment) for each Binocular ', '', 1, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(876, 18, 875, 'Casing ', 'Standard hard casing with shoulder strap', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(877, 18, 875, 'Lens cap', 'Complete set to be provided', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(878, 18, 875, 'Lens cleaning cloth and brush', 'To be provided', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(879, 18, 875, 'Maintenance Kit  (optional)', 'List to be provided  (Price to be quoted separately)', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(880, 18, 875, 'List of Other items/accessories ', 'List to be mentioned ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(881, 18, 875, 'List of Optional items', 'List to be mentioned ', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(882, 18, NULL, 'Others Conditions', '', 1, 0, '', '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(883, 18, 882, 'Tender sample basis . One complete binocular with complete accessories is to be submitted for as tender sample  for test and trial (NO cost No Obligation Basis )', '', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(884, 18, 882, 'All items and accessories to be supplied with each Binocular to be listed ', '', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(885, 18, 882, 'Brochure / Catalogue /Datasheet as applicable with detail technical data for the offered binocular is to be submitted  ', '', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(886, 18, 882, 'Manufacturer website/ URL etc. where details of offered binocular are available , are to be mentioned   ', '', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(887, 18, 882, 'Demonstration on equipment to be arranged by manufacturer / local agent (if nessary) ', '', 0, 0, NULL, '2023-04-16 14:42:30', '2023-04-16 14:42:30'),
(888, 19, NULL, 'Nomenclate ', 'Auxiliary  Power Unit (small capacity)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(889, 19, NULL, 'Brand Name/make', 'To be mentioned ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(890, 19, NULL, 'Model', 'To be mentioned', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(891, 19, NULL, 'Country of Origin', 'Group B countries', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(892, 19, NULL, 'Country of Manufacture', 'Group B countries', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(893, 19, NULL, 'Country of Assembly', 'Group B countries', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(894, 19, NULL, 'Year of Manufacture ', 'Brand new and not before the calendrer year of the contract', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(895, 19, NULL, 'Name of Manufacture with complete address (Address, Telephone, Fax Email & Website ) ', 'Details to be mentioned', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(896, 19, NULL, 'Name of Principal with complete address (Address, Telephone, Fax Email & Website )', 'Details to be mentioned', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(897, 19, NULL, 'Name of Local agent with complete address (Address, Telephone, Fax Email & Website )', 'Details to be mentioned	\n', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(898, 19, NULL, 'Drive', 'To be mentioned ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(899, 19, NULL, 'Configuration ', 'To be mentioned', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(900, 19, NULL, 'Dimension of Body', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(901, 19, 900, 'Length', 'Not more than 125 inch (3175 mm)', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(902, 19, 900, 'Width ', 'Not more than 70 inch (1778 mm)', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(903, 19, 900, 'Height', 'Not more than 67 inch (1701 mm)', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(904, 19, NULL, 'Weight', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(905, 19, 904, 'GVW', 'Not more than 1900 Kg', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(906, 19, NULL, 'Brake System', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(907, 19, 906, 'Parking Brake', 'To be mentioned ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(908, 19, 906, 'Emergency Brake', 'To be mentioned ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(909, 19, 906, 'Trailer Brake Connection', 'To be mentioned ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(910, 19, NULL, 'Generator for Auxiliary Power Unit (APU) ', '', 1, 0, 'Output Power', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(911, 19, 910, 'Brand', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(912, 19, 910, 'Model', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(913, 19, 910, 'Name of Manufacturer', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(914, 19, 910, 'Country of Origin', 'Group B Countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(915, 19, 910, 'Country of Manufacture ', 'Group B Countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(916, 19, 910, 'Country of Assembly', 'Group B Countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(917, 19, 910, 'Year of Manufacuter', 'Brand new and not before the calendrer year of contract ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(918, 19, NULL, 'Output Power', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(919, 19, 918, 'Prime', 'Minimum 45 KVM, Must be compatible with Engine and Alternator ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(920, 19, 918, 'Standby', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(921, 19, NULL, 'Engine', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(922, 19, 921, 'Brand', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(923, 19, 921, 'Model', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(924, 19, 921, 'Name of Manufacture', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(925, 19, 921, 'Country of Origin', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(926, 19, 921, 'Country of Manufacture', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(927, 19, 921, 'Country of Assembly', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(928, 19, 921, 'Types of Engine', 'Diesel', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(929, 19, 921, 'Engine Power Output', 'To be mentioned. (Must be compatible with the the system and alienator )', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(930, 19, 921, 'Max Torque', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(931, 19, 921, 'Turbo Charger (If available)', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(932, 19, 921, 'NO of Cylinder', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(933, 19, 921, 'Engine Displacement', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(934, 19, 921, 'Rated RPM', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(935, 19, 921, 'Fuel consumption Liter per Hour', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(936, 19, 921, 'Cooling System', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(937, 19, 921, 'Electric System', '12/24 Volt', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(938, 19, 921, 'Battery Capacity', '12/24 Volt, Ampere hour (Ah) to be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(939, 19, 921, 'Compression Ration', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(940, 19, 921, 'Fuel Tank Capacity', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(941, 19, NULL, 'Alternator', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(942, 19, 941, 'Brand ', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(943, 19, 941, 'Model', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(944, 19, 941, 'Type ', 'Brushless', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(945, 19, 941, 'Name of Manufacturer', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(946, 19, 941, 'Country of Origin', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(947, 19, 941, 'Country of Manufacturer', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(948, 19, 941, 'Country of Assembly', 'Group B countries', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(949, 19, 941, 'Power Output (KVA/KW)\n  a. Prime\n  b. Standby', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(950, 19, 941, 'Ampere ', '600-2000 Amp', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(951, 19, 941, 'Cooling ', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(952, 19, 941, 'Output Voltage', '115/200 VAC, 400 HZ, 3 Phase\n22-30 Volt DC', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(953, 19, 941, 'Power Factor  (Cos O)', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(954, 19, 941, 'RPM', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(955, 19, 941, 'Number of pole', 'To be mentioned', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(956, 19, NULL, 'List of Tools Kit', 'To be submitted', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(957, 19, NULL, 'Transformer Rectifier Unit (TRU) System', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(958, 19, 957, 'Output Filtering  ', 'DC out put must be incorporated with the filtering so as to reduce the ratio interference during operation', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(959, 19, 957, 'Output Voltage Selector Switch / Trimmer', 'Auto adjusting DC Output, APU to be fitted an internal line drop compensation to ensure at all time a stabel voltage of 28 /VDC at the end of electric cables and accurate adjustment of the exciting voltage is done accordingly to be needed amperage to guarantee the output voltage required by military air craft. This way both voltage 28 VDC and 115-200 VAC can be supplied simultaneously, which is necessary for numerous military aircrafts ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(960, 19, 957, 'Voltage Regulator', 'Automatic Voltage regulator for maintain the nominal output voltage 28 VDC  ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(961, 19, 957, 'Voltage Stabilizer', 'Auto Voltage stabilizer must be fitted for obtaining stable power at variable load', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(962, 19, 957, 'Output Current', '600A-2000 A with minimum 600 A continuous current', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(963, 19, 957, 'Control System and Instrument  for the TRU ', 'Input contractor, Power ON Push button, Power off Push button DC output indicator light over volt protection switch, DC volt meter and DC Ammeter', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(964, 19, NULL, 'Inurement for 400 HZ AC Electrical System ', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(965, 19, 964, 'Voltage Regulator ', 'Solid state voltage regular to min variation of output voltage within 1-1% of the nominal value in changing loads', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(966, 19, 964, 'Control Instrument ', '1) Contractors \n2) Power ON Light \n3) Power ON-\"OFF\" Switch\n4) Voltmeter\n5) Ammeter\n6) Frequency Meter\n7) Current Transducer\n8) Voltage Trammer for adjustment output volt within 15% of nominal voltage ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(967, 19, NULL, 'Battery', '12/24 V, 45 AH each\n1) Brand, Model, Country of Origin, Manufacture, Year of Production-To be mentioned.\n2) Volt and capacity (Ampere Hour) to be mentioned  ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(968, 19, NULL, 'Tyre and Wheels ', 'a) The Auxiliary Power unit (APU) will be mounted on 3/4 wheeled trucks.\nb) Brand of tyre to be mentioned\nc) Rim size to be mentioned.\nd) Tyre Pattern to be mentioned  ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(969, 19, NULL, 'Metallurgical Treatment ', 'Anticorrosive Treatment will be given on all parts of the auxiliary power unit (APU)  prone to corrosion', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(970, 19, NULL, 'Towing Hooks', 'Lockable towing hooks will be fitted in the forint and rear of the Auxiliary Power Unit (APU)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(971, 19, NULL, 'Noise control System', ' A noise reduction kits are fitted as standard to reduce the noise level white operating the Auxiliary Power Unit (APU)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(972, 19, NULL, 'Fault Protection Devices\n', '', 1, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(973, 19, 972, 'Electrical Power System', '1) Under and over frequency  protection system and cutoff provision.\n2)   Under and over frequency  protection system and on /off provision.\n3) Overload protection System.', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(974, 19, 972, 'Engine Section', '1) Low oil Pressure Indicator.\n2) High coolant temperature .\n3) Engine Over speed\n4) Any other items (if necessary): to be mentioned ', 0, 0, NULL, '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(975, 19, NULL, 'Lighting System', 'Rear/Front Spot light  to be provided', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(976, 19, NULL, 'Warning light  ', 'Auxiliary Power Unit (APU) should have engine failure and eclectic under /over voltage audio, visual warnings system ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(977, 19, NULL, '28 VDC power Socket', 'One standard two/there pin, 15 amps 28 VDC socket with an ON-OFF Swatch should be fitted in the power control bored easily accessible to use  ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(978, 19, NULL, 'Output Power cables ', 'a) One of 115/200 VAC, 400 Hz 3 phase at least 10 meters long output cables insulated sheathed in a standard 06 pin aircrafts adapter .\nb) one of 28.5 VDC 600-2000 AMPS cables will be fitted with standard aircrafts 3 pins. Flat adapter with cable will be at least 10 meter long', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(979, 19, NULL, 'Cable Box', 'a) Cable boxes are to be integrated to accommodated all the cable protected from rain. The location position of the boxes will be easily accessible.\nb) Mechanical Storing for cable, should be easy to handle  ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(980, 19, NULL, 'Color', 'a) Canopy and cabling will be golden yellows gloss color .\nb) Cabin boxes will be painted with standard black color', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(981, 19, NULL, 'List of standard items / Accessories for full range of operations /Use', 'List to be submitted as per following proforma:\nBill of Quantity /Material (BOW/BOM) of standard items:\nSer, Item name, Model NO/ Part NO, Quantity, Country of Manufacturer ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(982, 19, NULL, 'List of Optional / Accessories for full range of operations /Use', 'List to be submitted as per following proforma: Bill of Quantity /Material (BOW/BOM) of Optional items: Ser, Item name, Model NO/ Part NO, Quantity, Country of Manufacturer', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(983, 19, NULL, 'Miscellaneous', 'Following items /Accessorizes  are to be supplied  with the Auxiliary Power Unit (APU) by the supplier: \na) One dry chemical fire extinguisher of capacity 2.5 kg for each APU.\nb) One spare wheel assembly (Loose) completed with  tyre and tube for each APU.\nc) One set, Qty -02 (two) applicable jack for each APU.\nd) Wheel removing tools for each APU', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(984, 19, NULL, 'POL\na) Type of diesel to be used in Bangladesh.\nb) Type of Engine oil to be use in Bangladesh\nc)   Type of Gear oil to be use in Bangladesh', 'Information to be submitted as per requirement. The POL must be compatible with POL aval in Bangladesh  ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(985, 19, NULL, 'ISO certificate or similar rating ', 'ISO certificate to be provided by the manufacture ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(986, 19, NULL, 'Any other: Any item/accessors not mentioned above but is /are required for full range of operating /use, must be quoted and supply with the APU', 'To be confirmed ', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(987, 19, NULL, 'User Training', 'To be Provided including ITD person (as per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(988, 19, NULL, 'Operations, Repair and Maintenance triaging ', 'To be Provided including ITD person (as per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(989, 19, NULL, 'Inventory Management Trancing ', 'To be Provided  (as per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(990, 19, NULL, 'Publication on Training ', 'To be Provided  (as per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(991, 19, NULL, 'Books and Publication:\na) Owners / Operations manual   in English (Book Type) including CD/DVD.\nb) Workshop / Repair Manual in English (Book type ) including CD/DVD\nc) 100% Updated masters spare parts catalogue in English (Book Type) including CD/DVD.\nd) Complete and updated masters spare parts  price catalogue / list in English (Book type ) including CD/DVD.', 'To be Provided  (as per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56'),
(992, 19, NULL, 'List of standard spare parts, tools and accessories ', 'To be provided ( As per proforma)', 0, 0, '', '2023-04-16 16:51:56', '2023-04-16 16:51:56');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2023_03_02_101701_create_items_table', 1),
(2, '2023_03_02_101722_create_item_specifications_table', 1),
(3, '2023_03_05_153807_create_supplier_items_table', 2),
(4, '2023_03_05_153831_create_supplier_item_specifications_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `supplier_items`
--

CREATE TABLE `supplier_items` (
  `id` bigint UNSIGNED NOT NULL,
  `demand_no` int NOT NULL,
  `item_id` int NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_fully_comply` int DEFAULT NULL,
  `total_partially_comply` int DEFAULT NULL,
  `total_reject` int DEFAULT NULL,
  `attachement` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `offer_date` date DEFAULT NULL,
  `result_id` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supplier_items`
--

INSERT INTO `supplier_items` (`id`, `demand_no`, `item_id`, `supplier_name`, `total_fully_comply`, `total_partially_comply`, `total_reject`, `attachement`, `offer_date`, `result_id`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(100, 505, 15, 'M/S ARRA International ', 53, 0, 0, NULL, '2023-04-11', 1, NULL, NULL, '2023-04-11 10:50:03', '2023-04-15 14:49:37'),
(101, 505, 15, 'MinMax Corporation ', 42, 8, 3, 'storage/Specification/specificication-verify/643a7af1aeabf.docx', '2023-04-15', 2, NULL, NULL, '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(102, 790, 14, 'M/S Mahi International', 33, 11, 0, 'storage/Specification/specificication-verify/643a8852de8ed.docx', '2023-04-15', 1, NULL, NULL, '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(103, 790, 14, 'Benexim Corporation ', 43, 1, 0, 'storage/Specification/specificication-verify/643a8f0b0f6ec.docx', '2023-04-15', 1, NULL, NULL, '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(104, 790, 14, 'A RR Tarding', 22, 16, 6, 'storage/Specification/specificication-verify/643a95fd02bc4.docx', '2023-04-15', 2, NULL, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(105, 790, 14, 'Leo Enterprise', 40, 4, 0, 'storage/Specification/specificication-verify/643a9edb69573.docx', '2023-04-15', 1, NULL, NULL, '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(108, 192, 19, 'M/S Next Generation Graphics Ltd', 93, 2, 0, 'storage/Specification/specificication-verify/643cd9b7e7c62.doc', '2023-04-17', 1, NULL, NULL, '2023-04-17 09:31:35', '2023-04-17 09:31:35');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_item_specifications`
--

CREATE TABLE `supplier_item_specifications` (
  `id` bigint UNSIGNED NOT NULL,
  `supplier_item_id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `specification_id` bigint UNSIGNED NOT NULL,
  `received_specification` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `verify_status` tinyint DEFAULT '0',
  `reason` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `supplier_item_specifications`
--

INSERT INTO `supplier_item_specifications` (`id`, `supplier_item_id`, `parent_id`, `specification_id`, `received_specification`, `verify_status`, `reason`, `created_at`, `updated_at`) VALUES
(1298, 101, NULL, 655, 'MinMax Corporation  Address: House#06, Road#11, Sector#12, Uttara, Dhaka-1230, Bangladesh ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1299, 101, NULL, 656, 'POLEKS MAKINA SAN.VE TIC.AS 2. Organize San. Yaylacik Cad. Isiktepe Sk. No: 21 Konya/Turkey ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1300, 101, NULL, 657, 'Not before the year of contract', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1301, 101, NULL, 658, 'POLEKS ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1302, 101, NULL, 659, 'RM 320 CNC ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1303, 101, NULL, 660, 'TURKEY ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1304, 101, NULL, 661, 'TURKEY ', 3, NULL, '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1305, 101, NULL, 662, 'TURKEY ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1306, 101, NULL, 663, 'Dust collector available in machine as separated ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1307, 101, NULL, 664, 'Easy boring head holder and changer robot.  1.	Brand: Poleks  2.	Model: Poleks ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1308, 101, NULL, 665, 'Different size cutter and diamonds for use boring head.  1.	Brand: Poleks  2.	Model: Poleks ', 3, NULL, '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1309, 101, NULL, 666, 'V block apparatus capacity over 1 tons for all type of V kind engine blocks  1.	Brand: Poleks  2.	Model: Poleks ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1310, 101, NULL, 667, 'Standard block holder fixtures for handle the cylinder block not move around during the boring process.  1.	Brand: Poleks  2.	Model: Poleks', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1311, 101, NULL, 668, '1.	Brand: Poleks  2.	Model: Poleks', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1312, 101, NULL, 669, 'V Block apparatus capacity over 1 tons for all type of V kind Engine blocks  1.	Brand: Poleks  2.	Model: Poleks', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1313, 101, NULL, 670, 'Electronic drivers and servo motor coolant system available. ', 3, NULL, '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1314, 101, NULL, 671, 'Standard block holder fixture’s for handle the cylinder block not move around during the boring process. 2 pcs 100 mm and 2 pcs 200 mm  1.	Brand: Poleks  2.	Model: Poleks ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1315, 101, NULL, 672, 'CNC touch screen computer unit available as a standard equipment. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1316, 101, NULL, 673, 'To be included', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1317, 101, NULL, 674, 'Manual Centering system and full automatic boring system modes available  ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1318, 101, NULL, 675, 'Avaiable. Special Programming system produce by poleks.  Programming will be by control panel.  ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1319, 101, NULL, 676, 'Available electronic hand wheel 3 axis control. Also electronic hand wheel is available and useful for spindle rotating this specifications is usefull for centering of the cylinder. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1320, 101, NULL, 677, 'There are electronic readout (ruler) for three of the axis and operator can see depth of the boring during process running. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1321, 101, NULL, 678, 'Ball screw and AC SERVO Control ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1322, 101, NULL, 679, 'Movement – Z Axis – Up and Down by AC SERVO Control ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1323, 101, NULL, 680, 'Centering control by electronic hand wheel. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1324, 101, NULL, 681, 'Boring head use marble gears and special borings for heavy duty and boring heads are available to use in vutter feed up to 16 mm feed in one time. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1325, 101, NULL, 682, 'The system very easy and available function for RM 320 CNC boring Machine. ', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1326, 101, NULL, 683, 'This allows the machines accuracy to .0002\" (.005mm).', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1327, 101, NULL, 684, 'Spindle rotation speed adjustable 0-700 RPM ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1328, 101, NULL, 685, ' 35-320 ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1329, 101, NULL, 686, '740 mm ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1330, 101, NULL, 687, '1590 x 530 mm ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1331, 101, NULL, 688, '1890 mm ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1332, 101, NULL, 689, '0-1200 ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1333, 101, NULL, 690, 'AC SERVO  0-1000 RPM ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1334, 101, NULL, 691, '0-2.00 ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1335, 101, NULL, 692, '3 KW ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1336, 101, NULL, 693, '2600 mm ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1337, 101, NULL, 694, 'Automatic CNC', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1338, 101, NULL, 695, 'Machine: W=1654 mm (Min) x L= 3850 mm (Min) x H= 2600 mm (Min)', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1339, 101, NULL, 696, '208-240V, 30A, 50/60Hz, 3Ph', 2, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1340, 101, NULL, 697, '5.2” (132.08 mm)', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1341, 101, NULL, 698, 'Parallels. Dual axis level assembly.  7219 W Parallels. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1342, 101, NULL, 699, '2.319 – 4.1” (55.6 mm – 104mm)', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1343, 101, NULL, 700, 'Available ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1344, 101, NULL, 701, 'Standard Accessories Boring Head holder apparatus suitable for all boring heads and milling heads. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1345, 101, NULL, 702, 'To be provided ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1346, 101, NULL, 703, 'Boring diameter 320 mm ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1347, 101, NULL, 704, 'Standard Accessories Boring Head holder apparatus suitable for all boring heads and milling heads.', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1348, 101, NULL, 705, 'RM 320 CNC model use ready tool holder and chip breaker system . ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1349, 101, NULL, 706, 'To be mentioned', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1350, 101, NULL, 707, 'POLEKS standard special software. ', 1, '', '2023-04-15 14:22:41', '2023-04-15 14:22:41'),
(1457, 102, NULL, 611, 'Mahi international', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1458, 102, NULL, 612, 'BOTERSAN Endustriyel', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1459, 102, NULL, 613, 'Not before the year of contract ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1460, 102, NULL, 614, 'BOTERSAN ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1461, 102, NULL, 615, 'CB-720', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1462, 102, NULL, 616, 'TURKEY', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1463, 102, NULL, 617, 'TURKEY', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1464, 102, NULL, 618, 'TURKEY', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1465, 102, NULL, 619, 'Uniform wind speed is 12.6m/min', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1466, 102, NULL, 620, 'Comply will be given', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1467, 102, NULL, 621, 'Comply will be given', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1468, 102, NULL, 622, 'Comply will be given', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1469, 102, NULL, 623, 'Comply will be given', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1470, 102, NULL, 624, 'will be given', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1471, 102, NULL, 625, '30 Ft x 15 Ft x 15 Ft', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1472, 102, NULL, 626, '7220mm x 4520mm x 2700mm', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1473, 102, NULL, 627, '2900mm x 2670mm x 3 door open', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1474, 102, NULL, 628, '15 Ft x 15 Ft, front', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1475, 102, NULL, 629, 'Upper: 58W x 4 light, 10 units Lower: 40 W x 2 light, 10 units, Total 2400 W (Power consumption 2010W)', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1476, 102, NULL, 630, 'Insulation sandwich panel 55mm thickness', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1477, 102, NULL, 631, 'will be given', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1478, 102, NULL, 632, '1060mm x 1675mm x 16 sheets', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1479, 102, NULL, 633, '750mm x 1000mm, 6 sheets', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1480, 102, NULL, 634, 'Air supply fan 5.5kw', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1481, 102, NULL, 635, '250000 kcal/h', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1482, 102, NULL, 636, 'Max 80 Degree Celsius ', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1483, 102, NULL, 637, 'Paint-Dry-After purge Mode switching and internal pressure automatic control original control box (touch panel type).', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1484, 102, NULL, 638, 'Booth is safety devices and alarm to check pressure etc. The Riello burner is designed to check gas fluctuations.  ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1485, 102, NULL, 639, 'Three phase electricity with 380 Volt.  ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1486, 102, NULL, 640, 'White or blue white ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1487, 102, NULL, 641, 'Parts hanger and storage box ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1488, 102, NULL, 642, 'The new original heat exchanger has larger hear transfer area, has the same heating calories as the conventional type and has a faster heating time, saving 15% energy.', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1489, 102, NULL, 643, 'LED lights are illuminating  ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1490, 102, NULL, 644, 'To be provided', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1491, 102, NULL, 645, 'To be provided(locally Supplied)', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1492, 102, NULL, 646, 'To be provided(Local)', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1493, 102, NULL, 647, 'To be provided', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1494, 102, NULL, 648, 'To be provided', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1495, 102, NULL, 649, 'To be provided', 2, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1496, 102, NULL, 650, 'Both exhaust and clean air units have got pre-filters to increase the efficiency if the filters and all of them can be changed easily and comfortably. ', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1497, 102, NULL, 651, 'To be provided', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1498, 102, NULL, 652, 'To be provided', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1499, 102, NULL, 653, 'To be provided(Locally)', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1500, 102, NULL, 654, 'All type of software required for the machine to be supplied and updated online free of cost for ever', 1, '', '2023-04-15 15:19:46', '2023-04-15 15:19:46'),
(1501, 100, NULL, 655, 'M/S ARRA Corporation', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1502, 100, NULL, 656, 'Principal: MTA Group Company Limited, RM409, North Tower, Jinshan Building No.248. Wushan Rd, Tianhe Area, Guangzhou, China    Manufacturer: Rottler Manufacturing LLC, 8029 South 200th street, kent, Washington 980032, USA  ', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1503, 100, NULL, 657, 'Not before the year of contract', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1504, 100, NULL, 658, 'ROTTLER', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1505, 100, NULL, 659, 'FA10A', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1506, 100, NULL, 660, 'USA', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1507, 100, NULL, 661, 'USA', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1508, 100, NULL, 662, 'USA', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1509, 100, NULL, 663, 'Chip shield and dust collector allows connection of vacuum extractor to remove cast iron dust when boring and resleeving cylinder', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1510, 100, NULL, 664, 'These tools were designed for V-Block applications where main bearing interference at the bottom of the bore is problem. They provided an additional .25 of cutting depth compared to standard tool holders.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1511, 100, NULL, 665, 'Variety of brazed carbide tool bits to handle applications such as facing and counter boring , offset tools for blind hole and tight clearance situations, special grooving tools, etc.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1512, 100, NULL, 666, 'V-Block fixture multiple angle 15 degree, 30 degree, 60 degree and 90 degree. The Rottler universal V-block fixture system provides a fast and effortless method of holding blocks for boring and sleeving operations.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1513, 100, NULL, 667, 'The Rottler block handle provides a safe and efficient style blocks.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1514, 100, NULL, 668, 'This adapter allows quick mounting and leveling of in-line block without removing the block fixture from the machine', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1515, 100, NULL, 669, 'Large diesel V- block such as Detroit 71 or 92 and Mercedes 400 can be machined with the heavy duty V block fixture', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1516, 100, NULL, 670, 'Coolant system and tank capacity 265 liters', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1517, 100, NULL, 671, 'The massive one piece meehanite , stress relived , precision machined base casting allows the fixturing of large diesel block such as Cummins 855, Detroit 12V71, Mercedes 444V12 and odd jobs such as gear and connecting rods.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1518, 100, NULL, 672, 'precision programming and control thru a 4.5\" computerized touch screen. software for programmable and automated cycles such as boring, sleeving , counter boring and blind hole machining.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1519, 100, NULL, 673, 'Internet connection: cutting edge internet support. Factory technicians can connect direct to the machine through the worldwide internet for service and support', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1520, 100, NULL, 674, 'Vertical and spindle load monitoring for fast overload shut down', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1521, 100, NULL, 675, 'Machine operation through extra bright light when resleeving and counter boring during time', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1522, 100, NULL, 676, 'Electronic hand wheel : The electronic hand wheel on the FA machines has two modes of operation. In fine mode, each, each \"click\" of the hand wheel will move the machine exactly .001\" and in coarse mode, each click will move the machine exactly .010\". The hand wheel is also used to vary the feed rate during automatic cycles to find most productive feed rate.    ', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1523, 100, NULL, 677, 'Digital read out', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1524, 100, NULL, 678, 'The sliding quill spindle design that has proven to give decades of precision and reliable machining. over the last 90 years, Rottler has perfected this design which is ideal  for deep hole machining such as engine block machining.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1525, 100, NULL, 679, 'Dual axis level assembly', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1526, 100, NULL, 680, 'The machine is development of this simple method of operation and the display tells the operator exactly where the spindle is positioned at all times.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1527, 100, NULL, 681, 'Heavy Duty Spindle', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1528, 100, NULL, 682, 'Heavy duty hard chromed precision spindle with high-speed angular contact bearings supported with adjustable conical outer bearings', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1529, 100, NULL, 683, 'The FA series uses a precision ground ball screw to control feed rate and cutter position. This allows the machines to repeat cutter position accuracy to .0002\"', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1530, 100, NULL, 684, 'Increase spindle feed rate for simple oversize', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1531, 100, NULL, 685, 'Decrease feed rates for sleeve cuts or counter bores.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1532, 100, NULL, 686, '38-228mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1533, 100, NULL, 687, '370 to 390 mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1534, 100, NULL, 688, 'L= 1250 to 1400 mm W= 500 to 600 mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1535, 100, NULL, 689, '670 mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1536, 100, NULL, 690, '100 to 1200', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1537, 100, NULL, 691, 'Independent feed control allows you to change the feed rate from .001\" per revolution.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1538, 100, NULL, 692, '.025-.003mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1539, 100, NULL, 693, '3.3 HP (2.5 kw)', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1540, 100, NULL, 694, '2032 mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1541, 100, NULL, 695, 'Computer numerical control  ', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1542, 100, NULL, 696, 'Machine: W= 1143 mmx L= 1549 mm x H= 2032 mm', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1543, 100, NULL, 697, '208-240V, 30A, 50/60Hz 3Ph', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1544, 100, NULL, 698, '5.2\" (132.08mm)', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1545, 100, NULL, 699, 'Requires 7219W Paralles. Dual axis level assembly.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1546, 100, NULL, 700, 'Production stub cutter head pa2.319-4.1\" (55.6mm-104mm)ckage.', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1547, 100, NULL, 701, 'Production cutter head 2.68-5.0\" diameter complete with tooling and digital micrometer', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1548, 100, NULL, 702, 'comply', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1549, 100, NULL, 703, 'CNC SERVO Controlled high torque spindle rotation system- 530 in-lb', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1550, 100, NULL, 704, '1.5\" to 9\"', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1551, 100, NULL, 705, '0.25\" of cutting depth compared to standard tool holders. square tool holders are optional with cutter head assemblies', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1552, 100, NULL, 706, 'Triangular tool holders are used for sleeve cutting or counter bores. Different insert styles are available for your application. Triangular tool holders are standard with cutter head assemblies', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1553, 100, NULL, 707, 'Comply', 1, '', '2023-04-15 15:35:08', '2023-04-15 15:35:08'),
(1554, 103, NULL, 611, 'Benexim Corporation  Plot: 702, Road: 10, Avenue: 02 Mirpur DOHS, Dhaka-1216', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1555, 103, NULL, 612, 'Principal:  KAPLAN TRADING LTD Co. No. 10446345 Registered in England and Wales at 13 Thornton Road, Cambridge CB 3 onp  Manufacturer: iLKE Industrial Painting System and Automation INC.  Temsil Plaza 1201/1 Sokak No: 4 Z: 23 Yenishir izmir', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1556, 103, NULL, 613, 'Not before the year of contract ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1557, 103, NULL, 614, 'FIRAT ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1558, 103, NULL, 615, 'FBK 10000', 2, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1559, 103, NULL, 616, 'Turkey ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1560, 103, NULL, 617, 'Turkey ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1561, 103, NULL, 618, 'Turkey ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1562, 103, NULL, 619, 'Available with flow 36,000 m3/h', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1563, 103, NULL, 620, 'The celling filter will cover all the ceiling. It will be EU5 (m5) standard, which is bets in the sector.', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1564, 103, NULL, 621, 'Filters are fixed to the celling with the help of the filter frames, which is very easiest to change. ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1565, 103, NULL, 622, 'The touch screen control panel is developed by our own company and it is easy to operate, the inverter is connected to the control panel and it makes you control the processes easily and safely  The touch screen control panel is easy to use and connected with inverter to keep the pressure uniform inside the oven during the processes. The air circulation is full down draft (from ceiling to the floor vertical air movement) and the four leaf front door will allow you to see through. The side door is booth used as a service door and safety door. The dimensions of the entrance door are 3600 mm (wide) and 3865 (height)  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1566, 103, NULL, 623, 'a. The emblem at the top of the front is also renewed and the new Zero Nano is a new face. b. A vertically long glass window with excellent visibility is used to achieve both function and design. An optional panic door is also available. ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1567, 103, NULL, 624, 'Full down draft vertical ventilation system ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1568, 103, NULL, 625, '33.46 Ft (L) x 15.16 Ft (w) x 15.09 (H) Ft ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1569, 103, NULL, 626, '30 ft x 15 ft x 15 ft', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1570, 103, NULL, 627, '3600 mm x 3865 mm  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1571, 103, NULL, 628, '810 mm x 2127 mm  (W x H)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1572, 103, NULL, 629, 'LED lights (12 x 45 watt for top corner and 8 x 20 watts for the sides)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1573, 103, NULL, 630, 'Insulation sandwich panel 50 mm thick (Galvanized ground copper plate 1 mm thick between rock wool).', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1574, 103, NULL, 631, '20 meters x 1 meters (3 sets) ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1575, 103, NULL, 632, '20 meters x 1 meters (20 sheets)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1576, 103, NULL, 633, '10 meters x 1 meters (3 sheets)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1577, 103, NULL, 634, 'Air supply fan (Nicodra Italy) with specification of 3 phases, 7.5-11 Kw, air flow 600m3/min phase.', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1578, 103, NULL, 635, 'Riello kerosene gun type burner with 250000 kcal/hour. ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1579, 103, NULL, 636, 'Max 80 Degree Celsius ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1580, 103, NULL, 637, 'Paint-Dry-After purge Mode switching and internal pressure automatic control original control box (touch panel type).', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1581, 103, NULL, 638, 'Booth is safety devices and alarm to check pressure etc. The Riello burner is designed to check gas fluctuations.  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1582, 103, NULL, 639, 'Three phase electricity with 380 Volt.  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1583, 103, NULL, 640, 'White or blue white ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1584, 103, NULL, 641, 'Parts hanger and storage box ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1585, 103, NULL, 642, '1800 mm heat exchanger. Save energy around 10 to 20 %.  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1586, 103, NULL, 643, 'LED lights are illuminating  ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1587, 103, NULL, 644, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1588, 103, NULL, 645, 'To be provided (locally Supplied)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1589, 103, NULL, 646, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1590, 103, NULL, 647, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1591, 103, NULL, 648, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1592, 103, NULL, 649, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1593, 103, NULL, 650, 'Both exhaust and clean air units have got pre-filters to increase the efficiency if the filters and all of them can be changed easily and comfortably. ', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1594, 103, NULL, 651, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1595, 103, NULL, 652, 'To be provided', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1596, 103, NULL, 653, 'To be provided (Locally)', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1597, 103, NULL, 654, 'All type of software required for the machine to be supplied and updated online free of cost for ever', 1, '', '2023-04-15 15:48:27', '2023-04-15 15:48:27'),
(1598, 104, NULL, 611, 'A RR Trading ', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1599, 104, NULL, 612, 'ANDEX Co .Ltd, Japan', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1600, 104, NULL, 613, 'Not before the year of contract ', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1601, 104, NULL, 614, 'ANDEX', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1602, 104, NULL, 615, 'CAB-07V', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1603, 104, NULL, 616, 'Japan', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1604, 104, NULL, 617, 'Japan', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1605, 104, NULL, 618, 'Japan', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1606, 104, NULL, 619, 'Available with flow 36,000 m3/h', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1607, 104, NULL, 620, 'The celling filter will cover all the ceiling. It will be EU5 (m5) standard, which is bets in the sector.', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1608, 104, NULL, 621, 'Filters are fixed to the celling with the help of the filter frames, which is very easiest to change. ', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1609, 104, NULL, 622, 'The touch screen control panel is developed by our own company and it is easy to operate, the inverter is connected to the control panel and it makes you control the processes easily and safely  The touch screen control panel is easy to use and connected with inverter to keep the pressure uniform inside the oven during the processes. The air circulation is full down draft (from ceiling to the floor vertical air movement) and the four leaf front door will allow you to see through. The side door is booth used as a service door and safety door. The dimensions of the entrance door are 3600 mm (wide) and 3865 (height)  ', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1610, 104, NULL, 623, 'a. The emblem at the top of the front is also renewed and the new Zero Nano is a new face. b. A vertically long glass window with excellent visibility is used to achieve both function and design. An optional panic door is also available.', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1611, 104, NULL, 624, 'Push-pull type vertical flow uniform ventilation system', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1612, 104, NULL, 625, '30 Ft x 15 Ft x 15 Ft', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1613, 104, NULL, 626, '7220mm x 4520mm x 2700mm', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1614, 104, NULL, 627, '2900mm x 2670mm x 3 door open', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1615, 104, NULL, 628, '15 Ft x 15 Ft, front', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1616, 104, NULL, 629, 'Upper: 40W x 4 light, 10 units Lower: 40 W x 2 light, 10 units, Total 2400 W (Power consumption 2010W)', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1617, 104, NULL, 630, 'Insulation sandwich panel 35mm thick (Galvanized ground copper plate 0.5t)', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1618, 104, NULL, 631, 'Bag filter 484mm x 646mm x 3 sets', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1619, 104, NULL, 632, '1060mm x 1675mm x 16 sheets', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1620, 104, NULL, 633, '750mm x 1000mm, 6 sheets', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1621, 104, NULL, 634, 'Air supply fan/sirocco fan specification three phase 220V, 7.5 kw high efficiency motor air flow/420-440m3/min.', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1622, 104, NULL, 635, 'Riello kerosene gun type burner with 250000 kcal/hour. ', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1623, 104, NULL, 636, 'Max 80 Degree Celsius ', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1624, 104, NULL, 637, 'Paint-Dry-After purge Mode switching and internal pressure automatic control original control box (touch panel type).', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1625, 104, NULL, 638, 'Vibration sensor, after purge, inverter abnormal thermal trip, misfire alarm (gas pressure drop, wind pressure drop, high temperature abnormality)', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1626, 104, NULL, 639, 'Three phase 220V 16 to 18 kw single phase 220V 2.5-3.5 kw', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1627, 104, NULL, 640, 'Dex blue undeck thread noble brown ', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1628, 104, NULL, 641, 'Transformer box (1 source pressure, 1 pressure regulation auto drain) Outlet box (100 V x 2, 200V 20A, 200V 30A) Parts hanger (moveable to the centre of the booth) lighting window panic door horizontal storage box (medium) 1 (light weight)', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1629, 104, NULL, 642, 'The new original heat exchanger has larger hear transfer area, has the same heating calories as the conventional type and has a faster heating time, saving 15% energy.', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1630, 104, NULL, 643, 'The new fluorescent ballast is used for indoor lighting, reducing power consumption by 11.5 W per 40 W type compared to conventional steel ballast (approximately 25%=Hf stable period + equivalent to Hf dedicated lamp) the new ballast uses a conventional fluorescent lamp and is economical.', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1631, 104, NULL, 644, 'To be provided', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1632, 104, NULL, 645, 'To be provided', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1633, 104, NULL, 646, 'To be provided', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1634, 104, NULL, 647, 'To be provided', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1635, 104, NULL, 648, 'To be provided', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1636, 104, NULL, 649, 'To be provided', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1637, 104, NULL, 650, 'This exhaust unit created as a result of thoroughly pursuing the easy of cleaning and replacement of the exhaust filter. An exhaust fan is also built in the unit.', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1638, 104, NULL, 651, 'To be provided', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1639, 104, NULL, 652, 'To be provided', 3, NULL, '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1640, 104, NULL, 653, 'To be provided', 2, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1641, 104, NULL, 654, 'All type of software required for the machine to be supplied and updated online free of cost for ever', 1, '', '2023-04-15 16:18:05', '2023-04-15 16:18:05'),
(1642, 105, NULL, 611, 'Leo Enterprise, Dhaka, Bangladesh', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1643, 105, NULL, 612, 'BAJ International Co.Ltd, Japan', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1644, 105, NULL, 613, 'Not before the year of contract ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1645, 105, NULL, 614, 'FIRAT', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1646, 105, NULL, 615, 'FBK 8000', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1647, 105, NULL, 616, 'Turkey', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1648, 105, NULL, 617, 'Turkey', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1649, 105, NULL, 618, 'Turkey', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1650, 105, NULL, 619, 'Available with flow 36,000 m3/h', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1651, 105, NULL, 620, 'The celling filter will cover all the ceiling. It will be EU5 (m5) standard, which is bets in the sector.', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1652, 105, NULL, 621, 'Filters are fixed to the celling with the help of the filter frames, which is very easiest to change. ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1653, 105, NULL, 622, 'The touch screen control panel is developed by our own company and it is easy to operate, the inverter is connected to the control panel and it makes you control the processes easily and safely  The touch screen control panel is easy to use and connected with inverter to keep the pressure uniform inside the oven during the processes. The air circulation is full down draft (from ceiling to the floor vertical air movement) and the four leaf front door will allow you to see through. The side door is booth used as a service door and safety door. The dimensions of the entrance door are 3600 mm (wide) and 3865 (height)  ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1654, 105, NULL, 623, 'a. The emblem at the top of the front is also renewed and the new Zero Nano is a new face.\nb. A vertically long glass window with excellent visibility is used to achieve both function and design. An optional panic door is also available. ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1655, 105, NULL, 624, 'Push-pull type vertical flow uniform ventilation system', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1656, 105, NULL, 625, '30 Ft x 15 Ft x 15 Ft', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1657, 105, NULL, 626, '7220mm x 4520mm x 2700mm', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1658, 105, NULL, 627, '2900mm x 2670mm x 3 door open', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1659, 105, NULL, 628, '15 Ft x 15 Ft, front', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1660, 105, NULL, 629, 'Upper: 40W x 4 light, 10 units Lower: 40 W x 2 light, 10 units, Total 2400 W (Power consumption 2010W)', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1661, 105, NULL, 630, 'Insulation sandwich panel 35mm thick (Galvanized ground copper plate 0.5t)', 2, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1662, 105, NULL, 631, 'Bag filter 484mm x 646mm x 3 sets', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1663, 105, NULL, 632, '1060mm x 1675mm x 16 sheets', 2, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1664, 105, NULL, 633, '750mm x 1000mm, 6 sheets', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1665, 105, NULL, 634, 'Air supply fan/sirocco fan specification three phase 220V, 7.5 kw high efficiency motor air flow/420-440m3/min.', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1666, 105, NULL, 635, 'Fuel/gas (Propane/city gas) or kerosene gun type burner  250000 kcal/h (gas burner) gun type burner 240000kcal/h (kerosene burner)', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1667, 105, NULL, 636, 'Max 80 Degree Celsius ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1668, 105, NULL, 637, 'Paint-dry after purge mode switching and internal pressure automatic control original control box (touch panel type)', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1669, 105, NULL, 638, 'Vibration sensor, after purge, inverter abnormal thermal trip, misfire alarm (gas pressure drop, wind pressure drop, high temperature abnormality)', 2, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1670, 105, NULL, 639, 'Three phase 220V 16 to 18 kw single phase 220V 2.5-3.5 kw', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1671, 105, NULL, 640, 'Dex blue undeck thread noble brown ', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1672, 105, NULL, 641, 'Transformer box (1 source pressure, 1 pressure regulation auto drain) Outlet box (100 V x 2, 200V 20A, 200V 30A) Parts hanger (moveable to the centre of the booth) lighting window panic door horizontal storage box (medium) 1 (light weight)', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1673, 105, NULL, 642, 'The new original heat exchanger has larger hear transfer area, has the same heating calories as the conventional type and has a faster heating time, saving 15% energy.', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1674, 105, NULL, 643, 'The new fluorescent ballast is used for indoor lighting, reducing power consumption by 11.5 W per 40 W type compared to conventional steel ballast (approximately 25%=Hf stable period + equivalent to Hf dedicated lamp) the new ballast uses a conventional fluorescent lamp and is economical.', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1675, 105, NULL, 644, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1676, 105, NULL, 645, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1677, 105, NULL, 646, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1678, 105, NULL, 647, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1679, 105, NULL, 648, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1680, 105, NULL, 649, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1681, 105, NULL, 650, 'This exhaust unit created as a result of thoroughly pursuing the easy of cleaning and replacement of the exhaust filter. An exhaust fan is also built in the unit.', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1682, 105, NULL, 651, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1683, 105, NULL, 652, 'To be provided', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1684, 105, NULL, 653, 'To be provided', 2, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1685, 105, NULL, 654, 'All type of software required for the machine to be supplied and updated online free of cost for ever', 1, '', '2023-04-15 16:55:55', '2023-04-15 16:55:55'),
(1690, 108, NULL, 888, 'Auxiliary Power Unit (Small Capacity) also named as Ground Power Unit', 2, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1691, 108, NULL, 889, 'Brand: TLD Make: TLD Asia (Shanghai) Limited ', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1692, 108, NULL, 890, 'GPU-406-T-CUP-28 (Suffix T means TLD Generator, suffix CUP means Cummins Engine and suffix 28 means GPU with 28VDC output)', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1693, 108, NULL, 891, 'China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1694, 108, NULL, 892, 'China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1695, 108, NULL, 893, 'China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1696, 108, NULL, 894, 'Brand new and not before the calendrer year of the contract', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1697, 108, NULL, 895, 'TLD Asia (Shanghai) Limited Address: No.1 Xuanzhong Road, Pudong New District, Shanghai 201399, China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1698, 108, NULL, 896, 'TLD Asia Limited Address: Unit 1412, Fo Tan Industrial Centre, 26-28 Au Pui Street, Shatin, N.T, Hong Kong', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1699, 108, NULL, 897, 'Next Generation Graphics Ltd Address: House # 14, Road # 05, Sector # 01, Uttara, Dhaka-1230, Bangladesh', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1700, 108, NULL, 898, 'Diesel engine drive generator. ', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1701, 108, NULL, 899, 'The GPU unit is mounted on a galvanized steel fabricated trailer with a tow bar and four wheels. ', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1702, 108, NULL, 900, '', 0, NULL, '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1703, 108, 1702, 901, 'Overall length approx. 113\" (2871mm)', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1704, 108, 1702, 902, 'Overall Width approx. 68\" (1724 mm)', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1705, 108, 1702, 903, 'Overall Height approx. 65\" (1652 mm)', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1706, 108, NULL, 904, '', 0, NULL, '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1707, 108, 1706, 905, 'Approx. 2114 kg', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1708, 108, NULL, 906, '', 0, NULL, '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1709, 108, 1708, 907, 'Towbar actuated parking brake when towbar is raised up. ', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1710, 108, 1708, 908, 'Emergency brake is applied when towbar is dropped down in case towbar is dropped off accidentally during towing by tractor', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1711, 108, 1708, 909, 'Towbar actuated parking brake acting on front wheels', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1712, 108, NULL, 910, '', 0, NULL, '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1713, 108, 1712, 911, 'TLD', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1714, 108, 1712, 912, 'B1611-XX', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1715, 108, 1712, 913, 'Lanzhou Electric Corporation. ', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1716, 108, 1712, 914, 'China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1717, 108, 1712, 915, 'China', 1, '', '2023-04-17 09:31:35', '2023-04-17 09:31:35'),
(1718, 108, 1712, 916, 'China', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1719, 108, 1712, 917, 'Brand new and not before the calendar year of contract', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1720, 108, NULL, 918, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1721, 108, 1720, 919, '60 KVA (Must be Compatible with Engine and Alternator)', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1722, 108, 1720, 920, '60 KVA ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1723, 108, NULL, 921, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1724, 108, 1723, 922, 'CUMMINS', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1725, 108, 1723, 923, 'QSB4.5', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1726, 108, 1723, 924, 'CUMMINS Inc', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1727, 108, 1723, 925, 'USA', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1728, 108, 1723, 926, 'USA', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1729, 108, 1723, 927, 'USA', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1730, 108, 1723, 928, 'Diesel', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1731, 108, 1723, 929, '130HP @ 2000 rpm', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1732, 108, 1723, 930, '620 Nm @ 1500 rpm', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1733, 108, 1723, 931, 'Turbocharged', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1734, 108, 1723, 932, '4 Cylinders ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1735, 108, 1723, 933, '4.5 liters', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1736, 108, 1723, 934, '2000 rpm', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1737, 108, 1723, 935, '176~236 g/kW-hr various with engine speed and load', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1738, 108, 1723, 936, 'Water -cooled', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1739, 108, 1723, 937, '24 VDC', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1740, 108, 1723, 938, 'Two batteries, each battery is 12 V, 100 Ah.  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1741, 108, 1723, 939, '17.2:1', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1742, 108, 1723, 940, '46 gallons (174 litres)', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1743, 108, NULL, 941, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1744, 108, 1743, 942, 'TLD', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1745, 108, 1743, 943, 'B1611-XX ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1746, 108, 1743, 944, 'Brushless revolving field high efficiency AC generator with high density copper stator winding integral cooling fan.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1747, 108, 1743, 945, 'Lanzhou Electric Corporation. ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1748, 108, 1743, 946, 'China', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1749, 108, 1743, 947, 'China', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1750, 108, 1743, 948, 'China', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1751, 108, 1743, 949, '(a)   Prime: 60 KVA @ 1.0 pf/60 KW  (b)   Standby: 60 KVA @ 1.0 pf/60 KW ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1752, 108, 1743, 950, 'There are two parts of the GPU outputs. First part is the AC output (60 KVA) and the full load output current is 174 A. The second part is DC output (28.5 VDC) and the continuous current rating (Minimum rating) is 600A up to peak current rating 2500A (Maximum rating).', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1753, 108, 1743, 951, 'Self-contained air cooling system', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1754, 108, 1743, 952, 'AC: 115/200 VAC, 400 Hz, 3 Phase,  DC: 22-30 VDC with 28.5VDC nominal', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1755, 108, 1743, 953, '1', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1756, 108, 1743, 954, '2000 rpm ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1757, 108, 1743, 955, '24 ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1758, 108, NULL, 956, 'Following tools kit to be supplied with the each stores :Part No	Description	Qty NPN	Hand Tools Box Include:	   01 Set 	1 EA Tools Box	 	1 SET Hex wrench 1.5-10 MM	 	1 SET Screwdriver (different size)-8 pcs	 	1 SET Socket key 6-32 mm	 	1 EA Needle-Nose Pliers	 	1 EA Combination Pliers	 	1 EA Diagonal Cutting Pliers	 	1 EA Wrench 10”	 	1 EA Metallic tape	 	1 EA Grease-Gun	 	1 EA Filter – wrench  	 	1 Set Trye wrench	', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1759, 108, NULL, 957, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1760, 108, 1759, 958, 'DC output must be incorporated with the filtering so as to reduce the radio interference during operation', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1761, 108, 1759, 959, 'Auto adjusting DC output, APU to be  fitted an internal line drop compensation to ensure at all time a stable voltage of 28 VDC at the end of the electric cables and accurate adjustment of the exciting voltage is done accordingly to the needed amperage to guarantee the output voltage required by military aircrafts. This way, both voltage 28 VDC and 115-200 VAC can be supplied simultaneously, which is necessary for numerous military aircrafts', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1762, 108, 1759, 960, 'Automatic voltage regulator is controlled digitally by generator control module (GCM2) with automatic line drop compensation for precise and stable 28.5 V DC output.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1763, 108, 1759, 961, 'Automatic voltage regulator is controlled digitally by generator control module (GCM2) with automatic line drop compensation for precise and stable 28.5 V DC output.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1764, 108, 1759, 962, 'DC output (28.5 VDC) with continuous current rating (Minimum rating) 600A and up to peak current rating 2500A (Maximum rating). ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36');
INSERT INTO `supplier_item_specifications` (`id`, `supplier_item_id`, `parent_id`, `specification_id`, `received_specification`, `verify_status`, `reason`, `created_at`, `updated_at`) VALUES
(1765, 108, 1759, 963, 'All necessary protection, controls and instrument. Input contractors, power ‘ON’ pushbutton, power ‘OFF’ pushbutton, DC output indicator light, over volt protection switch, DC Voltmeter & DC Ammeter are shown in LCD color display on the GCM2', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1766, 108, NULL, 964, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1767, 108, 1766, 965, 'Automatic voltage regulator is controlled digitally (Solid-state) by generator control module (GCM2). Voltage regulation: +/- 1% over full load range', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1768, 108, 1766, 966, '(1) Contactors  (2) Power ‘ON’ light shown on LCD Display  (3) Power ‘ON-‘OFF’ switch (4) Voltmeter- shown on LCD Display (5) Ammeter shown on LCD Display  (6) Frequency meter shown on LCD Display  (7) Current Transducer (8) Voltage Trimmer for adjustment output voltage within 15% of nominal value', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1769, 108, NULL, 967, 'Two batteries each battery is 12 VDC, 100 Ah.  (1) Brand: Bolder, Model: G31-750, Country of Origin: China, Manufacture: Shanghai Bolder Battery Co, Ltd and Year of Production: 2021 (2) Volt: 2 x 12 VDC and Capacity: 100 AH', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1770, 108, NULL, 968, 'a. The Auxiliary Power Unit (APU) is mounted on a heavy duty trailer with 4 wheels b. Brand of tyre: Chaoyang.  Tire size: 20.5 x 8.0-10 c. Rim size: 7 x 6.00   d. Tyre pattern: GS67', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1771, 108, NULL, 969, 'Heavy duty fiberglass panels and power coated aluminum doors on GPU unit with hot-dip galvanized cable trays and trailer. The most corrosion resistant GPU in the market', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1772, 108, NULL, 970, 'Towing purpose of GPU trailer there is a tow bar equipped at front. The tow bar end is a tow hook (normally called tow eye) for connection to tow hitch of tractor for towing. We will provide a tow hook at front and  rear but the maximum towing capacity is 1100 Lbs', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1773, 108, NULL, 971, 'The GPU unit features a brushless, high efficiency generator running at an optimized 2000 rpm providing improved fuel efficiency and reduced sound level', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1774, 108, NULL, 972, '', 0, NULL, '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1775, 108, 1774, 973, '(1) Unit will be shutdown with fault indication latched under frequency or over frequency protection.  (2) Unit will be shutdown with fault indication latched under voltage or over voltage protection.  (3) Unit will be shutdown with fault indication latched Overload protection system.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1776, 108, 1774, 974, '(1) Unit will be shutdown under low oil pressure condition with fault indication shown on the LCD display. (2) Unit will be shutdown under High coolant temperature condition with fault indication shown on the LCD display. (3) Engine over speed protection is standard on engine.  (4) Low fuel warning and shutdown, low-load ramp-down, no load shutdown, warm up and cool down cycles and emergency stop are standard features.  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1777, 108, NULL, 975, 'Rear/Front spot lights to be provided', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1778, 108, NULL, 976, 'The Auxiliary Power Unit (APU) should have engine failure and electric Under/over voltage audio, visual warnings system', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1779, 108, NULL, 977, 'This is not available from TLD design because of safety concern. As explained before there is potential danger when using this power socket because the 28 VDC output to aircraft has to be active even it is not connected to aircraft ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1780, 108, NULL, 978, 'a. One of 115/200 VAC, 400Hz, 3 phase at least 12 meters long output cables insulated sheathed in a standard 06 pin aircraft adapter. b. One of 28.5 VDC 600-2000 Amps cables will be fitted with standard aircraft three pins. Flat Adapter with cable will be at least 12 meter long. ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1781, 108, NULL, 979, 'a. GPU system cable box is the cable tray and it is integrated on two sides of the trailer and those cables are stored inside. The cable plugs are inserted in the cable plug holders during cable storage so that the whole cable assembly are rain protected.  b. Mechanical storing of cable by cable plug holder, easy to handle.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1782, 108, NULL, 980, 'a. Canopies and cabin will be golden yellow gloss color.  b. Cable boxes will be painted with standard black color.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1783, 108, NULL, 981, 'Bill of Quantity/Material (BOQ/BOM) of Standard Items  Ser	Name of Item	Part No (If Any)	Qty	Country of Manufacture 01.	Generator for Auxiliary Power Unit	B1611-XX	01	China  02.	Engine	CUMMINS ASB4.5	01	USA 03.	Transformer Rectifier Unit (TRU) system	-	01	China 04.	Generator Control Module (GCM2)	-	01	USA 05.	Battery 12 VDC 100 AH	G13-750	02	China 06.	Tire and wheel	Tyre size-20.5 x 8.0-10 Rim size: 7 x 6.00	04	China 07.	AC output power cable	-	01	USA 08.	DC output power cable	-	01	USA ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1784, 108, NULL, 982, 'Not applicable', 2, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1785, 108, NULL, 983, 'Miscellaneous:  Following Items/Accessories are to be supplied with the Auxiliary Power Unit (APU) by the supplier: One Dry chemicals fire extinguisher of capacity 2.5 kg for each APU One spare wheel assembly (loose) completes with tyre and tube for each APU. One set, Quantity -02(Two) applicable jack for each APU. Wheel removing tools for each APU.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1786, 108, NULL, 984, 'Normal diesel fuel for use in aviation/airport equipment available in Bangladesh. Normal engine lubricating oil equivalent to EMA DHD-1, API CH-4 with viscosity grade at SAE 15W40. Not applicable as there is no gearbox system in the GPU unit.', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1787, 108, NULL, 985, 'To be provided', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1788, 108, NULL, 986, 'Not applicable ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1789, 108, NULL, 987, 'CONSOLIDATED TRG AND TRG DETAILS FOR AUXILIARY POWER UNIT (SMALL CAPACITY) FOR UN MSN THE FY 2020-2021    Ser	Nomenclature	Qty	Nature of Trg	Duration 	No of students 	Remarks 					Functional/User 	Repair, Maint and trouble shooting (EME)	Inventory Con and Mgt Aspect (Ord)	 1. 	Auxiliary Power Unit (Small Capacity) 	02 	Local trg 	02 wks 	06 Pers 	-	-	Detail trg program will be given by vendors/supplier  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1790, 108, NULL, 988, 'CONSOLIDATED TRG AND TRG DETAILS FOR AUXILIARY POWER UNIT (SMALL CAPACITY) FOR UN MSN THE FY 2020-2021    Ser	Nomenclature	Qty	Nature of Trg	Duration 	No of students 	Remarks 					Functional/User 	Repair, Maint and trouble shooting (EME)	Inventory Con and Mgt Aspect (Ord)	 1. 	Auxiliary Power Unit (Small Capacity) 	02 	Local trg 	02 wks 	06 Pers 	-	-	Detail trg program will be given by vendors/supplier  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1791, 108, NULL, 989, 'CONSOLIDATED TRG AND TRG DETAILS FOR AUXILIARY POWER UNIT (SMALL CAPACITY) FOR UN MSN THE FY 2020-2021    Ser	Nomenclature	Qty	Nature of Trg	Duration 	No of students 	Remarks 					Functional/User 	Repair, Maint and trouble shooting (EME)	Inventory Con and Mgt Aspect (Ord)	 1. 	Auxiliary Power Unit (Small Capacity) 	02 	Local trg 	02 wks 	06 Pers 	-	-	Detail trg program will be given by vendors/supplier  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1792, 108, NULL, 990, 'CONSOLIDATED TRG AND TRG DETAILS FOR AUXILIARY POWER UNIT (SMALL CAPACITY) FOR UN MSN THE FY 2020-2021    Ser	Nomenclature	Qty	Nature of Trg	Duration 	No of students 	Remarks 					Functional/User 	Repair, Maint and trouble shooting (EME)	Inventory Con and Mgt Aspect (Ord)	 1. 	Auxiliary Power Unit (Small Capacity) 	02 	Local trg 	02 wks 	06 Pers 	-	-	Detail trg program will be given by vendors/supplier  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1793, 108, NULL, 991, 'APPX 1 OF ANX A TO  IE&I LTR NO 23.01.901.051.03.192.03.24.06.21  DT:        JUN 2021  SPECIAL SERVICES TOOLS (SST), SPECIAL SERVICES MATERIALS (SSM), BOOKS & PUBLICATIONS AND FAST & SLOW MOVING SPARE PARTS FOR NIV AUXILIARY POWER UNIT (SMALL CAPACITY), QTY-02 NOS   Ser	Part no	Nomenclature	A/U	Qty	Rmks Analyzer/measuring & testing/fault finding and diagnostic set			 		Not Reqr			 Special Service Tools (SST) 		Not Reqr			 Special Service Materials (SSM) 		Not Reqr			 Fast & Slow Moving Spare parts  1.	1033394-P2	Filter, Oil	No	10	 2.	1033613	Fuse, 125 Amp rating	“	10	 3.	1033691-P3	1033691-P3	“	10	 4.	1036140	Resistor	“	10	 5.	1037763-P1	Element, Fuel Filter	“	10	 6.	1037763-P2	Element, Fuel Filter Water Sep	“	10	 7.	1038783-P19	Seal, Hub	“	10	 8.	1040720-P10	Sensor, Coolant Temp	“	05	 9.	1042011-P4	Bearing Race, Outer	“	04	 10.	1045199	Switch, Pressure, 20 PSI, NC	“	02	 11.	1145185	Indicator, Restriction 6.2 KPA	“	02	 12.	38935	Amber Flashing Beacon 3W 12-11		02	 Books and Publications				 Ser	Nomenclature	Qty  1.	Owners/Operators Manual in English (Book Type)	01 x Hard copy original (Book type) for each equipment and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  2.	Workshop/Repair Manual in English (Book Type)	a. 06 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  b. Online workshop/repair software to be mentioned.  3.	100% Updated Master Spare Parts Catalogue in English (Book Type)	08 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.   4.	Updated Master Spare Parts Price Catalogue/List in English (Book Type) 	02 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36'),
(1794, 108, NULL, 992, 'APPX 1 OF ANX A TO  IE&I LTR NO 23.01.901.051.03.192.03.24.06.21  DT:        JUN 2021  SPECIAL SERVICES TOOLS (SST), SPECIAL SERVICES MATERIALS (SSM), BOOKS & PUBLICATIONS AND FAST & SLOW MOVING SPARE PARTS FOR NIV AUXILIARY POWER UNIT (SMALL CAPACITY), QTY-02 NOS   Ser	Part no	Nomenclature	A/U	Qty	Rmks Analyzer/measuring & testing/fault finding and diagnostic set			 		Not Reqr			 Special Service Tools (SST) 		Not Reqr			 Special Service Materials (SSM) 		Not Reqr			 Fast & Slow Moving Spare parts  1.	1033394-P2	Filter, Oil	No	10	 2.	1033613	Fuse, 125 Amp rating	“	10	 3.	1033691-P3	1033691-P3	“	10	 4.	1036140	Resistor	“	10	 5.	1037763-P1	Element, Fuel Filter	“	10	 6.	1037763-P2	Element, Fuel Filter Water Sep	“	10	 7.	1038783-P19	Seal, Hub	“	10	 8.	1040720-P10	Sensor, Coolant Temp	“	05	 9.	1042011-P4	Bearing Race, Outer	“	04	 10.	1045199	Switch, Pressure, 20 PSI, NC	“	02	 11.	1145185	Indicator, Restriction 6.2 KPA	“	02	 12.	38935	Amber Flashing Beacon 3W 12-11		02	 Books and Publications				 Ser	Nomenclature	Qty  1.	Owners/Operators Manual in English (Book Type)	01 x Hard copy original (Book type) for each equipment and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  2.	Workshop/Repair Manual in English (Book Type)	a. 06 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  b. Online workshop/repair software to be mentioned.  3.	100% Updated Master Spare Parts Catalogue in English (Book Type)	08 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.   4.	Updated Master Spare Parts Price Catalogue/List in English (Book Type) 	02 x Hard copies original (Book type) and 01 x CD/DVD (Soft copy) to be provided with supply of the equipment.  ', 1, '', '2023-04-17 09:31:36', '2023-04-17 09:31:36');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `items_item_name_index` (`item_name`),
  ADD KEY `items_demand_no_index` (`demand_no`);

--
-- Indexes for table `item_specifications`
--
ALTER TABLE `item_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `item_specifications_item_id_foreign` (`item_id`),
  ADD KEY `item_specifications_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supplier_items`
--
ALTER TABLE `supplier_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_items_demand_no_index` (`demand_no`);

--
-- Indexes for table `supplier_item_specifications`
--
ALTER TABLE `supplier_item_specifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_item_specifications_supplier_item_id_foreign` (`supplier_item_id`),
  ADD KEY `supplier_item_specifications_parent_id_foreign` (`parent_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `item_specifications`
--
ALTER TABLE `item_specifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=993;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `supplier_items`
--
ALTER TABLE `supplier_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `supplier_item_specifications`
--
ALTER TABLE `supplier_item_specifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1795;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `item_specifications`
--
ALTER TABLE `item_specifications`
  ADD CONSTRAINT `item_specifications_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `item_specifications_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `item_specifications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `supplier_item_specifications`
--
ALTER TABLE `supplier_item_specifications`
  ADD CONSTRAINT `supplier_item_specifications_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `supplier_item_specifications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `supplier_item_specifications_supplier_item_id_foreign` FOREIGN KEY (`supplier_item_id`) REFERENCES `supplier_items` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
