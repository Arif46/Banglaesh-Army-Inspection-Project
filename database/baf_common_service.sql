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
-- Database: `baf_common_service`
--

-- --------------------------------------------------------

--
-- Table structure for table `assign_designations`
--

CREATE TABLE `assign_designations` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `office_type_id` bigint UNSIGNED NOT NULL,
  `office_id` bigint UNSIGNED NOT NULL,
  `designation_id` bigint UNSIGNED NOT NULL,
  `approved_post` int DEFAULT NULL,
  `sorting_order` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assign_designations`
--

INSERT INTO `assign_designations` (`id`, `org_id`, `office_type_id`, `office_id`, `designation_id`, `approved_post`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(4, 11, 5, 4, 6, 10, 1, NULL, NULL, 1, '2022-06-22 03:08:46', '2022-06-22 03:08:46'),
(5, 11, 5, 4, 5, 5, 2, NULL, NULL, 1, '2022-06-22 03:15:02', '2022-06-22 03:15:02'),
(6, 11, 3, 5, 8, 3, 3, NULL, NULL, 1, '2022-07-04 03:08:49', '2022-07-04 03:08:49'),
(7, 11, 2, 2, 6, 10, 4, NULL, NULL, 1, '2022-07-04 04:06:06', '2022-07-04 04:06:06'),
(8, 10, 12, 6, 9, 3, 5, NULL, NULL, 1, '2022-07-25 07:55:29', '2022-07-25 07:55:29'),
(9, 10, 12, 6, 11, 5, 6, NULL, NULL, 1, '2022-07-27 02:59:56', '2022-07-27 02:59:56'),
(10, 10, 12, 6, 10, 4, 7, NULL, NULL, 1, '2022-07-27 03:00:46', '2022-07-27 03:00:46'),
(11, 2, 14, 7, 12, 1, 1, NULL, NULL, 1, '2022-08-03 05:31:01', '2022-08-03 05:31:01'),
(12, 2, 14, 7, 13, 1, 2, NULL, NULL, 1, '2022-08-03 05:31:18', '2022-08-03 05:31:18'),
(13, 2, 14, 7, 14, 5, 3, NULL, NULL, 1, '2022-08-03 05:41:39', '2022-11-14 08:37:41'),
(14, 10, 12, 6, 15, 2, 8, NULL, NULL, 1, '2022-08-07 06:56:12', '2022-08-07 06:56:12'),
(15, 1, 15, 8, 3, 2, 6, NULL, NULL, 1, '2022-08-16 08:30:33', '2022-08-16 08:30:33'),
(16, 1, 15, 8, 17, 3, 3, NULL, NULL, 1, '2022-08-16 08:30:51', '2022-08-16 08:30:51'),
(17, 11, 3, 9, 8, 2, 9, NULL, NULL, 1, '2022-09-11 10:13:32', '2022-09-11 10:13:32'),
(18, 7, 18, 11, 21, 1, 10, NULL, NULL, 1, '2022-09-21 03:24:26', '2022-09-21 03:24:26'),
(19, 7, 17, 23, 18, 1, 11, NULL, NULL, 1, '2022-09-21 03:28:24', '2022-09-21 03:28:24'),
(20, 7, 17, 24, 19, 2, 12, NULL, NULL, 1, '2022-09-21 03:28:40', '2022-09-21 03:28:40'),
(21, 7, 17, 25, 20, 1, 13, NULL, NULL, 1, '2022-09-21 03:28:52', '2022-09-21 03:28:52'),
(22, 11, 3, 26, 8, 100, 14, NULL, NULL, 1, '2022-09-25 07:51:19', '2022-09-25 07:51:19'),
(23, 11, 2, 10, 8, 45, 15, NULL, NULL, 1, '2022-09-25 08:04:08', '2022-09-25 08:04:08'),
(24, 11, 2, 10, 6, 80, 16, NULL, NULL, 1, '2022-09-25 08:22:46', '2022-09-25 08:22:46'),
(25, 10, 12, 6, 22, 2, 17, NULL, NULL, 1, '2022-10-04 06:43:22', '2022-10-04 06:43:22'),
(26, 5, 19, 27, 23, 1, 18, NULL, NULL, 1, '2022-10-23 02:59:44', '2022-10-23 02:59:44'),
(27, 5, 19, 27, 24, 2, 19, NULL, NULL, 1, '2022-10-23 03:00:06', '2022-10-23 03:00:06'),
(28, 5, 19, 27, 25, 1, 20, NULL, NULL, 1, '2022-10-23 03:11:43', '2022-10-23 03:11:43'),
(29, 5, 19, 27, 26, 1, 21, NULL, NULL, 1, '2022-10-23 03:19:55', '2022-10-23 03:19:55'),
(30, 5, 21, 29, 27, 50, 22, NULL, NULL, 1, '2022-10-23 03:47:47', '2022-10-23 03:47:47'),
(31, 5, 21, 29, 28, 50, 23, NULL, NULL, 1, '2022-10-23 03:49:21', '2022-10-23 03:49:21'),
(32, 5, 21, 29, 29, 1, 24, NULL, NULL, 1, '2022-10-23 03:57:12', '2022-10-23 03:57:12'),
(33, 5, 21, 30, 29, 1, 25, NULL, NULL, 1, '2022-10-23 04:09:05', '2022-10-23 04:09:05'),
(34, 5, 21, 30, 30, 10, 26, NULL, NULL, 1, '2022-10-23 04:22:09', '2022-10-23 04:22:09'),
(35, 5, 20, 28, 27, 10, 27, NULL, NULL, 1, '2022-10-23 04:27:26', '2022-10-23 04:27:26'),
(36, 2, 14, 31, 32, 6, 28, NULL, NULL, 1, '2022-11-06 03:43:03', '2022-11-06 03:43:03'),
(37, 2, 14, 32, 14, 4, 29, NULL, NULL, 1, '2022-11-14 08:38:47', '2022-11-14 08:38:47'),
(38, 2, 14, 32, 13, 2, 30, NULL, NULL, 1, '2022-11-14 08:39:04', '2022-11-14 08:39:04'),
(39, 2, 14, 32, 12, 1, 31, NULL, NULL, 1, '2022-11-14 08:42:18', '2022-11-14 08:42:18'),
(40, 10, 12, 6, 33, 2, 32, NULL, NULL, 1, '2022-11-16 03:52:36', '2022-11-16 03:52:36'),
(41, 10, 12, 6, 16, 10, 33, NULL, NULL, 1, '2022-11-16 05:08:51', '2022-11-16 05:08:51'),
(42, 1, 15, 33, 34, 1, 1, NULL, NULL, 1, '2022-11-28 03:40:51', '2022-11-28 03:40:51'),
(43, 1, 15, 34, 35, 2, 9, NULL, NULL, 1, '2022-11-29 04:12:30', '2022-11-29 04:12:30'),
(44, 5, 22, 35, 36, 2, 34, NULL, NULL, 1, '2022-12-05 11:30:22', '2022-12-05 11:30:22'),
(45, 5, 21, 29, 37, 14, 9, NULL, NULL, 1, '2022-12-13 05:10:53', '2022-12-13 05:10:53'),
(46, 8, 16, 39, 38, 20, 35, NULL, NULL, 1, '2022-12-13 10:07:30', '2022-12-13 10:07:30'),
(47, 10, 12, 6, 39, 7, 36, NULL, NULL, 1, '2022-12-15 04:35:31', '2022-12-15 04:35:31'),
(48, 10, 12, 6, 40, 5, 37, NULL, NULL, 1, '2022-12-15 04:46:09', '2022-12-15 04:46:09'),
(49, 10, 12, 6, 41, 2, 38, NULL, NULL, 1, '2022-12-15 04:52:21', '2022-12-15 04:52:21'),
(50, 7, 18, 11, 42, 10, 39, NULL, NULL, 1, '2023-01-04 06:01:29', '2023-01-12 06:45:52'),
(51, 7, 23, 41, 42, 1, 1, NULL, NULL, 1, '2023-01-09 04:37:17', '2023-01-09 04:37:17'),
(52, 7, 23, 42, 42, 1, 1, NULL, NULL, 1, '2023-01-09 05:18:34', '2023-01-09 05:18:34'),
(53, 7, 23, 43, 42, 5, 40, NULL, NULL, 1, '2023-01-10 09:25:30', '2023-01-10 09:25:30'),
(54, 5, 22, 36, 36, 1, 41, NULL, NULL, 1, '2023-01-11 08:56:19', '2023-01-11 08:56:19'),
(55, 7, 18, 14, 21, 8, 42, NULL, NULL, 1, '2023-01-12 08:39:07', '2023-01-12 08:39:07'),
(56, 7, 18, 45, 43, 1, 43, NULL, NULL, 1, '2023-01-18 08:57:42', '2023-01-18 08:57:42'),
(57, 7, 23, 47, 42, 1, 44, NULL, NULL, 1, '2023-01-26 03:19:12', '2023-01-26 03:19:12'),
(58, 7, 18, 46, 45, 1, 45, NULL, NULL, 1, '2023-02-05 05:38:22', '2023-02-05 05:38:22'),
(59, 7, 18, 16, 43, 2, 46, NULL, NULL, 1, '2023-02-05 05:41:38', '2023-02-05 05:41:38'),
(60, 7, 18, 17, 46, 2, 47, NULL, NULL, 1, '2023-02-05 05:44:39', '2023-02-05 05:44:39'),
(61, 7, 18, 18, 43, 2, 48, NULL, NULL, 1, '2023-02-05 05:47:12', '2023-02-05 05:47:12'),
(62, 7, 18, 19, 45, 2, 49, NULL, NULL, 1, '2023-02-05 05:49:31', '2023-02-05 05:49:31'),
(63, 7, 18, 20, 45, 2, 50, NULL, NULL, 1, '2023-02-05 05:52:43', '2023-02-05 05:52:43'),
(64, 7, 18, 21, 45, 1, 51, NULL, NULL, 1, '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(65, 7, 18, 22, 45, 0, 52, NULL, NULL, 1, '2023-02-05 05:58:51', '2023-02-05 05:58:51'),
(66, 8, 16, 39, 47, 1, 53, NULL, NULL, 1, '2023-02-15 05:28:02', '2023-02-15 05:28:02'),
(67, 8, 16, 39, 48, 1, 54, NULL, NULL, 1, '2023-02-15 05:32:50', '2023-02-15 05:32:50');

-- --------------------------------------------------------

--
-- Table structure for table `cmt_agenda`
--

CREATE TABLE `cmt_agenda` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `cmt_committee_id` bigint UNSIGNED NOT NULL,
  `meeting_number` int NOT NULL,
  `memo_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `memo_issue_date` date NOT NULL,
  `agenda_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `agenda_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `meeting_date` date NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cmt_committees`
--

CREATE TABLE `cmt_committees` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `committee_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `committee_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `formation_date` date NOT NULL,
  `purpose` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL,
  `document_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cmt_committees`
--

INSERT INTO `cmt_committees` (`id`, `org_id`, `committee_name`, `committee_name_bn`, `formation_date`, `purpose`, `purpose_bn`, `duration`, `document_name`, `attachment`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 10, '1', '1', '2022-09-05', '1', '1', 1, '1', '1', 1, 1, 1, '2021-04-07 22:00:00', '2022-09-05 13:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `cmt_committee_members`
--

CREATE TABLE `cmt_committee_members` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `cmt_committee_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cmt_expenses`
--

CREATE TABLE `cmt_expenses` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `cmt_committee_id` bigint UNSIGNED NOT NULL,
  `cmt_agenda_id` bigint UNSIGNED NOT NULL,
  `fiscal_year` int NOT NULL,
  `date` date NOT NULL,
  `amount` double NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cmt_meeting_minutes`
--

CREATE TABLE `cmt_meeting_minutes` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `cmt_committee_id` bigint UNSIGNED NOT NULL,
  `cmt_agenda_id` bigint UNSIGNED NOT NULL,
  `decision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `decision_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attendance_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `document_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `component_designations`
--

CREATE TABLE `component_designations` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `designation_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `component_designations`
--

INSERT INTO `component_designations` (`id`, `org_id`, `component_id`, `designation_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(17, 1, 3, 1, NULL, NULL, 2, '2022-06-18 23:24:42', '2022-06-21 10:44:07'),
(18, 1, 3, 4, NULL, NULL, 2, '2022-06-18 23:24:42', '2022-06-21 10:44:07'),
(21, 1, 1, 1, NULL, NULL, 2, '2022-06-18 23:25:05', '2022-06-21 10:44:12'),
(28, 1, 6, 4, NULL, NULL, 2, '2022-06-18 23:57:00', '2022-06-19 02:09:42'),
(29, 1, 6, 1, NULL, NULL, 2, '2022-06-18 23:57:00', '2022-06-19 02:09:42'),
(30, 1, 6, 3, NULL, NULL, 2, '2022-06-18 23:57:01', '2022-06-19 02:09:42'),
(31, 11, 1, 1, NULL, NULL, 1, '2022-06-21 10:43:16', '2022-06-21 10:43:16'),
(32, 11, 1, 5, NULL, NULL, 1, '2022-06-21 10:43:16', '2022-06-21 10:43:16'),
(33, 11, 3, 1, NULL, NULL, 1, '2022-06-21 10:43:53', '2022-06-21 10:43:53'),
(34, 11, 3, 4, NULL, NULL, 1, '2022-06-21 10:43:53', '2022-06-21 10:43:53'),
(35, 11, 3, 6, NULL, NULL, 1, '2022-06-21 10:43:53', '2022-06-21 10:43:53'),
(40, 2, 10, 14, NULL, NULL, 1, '2022-08-03 06:20:27', '2022-08-03 06:20:27'),
(41, 2, 10, 13, NULL, NULL, 1, '2022-08-03 06:20:27', '2022-08-03 06:20:27'),
(42, 2, 10, 12, NULL, NULL, 1, '2022-08-03 06:20:27', '2022-08-03 06:20:27'),
(43, 10, 6, 9, NULL, NULL, 1, '2022-10-04 07:48:13', '2022-10-04 07:48:13'),
(44, 10, 6, 11, NULL, NULL, 1, '2022-10-04 07:48:13', '2022-10-04 07:48:13'),
(45, 10, 6, 10, NULL, NULL, 1, '2022-10-04 07:48:13', '2022-10-04 07:48:13'),
(46, 10, 6, 15, NULL, NULL, 1, '2022-10-04 07:48:13', '2022-10-04 07:48:13'),
(50, 2, 9, 14, NULL, NULL, 1, '2022-11-14 08:32:54', '2022-11-14 08:32:54'),
(51, 2, 9, 13, NULL, NULL, 1, '2022-11-14 08:32:54', '2022-11-14 08:32:54'),
(52, 2, 9, 12, NULL, NULL, 1, '2022-11-14 08:32:55', '2022-11-14 08:32:55'),
(61, 5, 5, 23, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(62, 5, 5, 24, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(63, 5, 5, 26, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(64, 5, 5, 28, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(65, 5, 5, 25, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(66, 5, 5, 27, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(67, 5, 5, 29, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(68, 5, 5, 30, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(69, 5, 5, 36, NULL, NULL, 1, '2022-12-05 11:23:04', '2022-12-05 11:23:04'),
(70, 7, 7, 42, NULL, NULL, 1, '2023-01-26 03:24:55', '2023-01-26 03:24:55');

-- --------------------------------------------------------

--
-- Table structure for table `com_approve`
--

CREATE TABLE `com_approve` (
  `id` bigint UNSIGNED NOT NULL,
  `complain_id` bigint UNSIGNED NOT NULL,
  `approve_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `approve_note_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `com_committees`
--

CREATE TABLE `com_committees` (
  `id` bigint UNSIGNED NOT NULL,
  `complain_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `designation_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `com_committee_reports`
--

CREATE TABLE `com_committee_reports` (
  `id` bigint UNSIGNED NOT NULL,
  `complain_id` bigint UNSIGNED NOT NULL,
  `report_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `report_note_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `com_complain_cycle`
--

CREATE TABLE `com_complain_cycle` (
  `id` bigint UNSIGNED NOT NULL,
  `complain_id` bigint UNSIGNED NOT NULL,
  `sender_id` bigint UNSIGNED NOT NULL,
  `receiver_id` bigint UNSIGNED NOT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '0' COMMENT '0=pending, 1=approve',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `com_complain_infos`
--

CREATE TABLE `com_complain_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `com_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `com_title_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `org_id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `division_id` bigint UNSIGNED NOT NULL,
  `district_id` bigint UNSIGNED NOT NULL,
  `upazila_id` bigint UNSIGNED NOT NULL,
  `union_id` bigint UNSIGNED NOT NULL,
  `mobile_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=pending, 2=processing,3=Presented,4=Rejected,5=Solved,6=Appealed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `com_reject`
--

CREATE TABLE `com_reject` (
  `id` bigint UNSIGNED NOT NULL,
  `complain_id` bigint UNSIGNED NOT NULL,
  `reject_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reject_note_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doc_doc_infos`
--

CREATE TABLE `doc_doc_infos` (
  `id` bigint UNSIGNED NOT NULL,
  `doc_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `doc_title_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive, 3=archive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doc_doc_infos`
--

INSERT INTO `doc_doc_infos` (`id`, `doc_title`, `doc_title_bn`, `attachment`, `org_id`, `category_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(17, 'fasd', 'sadf', 'storage/document/62a5b80391527.xls', 1, 1, NULL, NULL, 1, '2022-06-12 07:55:16', '2022-06-12 07:55:16'),
(18, 'fasd sadfasd', 'asdf', 'storage/document/62a5b83416a54.csv', 2, 1, NULL, NULL, 1, '2022-06-12 07:56:04', '2022-06-12 07:56:04'),
(19, 'fas sadf asf', 'asdf afd asdf', 'storage/document/62a5b86563185.pdf', 2, 2, NULL, NULL, 1, '2022-06-12 07:56:53', '2022-06-12 07:56:53'),
(20, 'sadfas sadfasdfas', 'fasdfasdfd asdfasd', 'storage/document/62a5dbd57ebcb.docx', 1, 1, NULL, NULL, 1, '2022-06-12 10:28:06', '2022-06-12 10:28:06'),
(21, 'fgh', 'df', 'storage/document/62a6f166a8d93.xls', 1, 1, NULL, NULL, 1, '2022-06-13 06:06:50', '2022-06-13 06:12:23'),
(22, 'Document', 'Document bn', 'storage/document/62a6f0b676c36.pdf', 1, 1, NULL, NULL, 1, '2022-06-13 06:09:26', '2022-06-13 06:09:26'),
(23, 'Document title en', 'Document title Bn', 'storage/document/62a6f0f40eef9.pdf', 1, 1, NULL, NULL, 3, '2022-06-13 06:10:28', '2022-06-13 06:51:55');

-- --------------------------------------------------------

--
-- Table structure for table `external_menus`
--

CREATE TABLE `external_menus` (
  `id` bigint UNSIGNED NOT NULL,
  `external_panel_id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sorting_order` int UNSIGNED NOT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '	1=active, 2=inactive	',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_menus`
--

INSERT INTO `external_menus` (`id`, `external_panel_id`, `name`, `name_bn`, `url`, `sorting_order`, `icon`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Dashboard', 'ড্যাশবোর্ড', '/export-trophy-cip-panel/dashboard', 1, 'fa fa-youtube', 1, '2022-06-28 02:37:41', '2022-07-20 09:28:25'),
(2, 1, 'Circular', 'বিজ্ঞপ্তি', '/export-trophy-cip-panel/circular', 2, 'fa fa-faceoobk', 1, '2022-06-28 02:38:24', '2022-07-20 09:28:08'),
(3, 1, 'CIP Application', 'সিআইপি আবেদন', '/export-trophy-cip-panel/cip-application', 3, 'fa fa-facebook', 1, '2022-06-28 02:40:13', '2022-07-20 09:28:37'),
(4, 1, 'Export Trophy Application', 'রপ্তানি ট্রফি আবেদন', '/export-trophy-cip-panel/export-trophy-application', 4, 'fa fa-facebook', 1, '2022-06-28 02:40:53', '2022-08-14 10:26:55'),
(5, 2, 'Dashboard', 'ড্যাশবোর্ড', '/bfti-panel/dashboard', 1, 'fa fa-youtube', 1, '2022-06-29 08:30:16', '2022-06-29 08:30:16'),
(6, 2, 'Research & Other Request', ' গবেষণা এবং অন্যান্য অনুরোধ', '/bfti-panel/research-and-other-request-list', 2, 'fas fa-clipboard-list', 1, '2022-06-29 09:43:58', '2022-06-30 06:25:22'),
(7, 2, 'Policy Review Request', 'পলিসি পর্যালোচনার  অনুরোধ', '/bfti-panel/policy-request-entry', 3, 'fas fa-clipboard-list', 1, '2022-07-17 08:11:31', '2022-10-10 10:53:18'),
(8, 2, 'Receive meeting notice', 'প্রাপ্ত মিটিং নোটিশ', '/bfti-panel/receive-meeting-notice', 4, 'fas fa-clipboard-list', 2, '2022-07-23 06:16:07', '2022-09-21 09:41:54'),
(9, 1, 'Published Gazettes', 'প্রকাশিত গেজেট', '/export-trophy-cip-panel/gazettes', 5, 'fa fa-facebook', 1, '2022-07-23 07:33:24', '2022-07-23 07:33:24'),
(10, 3, 'License Application', 'লাইসেন্স আবেদন', '/dealer-panel/applications', 1, 'fa fa-icon', 1, '2022-07-25 04:42:43', '2022-07-25 04:44:16'),
(11, 3, 'Allocation Letter', 'বরাদ্দ পত্র', '/dealer-panel/allocation-letter', 2, 'fa fa-email', 1, '2022-07-25 04:47:25', '2022-07-25 04:47:25'),
(12, 3, 'Complain', 'অভিযোগ', '/dealer-panel/complain', 3, 'fa fa-complain', 1, '2022-07-25 04:48:27', '2022-07-25 04:48:27'),
(13, 3, 'FAQ', 'প্রশ্ন ও উত্তর', '/dealer-panel/faq', 4, 'fa fa-faq', 1, '2022-07-25 04:50:13', '2022-07-25 04:50:13'),
(14, 1, 'CIP Award Invitation', 'সিআইপি পুরস্কারের আমন্ত্রণ', '/export-trophy-cip-panel/cip-award-invitation', 6, 'fa fa-facebook', 1, '2022-07-26 02:33:33', '2022-07-26 02:39:56'),
(15, 1, 'Export Trophy Award Invitation', 'রপ্তানি ট্রফি পুরস্কার আমন্ত্রণ', '/export-trophy-cip-panel/export-trophy-award-invitation', 7, 'fa-fa-facebok', 1, '2022-07-26 07:06:44', '2022-07-26 07:06:44'),
(16, 2, 'Survey List', 'জরিপ ফর্ম', '/bfti-panel/survey-list', 5, 'fas fa-clipboard-list', 1, '2022-09-21 09:41:42', '2022-09-21 09:41:42'),
(17, 4, 'Dashboard', 'ড্যাশবোর্ড', '/lrcpn-panel/dashboard', 1, 'fa fa-youtube', 1, '2022-10-03 07:09:11', '2022-11-30 04:21:29'),
(18, 5, 'Association Profile', 'সমিতির প্রোফাইল', '/association-panel/association-profile', 2, 'fa fa-user', 1, '2022-10-03 07:09:55', '2022-12-04 11:34:14'),
(19, 5, 'Published Notice', 'প্রকাশিত বিজ্ঞপ্তি', 'published-notice', 3, 'fa fa-list', 1, '2022-10-03 07:10:33', '2022-12-04 11:33:59'),
(20, 5, 'Proposal Submission', 'প্রস্তাব জমা', 'proposal-submission', 4, 'fa fa-file', 1, '2022-10-03 07:11:36', '2022-12-04 11:33:44'),
(21, 5, 'Dashboard', 'ড্যাশবোর্ড', '/association-panel/dashboard', 1, 'fa fa-youtube', 1, '2022-10-19 02:49:30', '2022-11-30 04:21:18'),
(22, 7, 'Small Tea Farmer Application', 'ক্ষুদ্র চা চাষী নিবন্ধন', '/tea-garden-panel/tea-farmer-application', 2, 'fa fa-facebook', 1, '2022-10-19 02:50:04', '2023-01-16 04:11:16'),
(23, 7, 'Tea Garden Application', 'চা বাগানের আবেদন', '/tea-garden-panel/tea-garden-application', 3, 'fa fa-facebook', 1, '2022-10-19 02:50:33', '2022-12-01 05:59:40'),
(24, 5, 'Program Request', 'প্রোগ্রাম অনুরোধ', '/association-panel/program-request', 5, 'fa fa-user', 1, '2022-10-31 11:25:39', '2022-12-04 11:33:11'),
(25, 7, 'Dashboard', 'ড্যাশবোর্ড', '/tea-garden-panel/dashboard', 1, 'fa fa-youtube', 1, '2022-12-01 08:00:58', '2022-12-01 08:00:58'),
(26, 7, 'Tea Factory Application', 'চা কারখানার আবেদন', '/tea-garden-panel/tea-factory-application', 4, 'fa fa-facebook', 1, '2022-12-01 08:04:36', '2022-12-01 08:04:50'),
(27, 5, 'Submit Bill', 'বিল জমা', 'submit-bill', 6, 'fa fa-user', 1, '2022-12-04 11:35:40', '2022-12-04 11:35:40'),
(28, 8, 'Dashboard', 'ড্যাশবোর্ড', '/trade-fair-panel/dashboard', 1, 'fa fa-facebook', 1, '2023-01-12 06:45:50', '2023-01-12 06:45:50'),
(29, 8, 'Circular of Fair Participation', 'মেলায় অংশগ্রহণের বিজ্ঞপ্তি', '/trade-fair-panel/fair-participation-circular', 2, 'fa fa-youtube', 1, '2023-01-12 06:46:28', '2023-01-12 06:46:28'),
(30, 8, 'Fair Participation & Payment Info', 'মেলায় অংশগ্রহণ এবং পেমেন্ট তথ্য', '/trade-fair-panel/fair-participation', 3, 'fa fa-youtube', 1, '2023-01-12 06:47:27', '2023-01-12 06:47:27'),
(31, 5, 'Fund Receive', 'তহবিল প্রাপ্তি', 'fund-receive', 7, 'fa fa-user', 1, '2023-01-23 03:56:45', '2023-01-23 03:56:45'),
(32, 5, 'Policy Advocacy Application', 'পলিসি অ্যাডভোকেসি আবেদন', 'policy-advocacy-application', 8, 'fa fa-file', 1, '2023-01-25 08:25:55', '2023-01-25 08:25:55'),
(33, 5, 'Policy Advocacy Feedback', 'পলিসি অ্যাডভোকেসি ফিডব্যাক', 'policy-advocacy-feedback', 9, 'fa fa-feedback', 1, '2023-01-25 08:27:58', '2023-01-25 08:27:58'),
(34, 8, 'Circular of Exhibition List', 'প্রদর্শনী তালিকার সার্কুলার', '/trade-fair-panel/exhibition-circular-list', 5, 'fa fa-youtube', 1, '2023-01-29 06:39:29', '2023-01-29 06:41:01'),
(35, 8, 'Exhibit Information', 'তথ্য প্রদর্শন', '/trade-fair-panel/exhibit-information', 6, 'fa fa-youtube', 1, '2023-01-29 06:39:55', '2023-01-29 06:41:01'),
(36, 8, 'Visa Processing Info', ' ভিসা প্রসেসিং তথ্য', '/trade-fair-panel/visa-processing-info-list', 4, 'fa fa-youtube', 1, '2023-01-29 06:40:45', '2023-01-29 06:41:01'),
(37, 5, 'Online Product Advertisement', 'অনলাইন পণ্য বিজ্ঞাপন', 'online-product-advertisement', 12, 'fa fa-user', 1, '2023-02-09 07:29:07', '2023-02-09 07:29:07'),
(38, 5, 'Promotion of Events', 'ইভেন্ট প্রচার', 'promotion-of-events', 13, 'fa fa-user', 1, '2023-02-09 07:30:30', '2023-02-09 07:30:30'),
(39, 5, 'Public Relationship Management', 'জনসংযোগ ব্যবস্থাপনা', 'public-relationship-management', 14, 'fa fa-user', 1, '2023-02-09 07:31:32', '2023-02-09 07:31:32'),
(40, 5, 'Country Branding', 'কান্ট্রি ব্র্যান্ডিং', 'country-branding', 15, 'fa fa-user', 1, '2023-02-09 07:32:28', '2023-02-09 07:32:28'),
(41, 5, 'Sales Kits', 'বিক্রয় কিট', 'sales-kits', 16, 'fa fa-user', 1, '2023-02-09 07:32:59', '2023-02-09 07:32:59'),
(42, 5, 'Business Directory', 'ব্যবসা ডিরেক্টরি', 'business-directory', 17, 'fa fa-user', 1, '2023-02-12 06:01:14', '2023-02-12 06:04:15'),
(43, 5, 'Product Directory', 'পণ্য ডিরেক্টরি', 'product-directory', 18, 'fa fa-user', 1, '2023-02-12 06:02:30', '2023-02-12 06:04:15'),
(44, 5, 'Training Information', 'প্রশিক্ষণের তথ্য', 'training-information', 19, 'fa fa-user', 1, '2023-02-12 06:03:53', '2023-02-12 06:04:15'),
(45, 5, 'Training Summary', 'প্রশিক্ষণ সারসংক্ষেপ', 'training-summary', 20, 'fa fa-user', 1, '2023-02-12 06:05:06', '2023-02-12 06:05:06'),
(46, 5, 'Content Management', 'কন্টেন্ট ব্যবস্থাপনা', 'content-management', 21, 'fa fa-user', 1, '2023-02-12 06:05:59', '2023-02-12 06:05:59');

-- --------------------------------------------------------

--
-- Table structure for table `external_panels`
--

CREATE TABLE `external_panels` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `sorting_order` int UNSIGNED NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '	1=active, 2=inactive	',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `external_panels`
--

INSERT INTO `external_panels` (`id`, `name`, `name_bn`, `component_id`, `sorting_order`, `description`, `description_bn`, `icon`, `status`, `created_at`, `updated_at`) VALUES
(1, 'CIP/Export Trophy', 'সিআইপি/রপ্তানি ট্রফি', 10, 1, '', '', 'fa fa-facebook', 1, '2022-06-28 00:36:14', '2022-06-28 00:36:14'),
(2, 'BFTI', 'বিএফটিআই', 6, 2, '', '', 'test', 1, '2022-06-29 06:28:20', '2022-11-23 02:45:15'),
(3, 'Dealer', 'ডিলার', 7, 3, '', '', 'fa fa-user', 1, '2022-07-25 01:29:36', '2022-11-23 02:45:05'),
(4, 'LRCPN', 'এল আর সি পি এন', 7, 4, 'LRCPN', 'এল আর সি পি এন', 'plus', 2, '2022-08-24 04:46:29', '2023-01-30 10:17:12'),
(5, 'Association', 'সংগঠন', 4, 5, 'na', 'na', 'fa fa-user', 1, '2022-09-22 07:10:29', '2022-10-10 04:35:37'),
(6, 'Council', 'কাউন্সিল', 4, 6, 'na', 'na', 'fa fa-user', 2, '2022-09-25 01:22:19', '2022-11-23 02:44:30'),
(7, 'Tea Garden External Panel', 'চা বাগানের বাহ্যিক প্যানেল', 5, 7, '', '', 'fa fa-user', 1, '2022-10-10 04:35:00', '2023-01-16 04:18:42'),
(8, 'International Trade Fair', 'আন্তর্জাতিক বাণিজ্য মেলা', 9, 8, 'International Trade Fair', 'আন্তর্জাতিক বাণিজ্য মেলা', 'save', 1, '2023-01-12 06:44:34', '2023-02-26 08:12:18'),
(9, 'Dhaka International Trade Fair', 'ঢাকা আন্তর্জাতিক বাণিজ্য মেলা', 9, 9, 'Dhaka International Trade Fair', 'ঢাকা আন্তর্জাতিক বাণিজ্য মেলা', 'fa fa-user', 1, '2023-02-26 08:12:58', '2023-02-26 08:13:39'),
(10, 'Trade And Tariff Panel', 'বাণিজ্য এবং ট্যারিফ প্যানেল', 8, 10, 'Trade And Tariff Panel', 'বাণিজ্য এবং ট্যারিফ প্যানেল', 'save', 1, '2023-02-26 08:13:29', '2023-02-26 08:13:39');

-- --------------------------------------------------------

--
-- Table structure for table `master_banks`
--

CREATE TABLE `master_banks` (
  `id` bigint UNSIGNED NOT NULL,
  `bank_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_banks`
--

INSERT INTO `master_banks` (`id`, `bank_name`, `bank_name_bn`, `org_id`, `component_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'NRB Bank', 'এন আর বি ব্যাংক', 1, 1, NULL, NULL, 1, '2022-06-01 15:30:02', '2023-01-11 05:21:43'),
(2, 'Premier  Bank', 'প্রিমিয়ার ব্যাংক', 1, 1, NULL, NULL, 1, '2022-06-01 15:30:20', '2023-01-11 05:23:30'),
(3, 'Sonali Bank', 'সোনালী ব্যাংক', 1, 5, NULL, NULL, 1, '2023-01-11 05:22:42', '2023-01-11 05:26:54'),
(4, 'Rupali Bank', 'রূপালী ব্যাংক', 1, 5, NULL, NULL, 1, '2023-01-11 05:24:13', '2023-01-11 05:25:51'),
(5, 'Islamic Bank', 'ইসলামী ব্যাংক', 1, 5, NULL, NULL, 1, '2023-01-11 05:25:41', '2023-01-11 05:25:41'),
(6, 'Meghna Bank ', 'মেঘনা ব্যাংক', 1, 5, NULL, NULL, 1, '2023-01-12 05:46:28', '2023-01-12 05:46:28'),
(7, 'Dutch Bangla Bank', 'ডাচ বাংলা ব্যাংক', 1, 5, NULL, NULL, 1, '2023-01-12 05:47:15', '2023-01-12 05:47:15');

-- --------------------------------------------------------

--
-- Table structure for table `master_branchs`
--

CREATE TABLE `master_branchs` (
  `id` bigint UNSIGNED NOT NULL,
  `branch_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `branch_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `bank_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_branchs`
--

INSERT INTO `master_branchs` (`id`, `branch_name`, `branch_name_bn`, `address`, `address_bn`, `org_id`, `bank_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Kajipara', 'কাজিপাড়া', 'address', 'ঠিকানা', 1, 1, NULL, NULL, 1, '2022-06-09 02:20:54', '2022-06-09 02:23:01');

-- --------------------------------------------------------

--
-- Table structure for table `master_city_corporations`
--

CREATE TABLE `master_city_corporations` (
  `id` bigint UNSIGNED NOT NULL,
  `division_id` bigint UNSIGNED NOT NULL,
  `district_id` bigint UNSIGNED NOT NULL,
  `city_corporation_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_corporation_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `city_corporation_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_city_corporations`
--

INSERT INTO `master_city_corporations` (`id`, `division_id`, `district_id`, `city_corporation_name`, `city_corporation_name_bn`, `city_corporation_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 6, 47, 'Dhaka South City Corporation', 'ঢাকা দক্ষিণ সিটি কর্পোরেশন', 2222, 1, 1, 1, '2021-05-01 12:02:37', '2021-05-01 12:02:37'),
(2, 6, 47, 'Dhaka North City Corporation', 'ঢাকা উত্তর সিটি কর্পোরেশন', 2223, 1, 1, 1, '2021-05-01 12:03:52', '2021-05-01 12:03:52'),
(3, 3, 27, 'Khulna City Corporation', 'খুলনা সিটি কর্পোরেশন', 2224, 1, 1, 1, '2021-05-01 12:12:08', '2021-05-01 12:12:08'),
(4, 2, 15, 'Rajshahi City Corporation', 'রাজশাহী সিটি কর্পোরেশন', 2225, 2, 1, 1, '2021-05-02 11:15:20', '2021-06-02 16:12:01'),
(5, 6, 41, 'Gazipur City Corporation', 'গাজীপুর সিটি কর্পোরেশন', 2226, 1, 1, 1, '2021-05-23 12:33:25', '2021-06-02 16:12:23'),
(6, 6, 43, 'Naryanganj City Corporation', 'নারায়ণগঞ্জ সিটি কর্পোরেশন', 2227, 1, 1, 1, '2021-06-02 16:09:10', '2021-06-02 16:09:10'),
(7, 1, 8, 'Chattogram City Corporation', 'চট্টগ্রাম সিটি কর্পোরেশন', 2228, 1, 1, 1, '2021-06-02 16:10:16', '2021-06-02 16:10:16'),
(8, 4, 33, 'Barisal CIty Corporation', 'বরিশাল সিটি কর্পোরেশন', 2229, 1, 1, 1, '2021-06-02 16:11:33', '2021-06-02 16:11:33'),
(9, 5, 36, 'Sylhet City Corporation', 'সিলেট সিটি কর্পোরেশন', 2230, 1, 296, 1, '2021-06-02 16:13:03', '2021-10-27 19:20:16'),
(10, 7, 59, 'Rangpur City Corporation', 'রংপুর সিটি কর্পোরেশন', 2231, 1, 1, 1, '2021-06-02 16:13:49', '2021-06-02 16:13:49'),
(11, 1, 1, 'Cumilla City Corporation', 'কুমিল্লা সিটি কর্পোরেশন', 2232, 1, 1, 1, '2021-06-02 16:14:17', '2021-06-02 16:14:17'),
(12, 8, 62, 'Mymensingh City Corporation', 'ময়মনসিংহঃ সিটি কর্পোরেশন', 2233, 1, 1, 1, '2021-06-02 16:14:54', '2021-06-02 16:14:54');

-- --------------------------------------------------------

--
-- Table structure for table `master_complain_chains`
--

CREATE TABLE `master_complain_chains` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `designation_id` bigint UNSIGNED NOT NULL,
  `sorting_order` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_complain_chains`
--

INSERT INTO `master_complain_chains` (`id`, `org_id`, `designation_id`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, NULL, NULL, 1, '2022-06-13 10:00:16', '2022-06-13 10:02:50');

-- --------------------------------------------------------

--
-- Table structure for table `master_complain_designations`
--

CREATE TABLE `master_complain_designations` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `designation_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_complain_designations`
--

INSERT INTO `master_complain_designations` (`id`, `org_id`, `designation_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, NULL, NULL, 2, '2022-06-09 09:55:15', '2022-06-13 07:21:19'),
(2, 1, 2, NULL, NULL, 1, '2022-06-13 07:20:10', '2022-06-13 07:20:10');

-- --------------------------------------------------------

--
-- Table structure for table `master_complain_types`
--

CREATE TABLE `master_complain_types` (
  `id` bigint UNSIGNED NOT NULL,
  `com_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `com_type_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_complain_types`
--

INSERT INTO `master_complain_types` (`id`, `com_type_name`, `com_type_name_bn`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Application', 'আবেদনন', NULL, NULL, 2, '2022-06-09 08:01:46', '2022-06-13 07:17:36'),
(2, 'Another', 'আরোএকটা', NULL, NULL, 1, '2022-06-09 08:04:03', '2022-06-09 08:04:03'),
(3, 'Type', 'Type Bn', NULL, NULL, 1, '2022-06-13 07:03:50', '2022-06-13 07:03:50');

-- --------------------------------------------------------

--
-- Table structure for table `master_components`
--

CREATE TABLE `master_components` (
  `id` bigint UNSIGNED NOT NULL,
  `component_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `component_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sorting_order` int NOT NULL DEFAULT '0',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_components`
--

INSERT INTO `master_components` (`id`, `component_name`, `component_name_bn`, `description`, `description_bn`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Common Service Configuration', 'কমন সার্ভিস কনফিগারেশন', 'Common Service Description', 'সাধারণ পরিষেবা বিবরণ', 11, NULL, NULL, 1, NULL, NULL),
(2, 'National G2B Portal', 'জি টু বি পোর্টাল', 'National G2B Portal', 'জি টু বি পোর্টাল', 1, NULL, NULL, 1, NULL, NULL),
(3, 'Bazar Monitoring System', 'বাজার তদারকি ব্যবস্থাপনা', 'Bazar Monitoring System', 'বাজার তদারকি ব্যবস্থাপনা', 2, NULL, NULL, 1, NULL, '2022-11-17 04:07:45'),
(4, 'E-Biz Management System', 'ই-বিজ ব্যবস্থাপনা', 'E-Biz Management System', 'ই-বিজ ব্যবস্থাপনা', 3, NULL, NULL, 1, NULL, NULL),
(5, 'Tea Garden Management System', 'চা বাগান ব্যবস্থাপনা', 'Tea Garden Management System', 'চা বাগান ব্যবস্থাপনা', 4, NULL, NULL, 1, NULL, NULL),
(6, 'BFTI Research & Policy Management System', 'বিএফটিআই গবেষণা এবং নীতিমালা', 'BFTI Research & Policy Management System', 'গবেষণা এবং নীতিমালা', 5, NULL, NULL, 1, NULL, NULL),
(7, 'TCB Delaer Management System', 'টিসিবি ডিলার ব্যবস্থাপনা', 'TCB Delaer Management System', 'টিসিবি ডিলার ব্যবস্থাপনা', 6, NULL, NULL, 1, NULL, '2023-01-10 04:52:02'),
(8, 'Indent and Offer Vetting', 'বাণিজ্য এবং শুল্ক ব্যবস্থাপনা', 'Trade & Tariff Management System', 'বাণিজ্য এবং শুল্ক ব্যবস্থাপনা', 7, NULL, NULL, 1, NULL, '2022-09-07 03:44:28'),
(9, 'International Trade Fair Participation Exploration', 'বাণিজ্য মেলা ব্যবস্থাপনা', 'International Trade Fair Participation Exploration', 'বাণিজ্য মেলা ব্যবস্থাপনা', 8, NULL, NULL, 1, NULL, NULL),
(10, 'Export Trophy & CIP Management System', 'রপ্তানি ট্রফি এবং সিআইপি ব্যবস্থাপনা', 'Export Trophy & CIP Management System', 'রপ্তানি ট্রফি এবং সিআইপি ব্যবস্থাপনা', 9, NULL, NULL, 1, NULL, NULL),
(11, 'RJSC Registered Entity Portal & Digital Service Management System', 'যৌথমূলধন পোর্টাল', 'RJSC Registered Entity Portal & Digital Service Management System', 'যৌথমূলধন পোর্টাল', 10, NULL, NULL, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `master_contents`
--

CREATE TABLE `master_contents` (
  `id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_content_eligibility`
--

CREATE TABLE `master_content_eligibility` (
  `id` bigint UNSIGNED NOT NULL,
  `eligibility_criteria_id` bigint UNSIGNED NOT NULL,
  `master_content_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_countries`
--

CREATE TABLE `master_countries` (
  `id` bigint UNSIGNED NOT NULL,
  `country_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nationality_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_countries`
--

INSERT INTO `master_countries` (`id`, `country_name`, `country_name_bn`, `nationality`, `nationality_bn`, `country_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Bangladesh', 'বাংলাদেশ', 'Bangladeshi', 'বাংলাদেশী ', 999, NULL, NULL, 1, '2022-05-30 07:19:11', '2023-01-30 09:53:23'),
(2, 'India', 'ভারত', NULL, NULL, 1000, NULL, NULL, 1, '2022-05-30 07:19:38', '2022-05-30 07:19:38'),
(3, 'Pakistan', 'পাকিস্তান', NULL, NULL, 1001, NULL, NULL, 1, '2022-05-30 07:20:05', '2022-08-28 09:33:54'),
(4, 'Nepal', 'নেপাল', NULL, NULL, 1002, NULL, NULL, 1, '2022-05-30 08:23:55', '2022-09-11 08:57:02'),
(5, 'Canada', 'কানাডা', NULL, NULL, 1003, NULL, NULL, 1, '2022-08-28 09:32:28', '2022-08-28 09:32:28'),
(6, 'Mayanmar', 'বার্মা', NULL, NULL, 1004, NULL, NULL, 1, '2022-08-28 09:32:57', '2022-08-28 09:32:57'),
(7, 'Bhutan', 'ভুটান', NULL, NULL, 1005, NULL, NULL, 1, '2022-08-28 09:33:16', '2022-08-28 09:35:41'),
(8, 'Thailand', 'থাইল্যান্ড', NULL, NULL, 1006, NULL, NULL, 1, '2022-08-28 09:34:26', '2022-08-28 09:34:26'),
(9, 'Maldives', 'মালদ্বীপ', NULL, NULL, 1007, NULL, NULL, 1, '2022-08-28 09:35:00', '2022-08-28 09:35:00'),
(10, 'Srilanka', 'শ্রিলঙ্কা', NULL, NULL, 1008, NULL, NULL, 1, '2022-08-28 09:35:23', '2022-08-28 09:35:23'),
(11, 'Indonesia', 'ইন্দোনেশিয়া', NULL, NULL, 1009, NULL, NULL, 1, '2022-08-28 09:36:25', '2022-08-28 09:36:25'),
(12, 'Malaysia', 'মালয়শিয়া', NULL, NULL, 1010, NULL, NULL, 1, '2022-08-28 09:36:46', '2022-08-28 09:36:46'),
(13, 'United Kingdom', 'ইংল্যান্ড', NULL, NULL, 1011, NULL, NULL, 1, '2022-08-28 09:37:22', '2022-08-28 09:37:22'),
(14, 'France', 'ফ্রান্স', NULL, NULL, 1012, NULL, NULL, 1, '2022-08-28 09:37:37', '2022-08-28 09:37:37'),
(15, 'Italy', 'ইতালি', NULL, NULL, 1013, NULL, NULL, 1, '2022-08-28 09:37:59', '2022-08-28 09:37:59'),
(16, 'Germany', 'জার্মানি', NULL, NULL, 1014, NULL, NULL, 1, '2022-08-28 09:38:25', '2022-08-28 09:38:25'),
(17, 'Russia', 'রাশিয়া', NULL, NULL, 1015, NULL, NULL, 1, '2022-08-28 09:38:43', '2022-08-28 09:38:43'),
(18, 'China', 'চীন', NULL, NULL, 1016, NULL, NULL, 1, '2022-08-28 09:39:04', '2022-08-28 09:39:04'),
(19, 'Mexico', 'মেক্সিকো', NULL, NULL, 1017, NULL, NULL, 1, '2022-08-28 09:39:22', '2022-08-28 09:39:22'),
(20, 'Brasil', 'ব্রাজিল', NULL, NULL, 1018, NULL, NULL, 1, '2022-08-28 09:39:42', '2022-08-28 09:39:42'),
(21, 'United States of America', 'আমেরিকা', NULL, NULL, 1019, NULL, NULL, 1, '2022-08-28 09:40:17', '2022-08-28 09:40:17'),
(22, 'Argentina', 'আর্জেন্টিনা', NULL, NULL, 1020, NULL, NULL, 1, '2022-08-28 09:45:50', '2022-08-28 09:45:50'),
(23, 'South Africa', 'দক্ষিণ আফ্রিকা', NULL, NULL, 1021, NULL, NULL, 1, '2022-08-28 09:46:15', '2022-08-28 09:46:15'),
(24, 'Nigeria', 'নাইজেরিয়া', NULL, NULL, 1022, NULL, NULL, 1, '2022-08-28 09:47:01', '2022-08-28 09:47:01'),
(25, 'Kenya', 'কেনিয়া', NULL, NULL, 1023, NULL, NULL, 1, '2022-08-28 09:47:23', '2022-08-28 09:47:23');

-- --------------------------------------------------------

--
-- Table structure for table `master_designations`
--

CREATE TABLE `master_designations` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `designation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `direct_post` int NOT NULL,
  `promotional_post` int NOT NULL,
  `total_post` int NOT NULL,
  `grade_id` int NOT NULL,
  `sorting_order` int NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_designations`
--

INSERT INTO `master_designations` (`id`, `org_id`, `designation`, `designation_bn`, `direct_post`, `promotional_post`, `total_post`, `grade_id`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', 'এডমিন', 10, 5, 15, 1, 120, NULL, NULL, 2, '2022-05-30 06:55:41', '2022-07-06 05:05:38'),
(2, 2, 'Officer', 'অফিসার', 500, 100, 600, 2, 22, NULL, NULL, 2, '2022-05-30 08:35:37', '2022-06-22 05:54:15'),
(3, 1, 'Administrative Officer ', 'প্রশাসনিক কর্মকর্তা', 20, 10, 30, 2, 10, NULL, NULL, 1, '2022-06-06 03:11:07', '2022-08-16 08:29:00'),
(4, 1, 'Executive', 'কার্যনির্বাহী', 100, 50, 150, 12, 12, NULL, NULL, 2, '2022-06-09 01:12:49', '2022-06-22 05:54:07'),
(5, 11, 'Director General (Additional Secretary)', 'মহাপরিচালক (অতিরিক্ত)', 10, 5, 15, 3, 5, NULL, NULL, 1, '2022-06-21 07:30:41', '2022-07-06 05:06:54'),
(6, 11, 'Deputy Director', 'উপ পরিচালক', 50, 50, 100, 4, 4, NULL, NULL, 1, '2022-06-21 07:31:36', '2022-09-25 08:19:14'),
(7, 11, 'Director (Additional Charge)', 'পরিচালক (অতিরিক্ত দায়িত্ব)', 25, 20, 45, 3, 2, NULL, NULL, 1, '2022-06-21 08:26:55', '2022-09-25 08:19:38'),
(8, 11, 'Assistant Director', 'সহকারী পরিচালক', 100, 50, 150, 3, 4, NULL, NULL, 1, '2022-07-04 01:03:21', '2022-09-11 10:12:44'),
(9, 10, 'Chief Executive Officer', 'প্রধান নির্বাহী কর্মকর্তা', 1, 0, 1, 1, 1, NULL, NULL, 1, '2022-07-25 07:46:57', '2022-07-26 06:56:04'),
(10, 10, 'Senior Research Officer ', 'সিনিয়র গবেষণা কর্মকর্তা', 4, 0, 4, 9, 7, NULL, NULL, 1, '2022-07-26 06:59:44', '2022-07-26 06:59:44'),
(11, 10, 'Research Associate', 'সহকারী গবেষক', 0, 8, 8, 8, 6, NULL, NULL, 1, '2022-07-26 07:04:33', '2022-07-26 07:04:33'),
(12, 2, 'Director', 'পরিচালক', 0, 4, 4, 2, 2, NULL, NULL, 1, '2022-08-03 05:26:46', '2022-08-03 05:26:46'),
(13, 2, 'Deputy Director', 'উপপরিচালক', 0, 9, 9, 2, 4, NULL, NULL, 1, '2022-08-03 05:28:58', '2022-08-03 05:28:58'),
(14, 2, 'Assistant Director', 'সহকারী পরিচালক', 8, 8, 16, 2, 9, NULL, NULL, 1, '2022-08-03 05:41:17', '2022-08-03 05:41:17'),
(15, 10, 'Director', 'পরিচালক', 1, 1, 2, 2, 1, NULL, NULL, 1, '2022-08-07 06:44:13', '2022-08-07 06:44:13'),
(16, 10, 'Research Manager', 'গবেষণা ব্যবস্থাপক', 5, 5, 10, 5, 5, NULL, NULL, 1, '2022-08-07 06:49:25', '2022-11-16 05:07:34'),
(17, 1, 'Deputy Secretary', 'উপসচিব', 0, 15, 15, 2, 5, NULL, NULL, 1, '2022-08-16 08:25:33', '2022-08-16 08:25:41'),
(18, 7, 'Chairman', 'চেয়ারম্যান', 1, 0, 1, 1, 1, NULL, NULL, 1, '2022-09-21 03:19:36', '2022-09-21 03:19:36'),
(19, 7, 'Senior Executive (CMS & S&D)', 'উর্ধ্বতন কার্যনির্বাহী ( সিএমএস অ্যান্ড বিওবি)', 3, 3, 6, 7, 2, NULL, NULL, 1, '2022-09-21 03:21:28', '2022-09-21 03:21:28'),
(20, 7, 'Computer programmer', 'কম্পিউটার প্রোগ্রামার', 1, 1, 2, 10, 3, NULL, NULL, 1, '2022-09-21 03:22:19', '2022-09-21 03:22:19'),
(21, 7, 'Senior Executive and Information Officer', 'ঊর্ধ্বতন কার্যনির্বাহী ও তথ্য প্রদানকারী কর্মকর্তা', 5, 5, 10, 7, 4, NULL, NULL, 1, '2022-09-21 03:23:05', '2022-09-21 03:23:05'),
(22, 10, 'Deputy Director', 'উপপরিচালক', 1, 1, 2, 3, 3, NULL, NULL, 1, '2022-10-04 04:58:37', '2022-10-04 04:58:37'),
(23, 5, 'Chairman', 'চেয়ারম্যান', 1, 0, 1, 1, 1, NULL, NULL, 1, '2022-10-10 08:27:24', '2022-10-10 08:27:24'),
(24, 5, 'Economist', 'অর্থনীতিবিদ', 1, 1, 2, 3, 5, NULL, NULL, 1, '2022-10-23 02:44:41', '2022-10-23 02:44:41'),
(25, 5, 'Research Officer', 'গবেষণা কর্মকর্তা', 1, 1, 2, 6, 6, NULL, NULL, 1, '2022-10-23 03:10:26', '2022-10-23 03:10:26'),
(26, 5, 'Statistics Officer', 'পরিসংখ্যান কর্মকর্তা', 1, 1, 2, 7, 7, NULL, NULL, 1, '2022-10-23 03:19:29', '2022-10-23 03:19:29'),
(27, 5, 'Principle Scientific Officer', 'প্রধান বৈজ্ঞানিক কর্মকর্তা', 50, 50, 100, 6, 5, NULL, NULL, 1, '2022-10-23 03:43:20', '2022-10-23 03:43:20'),
(28, 5, 'Senior Scientific Officer', 'উর্ধ্বতন বৈজ্ঞানিক কর্মকর্তা', 50, 50, 100, 6, 7, NULL, NULL, 1, '2022-10-23 03:48:57', '2022-10-23 03:48:57'),
(29, 5, 'Director', 'পরিচালক', 1, 1, 2, 1, 1, NULL, NULL, 1, '2022-10-23 03:56:29', '2022-10-23 03:56:29'),
(30, 5, 'Assistant Development Officer', 'সহকারী উন্নয়ন কর্মকর্তা', 10, 10, 20, 7, 10, NULL, NULL, 1, '2022-10-23 04:20:39', '2022-10-23 04:20:39'),
(31, 7, 'Test', 'Test Bn', 10, 10, 20, 7, 10, NULL, NULL, 1, '2022-10-27 04:21:19', '2022-10-27 04:21:19'),
(32, 2, 'Verification', 'ভেরিফিকেশন', 3, 3, 6, 10, 8, NULL, NULL, 1, '2022-11-06 03:41:40', '2022-11-06 03:41:40'),
(33, 10, 'Assistant Director(CS)', 'সহকারী পরিচালক (সিএস)', 2, 2, 4, 4, 5, NULL, NULL, 1, '2022-11-16 03:45:08', '2022-11-16 03:45:08'),
(34, 1, 'Senior Secretary', 'সিনিয়র সচিব', 0, 1, 1, 1, 1, NULL, NULL, 1, '2022-11-28 03:40:33', '2022-11-28 03:40:33'),
(35, 1, 'Assistant Trade Consultant', 'সহকারী বাণিজ্য পরামর্শক', 2, 1, 3, 9, 9, NULL, NULL, 1, '2022-11-29 04:12:09', '2022-11-29 04:12:09'),
(36, 5, 'Manager', 'ব্যবস্থাপক', 5, 1, 6, 3, 1, NULL, NULL, 1, '2022-12-05 11:21:39', '2023-01-11 08:55:45'),
(37, 5, 'Scientific Officer', 'বৈজ্ঞানিক কর্মকর্তা', 10, 10, 20, 9, 9, NULL, NULL, 1, '2022-12-13 05:09:57', '2022-12-13 05:09:57'),
(38, 8, 'ASSISTANT EXECUTIVE OFFICER', 'সহকারী নির্বাহী কর্মকর্তা', 12, 12, 24, 9, 50, NULL, NULL, 1, '2022-12-13 10:06:30', '2023-02-15 05:32:03'),
(39, 10, 'Research Officer', 'গবেষণা কর্মকর্তা', 5, 2, 7, 9, 5, NULL, NULL, 1, '2022-12-15 04:31:22', '2022-12-15 04:31:22'),
(40, 10, 'Administrative Officer', 'প্রশাসনিক কর্মকর্তা', 5, 1, 6, 11, 6, NULL, NULL, 1, '2022-12-15 04:45:01', '2022-12-15 04:45:01'),
(41, 10, 'Executive Officer', 'নির্বাহী কর্মকর্তা', 1, 1, 2, 10, 7, NULL, NULL, 1, '2022-12-15 04:51:48', '2022-12-15 04:51:48'),
(42, 7, 'Deputy Commissioner ', 'জেলা প্রশাসক', 64, 0, 64, 6, 55, NULL, NULL, 1, '2023-01-04 05:54:18', '2023-01-26 03:17:26'),
(43, 7, 'Senior Executive (Office Chief)', 'উর্ধ্বতন কার্যনির্বাহী (অফিস প্রধান)', 1, 5, 6, 6, 1, NULL, NULL, 1, '2023-01-18 08:56:43', '2023-01-18 08:56:43'),
(44, 5, 'Deputy Manager', 'উপ ব্যবস্থাপক', 200, 100, 300, 7, 70, NULL, NULL, 1, '2023-01-31 05:46:35', '2023-01-31 05:46:35'),
(45, 7, 'Assistant Executive (Office In charge)', 'সহকারী কার্যনির্বাহী (অফিস প্রধান)', 3, 3, 6, 5, 4, NULL, NULL, 1, '2023-02-05 05:14:38', '2023-02-05 05:14:38'),
(46, 7, 'Deputy Senior Executive (current responsibility)', 'উপ-পরিচালক (চঃদাঃ) (অফিস প্রধান)', 1, 3, 4, 5, 4, NULL, NULL, 1, '2023-02-05 05:44:11', '2023-02-05 05:44:11'),
(47, 8, 'Deputy Coordinator', 'ডেপুটি কো-অর্ডিনেটর', 1, 0, 1, 2, 1, NULL, NULL, 1, '2023-02-15 05:25:51', '2023-02-15 05:25:51'),
(48, 8, 'Executive Officer', 'নির্বাহী কর্মকর্তা', 1, 1, 2, 3, 2, NULL, NULL, 1, '2023-02-15 05:27:08', '2023-02-15 05:27:08');

-- --------------------------------------------------------

--
-- Table structure for table `master_dialogue_settings`
--

CREATE TABLE `master_dialogue_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `dialogue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dialogue_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` tinyint NOT NULL DEFAULT '1' COMMENT '1 = left bottom, 2 = left top',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1 = active, 2 = inactive',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_dialogue_settings`
--

INSERT INTO `master_dialogue_settings` (`id`, `dialogue`, `dialogue_bn`, `position`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Bangladesh Is Self-Sufficient In Agriculture', 'কৃষিতে স্বনির্ভর বাংলাদেশ', 2, 1, NULL, NULL, '2022-05-30 07:55:28', '2022-05-30 08:46:03'),
(2, 'dfg', 'dfg', 1, 1, NULL, NULL, '2022-05-30 08:45:04', '2022-05-30 08:57:11'),
(3, 'd', 'sdf', 1, 1, NULL, NULL, '2022-05-30 09:02:13', '2022-05-31 04:49:44'),
(4, 'df', 'sdf', 1, 0, NULL, NULL, '2022-05-31 04:51:32', '2022-05-31 04:51:32'),
(5, 'cgh', 'fgdf', 1, 1, NULL, NULL, '2022-05-31 04:53:12', '2022-05-31 05:15:20'),
(6, 'b', 'fg', 1, 1, NULL, NULL, '2022-05-31 05:13:54', '2022-05-31 05:15:11');

-- --------------------------------------------------------

--
-- Table structure for table `master_districts`
--

CREATE TABLE `master_districts` (
  `id` bigint UNSIGNED NOT NULL,
  `district_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `division_id` bigint UNSIGNED NOT NULL,
  `district_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_districts`
--

INSERT INTO `master_districts` (`id`, `district_name`, `district_name_bn`, `division_id`, `district_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Cumilla', 'কুমিল্লা', 1, 5555, 1, 1, 1, '2021-02-13 16:16:25', '2022-01-14 22:46:30'),
(2, 'Feni', 'ফেনী', 1, 5556, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(3, 'Brahmanbaria', 'ব্রাহ্মণবাড়িয়া', 1, 5557, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(4, 'Rangamati', 'রাঙ্গামাটি', 1, 5558, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(5, 'Noakhali', 'নোয়াখালী', 1, 5559, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(6, 'Chandpur', 'চাঁদপুর', 1, 5560, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(7, 'Lakshmipur', 'লক্ষ্মীপুর', 1, 5561, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(8, 'Chattogram', 'চট্টগ্রাম', 1, 5562, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(9, 'Coxsbazar', 'কক্সবাজার', 1, 5563, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(10, 'Khagrachhari', 'খাগড়াছড়ি', 1, 5564, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(11, 'Bandarban', 'বান্দরবান', 1, 5565, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(12, 'Sirajganj', 'সিরাজগঞ্জ', 2, 5566, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(13, 'Pabna', 'পাবনা', 2, 5567, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(14, 'Bogura', 'বগুড়া', 2, 5568, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(15, 'Rajshahi', 'রাজশাহী', 2, 5569, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(16, 'Natore', 'নাটোর', 2, 5570, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(17, 'Joypurhat', 'জয়পুরহাট', 2, 5571, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(18, 'Chapainawabganj', 'চাঁপাইনবাবগঞ্জ', 2, 5572, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(19, 'Naogaon', 'নওগাঁ', 2, 5573, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(20, 'Jashore', 'যশোর', 3, 5574, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(21, 'Satkhira', 'সাতক্ষীরা', 3, 5575, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(22, 'Meherpur', 'মেহেরপুর', 3, 5576, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(23, 'Narail', 'নড়াইল', 3, 5577, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(24, 'Chuadanga', 'চুয়াডাঙ্গা', 3, 5578, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(25, 'Kushtia', 'কুষ্টিয়া', 3, 5579, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(26, 'Magura', 'মাগুরা', 3, 5580, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(27, 'Khulna', 'খুলনা', 3, 5581, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(28, 'Bagerhat', 'বাগেরহাট', 3, 5582, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(29, 'Jhenaidah', 'ঝিনাইদহ', 3, 5583, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(30, 'Jhalakathi', 'ঝালকাঠি', 4, 5584, 1, 1, 1, '2021-02-13 16:16:26', '2021-02-13 16:16:26'),
(31, 'Patuakhali', 'পটুয়াখালী', 4, 5585, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(32, 'Pirojpur', 'পিরোজপুর', 4, 5586, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(33, 'Barisal', 'বরিশাল', 4, 5587, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(34, 'Bhola', 'ভোলা', 4, 5588, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(35, 'Barguna', 'বরগুনা', 4, 5589, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(36, 'Sylhet', 'সিলেট', 5, 5590, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(37, 'Moulvibazar', 'মৌলভীবাজার', 5, 5591, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(38, 'Habiganj', 'হবিগঞ্জ', 5, 5592, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(39, 'Sunamganj', 'সুনামগঞ্জ', 5, 5593, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(40, 'Narsingdi', 'নরসিংদী', 6, 5594, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(41, 'Gazipur', 'গাজীপুর', 6, 5595, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(42, 'Shariatpur', 'শরীয়তপুর', 6, 5596, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(43, 'Narayanganj', 'নারায়ণগঞ্জ', 6, 5597, 1, 1, 1, '2021-02-13 16:16:27', '2021-02-13 16:16:27'),
(44, 'Tangail', 'টাঙ্গাইল', 6, 5598, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(45, 'Kishoreganj', 'কিশোরগঞ্জ', 6, 5599, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(46, 'Manikganj', 'মানিকগঞ্জ', 6, 5600, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(47, 'Dhaka', 'ঢাকা', 6, 5601, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(48, 'Munshiganj', 'মুন্সিগঞ্জ', 6, 5602, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(49, 'Rajbari', 'রাজবাড়ী', 6, 5603, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(50, 'Madaripur', 'মাদারীপুর', 6, 5604, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(51, 'Gopalganj', 'গোপালগঞ্জ', 6, 5605, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(52, 'Faridpur', 'ফরিদপুর', 6, 5606, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(53, 'Panchagarh', 'পঞ্চগড়', 7, 5607, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(54, 'Dinajpur', 'দিনাজপুর', 7, 5608, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(55, 'Lalmonirhat', 'লালমনিরহাট', 7, 5609, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(56, 'Nilphamari', 'নীলফামারী', 7, 5610, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(57, 'Gaibandha', 'গাইবান্ধা', 7, 5611, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(58, 'Thakurgaon', 'ঠাকুরগাঁও', 7, 5612, 1, 1, 1, '2021-02-13 16:16:28', '2021-02-13 16:16:28'),
(59, 'Rangpur', 'রংপুর', 7, 5613, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(60, 'Kurigram', 'কুড়িগ্রাম', 7, 5614, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(61, 'Sherpur', 'শেরপুর', 8, 5615, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(62, 'Mymensingh', 'ময়মনসিংহ', 8, 5616, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(63, 'Jamalpur', 'জামালপুর', 8, 5617, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(64, 'Netrokona', 'নেত্রকোণা', 8, 5618, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29');

-- --------------------------------------------------------

--
-- Table structure for table `master_divisions`
--

CREATE TABLE `master_divisions` (
  `id` bigint UNSIGNED NOT NULL,
  `division_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `division_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint UNSIGNED NOT NULL DEFAULT '1',
  `division_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_divisions`
--

INSERT INTO `master_divisions` (`id`, `division_name`, `division_name_bn`, `country_id`, `division_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Chattagram', 'চট্টগ্রাম', 1, 4444, 1, 1, 1, '2021-02-13 16:16:24', '2021-02-13 16:16:24'),
(2, 'Rajshahi', 'রাজশাহী', 1, 4445, 1, 1, 1, '2021-02-13 16:16:24', '2021-02-13 16:16:24'),
(3, 'Khulna', 'খুলনা', 1, 4446, 1, 1, 1, '2021-02-13 16:16:24', '2021-02-13 16:16:24'),
(4, 'Barisal', 'বরিশাল', 1, 4447, 1, 1, 1, '2021-02-13 16:16:24', '2021-02-13 16:16:24'),
(5, 'Sylhet', 'সিলেট', 1, 4448, 1, 1, 1, '2021-02-13 16:16:24', '2021-03-22 14:58:19'),
(6, 'Dhaka', 'ঢাকা', 1, 4449, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(7, 'Rangpur', 'রংপুর', 1, 4450, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25'),
(8, 'Mymensingh', 'ময়মনসিংহ', 1, 4451, 1, 1, 1, '2021-02-13 16:16:25', '2021-02-13 16:16:25');

-- --------------------------------------------------------

--
-- Table structure for table `master_document_categories`
--

CREATE TABLE `master_document_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `category_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sorting_order` tinyint NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_document_categories`
--

INSERT INTO `master_document_categories` (`id`, `category_name`, `category_name_bn`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Application', 'আবেদন', 11, NULL, NULL, 1, '2022-06-04 21:33:04', '2022-06-04 22:12:16'),
(2, 'Test', 'টেস্ট', 11, NULL, NULL, 1, '2022-06-04 22:12:02', '2022-06-04 22:12:02');

-- --------------------------------------------------------

--
-- Table structure for table `master_eligibility_types`
--

CREATE TABLE `master_eligibility_types` (
  `id` bigint UNSIGNED NOT NULL,
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_faqs`
--

CREATE TABLE `master_faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `question` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `question_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_fiscal_years`
--

CREATE TABLE `master_fiscal_years` (
  `id` bigint UNSIGNED NOT NULL,
  `year` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `sorting_order` tinyint DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_fiscal_years`
--

INSERT INTO `master_fiscal_years` (`id`, `year`, `start_date`, `end_date`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, '2021-2022', '2021-07-01', '2022-06-30', 11, NULL, NULL, 1, '2022-06-08 09:00:04', '2022-06-08 09:00:04'),
(2, '2022-2023', '2022-07-01', '2023-06-30', 12, NULL, NULL, 1, '2022-06-08 09:06:30', '2022-06-08 09:30:46'),
(3, '2023-2024', '2023-07-01', '2024-06-30', 13, NULL, NULL, 1, '2022-06-14 06:26:18', '2022-06-14 06:26:18'),
(4, '2020-2021', '2020-07-01', '2021-06-30', 4, NULL, NULL, 1, '2022-08-07 02:05:39', '2022-08-07 02:05:39'),
(5, '2018-2019', '2018-07-01', '2019-06-30', 5, NULL, NULL, 1, '2022-09-04 06:24:27', '2022-09-04 06:27:36'),
(6, '2019-2020', '2019-07-01', '2020-06-30', 6, NULL, NULL, 1, '2022-09-04 06:25:43', '2022-09-04 06:28:09'),
(7, '2017-2018', '2017-07-01', '2018-06-30', 7, NULL, NULL, 1, '2022-09-04 06:31:11', '2022-09-04 06:31:11');

-- --------------------------------------------------------

--
-- Table structure for table `master_grades`
--

CREATE TABLE `master_grades` (
  `id` bigint UNSIGNED NOT NULL,
  `grade_name` bigint UNSIGNED NOT NULL,
  `grade_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_menus`
--

CREATE TABLE `master_menus` (
  `id` bigint UNSIGNED NOT NULL,
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sorting_order` int NOT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `module_id` bigint UNSIGNED DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `associated_urls` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_menus`
--

INSERT INTO `master_menus` (`id`, `menu_name`, `menu_name_bn`, `url`, `sorting_order`, `component_id`, `module_id`, `service_id`, `associated_urls`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Specification Info', 'Specification Info', '/trade-tariff-service/specification/specification-info', 1, 8, 51, 0, '', NULL, NULL, 1, '2023-03-01 10:40:14', '2023-03-01 10:40:14'),
(2, 'Offer Vetting', 'Offer Vetting', '/trade-tariff-service/specification/specification-verify', 1, 8, 51, 0, '', NULL, NULL, 1, '2023-03-01 10:40:14', '2023-03-01 10:40:14'),
(3, 'Indent Offer Report', 'Indent Offer Report', '/trade-tariff-service/specification/inspection-report', 1, 8, 51, 0, '', NULL, NULL, 1, '2023-03-01 10:40:14', '2023-03-01 10:40:14');

-- --------------------------------------------------------

--
-- Table structure for table `master_modules`
--

CREATE TABLE `master_modules` (
  `id` bigint UNSIGNED NOT NULL,
  `module_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `module_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `sorting_order` bigint UNSIGNED NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_modules`
--

INSERT INTO `master_modules` (`id`, `module_name`, `module_name_bn`, `component_id`, `created_by`, `updated_by`, `sorting_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Organization Profile', 'প্রতিষ্ঠানের প্রোফাইল', 1, NULL, NULL, 1, 1, '2022-06-13 02:55:22', '2022-06-13 02:55:22'),
(2, 'Configuration', 'কনফিগারেশন ', 3, NULL, NULL, 1, 1, '2022-06-13 03:26:49', '2022-06-13 03:26:49'),
(3, 'Configuration', 'কনফিগারেশন', 10, NULL, NULL, 1, 1, '2022-06-14 03:26:53', '2022-06-14 03:26:53'),
(4, 'Reports', 'প্রতিবেদনসমূহ', 3, NULL, NULL, 4, 1, '2022-06-19 02:28:10', '2022-11-23 06:22:11'),
(5, 'Menu', 'মেনু', 1, NULL, NULL, 2, 1, '2022-06-19 05:04:35', '2022-06-20 02:25:45'),
(7, 'Commodity Price Manage', 'দ্রব্যমূল্য ব্যবস্থাপনা', 3, NULL, NULL, 2, 1, '2022-06-19 10:09:19', '2022-11-23 06:21:43'),
(8, 'Organogram Management', 'অর্গানোগ্রাম ব্যবস্থাপনা', 1, NULL, NULL, 4, 1, '2022-06-19 10:14:50', '2022-06-19 10:14:50'),
(9, 'Notification Management', 'বিজ্ঞপ্তি ব্যবস্থাপনা', 1, NULL, NULL, 5, 1, '2022-06-19 10:26:11', '2022-06-19 10:26:11'),
(10, 'Document Management', 'নথি ব্যবস্থাপনা', 1, NULL, NULL, 6, 1, '2022-06-19 10:28:32', '2022-06-19 10:28:32'),
(11, 'Complain Management', 'অভিযোগ ব্যবস্থাপনা', 1, NULL, NULL, 7, 1, '2022-06-19 10:28:51', '2022-06-19 10:28:51'),
(12, 'User Management', 'ব্যবহারকারীর ব্যবস্থাপনা', 1, NULL, NULL, 3, 1, '2022-06-20 02:01:41', '2022-06-21 10:51:08'),
(13, 'External', 'এক্সটার্নাল', 1, NULL, NULL, 8, 1, '2022-06-20 02:39:59', '2022-06-20 02:39:59'),
(14, 'Circular', 'বিজ্ঞপ্তি', 10, NULL, NULL, 2, 1, '2022-06-29 02:39:56', '2022-06-29 02:39:56'),
(15, 'Export Trophy Management', 'রপ্তানি ট্রফি ব্যবস্থাপনা', 10, NULL, NULL, 3, 1, '2022-06-29 02:40:16', '2022-06-29 02:40:16'),
(16, 'CIP Management', 'সিআইপি ব্যবস্থাপনা', 10, NULL, NULL, 4, 1, '2022-06-29 02:40:40', '2022-06-29 02:40:40'),
(17, 'Event Management', 'ইভেন্ট ম্যানেজমেন্ট', 10, NULL, NULL, 6, 1, '2022-06-29 02:41:01', '2022-11-22 05:45:10'),
(18, 'Configuration', 'কনফিগারেশন', 6, NULL, NULL, 1, 1, '2022-07-19 03:16:25', '2022-07-19 03:16:25'),
(19, 'Research Request and Proposal Management', 'গবেষণা অনুরোধ এবং প্রস্তাব ব্যবস্থাপনা', 6, NULL, NULL, 2, 1, '2022-07-19 03:57:44', '2022-07-19 03:57:44'),
(20, 'Policy Advocacy Management System', 'পলিসি অ্যাডভোকেসি ম্যানেজমেন্ট সিস্টেম', 6, NULL, NULL, 5, 1, '2022-07-19 03:58:06', '2022-08-08 03:22:50'),
(21, 'System Configuration & Activity Management', 'সিস্টেম কনফিগারেশন এবং কার্যকলাপ ব্যবস্থাপনা', 6, NULL, NULL, 6, 1, '2022-07-19 03:58:30', '2022-08-08 03:21:21'),
(22, 'Task Activity Monitoring', 'টাস্ক অ্যাক্টিভিটি মনিটরিং', 6, NULL, NULL, 4, 1, '2022-07-28 02:42:23', '2022-08-08 03:22:50'),
(23, 'Research Execution Management ', 'গবেষণা সম্পাদন ব্যবস্থাপনা', 6, NULL, NULL, 3, 1, '2022-07-28 02:50:38', '2022-11-22 23:03:06'),
(24, 'Gazette Management', 'গেজেট ব্যবস্থাপনা', 10, NULL, NULL, 5, 1, '2022-08-02 04:29:42', '2022-11-22 05:45:10'),
(25, 'Report', 'প্রতিবেদন', 10, NULL, NULL, 7, 1, '2022-08-02 04:30:24', '2022-11-23 05:45:02'),
(26, 'Configuration', 'কনফিগারেশন', 7, NULL, NULL, 2, 1, '2022-08-22 10:08:07', '2022-08-22 10:08:07'),
(28, 'Dealer Management (TCB)', 'ডিলার ব্যবস্থাপনা (টিসিবি)', 7, NULL, NULL, 3, 1, '2022-08-22 10:13:33', '2022-09-12 03:06:26'),
(29, 'TCB Report', 'টিসিবি রিপোর্ট', 7, NULL, NULL, 5, 1, '2022-08-22 10:16:11', '2022-09-12 03:04:15'),
(31, 'Application Entry', 'আবেদন এন্ট্রি', 7, NULL, NULL, 10, 1, '2022-08-23 02:22:52', '2022-09-12 03:03:03'),
(32, 'Dashboard', 'ড্যাশবোর্ড', 7, NULL, NULL, 1, 1, '2022-08-23 03:00:55', '2022-09-12 03:00:09'),
(33, 'Portal', 'পোর্টাল', 1, NULL, NULL, 8, 1, '2022-09-01 10:17:33', '2022-09-01 10:17:33'),
(34, 'License Management (TCB)', 'লাইসেন্স ব্যবস্থাপনা (টিসিবি)', 7, NULL, NULL, 2, 1, '2022-09-12 03:11:11', '2022-09-21 08:44:40'),
(35, 'Configuration', 'কনফিগারেশন', 4, NULL, NULL, 2, 1, '2022-10-03 06:40:42', '2022-10-31 11:28:05'),
(36, 'Dashboard', 'ড্যাশবোর্ড', 5, NULL, NULL, 1, 1, '2022-10-03 06:45:40', '2022-10-03 06:45:40'),
(37, 'Configuration', 'কনফিগারেশন', 5, NULL, NULL, 2, 1, '2022-10-03 06:46:03', '2022-10-03 06:46:03'),
(38, 'Proposal Management', 'প্রপোজাল ব্যবস্থাপনা', 4, NULL, NULL, 4, 1, '2022-10-03 06:48:58', '2023-02-12 08:01:04'),
(39, 'E-Biz Reports', 'ই-বিজ প্রতিবেদন', 4, NULL, NULL, 9, 1, '2022-10-12 08:26:51', '2023-02-12 08:04:23'),
(40, 'BTB', 'বিটিবি', 5, NULL, NULL, 3, 1, '2022-10-19 02:44:23', '2022-10-19 02:44:23'),
(41, 'Association Management', 'এ্যাসোসিয়েশন ব্যবস্থাপনা', 4, NULL, NULL, 3, 1, '2022-10-31 11:26:47', '2023-02-12 08:06:43'),
(42, 'Dashboard', 'ড্যাশবোর্ড', 4, NULL, NULL, 1, 1, '2022-10-31 11:27:36', '2022-10-31 11:27:36'),
(43, 'Program Management', 'প্রোগ্রাম ব্যবস্থাপনা', 4, NULL, NULL, 5, 1, '2022-10-31 11:28:35', '2022-10-31 11:28:35'),
(44, 'ITF', 'আইটিএফ', 9, NULL, NULL, 1, 1, '2022-11-07 03:55:04', '2022-11-07 03:55:04'),
(45, 'BTB Application Approval Process', 'বিটিবি আবেদন অনুমোদন প্রক্রিয়া', 5, NULL, NULL, 4, 1, '2022-11-14 06:36:14', '2023-02-15 08:57:05'),
(46, 'Bazar Monitoring Manage', 'বাজার তদারকি ব্যবস্থাপনা', 3, NULL, NULL, 3, 1, '2022-11-23 06:19:42', '2022-11-23 06:22:02'),
(47, 'Allocation Management (Dc Office)', 'বরাদ্দ ব্যবস্থাপনা (ডিসি অফিস)', 7, NULL, NULL, 7, 1, '2022-12-08 05:50:57', '2022-12-08 05:50:57'),
(48, 'BTRI', 'বিটিআরআই', 5, NULL, NULL, 5, 1, '2022-12-21 07:45:47', '2023-02-15 08:57:05'),
(49, 'Configuration', 'কনফিগারেশন', 11, NULL, NULL, 1, 1, '2023-01-10 04:49:52', '2023-01-10 04:49:52'),
(50, 'Portal', 'পোর্টাল', 11, NULL, NULL, 2, 1, '2023-01-10 04:50:09', '2023-01-10 04:50:09'),
(51, 'Specification', 'Specification', 8, NULL, NULL, 1, 1, '2023-01-19 02:46:52', '2023-03-01 10:39:10'),
(52, 'Policy & Advocacy Management', 'পলিসি ও অ্যাডভোকেসি ব্যবস্থাপনা', 4, NULL, NULL, 8, 1, '2023-01-25 08:20:48', '2023-02-12 08:04:23'),
(53, 'Promotional Management', 'প্রমোশনাল ব্যবস্থাপনা', 4, NULL, NULL, 6, 1, '2023-02-09 07:35:24', '2023-02-12 08:04:23'),
(54, 'Information & Training Management', 'তথ্য ও প্রশিক্ষণ ব্যবস্থাপনা', 4, NULL, NULL, 7, 1, '2023-02-12 05:45:40', '2023-02-12 05:45:40'),
(55, 'PDU', 'পিডিইউ', 5, NULL, NULL, 6, 1, '2023-02-15 08:44:21', '2023-02-15 08:57:05'),
(56, 'Specificationddd', 'Specificationdd', 8, NULL, NULL, 1, 1, '2023-03-01 10:07:22', '2023-03-01 10:38:49');

-- --------------------------------------------------------

--
-- Table structure for table `master_notification_settings`
--

CREATE TABLE `master_notification_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `module_id` bigint UNSIGNED DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `menu_id` bigint UNSIGNED DEFAULT NULL,
  `notification_type_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_notification_types`
--

CREATE TABLE `master_notification_types` (
  `id` bigint UNSIGNED NOT NULL,
  `not_type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `not_type_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_notification_types`
--

INSERT INTO `master_notification_types` (`id`, `not_type_name`, `not_type_name_bn`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'fgd', 'dfgd', NULL, NULL, 1, '2022-05-31 04:38:03', '2022-06-02 01:56:39'),
(2, 'xdffdgdfg', 'sdfdfg', NULL, NULL, 1, '2022-05-31 04:46:58', '2022-06-02 01:54:23'),
(3, 'fgh', 'fyh', NULL, NULL, 1, '2022-05-31 05:15:41', '2022-05-31 05:15:41'),
(4, 'Notification First', 'Notification First bn', NULL, NULL, 1, '2022-05-31 05:23:28', '2022-05-31 05:39:10');

-- --------------------------------------------------------

--
-- Table structure for table `master_offices`
--

CREATE TABLE `master_offices` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `office_cat_id` tinyint DEFAULT NULL,
  `office_type_id` bigint UNSIGNED DEFAULT NULL,
  `area_type_id` int NOT NULL COMMENT '1=City Corpoation,2=Pauroshoba,3=Union',
  `city_corporation_id` int DEFAULT NULL,
  `pauroshoba_id` int DEFAULT NULL,
  `ward_id` int DEFAULT NULL,
  `country_id` bigint UNSIGNED DEFAULT NULL,
  `division_id` bigint UNSIGNED DEFAULT NULL,
  `district_id` bigint UNSIGNED DEFAULT NULL,
  `upazila_id` bigint UNSIGNED DEFAULT NULL,
  `union_id` bigint UNSIGNED DEFAULT NULL,
  `office_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `office_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `office_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_office_type_id` bigint UNSIGNED DEFAULT NULL,
  `parent_office_id` bigint UNSIGNED DEFAULT NULL,
  `is_regional_office` int NOT NULL DEFAULT '0' COMMENT '0=not Regional, 1=Regional',
  `regional_office_id` bigint UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_offices`
--

INSERT INTO `master_offices` (`id`, `org_id`, `office_cat_id`, `office_type_id`, `area_type_id`, `city_corporation_id`, `pauroshoba_id`, `ward_id`, `country_id`, `division_id`, `district_id`, `upazila_id`, `union_id`, `office_name`, `office_name_bn`, `address`, `address_bn`, `office_code`, `parent_office_type_id`, `parent_office_id`, `is_regional_office`, `regional_office_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 11, NULL, 2, 1, 2, 0, 31, 1, 6, 47, 0, 0, 'test ', 'test bn', NULL, NULL, '124', 2, 0, 0, NULL, NULL, NULL, 2, '2022-06-21 08:50:44', '2022-06-21 09:17:22'),
(2, 11, NULL, 2, 1, 2, 0, 31, 1, 6, 47, 0, 0, 'Divisional Office , Sylhet', 'বিভাগীয় কার্যালয়, সিলেট', NULL, NULL, '200', 0, 0, 0, NULL, NULL, NULL, 1, '2022-06-21 09:17:15', '2022-07-04 08:15:37'),
(3, 11, NULL, 2, 1, 2, 0, 31, 1, 6, 47, 0, 0, 'Divisional Office, Dhaka', 'বিভাগীয় কার্যালয়, ঢাকা', NULL, NULL, '2001', 2, 2, 0, NULL, NULL, NULL, 1, '2022-06-21 09:18:44', '2022-07-04 08:11:54'),
(4, 11, NULL, 5, 1, 2, 0, 31, 1, 6, 47, 0, 0, 'Head Office', 'হেড অফিস', NULL, NULL, '', 0, 0, 0, NULL, NULL, NULL, 1, '2022-06-21 10:39:19', '2022-06-21 10:39:19'),
(5, 11, NULL, 3, 1, 2, 37, 31, 1, 6, 47, 366, 0, 'District Office, Dhaka', 'ঢাকা জেলা অফিস', NULL, NULL, '', 0, 0, 0, NULL, NULL, NULL, 1, '2022-07-04 03:07:08', '2022-07-04 03:07:08'),
(6, 10, NULL, 12, 1, 1, 0, 0, 1, 6, 47, 0, 0, 'Head Office', 'সদর দফতর', NULL, NULL, '1', 0, 0, 0, 0, NULL, NULL, 1, '2022-07-25 07:55:14', '2022-07-25 07:55:14'),
(7, 2, NULL, 14, 1, 2, 0, 35, 1, 6, 47, 0, 0, 'Commodity Division', 'পণ্য বিভাগ', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-08-03 05:28:14', '2022-08-03 05:50:14'),
(8, 1, NULL, 15, 1, 1, 0, 30, 1, 6, 47, 0, 0, 'Export Wing', 'রপ্তানি অনুবিভাগ', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-08-16 08:24:27', '2022-08-16 08:24:27'),
(9, 11, NULL, 3, 2, 0, 85, 0, 1, 3, 21, 182, 0, 'District Office, Satkhira', 'জেলা অফিস, সাতক্ষীরা', NULL, NULL, '', 2, 10, 0, 0, NULL, NULL, 1, '2022-09-11 10:06:44', '2022-09-11 10:08:40'),
(10, 11, NULL, 2, 1, 3, 0, 0, 1, 3, 27, 0, 0, 'Divisional Office, Khulna', 'বিভাগীয় কার্যালয়, খুলনা', NULL, NULL, '', 5, 4, 0, 0, NULL, NULL, 1, '2022-09-11 10:08:07', '2022-09-11 10:08:07'),
(11, 7, NULL, 18, 1, 2, 0, 0, 1, 6, 47, 0, 0, 'Regional Office, Dhaka', 'আঞ্চলিক কার্যালয়, ঢাকা', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 02:53:05', '2022-09-21 02:53:05'),
(12, 7, NULL, 18, 1, 7, 0, 0, 1, 1, 8, 0, 0, 'Regional Office, Chittagong', 'আঞ্চলিক কার্যালয়, চট্টগ্রাম', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 02:54:21', '2022-09-21 02:54:21'),
(13, 7, NULL, 18, 1, 3, 0, 0, 1, 3, 27, 0, 0, 'Regional Office, Khulna', 'আঞ্চলিক কার্যালয়, খুলনা', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:00:50', '2022-09-21 03:01:25'),
(14, 5, NULL, 22, 2, 0, 0, 0, 1, 4, 35, 266, 0, 'Clivdon Tea Garden', 'ক্লিভডন চা বাগান', 'Proident commodo id', 'Irure sint aut aute', '', 0, 0, 1, 0, NULL, 1, 1, '2022-09-21 03:02:49', '2023-01-29 09:28:20'),
(15, 5, NULL, 22, 2, 2, 225, 0, 1, 7, 53, 399, 0, 'Sallylan Tea Estate', 'স্যালিলান টি এস্টেট', 'Panchagarh', 'পঞ্চগড়', '', 0, 0, 1, 0, NULL, 1, 1, '2022-09-21 03:05:15', '2022-12-01 09:13:58'),
(16, 7, NULL, 18, 1, 8, 0, 0, 1, 4, 33, 0, 0, 'Regional Office, Barisal', 'আঞ্চলিক কার্যালয়, বরিশাল', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:07:16', '2022-09-21 03:07:16'),
(17, 7, NULL, 18, 2, 0, 91, 0, 1, 5, 37, 288, 0, 'Regional Office, Moulabibazar', 'আঞ্চলিক কার্যালয়, মৌলভীবাজার', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:08:51', '2022-09-21 03:08:51'),
(18, 7, NULL, 18, 1, 12, 0, 0, 1, 8, 62, 0, 0, 'Regional Office, Mymensingh', 'আঞ্চলিক কার্যালয়, ময়মনসিংহ', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:12:59', '2022-09-21 03:12:59'),
(19, 7, NULL, 18, 1, 11, 0, 0, 1, 1, 1, 0, 0, 'Camp Office, Cumilla', 'ক্যাম্প অফিস, কুমিল্লা', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:13:58', '2022-09-21 03:13:58'),
(20, 7, NULL, 18, 2, 0, 112, 0, 1, 6, 50, 381, 0, 'Camp office, Madaripur', 'ক্যাম্প অফিস, মাদারীপুর', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:15:18', '2022-09-21 03:15:18'),
(21, 7, NULL, 18, 2, 0, 33, 0, 1, 3, 29, 224, 0, 'Camp Office, Jhenaidah', 'ক্যাম্প অফিস, ঝিনাইদহ', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:16:33', '2022-09-21 03:16:33'),
(22, 7, NULL, 18, 2, 0, 300, 0, 1, 2, 14, 123, 0, 'Camp Office, Bogra', 'ক্যাম্প অফিস, বগুড়া', NULL, NULL, '', 0, 0, 1, 0, NULL, NULL, 1, '2022-09-21 03:18:29', '2022-09-21 03:18:29'),
(23, 7, NULL, 17, 1, 2, 0, 0, 1, 6, 47, 0, 0, 'Administrative', 'প্রশাসনিক', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-09-21 03:25:26', '2022-09-21 03:25:26'),
(24, 7, NULL, 17, 1, 2, 0, 0, 1, 6, 47, 0, 0, 'CMS & S&D', 'সিএমএস অ্যান্ড বিওবি', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-09-21 03:26:38', '2022-09-21 03:26:38'),
(25, 7, NULL, 17, 1, 2, 0, 0, 1, 6, 47, 0, 0, 'ICT Department', 'আইসিটি শাখা', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-09-21 03:27:54', '2022-09-21 03:27:54'),
(26, 11, NULL, 3, 1, 3, 0, 2, 1, 3, 27, 0, 0, 'District Office, Khulna', 'জেলা অফিস, খুলনা', NULL, NULL, '', 2, 10, 0, 0, NULL, NULL, 1, '2022-09-25 07:48:33', '2022-09-25 07:49:06'),
(27, 5, NULL, 19, 1, 7, 0, 0, 1, 1, 8, 0, 0, 'Bangladesh Tea Board', 'বাংলাদেশ চা বোর্ড', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-10-10 08:22:48', '2022-10-10 08:22:48'),
(28, 5, NULL, 20, 2, 0, 225, 0, 1, 7, 53, 399, 0, 'Sub-Office, Panchagar', 'সাব-অফিস, পঞ্চগড়', NULL, NULL, '', 20, 0, 1, 0, NULL, NULL, 1, '2022-10-23 03:11:46', '2022-10-23 03:11:46'),
(29, 5, NULL, 21, 2, 0, 92, 0, 1, 5, 37, 290, 0, 'Bangladesh Tea Research Institute (BTRI)', 'বাংলাদেশ চা গবেষণা ইনস্টিটিউট(বিটিআরআই)', NULL, NULL, '', 19, 27, 1, 0, NULL, NULL, 1, '2022-10-23 03:34:56', '2022-10-23 03:36:23'),
(30, 5, NULL, 21, 2, 0, 92, 0, 1, 5, 37, 290, 0, 'Project Development Unit (PDU)', 'প্রকল্প উন্নয়ন ইউনিট (পিডিউ)', NULL, NULL, '', 21, 0, 1, 0, NULL, NULL, 1, '2022-10-23 03:36:15', '2022-10-23 03:36:15'),
(31, 2, NULL, 14, 1, 2, 0, 35, 1, 6, 47, 0, 0, 'Verification', 'ভেরিফিকেশন', NULL, NULL, '', 0, 0, 0, 0, NULL, NULL, 1, '2022-11-06 03:40:18', '2022-11-06 03:40:18'),
(32, 2, NULL, 14, 1, 1, 0, 0, 1, 6, 47, 0, 0, 'Fair and Display', 'মেলা এবং প্রদর্শন', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2022-11-14 08:29:37', '2022-11-15 04:56:52'),
(33, 1, NULL, 15, 1, 1, 0, 0, 1, 6, 47, 0, 0, 'Secretary Office', 'সচিবের দপ্তর', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2022-11-28 03:25:52', '2022-11-28 03:25:52'),
(34, 1, NULL, 15, 1, 1, 0, 0, 1, 6, 47, 0, 0, 'IIT Wing', 'আইআইটি অনুবিভাগ', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2022-11-29 04:11:12', '2022-11-29 04:11:12'),
(35, 5, NULL, 22, 3, 0, 0, 0, 1, 5, 37, 285, 2547, 'New Samanbagh Tea Garden', 'নিউ সমনবাগ চা বাগান', 'Baralekha, Moulvibazar', 'বড়লেখা, মৌলভীবাজার', NULL, NULL, NULL, 0, NULL, 1, 1, 1, '2022-12-01 08:58:46', '2022-12-01 08:58:46'),
(36, 5, NULL, 22, 2, 0, 81, 0, 1, 5, 38, 299, 0, 'Popular Tea Garden', 'পপুলার চা বাগান', 'Madhabpur, Habiganj', 'মাধবপুর, হবিগঞ্জ', NULL, NULL, NULL, 0, NULL, 1, 1, 1, '2022-12-01 09:22:00', '2022-12-01 09:22:00'),
(37, 5, NULL, 22, 2, 0, 92, 0, 1, 5, 37, 290, 0, 'Laxmicherra Tea Estate', 'লক্ষ্মীচরা টি এস্টেট', 'Srimongol', 'শ্রীমঙ্গল', NULL, NULL, NULL, 0, NULL, 1, 1, 1, '2022-12-01 09:32:32', '2022-12-01 09:32:32'),
(38, 5, NULL, 22, 2, 0, 152, 0, 1, 8, 62, 473, 0, 'Chandovag Tea Garden', 'চান্দভাগ চা বাগান', 'In id autem veritati', 'Perferendis rerum as', NULL, NULL, NULL, 0, NULL, 1, 1, 1, '2022-12-05 09:00:43', '2023-01-29 09:25:04'),
(39, 8, NULL, 16, 1, 2, 0, 31, 1, 6, 47, 0, 0, 'BPC', 'বিপিসি', NULL, NULL, '2233', 0, 0, 0, 0, 1, 1, 1, '2022-12-13 09:58:47', '2022-12-13 09:58:47'),
(40, 7, NULL, 23, 2, 0, 300, 0, 1, 2, 14, 123, 0, 'Dc Office', 'DC Office', NULL, NULL, '1244', 18, 22, 0, 22, 1, 1, 1, '2023-01-04 05:58:25', '2023-01-25 10:53:57'),
(41, 7, NULL, 23, 1, 2, 0, 0, 1, 6, 47, 0, 0, 'Dhaka DC Office', 'জেলা প্রশাসকের কার্যালয়, ঢাকা ', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2023-01-09 04:20:49', '2023-01-09 04:20:49'),
(42, 7, NULL, 23, 2, 0, 313, 0, 1, 2, 16, 143, 0, 'Natore DC Office', 'জেলা প্রশাসক কার্যালয়, নাটোর', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2023-01-09 05:18:19', '2023-01-09 05:18:19'),
(43, 7, NULL, 23, 2, 4, 233, 0, 1, 7, 57, 429, 0, 'Gaibandha Dc', 'Gaibandha Dc', NULL, NULL, '3422', 23, 0, 0, 22, 1, 1, 1, '2023-01-10 09:22:29', '2023-01-10 09:22:29'),
(44, 5, NULL, 22, 3, 0, 0, 0, 1, 1, 3, 28, 279, 'Klonal Tea Garden', 'ক্লোনাল চা বাগান', 'Sunt iusto a eos ali', 'Voluptas quo exceptu', NULL, NULL, NULL, 0, NULL, 1, 1, 1, '2023-01-12 09:52:53', '2023-01-29 09:26:01'),
(45, 7, NULL, 18, 1, 10, 0, 0, 1, 7, 59, 0, 0, 'Regional Office, Rangpur', 'আঞ্চলিক কার্যালয়, রংপুর', NULL, NULL, '', 18, 0, 1, 0, 1, 1, 1, '2023-01-18 07:37:09', '2023-01-18 07:37:09'),
(46, 7, NULL, 18, 1, 4, 0, 0, 1, 2, 15, 0, 0, 'Regional Office, Rajshahi', 'আঞ্চলিক কার্যালয়, রাজশাহী', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2023-01-25 10:59:05', '2023-01-25 10:59:05'),
(47, 7, NULL, 23, 1, 10, 0, 0, 1, 7, 59, 0, 0, 'Rangpur DC Office', 'রংপুর ডিসি অফিস', NULL, NULL, '', 0, 0, 0, 0, 1, 1, 1, '2023-01-26 03:15:15', '2023-01-26 03:15:15'),
(48, 5, NULL, 22, 3, 0, 0, 0, 1, 4, 35, 266, 2393, 'Ispahany Tea Garden', 'ইস্পাহানি চা বাগান', 'Dhaka, Bangladesh', 'ঢাকা, বাংলাদেশ', NULL, NULL, NULL, 1, NULL, 1, 1, 1, '2023-01-30 10:49:55', '2023-01-30 10:54:36');

-- --------------------------------------------------------

--
-- Table structure for table `master_office_types`
--

CREATE TABLE `master_office_types` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED DEFAULT NULL,
  `office_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `office_type_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_office_types`
--

INSERT INTO `master_office_types` (`id`, `org_id`, `office_type_name`, `office_type_name_bn`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'EEP Office Type', 'EEP অফিসের ধরন', NULL, NULL, 2, '2022-05-30 08:29:20', '2022-06-21 10:35:30'),
(2, 11, 'DNCRP Divisional Office', 'ডিএনসিআরপি বিভাগীয় কার্যালয়', NULL, NULL, 1, '2022-06-21 07:54:00', '2022-07-04 03:18:38'),
(3, 11, 'DNCRP District Office', 'ডিএনসিআরপি জেলা অফিস', NULL, NULL, 1, '2022-06-21 07:54:35', '2022-07-04 08:21:08'),
(5, 11, 'Head Office', 'হেড অফিস', NULL, NULL, 1, '2022-06-21 10:36:46', '2022-06-21 10:36:46'),
(12, 10, 'Head Office', 'সদর দফতর', NULL, NULL, 1, '2022-07-25 07:54:37', '2022-07-25 07:54:37'),
(13, 4, 'Head Office BTC', 'Head Office BTC bn', NULL, NULL, 1, '2022-07-25 08:50:05', '2022-07-25 08:50:05'),
(14, 2, 'Head Office ', 'সদর দফতর', NULL, NULL, 1, '2022-08-03 05:27:26', '2022-08-03 05:27:26'),
(15, 1, 'Ministry', 'মন্ত্রণালয়', NULL, NULL, 1, '2022-08-16 08:10:47', '2022-08-16 08:10:47'),
(16, 8, 'Head Office', 'Head Office Bn', NULL, NULL, 1, '2022-09-13 08:54:40', '2022-09-13 08:54:40'),
(17, 7, 'Head Office', 'প্রধান কার্যালয়', NULL, NULL, 1, '2022-09-21 02:48:04', '2022-09-21 02:48:04'),
(18, 7, 'Regional Office', 'আঞ্চলিক কার্যালয়', NULL, NULL, 1, '2022-09-21 02:50:18', '2022-09-21 07:52:15'),
(19, 5, 'Head Office', 'প্রধান কার্যালয়', NULL, NULL, 1, '2022-10-10 08:17:04', '2022-10-10 08:17:04'),
(20, 5, 'Sub-Office', 'সাব-অফিস', NULL, NULL, 1, '2022-10-23 03:09:56', '2022-10-23 03:09:56'),
(21, 5, 'BTB Organization', 'বিটিবি সংস্থা', NULL, NULL, 1, '2022-10-23 03:24:44', '2022-10-23 03:30:11'),
(22, 5, 'Tea Garden', 'চা বাগান', NULL, NULL, 1, '2022-10-23 03:26:28', '2022-10-23 03:30:33'),
(23, 7, 'DC Office', 'জেলা প্রশাসকের কার্যালয়', NULL, NULL, 1, '2023-01-09 04:12:54', '2023-01-09 04:12:54');

-- --------------------------------------------------------

--
-- Table structure for table `master_org_components`
--

CREATE TABLE `master_org_components` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_org_components`
--

INSERT INTO `master_org_components` (`id`, `org_id`, `component_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(85, 1, 1, NULL, NULL, 1, '2022-07-21 09:31:48', '2022-07-21 09:31:48'),
(86, 2, 10, NULL, NULL, 1, '2022-08-03 05:23:59', '2022-08-03 05:23:59'),
(87, 1, 10, NULL, NULL, 1, '2022-08-03 05:23:59', '2022-08-03 05:23:59'),
(105, 5, 5, NULL, NULL, 1, '2022-09-08 05:34:23', '2022-09-08 05:34:23'),
(110, 4, 8, NULL, NULL, 1, '2022-09-08 05:36:17', '2022-09-08 05:36:17'),
(114, 8, 4, NULL, NULL, 1, '2022-10-03 06:39:39', '2022-10-03 06:39:39'),
(119, 11, 3, NULL, NULL, 1, '2022-11-17 04:07:45', '2022-11-17 04:07:45'),
(120, 1, 3, NULL, NULL, 1, '2022-11-17 04:07:45', '2022-11-17 04:07:45'),
(123, 2, 9, NULL, NULL, 1, '2022-11-23 03:03:53', '2022-11-23 03:03:53'),
(127, 15, 11, NULL, NULL, 1, '2022-11-23 03:16:32', '2022-11-23 03:16:32'),
(128, 10, 6, NULL, NULL, 1, '2022-11-23 03:17:34', '2022-11-23 03:17:34'),
(129, 1, 6, NULL, NULL, 1, '2022-11-23 03:17:34', '2022-11-23 03:17:34'),
(130, 7, 7, NULL, NULL, 1, '2023-01-10 04:52:02', '2023-01-10 04:52:02'),
(131, 1, 7, NULL, NULL, 1, '2023-01-10 04:52:02', '2023-01-10 04:52:02');

-- --------------------------------------------------------

--
-- Table structure for table `master_org_modules`
--

CREATE TABLE `master_org_modules` (
  `id` bigint UNSIGNED NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_org_profiles`
--

CREATE TABLE `master_org_profiles` (
  `id` bigint UNSIGNED NOT NULL,
  `org_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abbreviation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `abbreviation_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `establishment_year` int DEFAULT NULL,
  `about_org` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `about_org_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `mission` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `mission_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vision` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `vision_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hierarchy` int DEFAULT NULL,
  `website_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_org_profiles`
--

INSERT INTO `master_org_profiles` (`id`, `org_name`, `org_name_bn`, `abbreviation`, `abbreviation_bn`, `establishment_year`, `about_org`, `about_org_bn`, `mission`, `mission_bn`, `vision`, `vision_bn`, `logo`, `hierarchy`, `website_url`, `address`, `address_bn`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Ministry of Commerce', 'বাণিজ্য মন্ত্রণালয়', 'Ministry', 'মন্ত্রণালয়', 1985, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 'www.mincom.gov.bd/', '-', '-', NULL, NULL, 1, NULL, '2022-11-23 02:52:36'),
(2, 'Export Promotion Bureau\r\n', 'রপ্তানি উন্নয়ন ব্যুরো', 'EPB', 'ইপিবি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'www.epb.gov.bd/', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(4, 'Bangladesh Trade and Tariff Commission', 'বাংলাদেশ ট্রেড এন্ড ট্যারিফ কমিশন', 'BTTC', 'বিটিটিসি', 1973, '-', '-', '-', '-', '-', '-', NULL, 7, 'www.btc.gov.bd/', '-', '-', NULL, NULL, 1, NULL, '2022-11-23 03:24:45'),
(5, 'Bangladesh Tea Board', 'বাংলাদেশ চা বোর্ড', 'BTB', 'বিটিবি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'www.teaboard.gov.bd/', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(7, 'Trading Corporation of Bangladesh', 'ট্রেডিং কর্পোরেশন অব বাংলাদেশ', 'TCB', 'টিসিবি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'www.tcb.gov.bd/', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(8, 'Business Promotion Council', 'বিজনেস প্রোমোশন কাউন্সিল', 'BPC', 'বিপিসি', 1983, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 2, 'www.bpc.org.bd', 'Motijhil', 'মতিঝিল', NULL, NULL, 1, NULL, '2023-01-31 10:03:13'),
(10, 'Bangladesh Foreign Trade Institution', 'বাংলাদেশ ফরেন ট্রেড ইনস্টিটিউট', 'BFTI', 'বিএফটিআই', 2003, 'Bangladesh Foreign Trade Institute (BFTI) is a non-profit research and training institution. Founded in 2003, it traces its inception to the public-private partnership (PPP) between the Ministry of Commerce (MoC), the Government of Bangladesh, and the private sector. Its prime focus is research, education, training, and policy advocacy on international trade-related issues. The beneficiaries of the institute comprise both the public and private sectors, engaged in trade-related activities.', 'Bangladesh Foreign Trade Institute (BFTI) is a non-profit research and training institution. Founded in 2003, it traces its inception to the public-private partnership (PPP) between the Ministry of Commerce (MoC), the Government of Bangladesh, and the private sector. Its prime focus is research, education, training, and policy advocacy on international trade-related issues. The beneficiaries of the institute comprise both the public and private sectors, engaged in trade-related activities.', 'To set the country’s foreign trade management in a professional manner by developing trade and business knowledge of the public and private sector practitioners through top-quality research, policy advice, education, and training.\n\nThe Institute has three major mandates:\n\nProviding policy support to the government and the private sector trade bodies and associations on existing and emerging trade-related issues;\nBuilding trade-related capacity for government agencies and private sector enterprises through training and research; and\nWe are creating a policy forum for consultation between policymakers and business leaders.\n \nTo carry out its mandate, the Institute may conduct the following activities:\n\nTraining\nResearch\nPolicy Advocacy\nConsulting\nEducation', 'To set in motion the country’s foreign trade management in a professional manner by developing trade and business knowledge of the public and private sector practitioners through top quality research, policy advice, education and training.\n\nThe Institute has three major mandates:\n\nProviding policy support to the government and the private sector trade bodies and associations on existing and emerging trade-related issues;\nBuilding trade-related capacity for government agencies and private sector enterprises through training and research; and\nCreating a policy forum for consultation between policymakers and business leaders.\n \n\nTo carry out its mandate, the Institute may conduct the following activities:\n\nTraining\nResearch\nPolicy Advocacy\nConsulting\nEducation', NULL, NULL, NULL, 10, 'bfti.org.bd/', '1, TCB Bhaban, Karwan Bazar, Dhaka 1215', '১, টিসিবি ভবনে, কারওয়ান বাজার, ঢাকা ১২১৫', NULL, NULL, 1, NULL, '2022-08-30 02:38:06'),
(11, 'Directorate of National Consumer Rights Protection', 'জাতীয় ভোক্তা অধিকার সংরক্ষণ অধিদপ্তর', 'DNCRP', 'ডিএনসিআরপি', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'dncrp.portal.gov.bd/', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(15, 'Office of the Registrar of Joint Stock Companies and Firms', 'যৌথমূলধন কোম্পানি ও ফার্মসমূহের পরিদপ্তর', 'RJSC', 'আরজেএসসি ', 1962, '-', '-', '-', '-', '-', '-', '', 10, NULL, '-', '-', NULL, NULL, 1, '2022-11-23 03:14:22', '2022-11-23 03:14:22');

-- --------------------------------------------------------

--
-- Table structure for table `master_pauroshobas`
--

CREATE TABLE `master_pauroshobas` (
  `id` bigint UNSIGNED NOT NULL,
  `division_id` bigint UNSIGNED NOT NULL,
  `district_id` bigint UNSIGNED NOT NULL,
  `upazila_id` bigint UNSIGNED NOT NULL,
  `pauroshoba_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pauroshoba_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pauroshoba_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_pauroshobas`
--

INSERT INTO `master_pauroshobas` (`id`, `division_id`, `district_id`, `upazila_id`, `pauroshoba_name`, `pauroshoba_name_bn`, `pauroshoba_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 15, 134, 'PABA Pauroshava', 'পবা পৌরসভা', 1111, 2, 1, 1, '2021-05-02 10:32:30', '2021-06-02 16:34:27'),
(2, 2, 19, 168, 'Naogaon Sadar Pouroshova', 'নওগাঁ সদর পৌরসভা', 1112, 2, 1, 1, '2021-05-02 10:33:23', '2021-06-02 16:35:10'),
(3, 2, 19, 162, 'Patnitala Pouroshova', 'পাটনিটলা পৌরসভা ', 1113, 2, 1, 1, '2021-05-02 10:33:53', '2021-06-02 16:35:49'),
(4, 2, 18, 155, 'Chapainawabganj Pouroshova', 'চাঁপাইনবাবগঞ্জ পৌরসভা', 1114, 2, 1, 1, '2021-05-02 10:34:57', '2021-06-02 16:36:43'),
(5, 6, 41, 317, 'Kaliganj', 'কালীগঞ্জ ', 1115, 1, 1, 1, '2021-05-23 12:37:52', '2021-06-02 16:37:06'),
(6, 6, 41, 319, 'Kapasia', 'কাপাসিয়া ', 1116, 1, 1, 1, '2021-05-23 12:38:21', '2021-06-02 16:37:21'),
(7, 6, 40, 312, 'Monohardi', 'মনোহরদী ', 1117, 1, 1, 1, '2021-05-23 12:50:54', '2021-06-02 16:37:38'),
(8, 2, 15, 139, 'Bagha', 'বাঘা ', 1118, 1, 1, 1, '2021-06-02 16:20:35', '2021-06-02 16:20:35'),
(9, 2, 15, 139, 'Arani', 'আড়ানী', 1119, 1, 1, 1, '2021-06-02 16:23:29', '2021-06-02 16:23:29'),
(10, 2, 15, 140, 'Godagari ', 'গোদাগাড়ী', 1120, 1, 1, 1, '2021-06-02 16:31:52', '2021-06-02 16:31:52'),
(11, 3, 27, 206, 'Paikgasa', 'পাইকগাছা', 1121, 1, 1, 1, '2021-06-02 16:35:44', '2021-06-02 16:35:44'),
(12, 3, 20, 172, 'Abhaynagar', 'অভয়নগর', 1122, 1, 1, 1, '2021-06-02 16:38:36', '2021-06-02 16:38:36'),
(13, 3, 20, 173, 'Bagherpara', 'বাঘারপাড়া', 1123, 1, 1, 1, '2021-06-02 16:40:28', '2021-06-02 16:40:28'),
(14, 2, 15, 141, 'Tanore', 'তানর ', 1124, 1, 1, 1, '2021-06-02 16:43:11', '2021-06-02 16:43:11'),
(15, 2, 15, 137, 'Charghat', 'চারঘাট', 1125, 1, 1, 1, '2021-06-02 16:48:19', '2021-06-02 16:48:19'),
(16, 2, 15, 135, 'Durgapur', 'দুর্গাপুর ', 1126, 1, 1, 1, '2021-06-02 16:49:20', '2021-06-02 16:49:20'),
(17, 3, 20, 174, 'Chougachha', 'চৌগাছা', 1127, 1, 1, 1, '2021-06-02 16:51:30', '2021-06-02 16:51:30'),
(18, 3, 20, 177, 'Jessore Sadar', 'যশোর সদর', 1128, 1, 1, 1, '2021-06-02 16:53:23', '2021-06-02 16:53:23'),
(19, 3, 20, 177, 'Jashore Sadar', 'যশোর সদর', 1129, 1, 1, 1, '2021-06-02 16:55:42', '2021-06-02 16:55:42'),
(20, 2, 15, 138, 'Puthia', 'পুঠিয়া', 1130, 1, 1, 1, '2021-06-02 16:56:17', '2021-06-02 16:56:17'),
(21, 2, 14, 128, 'Nandigram ', 'নন্দীগ্রাম', 1131, 1, 1, 1, '2021-06-02 16:59:39', '2021-06-02 16:59:39'),
(22, 3, 20, 175, 'Jhikargacha', 'ঝিকরগাছা', 1132, 1, 1, 1, '2021-06-02 17:00:11', '2021-06-02 17:00:11'),
(23, 2, 14, 130, 'Dhunat ', 'ধুনট ', 1133, 1, 1, 1, '2021-06-02 17:00:33', '2021-06-02 17:00:33'),
(24, 2, 14, 131, 'Gabtali ', 'গাবতলী ', 1134, 1, 1, 1, '2021-06-02 17:01:15', '2021-06-02 17:01:15'),
(25, 3, 20, 176, 'Keshabpur ', 'কেশবপুর', 1135, 1, 1, 1, '2021-06-02 17:01:27', '2021-06-02 17:01:27'),
(26, 2, 14, 126, 'Dhupchanchia ', 'ধুপচঞ্চিয়া ', 1136, 1, 1, 1, '2021-06-02 17:01:51', '2021-06-02 17:01:51'),
(27, 2, 14, 129, 'Sonatala ', 'সোনাতলা ', 1137, 1, 1, 1, '2021-06-02 17:02:27', '2021-06-02 17:02:27'),
(28, 3, 20, 171, 'Monirampur', 'মণিরামপুর', 1138, 1, 1, 1, '2021-06-02 17:02:40', '2021-06-02 17:02:40'),
(29, 3, 20, 178, 'Sharsha', 'শার্শা', 1139, 1, 1, 1, '2021-06-02 17:03:25', '2021-06-02 17:03:25'),
(30, 2, 14, 124, 'Sariakandi ', 'সারিয়াকান্দি ', 1140, 1, 1, 1, '2021-06-02 17:03:35', '2021-06-02 17:03:35'),
(31, 2, 14, 133, 'Shibgonj ', 'শিবগঞ্জ ', 1141, 1, 1, 1, '2021-06-02 17:04:10', '2021-06-02 17:04:10'),
(32, 2, 14, 132, 'Sherpur', 'শেরপুর ', 1142, 1, 1, 1, '2021-06-02 17:04:51', '2021-06-02 17:04:51'),
(33, 3, 29, 224, 'Jhenaidah Sadar', 'ঝিনাইদহ সদর', 1143, 1, 1, 1, '2021-06-02 17:05:01', '2021-06-02 17:05:01'),
(34, 6, 47, 365, 'Savar', 'সাভার', 1144, 1, 1, 1, '2021-06-02 17:05:16', '2021-06-02 17:05:16'),
(35, 6, 47, 369, 'Dohar', 'দোহার', 1145, 1, 1, 1, '2021-06-02 17:05:48', '2021-06-02 17:05:48'),
(36, 3, 29, 226, 'Harinakundu', 'হরিনাকুন্ডু', 1146, 1, 1, 1, '2021-06-02 17:06:01', '2021-06-02 17:06:01'),
(37, 6, 47, 366, 'Dhamrai', 'ধামরাই', 1147, 1, 1, 1, '2021-06-02 17:06:26', '2021-06-02 17:06:26'),
(38, 2, 13, 116, 'Pabna Sadar', 'পাবনা সদর', 1148, 1, 1, 1, '2021-06-02 17:06:52', '2021-06-02 17:06:52'),
(39, 2, 13, 118, 'Atgharia ', 'আটঘরিয়া ', 1149, 1, 1, 1, '2021-06-02 17:07:32', '2021-06-02 17:07:32'),
(40, 2, 13, 119, 'Chatmohar ', 'চাটমোহর ', 1150, 1, 1, 1, '2021-06-02 17:08:14', '2021-06-02 17:08:14'),
(41, 2, 13, 115, 'Bhangura ', 'ভাঙ্গুরা ', 1151, 1, 1, 1, '2021-06-02 17:09:01', '2021-06-02 17:09:01'),
(42, 2, 13, 114, 'Ishwardi ', 'ইশ্বরদী ', 1152, 1, 1, 1, '2021-06-02 17:10:20', '2021-06-02 17:10:20'),
(43, 2, 13, 120, 'Sathiya ', 'সাথিয়া ', 1153, 1, 1, 1, '2021-06-02 17:11:13', '2021-06-02 17:11:13'),
(44, 2, 13, 117, 'Bera ', 'বেরা ', 1154, 1, 1, 1, '2021-06-02 17:11:39', '2021-06-02 17:11:39'),
(45, 2, 13, 113, 'Sujanagar', 'সুজনগর ', 1155, 1, 1, 1, '2021-06-02 17:12:21', '2021-06-02 17:12:21'),
(46, 6, 46, 360, 'Manikganj', 'মানিকগঞ্জ', 1156, 1, 1, 1, '2021-06-02 17:13:59', '2021-06-02 17:13:59'),
(47, 2, 12, 110, 'Sirajganj Sadar', 'সিরাজগঞ্জ সদর ', 1157, 1, 1, 1, '2021-06-02 17:14:09', '2021-06-02 17:14:09'),
(48, 2, 12, 109, 'Shahzadpur ', 'শাহজাদপুর ', 1158, 1, 1, 1, '2021-06-02 17:14:46', '2021-06-02 17:14:46'),
(49, 2, 12, 108, 'Raiganj ', 'রায়গঞ্জ ', 1159, 1, 1, 1, '2021-06-02 17:15:45', '2021-06-02 17:15:45'),
(50, 3, 29, 228, 'Kotchandpur', 'কোটচাঁদপুর', 1160, 1, 1, 1, '2021-06-02 17:15:57', '2021-06-02 17:15:57'),
(51, 2, 12, 112, 'Ullapara ', 'উল্লাপাড়া ', 1161, 1, 1, 1, '2021-06-02 17:16:40', '2021-06-02 17:16:40'),
(52, 2, 12, 107, 'Kazipur ', 'কাজিপুর ', 1162, 1, 1, 1, '2021-06-02 17:17:29', '2021-06-02 17:17:29'),
(53, 2, 12, 104, 'Belkuchi ', 'বেলকুচি ', 1163, 1, 1, 1, '2021-06-02 17:18:39', '2021-06-02 17:18:39'),
(54, 6, 46, 364, 'Singair', 'সিঙ্গাইর', 1164, 1, 1, 1, '2021-06-02 17:19:09', '2021-06-02 17:19:09'),
(55, 2, 12, 111, 'tarash', 'তারাশ', 1165, 1, 1, 1, '2021-06-02 17:19:35', '2021-06-02 17:19:35'),
(56, 2, 19, 163, 'Dhamuirahata', 'ধামইরাহাতা ', 1166, 1, 1, 1, '2021-06-02 17:20:36', '2021-06-02 17:20:36'),
(57, 2, 16, 149, 'Naldanga ', 'নলডাঙ্গা ', 1167, 1, 1, 1, '2021-06-02 17:21:57', '2021-06-02 17:21:57'),
(58, 2, 16, 144, 'Singra ', 'সিংড়া ', 1168, 1, 1, 1, '2021-06-02 17:22:20', '2021-06-02 17:22:20'),
(59, 2, 16, 148, 'Gurdaspur ', 'গুরুদাসপুর ', 1169, 1, 1, 1, '2021-06-02 17:22:52', '2021-06-02 17:22:52'),
(60, 2, 16, 147, 'Gopalpur', 'গোপালপুর ', 1170, 1, 1, 1, '2021-06-02 17:23:34', '2021-06-02 17:23:34'),
(61, 3, 29, 229, 'Moheshpur', 'মহেশপুর', 1171, 1, 1, 1, '2021-06-02 17:23:49', '2021-06-02 17:23:49'),
(62, 2, 18, 159, 'Shibganj ', 'শিবগঞ্জ ', 1172, 1, 1, 1, '2021-06-02 17:24:26', '2021-06-02 17:24:26'),
(63, 6, 48, 370, 'Munshiganj', 'মুন্সিগঞ্জ', 1173, 1, 1, 1, '2021-06-02 17:24:45', '2021-06-02 17:24:45'),
(64, 3, 29, 225, 'Shailkupa', 'শৈলকূপা', 1174, 1, 1, 1, '2021-06-02 17:24:51', '2021-06-02 17:24:51'),
(65, 2, 18, 155, ' Rahanpur ', 'রাহানপুর ', 1175, 1, 1, 1, '2021-06-02 17:25:06', '2021-06-02 17:50:24'),
(66, 3, 26, 204, 'Magura Sadar', 'মাগুরা সদর', 1176, 1, 1, 1, '2021-06-02 17:26:41', '2021-06-02 17:26:41'),
(67, 3, 23, 189, 'Narail Sadar', 'নড়াইল সদর', 1177, 1, 1, 1, '2021-06-02 17:28:26', '2021-06-02 17:28:26'),
(68, 3, 23, 191, 'Kalia', 'কালিয়া', 1178, 1, 1, 1, '2021-06-02 17:29:18', '2021-06-02 17:29:18'),
(69, 3, 23, 190, 'Lohagara', 'লোহাগাড়া', 1179, 1, 1, 1, '2021-06-02 17:30:00', '2021-06-02 17:30:00'),
(70, 6, 41, 321, 'Sreepur', 'শ্রীপুর', 1180, 1, 1, 1, '2021-06-02 17:30:49', '2021-06-02 17:30:49'),
(71, 3, 28, 216, 'Bagerhat Sadar', 'বাগেরহাট সদর', 1181, 1, 1, 1, '2021-06-02 17:31:28', '2021-06-02 17:31:28'),
(72, 6, 51, 385, 'Gopalganj', 'গোপালগঞ্জ', 1182, 1, 1, 1, '2021-06-02 17:32:06', '2021-06-02 17:32:06'),
(73, 3, 28, 222, 'Mongla ', 'মংলা', 1183, 1, 1, 1, '2021-06-02 17:32:27', '2021-06-02 17:32:27'),
(74, 6, 51, 388, ' Kotalipara ', 'কোটালীপাড়া', 1184, 1, 1, 1, '2021-06-02 17:32:50', '2021-06-02 17:32:50'),
(75, 6, 51, 387, 'Tungipara ', 'টুঙ্গিপাড়া', 1185, 1, 1, 1, '2021-06-02 17:33:32', '2021-06-02 17:33:32'),
(76, 5, 38, 298, 'Habiganj Sadar', 'হবিগঞ্জ সদর ', 1186, 1, 1, 1, '2021-06-02 17:34:10', '2021-06-02 17:34:10'),
(77, 6, 51, 389, 'Muksudpur', 'মুকসুদপুর', 1187, 1, 1, 1, '2021-06-02 17:34:15', '2021-06-02 17:34:15'),
(78, 6, 49, 376, 'Rajbari', 'রাজবাড়ী', 1188, 1, 1, 1, '2021-06-02 17:35:28', '2021-06-02 17:35:28'),
(79, 5, 38, 292, 'Nabiganj ', 'নবীগঞ্জ ', 1189, 1, 1, 1, '2021-06-02 17:36:39', '2021-06-02 17:36:39'),
(80, 3, 28, 220, 'Morrelgonj', 'মোড়লগঞ্জ', 1190, 1, 1, 1, '2021-06-02 17:36:58', '2021-06-02 17:36:58'),
(81, 5, 38, 299, 'Madhabpur ', 'মাধবপুর ', 1191, 1, 1, 1, '2021-06-02 17:37:08', '2021-06-02 17:37:08'),
(82, 5, 38, 297, 'Chunarughat ', 'চুনারুঘাট ', 1192, 1, 1, 1, '2021-06-02 17:37:48', '2021-06-02 17:37:48'),
(83, 5, 38, 294, 'Ajmiriganj', 'আজমিরীগঞ্জ ', 1193, 1, 1, 1, '2021-06-02 17:38:25', '2021-06-02 17:38:25'),
(84, 5, 39, 300, 'Sunamganj', 'সুনামগঞ্জ ', 1194, 1, 1, 1, '2021-06-02 17:39:07', '2021-06-02 17:39:07'),
(85, 3, 21, 182, 'Satkhira Sadar ', 'সাতক্ষীরা সদর', 1195, 1, 1, 1, '2021-06-02 17:39:37', '2021-06-02 17:39:37'),
(86, 5, 39, 303, 'Chattak', 'চাটক ', 1196, 1, 1, 1, '2021-06-02 17:39:41', '2021-06-02 17:39:41'),
(87, 5, 39, 304, 'Jagannathpur ', 'জগন্নাথপুর ', 1197, 1, 1, 1, '2021-06-02 17:40:17', '2021-06-02 17:40:17'),
(88, 5, 39, 310, 'Derai', 'দেড়ই ', 1198, 1, 1, 1, '2021-06-02 17:40:42', '2021-06-02 17:40:42'),
(89, 3, 21, 181, 'Kalaroa', 'কলারোয়া', 1199, 1, 1, 1, '2021-06-02 17:40:54', '2021-06-02 17:40:54'),
(90, 6, 49, 378, ' Pangsha', 'পাংশা', 1200, 1, 1, 1, '2021-06-02 17:41:10', '2021-06-02 17:41:10'),
(91, 5, 37, 288, 'Moulvibazar Sadar', 'মৌলভীবাজার সদর ', 1201, 1, 1, 1, '2021-06-02 17:41:21', '2021-06-02 17:41:21'),
(92, 5, 37, 290, 'Sreemangal ', 'শ্রীমঙ্গল ', 1202, 1, 1, 1, '2021-06-02 17:41:45', '2021-06-02 17:41:45'),
(93, 3, 24, 192, 'Chuadanga Sadar', 'চুয়াডাঙ্গা সদর', 1203, 1, 1, 1, '2021-06-02 17:41:52', '2021-06-02 17:41:52'),
(94, 6, 49, 377, 'Goalanda', 'গোয়ালন্দ', 1204, 1, 1, 1, '2021-06-02 17:41:59', '2021-06-02 17:42:45'),
(95, 5, 37, 285, 'Borolekha ', 'বোরলেখা ', 1205, 1, 1, 1, '2021-06-02 17:42:40', '2021-06-02 17:42:40'),
(96, 3, 24, 193, 'Alamdanga', 'আলমডাঙ্গা', 1206, 1, 1, 1, '2021-06-02 17:42:51', '2021-06-02 17:42:51'),
(97, 3, 24, 194, 'Damurhuda', 'দামুড়হুদা', 1207, 1, 1, 1, '2021-06-02 17:43:49', '2021-06-02 17:43:49'),
(98, 5, 37, 287, 'Kulaura ', 'কুলাউড়া ', 1208, 1, 1, 1, '2021-06-02 17:44:49', '2021-06-02 17:44:49'),
(99, 3, 24, 195, 'Jibonnagar', 'Jibonnagar', 1209, 1, 1, 1, '2021-06-02 17:45:00', '2021-06-02 17:45:00'),
(100, 5, 37, 286, 'Kamalganj', 'কমলগঞ্জ ', 1210, 1, 1, 1, '2021-06-02 17:45:23', '2021-06-02 17:45:23'),
(101, 6, 52, 390, 'Faridpur', 'ফরিদপুর', 1211, 1, 1, 1, '2021-06-02 17:45:48', '2021-06-02 17:45:48'),
(102, 5, 36, 277, 'Golapganj ', 'গোলাপগঞ্জ ', 1212, 1, 1, 1, '2021-06-02 17:45:57', '2021-06-02 17:45:57'),
(103, 3, 25, 196, 'Kushtia Sadar', 'কুষ্টিয়া সদর', 1213, 1, 1, 1, '2021-06-02 17:46:28', '2021-06-02 17:46:28'),
(104, 6, 52, 395, 'Bhanga', 'ভাঙ্গা', 1214, 1, 1, 1, '2021-06-02 17:46:57', '2021-06-02 17:46:57'),
(105, 5, 36, 273, 'Beanibazar ', 'বিয়ানীবাজার ', 1215, 1, 1, 1, '2021-06-02 17:47:07', '2021-06-02 17:47:07'),
(106, 5, 36, 280, 'Kanaighat ', 'কানাইঘাট ', 1216, 1, 1, 1, '2021-06-02 17:47:30', '2021-06-02 17:47:30'),
(107, 6, 52, 392, 'Boalmari', 'বোয়ালমারী', 1217, 1, 1, 1, '2021-06-02 17:47:34', '2021-06-02 17:47:34'),
(108, 3, 25, 198, 'Khoksa', 'খোকসা', 1218, 1, 1, 1, '2021-06-02 17:47:41', '2021-06-02 17:47:41'),
(109, 5, 36, 282, 'Zakiganj', 'জকিগঞ্জ ', 1219, 1, 1, 1, '2021-06-02 17:48:02', '2021-06-02 17:48:02'),
(110, 6, 52, 394, 'Nagarkanda', 'নগরকান্দা', 1220, 1, 1, 1, '2021-06-02 17:48:23', '2021-06-02 17:48:23'),
(111, 3, 25, 197, 'Kamarkhali', 'কামারখালী', 1221, 1, 1, 1, '2021-06-02 17:48:35', '2021-06-02 17:48:35'),
(112, 6, 50, 381, 'Madaripur', 'মাদারীপুর', 1222, 1, 1, 1, '2021-06-02 17:49:04', '2021-06-02 17:49:04'),
(113, 3, 25, 199, 'Mirpur', 'মিরপুর', 1223, 1, 1, 1, '2021-06-02 17:49:32', '2021-06-02 17:49:32'),
(114, 6, 50, 382, 'Shibchar', 'শিবচর', 1224, 1, 1, 1, '2021-06-02 17:49:38', '2021-06-02 17:49:38'),
(115, 3, 25, 201, 'Bheramara', 'ভেড়ামারা', 1225, 1, 1, 1, '2021-06-02 17:50:46', '2021-06-02 17:50:46'),
(116, 6, 50, 383, 'Kalkini', 'কালকিনি', 1226, 1, 1, 1, '2021-06-02 17:51:21', '2021-06-02 17:51:21'),
(117, 2, 17, 154, 'Joypurhat Sadar', 'জয়পুরহাট সদর ', 1227, 1, 1, 1, '2021-06-02 17:52:08', '2021-06-02 17:52:08'),
(118, 2, 17, 153, 'Panchbibi ', 'পাঁচবিবি ', 1228, 1, 1, 1, '2021-06-02 17:52:44', '2021-06-02 17:52:44'),
(119, 6, 50, 384, 'Rajoir', 'রাজৈর', 1229, 1, 1, 1, '2021-06-02 17:53:09', '2021-06-02 17:53:09'),
(120, 2, 17, 151, 'Kalai ', 'কালাই ', 1230, 1, 1, 1, '2021-06-02 17:53:12', '2021-06-02 17:53:12'),
(121, 3, 22, 187, 'Meherpur Sadar', 'মেহেরপুর সদর', 1231, 1, 1, 1, '2021-06-02 17:53:41', '2021-06-02 17:53:41'),
(122, 6, 43, 332, 'Sonargaon', 'সোনারগাঁও', 1232, 1, 1, 1, '2021-06-02 17:55:39', '2021-06-02 17:55:39'),
(123, 3, 22, 188, 'Gangni', 'গাংনী', 1233, 1, 1, 1, '2021-06-02 17:56:16', '2021-06-02 17:56:16'),
(124, 8, 63, 475, 'Jamalpur Sadar', 'জামালপুর সদর', 1234, 1, 1, 1, '2021-06-02 17:57:48', '2021-06-02 17:57:48'),
(125, 2, 17, 150, 'Akkelpur ', 'আক্কেলপুর ', 1235, 1, 1, 1, '2021-06-02 17:58:14', '2021-06-02 17:58:14'),
(126, 6, 43, 328, ' Araihazar', 'আড়াইহাজার', 1236, 1, 1, 1, '2021-06-02 17:58:34', '2021-06-02 17:58:34'),
(127, 2, 17, 152, 'Khetlal', 'ক্ষেতলাল ', 1237, 1, 1, 1, '2021-06-02 17:58:52', '2021-06-02 17:58:52'),
(128, 8, 63, 479, 'Sarishabari', 'সরিষাবাড়ি', 1238, 1, 1, 1, '2021-06-02 17:59:17', '2021-06-02 17:59:17'),
(129, 6, 40, 313, 'Narsingdi', 'নরসিংদী', 1239, 1, 1, 1, '2021-06-02 18:00:01', '2021-06-02 18:00:01'),
(130, 8, 63, 477, 'Islampur', 'ইসলামপুর', 1240, 1, 1, 1, '2021-06-02 18:00:16', '2021-06-02 18:00:16'),
(131, 8, 63, 478, 'Dewangonj', 'দেওয়ানগঞ্জ', 1241, 1, 1, 1, '2021-06-02 18:01:19', '2021-06-02 18:01:19'),
(132, 8, 63, 476, 'Melandah', 'মেলান্দহ', 1242, 1, 1, 1, '2021-06-02 18:02:02', '2021-06-02 18:02:02'),
(133, 8, 63, 480, 'Madarganj', 'মাদারগঞ্জ', 1243, 1, 1, 1, '2021-06-02 18:02:56', '2021-06-02 18:02:56'),
(134, 8, 63, 481, 'Bokshiganj', 'বকশীগঞ্জ', 1244, 1, 1, 1, '2021-06-02 18:04:55', '2021-06-02 18:04:55'),
(135, 8, 61, 457, 'Sherpur Sadar', 'শেরপুর সদর', 1245, 1, 1, 1, '2021-06-02 18:07:11', '2021-06-02 18:07:11'),
(136, 8, 61, 458, 'Nalitabari', 'নালিতাবাড়ি', 1246, 1, 1, 1, '2021-06-02 18:08:15', '2021-06-02 18:08:15'),
(137, 8, 61, 460, 'Nokla', 'নোকলা', 1247, 1, 1, 1, '2021-06-02 18:09:29', '2021-06-02 18:09:29'),
(138, 8, 61, 459, 'Sreebordi', 'শ্রীবোর্দি', 1248, 1, 1, 1, '2021-06-02 18:11:20', '2021-06-02 18:11:20'),
(139, 8, 62, 471, 'Gafargaon', 'গফরগাঁও', 1249, 1, 1, 1, '2021-06-02 18:12:45', '2021-06-02 18:12:45'),
(140, 8, 62, 463, 'Trishal ', 'ত্রিশাল', 1250, 1, 1, 1, '2021-06-02 18:14:31', '2021-06-02 18:14:31'),
(141, 8, 62, 465, 'Muktagacha', 'মুক্তগাছা', 1251, 1, 1, 1, '2021-06-02 18:15:17', '2021-06-02 18:15:17'),
(142, 6, 40, 316, 'Shibpur', 'শিবপুর', 1252, 1, 1, 1, '2021-06-02 18:15:17', '2021-06-02 18:15:17'),
(143, 6, 40, 315, 'Raipura', 'রায়পুরা', 1253, 1, 1, 1, '2021-06-02 18:15:48', '2021-06-02 18:15:48'),
(144, 8, 62, 472, 'Iswarganj', 'ইশ্বরগঞ্জ', 1254, 1, 1, 1, '2021-06-02 18:16:33', '2021-06-02 18:16:33'),
(145, 6, 42, 322, 'Shariatpur', 'শরীয়তপুর', 1255, 1, 1, 1, '2021-06-02 18:17:01', '2021-06-02 18:17:01'),
(146, 8, 62, 464, 'Bhaluka', 'ভালুকা', 1256, 1, 1, 1, '2021-06-02 18:17:36', '2021-06-02 18:17:36'),
(147, 6, 42, 327, 'Damudya', 'দামুড্যা', 1257, 1, 1, 1, '2021-06-02 18:17:39', '2021-06-02 18:17:39'),
(148, 8, 62, 470, 'Gouripur', 'গৌরীপুর', 1258, 1, 1, 1, '2021-06-02 18:19:23', '2021-06-02 18:19:23'),
(149, 6, 42, 323, 'Naria', 'নারিয়া', 1259, 1, 1, 1, '2021-06-02 18:19:30', '2021-06-02 18:19:30'),
(150, 8, 62, 468, 'Phulpur', 'ফুলপুর', 1260, 1, 1, 1, '2021-06-02 18:20:06', '2021-06-02 18:20:06'),
(151, 8, 62, 462, 'Fulbaria', 'ফুলবাড়িয়া', 1261, 1, 1, 1, '2021-06-02 18:20:48', '2021-06-02 18:20:48'),
(152, 8, 62, 473, 'Nandail', 'নান্দাইল', 1262, 1, 1, 1, '2021-06-02 18:21:36', '2021-06-02 18:21:36'),
(153, 8, 62, 469, 'Haluaghat', 'হালুয়াঘাট', 1263, 1, 1, 1, '2021-06-02 18:22:34', '2021-06-02 18:22:34'),
(154, 8, 64, 491, 'Netrokona Sadar', 'নেত্রকোনা সদর', 1264, 1, 1, 1, '2021-06-02 18:23:42', '2021-06-02 18:23:42'),
(155, 8, 64, 489, 'Mohongonj', 'মোনগঞ্জ', 1265, 1, 1, 1, '2021-06-02 18:25:14', '2021-06-02 18:26:21'),
(156, 6, 42, 324, 'Jazeera', 'জাজিরা', 1266, 1, 1, 1, '2021-06-02 18:29:28', '2021-06-02 18:29:28'),
(157, 6, 42, 326, 'Bhedarganj', 'ভেদারগঞ্জ', 1267, 1, 1, 1, '2021-06-02 18:30:07', '2021-06-02 18:30:07'),
(158, 8, 64, 484, 'Kendua', 'কেন্দুয়া', 1268, 1, 1, 1, '2021-06-02 18:30:07', '2021-06-02 18:30:07'),
(159, 6, 42, 325, 'Gosairhat', 'গোসাইরহাট', 1269, 1, 1, 1, '2021-06-02 18:30:44', '2021-06-02 18:30:44'),
(160, 8, 64, 486, 'Madan ', 'মদন', 1270, 1, 1, 1, '2021-06-02 18:30:44', '2021-06-02 18:30:44'),
(161, 6, 45, 352, 'Kishoreganj', 'কিশোরগঞ্জ', 1271, 1, 1, 1, '2021-06-04 10:48:15', '2021-06-04 10:48:15'),
(162, 6, 45, 347, 'Bhairab', 'ভৈরব', 1272, 1, 1, 1, '2021-06-04 10:48:59', '2021-06-04 10:48:59'),
(163, 6, 45, 354, 'Bajitpur', 'বাজিতপুর', 1273, 1, 1, 1, '2021-06-04 10:49:34', '2021-06-04 10:49:34'),
(164, 6, 45, 353, 'Karimganj', 'করিমগঞ্জ', 1274, 1, 1, 1, '2021-06-04 10:50:38', '2021-06-04 10:50:38'),
(165, 6, 45, 349, 'Hossainpur', 'হোসেনপুর', 1275, 1, 1, 1, '2021-06-04 10:51:12', '2021-06-04 10:51:12'),
(166, 6, 45, 351, 'Kuliachar', 'কুলিয়াচর', 1276, 1, 1, 1, '2021-06-04 10:51:44', '2021-06-04 10:51:44'),
(167, 6, 45, 346, 'Katiadi', 'কটিয়াদি', 1277, 1, 1, 1, '2021-06-04 10:52:31', '2021-06-04 10:52:31'),
(168, 1, 8, 68, 'Patiya', 'পটিয়া', 1278, 1, 1, 1, '2021-06-04 10:53:02', '2021-06-04 10:53:02'),
(169, 6, 45, 350, 'Pakundia', 'পাকুন্দিয়া', 1279, 1, 1, 1, '2021-06-04 10:53:49', '2021-06-04 10:53:49'),
(170, 1, 8, 67, 'Mirsharai', 'মীরসরাই', 1280, 1, 1, 1, '2021-06-04 10:55:46', '2021-06-04 10:55:46'),
(171, 4, 33, 254, 'Gournadi', 'গৌরনদী', 1281, 1, 1, 1, '2021-06-04 10:56:39', '2021-06-04 10:56:39'),
(172, 4, 33, 257, 'Muladi', 'মুলাদী', 1282, 1, 1, 1, '2021-06-04 10:57:18', '2021-06-04 10:57:18'),
(173, 4, 33, 250, 'Bakerganj', 'বাকেরগঞ্জ', 1283, 1, 1, 1, '2021-06-04 10:57:55', '2021-06-04 10:57:55'),
(174, 1, 8, 78, 'Raozan', 'রাউজান', 1284, 1, 1, 1, '2021-06-04 10:58:15', '2021-06-04 10:58:15'),
(175, 1, 8, 65, 'Rangunia', 'রাঙ্গুনিয়া', 1285, 1, 1, 1, '2021-06-04 10:59:23', '2021-06-04 10:59:23'),
(176, 4, 33, 256, 'Mehendiganj', 'মেহেন্দিগঞ্জ', 1286, 1, 1, 1, '2021-06-04 10:59:41', '2021-06-04 10:59:41'),
(177, 4, 33, 253, ' Banaripara', 'বানারীপাড়া', 1287, 1, 1, 1, '2021-06-04 11:00:33', '2021-06-04 11:00:33'),
(178, 1, 8, 70, 'Banshkhali', 'বাঁশখালী', 1288, 1, 1, 1, '2021-06-04 11:00:43', '2021-06-04 11:00:43'),
(179, 4, 33, 252, 'Wazirpur', 'উজিরপুর', 1289, 1, 1, 1, '2021-06-04 11:01:17', '2021-06-04 11:01:17'),
(180, 1, 8, 74, 'Satkania', 'সাতকানিয়া', 1290, 1, 1, 1, '2021-06-04 11:01:52', '2021-06-04 11:01:52'),
(181, 4, 34, 259, 'Bhola', 'ভোলা', 1291, 1, 1, 1, '2021-06-04 11:03:56', '2021-06-04 11:03:56'),
(182, 4, 34, 265, 'Lalmohan', 'লালমোহন', 1292, 1, 1, 1, '2021-06-04 11:04:35', '2021-06-04 11:04:35'),
(183, 4, 34, 261, ' Char Fasson', 'চর ফ্যাসন', 1293, 1, 1, 1, '2021-06-04 11:06:00', '2021-06-04 11:06:00'),
(184, 4, 34, 260, ' Burhanuddin', 'বোরহানউদ্দিন', 1294, 1, 1, 1, '2021-06-04 11:07:19', '2021-06-04 11:07:19'),
(185, 4, 34, 262, 'Daulatkhan', 'দৌলতখান', 1295, 1, 1, 1, '2021-06-04 11:08:01', '2021-06-04 11:08:01'),
(186, 1, 8, 73, 'Chandanaish ', 'চন্দনাইশ', 1296, 1, 1, 1, '2021-06-04 11:08:45', '2021-06-04 11:08:45'),
(187, 1, 8, 77, 'Fatikchhari', 'ফটিকছড়ি', 1297, 1, 1, 1, '2021-06-04 11:10:18', '2021-06-04 11:10:18'),
(188, 1, 8, 76, 'Hathazari', 'হাটহাজারী', 1298, 1, 1, 1, '2021-06-04 11:12:06', '2021-06-04 11:12:06'),
(189, 4, 30, 230, 'Jhalokati', 'ঝালকাঠি', 1299, 1, 1, 1, '2021-06-04 11:14:12', '2021-06-04 11:14:12'),
(190, 4, 30, 232, 'Nalchity', 'নলছিটি', 1300, 1, 1, 1, '2021-06-04 11:15:08', '2021-06-04 11:15:08'),
(191, 4, 32, 242, 'Pirojpur', 'পিরোজপুর', 1301, 1, 1, 1, '2021-06-04 11:16:17', '2021-06-04 11:16:17'),
(192, 4, 32, 247, 'Mathbaria', 'মঠবাড়িয়া', 1302, 1, 1, 1, '2021-06-04 11:20:48', '2021-06-04 11:20:48'),
(193, 4, 32, 246, 'Bhandaria', 'ভান্ডারিয়া', 1303, 1, 1, 1, '2021-06-04 11:21:30', '2021-06-04 11:21:30'),
(194, 4, 35, 267, 'Barguna', 'বরগুনা', 1304, 1, 1, 1, '2021-06-04 11:22:09', '2021-06-04 11:22:09'),
(195, 4, 35, 270, 'Pathorghata', 'পাথরঘাটা', 1305, 1, 1, 1, '2021-06-04 11:22:56', '2021-06-04 11:22:56'),
(196, 4, 35, 266, 'Amtali ', 'আমতলী', 1306, 1, 1, 1, '2021-06-04 11:23:49', '2021-06-04 11:23:49'),
(197, 4, 35, 268, 'Betagi', 'বেতাগী', 1307, 1, 1, 1, '2021-06-04 11:24:20', '2021-06-04 11:24:20'),
(198, 1, 8, 492, 'Baroiyahat', 'বারোইয়াহাট', 1308, 1, 1, 1, '2021-06-04 11:30:24', '2021-06-04 11:30:24'),
(199, 4, 31, 235, 'Patuakhali', 'পটুয়াখালী', 1309, 1, 1, 1, '2021-06-04 11:31:50', '2021-06-04 11:31:50'),
(200, 1, 8, 493, 'Nazirhat', 'নাজিরহাট', 1310, 1, 1, 1, '2021-06-04 11:31:57', '2021-06-04 11:31:57'),
(201, 4, 31, 240, 'Galachipa', 'গলাচিপা', 1311, 1, 1, 1, '2021-06-04 11:32:38', '2021-06-04 11:32:38'),
(202, 4, 31, 234, 'Bauphal', 'বাউফল', 1312, 1, 1, 1, '2021-06-04 11:33:39', '2021-06-04 11:33:39'),
(203, 1, 8, 69, 'Sandwip', 'সন্দ্বীপ', 1313, 1, 1, 1, '2021-06-04 11:33:55', '2021-06-04 11:33:55'),
(204, 4, 31, 238, 'Kolapara', 'কলাপাড়া', 1314, 1, 1, 1, '2021-06-04 11:34:52', '2021-06-04 11:34:52'),
(205, 1, 8, 71, 'Boalkhali', 'বোয়ালখালী', 1315, 1, 1, 1, '2021-06-04 11:35:28', '2021-06-04 11:35:28'),
(206, 1, 9, 80, 'Coxsbazar Sadar', 'কক্সবাজার সদর', 1316, 1, 1, 1, '2021-06-04 11:37:37', '2021-06-04 11:37:37'),
(207, 1, 9, 81, 'Chakaria', 'চকরিয়া', 1317, 1, 1, 1, '2021-06-04 11:40:36', '2021-06-04 11:40:36'),
(208, 1, 9, 84, 'Moheshkhali', 'মহেশখালী', 1318, 1, 1, 1, '2021-06-04 11:41:46', '2021-06-04 11:41:46'),
(209, 1, 9, 87, 'Teknaf', 'টেকনাফ', 1319, 1, 1, 1, '2021-06-04 11:42:41', '2021-06-04 11:42:41'),
(210, 1, 11, 97, 'Bandarban Sadar ', 'বান্দরবান সদর', 1320, 1, 1, 1, '2021-06-04 11:44:24', '2021-06-04 11:44:24'),
(211, 1, 11, 101, 'Lama', 'লামা', 1321, 1, 1, 1, '2021-06-04 11:45:15', '2021-06-04 11:45:15'),
(212, 7, 54, 412, 'Dinajpur', 'দিনাজপুর', 1322, 1, 1, 1, '2021-06-04 11:51:28', '2021-06-04 11:51:28'),
(213, 1, 10, 88, 'Khagrachhari Sadar ', 'খাগড়াছড়ি সদর', 1323, 1, 1, 1, '2021-06-04 11:52:05', '2021-06-04 11:52:05'),
(214, 7, 54, 407, 'Birampur', 'বিরামপুর', 1324, 1, 1, 1, '2021-06-04 11:52:18', '2021-06-04 11:52:18'),
(215, 7, 54, 405, 'Birganj', 'বীরগঞ্জ', 1325, 1, 1, 1, '2021-06-04 11:53:12', '2021-06-04 11:53:12'),
(216, 1, 10, 94, 'Ramgrah ', 'রামগড়', 1326, 1, 1, 1, '2021-06-04 11:53:38', '2021-06-04 11:53:38'),
(217, 1, 10, 95, 'Matiranga ', 'মাটিরাঙ্গা', 1327, 1, 1, 1, '2021-06-04 11:54:56', '2021-06-04 11:54:56'),
(218, 7, 54, 411, 'Fulbari', 'ফুলবাড়ি', 1328, 1, 1, 1, '2021-06-04 11:55:50', '2021-06-04 11:55:50'),
(219, 7, 54, 408, 'Parbatipur', 'পার্বতীপুর', 1329, 1, 1, 1, '2021-06-04 11:56:37', '2021-06-04 11:56:37'),
(220, 7, 54, 413, 'Hakimpur', 'হাকিমপুর', 1330, 1, 1, 1, '2021-06-04 11:57:10', '2021-06-04 11:57:10'),
(221, 1, 4, 33, 'Rangamati Sadar ', 'রাঙামাটি সদর', 1331, 1, 1, 1, '2021-06-04 11:57:14', '2021-06-04 11:57:14'),
(222, 7, 54, 406, 'Ghoraghat', 'ঘোড়াঘাট', 1332, 1, 1, 1, '2021-06-04 11:57:40', '2021-06-04 11:57:40'),
(223, 7, 54, 415, 'Birol', 'বিরল', 1333, 1, 1, 1, '2021-06-04 11:58:16', '2021-06-04 11:58:16'),
(224, 1, 4, 36, 'Baghaichari ', 'বাঘাইছড়ি', 1334, 1, 1, 1, '2021-06-04 11:58:55', '2021-06-04 11:58:55'),
(225, 7, 53, 399, 'Panchagarh', 'পঞ্চগড়', 1335, 1, 1, 1, '2021-06-04 11:59:00', '2021-06-04 11:59:00'),
(226, 7, 53, 401, 'Boda', 'বোদা', 1336, 1, 1, 1, '2021-06-04 11:59:44', '2021-06-04 11:59:44'),
(227, 7, 58, 435, 'Thakurgaon', 'ঠাকুরগাঁও', 1337, 1, 1, 1, '2021-06-04 12:00:18', '2021-06-04 12:00:18'),
(228, 1, 3, 24, 'Brahmanbaria Sadar ', 'ব্রাহ্মণবাড়িয়া সদর', 1338, 1, 1, 1, '2021-06-04 12:00:55', '2021-06-04 12:00:55'),
(229, 7, 58, 436, 'Pirganj', 'পীরগঞ্জ', 1339, 1, 1, 1, '2021-06-04 12:01:11', '2021-06-04 12:01:11'),
(230, 1, 3, 30, 'Nabinagar ', 'নবীনগর', 1340, 1, 1, 1, '2021-06-04 12:01:53', '2021-06-04 12:01:53'),
(231, 7, 58, 437, ' Ranishankail', 'রানীশংকৈল', 1341, 1, 1, 1, '2021-06-04 12:02:32', '2021-06-04 12:02:32'),
(232, 1, 3, 29, 'Akhaura ', 'আখাউড়া', 1342, 1, 1, 1, '2021-06-04 12:02:45', '2021-06-04 12:02:45'),
(233, 7, 57, 429, 'Gaibandha', 'গাইবান্ধা', 1343, 1, 1, 1, '2021-06-04 12:03:24', '2021-06-04 12:03:24'),
(234, 1, 3, 25, 'Kasba ', 'কসবা', 1344, 1, 1, 1, '2021-06-04 12:03:39', '2021-06-04 12:03:39'),
(235, 7, 57, 432, 'Gobindaganj ', 'গোবিন্দগঞ্জ', 1345, 1, 1, 1, '2021-06-04 12:03:51', '2021-06-04 12:03:51'),
(236, 7, 57, 433, 'Sundarganj', 'সুন্দরগঞ্জ', 1346, 1, 1, 1, '2021-06-04 12:04:32', '2021-06-04 12:04:32'),
(237, 7, 57, 430, 'Palashbari', 'পলাশবাড়ী', 1347, 1, 1, 1, '2021-06-04 12:05:11', '2021-06-04 12:05:11'),
(238, 1, 6, 55, 'Chandpur Sadar ', 'চাঁদপুর সদর', 1348, 1, 1, 1, '2021-06-04 12:06:12', '2021-06-04 12:06:12'),
(239, 7, 60, 448, 'Kurigram', 'কুড়িগ্রাম', 1349, 1, 1, 1, '2021-06-04 12:06:18', '2021-06-04 12:06:18'),
(240, 7, 60, 449, 'Nageshwari', 'নাগেশ্বরী', 1350, 1, 1, 1, '2021-06-04 12:07:03', '2021-06-04 12:07:03'),
(241, 7, 60, 453, 'Ulipur', 'উলিপুর', 1351, 1, 1, 1, '2021-06-04 12:07:34', '2021-06-04 12:07:34'),
(242, 1, 6, 57, 'Hajiganj ', 'হাজীগঞ্জ', 1352, 1, 1, 1, '2021-06-04 12:07:39', '2021-06-04 12:07:39'),
(243, 1, 6, 53, 'Kachua ', 'কচুয়া', 1353, 1, 1, 1, '2021-06-04 12:08:33', '2021-06-04 12:08:33'),
(244, 7, 55, 417, 'Lalmonirhat', 'লালমনিরহাট', 1354, 1, 1, 1, '2021-06-04 12:11:15', '2021-06-04 12:11:15'),
(245, 1, 6, 495, 'Chengaracara', 'চেঙ্গারচারা', 1355, 1, 1, 1, '2021-06-04 12:11:50', '2021-06-04 12:11:50'),
(246, 7, 55, 420, 'Patgram', 'পাটগ্রাম', 1356, 1, 1, 1, '2021-06-04 12:12:40', '2021-06-04 12:12:40'),
(247, 1, 6, 58, 'Matlab North ', 'মতলব উত্তর', 1357, 1, 1, 1, '2021-06-04 12:13:17', '2021-06-04 12:13:17'),
(248, 7, 56, 427, 'Nilphamari', 'নীলফামারী', 1358, 1, 1, 1, '2021-06-04 12:13:35', '2021-06-04 12:13:35'),
(249, 7, 56, 422, ' Saidpur', 'সৈয়দপুর', 1359, 1, 1, 1, '2021-06-04 12:14:35', '2021-06-04 12:14:35'),
(250, 7, 56, 423, 'Domar', 'ডোমার', 1360, 1, 1, 1, '2021-06-04 12:15:54', '2021-06-04 12:15:54'),
(251, 7, 56, 425, 'Jaldhaka', 'জলঢাকা', 1361, 1, 1, 1, '2021-06-04 12:16:30', '2021-06-04 12:16:30'),
(252, 1, 6, 56, 'Matlab South ', 'মতলব দক্ষিণ', 1362, 1, 1, 1, '2021-06-04 12:16:49', '2021-06-04 12:16:49'),
(253, 7, 59, 443, 'Badarganj', 'বদরগঞ্জ', 1363, 1, 1, 1, '2021-06-04 12:19:31', '2021-06-04 12:19:31'),
(254, 1, 6, 54, 'Shahrasti', 'শাহরাস্তি', 1364, 1, 1, 1, '2021-06-04 12:23:18', '2021-06-04 12:23:18'),
(255, 1, 6, 59, 'Faridgonj', 'ফরিদগঞ্জ', 1365, 1, 1, 1, '2021-06-04 12:24:47', '2021-06-04 12:24:47'),
(256, 1, 1, 8, 'Laksam', 'লাকসাম', 1366, 1, 1, 1, '2021-06-04 12:31:09', '2021-06-04 12:31:09'),
(257, 1, 1, 6, 'Daudkandi ', 'দাউদকান্দি', 1367, 1, 1, 1, '2021-06-04 12:33:04', '2021-06-04 12:33:04'),
(258, 1, 1, 4, 'Chandina ', 'চান্দিনা', 1368, 1, 1, 1, '2021-06-04 12:35:23', '2021-06-04 12:35:23'),
(259, 1, 1, 7, 'Homna ', 'হোমনা', 1369, 1, 1, 1, '2021-06-04 12:36:15', '2021-06-04 12:36:15'),
(260, 1, 1, 1, ' Debidwar', 'দেবিদ্বার', 1370, 1, 1, 1, '2021-06-04 12:38:09', '2021-06-04 12:38:09'),
(261, 1, 1, 5, 'Chauddagram ', 'চৌদ্দগ্রাম', 1371, 1, 1, 1, '2021-06-04 12:40:09', '2021-06-04 12:40:09'),
(262, 1, 1, 10, 'Nangalkot', 'নাঙ্গলকোট', 1372, 1, 1, 1, '2021-06-04 12:41:25', '2021-06-04 12:41:25'),
(263, 1, 1, 2, 'Barura', 'বড়ুরা', 1373, 1, 1, 1, '2021-06-04 12:42:19', '2021-06-04 12:42:19'),
(264, 1, 2, 19, 'Feni Sadar ', 'ফেনী সদর', 1374, 1, 1, 1, '2021-06-04 12:43:44', '2021-06-04 12:43:44'),
(265, 1, 2, 23, ' Daganbhuiyan', 'দাগনভূইয়ান', 1375, 1, 1, 1, '2021-06-04 12:46:08', '2021-06-04 12:46:08'),
(266, 1, 2, 18, 'Chhagalnaiya ', 'ছাগলনাইয়া', 1376, 1, 1, 1, '2021-06-04 12:47:20', '2021-06-04 12:47:20'),
(267, 6, 44, 342, 'Tangail', 'টাঙ্গাইল', 1377, 1, 1, 1, '2021-06-04 12:47:50', '2021-06-04 12:47:50'),
(268, 1, 2, 22, ' Parshuram', 'পরশুরাম', 1378, 1, 1, 1, '2021-06-04 12:50:35', '2021-06-04 12:50:35'),
(269, 1, 2, 20, 'Sonagazi', 'সোনাগাজী', 1379, 1, 1, 1, '2021-06-04 12:51:29', '2021-06-04 12:51:29'),
(270, 1, 7, 60, 'Lakshmipur Sadar ', 'লক্ষ্মীপুর সদর', 1380, 1, 1, 1, '2021-06-04 12:53:02', '2021-06-04 12:53:02'),
(271, 1, 7, 62, 'Raipur ', 'রায়পুর', 1381, 1, 1, 1, '2021-06-04 12:54:19', '2021-06-04 12:54:19'),
(272, 1, 7, 64, 'Ramganj ', 'Ramganj ', 1382, 1, 1, 1, '2021-06-04 12:55:19', '2021-06-04 12:55:19'),
(273, 1, 7, 63, 'Ramgati', 'রামগতি', 1383, 1, 1, 1, '2021-06-04 12:56:38', '2021-06-04 12:56:38'),
(274, 1, 5, 43, 'Noakhali Sadar ', 'নোয়াখালী সদর', 1384, 1, 1, 1, '2021-06-04 12:58:47', '2021-06-04 12:58:47'),
(275, 1, 5, 496, ' Chowmuhani ', 'চৌমুহনী', 1385, 1, 1, 1, '2021-06-04 13:02:18', '2021-06-04 13:02:18'),
(276, 6, 44, 334, 'Bhuapur', 'ভূঞাপুর', 1386, 1, 1, 1, '2021-06-04 13:07:57', '2021-06-04 13:07:57'),
(277, 6, 44, 336, 'Ghatail', 'ঘাটাইল', 1387, 1, 1, 1, '2021-06-04 13:10:23', '2021-06-04 13:10:23'),
(278, 1, 5, 50, 'Chatkhil ', 'চাটখিল', 1388, 1, 1, 1, '2021-06-04 13:10:30', '2021-06-04 13:10:30'),
(279, 6, 44, 338, 'Madhupur', 'মধুপুর', 1389, 1, 1, 1, '2021-06-04 13:11:50', '2021-06-04 13:11:50'),
(280, 6, 44, 339, 'Mirzapur', 'মির্জাপুর', 1390, 1, 1, 1, '2021-06-04 13:19:31', '2021-06-04 13:19:31'),
(281, 6, 44, 344, 'Dhanbari', 'ধনবাড়ী', 1391, 1, 1, 1, '2021-06-04 13:21:21', '2021-06-04 13:21:21'),
(282, 6, 44, 343, 'Kalihati', 'কালিহাতী', 1392, 1, 1, 1, '2021-06-04 13:22:55', '2021-06-04 13:22:55'),
(283, 6, 44, 341, 'Sakhipur', 'সখিপুর', 1393, 1, 1, 1, '2021-06-04 13:24:16', '2021-06-04 13:24:16'),
(284, 6, 44, 333, 'Basail', 'বাসাইল', 1394, 1, 1, 1, '2021-06-04 13:30:54', '2021-06-04 13:30:54'),
(285, 1, 5, 497, 'Bashurhat', 'বসুরহাট', 1395, 1, 1, 1, '2021-06-04 13:58:48', '2021-06-04 13:58:48'),
(286, 1, 5, 48, 'Kabirhat ', 'কবিরহাট', 1396, 1, 1, 1, '2021-06-04 13:59:44', '2021-06-04 13:59:44'),
(287, 1, 5, 51, 'Sonaimari', 'সোনাইমারি', 1397, 1, 1, 1, '2021-06-04 14:01:24', '2021-06-04 14:01:24'),
(288, 1, 5, 49, 'Senbug', 'সেনবাগ', 1398, 1, 1, 1, '2021-06-04 14:02:54', '2021-06-04 14:02:54'),
(289, 1, 5, 46, 'Hatia', 'হাতিয়া', 1399, 1, 1, 1, '2021-06-04 14:04:06', '2021-06-04 14:04:06'),
(290, 7, 54, 409, 'Setabganj', 'সেতাবগঞ্জ', 1400, 1, 1, 1, '2021-06-04 15:10:13', '2021-06-04 15:10:13'),
(291, 7, 59, 446, 'Haragachh', 'হারাগাছ', 1401, 1, 1, 1, '2021-06-04 15:15:24', '2021-06-04 15:15:24'),
(292, 6, 43, 331, 'Tarabo', 'তারাবো', 1402, 1, 1, 1, '2021-06-04 16:20:05', '2021-06-04 16:20:05'),
(293, 6, 43, 331, 'Kanchan', 'কাঞ্চন', 1403, 1, 1, 1, '2021-06-04 16:23:04', '2021-06-04 16:23:04'),
(294, 6, 43, 328, 'Gopaladi', 'গোপালাদী', 1404, 1, 1, 1, '2021-06-04 16:26:57', '2021-06-04 16:26:57'),
(295, 4, 31, 238, 'Kuakata', 'কুয়াকাটা', 1405, 1, 1, 1, '2021-06-04 16:29:35', '2021-06-04 16:29:35'),
(296, 5, 38, 498, 'Shaistaganj ', 'শায়েস্তাগঞ্জ', 1406, 1, 1, 1, '2021-06-04 16:30:39', '2021-06-04 16:30:39'),
(297, 5, 39, 303, ' Chattak ', 'চাটক', 1407, 1, 1, 1, '2021-06-04 16:33:23', '2021-06-04 16:33:23'),
(298, 5, 39, 310, ' Derai', 'দেড়ই', 1408, 1, 1, 1, '2021-06-04 16:34:40', '2021-06-04 16:34:40'),
(299, 4, 32, 248, 'Swarupakathi', 'স্বরূপকাঠি', 1409, 1, 1, 1, '2021-06-04 16:47:37', '2021-06-04 16:47:37'),
(300, 2, 14, 123, 'Bogra Sadar ', 'বগুড়া সদর', 1410, 1, 1, 1, '2021-06-04 16:49:13', '2021-06-04 16:49:13'),
(301, 6, 44, 343, 'Elenga', 'এলেঙ্গা', 1411, 1, 1, 1, '2021-06-04 16:50:07', '2021-06-04 16:50:07'),
(302, 6, 40, 314, 'Ghorashal', 'ঘোড়াশাল', 1412, 1, 1, 1, '2021-06-04 16:52:44', '2021-06-04 16:52:44'),
(303, 2, 14, 499, 'Mahal', 'মহল', 1413, 1, 1, 1, '2021-06-04 16:53:52', '2021-06-04 16:53:52'),
(304, 2, 14, 500, 'Santahar', 'সান্তাহার', 1414, 1, 1, 1, '2021-06-04 17:00:08', '2021-06-04 17:00:08'),
(305, 2, 14, 132, ' Sherpur', 'শেরপুর', 1415, 1, 1, 1, '2021-06-04 17:03:24', '2021-06-04 17:03:24'),
(306, 2, 14, 501, 'Talora', 'তালোড়া', 1416, 1, 1, 1, '2021-06-04 17:09:02', '2021-06-04 17:09:02'),
(307, 2, 17, 153, ' Panchbibi', 'পাঁচবিবি', 1417, 1, 1, 1, '2021-06-04 17:12:39', '2021-06-04 17:12:39'),
(308, 2, 17, 152, ' Khetlal', 'ক্ষেতলাল', 1418, 1, 1, 1, '2021-06-04 17:14:26', '2021-06-04 17:14:26'),
(309, 2, 13, 117, ' Bera ', 'বেরা', 1419, 1, 1, 1, '2021-06-04 17:17:46', '2021-06-05 11:14:20'),
(310, 2, 12, 502, 'Ullahpara', 'উল্লাহপাড়া', 1420, 1, 1, 1, '2021-06-04 17:21:54', '2021-06-05 11:14:54'),
(311, 6, 40, 313, 'Madhabdi', 'মাধবদী', 1421, 1, 1, 1, '2021-06-04 17:23:02', '2021-06-04 17:23:02'),
(312, 2, 19, 162, 'Nazipur', 'নাজিপুর', 1422, 1, 1, 1, '2021-06-04 17:35:44', '2021-06-05 12:22:23'),
(313, 2, 16, 143, 'Natore Sadar', 'নাটোর সদর', 1423, 1, 1, 1, '2021-06-05 11:17:40', '2021-06-05 11:17:40'),
(314, 2, 15, 140, 'Kakanahata', 'কাকানাহাটা', 1424, 1, 1, 1, '2021-06-05 12:05:28', '2021-06-05 12:05:28'),
(315, 2, 15, 136, 'Keshorhat', 'কেশরহাট ', 1425, 1, 1, 1, '2021-06-05 12:11:58', '2021-06-05 12:11:58'),
(316, 2, 15, 142, 'Bhabaniganj', 'ভবানীগঞ্জ ', 1426, 1, 1, 1, '2021-06-05 12:14:29', '2021-06-05 12:14:29'),
(317, 2, 15, 142, 'Taherpur', 'তাহেরপুর ', 1427, 1, 1, 1, '2021-06-05 12:15:38', '2021-06-05 12:15:38'),
(318, 2, 15, 141, 'Mundumala', 'মুন্ডুমালা ', 1428, 1, 1, 1, '2021-06-05 12:16:48', '2021-06-05 12:16:48'),
(319, 2, 15, 134, 'Naohata', 'নওহাটা', 1429, 1, 1, 1, '2021-06-05 12:18:47', '2021-06-05 12:18:47'),
(320, 6, 47, 367, 'Keraniganj', 'কেরানীগঞ্জ', 1430, 1, 1, 1, '2021-11-15 02:44:45', '2021-11-15 02:44:45');

-- --------------------------------------------------------

--
-- Table structure for table `master_payment_services`
--

CREATE TABLE `master_payment_services` (
  `id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `master_services`
--

CREATE TABLE `master_services` (
  `id` bigint UNSIGNED NOT NULL,
  `service_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `module_id` bigint UNSIGNED DEFAULT NULL,
  `sorting_order` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_services`
--

INSERT INTO `master_services` (`id`, `service_name`, `service_name_bn`, `component_id`, `module_id`, `sorting_order`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Test Service aa', 'Test Service Bn', 1, 5, 1, NULL, NULL, 1, '2022-06-19 07:29:46', '2022-06-19 07:29:46'),
(2, 'Policy Request & Approval ', 'পলিসি অনুরোধ এবং অনুমোদন', 6, 20, 1, NULL, NULL, 1, '2022-07-19 03:42:51', '2022-07-19 04:43:39'),
(3, 'Program Management', 'প্রোগ্রাম ব্যবস্থাপনা', 6, 21, 1, NULL, NULL, 1, '2022-07-19 04:00:25', '2022-08-28 05:03:22'),
(4, 'Survey Management', 'জরিপ ব্যবস্থাপনা', 6, 21, 3, NULL, NULL, 1, '2022-07-19 04:01:01', '2022-07-19 04:01:01'),
(5, 'Meeting Management', 'সভা ব্যবস্থাপনা', 6, 21, 4, NULL, NULL, 1, '2022-07-19 04:01:26', '2022-07-19 04:01:26'),
(6, 'Research Plan Preparation', 'গবেষণা পরিকল্পনা প্রস্তুতি', 6, 19, 5, NULL, NULL, 1, '2022-07-19 04:01:53', '2022-07-19 04:01:53'),
(7, 'Action Plan', 'কর্ম পরিকল্পনা', 6, 19, 2, NULL, NULL, 1, '2022-07-25 06:59:48', '2022-07-25 06:59:48'),
(8, 'Contract Signing', 'চুক্তি স্বাক্ষর', 6, 19, 3, NULL, NULL, 1, '2022-07-25 07:00:22', '2022-07-25 07:00:31'),
(9, 'Research/Others Document', 'গবেষণা/অনন্য ডকুমেন্ট', 6, 23, 1, NULL, NULL, 1, '2022-07-28 02:51:57', '2022-10-11 12:02:58'),
(10, 'Activity Audit', 'কার্যকলাপ নিরীক্ষণ', 6, 23, 2, NULL, NULL, 1, '2022-08-10 10:20:35', '2022-08-10 10:20:50'),
(11, 'Process Workflow Management', 'প্রসেস ওয়ার্কফ্লো ম্যানেজমেন্ট', 7, 26, 1, NULL, NULL, 1, '2022-08-23 03:34:48', '2022-08-23 03:34:48'),
(12, 'TCB Configuration', 'টিসিবি কনফিগারেশন', 7, 26, 2, NULL, NULL, 1, '2022-08-23 03:41:25', '2022-08-23 03:41:25'),
(13, 'Dealership License (TCB)', 'ডিলারশীপ লাইসেন্স (টিসিবি)', 7, 34, 2, NULL, NULL, 1, '2022-08-23 03:43:33', '2022-09-21 03:23:21'),
(14, 'Store Management', 'গুদাম ব্যবস্থাপনা', 7, 28, 2, NULL, NULL, 1, '2022-08-23 04:14:43', '2022-09-21 08:42:28'),
(15, 'Allocation Management', 'বরাদ্দ ব্যবস্থাপনা', 7, 28, 3, NULL, NULL, 1, '2022-08-23 04:15:29', '2022-09-21 04:37:45'),
(16, 'Manage Information', 'তথ্য ব্যবস্থাপনা', 7, 28, 1, NULL, NULL, 1, '2022-08-23 04:16:14', '2022-09-12 03:21:30'),
(18, 'Report Management', 'প্রতিবেদন ব্যবস্থাপনা', 6, 21, 5, NULL, NULL, 1, '2022-08-28 05:02:39', '2022-08-28 05:02:39'),
(19, 'Small Tea Farmer Registration & Renew', 'ক্ষুদ্র চা চাষী নিবন্ধন এবং নবায়ন', 5, 40, 1, NULL, NULL, 1, '2022-10-19 02:45:59', '2022-12-05 06:02:52'),
(20, 'Configuration', 'কনফিগারেশন', 9, 44, 1, NULL, NULL, 1, '2022-11-07 03:58:28', '2022-11-07 03:58:28'),
(21, 'Trade Fair Info Management', 'বাণিজ্য মেলা তথ্য ব্যবস্থাপনা', 9, 44, 2, NULL, NULL, 1, '2022-11-10 06:04:48', '2023-01-29 06:23:45'),
(22, 'Tree Disposal NOC', 'গাছ কর্তনের অনুমতি', 5, 40, 2, NULL, NULL, 1, '2022-11-13 08:58:54', '2022-11-23 05:42:52'),
(23, 'Tea Garden Application & Renew', 'চা বাগানের আবেদন ও নবায়ন', 5, 40, 3, NULL, NULL, 1, '2022-12-01 08:08:52', '2022-12-05 06:02:40'),
(24, 'Tea Factory Application & Renew', 'চা কারখানার আবেদন ও নবায়ন', 5, 40, 4, NULL, NULL, 1, '2022-12-01 08:09:58', '2022-12-05 06:02:06'),
(25, 'Entity Statistics', 'এনটিটি পরিসংখ্যান', 11, 50, 1, NULL, NULL, 1, '2023-01-10 04:51:00', '2023-01-10 04:51:00'),
(26, 'Fair Proposal Management', 'মেলার প্রস্তাব ব্যবস্থাপনা', 9, 44, 3, NULL, NULL, 1, '2023-01-12 06:01:34', '2023-01-12 06:01:34'),
(27, 'Fair Participation Circular Management', 'মেলা অংশগ্রহণ সার্কুলার ব্যবস্থাপনা', 9, 44, 4, NULL, NULL, 1, '2023-01-12 06:02:29', '2023-01-12 06:02:29'),
(28, 'Fair Participation Management', 'মেলা অংশগ্রহণ ব্যবস্থাপনা', 9, 44, 5, NULL, NULL, 1, '2023-01-12 06:03:15', '2023-01-12 06:03:15'),
(29, 'Exhibition Info Management', 'প্রদর্শনীর তথ্য ব্যবস্থাপনা', 9, 44, 6, NULL, NULL, 1, '2023-01-29 06:25:02', '2023-01-29 06:25:02'),
(30, 'Report', 'প্রতিবেদন', 9, 44, 7, NULL, NULL, 1, '2023-01-29 06:25:30', '2023-01-29 06:25:30'),
(31, 'Professional Course Management', 'প্রফেশনাল কোর্স ম্যানেজমেন্ট', 5, 55, 4, NULL, NULL, 1, '2023-02-15 08:45:17', '2023-02-15 08:56:04'),
(32, 'Circular Management', 'সার্কুলার ম্যানেজমেন্ট', 5, 55, 3, NULL, NULL, 1, '2023-02-15 08:45:42', '2023-02-15 08:55:07');

-- --------------------------------------------------------

--
-- Table structure for table `master_thanas`
--

CREATE TABLE `master_thanas` (
  `id` bigint UNSIGNED NOT NULL,
  `thana_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thana_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` bigint UNSIGNED NOT NULL,
  `thana_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_thanas`
--

INSERT INTO `master_thanas` (`id`, `thana_name`, `thana_name_bn`, `district_id`, `thana_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'brahmanpara', 'ব্রাহ্মণপাড়া', 1, 4444, NULL, 1, 1, '2023-02-13 08:29:50', '2023-02-13 08:32:16'),
(2, 'Adabor Thana', 'আদাবর থানা', 47, 4445, NULL, NULL, 1, '2023-02-13 10:08:08', '2023-02-13 10:08:08'),
(8, 'Ramna', 'রমনা', 47, 1, NULL, NULL, 1, '2023-02-13 11:19:25', '2023-02-13 11:19:25'),
(17, 'Badda', 'বাড্ডা', 47, 2, NULL, 1, 1, '2023-02-13 11:27:32', '2023-02-13 11:28:10'),
(18, 'Hatirjheel', 'হাতিরঝিল', 47, 3, NULL, 1, 1, '2023-02-13 11:28:34', '2023-02-13 11:29:18'),
(19, 'Uttora Thana', 'উত্তরা থানা', 47, 4, NULL, NULL, 1, '2023-02-13 11:55:09', '2023-02-13 11:55:09'),
(20, 'Khilkhet police station', 'খিলক্ষেত থানা', 47, 5, NULL, NULL, 1, '2023-02-13 12:01:20', '2023-02-13 12:01:20'),
(21, 'Kafrul police station', 'কাফরুল থানা', 47, 6, NULL, NULL, 1, '2023-02-13 12:01:52', '2023-02-13 12:01:52'),
(22, 'Dhanmondi police station', 'ধানমন্ডি থানা', 47, 7, NULL, 1, 1, '2023-02-13 12:02:23', '2023-02-14 02:55:10'),
(23, 'Mohammadpur police station', 'মোহাম্মদপুর থানা', 47, 8, NULL, NULL, 1, '2023-02-13 12:02:54', '2023-02-13 12:02:54'),
(24, 'Sutrapur police station', 'সূত্রাপুর থানা', 47, 9, NULL, NULL, 1, '2023-02-13 12:04:55', '2023-02-13 12:04:55'),
(25, 'Jatrabari police station', 'যাত্রাবাড়ী থানা', 47, 10, NULL, NULL, 1, '2023-02-13 12:05:19', '2023-02-13 12:05:19'),
(26, 'Airport police station', 'বিমানবন্দর থানা', 47, 11, NULL, NULL, 1, '2023-02-13 12:05:43', '2023-02-13 12:05:43'),
(27, 'Gulshan police station', 'গুলশান থানা', 47, 12, NULL, NULL, 1, '2023-02-13 12:06:07', '2023-02-13 12:06:07'),
(28, 'Uttara West Police Station', 'উত্তারা পশ্চিম থানা', 47, 13, NULL, NULL, 1, '2023-02-13 12:06:35', '2023-02-13 12:06:35'),
(29, 'Mugda police station', 'মুগদা থানা', 47, 14, NULL, NULL, 1, '2023-02-13 12:07:02', '2023-02-13 12:07:02'),
(30, 'Rupnagar police station', 'রূপনগর থানা', 47, 15, NULL, NULL, 1, '2023-02-13 12:09:47', '2023-02-13 12:09:47'),
(31, 'Bhashantek police station', 'ভাষানটেক থানা', 47, 16, NULL, NULL, 1, '2023-02-13 12:10:10', '2023-02-13 12:10:10'),
(32, 'Bhatara police station', 'ভাটারা থানা', 47, 17, NULL, NULL, 1, '2023-02-13 12:10:35', '2023-02-13 12:10:35'),
(33, 'Banani police station', 'বনানী থানা', 47, 18, NULL, NULL, 1, '2023-02-13 12:13:04', '2023-02-13 12:13:04'),
(34, 'Wari police station', 'ওয়ারী থানা', 47, 19, NULL, NULL, 1, '2023-02-13 12:13:35', '2023-02-13 12:13:35'),
(35, 'Shahjahanpur police station', 'শাহজাহানপুর থানা', 47, 20, NULL, NULL, 1, '2023-02-13 12:13:56', '2023-02-13 12:13:56'),
(36, 'Sherbangla Nagar Police Station', 'শেরেবাংলা নগর থানা', 47, 21, NULL, NULL, 1, '2023-02-13 12:14:14', '2023-02-13 12:14:14'),
(37, 'Mirpur Model Police Station', 'মিরপুর মডেল থানা', 47, 22, NULL, NULL, 1, '2023-02-13 12:14:44', '2023-02-13 12:14:44'),
(38, 'Darus Salam police station', 'দারুস সালাম থানা', 47, 23, NULL, NULL, 1, '2023-02-13 12:15:12', '2023-02-13 12:15:12'),
(39, 'Dakshinkhan police station', 'দক্ষিণখান থানা', 47, 24, NULL, NULL, 1, '2023-02-13 12:15:33', '2023-02-13 12:15:33'),
(40, 'Uttarkhan police station', 'উত্তরখান থানা', 47, 25, NULL, NULL, 1, '2023-02-13 12:16:21', '2023-02-13 12:16:21'),
(41, 'Turag police station', 'তুরাগ থানা', 47, 26, NULL, NULL, 1, '2023-02-13 12:16:47', '2023-02-13 12:16:47'),
(42, 'Cantonment police station', 'ক্যান্টনমেন্ট থানা', 47, 27, NULL, NULL, 1, '2023-02-13 12:17:09', '2023-02-13 12:17:09'),
(43, 'Pallavi police station', 'পল্লবী থানা', 47, 28, NULL, NULL, 1, '2023-02-13 12:18:15', '2023-02-13 12:18:15'),
(44, 'Shahali police station', 'শাহআলী থানা', 47, 29, NULL, NULL, 1, '2023-02-13 12:18:50', '2023-02-13 12:18:50'),
(45, 'Tejangao Industrial Police Station', 'তেজঁগাও শিল্পাঞ্চল থানা', 47, 30, NULL, NULL, 1, '2023-02-13 12:19:23', '2023-02-13 12:19:23'),
(46, 'Tejgaon Police Station', 'তেজঁগাও থানা', 47, 31, NULL, NULL, 1, '2023-02-13 12:19:54', '2023-02-13 12:19:54'),
(47, 'Rampura Police Station', 'রামপুরা থানা', 47, 32, NULL, NULL, 1, '2023-02-13 12:20:14', '2023-02-13 12:20:14'),
(48, 'Sabuj Bagh Police Station', 'সবুজবাগ থানা', 47, 33, NULL, NULL, 1, '2023-02-13 12:20:51', '2023-02-13 12:20:51'),
(49, 'Kadmatoli police station', 'কদমতলী থানা', 47, 34, NULL, NULL, 1, '2023-02-13 12:21:15', '2023-02-13 12:21:15'),
(50, 'Chawkbazar police station', 'চকবাজার থানা', 47, 35, NULL, NULL, 1, '2023-02-13 12:21:36', '2023-02-13 12:21:36'),
(51, 'Kamrangirchar police station', 'কামরাঙ্গীরচর থানা', 47, 36, NULL, NULL, 1, '2023-02-13 12:21:59', '2023-02-13 12:21:59'),
(52, 'Kotyali police station', 'কোতয়ালী থানা', 47, 37, NULL, NULL, 1, '2023-02-13 12:22:22', '2023-02-13 12:22:22'),
(53, 'Lalbagh police station', 'লালবাগ থানা', 47, 38, NULL, NULL, 1, '2023-02-13 12:22:47', '2023-02-13 12:22:47'),
(54, 'Kalabagan police station', 'কলাবাগান থানা', 47, 39, NULL, NULL, 1, '2023-02-13 12:23:14', '2023-02-13 12:23:14'),
(55, 'Shahbag police station', 'শাহবাগ থানা', 47, 40, NULL, NULL, 1, '2023-02-13 12:23:38', '2023-02-13 12:23:38'),
(56, 'Motijheel police station', 'মতিঝিল থানা', 47, 41, NULL, NULL, 1, '2023-02-13 12:24:00', '2023-02-13 12:24:00'),
(57, 'Khilgaon police station', 'খিলগাঁও থানা', 47, 42, NULL, NULL, 1, '2023-02-13 12:24:21', '2023-02-13 12:24:21'),
(58, 'Hazaribagh police station', 'হাজারীবাগ থানা', 47, 43, NULL, NULL, 1, '2023-02-13 12:24:47', '2023-02-13 12:24:47'),
(59, 'Demra police station', 'ডেমরা থানা', 47, 44, NULL, NULL, 1, '2023-02-13 12:25:24', '2023-02-13 12:25:24'),
(60, 'Paltan Model Police Station', 'পল্টন মডেল থানা', 47, 45, NULL, NULL, 1, '2023-02-13 12:25:48', '2023-02-13 12:25:48'),
(61, 'Banshal police station', 'বংশাল থানা', 47, 46, NULL, NULL, 1, '2023-02-13 12:26:25', '2023-02-13 12:26:25'),
(62, 'Newmarket police station', 'নিউমার্কেট থানা', 47, 47, NULL, NULL, 1, '2023-02-13 12:26:57', '2023-02-13 12:26:57'),
(63, 'Shyampur police station', 'শ্যামপুর থানা', 47, 48, NULL, NULL, 1, '2023-02-13 12:27:22', '2023-02-13 12:27:22'),
(64, 'Gendaria police station1', 'গেন্ডারিয়া থানা', 47, 49, NULL, 1, 1, '2023-02-13 12:27:42', '2023-02-14 05:56:58');

-- --------------------------------------------------------

--
-- Table structure for table `master_unions`
--

CREATE TABLE `master_unions` (
  `id` bigint UNSIGNED NOT NULL,
  `union_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `union_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `division_id` bigint UNSIGNED DEFAULT NULL,
  `district_id` bigint UNSIGNED DEFAULT NULL,
  `upazila_id` bigint UNSIGNED DEFAULT NULL,
  `union_code` int UNSIGNED DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_unions`
--

INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Subil', 'সুবিল', 1, 1, 1, 8888, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:18'),
(2, 'North Gunaighor', 'উত্তর গুনাইঘর', 1, 1, 1, 8889, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:19'),
(3, 'South Gunaighor', 'দক্ষিণ গুনাইঘর', 1, 1, 1, 8890, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:21'),
(4, 'Boroshalghor', 'বড়শালঘর', 1, 1, 1, 8891, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:23'),
(5, 'Rajameher', 'রাজামেহার', 1, 1, 1, 8892, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:25'),
(6, 'Yousufpur', 'ইউসুফপুর', 1, 1, 1, 8893, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:26'),
(7, 'Rasulpur', 'রসুলপুর', 1, 1, 1, 8894, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:28'),
(8, 'Fatehabad', 'ফতেহাবাদ', 1, 1, 1, 8895, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:29'),
(9, 'Elahabad', 'এলাহাবাদ', 1, 1, 1, 8896, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:31'),
(10, 'Jafargonj', 'জাফরগঞ্জ', 1, 1, 1, 8897, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:32'),
(11, 'Dhampti', 'ধামতী', 1, 1, 1, 8898, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:34'),
(12, 'Mohanpur', 'মোহনপুর', 1, 1, 1, 8899, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:36'),
(13, 'Vani', 'ভানী', 1, 1, 1, 8900, 1, 1, 1, '2021-02-13 15:17:03', '2023-02-22 02:22:37'),
(14, 'Barkamta', 'বরকামতা', 1, 1, 1, 8901, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:39'),
(15, 'Sultanpur', 'সুলতানপুর', 1, 1, 1, 8902, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:40'),
(16, 'Aganagar', 'আগানগর', 1, 1, 2, 8903, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:42'),
(17, 'Bhabanipur', 'ভবানীপুর', 1, 1, 2, 8904, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:43'),
(18, 'North Khoshbas', 'উত্তর খোশবাস', 1, 1, 2, 8905, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:45'),
(19, 'South Khoshbas', 'দক্ষিন খোশবাস', 1, 1, 2, 8906, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:47'),
(20, 'Jhalam', 'ঝলম', 1, 1, 2, 8907, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:48'),
(21, 'Chitodda', 'চিতড্ডা', 1, 1, 2, 8908, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:50'),
(22, 'North Shilmuri', 'উত্তর শিলমুড়ি', 1, 1, 2, 8909, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:51'),
(23, 'South Shilmuri', 'দক্ষিন শিলমুড়ি', 1, 1, 2, 8910, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:53'),
(24, 'Galimpur', 'গালিমপুর', 1, 1, 2, 8911, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:54'),
(25, 'Shakpur', 'শাকপুর', 1, 1, 2, 8912, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:56'),
(26, 'Bhaukshar', 'ভাউকসার', 1, 1, 2, 8913, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:57'),
(27, 'Adda', 'আড্ডা', 1, 1, 2, 8914, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:22:59'),
(28, 'Adra', 'আদ্রা', 1, 1, 2, 8915, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:00'),
(29, 'Payalgacha', 'পয়ালগাছা', 1, 1, 2, 8916, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:02'),
(30, 'Laxmipur', 'লক্ষীপুর', 1, 1, 2, 8917, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:04'),
(31, 'Shidli', 'শিদলাই', 1, 1, 3, 8918, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:06'),
(32, 'Chandla', 'চান্দলা', 1, 1, 3, 8919, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:07'),
(33, 'Shashidal', 'শশীদল', 1, 1, 3, 8920, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:09'),
(34, 'Dulalpur', 'দুলালপুর', 1, 1, 3, 8921, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:10'),
(35, 'Brahmanpara Sadar', 'ব্রাহ্মনপাড়া সদর', 1, 1, 3, 8922, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:12'),
(36, 'Shahebabad', 'সাহেবাবাদ', 1, 1, 3, 8923, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:13'),
(37, 'Malapara', 'মালাপাড়া', 1, 1, 3, 8924, 1, 1, 1, '2021-02-13 15:17:04', '2023-02-22 02:23:15'),
(38, 'Madhabpur', 'মাধবপুর', 1, 1, 3, 8925, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:16'),
(39, 'Shuhilpur', 'সুহিলপুর', 1, 1, 4, 8926, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:18'),
(40, 'Bataghashi', 'বাতাঘাসি', 1, 1, 4, 8927, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:19'),
(41, 'Joag', 'জোয়াগ', 1, 1, 4, 8928, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:21'),
(42, 'Borcarai', 'বরকরই', 1, 1, 4, 8929, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:23'),
(43, 'Madhaiya', 'মাধাইয়া', 1, 1, 4, 8930, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:25'),
(44, 'Dollai Nowabpur', 'দোল্লাই নবাবপুর', 1, 1, 4, 8931, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:28'),
(45, 'Mohichial', 'মহিচাইল', 1, 1, 4, 8932, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:30'),
(46, 'Gollai', 'গল্লাই', 1, 1, 4, 8933, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:31'),
(47, 'Keronkhal', 'কেরণখাল', 1, 1, 4, 8934, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:33'),
(48, 'Maijkhar', 'মাইজখার', 1, 1, 4, 8935, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:35'),
(49, 'Etberpur', 'এতবারপুর', 1, 1, 4, 8936, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:36'),
(50, 'Barera', 'বাড়েরা', 1, 1, 4, 8937, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:38'),
(51, 'Borcoit', 'বরকইট', 1, 1, 4, 8938, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:39'),
(52, 'Sreepur', 'শ্রীপুর', 1, 1, 5, 8939, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:41'),
(53, 'Kashinagar', 'কাশিনগর', 1, 1, 5, 8940, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:42'),
(54, 'Kalikapur', 'কালিকাপুর', 1, 1, 5, 8941, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:44'),
(55, 'Shuvapur', 'শুভপুর', 1, 1, 5, 8942, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:45'),
(56, 'Ghulpasha', 'ঘোলপাশা', 1, 1, 5, 8943, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:47'),
(57, 'Moonshirhat', 'মুন্সীরহাট', 1, 1, 5, 8944, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:48'),
(58, 'Batisha', 'বাতিসা', 1, 1, 5, 8945, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:50'),
(59, 'Kankapait', 'কনকাপৈত', 1, 1, 5, 8946, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:51'),
(60, 'Cheora', 'চিওড়া', 1, 1, 5, 8947, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:53'),
(61, 'Jagannatdighi', 'জগন্নাথদিঘী', 1, 1, 5, 8948, 1, 1, 1, '2021-02-13 15:17:05', '2023-02-22 02:23:55'),
(62, 'Goonabati', 'গুনবতী', 1, 1, 5, 8949, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:23:56'),
(63, 'Alkara', 'আলকরা', 1, 1, 5, 8950, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:23:58'),
(64, 'Doulotpur', 'দৌলতপুর', 1, 1, 6, 8951, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:23:59'),
(65, 'Daudkandi', 'দাউদকান্দি', 1, 1, 6, 8952, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:01'),
(66, 'North Eliotgonj', 'উত্তর ইলিয়টগঞ্জ', 1, 1, 6, 8953, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:02'),
(67, 'South Eliotgonj', 'দক্ষিন ইলিয়টগঞ্জ', 1, 1, 6, 8954, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:04'),
(68, 'Zinglatoli', 'জিংলাতলী', 1, 1, 6, 8955, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:05'),
(69, 'Sundolpur', 'সুন্দলপুর', 1, 1, 6, 8956, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:07'),
(70, 'Gouripur', 'গৌরীপুর', 1, 1, 6, 8957, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:08'),
(71, 'East Mohammadpur', 'পুর্ব মোহাম্মদপুর', 1, 1, 6, 8958, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:10'),
(72, 'West Mohammadpur', 'পশ্চিম মোহাম্মদপুর', 1, 1, 6, 8959, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:11'),
(73, 'Goalmari', 'গোয়ালমারী', 1, 1, 6, 8960, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:13'),
(74, 'Maruka', 'মারুকা', 1, 1, 6, 8961, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:15'),
(75, 'Betessor', 'বিটেশ্বর', 1, 1, 6, 8962, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:16'),
(76, 'Podua', 'পদুয়া', 1, 1, 6, 8963, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:18'),
(77, 'West Passgacia', 'পশ্চিম পাচঁগাছিয়া', 1, 1, 6, 8964, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:19'),
(78, 'Baropara', 'বারপাড়া', 1, 1, 6, 8965, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:21'),
(79, 'Mathabanga', 'মাথাভাঙ্গা', 1, 1, 7, 8966, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:22'),
(80, 'Gagutiea', 'ঘাগুটিয়া', 1, 1, 7, 8967, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:24'),
(81, 'Asadpur', 'আছাদপুর', 1, 1, 7, 8968, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:26'),
(82, 'Chanderchor', 'চান্দেরচর', 1, 1, 7, 8969, 1, 1, 1, '2021-02-13 15:17:06', '2023-02-22 02:24:28'),
(83, 'Vashania', 'ভাষানিয়া', 1, 1, 7, 8970, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:29'),
(84, 'Nilokhi', 'নিলখী', 1, 1, 7, 8971, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:31'),
(85, 'Garmora', 'ঘারমোড়া', 1, 1, 7, 8972, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:32'),
(86, 'Joypur', 'জয়পুর', 1, 1, 7, 8973, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:34'),
(87, 'Dulalpur', 'দুলালপুর', 1, 1, 7, 8974, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:36'),
(88, 'Bakoi', 'বাকই', 1, 1, 8, 8975, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:37'),
(89, 'Mudafargonj', 'মুদাফফর গঞ্জ', 1, 1, 8, 8976, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:39'),
(90, 'Kandirpar', 'কান্দিরপাড়', 1, 1, 8, 8977, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:40'),
(91, 'Gobindapur', 'গোবিন্দপুর', 1, 1, 8, 8978, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:42'),
(92, 'Uttarda', 'উত্তরদা', 1, 1, 8, 8979, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:44'),
(93, 'Laksam Purba', 'লাকসাম পুর্ব', 1, 1, 8, 8980, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:46'),
(94, 'Azgora', 'আজগরা', 1, 1, 8, 8981, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:47'),
(95, 'Sreekil', 'শ্রীকাইল', 1, 1, 9, 8982, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:49'),
(96, 'Akubpur', 'আকুবপুর', 1, 1, 9, 8983, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:50'),
(97, 'Andicot', 'আন্দিকোট', 1, 1, 9, 8984, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:52'),
(98, 'Purbadair (East)', 'পুর্বধৈইর (পুর্ব)', 1, 1, 9, 8985, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:54'),
(99, 'Purbadair (West)', 'পুর্বধৈইর (পশ্চিম)', 1, 1, 9, 8986, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:55'),
(100, 'Bangara (East)', 'বাঙ্গরা (পূর্ব)', 1, 1, 9, 8987, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:57'),
(101, 'Bangara (West)', 'বাঙ্গরা (পশ্চিম)', 1, 1, 9, 8988, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:24:58'),
(102, 'Chapitala', 'চাপিতলা', 1, 1, 9, 8989, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:25:00'),
(103, 'Camalla', 'কামাল্লা', 1, 1, 9, 8990, 1, 1, 1, '2021-02-13 15:17:07', '2023-02-22 02:25:01'),
(104, 'Jatrapur', 'যাত্রাপুর', 1, 1, 9, 8991, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:03'),
(105, 'Ramachandrapur (North)', 'রামচন্দ্রপুর (উত্তর)', 1, 1, 9, 8992, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:05'),
(106, 'Ramachandrapur (South)', 'রামচন্দ্রপুর (দক্ষিন)', 1, 1, 9, 8993, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:06'),
(107, 'Muradnagar Sadar', 'মুরাদনগর সদর', 1, 1, 9, 8994, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:08'),
(108, 'Nobipur (East)', 'নবীপুর (পুর্ব)', 1, 1, 9, 8995, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:09'),
(109, 'Nobipur (West)', 'নবীপুর (পশ্চিম)', 1, 1, 9, 8996, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:11'),
(110, 'Damgar', 'ধামঘর', 1, 1, 9, 8997, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:12'),
(111, 'Jahapur', 'জাহাপুর', 1, 1, 9, 8998, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:14'),
(112, 'Salikandi', 'ছালিয়াকান্দি', 1, 1, 9, 8999, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:15'),
(113, 'Darura', 'দারোরা', 1, 1, 9, 9000, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:17'),
(114, 'Paharpur', 'পাহাড়পুর', 1, 1, 9, 9001, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:19'),
(115, 'Babutipara', 'বাবুটিপাড়া', 1, 1, 9, 9002, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:20'),
(116, 'Tanki', 'টনকী', 1, 1, 9, 9003, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:22'),
(117, 'Bangadda', 'বাঙ্গড্ডা', 1, 1, 10, 9004, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:24'),
(118, 'Paria', 'পেরিয়া', 1, 1, 10, 9005, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:25'),
(119, 'Raykot', 'রায়কোট', 1, 1, 10, 9006, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:27'),
(120, 'Mokara', 'মোকরা', 1, 1, 10, 9007, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:28'),
(121, 'Makrabpur', 'মক্রবপুর', 1, 1, 10, 9008, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:31'),
(122, 'Heshakhal', 'হেসাখাল', 1, 1, 10, 9009, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:33'),
(123, 'Adra', 'আদ্রা', 1, 1, 10, 9010, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:35'),
(124, 'Judda', 'জোড্ডা', 1, 1, 10, 9011, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:37'),
(125, 'Dhalua', 'ঢালুয়া', 1, 1, 10, 9012, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:38'),
(126, 'Doulkha', 'দৌলখাঁড়', 1, 1, 10, 9013, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:40'),
(127, 'Boxgonj', 'বক্সগঞ্জ', 1, 1, 10, 9014, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:41'),
(128, 'Satbaria', 'সাতবাড়ীয়া', 1, 1, 10, 9015, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:43'),
(129, 'Kalirbazer', 'কালীর বাজার', 1, 1, 11, 9016, 1, 1, 1, '2021-02-13 15:17:08', '2023-02-22 02:25:45'),
(130, 'North Durgapur', 'উত্তর দুর্গাপুর', 1, 1, 11, 9017, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:46'),
(131, 'South Durgapur', 'দক্ষিন দুর্গাপুর', 1, 1, 11, 9018, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:48'),
(132, 'Amratoli', 'আমড়াতলী', 1, 1, 11, 9019, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:49'),
(133, 'Panchthubi', 'পাঁচথুবী', 1, 1, 11, 9020, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:51'),
(134, 'Jagannatpur', 'জগন্নাথপুর', 1, 1, 11, 9021, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:52'),
(135, 'Chandanpur', 'চন্দনপুর', 1, 1, 12, 9022, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:54'),
(136, 'Chalibanga', 'চালিভাঙ্গা', 1, 1, 12, 9023, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:55'),
(137, 'Radanagar', 'রাধানগর', 1, 1, 12, 9024, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:57'),
(138, 'Manikarchar', 'মানিকারচর', 1, 1, 12, 9025, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:25:58'),
(139, 'Barakanda', 'বড়কান্দা', 1, 1, 12, 9026, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:00'),
(140, 'Govindapur', 'গোবিন্দপুর', 1, 1, 12, 9027, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:01'),
(141, 'Luterchar', 'লুটেরচর', 1, 1, 12, 9028, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:03'),
(142, 'Vaorkhola', 'ভাওরখোলা', 1, 1, 12, 9029, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:05'),
(143, 'Baishgaon', 'বাইশগাঁও', 1, 1, 13, 9030, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:06'),
(144, 'Shoroshpur', 'সরসপুর', 1, 1, 13, 9031, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:08'),
(145, 'Hasnabad', 'হাসনাবাদ', 1, 1, 13, 9032, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:09'),
(146, 'Jholam (North)', 'ঝলম (উত্তর)', 1, 1, 13, 9033, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:11'),
(147, 'Jholam (South)', 'ঝলম (দক্ষিন)', 1, 1, 13, 9034, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:12'),
(148, 'Moishatua', 'মৈশাতুয়া', 1, 1, 13, 9035, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:14'),
(149, 'Lokkhanpur', 'লক্ষনপুর', 1, 1, 13, 9036, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:15'),
(150, 'Khela', 'খিলা', 1, 1, 13, 9037, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:17'),
(151, 'Uttarhowla', 'উত্তর হাওলা', 1, 1, 13, 9038, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:18'),
(152, 'Natherpetua', 'নাথেরপেটুয়া', 1, 1, 13, 9039, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:20'),
(153, 'Bipulashar', 'বিপুলাসার', 1, 1, 13, 9040, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:21'),
(154, 'Chuwara', 'চৌয়ারা', 1, 1, 14, 9041, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:23'),
(155, 'Baropara', 'বারপাড়া', 1, 1, 14, 9042, 1, 1, 1, '2021-02-13 15:17:09', '2023-02-22 02:26:24'),
(156, 'Jorkanoneast', 'জোড়কানন (পুর্ব)', 1, 1, 14, 9043, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:26'),
(157, 'Goliara', 'গলিয়ারা', 1, 1, 14, 9044, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:27'),
(158, 'Jorkanonwest', 'জোড়কানন (পশ্চিম)', 1, 1, 14, 9045, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:29'),
(159, 'Bagmara (North)', 'বাগমারা (উত্তর)', 1, 1, 14, 9046, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:30'),
(160, 'Bagmara (South)', 'বাগমারা (দক্ষিন)', 1, 1, 14, 9047, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:32'),
(161, 'Bhuloin (North)', 'ভূলইন (উত্তর)', 1, 1, 14, 9048, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:33'),
(162, 'Bhuloin (South)', 'ভূলইন (দক্ষিন)', 1, 1, 14, 9049, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:35'),
(163, 'Belgor (North)', 'বেলঘর (উত্তর)', 1, 1, 14, 9050, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:37'),
(164, 'Belgor (South)', 'বেলঘর (দক্ষিন)', 1, 1, 14, 9051, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:38'),
(165, 'Perul (North)', 'পেরুল (উত্তর)', 1, 1, 14, 9052, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:40'),
(166, 'Perul (South)', 'পেরুল (দক্ষিন)', 1, 1, 14, 9053, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:41'),
(167, 'Bijoypur', 'বিজয়পুর', 1, 1, 14, 9054, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:43'),
(168, 'Satani', 'সাতানী', 1, 1, 15, 9055, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:44'),
(169, 'Jagatpur', 'জগতপুর', 1, 1, 15, 9056, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:46'),
(170, 'Balorampur', 'বলরামপুর', 1, 1, 15, 9057, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:47'),
(171, 'Karikandi', 'কড়িকান্দি', 1, 1, 15, 9058, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:49'),
(172, 'Kalakandi', 'কলাকান্দি', 1, 1, 15, 9059, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:50'),
(173, 'Vitikandi', 'ভিটিকান্দি', 1, 1, 15, 9060, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:52'),
(174, 'Narayandia', 'নারান্দিয়া', 1, 1, 15, 9061, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:53'),
(175, 'Zearkandi', 'জিয়ারকান্দি', 1, 1, 15, 9062, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:55'),
(176, 'Majidpur', 'মজিদপুর', 1, 1, 15, 9063, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:56'),
(177, 'Moynamoti', 'ময়নামতি', 1, 1, 16, 9064, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:26:58'),
(178, 'Varella', 'ভারেল্লা', 1, 1, 16, 9065, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:27:00'),
(179, 'Mokam', 'মোকাম', 1, 1, 16, 9066, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:27:02'),
(180, 'Burichang Sadar', 'বুড়িচং সদর', 1, 1, 16, 9067, 1, 1, 1, '2021-02-13 15:17:10', '2023-02-22 02:27:04'),
(181, 'Bakshimul', 'বাকশীমূল', 1, 1, 16, 9068, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:05'),
(182, 'Pirjatrapur', 'পীরযাত্রাপুর', 1, 1, 16, 9069, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:07'),
(183, 'Sholonal', 'ষোলনল', 1, 1, 16, 9070, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:08'),
(184, 'Rajapur', 'রাজাপুর', 1, 1, 16, 9071, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:10'),
(185, 'Bagmara (North)', 'বাগমারা (উত্তর)', 1, 1, 17, 9072, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:11'),
(186, 'Bagmara (South)', 'বাগমারা (দক্ষিন)', 1, 1, 17, 9073, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:13'),
(187, 'Bhuloin (North)', 'ভূলইন (উত্তর)', 1, 1, 17, 9074, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:15'),
(188, 'Bhuloin (South)', 'ভূলইন (দক্ষিন)', 1, 1, 17, 9075, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:16'),
(189, 'Belgor (North)', 'বেলঘর (উত্তর)', 1, 1, 17, 9076, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:18'),
(190, 'Belgor (South)', 'বেলঘর (দক্ষিন)', 1, 1, 17, 9077, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:19'),
(191, 'Perul (North)', 'পেরুল (উত্তর)', 1, 1, 17, 9078, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:21'),
(192, 'Perul (South)', 'পেরুল (দক্ষিন)', 1, 1, 17, 9079, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:23'),
(193, 'Mohamaya', 'মহামায়া', 1, 2, 18, 9080, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:24'),
(194, 'Pathannagar', 'পাঠাননগর', 1, 2, 18, 9081, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:26'),
(195, 'Subhapur', 'শুভপুর', 1, 2, 18, 9082, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:27'),
(196, 'Radhanagar', 'রাধানগর', 1, 2, 18, 9083, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:29'),
(197, 'Gopal', 'ঘোপাল', 1, 2, 18, 9084, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:30'),
(198, 'Sarishadi', 'শর্শদি', 1, 2, 19, 9085, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:32'),
(199, 'Panchgachia', 'পাঁচগাছিয়া', 1, 2, 19, 9086, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:33'),
(200, 'Dhormapur', 'ধর্মপুর', 1, 2, 19, 9087, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:35'),
(201, 'Kazirbag', 'কাজিরবাগ', 1, 2, 19, 9088, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:36'),
(202, 'Kalidah', 'কালিদহ', 1, 2, 19, 9089, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:38'),
(203, 'Baligaon', 'বালিগাঁও', 1, 2, 19, 9090, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:39'),
(204, 'Dholia', 'ধলিয়া', 1, 2, 19, 9091, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:42'),
(205, 'Lemua', 'লেমুয়া', 1, 2, 19, 9092, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:44'),
(206, 'Chonua', 'ছনুয়া', 1, 2, 19, 9093, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:47'),
(207, 'Motobi', 'মোটবী', 1, 2, 19, 9094, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:49'),
(208, 'Fazilpur', 'ফাজিলপুর', 1, 2, 19, 9095, 1, 1, 1, '2021-02-13 15:17:11', '2023-02-22 02:27:52'),
(209, 'Forhadnogor', 'ফরহাদনগর', 1, 2, 19, 9096, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:27:54'),
(210, 'Charmozlishpur', 'চরমজলিশপুর', 1, 2, 20, 9097, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:27:56'),
(211, 'Bogadana', 'বগাদানা', 1, 2, 20, 9098, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:27:58'),
(212, 'Motigonj', 'মতিগঞ্জ', 1, 2, 20, 9099, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:00'),
(213, 'Mongolkandi', 'মঙ্গলকান্দি', 1, 2, 20, 9100, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:01'),
(214, 'Chardorbesh', 'চরদরবেশ', 1, 2, 20, 9101, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:04'),
(215, 'Chorchandia', 'চরচান্দিয়া', 1, 2, 20, 9102, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:05'),
(216, 'Sonagazi', 'সোনাগাজী', 1, 2, 20, 9103, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:07'),
(217, 'Amirabad', 'আমিরাবাদ', 1, 2, 20, 9104, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:09'),
(218, 'Nababpur', 'নবাবপুর', 1, 2, 20, 9105, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:11'),
(219, 'Fulgazi', 'ফুলগাজী', 1, 2, 21, 9106, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:12'),
(220, 'Munshirhat', 'মুন্সিরহাট', 1, 2, 21, 9107, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:14'),
(221, 'Dorbarpur', 'দরবারপুর', 1, 2, 21, 9108, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:15'),
(222, 'Anandopur', 'আনন্দপুর', 1, 2, 21, 9109, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:17'),
(223, 'Amzadhat', 'আমজাদহাট', 1, 2, 21, 9110, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:18'),
(224, 'Gmhat', 'জি,এম, হাট', 1, 2, 21, 9111, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:20'),
(225, 'Mizanagar', 'মির্জানগর', 1, 2, 22, 9112, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:22'),
(226, 'Ctholia', 'চিথলিয়া', 1, 2, 22, 9113, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:24'),
(227, 'Boxmahmmud', 'বক্সমাহমুদ', 1, 2, 22, 9114, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:25'),
(228, 'Sindurpur', 'সিন্দুরপুর', 1, 2, 23, 9115, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:27'),
(229, 'Rajapur', 'রাজাপুর', 1, 2, 23, 9116, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:30'),
(230, 'Purbachandrapur', 'পূর্বচন্দ্রপুর', 1, 2, 23, 9117, 1, 1, 1, '2021-02-13 15:17:12', '2023-02-22 02:28:32'),
(231, 'Ramnagar', 'রামনগর', 1, 2, 23, 9118, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:34'),
(232, 'Yeakubpur', 'ইয়াকুবপুর', 1, 2, 23, 9119, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:35'),
(233, 'Daganbhuiyan', 'দাগনভূঞা', 1, 2, 23, 9120, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:37'),
(234, 'Matubhuiyan', 'মাতুভূঞা', 1, 2, 23, 9121, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:39'),
(235, 'Jayloskor', 'জায়লস্কর', 1, 2, 23, 9122, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:41'),
(236, 'Basudeb', 'বাসুদেব', 1, 3, 24, 9123, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:43'),
(237, 'Machihata', 'মাছিহাতা', 1, 3, 24, 9124, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:45'),
(238, 'Sultanpur', 'সুলতানপুর', 1, 3, 24, 9125, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:47'),
(239, 'Ramrail', 'রামরাইল', 1, 3, 24, 9126, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:48'),
(240, 'Sadekpur', 'সাদেকপুর', 1, 3, 24, 9127, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:50'),
(241, 'Talsahar', 'তালশহর', 1, 3, 24, 9128, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:51'),
(242, 'Natai', 'নাটাই (দক্ষিন)', 1, 3, 24, 9129, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:53'),
(243, 'Natai', 'নাটাই (উত্তর)', 1, 3, 24, 9130, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:54'),
(244, 'Shuhilpur', 'সুহিলপুর', 1, 3, 24, 9131, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:56'),
(245, 'Bodhal', 'বুধল', 1, 3, 24, 9132, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:57'),
(246, 'Majlishpur', 'মজলিশপুর', 1, 3, 24, 9133, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:28:59'),
(247, 'Mulagram', 'মূলগ্রাম', 1, 3, 25, 9134, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:00'),
(248, 'Mehari', 'মেহারী', 1, 3, 25, 9135, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:02'),
(249, 'Badair', 'বাদৈর', 1, 3, 25, 9136, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:04'),
(250, 'Kharera', 'খাড়েরা', 1, 3, 25, 9137, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:05'),
(251, 'Benauty', 'বিনাউটি', 1, 3, 25, 9138, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:07'),
(252, 'Gopinathpur', 'গোপীনাথপুর', 1, 3, 25, 9139, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:09'),
(253, 'Kasbaw', 'কসবা', 1, 3, 25, 9140, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:11'),
(254, 'Kuti', 'কুটি', 1, 3, 25, 9141, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:13'),
(255, 'Kayempur', 'কাইমপুর', 1, 3, 25, 9142, 1, 1, 1, '2021-02-13 15:17:13', '2023-02-22 02:29:15'),
(256, 'Bayek', 'বায়েক', 1, 3, 25, 9143, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:18'),
(257, 'Chatalpar', 'চাতলপাড়', 1, 3, 26, 9144, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:19'),
(258, 'Bhalakut', 'ভলাকুট', 1, 3, 26, 9145, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:21'),
(259, 'Kunda', 'কুন্ডা', 1, 3, 26, 9146, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:22'),
(260, 'Goalnagar', 'গোয়ালনগর', 1, 3, 26, 9147, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:24'),
(261, 'Nasirnagar', 'নাসিরনগর', 1, 3, 26, 9148, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:25'),
(262, 'Burishwar', 'বুড়িশ্বর', 1, 3, 26, 9149, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:27'),
(263, 'Fandauk', 'ফান্দাউক', 1, 3, 26, 9150, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:29'),
(264, 'Goniauk', 'গুনিয়াউক', 1, 3, 26, 9151, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:31'),
(265, 'Chapartala', 'চাপৈরতলা', 1, 3, 26, 9152, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:32'),
(266, 'Dharnondol', 'ধরমন্ডল', 1, 3, 26, 9153, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:34'),
(267, 'Haripur', 'হরিপুর', 1, 3, 26, 9154, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:35'),
(268, 'Purbabhag', 'পূর্বভাগ', 1, 3, 26, 9155, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:37'),
(269, 'Gokarna', 'গোকর্ণ', 1, 3, 26, 9156, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:38'),
(270, 'Auraol', 'অরুয়াইল', 1, 3, 27, 9157, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:40'),
(271, 'Pakshimuul', 'পাকশিমুল', 1, 3, 27, 9158, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:41'),
(272, 'Chunta', 'চুন্টা', 1, 3, 27, 9159, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:43'),
(273, 'Kalikaccha', 'কালীকচ্ছ', 1, 3, 27, 9160, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:44'),
(274, 'Panishor', 'পানিশ্বর', 1, 3, 27, 9161, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:46'),
(275, 'Sarail', 'সরাইল সদর', 1, 3, 27, 9162, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:47'),
(276, 'Noagoun', 'নোয়াগাঁও', 1, 3, 27, 9163, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:49'),
(277, 'Shahajadapur', 'শাহজাদাপুর', 1, 3, 27, 9164, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:51'),
(278, 'Shahbazpur', 'শাহবাজপুর', 1, 3, 27, 9165, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:52'),
(279, 'Ashuganj', 'আশুগঞ্জ সদর', 1, 3, 28, 9166, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:54'),
(280, 'Charchartala', 'চরচারতলা', 1, 3, 28, 9167, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:55'),
(281, 'Durgapur', 'দুর্গাপুর', 1, 3, 28, 9168, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:57'),
(282, 'Araishidha', 'আড়াইসিধা', 1, 3, 28, 9169, 1, 1, 1, '2021-02-13 15:17:14', '2023-02-22 02:29:59'),
(283, 'Talshaharw', 'তালশহর(পঃ)', 1, 3, 28, 9170, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:01'),
(284, 'Sarifpur', 'শরীফপুর', 1, 3, 28, 9171, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:02'),
(285, 'Lalpur', 'লালপুর', 1, 3, 28, 9172, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:04'),
(286, 'Tarua', 'তারুয়া', 1, 3, 28, 9173, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:05'),
(287, 'Monionda', 'মনিয়ন্দ', 1, 3, 29, 9174, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:07'),
(288, 'Dharkhar', 'ধরখার', 1, 3, 29, 9175, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:08'),
(289, 'Mogra', 'মোগড়া', 1, 3, 29, 9176, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:10'),
(290, 'Akhauran', 'আখাউড়া (উঃ)', 1, 3, 29, 9177, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:11'),
(291, 'Akhauras', 'আখাউড়া (দঃ)', 1, 3, 29, 9178, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:13'),
(292, 'Barail', 'বড়াইল', 1, 3, 30, 9179, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:14'),
(293, 'Birgaon', 'বীরগাঁও', 1, 3, 30, 9180, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:16'),
(294, 'Krishnanagar', 'কৃষ্ণনগর', 1, 3, 30, 9181, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:17'),
(295, 'Nathghar', 'নাটঘর', 1, 3, 30, 9182, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:19'),
(296, 'Biddayakut', 'বিদ্যাকুট', 1, 3, 30, 9183, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:21'),
(297, 'Nabinagare', 'নবীনগর (পূর্ব)', 1, 3, 30, 9184, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:23'),
(298, 'Nabinagarw', 'নবীনগর(পশ্চিম)', 1, 3, 30, 9185, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:25'),
(299, 'Bitghar', 'বিটঘর', 1, 3, 30, 9186, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:27'),
(300, 'Shibpur', 'শিবপুর', 1, 3, 30, 9187, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:29'),
(301, 'Sreerampur', 'শ্রীরামপুর', 1, 3, 30, 9188, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:31'),
(302, 'Jinudpur', 'জিনোদপুর', 1, 3, 30, 9189, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:36'),
(303, 'Laurfatehpur', 'লাউরফতেপুর', 1, 3, 30, 9190, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:39'),
(304, 'Ibrahimpur', 'ইব্রাহিমপুর', 1, 3, 30, 9191, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:41'),
(305, 'Satmura', 'সাতমোড়া', 1, 3, 30, 9192, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:43'),
(306, 'Shamogram', 'শ্যামগ্রাম', 1, 3, 30, 9193, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:44'),
(307, 'Rasullabad', 'রসুল্লাবাদ', 1, 3, 30, 9194, 1, 1, 1, '2021-02-13 15:17:15', '2023-02-22 02:30:46'),
(308, 'Barikandi', 'বড়িকান্দি', 1, 3, 30, 9195, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:47'),
(309, 'Salimganj', 'ছলিমগঞ্জ', 1, 3, 30, 9196, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:49'),
(310, 'Ratanpur', 'রতনপুর', 1, 3, 30, 9197, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:50'),
(311, 'Kaitala (North)', 'কাইতলা (উত্তর)', 1, 3, 30, 9198, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:52'),
(312, 'Kaitala (South)', 'কাইতলা (দক্ষিন)', 1, 3, 30, 9199, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:53'),
(313, 'Tazkhali', 'তেজখালী', 1, 3, 31, 9200, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:55'),
(314, 'Pahariya Kandi', 'পাহাড়িয়া কান্দি', 1, 3, 31, 9201, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:56'),
(315, 'Dariadulat', 'দরিয়াদৌলত', 1, 3, 31, 9202, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:30:58'),
(316, 'Sonarampur', 'সোনারামপুর', 1, 3, 31, 9203, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:00'),
(317, 'Darikandi', 'দড়িকান্দি', 1, 3, 31, 9204, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:01'),
(318, 'Saifullyakandi', 'ছয়ফুল্লাকান্দি', 1, 3, 31, 9205, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:03'),
(319, 'Bancharampur', 'বাঞ্ছারামপুর', 1, 3, 31, 9206, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:04'),
(320, 'Ayabpur', 'আইয়ুবপুর', 1, 3, 31, 9207, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:06'),
(321, 'Fardabad', 'ফরদাবাদ', 1, 3, 31, 9208, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:07'),
(322, 'Rupushdi', 'রুপসদী পশ্চিম', 1, 3, 31, 9209, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:09'),
(323, 'Salimabad', 'ছলিমাবাদ', 1, 3, 31, 9210, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:11'),
(324, 'Ujanchar', 'উজানচর পূর্ব', 1, 3, 31, 9211, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:12'),
(325, 'Manikpur', 'মানিকপুর', 1, 3, 31, 9212, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:14'),
(326, 'Bhudanty', 'বুধন্তি', 1, 3, 32, 9213, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:15'),
(327, 'Chandura', 'চান্দুরা', 1, 3, 32, 9214, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:17'),
(328, 'Ichapura', 'ইছাপুরা', 1, 3, 32, 9215, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:18'),
(329, 'Champaknagar', 'চম্পকনগর', 1, 3, 32, 9216, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:20'),
(330, 'Harashpur', 'হরষপুর', 1, 3, 32, 9217, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:21'),
(331, 'Pattan', 'পত্তন', 1, 3, 32, 9218, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:23'),
(332, 'Singerbil', 'সিংগারবিল', 1, 3, 32, 9219, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:24'),
(333, 'Bishupor', 'বিষ্ণুপুর', 1, 3, 32, 9220, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:26'),
(334, 'Charislampur', 'চর-ইসলামপুর', 1, 3, 32, 9221, 1, 1, 1, '2021-02-13 15:17:16', '2023-02-22 02:31:27'),
(335, 'Paharpur', 'পাহাড়পুর', 1, 3, 32, 9222, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:29'),
(336, 'Jibtali', 'জীবতলি', 1, 4, 33, 9223, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:30'),
(337, 'Sapchari', 'সাপছড়ি', 1, 4, 33, 9224, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:32'),
(338, 'Kutukchari', 'কুতুকছড়ি', 1, 4, 33, 9225, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:33'),
(339, 'Bandukbhanga', 'বন্দুকভাঙ্গা', 1, 4, 33, 9226, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:35'),
(340, 'Balukhali', 'বালুখালী', 1, 4, 33, 9227, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:37'),
(341, 'Mogban', 'মগবান', 1, 4, 33, 9228, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:38'),
(342, 'Raikhali', 'রাইখালী', 1, 4, 34, 9229, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:40'),
(343, 'Kaptai', 'কাপ্তাই', 1, 4, 34, 9230, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:41'),
(344, 'Wagga', 'ওয়াজ্ঞা', 1, 4, 34, 9231, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:43'),
(345, 'Chandraghona', 'চন্দ্রঘোনা', 1, 4, 34, 9232, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:45'),
(346, 'Chitmorom', 'চিৎমরম', 1, 4, 34, 9233, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:46'),
(347, 'Ghagra', 'ঘাগড়া', 1, 4, 35, 9234, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:48'),
(348, 'Fatikchari', 'ফটিকছড়ি', 1, 4, 35, 9235, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:49'),
(349, 'Betbunia', 'বেতবুনিয়া', 1, 4, 35, 9236, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:51'),
(350, 'Kalampati', 'কলমপতি', 1, 4, 35, 9237, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:52'),
(351, 'Sajek', 'সাজেক', 1, 4, 36, 9238, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:54'),
(352, 'Amtali', 'আমতলী', 1, 4, 36, 9239, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:55'),
(353, 'Bongoltali', 'বঙ্গলতলী', 1, 4, 36, 9240, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:57'),
(354, 'Rupokari', 'রুপকারী', 1, 4, 36, 9241, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:31:58'),
(355, 'Marisha', 'মারিশ্যা', 1, 4, 36, 9242, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:32:00'),
(356, 'Khedarmara', 'খেদারমারা', 1, 4, 36, 9243, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:32:01'),
(357, 'Sharoyatali', 'সারোয়াতলী', 1, 4, 36, 9244, 1, 1, 1, '2021-02-13 15:17:17', '2023-02-22 02:32:03'),
(358, 'Baghaichari', 'বাঘাইছড়ি', 1, 4, 36, 9245, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:04'),
(359, 'Subalong', 'সুবলং', 1, 4, 37, 9246, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:06'),
(360, 'Barkal', 'বরকল', 1, 4, 37, 9247, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:08'),
(361, 'Bushanchara', 'ভূষনছড়া', 1, 4, 37, 9248, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:09'),
(362, 'Aimachara', 'আইমাছড়া', 1, 4, 37, 9249, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:11'),
(363, 'Borohorina', 'বড় হরিণা', 1, 4, 37, 9250, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:12'),
(364, 'Langad', 'লংগদু', 1, 4, 38, 9251, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:14'),
(365, 'Maeinimukh', 'মাইনীমুখ', 1, 4, 38, 9252, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:15'),
(366, 'Vasannadam', 'ভাসান্যাদম', 1, 4, 38, 9253, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:17'),
(367, 'Bogachattar', 'বগাচতর', 1, 4, 38, 9254, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:18'),
(368, 'Gulshakhali', 'গুলশাখালী', 1, 4, 38, 9255, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:20'),
(369, 'Kalapakujja', 'কালাপাকুজ্যা', 1, 4, 38, 9256, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:21'),
(370, 'Atarakchara', 'আটারকছড়া', 1, 4, 38, 9257, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:23'),
(371, 'Ghilachari', 'ঘিলাছড়ি', 1, 4, 39, 9258, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:24'),
(372, 'Gaindya', 'গাইন্দ্যা', 1, 4, 39, 9259, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:26'),
(373, 'Bangalhalia', 'বাঙ্গালহালিয়া', 1, 4, 39, 9260, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:27'),
(374, 'Kengrachari', 'কেংড়াছড়ি', 1, 4, 40, 9261, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:29'),
(375, 'Belaichari', 'বিলাইছড়ি', 1, 4, 40, 9262, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:30'),
(376, 'Farua', 'ফারুয়া', 1, 4, 40, 9263, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:32'),
(377, 'Juraichari', 'জুরাছড়ি', 1, 4, 41, 9264, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:33'),
(378, 'Banajogichara', 'বনযোগীছড়া', 1, 4, 41, 9265, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:35'),
(379, 'Moidong', 'মৈদং', 1, 4, 41, 9266, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:37'),
(380, 'Dumdumya', 'দুমদুম্যা', 1, 4, 41, 9267, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:38'),
(381, 'Sabekkhong', 'সাবেক্ষ্যং', 1, 4, 42, 9268, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:40'),
(382, 'Naniarchar', 'নানিয়ারচর', 1, 4, 42, 9269, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:41'),
(383, 'Burighat', 'বুড়িঘাট', 1, 4, 42, 9270, 1, 1, 1, '2021-02-13 15:17:18', '2023-02-22 02:32:43'),
(384, 'Ghilachhari', 'ঘিলাছড়ি', 1, 4, 42, 9271, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:44'),
(385, 'Charmatua', 'চরমটুয়া', 1, 5, 43, 9272, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:46'),
(386, 'Dadpur', 'দাদপুর', 1, 5, 43, 9273, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:47'),
(387, 'Noannoi', 'নোয়ান্নই', 1, 5, 43, 9274, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:49'),
(388, 'Kadirhanif', 'কাদির হানিফ', 1, 5, 43, 9275, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:51'),
(389, 'Binodpur', 'বিনোদপুর', 1, 5, 43, 9276, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:53'),
(390, 'Dharmapur', 'ধর্মপুর', 1, 5, 43, 9277, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:55'),
(391, 'Aujbalia', 'এওজবালিয়া', 1, 5, 43, 9278, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:56'),
(392, 'Kaladara', 'কালাদরপ', 1, 5, 43, 9279, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:58'),
(393, 'Ashwadia', 'অশ্বদিয়া', 1, 5, 43, 9280, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:32:59'),
(394, 'Newajpur', 'নিয়াজপুর', 1, 5, 43, 9281, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:01'),
(395, 'East Charmatua', 'পূর্ব চরমটুয়া', 1, 5, 43, 9282, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:03'),
(396, 'Andarchar', 'আন্ডারচর', 1, 5, 43, 9283, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:05'),
(397, 'Noakhali', 'নোয়াখালী', 1, 5, 43, 9284, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:06'),
(398, 'Sirajpur', 'সিরাজপুর', 1, 5, 44, 9285, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:08'),
(399, 'Charparboti', 'চরপার্বতী', 1, 5, 44, 9286, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:09'),
(400, 'Charhazari', 'চরহাজারী', 1, 5, 44, 9287, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:11'),
(401, 'Charkakra', 'চরকাঁকড়া', 1, 5, 44, 9288, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:12'),
(402, 'Charfakira', 'চরফকিরা', 1, 5, 44, 9289, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:14'),
(403, 'Musapur', 'মুসাপুর', 1, 5, 44, 9290, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:15'),
(404, 'Charelahi', 'চরএলাহী', 1, 5, 44, 9291, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:17'),
(405, 'Rampur', 'রামপুর', 1, 5, 44, 9292, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:18'),
(406, 'Amanullapur', 'আমানউল্ল্যাপুর', 1, 5, 45, 9293, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:20'),
(407, 'Gopalpur', 'গোপালপুর', 1, 5, 45, 9294, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:21'),
(408, 'Jirtali', 'জিরতলী', 1, 5, 45, 9295, 1, 1, 1, '2021-02-13 15:17:19', '2023-02-22 02:33:23'),
(409, 'Kutubpur', 'কুতবপুর', 1, 5, 45, 9296, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:24'),
(410, 'Alyearpur', 'আলাইয়ারপুর', 1, 5, 45, 9297, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:26'),
(411, 'Chayani', 'ছয়ানী', 1, 5, 45, 9298, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:27'),
(412, 'Rajganj', 'রাজগঞ্জ', 1, 5, 45, 9299, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:29'),
(413, 'Eklashpur', 'একলাশপুর', 1, 5, 45, 9300, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:31'),
(414, 'Begumganj', 'বেগমগঞ্জ', 1, 5, 45, 9301, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:32'),
(415, 'Mirwarishpur', 'মিরওয়ারিশপুর', 1, 5, 45, 9302, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:34'),
(416, 'Narottampur', 'নরোত্তমপুর', 1, 5, 45, 9303, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:35'),
(417, 'Durgapur', 'দূর্গাপুর', 1, 5, 45, 9304, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:37'),
(418, 'Rasulpur', 'রসুলপুর', 1, 5, 45, 9305, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:38'),
(419, 'Hajipur', 'হাজীপুর', 1, 5, 45, 9306, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:40'),
(420, 'Sharifpur', 'শরীফপুর', 1, 5, 45, 9307, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:41'),
(421, 'Kadirpur', 'কাদিরপুর', 1, 5, 45, 9308, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:43'),
(422, 'Sukhchar', 'সুখচর', 1, 5, 46, 9309, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:44'),
(423, 'Nolchira', 'নলচিরা', 1, 5, 46, 9310, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:46'),
(424, 'Charishwar', 'চরঈশ্বর', 1, 5, 46, 9311, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:47'),
(425, 'Charking', 'চরকিং', 1, 5, 46, 9312, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:49'),
(426, 'Tomoroddi', 'তমরদ্দি', 1, 5, 46, 9313, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:50'),
(427, 'Sonadiya', 'সোনাদিয়া', 1, 5, 46, 9314, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:52'),
(428, 'Burirchar', 'বুড়িরচর', 1, 5, 46, 9315, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:53'),
(429, 'Jahajmara', 'জাহাজমারা', 1, 5, 46, 9316, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:55'),
(430, 'Nijhumdwi', 'নিঝুমদ্বীপ', 1, 5, 46, 9317, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:57'),
(431, 'Charjabbar', 'চরজাব্বার', 1, 5, 47, 9318, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:33:58'),
(432, 'Charbata', 'চরবাটা', 1, 5, 47, 9319, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:00'),
(433, 'Charclerk', 'চরক্লার্ক', 1, 5, 47, 9320, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:01'),
(434, 'Charwapda', 'চরওয়াপদা', 1, 5, 47, 9321, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:03'),
(435, 'Charjubilee', 'চরজুবলী', 1, 5, 47, 9322, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:04'),
(436, 'Charaman Ullah', 'চরআমান উল্যা', 1, 5, 47, 9323, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:06'),
(437, 'East Charbata', 'পূর্ব চরবাটা', 1, 5, 47, 9324, 1, 1, 1, '2021-02-13 15:17:20', '2023-02-22 02:34:07'),
(438, 'Mohammadpur', 'মোহাম্মদপুর', 1, 5, 47, 9325, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:09'),
(439, 'Narottampur', 'নরোত্তমপুর', 1, 5, 48, 9326, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:10'),
(440, 'Dhanshiri', 'ধানসিঁড়ি', 1, 5, 48, 9327, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:12'),
(441, 'Sundalpur', 'সুন্দলপুর', 1, 5, 48, 9328, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:13'),
(442, 'Ghoshbag', 'ঘোষবাগ', 1, 5, 48, 9329, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:15'),
(443, 'Chaprashirhat', 'চাপরাশিরহাট', 1, 5, 48, 9330, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:16'),
(444, 'Dhanshalik', 'ধানশালিক', 1, 5, 48, 9331, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:18'),
(445, 'Batoiya', 'বাটইয়া', 1, 5, 48, 9332, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:19'),
(446, 'Chhatarpaia', 'ছাতারপাইয়া', 1, 5, 49, 9333, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:21'),
(447, 'Kesharpar', 'কেশরপাড়া', 1, 5, 49, 9334, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:22'),
(448, 'Dumurua', 'ডুমুরুয়া', 1, 5, 49, 9335, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:24'),
(449, 'Kadra', 'কাদরা', 1, 5, 49, 9336, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:27'),
(450, 'Arjuntala', 'অর্জুনতলা', 1, 5, 49, 9337, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:28'),
(451, 'Kabilpur', 'কাবিলপুর', 1, 5, 49, 9338, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:30'),
(452, 'Mohammadpur', 'মোহাম্মদপুর', 1, 5, 49, 9339, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:31'),
(453, 'Nabipur', 'নবীপুর', 1, 5, 49, 9340, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:33'),
(454, 'Bejbagh', 'বিজবাগ', 1, 5, 49, 9341, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:35'),
(455, 'Sahapur', 'সাহাপুর', 1, 5, 50, 9342, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:37'),
(456, 'Ramnarayanpur', 'রামনারায়নপুর', 1, 5, 50, 9343, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:38'),
(457, 'Porokote', 'পরকোট', 1, 5, 50, 9344, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:40'),
(458, 'Badalkot', 'বাদলকোট', 1, 5, 50, 9345, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:41'),
(459, 'Panchgaon', 'পাঁচগাঁও', 1, 5, 50, 9346, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:43'),
(460, 'Hat-Pukuria Ghatlabag', 'হাট-পুকুরিয়া ঘাটলাবাগ', 1, 5, 50, 9347, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:44'),
(461, 'Noakhala', 'নোয়াখলা', 1, 5, 50, 9348, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:46'),
(462, 'Khilpara', 'খিলপাড়া', 1, 5, 50, 9349, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:47'),
(463, 'Mohammadpur', 'মোহাম্মদপুর', 1, 5, 50, 9350, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:49'),
(464, 'Joyag', 'জয়াগ', 1, 5, 51, 9351, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:50'),
(465, 'Nodona', 'নদনা', 1, 5, 51, 9352, 1, 1, 1, '2021-02-13 15:17:21', '2023-02-22 02:34:52'),
(466, 'Chashirhat', 'চাষীরহাট', 1, 5, 51, 9353, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:34:54'),
(467, 'Barogaon', 'বারগাঁও', 1, 5, 51, 9354, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:34:55'),
(468, 'Ambarnagor', 'অম্বরনগর', 1, 5, 51, 9355, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:34:57'),
(469, 'Nateshwar', 'নাটেশ্বর', 1, 5, 51, 9356, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:34:58'),
(470, 'Bajra', 'বজরা', 1, 5, 51, 9357, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:00'),
(471, 'Sonapur', 'সোনাপুর', 1, 5, 51, 9358, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:02'),
(472, 'Deoti', 'দেওটি', 1, 5, 51, 9359, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:03'),
(473, 'Amishapara', 'আমিশাপাড়া', 1, 5, 51, 9360, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:05'),
(474, 'Gazipur', 'গাজীপুর', 1, 6, 52, 9361, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:06'),
(475, 'Algidurgapur (North)', 'আলগী দুর্গাপুর (উত্তর)', 1, 6, 52, 9362, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:08'),
(476, 'Algidurgapur (South)', 'আলগী দুর্গাপুর (দক্ষিণ)', 1, 6, 52, 9363, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:09'),
(477, 'Nilkamal', 'নীলকমল', 1, 6, 52, 9364, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:11'),
(478, 'Haimchar', 'হাইমচর', 1, 6, 52, 9365, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:12'),
(479, 'Charbhairabi', 'চরভৈরবী', 1, 6, 52, 9366, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:14'),
(480, 'Pathair', 'পাথৈর', 1, 6, 53, 9367, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:15'),
(481, 'Bitara', 'বিতারা', 1, 6, 53, 9368, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:17'),
(482, 'Shohodebpur (East)', 'সহদেবপুর (পূর্ব)', 1, 6, 53, 9369, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:18'),
(483, 'Shohodebpur (West)', 'সহদেবপুর (পশ্চিম)', 1, 6, 53, 9370, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:20'),
(484, 'Kachua (North)', 'কচুয়া (উত্তর)', 1, 6, 53, 9371, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:21'),
(485, 'Kachua (South)', 'কচুয়া (দক্ষিণ)', 1, 6, 53, 9372, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:23'),
(486, 'Gohat (North)', 'গোহাট (উত্তর)', 1, 6, 53, 9373, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:25'),
(487, 'Kadla', 'কাদলা', 1, 6, 53, 9374, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:26'),
(488, 'Ashrafpur', 'আসরাফপুর', 1, 6, 53, 9375, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:28'),
(489, 'Gohat (South)', 'গোহাট (দক্ষিণ)', 1, 6, 53, 9376, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:29'),
(490, 'Sachar', 'সাচার', 1, 6, 53, 9377, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:31');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(491, 'Koroia', 'কড়ইয়া', 1, 6, 53, 9378, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:32'),
(492, 'Tamta (South)', 'টামটা (দক্ষিণ)', 1, 6, 54, 9379, 1, 1, 1, '2021-02-13 15:17:22', '2023-02-22 02:35:34'),
(493, 'Tamta (North)', 'টামটা (উত্তর)', 1, 6, 54, 9380, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:35'),
(494, 'Meher (North)', 'মেহের (উত্তর)', 1, 6, 54, 9381, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:37'),
(495, 'Meher (South)', 'মেহের (দক্ষিণ)', 1, 6, 54, 9382, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:38'),
(496, 'Suchipara (North)', 'সুচিপাড়া (উত্তর)', 1, 6, 54, 9383, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:40'),
(497, 'Suchipara (South)', 'সুচিপাড়া (দক্ষিণ)', 1, 6, 54, 9384, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:42'),
(498, 'Chitoshi (East)', 'চিতষী (পূর্ব)', 1, 6, 54, 9385, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:43'),
(499, 'Raysree (South)', 'রায়শ্রী (দক্ষিন)', 1, 6, 54, 9386, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:45'),
(500, 'Raysree (North)', 'রায়শ্রী (উত্তর)', 1, 6, 54, 9387, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:46'),
(501, 'Chitoshiwest', 'চিতষী (পশ্চিম)', 1, 6, 54, 9388, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:48'),
(502, 'Bishnapur', 'বিষ্ণপুর', 1, 6, 55, 9389, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:49'),
(503, 'Ashikati', 'আশিকাটি', 1, 6, 55, 9390, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:51'),
(504, 'Shahmahmudpur', 'শাহ্‌ মাহমুদপুর', 1, 6, 55, 9391, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:52'),
(505, 'Kalyanpur', 'কল্যাণপুর', 1, 6, 55, 9392, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:54'),
(506, 'Rampur', 'রামপুর', 1, 6, 55, 9393, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:56'),
(507, 'Maishadi', 'মৈশাদী', 1, 6, 55, 9394, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:57'),
(508, 'Tarpurchandi', 'তরপুচন্ডী', 1, 6, 55, 9395, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:35:59'),
(509, 'Baghadi', 'বাগাদী', 1, 6, 55, 9396, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:00'),
(510, 'Laxmipur Model', 'লক্ষীপুর মডেল', 1, 6, 55, 9397, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:02'),
(511, 'Hanarchar', 'হানারচর', 1, 6, 55, 9398, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:03'),
(512, 'Chandra', 'চান্দ্রা', 1, 6, 55, 9399, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:05'),
(513, 'Rajrajeshwar', 'রাজরাজেশ্বর', 1, 6, 55, 9400, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:06'),
(514, 'Ibrahimpur', 'ইব্রাহীমপুর', 1, 6, 55, 9401, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:08'),
(515, 'Balia', 'বালিয়া', 1, 6, 55, 9402, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:09'),
(516, 'Nayergaon (North)', 'নায়েরগাঁও (উত্তর)', 1, 6, 56, 9403, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:11'),
(517, 'Nayergaon (South)', 'নায়েরগাঁও (দক্ষিন)', 1, 6, 56, 9404, 1, 1, 1, '2021-02-13 15:17:23', '2023-02-22 02:36:12'),
(518, 'Khadergaon', 'খাদেরগাঁও', 1, 6, 56, 9405, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:14'),
(519, 'Narayanpur', 'নারায়নপুর', 1, 6, 56, 9406, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:16'),
(520, 'Upadi (South)', 'উপাদী (দক্ষিণ)', 1, 6, 56, 9407, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:17'),
(521, 'Upadi (North)', 'উপাদী (উত্তর)', 1, 6, 56, 9408, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:19'),
(522, 'Rajargaon (North)', 'রাজারগাঁও (উত্তর)', 1, 6, 57, 9409, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:20'),
(523, 'Bakila', 'বাকিলা', 1, 6, 57, 9410, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:22'),
(524, 'Kalocho (North)', 'কালচোঁ (উত্তর)', 1, 6, 57, 9411, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:23'),
(525, 'Hajiganj Sadar', 'হাজীগঞ্জ সদর', 1, 6, 57, 9412, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:25'),
(526, 'Kalocho (South)', 'কালচোঁ (দক্ষিণ)', 1, 6, 57, 9413, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:26'),
(527, 'Barkul (East)', 'বড়কুল (পূর্ব)', 1, 6, 57, 9414, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:28'),
(528, 'Barkul (West)', 'বড়কুল (পশ্চিম)', 1, 6, 57, 9415, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:30'),
(529, 'Hatila (East)', 'হাটিলা (পূর্ব)', 1, 6, 57, 9416, 1, 1, 1, '2021-02-13 15:17:24', '2023-02-22 02:36:31'),
(530, 'Hatila (West)', 'হাটিলা (পশ্চিম)', 1, 6, 57, 9417, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:33'),
(531, 'Gandharbapur (North)', 'গন্ধর্ব্যপুর (উত্তর)', 1, 6, 57, 9418, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:34'),
(532, 'Gandharbapur (South)', 'গন্ধর্ব্যপুর (দক্ষিণ)', 1, 6, 57, 9419, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:36'),
(533, 'Satnal', 'ষাটনল', 1, 6, 58, 9420, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:37'),
(534, 'Banganbari', 'বাগানবাড়ী', 1, 6, 58, 9421, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:39'),
(535, 'Sadullapur', 'সাদুল্ল্যাপুর', 1, 6, 58, 9422, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:40'),
(536, 'Durgapur', 'দূর্গাপুর', 1, 6, 58, 9423, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:42'),
(537, 'Kalakanda', 'কালাকান্দা', 1, 6, 58, 9424, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:43'),
(538, 'Mohanpur', 'মোহনপুর', 1, 6, 58, 9425, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:45'),
(539, 'Eklaspur', 'এখলাছপুর', 1, 6, 58, 9426, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:46'),
(540, 'Jahirabad', 'জহিরাবাদ', 1, 6, 58, 9427, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:48'),
(541, 'Fatehpur (East)', 'ফতেহপুর (পূর্ব)', 1, 6, 58, 9428, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:49'),
(542, 'Fatehpur (West)', 'ফতেহপুর (পশ্চিম)', 1, 6, 58, 9429, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:51'),
(543, 'Farajikandi', 'ফরাজীকান্দি', 1, 6, 58, 9430, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:52'),
(544, 'Islamabad', 'ইসলামাবাদ', 1, 6, 58, 9431, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:54'),
(545, 'Sultanabad', 'সুলতানাবাদ', 1, 6, 58, 9432, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:56'),
(546, 'Gazra', 'গজরা', 1, 6, 58, 9433, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:57'),
(547, 'Balithuba (West)', 'বালিথুবা (পশ্চিম)', 1, 6, 59, 9434, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:36:59'),
(548, 'Balithuba (East)', 'বালিথুবা (পূর্ব)', 1, 6, 59, 9435, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:00'),
(549, 'Subidpur (East)', 'সুবিদপুর (পূর্ব)', 1, 6, 59, 9436, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:02'),
(550, 'Subidpur (West)', 'সুবিদপুর (পশ্চিম)', 1, 6, 59, 9437, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:03'),
(551, 'Gupti (West)', 'গুপ্তি (পশ্চিম)', 1, 6, 59, 9438, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:05'),
(552, 'Gupti (East)', 'গুপ্তি (পূর্ব)', 1, 6, 59, 9439, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:06'),
(553, 'Paikpara (North)', 'পাইকপাড়া (উত্তর)', 1, 6, 59, 9440, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:08'),
(554, 'Paikpara (South)', 'পাইকপাড়া (দক্ষিণ)', 1, 6, 59, 9441, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:09'),
(555, 'Gobindapur (North)', 'গবিন্দপুর (উত্তর)', 1, 6, 59, 9442, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:11'),
(556, 'Gobindapur (South)', 'গবিন্দপুর (দক্ষিণ)', 1, 6, 59, 9443, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:12'),
(557, 'Chardukhia (East)', 'চরদুখিয়া (পূর্ব)', 1, 6, 59, 9444, 1, 1, 1, '2021-02-13 15:17:25', '2023-02-22 02:37:14'),
(558, 'Chardukhia (West)', 'চরদুঃখিয়া (পশ্চিম)', 1, 6, 59, 9445, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:15'),
(559, 'Faridgonj (South)', 'ফরিদ্গঞ্জ (দক্ষিণ)', 1, 6, 59, 9446, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:17'),
(560, 'Rupsha (South)', 'রুপসা (দক্ষিণ)', 1, 6, 59, 9447, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:18'),
(561, 'Rupsha (North)', 'রুপসা (উত্তর)', 1, 6, 59, 9448, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:20'),
(562, 'Hamsadi (North)', 'হামছাদী (উত্তর)', 1, 7, 60, 9449, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:22'),
(563, 'Hamsadi (South)', 'হামছাদী (দক্ষিন)', 1, 7, 60, 9450, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:23'),
(564, 'Dalalbazar', 'দালাল বাজার', 1, 7, 60, 9451, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:25'),
(565, 'Charruhita', 'চররুহিতা', 1, 7, 60, 9452, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:26'),
(566, 'Parbotinagar', 'পার্বতীনগর', 1, 7, 60, 9453, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:28'),
(567, 'Bangakha', 'বাঙ্গাখাঁ', 1, 7, 60, 9454, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:30'),
(568, 'Dattapara', 'দত্তপাড়া', 1, 7, 60, 9455, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:32'),
(569, 'Basikpur', 'বশিকপুর', 1, 7, 60, 9456, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:33'),
(570, 'Chandrogonj', 'চন্দ্রগঞ্জ', 1, 7, 60, 9457, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:35'),
(571, 'Nourthjoypur', 'উত্তর জয়পুর', 1, 7, 60, 9458, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:36'),
(572, 'Hazirpara', 'হাজিরপাড়া', 1, 7, 60, 9459, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:38'),
(573, 'Charshahi', 'চরশাহী', 1, 7, 60, 9460, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:39'),
(574, 'Digli', 'দিঘলী', 1, 7, 60, 9461, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:41'),
(575, 'Laharkandi', 'লাহারকান্দি', 1, 7, 60, 9462, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:42'),
(576, 'Vobanigonj', 'ভবানীগঞ্জ', 1, 7, 60, 9463, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:44'),
(577, 'Kusakhali', 'কুশাখালী', 1, 7, 60, 9464, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:45'),
(578, 'Sakchor', 'শাকচর', 1, 7, 60, 9465, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:47'),
(579, 'Tearigonj', 'তেয়ারীগঞ্জ', 1, 7, 60, 9466, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:48'),
(580, 'Tumchor', 'টুমচর', 1, 7, 60, 9467, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:50'),
(581, 'Charramoni Mohon', 'চররমনী মোহন', 1, 7, 60, 9468, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:51'),
(582, 'Charkalkini', 'চর কালকিনি', 1, 7, 61, 9469, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:53'),
(583, 'Shaheberhat', 'সাহেবেরহাট', 1, 7, 61, 9470, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:54'),
(584, 'Char Martin', 'চর মার্টিন', 1, 7, 61, 9471, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:56'),
(585, 'Char Folcon', 'চর ফলকন', 1, 7, 61, 9472, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:58'),
(586, 'Patarirhat', 'পাটারীরহাট', 1, 7, 61, 9473, 1, 1, 1, '2021-02-13 15:17:26', '2023-02-22 02:37:59'),
(587, 'Hajirhat', 'হাজিরহাট', 1, 7, 61, 9474, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:01'),
(588, 'Char Kadira', 'চর কাদিরা', 1, 7, 61, 9475, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:02'),
(589, 'Torabgonj', 'তোরাবগঞ্জ', 1, 7, 61, 9476, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:04'),
(590, 'Charlorench', 'চর লরেঞ্চ', 1, 7, 61, 9477, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:05'),
(591, 'North Char Ababil', 'উত্তর চর আবাবিল', 1, 7, 62, 9478, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:07'),
(592, 'North Char Bangshi', 'উত্তর চর বংশী', 1, 7, 62, 9479, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:08'),
(593, 'Char Mohana', 'চর মোহনা', 1, 7, 62, 9480, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:10'),
(594, 'Sonapur', 'সোনাপুর', 1, 7, 62, 9481, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:11'),
(595, 'Charpata', 'চর পাতা', 1, 7, 62, 9482, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:13'),
(596, 'Bamni', 'বামনী', 1, 7, 62, 9483, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:14'),
(597, 'South Char Bangshi', 'দক্ষিন চর বংশী', 1, 7, 62, 9484, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:16'),
(598, 'South Char Ababil', 'দক্ষিন চর আবাবিল', 1, 7, 62, 9485, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:17'),
(599, 'Raipur', 'রায়পুর', 1, 7, 62, 9486, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:19'),
(600, 'Keora', 'কেরোয়া', 1, 7, 62, 9487, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:21'),
(601, 'Char Poragacha', 'চর পোড়াগাছা', 1, 7, 63, 9488, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:22'),
(602, 'Charbadam', 'চর বাদাম', 1, 7, 63, 9489, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:24'),
(603, 'Char Abdullah', 'চর আবদুল্যাহ', 1, 7, 63, 9490, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:25'),
(604, 'Alxendar', 'আলেকজান্ডার', 1, 7, 63, 9491, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:27'),
(605, 'Char Algi', 'চর আলগী', 1, 7, 63, 9492, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:28'),
(606, 'Char Ramiz', 'চর রমিজ', 1, 7, 63, 9493, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:30'),
(607, 'Borokheri', 'বড়খেড়ী', 1, 7, 63, 9494, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:31'),
(608, 'Chargazi', 'চরগাজী', 1, 7, 63, 9495, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:33'),
(609, 'Kanchanpur', 'কাঞ্চনপুর', 1, 7, 64, 9496, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:34'),
(610, 'Noagaon', 'নোয়াগাঁও', 1, 7, 64, 9497, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:36'),
(611, 'Bhadur', 'ভাদুর', 1, 7, 64, 9498, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:37'),
(612, 'Ichhapur', 'ইছাপুর', 1, 7, 64, 9499, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:39'),
(613, 'Chandipur', 'চন্ডিপুর', 1, 7, 64, 9500, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:40'),
(614, 'Lamchar', 'লামচর', 1, 7, 64, 9501, 1, 1, 1, '2021-02-13 15:17:27', '2023-02-22 02:38:42'),
(615, 'Darbeshpur', 'দরবেশপুর', 1, 7, 64, 9502, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:43'),
(616, 'Karpara', 'করপাড়া', 1, 7, 64, 9503, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:45'),
(617, 'Bholakot', 'ভোলাকোট', 1, 7, 64, 9504, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:46'),
(618, 'Bhatra', 'ভাটরা', 1, 7, 64, 9505, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:48'),
(619, 'Rajanagar', 'রাজানগর', 1, 8, 65, 9506, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:49'),
(620, 'Hosnabad', 'হোছনাবাদ', 1, 8, 65, 9507, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:51'),
(621, 'Swanirbor Rangunia', 'স্বনির্ভর রাঙ্গুনিয়া', 1, 8, 65, 9508, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:53'),
(622, 'Mariumnagar', 'মরিয়মনগর', 1, 8, 65, 9509, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:54'),
(623, 'Parua', 'পারুয়া', 1, 8, 65, 9510, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:56'),
(624, 'Pomra', 'পোমরা', 1, 8, 65, 9511, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:57'),
(625, 'Betagi', 'বেতাগী', 1, 8, 65, 9512, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:38:59'),
(626, 'Sharafbhata', 'সরফভাটা', 1, 8, 65, 9513, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:00'),
(627, 'Shilok', 'শিলক', 1, 8, 65, 9514, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:02'),
(628, 'Chandraghona', 'চন্দ্রঘোনা', 1, 8, 65, 9515, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:05'),
(629, 'Kodala', 'কোদালা', 1, 8, 65, 9516, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:06'),
(630, 'Islampur', 'ইসলামপুর', 1, 8, 65, 9517, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:09'),
(631, 'South Rajanagar', 'দক্ষিণ রাজানগর', 1, 8, 65, 9518, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:10'),
(632, 'Lalanagar', 'লালানগর', 1, 8, 65, 9519, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:12'),
(633, 'Kumira', 'কুমিরা', 1, 8, 66, 9520, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:14'),
(634, 'Banshbaria', 'বাঁশবারীয়া', 1, 8, 66, 9521, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:15'),
(635, 'Barabkunda', 'বারবকুন্ড', 1, 8, 66, 9522, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:17'),
(636, 'Bariadyala', 'বাড়িয়াডিয়ালা', 1, 8, 66, 9523, 1, 1, 1, '2021-02-13 15:17:28', '2023-02-22 02:39:19'),
(637, 'Muradpur', 'মুরাদপুর', 1, 8, 66, 9524, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:20'),
(638, 'Saidpur', 'সাঈদপুর', 1, 8, 66, 9525, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:22'),
(639, 'Salimpur', 'সালিমপুর', 1, 8, 66, 9526, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:23'),
(640, 'Sonaichhari', 'সোনাইছড়ি', 1, 8, 66, 9527, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:25'),
(641, 'Bhatiari', 'ভাটিয়ারী', 1, 8, 66, 9528, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:26'),
(642, 'Korerhat', 'করেরহাট', 1, 8, 67, 9529, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:28'),
(643, 'Hinguli', 'হিংগুলি', 1, 8, 67, 9530, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:29'),
(644, 'Jorarganj', 'জোরারগঞ্জ', 1, 8, 67, 9531, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:31'),
(645, 'Dhoom', 'ধুম', 1, 8, 67, 9532, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:32'),
(646, 'Osmanpur', 'ওসমানপুর', 1, 8, 67, 9533, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:34'),
(647, 'Ichakhali', 'ইছাখালী', 1, 8, 67, 9534, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:35'),
(648, 'Katachhara', 'কাটাছরা', 1, 8, 67, 9535, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:37'),
(649, 'Durgapur', 'দূর্গাপুর', 1, 8, 67, 9536, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:38'),
(650, 'Mirsharai', 'মীরসরাই', 1, 8, 67, 9537, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:40'),
(651, 'Mithanala', 'মিঠানালা', 1, 8, 67, 9538, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:42'),
(652, 'Maghadia', 'মঘাদিয়া', 1, 8, 67, 9539, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:43'),
(653, 'Khaiyachhara', 'খৈয়াছরা', 1, 8, 67, 9540, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:45'),
(654, 'Mayani', 'মায়ানী', 1, 8, 67, 9541, 1, 1, 1, '2021-02-13 15:17:29', '2023-02-22 02:39:46'),
(655, 'Haitkandi', 'হাইতকান্দি', 1, 8, 67, 9542, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:48'),
(656, 'Wahedpur', 'ওয়াহেদপুর', 1, 8, 67, 9543, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:49'),
(657, 'Saherkhali', 'সাহেরখালী', 1, 8, 67, 9544, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:51'),
(658, 'Asia', 'আশিয়া', 1, 8, 68, 9545, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:52'),
(659, 'Kachuai', 'কাচুয়াই', 1, 8, 68, 9546, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:54'),
(660, 'Kasiais', 'কাশিয়াইশ', 1, 8, 68, 9547, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:55'),
(661, 'Kusumpura', 'কুসুমপুরা', 1, 8, 68, 9548, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:57'),
(662, 'Kelishahar', 'কেলিশহর', 1, 8, 68, 9549, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:39:58'),
(663, 'Kolagaon', 'কোলাগাঁও', 1, 8, 68, 9550, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:00'),
(664, 'Kharana', 'খরনা', 1, 8, 68, 9551, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:01'),
(665, 'Char Patharghata', 'চর পাথরঘাটা', 1, 8, 68, 9552, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:03'),
(666, 'Char Lakshya', 'চর লক্ষ্যা', 1, 8, 68, 9553, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:05'),
(667, 'Chanhara', 'ছনহরা', 1, 8, 68, 9554, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:06'),
(668, 'Janglukhain', 'জঙ্গলখাইন', 1, 8, 68, 9555, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:08'),
(669, 'Jiri', 'জিরি', 1, 8, 68, 9556, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:09'),
(670, 'Juldha', 'জুলধা', 1, 8, 68, 9557, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:11'),
(671, 'Dakkhin Bhurshi', 'দক্ষিণ ভূর্ষি', 1, 8, 68, 9558, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:12'),
(672, 'Dhalghat', 'ধলঘাট', 1, 8, 68, 9559, 1, 1, 1, '2021-02-13 15:17:30', '2023-02-22 02:40:14'),
(673, 'Bara Uthan', 'বড় উঠান', 1, 8, 68, 9560, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:16'),
(674, 'Baralia', 'বরলিয়া', 1, 8, 68, 9561, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:17'),
(675, 'Bhatikhain', 'ভাটিখাইন', 1, 8, 68, 9562, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:19'),
(676, 'Sikalbaha', 'শিকলবাহা', 1, 8, 68, 9563, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:20'),
(677, 'Sobhandandi', 'শোভনদন্ডী', 1, 8, 68, 9564, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:22'),
(678, 'Habilasdwi', 'হাবিলাসদ্বীপ', 1, 8, 68, 9565, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:23'),
(679, 'Haidgaon', 'হাইদগাঁও', 1, 8, 68, 9566, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:25'),
(680, 'Rahmatpur', 'রহমতপুর', 1, 8, 69, 9567, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:26'),
(681, 'Harispur', 'হরিশপুর', 1, 8, 69, 9568, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:28'),
(682, 'Kalapania', 'কালাপানিয়া', 1, 8, 69, 9569, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:29'),
(683, 'Amanullah', 'আমানউল্যা', 1, 8, 69, 9570, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:31'),
(684, 'Santoshpur', 'সন্তোষপুর', 1, 8, 69, 9571, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:32'),
(685, 'Gachhua', 'গাছুয়া', 1, 8, 69, 9572, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:34'),
(686, 'Bauria', 'বাউরিয়া', 1, 8, 69, 9573, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:36'),
(687, 'Haramia', 'হারামিয়া', 1, 8, 69, 9574, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:37'),
(688, 'Magdhara', 'মগধরা', 1, 8, 69, 9575, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:39'),
(689, 'Maitbhanga', 'মাইটভাঙ্গা', 1, 8, 69, 9576, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:40'),
(690, 'Sarikait', 'সারিকাইত', 1, 8, 69, 9577, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:42'),
(691, 'Musapur', 'মুছাপুর', 1, 8, 69, 9578, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:43'),
(692, 'Azimpur', 'আজিমপুর', 1, 8, 69, 9579, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:45'),
(693, 'Urirchar', 'উড়িরচর', 1, 8, 69, 9580, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:47'),
(694, 'Pukuria', 'পুকুরিয়া', 1, 8, 70, 9581, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:48'),
(695, 'Sadhanpur', 'সাধনপুর', 1, 8, 70, 9582, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:50'),
(696, 'Khankhanabad', 'খানখানাবাদ', 1, 8, 70, 9583, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:51'),
(697, 'Baharchhara', 'বাহারছড়া', 1, 8, 70, 9584, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:53'),
(698, 'Kalipur', 'কালীপুর', 1, 8, 70, 9585, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:54'),
(699, 'Bailchhari', 'বৈলছড়ি', 1, 8, 70, 9586, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:56'),
(700, 'Katharia', 'কাথরিয়া', 1, 8, 70, 9587, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:57'),
(701, 'Saral', 'সরল', 1, 8, 70, 9588, 1, 1, 1, '2021-02-13 15:17:31', '2023-02-22 02:40:59'),
(702, 'Silk', 'শীলকুপ', 1, 8, 70, 9589, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:00'),
(703, 'Chambal', 'চাম্বল', 1, 8, 70, 9590, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:02'),
(704, 'Gandamara', 'গন্ডামারা', 1, 8, 70, 9591, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:03'),
(705, 'Sekherkhil', 'শেখেরখীল', 1, 8, 70, 9592, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:05'),
(706, 'Puichhari', 'পুঁইছড়ি', 1, 8, 70, 9593, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:07'),
(707, 'Chhanua', 'ছনুয়া', 1, 8, 70, 9594, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:08'),
(708, 'Kandhurkhil', 'কধুরখীল', 1, 8, 71, 9595, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:10'),
(709, 'Pashchim Gamdandi', 'পশ্চিম গোমদন্ডী', 1, 8, 71, 9596, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:11'),
(710, 'Purba Gomdandi', 'পুর্ব গোমদন্ডী', 1, 8, 71, 9597, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:13'),
(711, 'Sakpura', 'শাকপুরা', 1, 8, 71, 9598, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:14'),
(712, 'Saroatali', 'সারোয়াতলী', 1, 8, 71, 9599, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:16'),
(713, 'Popadia', 'পোপাদিয়া', 1, 8, 71, 9600, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:17'),
(714, 'Charandwi', 'চরনদ্বীপ', 1, 8, 71, 9601, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:19'),
(715, 'Sreepur-Kharandwi', 'শ্রীপুর-খরন্দীপ', 1, 8, 71, 9602, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:20'),
(716, 'Amuchia', 'আমুচিয়া', 1, 8, 71, 9603, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:22'),
(717, 'Ahla Karaldenga', 'আহল্লা করলডেঙ্গা', 1, 8, 71, 9604, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:23'),
(718, 'Boirag', 'বৈরাগ', 1, 8, 72, 9605, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:25'),
(719, 'Barasat', 'বারশত', 1, 8, 72, 9606, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:26'),
(720, 'Raipur', 'রায়পুর', 1, 8, 72, 9607, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:28'),
(721, 'Battali', 'বটতলী', 1, 8, 72, 9608, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:30'),
(722, 'Barumchara', 'বরম্নমচড়া', 1, 8, 72, 9609, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:31'),
(723, 'Baroakhan', 'বারখাইন', 1, 8, 72, 9610, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:33'),
(724, 'Anwara', 'আনোয়ারা', 1, 8, 72, 9611, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:34'),
(725, 'Chatari', 'চাতরী', 1, 8, 72, 9612, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:36'),
(726, 'Paraikora', 'পরৈকোড়া', 1, 8, 72, 9613, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:37'),
(727, 'Haildhar', 'হাইলধর', 1, 8, 72, 9614, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:39'),
(728, 'Juidandi', 'জুঁইদন্ডী', 1, 8, 72, 9615, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:40'),
(729, 'Kanchanabad', 'কাঞ্চনাবাদ', 1, 8, 73, 9616, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:42'),
(730, 'Joara', 'জোয়ারা', 1, 8, 73, 9617, 1, 1, 1, '2021-02-13 15:17:32', '2023-02-22 02:41:43'),
(731, 'Barkal', 'বরকল', 1, 8, 73, 9618, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:45'),
(732, 'Barama', 'বরমা', 1, 8, 73, 9619, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:46'),
(733, 'Bailtali', 'বৈলতলী', 1, 8, 73, 9620, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:48'),
(734, 'Satbaria', 'সাতবাড়িয়া', 1, 8, 73, 9621, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:49'),
(735, 'Hashimpur', 'হাশিমপুর', 1, 8, 73, 9622, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:51'),
(736, 'Dohazari', 'দোহাজারী', 1, 8, 73, 9623, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:52'),
(737, 'Dhopachhari', 'ধোপাছড়ী', 1, 8, 73, 9624, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:54'),
(738, 'Charati', 'চরতী', 1, 8, 74, 9625, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:56'),
(739, 'Khagaria', 'খাগরিয়া', 1, 8, 74, 9626, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:57'),
(740, 'Nalua', 'নলুয়া', 1, 8, 74, 9627, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:41:59'),
(741, 'Kanchana', 'কাঞ্চনা', 1, 8, 74, 9628, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:00'),
(742, 'Amilaisi', 'আমিলাইশ', 1, 8, 74, 9629, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:02'),
(743, 'Eochiai', 'এওচিয়া', 1, 8, 74, 9630, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:03'),
(744, 'Madarsa', 'মাদার্শা', 1, 8, 74, 9631, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:05'),
(745, 'Dhemsa', 'ঢেমশা', 1, 8, 74, 9632, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:06'),
(746, 'Paschim Dhemsa', 'পশ্চিম ঢেমশা', 1, 8, 74, 9633, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:08'),
(747, 'Keochia', 'কেঁওচিয়া', 1, 8, 74, 9634, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:09'),
(748, 'Kaliais', 'কালিয়াইশ', 1, 8, 74, 9635, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:11'),
(749, 'Bazalia', 'বাজালিয়া', 1, 8, 74, 9636, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:12'),
(750, 'Puranagar', 'পুরানগড়', 1, 8, 74, 9637, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:14'),
(751, 'Sadaha', 'ছদাহা', 1, 8, 74, 9638, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:15'),
(752, 'Satkania', 'সাতকানিয়া', 1, 8, 74, 9639, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:17'),
(753, 'Sonakania', 'সোনাকানিয়া', 1, 8, 74, 9640, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:18'),
(754, 'Padua', 'পদুয়া', 1, 8, 75, 9641, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:20'),
(755, 'Barahatia', 'বড়হাতিয়া', 1, 8, 75, 9642, 1, 1, 1, '2021-02-13 15:17:33', '2023-02-22 02:42:21'),
(756, 'Amirabad', 'আমিরাবাদ', 1, 8, 75, 9643, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:23'),
(757, 'Charamba', 'চরম্বা', 1, 8, 75, 9644, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:25'),
(758, 'Kalauzan', 'কলাউজান', 1, 8, 75, 9645, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:26'),
(759, 'Lohagara', 'লোহাগাড়া', 1, 8, 75, 9646, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:28'),
(760, 'Putibila', 'পুটিবিলা', 1, 8, 75, 9647, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:29'),
(761, 'Chunati', 'চুনতি', 1, 8, 75, 9648, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:31'),
(762, 'Adhunagar', 'আধুনগর', 1, 8, 75, 9649, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:32'),
(763, 'Farhadabad', 'ফরহাদাবাদ', 1, 8, 76, 9650, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:34'),
(764, 'Dhalai', 'ধলই', 1, 8, 76, 9651, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:35'),
(765, 'Mirjapur', 'মির্জাপুর', 1, 8, 76, 9652, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:37'),
(766, 'Nangolmora', 'নাঙ্গলমোরা', 1, 8, 76, 9653, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:38'),
(767, 'Gomanmordan', 'গুমানমর্দ্দন', 1, 8, 76, 9654, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:40'),
(768, 'Chipatali', 'ছিপাতলী', 1, 8, 76, 9655, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:41'),
(769, 'Mekhal', 'মেখল', 1, 8, 76, 9656, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:43'),
(770, 'Garduara', 'গড়দুয়ারা', 1, 8, 76, 9657, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:44'),
(771, 'Fathepur', 'ফতেপুর', 1, 8, 76, 9658, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:46'),
(772, 'Chikondandi', 'চিকনদন্ডী', 1, 8, 76, 9659, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:47'),
(773, 'Uttar Madrasha', 'উত্তর মাদার্শা', 1, 8, 76, 9660, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:49'),
(774, 'Dakkin Madrasha', 'দক্ষিন মাদার্শা', 1, 8, 76, 9661, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:50'),
(775, 'Sikarpur', 'শিকারপুর', 1, 8, 76, 9662, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:52'),
(776, 'Budirchar', 'বুডিরশ্চর', 1, 8, 76, 9663, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:54'),
(777, 'Hathazari', 'হাটহাজারী', 1, 8, 76, 9664, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:55'),
(778, 'Dharmapur', 'ধর্মপুর', 1, 8, 77, 9665, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:57'),
(779, 'Baganbazar', 'বাগান বাজার', 1, 8, 77, 9666, 1, 1, 1, '2021-02-13 15:17:34', '2023-02-22 02:42:58'),
(780, 'Dantmara', 'দাঁতমারা', 1, 8, 77, 9667, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:00'),
(781, 'Narayanhat', 'নারায়নহাট', 1, 8, 77, 9668, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:01'),
(782, 'Bhujpur', 'ভূজপুর', 1, 8, 77, 9669, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:03'),
(783, 'Harualchari', 'হারুয়ালছড়ি', 1, 8, 77, 9670, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:04'),
(784, 'Paindong', 'পাইনদং', 1, 8, 77, 9671, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:06'),
(785, 'Kanchannagor', 'কাঞ্চনগর', 1, 8, 77, 9672, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:07'),
(786, 'Sunderpur', 'সুনদরপুর', 1, 8, 77, 9673, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:09'),
(787, 'Suabil', 'সুয়াবিল', 1, 8, 77, 9674, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:10'),
(788, 'Abdullapur', 'আবদুল্লাপুর', 1, 8, 77, 9675, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:12'),
(789, 'Samitirhat', 'সমিতির হাট', 1, 8, 77, 9676, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:13'),
(790, 'Jafathagar', 'জাফতনগর', 1, 8, 77, 9677, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:15'),
(791, 'Bokhtapur', 'বক্তপুর', 1, 8, 77, 9678, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:16'),
(792, 'Roshangiri', 'রোসাংগিরী', 1, 8, 77, 9679, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:18'),
(793, 'Nanupur', 'নানুপুর', 1, 8, 77, 9680, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:20'),
(794, 'Lelang', 'লেলাং', 1, 8, 77, 9681, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:21'),
(795, 'Daulatpur', 'দৌলতপুর', 1, 8, 77, 9682, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:23'),
(796, 'Raozan', 'রাউজান', 1, 8, 78, 9683, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:24'),
(797, 'Bagoan', 'বাগোয়ান', 1, 8, 78, 9684, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:26'),
(798, 'Binajuri', 'বিনাজুরী', 1, 8, 78, 9685, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:27'),
(799, 'Chikdair', 'চিকদাইর', 1, 8, 78, 9686, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:29'),
(800, 'Dabua', 'ডাবুয়া', 1, 8, 78, 9687, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:30'),
(801, 'Purbagujra', 'পূর্ব গুজরা', 1, 8, 78, 9688, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:32'),
(802, 'Paschim Gujra', 'পশ্চিম গুজরা', 1, 8, 78, 9689, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:34'),
(803, 'Gohira', 'গহিরা', 1, 8, 78, 9690, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:35'),
(804, 'Holdia', 'হলদিয়া', 1, 8, 78, 9691, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:37'),
(805, 'Kodolpur', 'কদলপূর', 1, 8, 78, 9692, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:38'),
(806, 'Noapara', 'নোয়াপাড়া', 1, 8, 78, 9693, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:40'),
(807, 'Pahartali', 'পাহাড়তলী', 1, 8, 78, 9694, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:41'),
(808, 'Urkirchar', 'উড়কিরচর', 1, 8, 78, 9695, 1, 1, 1, '2021-02-13 15:17:35', '2023-02-22 02:43:43'),
(809, 'Nowajushpur', 'নওয়াজিশপুর', 1, 8, 78, 9696, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:44'),
(810, 'Char Patharghata', 'চর পাথরঘাটা', 1, 8, 79, 9697, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:46'),
(811, 'Char Lakshya', 'চর লক্ষ্যা', 1, 8, 79, 9698, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:47'),
(812, 'Juldha', 'জুলধা', 1, 8, 79, 9699, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:49'),
(813, 'Barauthan', 'বড় উঠান', 1, 8, 79, 9700, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:51'),
(814, 'Sikalbaha', 'শিকলবাহা', 1, 8, 79, 9701, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:52'),
(815, 'Islamabad', 'ইসলামাবাদ', 1, 9, 80, 9702, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:54'),
(816, 'Islampur', 'ইসলামপুর', 1, 9, 80, 9703, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:55'),
(817, 'Pokkhali', 'পোকখালী', 1, 9, 80, 9704, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:57'),
(818, 'Eidgaon', 'ঈদগাঁও', 1, 9, 80, 9705, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:43:58'),
(819, 'Jalalabad', 'জালালাবাদ', 1, 9, 80, 9706, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:00'),
(820, 'Chowfaldandi', 'চৌফলদন্ডী', 1, 9, 80, 9707, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:01'),
(821, 'Varuakhali', 'ভারুয়াখালী', 1, 9, 80, 9708, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:03'),
(822, 'Pmkhali', 'পিএমখালী', 1, 9, 80, 9709, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:04'),
(823, 'Khurushkhul', 'খুরুশকুল', 1, 9, 80, 9710, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:06'),
(824, 'Jhilongjha', 'ঝিলংঝা', 1, 9, 80, 9711, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:07'),
(825, 'Kakhara', 'কাকারা', 1, 9, 81, 9712, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:09'),
(826, 'Kaiar Bil', 'কাইয়ার বিল', 1, 9, 81, 9713, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:10'),
(827, 'Konakhali', 'কোনাখালী', 1, 9, 81, 9714, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:12'),
(828, 'Khuntakhali', 'খুটাখালী', 1, 9, 81, 9715, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:13'),
(829, 'Chiringa', 'চিরিঙ্গা', 1, 9, 81, 9716, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:15'),
(830, 'Demusia', 'ঢেমুশিয়া', 1, 9, 81, 9717, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:16'),
(831, 'Dulahazara', 'ডুলাহাজারা', 1, 9, 81, 9718, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:18'),
(832, 'Paschim Bara Bheola', 'পশ্চিম বড় ভেওলা', 1, 9, 81, 9719, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:20'),
(833, 'Badarkhali', 'বদরখালী', 1, 9, 81, 9720, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:21'),
(834, 'Bamobil Chari', 'বামু বিলছড়ি', 1, 9, 81, 9721, 1, 1, 1, '2021-02-13 15:17:36', '2023-02-22 02:44:23'),
(835, 'Baraitali', 'বড়ইতলী', 1, 9, 81, 9722, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:24'),
(836, 'Bheola Manik Char', 'ভেওলা মানিক চর', 1, 9, 81, 9723, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:26'),
(837, 'Saharbil', 'শাহারবিল', 1, 9, 81, 9724, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:27'),
(838, 'Surajpur Manikpur', 'সুরজপুর মানিকপুর', 1, 9, 81, 9725, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:29'),
(839, 'Harbang', 'হারবাঙ্গ', 1, 9, 81, 9726, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:30'),
(840, 'Fashiakhali', 'ফাঁসিয়াখালী', 1, 9, 81, 9727, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:32'),
(841, 'Ali Akbar Deil', 'আলি আকবর ডেইল', 1, 9, 82, 9728, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:33'),
(842, 'Uttar Dhurung', 'উত্তর ধুরুং', 1, 9, 82, 9729, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:35'),
(843, 'Kaiyarbil', 'কৈয়ারবিল', 1, 9, 82, 9730, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:36'),
(844, 'Dakshi Dhurung', 'দক্ষিণ ধুরুং', 1, 9, 82, 9731, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:38'),
(845, 'Baragho', 'বড়ঘোপ', 1, 9, 82, 9732, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:39'),
(846, 'Lemsikhali', 'লেমসিখালী', 1, 9, 82, 9733, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:41'),
(847, 'Rajapalong', 'রাজাপালং', 1, 9, 83, 9734, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:42'),
(848, 'Jaliapalong', 'জালিয়াপালং', 1, 9, 83, 9735, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:44'),
(849, 'Holdiapalong', 'হলদিয়াপালং', 1, 9, 83, 9736, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:45'),
(850, 'Ratnapalong', 'রত্নাপালং', 1, 9, 83, 9737, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:47'),
(851, 'Palongkhali', 'পালংখালী', 1, 9, 83, 9738, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:49'),
(852, 'Boro Moheshkhali', 'বড় মহেশখালী', 1, 9, 84, 9739, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:50'),
(853, 'Choto Moheshkhali', 'ছোট মহেশখালী', 1, 9, 84, 9740, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:52'),
(854, 'Shaplapur', 'শাপলাপুর', 1, 9, 84, 9741, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:53'),
(855, 'Kutubjum', 'কুতুবজোম', 1, 9, 84, 9742, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:55'),
(856, 'Hoanak', 'হোয়ানক', 1, 9, 84, 9743, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:56'),
(857, 'Kalarmarchhara', 'কালারমারছড়া', 1, 9, 84, 9744, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:58'),
(858, 'Matarbari', 'মাতারবাড়ী', 1, 9, 84, 9745, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:44:59'),
(859, 'Dhalghata', 'ধলঘাটা', 1, 9, 84, 9746, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:45:01'),
(860, 'Ujantia', 'উজানটিয়া', 1, 9, 85, 9747, 1, 1, 1, '2021-02-13 15:17:37', '2023-02-22 02:45:02'),
(861, 'Taitong', 'টাইটং', 1, 9, 85, 9748, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:04'),
(862, 'Pekua', 'পেকুয়া', 1, 9, 85, 9749, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:06'),
(863, 'Barabakia', 'বড় বাকিয়া', 1, 9, 85, 9750, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:10'),
(864, 'Magnama', 'মগনামা', 1, 9, 85, 9751, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:13'),
(865, 'Rajakhali', 'রাজাখালী', 1, 9, 85, 9752, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:14'),
(866, 'Shilkhali', 'শীলখালী', 1, 9, 85, 9753, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:16'),
(867, 'Fotekharkul', 'ফতেখাঁরকুল', 1, 9, 86, 9754, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:18'),
(868, 'Rajarkul', 'রাজারকুল', 1, 9, 86, 9755, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:19'),
(869, 'Rashidnagar', 'রশীদনগর', 1, 9, 86, 9756, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:21'),
(870, 'Khuniapalong', 'খুনিয়াপালং', 1, 9, 86, 9757, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:23'),
(871, 'Eidghar', 'ঈদগড়', 1, 9, 86, 9758, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:24'),
(872, 'Chakmarkul', 'চাকমারকুল', 1, 9, 86, 9759, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:26'),
(873, 'Kacchapia', 'কচ্ছপিয়া', 1, 9, 86, 9760, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:27'),
(874, 'Kauwarkho', 'কাউয়ারখোপ', 1, 9, 86, 9761, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:29'),
(875, 'Dakkhin Mithachhari', 'দক্ষিণ মিঠাছড়ি', 1, 9, 86, 9762, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:30'),
(876, 'Jouarianala', 'জোয়ারিয়া নালা', 1, 9, 86, 9763, 1, 1, 1, '2021-02-13 15:17:38', '2023-02-22 02:45:32'),
(877, 'Garjoniya', 'গর্জনিয়া', 1, 9, 86, 9764, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:33'),
(878, 'Subrang', 'সাবরাং', 1, 9, 87, 9765, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:35'),
(879, 'Baharchara', 'বাহারছড়া', 1, 9, 87, 9766, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:36'),
(880, 'Hnila', 'হ্নীলা', 1, 9, 87, 9767, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:38'),
(881, 'Whykong', 'হোয়াইক্যং', 1, 9, 87, 9768, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:39'),
(882, 'Saintmartin', 'সেন্ট মার্টিন', 1, 9, 87, 9769, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:41'),
(883, 'Teknaf Sadar', 'টেকনাফ সদর', 1, 9, 87, 9770, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:42'),
(884, 'Khagrachhari Sadar', 'খাগরাছড়ি সদর', 1, 10, 88, 9771, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:44'),
(885, 'Golabari', 'গোলাবাড়ী', 1, 10, 88, 9772, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:46'),
(886, 'Parachara', 'পেরাছড়া', 1, 10, 88, 9773, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:47'),
(887, 'Kamalchari', 'কমলছড়ি', 1, 10, 88, 9774, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:49'),
(888, 'Merung', 'মেরুং', 1, 10, 89, 9775, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:51'),
(889, 'Boalkhali', 'বোয়ালখালী', 1, 10, 89, 9776, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:53'),
(890, 'Kabakhali', 'কবাখালী', 1, 10, 89, 9777, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:54'),
(891, 'Dighinala', 'দিঘীনালা', 1, 10, 89, 9778, 1, 1, 1, '2021-02-13 15:17:39', '2023-02-22 02:45:56'),
(892, 'Babuchara', 'বাবুছড়া', 1, 10, 89, 9779, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:45:57'),
(893, 'Logang', 'লোগাং', 1, 10, 90, 9780, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:45:59'),
(894, 'Changi', 'চেংগী', 1, 10, 90, 9781, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:01'),
(895, 'Panchari', 'পানছড়ি', 1, 10, 90, 9782, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:02'),
(896, 'Latiban', 'লতিবান', 1, 10, 90, 9783, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:04'),
(897, 'Dullyatali', 'দুল্যাতলী', 1, 10, 91, 9784, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:05'),
(898, 'Barmachari', 'বর্মাছড়ি', 1, 10, 91, 9785, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:07'),
(899, 'Laxmichhari', 'লক্ষীছড়ি', 1, 10, 91, 9786, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:08'),
(900, 'Bhaibonchara', 'ভাইবোনছড়া', 1, 10, 92, 9787, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:10'),
(901, 'Mahalchari', 'মহালছড়ি', 1, 10, 92, 9788, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:11'),
(902, 'Mobachari', 'মুবাছড়ি', 1, 10, 92, 9789, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:13'),
(903, 'Kayanghat', 'ক্যায়াংঘাট', 1, 10, 92, 9790, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:14'),
(904, 'Maischari', 'মাইসছড়ি', 1, 10, 92, 9791, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:16'),
(905, 'Manikchari', 'মানিকছড়ি', 1, 10, 93, 9792, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:17'),
(906, 'Batnatali', 'বাটনাতলী', 1, 10, 93, 9793, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:19'),
(907, 'Jogyachola', 'যোগ্যছোলা', 1, 10, 93, 9794, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:20'),
(908, 'Tintahari', 'তিনটহরী', 1, 10, 93, 9795, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:22'),
(909, 'Ramgarh', 'রামগড়', 1, 10, 94, 9796, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:23'),
(910, 'Patachara', 'পাতাছড়া', 1, 10, 94, 9797, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:25'),
(911, 'Hafchari', 'হাফছড়ি', 1, 10, 94, 9798, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:26'),
(912, 'Taindong', 'তাইন্দং', 1, 10, 95, 9799, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:28'),
(913, 'Tabalchari', 'তবলছড়ি', 1, 10, 95, 9800, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:29'),
(914, 'Barnal', 'বর্ণাল', 1, 10, 95, 9801, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:31'),
(915, 'Gomti', 'গোমতি', 1, 10, 95, 9802, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:32'),
(916, 'Balchari', 'বেলছড়ি', 1, 10, 95, 9803, 1, 1, 1, '2021-02-13 15:17:40', '2023-02-22 02:46:34'),
(917, 'Matiranga', 'মাটিরাঙ্গা', 1, 10, 95, 9804, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:36'),
(918, 'Guimara', 'গুইমারা', 1, 10, 95, 9805, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:37'),
(919, 'Amtali', 'আমতলি', 1, 10, 95, 9806, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:39'),
(920, 'Rajbila', 'রাজবিলা', 1, 11, 97, 9807, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:40'),
(921, 'Tongkaboty', 'টংকাবতী', 1, 11, 97, 9808, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:42'),
(922, 'Suwalok', 'সুয়ালক', 1, 11, 97, 9809, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:43'),
(923, 'Bandarban Sadar', 'বান্দরবান সদর', 1, 11, 97, 9810, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:45'),
(924, 'Kuhalong', 'কুহালং', 1, 11, 97, 9811, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:47'),
(925, 'Alikadam Sadar', 'আলীকদম সদর', 1, 11, 98, 9812, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:49'),
(926, 'Chwekhyong', 'চৈক্ষ্যং', 1, 11, 98, 9813, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:51'),
(927, 'Naikhyongchari Sadar', 'নাইক্ষ্যংছড়ি সদর', 1, 11, 99, 9814, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:53'),
(928, 'Gumdhum', 'ঘুমধুম', 1, 11, 99, 9815, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:56'),
(929, 'Baishari', 'বাইশারী', 1, 11, 99, 9816, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:58'),
(930, 'Sonaychari', 'সোনাইছড়ি', 1, 11, 99, 9817, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:46:59'),
(931, 'Duwchari', 'দোছড়ি', 1, 11, 99, 9818, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:01'),
(932, 'Rowangchari Sadar', 'রোয়াংছড়ি সদর', 1, 11, 100, 9819, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:02'),
(933, 'Taracha', 'তারাছা', 1, 11, 100, 9820, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:04'),
(934, 'Alekyong', 'আলেক্ষ্যং', 1, 11, 100, 9821, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:05'),
(935, 'Nawapotong', 'নোয়াপতং', 1, 11, 100, 9822, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:07'),
(936, 'Gajalia', 'গজালিয়া', 1, 11, 101, 9823, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:08'),
(937, 'Lama Sadar', 'লামা সদর', 1, 11, 101, 9824, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:10'),
(938, 'Fasiakhali', 'ফাসিয়াখালী', 1, 11, 101, 9825, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:11'),
(939, 'Fythong', 'ফাইতং', 1, 11, 101, 9826, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:13'),
(940, 'Rupushipara', 'রূপসীপাড়া', 1, 11, 101, 9827, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:15'),
(941, 'Sarai', 'সরই', 1, 11, 101, 9828, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:16'),
(942, 'Aziznagar', 'আজিজনগর', 1, 11, 101, 9829, 1, 1, 1, '2021-02-13 15:17:41', '2023-02-22 02:47:18'),
(943, 'Paind', 'পাইন্দু', 1, 11, 102, 9830, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:20'),
(944, 'Ruma Sadar', 'রুমা সদর', 1, 11, 102, 9831, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:21'),
(945, 'Ramakreprangsa', 'রেমাক্রীপ্রাংসা', 1, 11, 102, 9832, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:23'),
(946, 'Galanggya', 'গ্যালেংগ্যা', 1, 11, 102, 9833, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:24'),
(947, 'Remakre', 'রেমাক্রী', 1, 11, 103, 9834, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:26'),
(948, 'Tind', 'তিন্দু', 1, 11, 103, 9835, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:27'),
(949, 'Thanchi Sadar', 'থানচি সদর', 1, 11, 103, 9836, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:29'),
(950, 'Balipara', 'বলিপাড়া', 1, 11, 103, 9837, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:30'),
(951, 'Rajapur', 'রাজাপুর', 2, 12, 104, 9838, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:32'),
(952, 'Baradhul', 'বড়ধুল', 2, 12, 104, 9839, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:33'),
(953, 'Belkuchi Sadar', 'বেলকুচি সদর', 2, 12, 104, 9840, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:35'),
(954, 'Dhukuriabera', 'ধুকুরিয়া বেড়া', 2, 12, 104, 9841, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:36'),
(955, 'Doulatpur', 'দৌলতপুর', 2, 12, 104, 9842, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:38'),
(956, 'Bhangabari', 'ভাঙ্গাবাড়ী', 2, 12, 104, 9843, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:39'),
(957, 'Baghutia', 'বাঘুটিয়া', 2, 12, 105, 9844, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:41'),
(958, 'Gharjan', 'ঘোরজান', 2, 12, 105, 9845, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:42'),
(959, 'Khaskaulia', 'খাসকাউলিয়া', 2, 12, 105, 9846, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:44'),
(960, 'Khaspukuria', 'খাসপুকুরিয়া', 2, 12, 105, 9847, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:46'),
(961, 'Omarpur', 'উমারপুর', 2, 12, 105, 9848, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:47'),
(962, 'Sadia Chandpur', 'সদিয়া চাঁদপুর', 2, 12, 105, 9849, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:49'),
(963, 'Sthal', 'স্থল', 2, 12, 105, 9850, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:50'),
(964, 'Bhadraghat', 'ভদ্রঘাট', 2, 12, 106, 9851, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:52'),
(965, 'Jamtail', 'জামতৈল', 2, 12, 106, 9852, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:53'),
(966, 'Jhawail', 'ঝাঐল', 2, 12, 106, 9853, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:55'),
(967, 'Roydaulatpur', 'রায়দৌলতপুর', 2, 12, 106, 9854, 1, 1, 1, '2021-02-13 15:17:42', '2023-02-22 02:47:56'),
(968, 'Chalitadangha', 'চালিতাডাঙ্গা', 2, 12, 107, 9855, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:47:58'),
(969, 'Chargirish', 'চরগিরিশ', 2, 12, 107, 9856, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:47:59'),
(970, 'Gandail', 'গান্ধাইল', 2, 12, 107, 9857, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:01'),
(971, 'Kazipur Sadar', 'কাজিপুর সদর', 2, 12, 107, 9858, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:02'),
(972, 'Khasrajbari', 'খাসরাজবাড়ী', 2, 12, 107, 9859, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:04'),
(973, 'Maijbari', 'মাইজবাড়ী', 2, 12, 107, 9860, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:05'),
(974, 'Monsur Nagar', 'মনসুর নগর', 2, 12, 107, 9861, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:07');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(975, 'Natuarpara', 'নাটুয়ারপাড়া', 2, 12, 107, 9862, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:09'),
(976, 'Nishchintapur', 'নিশ্চিন্তপুর', 2, 12, 107, 9863, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:10'),
(977, 'Sonamukhi', 'সোনামুখী', 2, 12, 107, 9864, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:12'),
(978, 'Subhagacha', 'শুভগাছা', 2, 12, 107, 9865, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:13'),
(979, 'Tekani', 'তেকানী', 2, 12, 107, 9866, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:15'),
(980, 'Brommogacha', 'ব্রহ্মগাছা', 2, 12, 108, 9867, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:16'),
(981, 'Chandaikona', 'চান্দাইকোনা', 2, 12, 108, 9868, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:18'),
(982, 'Dhamainagar', 'ধামাইনগর', 2, 12, 108, 9869, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:19'),
(983, 'Dhangora', 'ধানগড়া', 2, 12, 108, 9870, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:21'),
(984, 'Dhubil', 'ধুবিল', 2, 12, 108, 9871, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:22'),
(985, 'Ghurka', 'ঘুড়কা', 2, 12, 108, 9872, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:24'),
(986, 'Nalka', 'নলকা', 2, 12, 108, 9873, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:25'),
(987, 'Pangashi', 'পাঙ্গাসী', 2, 12, 108, 9874, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:27'),
(988, 'Sonakhara', 'সোনাখাড়া', 2, 12, 108, 9875, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:28'),
(989, 'Beltail', 'বেলতৈল', 2, 12, 109, 9876, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:30'),
(990, 'Jalalpur', 'জালালপুর', 2, 12, 109, 9877, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:31'),
(991, 'Kayempure', 'কায়েমপুর', 2, 12, 109, 9878, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:33'),
(992, 'Garadah', 'গাড়াদহ', 2, 12, 109, 9879, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:34'),
(993, 'Potazia', 'পোতাজিয়া', 2, 12, 109, 9880, 1, 1, 1, '2021-02-13 15:17:43', '2023-02-22 02:48:36'),
(994, 'Rupbati', 'রূপবাটি', 2, 12, 109, 9881, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:37'),
(995, 'Gala', 'গালা', 2, 12, 109, 9882, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:39'),
(996, 'Porzona', 'পোরজনা', 2, 12, 109, 9883, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:41'),
(997, 'Habibullah Nagar', 'হাবিবুল্লাহ নগর', 2, 12, 109, 9884, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:42'),
(998, 'Khukni', 'খুকনী', 2, 12, 109, 9885, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:44'),
(999, 'Koizuri', 'কৈজুরী', 2, 12, 109, 9886, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:45'),
(1000, 'Sonatoni', 'সোনাতনী', 2, 12, 109, 9887, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:47'),
(1001, 'Narina', 'নরিনা', 2, 12, 109, 9888, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:48'),
(1002, 'Bagbati', 'বাগবাটি', 2, 12, 110, 9889, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:50'),
(1003, 'Ratankandi', 'রতনকান্দি', 2, 12, 110, 9890, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:51'),
(1004, 'Bohuli', 'বহুলী', 2, 12, 110, 9891, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:53'),
(1005, 'Sheyalkol', 'শিয়ালকোল', 2, 12, 110, 9892, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:54'),
(1006, 'Khokshabari', 'খোকশাবাড়ী', 2, 12, 110, 9893, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:56'),
(1007, 'Songacha', 'ছোনগাছা', 2, 12, 110, 9894, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:57'),
(1008, 'Mesra', 'মেছড়া', 2, 12, 110, 9895, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:48:59'),
(1009, 'Kowakhola', 'কাওয়াখোলা', 2, 12, 110, 9896, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:00'),
(1010, 'Kaliahoripur', 'কালিয়াহরিপুর', 2, 12, 110, 9897, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:02'),
(1011, 'Soydabad', 'সয়দাবাদ', 2, 12, 110, 9898, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:03'),
(1012, 'Baruhas', 'বারুহাস', 2, 12, 111, 9899, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:05'),
(1013, 'Talam', 'তালম', 2, 12, 111, 9900, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:07'),
(1014, 'Soguna', 'সগুনা', 2, 12, 111, 9901, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:08'),
(1015, 'Magura Binod', 'মাগুড়া বিনোদ', 2, 12, 111, 9902, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:10'),
(1016, 'Naogaon', 'নওগাঁ', 2, 12, 111, 9903, 1, 1, 1, '2021-02-13 15:17:44', '2023-02-22 02:49:12'),
(1017, 'Tarash Sadar', 'তাড়াশ সদর', 2, 12, 111, 9904, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:13'),
(1018, 'Madhainagar', 'মাধাইনগর', 2, 12, 111, 9905, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:15'),
(1019, 'Deshigram', 'দেশীগ্রাম', 2, 12, 111, 9906, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:16'),
(1020, 'Ullapara Sadar', 'উল্লাপাড়া সদর', 2, 12, 112, 9907, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:18'),
(1021, 'Ramkrisnopur', 'রামকৃষ্ণপুর', 2, 12, 112, 9908, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:19'),
(1022, 'Bangala', 'বাঙ্গালা', 2, 12, 112, 9909, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:21'),
(1023, 'Udhunia', 'উধুনিয়া', 2, 12, 112, 9910, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:22'),
(1024, 'Boropangashi', 'বড়পাঙ্গাসী', 2, 12, 112, 9911, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:24'),
(1025, 'Durga Nagar', 'দুর্গা নগর', 2, 12, 112, 9912, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:25'),
(1026, 'Purnimagati', 'পূর্ণিমাগাতী', 2, 12, 112, 9913, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:27'),
(1027, 'Salanga', 'সলঙ্গা', 2, 12, 112, 9914, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:28'),
(1028, 'Hatikumrul', 'হটিকুমরুল', 2, 12, 112, 9915, 1, 1, 1, '2021-02-13 15:17:45', '2023-02-22 02:49:30'),
(1029, 'Borohor', 'বড়হর', 2, 12, 112, 9916, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:31'),
(1030, 'Ponchocroshi', 'পঞ্চক্রোশী', 2, 12, 112, 9917, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:33'),
(1031, 'Salo', 'সলপ', 2, 12, 112, 9918, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:34'),
(1032, 'Mohonpur', 'মোহনপুর', 2, 12, 112, 9919, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:36'),
(1033, 'Vaina', 'ভায়না', 2, 13, 113, 9920, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:38'),
(1034, 'Tantibonda', 'তাঁতিবন্দ', 2, 13, 113, 9921, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:39'),
(1035, 'Manikhat', 'মানিকহাট', 2, 13, 113, 9922, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:41'),
(1036, 'Dulai', 'দুলাই', 2, 13, 113, 9923, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:42'),
(1037, 'Ahammadpur', 'আহম্মদপুর', 2, 13, 113, 9924, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:44'),
(1038, 'Raninagar', 'রাণীনগর', 2, 13, 113, 9925, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:45'),
(1039, 'Satbaria', 'সাতবাড়ীয়া', 2, 13, 113, 9926, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:47'),
(1040, 'Hatkhali', 'হাটখালী', 2, 13, 113, 9927, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:48'),
(1041, 'Nazirganj', 'নাজিরগঞ্জ', 2, 13, 113, 9928, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:50'),
(1042, 'Sagorkandi', 'সাগরকান্দি', 2, 13, 113, 9929, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:51'),
(1043, 'Sara', 'সাঁড়া', 2, 13, 114, 9930, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:53'),
(1044, 'Pakshi', 'পাকশী', 2, 13, 114, 9931, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:54'),
(1045, 'Muladuli', 'মুলাডুলি', 2, 13, 114, 9932, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:56'),
(1046, 'Dashuria', 'দাশুরিয়া', 2, 13, 114, 9933, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:57'),
(1047, 'Silimpur', 'ছলিমপুর', 2, 13, 114, 9934, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:49:59'),
(1048, 'Sahapur', 'সাহাপুর', 2, 13, 114, 9935, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:00'),
(1049, 'Luxmikunda', 'লক্ষীকুন্ডা', 2, 13, 114, 9936, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:02'),
(1050, 'Bhangura', 'ভাঙ্গুড়া', 2, 13, 115, 9937, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:04'),
(1051, 'Khanmarich', 'খানমরিচ', 2, 13, 115, 9938, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:05'),
(1052, 'Ashtamanisha', 'অষ্টমণিষা', 2, 13, 115, 9939, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:07'),
(1053, 'Dilpasar', 'দিলপাশার', 2, 13, 115, 9940, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:08'),
(1054, 'Parbhangura', 'পারভাঙ্গুড়া', 2, 13, 115, 9941, 1, 1, 1, '2021-02-13 15:17:46', '2023-02-22 02:50:10'),
(1055, 'Maligachha', 'মালিগাছা', 2, 13, 116, 9942, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:11'),
(1056, 'Malanchi', 'মালঞ্চি', 2, 13, 116, 9943, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:13'),
(1057, 'Gayeshpur', 'গয়েশপুর', 2, 13, 116, 9944, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:14'),
(1058, 'Ataikula', 'আতাইকুলা', 2, 13, 116, 9945, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:16'),
(1059, 'Chartarapur', 'চরতারাপুর', 2, 13, 116, 9946, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:17'),
(1060, 'Sadullahpur', 'সাদুল্লাপুর', 2, 13, 116, 9947, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:19'),
(1061, 'Bharara', 'ভাঁড়ারা', 2, 13, 116, 9948, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:20'),
(1062, 'Dogachi', 'দোগাছী', 2, 13, 116, 9949, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:22'),
(1063, 'Hemayetpur', 'হেমায়েতপুর', 2, 13, 116, 9950, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:23'),
(1064, 'Dapunia', 'দাপুনিয়া', 2, 13, 116, 9951, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:25'),
(1065, 'Haturia Nakalia', 'হাটুরিয়া নাকালিয়া', 2, 13, 117, 9952, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:26'),
(1066, 'Notun Varenga', 'নতুন ভারেঙ্গা', 2, 13, 117, 9953, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:28'),
(1067, 'Koitola', 'কৈটোলা', 2, 13, 117, 9954, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:29'),
(1068, 'Chakla', 'চাকলা', 2, 13, 117, 9955, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:31'),
(1069, 'Jatsakhini', 'জাতসাখিনি', 2, 13, 117, 9956, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:33'),
(1070, 'Puran Varenga', 'পুরান ভারেঙ্গা', 2, 13, 117, 9957, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:34'),
(1071, 'Ruppur', 'রূপপুর', 2, 13, 117, 9958, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:36'),
(1072, 'Masumdia', 'মাসুমদিয়া', 2, 13, 117, 9959, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:38'),
(1073, 'Dhalar Char', 'ঢালার চর', 2, 13, 117, 9960, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:39'),
(1074, 'Majhpara', 'মাজপাড়া', 2, 13, 118, 9961, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:41'),
(1075, 'Chandba', 'চাঁদভা', 2, 13, 118, 9962, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:43'),
(1076, 'Debottar', 'দেবোত্তর', 2, 13, 118, 9963, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:44'),
(1077, 'Ekdanta', 'একদন্ত', 2, 13, 118, 9964, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:46'),
(1078, 'Laxshmipur', 'লক্ষীপুর', 2, 13, 118, 9965, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:47'),
(1079, 'Handial', 'হান্ডিয়াল', 2, 13, 119, 9966, 1, 1, 1, '2021-02-13 15:17:47', '2023-02-22 02:50:49'),
(1080, 'Chhaikola', 'ছাইকোলা', 2, 13, 119, 9967, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:50'),
(1081, 'Nimaichara', 'নিমাইচড়া', 2, 13, 119, 9968, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:52'),
(1082, 'Gunaigachha', 'গুনাইগাছা', 2, 13, 119, 9969, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:53'),
(1083, 'Parshadanga', 'পার্শ্বডাঙ্গা', 2, 13, 119, 9970, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:55'),
(1084, 'Failjana', 'ফৈলজানা', 2, 13, 119, 9971, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:56'),
(1085, 'Mulgram', 'মুলগ্রাম', 2, 13, 119, 9972, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:58'),
(1086, 'Haripur', 'হরিপুর', 2, 13, 119, 9973, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:50:59'),
(1087, 'Mothurapur', 'মথুরাপুর', 2, 13, 119, 9974, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:01'),
(1088, 'Bilchalan', 'বিলচলন', 2, 13, 119, 9975, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:02'),
(1089, 'Danthia Bamangram', 'দাতিয়া বামনগ্রাম', 2, 13, 119, 9976, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:04'),
(1090, 'Nagdemra', 'নাগডেমড়া', 2, 13, 120, 9977, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:05'),
(1091, 'Dhulauri', 'ধুলাউড়ি', 2, 13, 120, 9978, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:07'),
(1092, 'Bhulbaria', 'ভুলবাড়ীয়া', 2, 13, 120, 9979, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:08'),
(1093, 'Dhopadaha', 'ধোপাদহ', 2, 13, 120, 9980, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:10'),
(1094, 'Karamja', 'করমজা', 2, 13, 120, 9981, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:12'),
(1095, 'Kashinathpur', 'কাশিনাথপুর', 2, 13, 120, 9982, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:13'),
(1096, 'Gaurigram', 'গৌরীগ্রাম', 2, 13, 120, 9983, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:15'),
(1097, 'Nandanpur', 'নন্দনপুর', 2, 13, 120, 9984, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:16'),
(1098, 'Khetupara', 'ক্ষেতুপাড়া', 2, 13, 120, 9985, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:18'),
(1099, 'Ar-Ataikula', 'আর-আতাইকুলা', 2, 13, 120, 9986, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:19'),
(1100, 'Brilahiribari', 'বৃলাহিড়ীবাড়ী', 2, 13, 121, 9987, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:21'),
(1101, 'Pungali', 'পুঙ্গুলি', 2, 13, 121, 9988, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:22'),
(1102, 'Faridpur', 'ফরিদপুর', 2, 13, 121, 9989, 1, 1, 1, '2021-02-13 15:17:48', '2023-02-22 02:51:24'),
(1103, 'Hadal', 'হাদল', 2, 13, 121, 9990, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:25'),
(1104, 'Banwarinagar', 'বনওয়ারীনগর', 2, 13, 121, 9991, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:27'),
(1105, 'Demra', 'ডেমড়া', 2, 13, 121, 9992, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:28'),
(1106, 'Birkedar', 'বীরকেদার', 2, 14, 122, 9993, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:30'),
(1107, 'Kalai', 'কালাই', 2, 14, 122, 9994, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:31'),
(1108, 'Paikar', 'পাইকড়', 2, 14, 122, 9995, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:33'),
(1109, 'Narhatta', 'নারহট্ট', 2, 14, 122, 9996, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:34'),
(1110, 'Murail', 'মুরইল', 2, 14, 122, 9997, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:36'),
(1111, 'Kahaloo', 'কাহালু', 2, 14, 122, 9998, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:37'),
(1112, 'Durgapur', 'দূর্গাপুর', 2, 14, 122, 9999, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:39'),
(1113, 'Jamgaon', 'জামগ্রাম', 2, 14, 122, 10000, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:40'),
(1114, 'Malancha', 'মালঞ্চা', 2, 14, 122, 10001, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:42'),
(1115, 'Fapore', 'ফাঁপোর', 2, 14, 123, 10002, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:44'),
(1116, 'Shabgram', 'সাবগ্রাম', 2, 14, 123, 10003, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:45'),
(1117, 'Nishindara', 'নিশিন্দারা', 2, 14, 123, 10004, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:47'),
(1118, 'Erulia', 'এরুলিয়া', 2, 14, 123, 10005, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:48'),
(1119, 'Rajapur', 'রাজাপুর', 2, 14, 123, 10006, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:50'),
(1120, 'Shakharia', 'শাখারিয়া', 2, 14, 123, 10007, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:51'),
(1121, 'Sekherkola', 'শেখেরকোলা', 2, 14, 123, 10008, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:53'),
(1122, 'Gokul', 'গোকুল', 2, 14, 123, 10009, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:54'),
(1123, 'Noongola', 'নুনগোলা', 2, 14, 123, 10010, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:56'),
(1124, 'Lahiripara', 'লাহিড়ীপাড়া', 2, 14, 123, 10011, 1, 1, 1, '2021-02-13 15:17:49', '2023-02-22 02:51:57'),
(1125, 'Namuja', 'নামুজা', 2, 14, 123, 10012, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:51:59'),
(1126, 'Sariakandi Sadar', 'সারিয়াকান্দি সদর', 2, 14, 124, 10013, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:00'),
(1127, 'Narchi', 'নারচী', 2, 14, 124, 10014, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:02'),
(1128, 'Bohail', 'বোহাইল', 2, 14, 124, 10015, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:04'),
(1129, 'Chaluabari', 'চালুয়াবাড়ী', 2, 14, 124, 10016, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:05'),
(1130, 'Chandanbaisha', 'চন্দনবাইশা', 2, 14, 124, 10017, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:07'),
(1131, 'Hatfulbari', 'হাটফুলবাড়ী', 2, 14, 124, 10018, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:08'),
(1132, 'Hatsherpur', 'হাটশেরপুর', 2, 14, 124, 10019, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:10'),
(1133, 'Karnibari', 'কর্ণিবাড়ী', 2, 14, 124, 10020, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:11'),
(1134, 'Kazla', 'কাজলা', 2, 14, 124, 10021, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:13'),
(1135, 'Kutubpur', 'কুতুবপুর', 2, 14, 124, 10022, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:14'),
(1136, 'Kamalpur', 'কামালপুর', 2, 14, 124, 10023, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:16'),
(1137, 'Bhelabari', 'ভেলাবাড়ী', 2, 14, 124, 10024, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:17'),
(1138, 'Asekpur', 'আশেকপুর', 2, 14, 125, 10025, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:19'),
(1139, 'Madla', 'মাদলা', 2, 14, 125, 10026, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:20'),
(1140, 'Majhira', 'মাঝিড়া', 2, 14, 125, 10027, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:22'),
(1141, 'Aria', 'আড়িয়া', 2, 14, 125, 10028, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:24'),
(1142, 'Kharna', 'খরনা', 2, 14, 125, 10029, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:25'),
(1143, 'Khottapara', 'খোট্টাপাড়া', 2, 14, 125, 10030, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:27'),
(1144, 'Chopinagar', 'চোপিনগর', 2, 14, 125, 10031, 1, 1, 1, '2021-02-13 15:17:50', '2023-02-22 02:52:28'),
(1145, 'Amrul', 'আমরুল', 2, 14, 125, 10032, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:30'),
(1146, 'Gohail', 'গোহাইল', 2, 14, 125, 10033, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:31'),
(1147, 'Zianagar', 'জিয়ানগর', 2, 14, 126, 10034, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:33'),
(1148, 'Chamrul', 'চামরুল', 2, 14, 126, 10035, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:34'),
(1149, 'Dupchanchia', 'দুপচাঁচিয়া', 2, 14, 126, 10036, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:36'),
(1150, 'Gunahar', 'গুনাহার', 2, 14, 126, 10037, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:37'),
(1151, 'Gobindapur', 'গোবিন্দপুর', 2, 14, 126, 10038, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:39'),
(1152, 'Talora', 'তালোড়া', 2, 14, 126, 10039, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:41'),
(1153, 'Chhatiangram', 'ছাতিয়ানগ্রাম', 2, 14, 127, 10040, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:42'),
(1154, 'Nasaratpur', 'নশরতপুর', 2, 14, 127, 10041, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:44'),
(1155, 'Adamdighi', 'আদমদিঘি', 2, 14, 127, 10042, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:45'),
(1156, 'Kundagram', 'কুন্দগ্রাম', 2, 14, 127, 10043, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:47'),
(1157, 'Chapapur', 'চাঁপাপুর', 2, 14, 127, 10044, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:48'),
(1158, 'Shantahar', 'সান্তাহার', 2, 14, 127, 10045, 1, 1, 1, '2021-02-13 15:17:51', '2023-02-22 02:52:50'),
(1159, 'Burail', 'বুড়ইল', 2, 14, 128, 10046, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:51'),
(1160, 'Nandigram', 'নন্দিগ্রাম', 2, 14, 128, 10047, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:53'),
(1161, 'Bhatra', 'ভাটরা', 2, 14, 128, 10048, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:54'),
(1162, 'Thalta Majhgram', 'থালতা মাঝগ্রাম', 2, 14, 128, 10049, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:56'),
(1163, 'Bhatgram', 'ভাটগ্রাম', 2, 14, 128, 10050, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:57'),
(1164, 'Sonatala', 'সোনাতলা', 2, 14, 129, 10051, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:52:59'),
(1165, 'Balua', 'বালুয়া', 2, 14, 129, 10052, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:00'),
(1166, 'Zorgacha', 'জোড়গাছা', 2, 14, 129, 10053, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:02'),
(1167, 'Digdair', 'দিগদাইড়', 2, 14, 129, 10054, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:04'),
(1168, 'Madhupur', 'মধুপুর', 2, 14, 129, 10055, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:05'),
(1169, 'Pakulla', 'পাকুল্ল্যা', 2, 14, 129, 10056, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:07'),
(1170, 'Tekani Chukinagar', 'তেকানী চুকাইনগর', 2, 14, 129, 10057, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:08'),
(1171, 'Nimgachi', 'নিমগাছি', 2, 14, 130, 10058, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:10'),
(1172, 'Kalerpara', 'কালেরপাড়া', 2, 14, 130, 10059, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:11'),
(1173, 'Chikashi', 'চিকাশী', 2, 14, 130, 10060, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:13'),
(1174, 'Gossainbari', 'গোসাইবাড়ী', 2, 14, 130, 10061, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:14'),
(1175, 'Bhandarbari', 'ভান্ডারবাড়ী', 2, 14, 130, 10062, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:16'),
(1176, 'Gopalnagar', '১গোপালনগর', 2, 14, 130, 10063, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:17'),
(1177, 'Mothurapur', 'মথুরাপুর', 2, 14, 130, 10064, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:19'),
(1178, 'Chowkibari', 'চৌকিবাড়ী', 2, 14, 130, 10065, 1, 1, 1, '2021-02-13 15:17:52', '2023-02-22 02:53:20'),
(1179, 'Elangi', 'এলাঙ্গী', 2, 14, 130, 10066, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:22'),
(1180, 'Dhunat Sadar', 'ধুনট সদর', 2, 14, 130, 10067, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:23'),
(1181, 'Baliadighi', 'বালিয়া দিঘী', 2, 14, 131, 10068, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:25'),
(1182, 'Dakshinpara', 'দক্ষিণপাড়া', 2, 14, 131, 10069, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:26'),
(1183, 'Durgahata', 'দুর্গাহাটা', 2, 14, 131, 10070, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:28'),
(1184, 'Kagail', 'কাগইল', 2, 14, 131, 10071, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:29'),
(1185, 'Sonarai', 'সোনারায়', 2, 14, 131, 10072, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:31'),
(1186, 'Rameshwarpur', 'রামেশ্বরপুর', 2, 14, 131, 10073, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:32'),
(1187, 'Naruamala', 'নাড়ুয়ামালা', 2, 14, 131, 10074, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:34'),
(1188, 'Nepaltali', 'নেপালতলী', 2, 14, 131, 10075, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:36'),
(1189, 'Gabtali', 'গাবতলি', 2, 14, 131, 10076, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:37'),
(1190, 'Mahishaban', 'মহিষাবান', 2, 14, 131, 10077, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:39'),
(1191, 'Nasipur', 'নশিপুর', 2, 14, 131, 10078, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:40'),
(1192, 'Mirzapur', 'মির্জাপুর', 2, 14, 132, 10079, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:42'),
(1193, 'Khamarkandi', 'খামারকান্দি', 2, 14, 132, 10080, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:43'),
(1194, 'Garidaha', 'গাড়িদহ', 2, 14, 132, 10081, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:45'),
(1195, 'Kusumbi', 'কুসুম্বী', 2, 14, 132, 10082, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:46'),
(1196, 'Bishalpur', 'বিশালপুর', 2, 14, 132, 10083, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:48'),
(1197, 'Shimabari', 'সীমাবাড়ি', 2, 14, 132, 10084, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:49'),
(1198, 'Shahbondegi', 'শাহবন্দেগী', 2, 14, 132, 10085, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:51'),
(1199, 'Sughat', 'সুঘাট', 2, 14, 132, 10086, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:52'),
(1200, 'Khanpur', 'খানপুর', 2, 14, 132, 10087, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:54'),
(1201, 'Bhabanipur', 'ভবানীপুর', 2, 14, 132, 10088, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:56'),
(1202, 'Moidanhatta', 'ময়দানহাট্টা', 2, 14, 133, 10089, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:57'),
(1203, 'Kichok', 'কিচক', 2, 14, 133, 10090, 1, 1, 1, '2021-02-13 15:17:53', '2023-02-22 02:53:59'),
(1204, 'Atmul', 'আটমূল', 2, 14, 133, 10091, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:00'),
(1205, 'Pirob', 'পিরব', 2, 14, 133, 10092, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:02'),
(1206, 'Majhihatta', 'মাঝিহট্ট', 2, 14, 133, 10093, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:03'),
(1207, 'Buriganj', 'বুড়িগঞ্জ', 2, 14, 133, 10094, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:05'),
(1208, 'Bihar', 'বিহার', 2, 14, 133, 10095, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:06'),
(1209, 'Shibganj', 'শিবগঞ্জ', 2, 14, 133, 10096, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:08'),
(1210, 'Deuly', 'দেউলি', 2, 14, 133, 10097, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:09'),
(1211, 'Sayedpur', 'সৈয়দপুর', 2, 14, 133, 10098, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:11'),
(1212, 'Mokamtala', 'মোকামতলা', 2, 14, 133, 10099, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:12'),
(1213, 'Raynagar', 'রায়নগর', 2, 14, 133, 10100, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:14'),
(1214, 'Darsanpara', 'দর্শনপাড়া', 2, 15, 134, 10101, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:15'),
(1215, 'Hujuripara', 'হুজুরী পাড়া', 2, 15, 134, 10102, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:17'),
(1216, 'Damkura', 'দামকুড়া', 2, 15, 134, 10103, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:18'),
(1217, 'Horipur', 'হরিপুর', 2, 15, 134, 10104, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:20'),
(1218, 'Horogram', 'হড়গ্রাম', 2, 15, 134, 10105, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:21'),
(1219, 'Harian', 'হরিয়ান', 2, 15, 134, 10106, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:23'),
(1220, 'Borgachi', 'বড়্গাছি', 2, 15, 134, 10107, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:25'),
(1221, 'Parila', 'পারিলা', 2, 15, 134, 10108, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:26'),
(1222, 'Naopara', 'নওপাড়া', 2, 15, 135, 10109, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:28'),
(1223, 'Kismatgankoir', 'কিসমতগণকৈড়', 2, 15, 135, 10110, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:29'),
(1224, 'Pananagar', 'পানানগর', 2, 15, 135, 10111, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:31'),
(1225, 'Deluabari', 'দেলুয়াবাড়ী', 2, 15, 135, 10112, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:32'),
(1226, 'Jhaluka', 'ঝালুকা', 2, 15, 135, 10113, 1, 1, 1, '2021-02-13 15:17:54', '2023-02-22 02:54:34'),
(1227, 'Maria', 'মাড়িয়া', 2, 15, 135, 10114, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:35'),
(1228, 'Joynogor', 'জয়নগর', 2, 15, 135, 10115, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:37'),
(1229, 'Dhuroil', 'ধুরইল', 2, 15, 136, 10116, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:38'),
(1230, 'Ghasigram', 'ঘষিগ্রাম', 2, 15, 136, 10117, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:40'),
(1231, 'Raighati', 'রায়ঘাটি', 2, 15, 136, 10118, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:42'),
(1232, 'Mougachi', 'মৌগাছি', 2, 15, 136, 10119, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:44'),
(1233, 'Baksimoil', 'বাকশিমইল', 2, 15, 136, 10120, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:45'),
(1234, 'Jahanabad', 'জাহানাবাদ', 2, 15, 136, 10121, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:47'),
(1235, 'Yousufpur', 'ইউসুফপুর', 2, 15, 137, 10122, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:48'),
(1236, 'Solua', 'শলুয়া', 2, 15, 137, 10123, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:50'),
(1237, 'Sardah', 'সরদহ', 2, 15, 137, 10124, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:52'),
(1238, 'Nimpara', 'নিমপাড়া', 2, 15, 137, 10125, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:53'),
(1239, 'Charghat', 'চারঘাট', 2, 15, 137, 10126, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:55'),
(1240, 'Vialuxmipur', 'ভায়ালক্ষ্মীপুর', 2, 15, 137, 10127, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:56'),
(1241, 'Puthia', 'পুঠিয়া', 2, 15, 138, 10128, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:58'),
(1242, 'Belpukuria', 'বেলপুকুরিয়া', 2, 15, 138, 10129, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:54:59'),
(1243, 'Baneswar', 'বানেশ্বর', 2, 15, 138, 10130, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:01'),
(1244, 'Valukgachi', 'ভালুক গাছি', 2, 15, 138, 10131, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:03'),
(1245, 'Shilmaria', 'শিলমাড়িয়া', 2, 15, 138, 10132, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:04'),
(1246, 'Jewpara', 'জিউপাড়া', 2, 15, 138, 10133, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:06'),
(1247, 'Bajubagha', 'বাজুবাঘা', 2, 15, 139, 10134, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:07'),
(1248, 'Gorgori', 'গড়গড়ি', 2, 15, 139, 10135, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:09'),
(1249, 'Pakuria', 'পাকুড়িয়া', 2, 15, 139, 10136, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:11'),
(1250, 'Monigram', 'মনিগ্রাম', 2, 15, 139, 10137, 1, 1, 1, '2021-02-13 15:17:55', '2023-02-22 02:55:13'),
(1251, 'Bausa', 'বাউসা', 2, 15, 139, 10138, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:14'),
(1252, 'Arani', 'আড়ানী', 2, 15, 139, 10139, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:16'),
(1253, 'Godagari', 'গোদাগাড়ী', 2, 15, 140, 10140, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:17'),
(1254, 'Mohonpur', 'মোহনপুর', 2, 15, 140, 10141, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:19'),
(1255, 'Pakri', 'পাকড়ী', 2, 15, 140, 10142, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:21'),
(1256, 'Risikul', 'রিশিকুল', 2, 15, 140, 10143, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:22'),
(1257, 'Gogram', 'গোগ্রাম', 2, 15, 140, 10144, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:24'),
(1258, 'Matikata', 'মাটিকাটা', 2, 15, 140, 10145, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:26'),
(1259, 'Dewpara', 'দেওপাড়া', 2, 15, 140, 10146, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:27'),
(1260, 'Basudebpur', 'বাসুদেবপুর', 2, 15, 140, 10147, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:29'),
(1261, 'Asariadaha', 'আষাড়িয়াদহ', 2, 15, 140, 10148, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:31'),
(1262, 'Kalma', 'কলমা', 2, 15, 141, 10149, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:32'),
(1263, 'Badhair', 'বাধাইড়', 2, 15, 141, 10150, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:34'),
(1264, 'Panchandar', 'পাঁচন্দর', 2, 15, 141, 10151, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:36'),
(1265, 'Saranjai', 'সরঞ্জাই', 2, 15, 141, 10152, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:37'),
(1266, 'Talondo', 'তালন্দ', 2, 15, 141, 10153, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:39'),
(1267, 'Kamargaon', 'কামারগাঁ', 2, 15, 141, 10154, 1, 1, 1, '2021-02-13 15:17:56', '2023-02-22 02:55:41'),
(1268, 'Chanduria', 'চান্দুড়িয়া', 2, 15, 141, 10155, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:42'),
(1269, 'Gobindopara', 'গোবিন্দপাড়া', 2, 15, 142, 10156, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:44'),
(1270, 'Nordas', 'নরদাস', 2, 15, 142, 10157, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:46'),
(1271, 'Dippur', 'দ্বীপপুর', 2, 15, 142, 10158, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:47'),
(1272, 'Borobihanoli', 'বড়বিহানলী', 2, 15, 142, 10159, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:49'),
(1273, 'Auchpara', 'আউচপাড়া', 2, 15, 142, 10160, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:50'),
(1274, 'Sreepur', 'শ্রীপুর', 2, 15, 142, 10161, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:52'),
(1275, 'Basupara', 'বাসুপাড়া', 2, 15, 142, 10162, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:53'),
(1276, 'Kacharikoalipara', 'কাচাড়ী কোয়লিপাড়া', 2, 15, 142, 10163, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:55'),
(1277, 'Suvodanga', 'শুভডাঙ্গা', 2, 15, 142, 10164, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:56'),
(1278, 'Mariaup', 'মাড়িয়া', 2, 15, 142, 10165, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:55:58'),
(1279, 'Ganipur', 'গণিপুর', 2, 15, 142, 10166, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:00'),
(1280, 'Zhikara', 'ঝিকড়া', 2, 15, 142, 10167, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:01'),
(1281, 'Gualkandi', 'গোয়ালকান্দি', 2, 15, 142, 10168, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:03'),
(1282, 'Hamirkutsa', 'হামিরকুৎসা', 2, 15, 142, 10169, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:04'),
(1283, 'Jogipara', 'যোগিপাড়া', 2, 15, 142, 10170, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:06'),
(1284, 'Sonadanga', 'সোনাডাঙ্গা', 2, 15, 142, 10171, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:07'),
(1285, 'Brahmapur', 'ব্রহ্মপুর', 2, 16, 143, 10172, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:09'),
(1286, 'Madhnagar', 'মাধনগর', 2, 16, 143, 10173, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:10'),
(1287, 'Khajura', 'খাজুরা', 2, 16, 143, 10174, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:12'),
(1288, 'Piprul', 'পিপরুল', 2, 16, 143, 10175, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:14'),
(1289, 'Biprobelghoria', 'বিপ্রবেলঘড়িয়া', 2, 16, 143, 10176, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:15'),
(1290, 'Chhatni', 'ছাতনী', 2, 16, 143, 10177, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:17'),
(1291, 'Tebaria', 'তেবাড়িয়া', 2, 16, 143, 10178, 1, 1, 1, '2021-02-13 15:17:57', '2023-02-22 02:56:18'),
(1292, 'Dighapatia', 'দিঘাপতিয়া', 2, 16, 143, 10179, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:20'),
(1293, 'Luxmipurkholabaria', 'লক্ষীপুর খোলাবাড়িয়া', 2, 16, 143, 10180, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:22'),
(1294, 'Barahorispur', 'বড়হরিশপুর', 2, 16, 143, 10181, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:23'),
(1295, 'Kaphuria', 'কাফুরিয়া', 2, 16, 143, 10182, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:25'),
(1296, 'Halsa', 'হালসা', 2, 16, 143, 10183, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:26'),
(1297, 'Sukash', 'শুকাশ', 2, 16, 144, 10184, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:28'),
(1298, 'Dahia', 'ডাহিয়া', 2, 16, 144, 10185, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:29'),
(1299, 'Italy', 'ইটালী', 2, 16, 144, 10186, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:31'),
(1300, 'Kalam', 'কলম', 2, 16, 144, 10187, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:32'),
(1301, 'Chamari', 'চামারী', 2, 16, 144, 10188, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:34'),
(1302, 'Hatiandaha', 'হাতিয়ানদহ', 2, 16, 144, 10189, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:36'),
(1303, 'Lalore', 'লালোর', 2, 16, 144, 10190, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:37'),
(1304, 'Sherkole', 'শেরকোল', 2, 16, 144, 10191, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:39'),
(1305, 'Tajpur', 'তাজপুর', 2, 16, 144, 10192, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:40'),
(1306, 'Chaugram', 'চৌগ্রাম', 2, 16, 144, 10193, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:42'),
(1307, 'Chhatardighi', 'ছাতারদিঘী', 2, 16, 144, 10194, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:43'),
(1308, 'Ramanandakhajura', 'রামান্দখাজুরা', 2, 16, 144, 10195, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:45'),
(1309, 'Joari', 'জোয়াড়ী', 2, 16, 145, 10196, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:47'),
(1310, 'Baraigram', 'বড়াইগ্রাম', 2, 16, 145, 10197, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:48'),
(1311, 'Zonail', 'জোনাইল', 2, 16, 145, 10198, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:50'),
(1312, 'Nagor', 'নগর', 2, 16, 145, 10199, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:51'),
(1313, 'Majgoan', 'মাঝগাও', 2, 16, 145, 10200, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:53'),
(1314, 'Gopalpur', 'গোপালপুর', 2, 16, 145, 10201, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:55'),
(1315, 'Chandai', 'চান্দাই', 2, 16, 145, 10202, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:56'),
(1316, 'Panka', 'পাঁকা', 2, 16, 146, 10203, 1, 1, 1, '2021-02-13 15:17:58', '2023-02-22 02:56:58'),
(1317, 'Jamnagor', 'জামনগর', 2, 16, 146, 10204, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:56:59'),
(1318, 'Bagatipara', 'বাগাতিপাড়া', 2, 16, 146, 10205, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:01'),
(1319, 'Dayarampur', 'দয়ারামপুর', 2, 16, 146, 10206, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:02'),
(1320, 'Faguardiar', 'ফাগুয়ারদিয়াড়', 2, 16, 146, 10207, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:04'),
(1321, 'Lalpur', 'লালপুর', 2, 16, 147, 10208, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:05'),
(1322, 'Iswardi', 'ঈশ্বরদী', 2, 16, 147, 10209, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:07'),
(1323, 'Chongdhupoil', 'চংধুপইল', 2, 16, 147, 10210, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:09'),
(1324, 'Arbab', 'আড়বাব', 2, 16, 147, 10211, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:10'),
(1325, 'Bilmaria', 'বিলমাড়িয়া', 2, 16, 147, 10212, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:13'),
(1326, 'Duaria', 'দুয়ারিয়া', 2, 16, 147, 10213, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:15'),
(1327, 'Oalia', 'ওয়ালিয়া', 2, 16, 147, 10214, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:17'),
(1328, 'Durduria', 'দুড়দুরিয়া', 2, 16, 147, 10215, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:18'),
(1329, 'Arjunpur', 'অর্জুনপুর বরমহাটী', 2, 16, 147, 10216, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:20'),
(1330, 'Kadimchilan', 'কদিমচিলান', 2, 16, 147, 10217, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:22'),
(1331, 'Nazirpur', 'নাজিরপুর', 2, 16, 148, 10218, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:24'),
(1332, 'Biaghat', 'বিয়াঘাট', 2, 16, 148, 10219, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:27'),
(1333, 'Khubjipur', 'খুবজীপুর', 2, 16, 148, 10220, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:28'),
(1334, 'Dharabarisha', 'ধারাবারিষা', 2, 16, 148, 10221, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:30'),
(1335, 'Moshindha', 'মসিন্দা', 2, 16, 148, 10222, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:32'),
(1336, 'Chapila', 'চাপিলা', 2, 16, 148, 10223, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:33'),
(1337, 'Rukindipur', 'রুকিন্দীপুর', 2, 17, 150, 10224, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:35'),
(1338, 'Sonamukhi', 'সোনামূখী', 2, 17, 150, 10225, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:36'),
(1339, 'Tilakpur', 'তিলকপুর', 2, 17, 150, 10226, 1, 1, 1, '2021-02-13 15:17:59', '2023-02-22 02:57:38'),
(1340, 'Raikali', 'রায়কালী', 2, 17, 150, 10227, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:39'),
(1341, 'Gopinathpur', 'গোপীনাথপুর', 2, 17, 150, 10228, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:41'),
(1342, 'Matrai', 'মাত্রাই', 2, 17, 151, 10229, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:43'),
(1343, 'Ahammedabad', 'আহম্মেদাবাদ', 2, 17, 151, 10230, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:45'),
(1344, 'Punot', 'পুনট', 2, 17, 151, 10231, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:46'),
(1345, 'Zindarpur', 'জিন্দারপুর', 2, 17, 151, 10232, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:48'),
(1346, 'Udaipur', 'উদয়পুর', 2, 17, 151, 10233, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:50'),
(1347, 'Alampur', 'আলমপুর', 2, 17, 152, 10234, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:51'),
(1348, 'Borail', 'বড়াইল', 2, 17, 152, 10235, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:53'),
(1349, 'Tulshiganga', ' তুলশীগংগা', 2, 17, 152, 10236, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:55'),
(1350, 'Mamudpur', 'মামুদপুর', 2, 17, 152, 10237, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:56'),
(1351, 'Boratara', 'বড়তারা', 2, 17, 152, 10238, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:58'),
(1352, 'Bagjana', 'বাগজানা', 2, 17, 153, 10239, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:57:59'),
(1353, 'Dharanji', 'ধরঞ্জি', 2, 17, 153, 10240, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:02'),
(1354, 'Aymarasulpur', 'আয়মারসুলপুর', 2, 17, 153, 10241, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:03'),
(1355, 'Balighata', 'বালিঘাটা', 2, 17, 153, 10242, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:05'),
(1356, 'Atapur', 'আটাপুর', 2, 17, 153, 10243, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:07'),
(1357, 'Mohammadpur', 'মোহাম্মদপুর', 2, 17, 153, 10244, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:09'),
(1358, 'Aolai', 'আওলাই', 2, 17, 153, 10245, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:12'),
(1359, 'Kusumba', 'কুসুম্বা', 2, 17, 153, 10246, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:14'),
(1360, 'Amdai', 'আমদই', 2, 17, 154, 10247, 1, 1, 1, '2021-02-13 15:18:00', '2023-02-22 02:58:18'),
(1361, 'Bamb', 'বম্বু', 2, 17, 154, 10248, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:20'),
(1362, 'Dogachi', 'দোগাছি', 2, 17, 154, 10249, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:22'),
(1363, 'Puranapail', 'পুরানাপৈল', 2, 17, 154, 10250, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:24'),
(1364, 'Jamalpur', 'জামালপুর', 2, 17, 154, 10251, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:26'),
(1365, 'Chakborkat', 'চকবরকত', 2, 17, 154, 10252, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:27'),
(1366, 'Mohammadabad', 'মোহাম্মদাবাদ', 2, 17, 154, 10253, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:30'),
(1367, 'Dhalahar', 'ধলাহার', 2, 17, 154, 10254, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:31'),
(1368, 'Bhadsha', 'ভাদসা', 2, 17, 154, 10255, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:33'),
(1369, 'Alatuli', 'আলাতুলী', 2, 18, 155, 10256, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:35'),
(1370, 'Baroghoria', 'বারঘরিয়া', 2, 18, 155, 10257, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:36'),
(1371, 'Moharajpur', 'মহারাজপুর', 2, 18, 155, 10258, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:38'),
(1372, 'Ranihati', 'রানীহাটি', 2, 18, 155, 10259, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:40'),
(1373, 'Baliadanga', 'বালিয়াডাঙ্গা', 2, 18, 155, 10260, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:41'),
(1374, 'Gobratola', 'গোবরাতলা', 2, 18, 155, 10261, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:43'),
(1375, 'Jhilim', 'ঝিলিম', 2, 18, 155, 10262, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:44'),
(1376, 'Char Anupnagar', 'চর অনুপনগর', 2, 18, 155, 10263, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:46'),
(1377, 'Debinagar', 'দেবীনগর', 2, 18, 155, 10264, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:47'),
(1378, 'Shahjahanpur', 'শাহজাহানপুর', 2, 18, 155, 10265, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:50'),
(1379, 'Islampur', 'ইসলামপুর', 2, 18, 155, 10266, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:52'),
(1380, 'Charbagdanga', 'চরবাগডাঙ্গা', 2, 18, 155, 10267, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:54'),
(1381, 'Narayanpur', 'নারায়নপুর', 2, 18, 155, 10268, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:56'),
(1382, 'Sundarpur', 'সুন্দরপুর', 2, 18, 155, 10269, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:58'),
(1383, 'Radhanagar', 'রাধানগর', 2, 18, 156, 10270, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:58:59'),
(1384, 'Rahanpur', 'রহনপুর', 2, 18, 156, 10271, 1, 1, 1, '2021-02-13 15:18:01', '2023-02-22 02:59:02'),
(1385, 'Boalia', 'বোয়ালিয়া', 2, 18, 156, 10272, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:04'),
(1386, 'Bangabari', 'বাঙ্গাবাড়ী', 2, 18, 156, 10273, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:06'),
(1387, 'Parbotipur', 'পার্বতীপুর', 2, 18, 156, 10274, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:07'),
(1388, 'Chowdala', 'চৌডালা', 2, 18, 156, 10275, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:09'),
(1389, 'Gomostapur', 'গোমস্তাপুর', 2, 18, 156, 10276, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:11'),
(1390, 'Alinagar', 'আলীনগর', 2, 18, 156, 10277, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:13'),
(1391, 'Fhotepur', 'ফতেপুর', 2, 18, 157, 10278, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:14'),
(1392, 'Kosba', 'কসবা', 2, 18, 157, 10279, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:16'),
(1393, 'Nezampur', 'নেজামপুর', 2, 18, 157, 10280, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:17'),
(1394, 'Nachol', 'নাচোল', 2, 18, 157, 10281, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:19'),
(1395, 'Bholahat', 'ভোলাহাট', 2, 18, 158, 10282, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:20'),
(1396, 'Jambaria', 'জামবাড়িয়া', 2, 18, 158, 10283, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:22'),
(1397, 'Gohalbari', 'গোহালবাড়ী', 2, 18, 158, 10284, 1, 1, 1, '2021-02-13 15:18:02', '2023-02-22 02:59:24'),
(1398, 'Daldoli', 'দলদলী', 2, 18, 158, 10285, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:25'),
(1399, 'Binodpur', 'বিনোদপুর', 2, 18, 159, 10286, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:27'),
(1400, 'Chakkirti', 'চককির্তী', 2, 18, 159, 10287, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:28'),
(1401, 'Daipukuria', 'দাইপুকুরিয়া', 2, 18, 159, 10288, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:30'),
(1402, 'Dhainagar', 'ধাইনগর', 2, 18, 159, 10289, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:31'),
(1403, 'Durlovpur', 'দুর্লভপুর', 2, 18, 159, 10290, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:33'),
(1404, 'Ghorapakhia', 'ঘোড়াপাখিয়া', 2, 18, 159, 10291, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:35'),
(1405, 'Mobarakpur', 'মোবারকপুর', 2, 18, 159, 10292, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:36'),
(1406, 'Monakasha', 'মনাকষা', 2, 18, 159, 10293, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:38'),
(1407, 'Noyalavanga', 'নয়ালাভাঙ্গা', 2, 18, 159, 10294, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:39'),
(1408, 'Panka', 'পাঁকা', 2, 18, 159, 10295, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:41'),
(1409, 'Chatrajitpur', 'ছত্রাজিতপুর', 2, 18, 159, 10296, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:42'),
(1410, 'Shahabajpur', 'শাহাবাজপুর', 2, 18, 159, 10297, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:44'),
(1411, 'Shyampur', 'শ্যামপুর', 2, 18, 159, 10298, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:45'),
(1412, 'Kansat', 'কানসাট', 2, 18, 159, 10299, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:47'),
(1413, 'Ujirpur', 'উজিরপুর', 2, 18, 159, 10300, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:48'),
(1414, '1nomohadevpur', 'মহাদেবপুর', 2, 19, 160, 10301, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:50'),
(1415, 'Hatur', 'হাতুড়', 2, 19, 160, 10302, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:51'),
(1416, 'Khajur', 'খাজুর', 2, 19, 160, 10303, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:53'),
(1417, 'Chandas', 'চাঁন্দাশ', 2, 19, 160, 10304, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:54'),
(1418, 'Enayetpur', 'এনায়েতপুর', 2, 19, 160, 10305, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:56'),
(1419, 'Sofapur', 'সফাপুর', 2, 19, 160, 10306, 1, 1, 1, '2021-02-13 15:18:03', '2023-02-22 02:59:58'),
(1420, 'Uttargram', 'উত্তরগ্রাম', 2, 19, 160, 10307, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 02:59:59'),
(1421, 'Cheragpur', 'চেরাগপুর', 2, 19, 160, 10308, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:01'),
(1422, 'Vimpur', 'ভীমপুর', 2, 19, 160, 10309, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:03'),
(1423, 'Roygon', 'রাইগাঁ', 2, 19, 160, 10310, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:04'),
(1424, 'Badalgachi', 'বদলগাছী', 2, 19, 161, 10311, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:06'),
(1425, 'Mothurapur', 'মথুরাপুর', 2, 19, 161, 10312, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:07'),
(1426, 'Paharpur', 'পাহারপুর', 2, 19, 161, 10313, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:09'),
(1427, 'Mithapur', 'মিঠাপুর', 2, 19, 161, 10314, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:10'),
(1428, 'Kola', 'কোলা', 2, 19, 161, 10315, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:12'),
(1429, 'Bilashbari', 'বিলাশবাড়ী', 2, 19, 161, 10316, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:13'),
(1430, 'Adhaipur', 'আধাইপুর', 2, 19, 161, 10317, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:15'),
(1431, 'Balubhara', 'বালুভরা', 2, 19, 161, 10318, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:17'),
(1432, 'Patnitala', 'পত্নীতলা', 2, 19, 162, 10319, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:19'),
(1433, 'Nirmail', 'নিমইল', 2, 19, 162, 10320, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:20'),
(1434, 'Dibar', 'দিবর', 2, 19, 162, 10321, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:22'),
(1435, 'Akbarpur', 'আকবরপুর', 2, 19, 162, 10322, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:23'),
(1436, 'Matindar', 'মাটিন্দর', 2, 19, 162, 10323, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:25'),
(1437, 'Krishnapur', 'কৃষ্ণপুর', 2, 19, 162, 10324, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:26'),
(1438, 'Patichrara', 'পাটিচড়া', 2, 19, 162, 10325, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:28'),
(1439, 'Nazipur', 'নজিপুর', 2, 19, 162, 10326, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:29'),
(1440, 'Ghasnagar', 'ঘষনগর', 2, 19, 162, 10327, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:31'),
(1441, 'Amair', 'আমাইড়', 2, 19, 162, 10328, 1, 1, 1, '2021-02-13 15:18:04', '2023-02-22 03:00:32'),
(1442, 'Shihara', 'শিহারা', 2, 19, 162, 10329, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:34'),
(1443, 'Dhamoirhat', 'ধামইরহাট', 2, 19, 163, 10330, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:36'),
(1444, 'Alampur', 'আলমপুর', 2, 19, 163, 10331, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:37'),
(1445, 'Umar', 'উমার', 2, 19, 163, 10332, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:39'),
(1446, 'Aranagar', 'আড়ানগর', 2, 19, 163, 10333, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:40'),
(1447, 'Jahanpur', 'জাহানপুর', 2, 19, 163, 10334, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:43'),
(1448, 'Isabpur', 'ইসবপুর', 2, 19, 163, 10335, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:44'),
(1449, 'Khelna', 'খেলনা', 2, 19, 163, 10336, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:46'),
(1450, 'Agradigun', 'আগ্রাদ্বিগুন', 2, 19, 163, 10337, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:47'),
(1451, 'Hajinagar', 'হাজীনগর', 2, 19, 164, 10338, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:49'),
(1452, 'Chandannagar', 'চন্দননগর', 2, 19, 164, 10339, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:51'),
(1453, 'Bhabicha', 'ভাবিচা', 2, 19, 164, 10340, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:52');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1454, 'Niamatpur', 'নিয়ামতপুর', 2, 19, 164, 10341, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:54'),
(1455, 'Rasulpur', 'রসুলপুর', 2, 19, 164, 10342, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:56'),
(1456, 'Paroil', 'পাড়ইল', 2, 19, 164, 10343, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:57'),
(1457, 'Sremantapur', 'শ্রীমন্তপুর', 2, 19, 164, 10344, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:00:59'),
(1458, 'Bahadurpur', 'বাহাদুরপুর', 2, 19, 164, 10345, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:01:00'),
(1459, 'Varsho', 'ভারশো', 2, 19, 165, 10346, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:01:02'),
(1460, 'Valain', 'ভালাইন', 2, 19, 165, 10347, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:01:03'),
(1461, 'Paranpur', 'পরানপুর', 2, 19, 165, 10348, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:01:05'),
(1462, 'Manda', 'মান্দা', 2, 19, 165, 10349, 1, 1, 1, '2021-02-13 15:18:05', '2023-02-22 03:01:06'),
(1463, 'Goneshpur', 'গনেশপুর', 2, 19, 165, 10350, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:08'),
(1464, 'Moinom', 'মৈনম', 2, 19, 165, 10351, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:10'),
(1465, 'Proshadpur', 'প্রসাদপুর', 2, 19, 165, 10352, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:11'),
(1466, 'Kosomba', 'কুসুম্বা', 2, 19, 165, 10353, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:13'),
(1467, 'Tetulia', 'তেঁতুলিয়া', 2, 19, 165, 10354, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:14'),
(1468, 'Nurullabad', 'নূরুল্যাবাদ', 2, 19, 165, 10355, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:16'),
(1469, 'Kalikapur', 'কালিকাপুর', 2, 19, 165, 10356, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:18'),
(1470, 'Kashopara', 'কাঁশোকাপুর', 2, 19, 165, 10357, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:20'),
(1471, 'Koshob', 'কশব', 2, 19, 165, 10358, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:21'),
(1472, 'Bisnopur', 'বিষ্ণপুর', 2, 19, 165, 10359, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:23'),
(1473, 'Shahagola', 'শাহাগোলা', 2, 19, 166, 10360, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:24'),
(1474, 'Bhonpara', 'ভোঁপড়া', 2, 19, 166, 10361, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:26'),
(1475, 'Ahsanganj', 'আহসানগঞ্জ', 2, 19, 166, 10362, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:28'),
(1476, 'Panchupur', 'পাঁচুপুর', 2, 19, 166, 10363, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:29'),
(1477, 'Bisha', 'বিশা', 2, 19, 166, 10364, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:31'),
(1478, 'Maniary', 'মনিয়ারী', 2, 19, 166, 10365, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:32'),
(1479, 'Kalikapur', 'কালিকাপুর', 2, 19, 166, 10366, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:34'),
(1480, 'Hatkalupara', 'হাটকালুপাড়া', 2, 19, 166, 10367, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:36'),
(1481, 'Khatteshawr', 'খট্টেশ্বর রাণীনগর', 2, 19, 167, 10368, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:38'),
(1482, 'Kashimpur', 'কাশিমপুর', 2, 19, 167, 10369, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:39'),
(1483, 'Gona', 'গোনা', 2, 19, 167, 10370, 1, 1, 1, '2021-02-13 15:18:06', '2023-02-22 03:01:41'),
(1484, 'Paroil', 'পারইল', 2, 19, 167, 10371, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:43'),
(1485, 'Borgoca', 'বরগাছা', 2, 19, 167, 10372, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:44'),
(1486, 'Kaligram', 'কালিগ্রাম', 2, 19, 167, 10373, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:46'),
(1487, 'Ekdala', 'একডালা', 2, 19, 167, 10374, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:47'),
(1488, 'Mirat', 'মিরাট', 2, 19, 167, 10375, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:49'),
(1489, 'Barshail', 'বর্ষাইল', 2, 19, 168, 10376, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:51'),
(1490, 'Kritipur', 'কির্ত্তিপুর', 2, 19, 168, 10377, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:53'),
(1491, 'Baktiarpur', 'বক্তারপুর', 2, 19, 168, 10378, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:55'),
(1492, 'Tilakpur', 'তিলোকপুর', 2, 19, 168, 10379, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:56'),
(1493, 'Hapaniya', 'হাপানিয়া', 2, 19, 168, 10380, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:58'),
(1494, 'Dubalhati', 'দুবলহাটী', 2, 19, 168, 10381, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:01:59'),
(1495, 'Boalia', 'বোয়ালিয়া', 2, 19, 168, 10382, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:01'),
(1496, 'Hashaigari', 'হাঁসাইগাড়ী', 2, 19, 168, 10383, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:03'),
(1497, 'Chandipur', 'চন্ডিপুর', 2, 19, 168, 10384, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:04'),
(1498, 'Bolihar', 'বলিহার', 2, 19, 168, 10385, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:06'),
(1499, 'Shekerpur', 'শিকারপুর', 2, 19, 168, 10386, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:08'),
(1500, 'Shailgachhi', 'শৈলগাছী', 2, 19, 168, 10387, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:09'),
(1501, 'Nitpur', 'নিতপুর', 2, 19, 169, 10388, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:11'),
(1502, 'Tetulia', 'তেঁতুলিয়া', 2, 19, 169, 10389, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:12'),
(1503, 'Chhaor', 'ছাওড়', 2, 19, 169, 10390, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:14'),
(1504, 'Ganguria', 'গাঙ্গুরিয়া', 2, 19, 169, 10391, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:15'),
(1505, 'Ghatnagar', 'ঘাটনগর', 2, 19, 169, 10392, 1, 1, 1, '2021-02-13 15:18:07', '2023-02-22 03:02:17'),
(1506, 'Moshidpur', 'মশিদপুর', 2, 19, 169, 10393, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:18'),
(1507, 'Sapahar', 'সাপাহার', 2, 19, 170, 10394, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:20'),
(1508, 'Tilna', 'তিলনা', 2, 19, 170, 10395, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:21'),
(1509, 'Aihai', 'আইহাই', 2, 19, 170, 10396, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:23'),
(1510, 'Shironti', 'শিরন্টী', 2, 19, 170, 10397, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:24'),
(1511, 'Goala', 'গোয়ালা', 2, 19, 170, 10398, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:26'),
(1512, 'Patari', 'পাতাড়ী', 2, 19, 170, 10399, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:28'),
(1513, 'Nehalpur', 'নেহালপুর', 3, 20, 171, 10400, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:29'),
(1514, 'Hariharnagar', 'হরিহরনগর', 3, 20, 171, 10401, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:31'),
(1515, 'Haridaskati', 'হরিদাসকাটি', 3, 20, 171, 10402, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:32'),
(1516, 'Shyamkur', 'শ্যামকুড়', 3, 20, 171, 10403, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:34'),
(1517, 'Rohita', 'রোহিতা', 3, 20, 171, 10404, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:36'),
(1518, 'Maswimnagar', 'মশ্মিমনগর', 3, 20, 171, 10405, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:37'),
(1519, 'Manoharpur', 'মনোহরপুর', 3, 20, 171, 10406, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:39'),
(1520, 'Manirampur', 'মনিরামপুর', 3, 20, 171, 10407, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:40'),
(1521, 'Bhojgati', 'ভোজগাতি', 3, 20, 171, 10408, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:42'),
(1522, 'Durbadanga', 'দুর্বাডাংগা', 3, 20, 171, 10409, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:43'),
(1523, 'Dhakuria', 'ঢাকুরিয়া', 3, 20, 171, 10410, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:45'),
(1524, 'Jhanpa', 'ঝাঁপা', 3, 20, 171, 10411, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:46'),
(1525, 'Chaluahati', 'চালুয়াহাটি', 3, 20, 171, 10412, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:48'),
(1526, 'Khedapara', 'খেদাপাড়া', 3, 20, 171, 10413, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:49'),
(1527, 'Khanpur', 'খানপুর', 3, 20, 171, 10414, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:51'),
(1528, 'Kultia', 'কুলটিয়া', 3, 20, 171, 10415, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:52'),
(1529, 'Kashimnagar', 'কাশিমনগর', 3, 20, 171, 10416, 1, 1, 1, '2021-02-13 15:18:08', '2023-02-22 03:02:54'),
(1530, 'Baghutia', 'বাঘুটিয়া', 3, 20, 172, 10417, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:02:55'),
(1531, 'Chalishia', 'চলিশিয়া', 3, 20, 172, 10418, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:02:57'),
(1532, 'Sundoli', 'সুন্দলী', 3, 20, 172, 10419, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:02:59'),
(1533, 'Siddhipasha', 'সিদ্দিপাশা', 3, 20, 172, 10420, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:00'),
(1534, 'Sreedharpur', 'শ্রীধরপুর', 3, 20, 172, 10421, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:02'),
(1535, 'Subharara', 'শুভরাড়া', 3, 20, 172, 10422, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:03'),
(1536, 'Prambag', 'প্রেমবাগ', 3, 20, 172, 10423, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:05'),
(1537, 'Payra', 'পায়রা', 3, 20, 172, 10424, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:06'),
(1538, 'Jaharpur', 'জহুরপুর', 3, 20, 173, 10425, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:08'),
(1539, 'Jamdia', 'জামদিয়া', 3, 20, 173, 10426, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:09'),
(1540, 'Darajhat', 'দরাজহাট', 3, 20, 173, 10427, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:11'),
(1541, 'Dhalgram', 'ধলগ্রাম', 3, 20, 173, 10428, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:12'),
(1542, 'Narikelbaria', 'নারিকেলবাড়ীয়া', 3, 20, 173, 10429, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:14'),
(1543, 'Bandabilla', 'বন্দবিলা', 3, 20, 173, 10430, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:16'),
(1544, 'Basuari', 'বাসুয়াড়ী', 3, 20, 173, 10431, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:17'),
(1545, 'Roypur', 'রায়পুর', 3, 20, 173, 10432, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:19'),
(1546, 'Dohakula', 'দোহাকুলা', 3, 20, 173, 10433, 1, 1, 1, '2021-02-13 15:18:09', '2023-02-22 03:03:20'),
(1547, 'Chougachha', 'চৌগাছা', 3, 20, 174, 10434, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:22'),
(1548, 'Jagadishpur', 'জগদীশপুর', 3, 20, 174, 10435, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:23'),
(1549, 'Dhuliani', 'ধুলিয়ানী', 3, 20, 174, 10436, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:25'),
(1550, 'Narayanpur', 'নারায়নপুর', 3, 20, 174, 10437, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:26'),
(1551, 'Patibila', 'পাতিবিলা', 3, 20, 174, 10438, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:28'),
(1552, 'Pashapole', 'পাশাপোল', 3, 20, 174, 10439, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:29'),
(1553, 'Fulsara', 'ফুলসারা', 3, 20, 174, 10440, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:31'),
(1554, 'Singhajhuli', 'সিংহঝুলি', 3, 20, 174, 10441, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:32'),
(1555, 'Sukpukhuria', 'সুখপুকুরিয়া', 3, 20, 174, 10442, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:34'),
(1556, 'Swarupdaha', 'সরুপদাহ', 3, 20, 174, 10443, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:36'),
(1557, 'Hakimpur', 'হাকিমপুর', 3, 20, 174, 10444, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:37'),
(1558, 'Gangananda', 'গংগানন্দপুর', 3, 20, 175, 10445, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:39'),
(1559, 'Gadkhali', 'গদখালী', 3, 20, 175, 10446, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:40'),
(1560, 'Jhikargachha', 'ঝিকরগাছা', 3, 20, 175, 10447, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:42'),
(1561, 'Nabharan', 'নাভারন', 3, 20, 175, 10448, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:43'),
(1562, 'Nibaskhola', 'নির্বাসখোলা', 3, 20, 175, 10449, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:45'),
(1563, 'Panisara', 'পানিসারা', 3, 20, 175, 10450, 1, 1, 1, '2021-02-13 15:18:10', '2023-02-22 03:03:46'),
(1564, 'Bankra', 'বাঁকড়া', 3, 20, 175, 10451, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:48'),
(1565, 'Shankarpur', 'শংকরপুর', 3, 20, 175, 10452, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:49'),
(1566, 'Shimulia', 'শিমুলিয়া', 3, 20, 175, 10453, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:51'),
(1567, 'Hajirbagh', 'হাজিরবাগ', 3, 20, 175, 10454, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:52'),
(1568, 'Magura', 'মাগুরা', 3, 20, 175, 10455, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:54'),
(1569, 'Sufalakati', 'সুফলাকাটি', 3, 20, 176, 10456, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:55'),
(1570, 'Sagardari', 'সাগরদাড়ী', 3, 20, 176, 10457, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:57'),
(1571, 'Majidpur', 'মজিদপুর', 3, 20, 176, 10458, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:03:59'),
(1572, 'Mongolkot', 'মঙ্গলকোর্ট', 3, 20, 176, 10459, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:00'),
(1573, 'Bidyanandakati', 'বিদ্যানন্দকাটি', 3, 20, 176, 10460, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:02'),
(1574, 'Panjia', 'পাজিয়া', 3, 20, 176, 10461, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:04'),
(1575, 'Trimohini', 'ত্রিমোহিনী', 3, 20, 176, 10462, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:05'),
(1576, 'Gaurighona', 'গৌরিঘোনা', 3, 20, 176, 10463, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:07'),
(1577, 'Keshabpur', 'কেশবপুর', 3, 20, 176, 10464, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:09'),
(1578, 'Lebutala', 'লেবুতলা', 3, 20, 177, 10465, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:10'),
(1579, 'Ichhali', 'ইছালী', 3, 20, 177, 10466, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:12'),
(1580, 'Arabpur', 'আরবপুর', 3, 20, 177, 10467, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:13'),
(1581, 'Upasahar', 'উপশহর', 3, 20, 177, 10468, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:15'),
(1582, 'Kachua', 'কচুয়া', 3, 20, 177, 10469, 1, 1, 1, '2021-02-13 15:18:11', '2023-02-22 03:04:16'),
(1583, 'Kashimpur', 'কাশিমপুর', 3, 20, 177, 10470, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:18'),
(1584, 'Chanchra', 'চাঁচড়া', 3, 20, 177, 10471, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:20'),
(1585, 'Churamankati', 'চূড়ামনকাটি', 3, 20, 177, 10472, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:21'),
(1586, 'Narendrapur', 'নরেন্দ্রপুর', 3, 20, 177, 10473, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:23'),
(1587, 'Noapara', 'নওয়াপাড়া', 3, 20, 177, 10474, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:24'),
(1588, 'Fathehpur', 'ফতেপুর', 3, 20, 177, 10475, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:26'),
(1589, 'Basundia', 'বসুন্দিয়া', 3, 20, 177, 10476, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:27'),
(1590, 'Ramnagar', 'রামনগর', 3, 20, 177, 10477, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:29'),
(1591, 'Haibatpur', 'হৈবতপুর', 3, 20, 177, 10478, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:30'),
(1592, 'Dearamodel', 'দেয়ারা মডেল', 3, 20, 177, 10479, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:32'),
(1593, 'Ulshi', 'উলশী', 3, 20, 178, 10480, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:33'),
(1594, 'Sharsha', 'শার্শা', 3, 20, 178, 10481, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:35'),
(1595, 'Lakshmanpur', 'লক্ষণপুর', 3, 20, 178, 10482, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:37'),
(1596, 'Benapole', 'বেনাপোল', 3, 20, 178, 10483, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:38'),
(1597, 'Bahadurpur', 'বাহাদুরপুর', 3, 20, 178, 10484, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:41'),
(1598, 'Bagachra', 'বাগআচড়া', 3, 20, 178, 10485, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:44'),
(1599, 'Putkhali', 'পুটখালী', 3, 20, 178, 10486, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:48'),
(1600, 'Nizampur', 'নিজামপুর', 3, 20, 178, 10487, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:49'),
(1601, 'Dihi', 'ডিহি', 3, 20, 178, 10488, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:51'),
(1602, 'Goga', 'গোগা', 3, 20, 178, 10489, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:52'),
(1603, 'Kayba', 'কায়বা', 3, 20, 178, 10490, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:54'),
(1604, 'Anulia', 'আনুলিয়া', 3, 21, 179, 10491, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:56'),
(1605, 'Assasuni', 'আশাশুনি', 3, 21, 179, 10492, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:57'),
(1606, 'Kadakati', 'কাদাকাটি', 3, 21, 179, 10493, 1, 1, 1, '2021-02-13 15:18:12', '2023-02-22 03:04:59'),
(1607, 'Kulla', 'কুল্যা', 3, 21, 179, 10494, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:01'),
(1608, 'Khajra', 'খাজরা', 3, 21, 179, 10495, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:02'),
(1609, 'Durgapur', 'দরগাহপুর', 3, 21, 179, 10496, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:04'),
(1610, 'Pratapnagar', 'প্রতাপনগর', 3, 21, 179, 10497, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:05'),
(1611, 'Budhhata', 'বুধহাটা', 3, 21, 179, 10498, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:07'),
(1612, 'Baradal', 'বড়দল', 3, 21, 179, 10499, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:09'),
(1613, 'Sreeula', 'শ্রীউলা', 3, 21, 179, 10500, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:10'),
(1614, 'Sobhnali', 'শোভনালী', 3, 21, 179, 10501, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:12'),
(1615, 'Kulia', 'কুলিয়া', 3, 21, 180, 10502, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:13'),
(1616, 'Debhata', 'দেবহাটা', 3, 21, 180, 10503, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:15'),
(1617, 'Noapara', 'নওয়াপাড়া', 3, 21, 180, 10504, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:16'),
(1618, 'Parulia', 'পারুলিয়া', 3, 21, 180, 10505, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:18'),
(1619, 'Sakhipur', 'সখিপুর', 3, 21, 180, 10506, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:19'),
(1620, 'Kushadanga', 'কুশোডাংগা', 3, 21, 181, 10507, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:21'),
(1621, 'Keralkata', 'কেরালকাতা', 3, 21, 181, 10508, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:22'),
(1622, 'Keragachhi', 'কেঁড়াগাছি', 3, 21, 181, 10509, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:24'),
(1623, 'Kaila', 'কয়লা', 3, 21, 181, 10510, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:25'),
(1624, 'Jallabad', 'জালালাবাদ', 3, 21, 181, 10511, 1, 1, 1, '2021-02-13 15:18:13', '2023-02-22 03:05:27'),
(1625, 'Jogikhali', 'যুগিখালী', 3, 21, 181, 10512, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:28'),
(1626, 'Langaljhara', 'লাঙ্গলঝাড়া', 3, 21, 181, 10513, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:30'),
(1627, 'Sonabaria', 'সোনাবাড়িয়া', 3, 21, 181, 10514, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:32'),
(1628, 'Helatala', 'হেলাতলা', 3, 21, 181, 10515, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:33'),
(1629, 'Chandanpur', 'চন্দনপুর', 3, 21, 181, 10516, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:35'),
(1630, 'Deara', 'দেয়ারা', 3, 21, 181, 10517, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:36'),
(1631, 'Joynagar', 'জয়নগর', 3, 21, 181, 10518, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:38'),
(1632, 'Shibpur', 'শিবপুর', 3, 21, 182, 10519, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:40'),
(1633, 'Labsa', 'লাবসা', 3, 21, 182, 10520, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:41'),
(1634, 'Bhomra', 'ভোমরা', 3, 21, 182, 10521, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:43'),
(1635, 'Brahmarajpur', 'ব্রক্ষ্মরাজপুর', 3, 21, 182, 10522, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:44'),
(1636, 'Balli', 'বল্লী', 3, 21, 182, 10523, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:46'),
(1637, 'Banshdaha', 'বাঁশদহ', 3, 21, 182, 10524, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:47'),
(1638, 'Baikari', 'বৈকারী', 3, 21, 182, 10525, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:49'),
(1639, 'Fingri', 'ফিংড়ি', 3, 21, 182, 10526, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:50'),
(1640, 'Dhulihar', 'ধুলিহর', 3, 21, 182, 10527, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:52'),
(1641, 'Jhaudanga', 'ঝাউডাঙ্গা', 3, 21, 182, 10528, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:53'),
(1642, 'Ghona', 'ঘোনা', 3, 21, 182, 10529, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:55'),
(1643, 'Kuskhali', 'কুশখালী', 3, 21, 182, 10530, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:56'),
(1644, 'Alipur', 'আলিপুর', 3, 21, 182, 10531, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:58'),
(1645, 'Agardari', 'আগরদাড়ী', 3, 21, 182, 10532, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:05:59'),
(1646, 'Atulia', 'আটুলিয়া', 3, 21, 183, 10533, 1, 1, 1, '2021-02-13 15:18:14', '2023-02-22 03:06:01'),
(1647, 'Ishwaripur', 'ঈশ্বরীপুর', 3, 21, 183, 10534, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:02'),
(1648, 'Kaikhali', 'কৈখালী', 3, 21, 183, 10535, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:04'),
(1649, 'Kashimari', 'কাশিমাড়ী', 3, 21, 183, 10536, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:06'),
(1650, 'Nurnagar', 'নুরনগর', 3, 21, 183, 10537, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:07'),
(1651, 'Padmapukur', 'পদ্মপুকুর', 3, 21, 183, 10538, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:09'),
(1652, 'Burigoalini', 'বুড়িগোয়ালিনী', 3, 21, 183, 10539, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:10'),
(1653, 'Bhurulia', 'ভুরুলিয়া', 3, 21, 183, 10540, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:12'),
(1654, 'Munshiganj', 'মুন্সীগজ্ঞ', 3, 21, 183, 10541, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:13'),
(1655, 'Ramjannagar', 'রমজাননগর', 3, 21, 183, 10542, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:15'),
(1656, 'Shyamnagar', 'শ্যামনগর', 3, 21, 183, 10543, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:17'),
(1657, 'Gabura', 'গাবুরা', 3, 21, 183, 10544, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:18'),
(1658, 'Sarulia', 'সরুলিয়া', 3, 21, 184, 10545, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:20'),
(1659, 'Magura', 'মাগুরা', 3, 21, 184, 10546, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:21'),
(1660, 'Nagarghata', 'নগরঘাটা', 3, 21, 184, 10547, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:23'),
(1661, 'Dhandia', 'ধানদিয়া', 3, 21, 184, 10548, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:24'),
(1662, 'Tentulia', 'তেতুলিয়া', 3, 21, 184, 10549, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:26'),
(1663, 'Tala', 'তালা', 3, 21, 184, 10550, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:27'),
(1664, 'Jalalpur', 'জালালপুর', 3, 21, 184, 10551, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:29'),
(1665, 'Khesra', 'খেশরা', 3, 21, 184, 10552, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:31'),
(1666, 'Khalishkhali', 'খলিশখালী', 3, 21, 184, 10553, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:32'),
(1667, 'Khalilnagar', 'খলিলনগর', 3, 21, 184, 10554, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:34'),
(1668, 'Kumira', 'কুমিরা', 3, 21, 184, 10555, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:36'),
(1669, 'Islamkati', 'ইসলামকাটি', 3, 21, 184, 10556, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:38'),
(1670, 'Kushlia', 'কুশুলিয়া', 3, 21, 185, 10557, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:40'),
(1671, 'Champaphul', 'চাম্পাফুল', 3, 21, 185, 10558, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:42'),
(1672, 'Tarali', 'তারালী', 3, 21, 185, 10559, 1, 1, 1, '2021-02-13 15:18:15', '2023-02-22 03:06:43'),
(1673, 'Dakshin Sreepur', 'দক্ষিণ শ্রীপুর', 3, 21, 185, 10560, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:45'),
(1674, 'Dhalbaria', 'ধলবাড়িয়া', 3, 21, 185, 10561, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:46'),
(1675, 'Nalta', 'নলতা', 3, 21, 185, 10562, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:48'),
(1676, 'Bishnupur', 'বিষ্ণুপুর', 3, 21, 185, 10563, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:49'),
(1677, 'Bharasimla', 'ভাড়াশিমলা', 3, 21, 185, 10564, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:51'),
(1678, 'Mathureshpur', 'মথুরেশপুর', 3, 21, 185, 10565, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:52'),
(1679, 'Ratanpur', 'রতনপুর', 3, 21, 185, 10566, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:54'),
(1680, 'Mautala', 'মৌতলা', 3, 21, 185, 10567, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:55'),
(1681, 'Krishnanagar', 'কৃষ্ণনগর', 3, 21, 185, 10568, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:57'),
(1682, 'Dariapur', 'দারিয়াপুর', 3, 22, 186, 10569, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:06:58'),
(1683, 'Monakhali', 'মোনাখালী', 3, 22, 186, 10570, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:07:00'),
(1684, 'Bagowan', 'বাগোয়ান', 3, 22, 186, 10571, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:07:01'),
(1685, 'Mohajanpur', 'মহাজনপুর', 3, 22, 186, 10572, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:07:04'),
(1686, 'Amjhupi', 'আমঝুপি', 3, 22, 187, 10573, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:07:05'),
(1687, 'Pirojpur', 'পিরোজপুর', 3, 22, 187, 10574, 1, 1, 1, '2021-02-13 15:18:16', '2023-02-22 03:07:07'),
(1688, 'Kutubpur', 'কতুবপুর', 3, 22, 187, 10575, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:08'),
(1689, 'Amdah', 'আমদহ', 3, 22, 187, 10576, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:10'),
(1690, 'Buripota', 'বুড়িপোতা', 3, 22, 187, 10577, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:11'),
(1691, 'Tentulbaria', 'তেঁতুলবাড়ীয়া', 3, 22, 188, 10578, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:13'),
(1692, 'Kazipur', 'কাজিপুর', 3, 22, 188, 10579, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:15'),
(1693, 'Bamondi', 'বামন্দী', 3, 22, 188, 10580, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:16'),
(1694, 'Motmura', 'মটমুড়া', 3, 22, 188, 10581, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:18'),
(1695, 'Sholotaka', 'ষোলটাকা', 3, 22, 188, 10582, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:19'),
(1696, 'Shaharbati', 'সাহারবাটী', 3, 22, 188, 10583, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:21'),
(1697, 'Dhankolla', 'ধানখোলা', 3, 22, 188, 10584, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:23'),
(1698, 'Raipur', 'রায়পুর', 3, 22, 188, 10585, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:24'),
(1699, 'Kathuli', 'কাথুলী', 3, 22, 188, 10586, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:26'),
(1700, 'Sheikhati', 'সেখহাটী', 3, 23, 189, 10587, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:27'),
(1701, 'Tularampur', 'তুলারামপুর', 3, 23, 189, 10588, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:29'),
(1702, 'Kalora', 'কলোড়া', 3, 23, 189, 10589, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:30'),
(1703, 'Shahabad', 'শাহাবাদ', 3, 23, 189, 10590, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:32'),
(1704, 'Bashgram', 'বাশগ্রাম', 3, 23, 189, 10591, 1, 1, 1, '2021-02-13 15:18:17', '2023-02-22 03:07:33'),
(1705, 'Habokhali', 'হবখালী', 3, 23, 189, 10592, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:35'),
(1706, 'Maijpara', 'মাইজপাড়া', 3, 23, 189, 10593, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:36'),
(1707, 'Bisali', 'বিছালী', 3, 23, 189, 10594, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:38'),
(1708, 'Chandiborpur', 'চন্ডিবরপুর', 3, 23, 189, 10595, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:39'),
(1709, 'Bhadrabila', 'ভদ্রবিলা', 3, 23, 189, 10596, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:41'),
(1710, 'Auria', 'আউড়িয়া', 3, 23, 189, 10597, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:43'),
(1711, 'Singasholpur', 'সিঙ্গাশোলপুর', 3, 23, 189, 10598, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:44'),
(1712, 'Mulia', 'মুলিয়া', 3, 23, 189, 10599, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:46'),
(1713, 'Lohagora', 'লোহাগড়া', 3, 23, 190, 10600, 1, 1, 1, '2021-02-13 15:18:18', '2023-02-22 03:07:47'),
(1714, 'Kashipur', 'কাশিপুর', 3, 23, 190, 10601, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:49'),
(1715, 'Naldi', 'নলদী', 3, 23, 190, 10602, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:50'),
(1716, 'Noagram', 'নোয়াগ্রাম', 3, 23, 190, 10603, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:52'),
(1717, 'Lahuria', 'লাহুড়িয়া', 3, 23, 190, 10604, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:53'),
(1718, 'Mallikpur', 'মল্লিকপুর', 3, 23, 190, 10605, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:55'),
(1719, 'Salnagar', 'শালনগর', 3, 23, 190, 10606, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:56'),
(1720, 'Lakshmipasha', 'লক্ষীপাশা', 3, 23, 190, 10607, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:58'),
(1721, 'Joypur', 'জয়পুর', 3, 23, 190, 10608, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:07:59'),
(1722, 'Kotakol', 'কোটাকোল', 3, 23, 190, 10609, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:01'),
(1723, 'Digholia', 'দিঘলিয়া', 3, 23, 190, 10610, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:02'),
(1724, 'Itna', 'ইতনা', 3, 23, 190, 10611, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:06'),
(1725, 'Jaynagor', 'জয়নগর', 3, 23, 191, 10612, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:07'),
(1726, 'Pahordanga', 'পহরডাঙ্গা', 3, 23, 191, 10613, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:09'),
(1727, 'Babrahasla', 'বাবরা-হাচলা', 3, 23, 191, 10614, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:11'),
(1728, 'Salamabad', 'সালামাবাদ', 3, 23, 191, 10615, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:13'),
(1729, 'Baioshona', 'বাঐসোনা', 3, 23, 191, 10616, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:14'),
(1730, 'Chacuri', 'চাচুড়ী', 3, 23, 191, 10617, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:16'),
(1731, 'Hamidpur', 'হামিদপুর', 3, 23, 191, 10618, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:17'),
(1732, 'Peroli', 'পেড়লী', 3, 23, 191, 10619, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:19'),
(1733, 'Khashial', 'খাসিয়াল', 3, 23, 191, 10620, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:21'),
(1734, 'Purulia', 'পুরুলিয়া', 3, 23, 191, 10621, 1, 1, 1, '2021-02-13 15:18:19', '2023-02-22 03:08:22'),
(1735, 'Kalabaria', 'কলাবাড়ীয়া', 3, 23, 191, 10622, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:24'),
(1736, 'Mauli', 'মাউলী', 3, 23, 191, 10623, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:25'),
(1737, 'Boronaleliasabad', 'বড়নাল-ইলিয়াছাবাদ', 3, 23, 191, 10624, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:27'),
(1738, 'Panchgram', 'পাঁচগ্রাম', 3, 23, 191, 10625, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:30'),
(1739, 'Alukdia', 'আলুকদিয়া', 3, 24, 192, 10626, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:33'),
(1740, 'Mominpur', 'মোমিনপুর', 3, 24, 192, 10627, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:34'),
(1741, 'Titudah', 'তিতুদাহ', 3, 24, 192, 10628, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:36'),
(1742, 'Shankarchandra', 'শংকরচন্দ্র', 3, 24, 192, 10629, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:37'),
(1743, 'Begumpur', 'বেগমপুর', 3, 24, 192, 10630, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:39'),
(1744, 'Kutubpur', 'কুতুবপুর', 3, 24, 192, 10631, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:41'),
(1745, 'Padmabila', 'পদ্মবিলা', 3, 24, 192, 10632, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:43'),
(1746, 'Bhangbaria', 'ভাংবাড়ীয়া', 3, 24, 193, 10633, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:46'),
(1747, 'Baradi', 'বাড়াদী', 3, 24, 193, 10634, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:47'),
(1748, 'Gangni', 'গাংনী', 3, 24, 193, 10635, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:49'),
(1749, 'Khadimpur', 'খাদিমপুর', 3, 24, 193, 10636, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:51'),
(1750, 'Jehala', 'জেহালা', 3, 24, 193, 10637, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:53'),
(1751, 'Belgachi', 'বেলগাছি', 3, 24, 193, 10638, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:55'),
(1752, 'Dauki', 'ডাউকী', 3, 24, 193, 10639, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:08:58'),
(1753, 'Jamjami', 'জামজামি', 3, 24, 193, 10640, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:09:00'),
(1754, 'Nagdah', 'নাগদাহ', 3, 24, 193, 10641, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:09:02'),
(1755, 'Kashkorara', 'খাসকররা', 3, 24, 193, 10642, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:09:04'),
(1756, 'Chitla', 'চিৎলা', 3, 24, 193, 10643, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:09:06'),
(1757, 'Kalidashpur', 'কালিদাসপুর', 3, 24, 193, 10644, 1, 1, 1, '2021-02-13 15:18:20', '2023-02-22 03:09:07'),
(1758, 'Kumari', 'কুমারী', 3, 24, 193, 10645, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:09'),
(1759, 'Hardi', 'হারদী', 3, 24, 193, 10646, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:11'),
(1760, 'Ailhash', 'আইলহাঁস', 3, 24, 193, 10647, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:12'),
(1761, 'Damurhuda', 'দামুড়হুদা', 3, 24, 194, 10648, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:14'),
(1762, 'Karpashdanga', 'কার্পাসডাঙ্গা', 3, 24, 194, 10649, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:16'),
(1763, 'Natipota', 'নতিপোতা', 3, 24, 194, 10650, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:17'),
(1764, 'Hawli', 'হাওলী', 3, 24, 194, 10651, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:19'),
(1765, 'Kurulgachhi', 'কুড়ালগাছী', 3, 24, 194, 10652, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:20'),
(1766, 'Perkrishnopur Madna', 'পারকৃষ্ণপুর মদনা', 3, 24, 194, 10653, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:22'),
(1767, 'Juranpur', 'জুড়ানপুর', 3, 24, 194, 10654, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:23'),
(1768, 'Uthali', 'উথলী', 3, 24, 195, 10655, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:25'),
(1769, 'Andulbaria', 'আন্দুলবাড়ীয়া', 3, 24, 195, 10656, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:26'),
(1770, 'Banka', 'বাঁকা', 3, 24, 195, 10657, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:28'),
(1771, 'Shimanto', 'সীমান্ত', 3, 24, 195, 10658, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:29'),
(1772, 'Raypur', 'রায়পুর', 3, 24, 195, 10659, 1, 1, 1, '2021-02-13 15:18:21', '2023-02-22 03:09:31'),
(1773, 'Hasadah', 'হাসাদাহ', 3, 24, 195, 10660, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:32'),
(1774, 'Hatash Haripur', 'হাটশ হরিপুর', 3, 25, 196, 10661, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:34'),
(1775, 'Barkhada', 'বারখাদা', 3, 25, 196, 10662, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:36'),
(1776, 'Mazampur', 'মজমপুর', 3, 25, 196, 10663, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:37'),
(1777, 'Bottail', 'বটতৈল', 3, 25, 196, 10664, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:39'),
(1778, 'Alampur', 'আলামপুর', 3, 25, 196, 10665, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:40'),
(1779, 'Ziaraakhi', 'জিয়ারাখী', 3, 25, 196, 10666, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:42'),
(1780, 'Ailchara', 'আইলচারা', 3, 25, 196, 10667, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:43'),
(1781, 'Patikabari', 'পাটিকাবাড়ী', 3, 25, 196, 10668, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:45'),
(1782, 'Jhaudia', 'ঝাউদিয়া', 3, 25, 196, 10669, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:47'),
(1783, 'Ujangram', 'উজানগ্রাম', 3, 25, 196, 10670, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:48'),
(1784, 'Abdulpur', 'আব্দালপুর', 3, 25, 196, 10671, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:50'),
(1785, 'Harinarayanpur', 'হরিনারায়নপুর', 3, 25, 196, 10672, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:52'),
(1786, 'Monohardia', 'মনোহরদিয়া', 3, 25, 196, 10673, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:53'),
(1787, 'Goswami Durgapur', 'গোস্বামী দুর্গাপুর', 3, 25, 196, 10674, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:55'),
(1788, 'Kaya', 'কয়া', 3, 25, 197, 10675, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:56'),
(1789, 'Jagonnathpur', 'জগন্নাথপুর', 3, 25, 197, 10676, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:09:58'),
(1790, 'Sadki', 'সদকী', 3, 25, 197, 10677, 1, 1, 1, '2021-02-13 15:18:22', '2023-02-22 03:10:00'),
(1791, 'Shelaidah', 'শিলাইদহ', 3, 25, 197, 10678, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:01'),
(1792, 'Nandolalpur', 'নন্দলালপুর', 3, 25, 197, 10679, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:03'),
(1793, 'Chapra', 'চাপড়া', 3, 25, 197, 10680, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:05'),
(1794, 'Bagulat', 'বাগুলাট', 3, 25, 197, 10681, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:06'),
(1795, 'Jaduboyra', 'যদুবয়রা', 3, 25, 197, 10682, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:08'),
(1796, 'Chadpur', 'চাঁদপুর', 3, 25, 197, 10683, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:09'),
(1797, 'Panti', 'পান্টি', 3, 25, 197, 10684, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:11'),
(1798, 'Charsadipur', 'চরসাদীপুর', 3, 25, 197, 10685, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:12'),
(1799, 'Khoksa', 'খোকসা', 3, 25, 198, 10686, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:15'),
(1800, 'Osmanpur', 'ওসমানপুর', 3, 25, 198, 10687, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:17'),
(1801, 'Janipur', 'জানিপুর', 3, 25, 198, 10688, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:19'),
(1802, 'Shimulia', 'শিমুলিয়া', 3, 25, 198, 10689, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:20'),
(1803, 'Joyntihazra', 'জয়ন্তীহাজরা', 3, 25, 198, 10690, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:22'),
(1804, 'Ambaria', 'আমবাড়ীয়া', 3, 25, 198, 10691, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:23'),
(1805, 'Bethbaria', 'বেতবাড়ীয়া', 3, 25, 198, 10692, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:25'),
(1806, 'Shomospur', 'শোমসপুর', 3, 25, 198, 10693, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:26'),
(1807, 'Gopgram', 'গোপগ্রাম', 3, 25, 198, 10694, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:28'),
(1808, 'Chithalia', 'চিথলিয়া', 3, 25, 199, 10695, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:30'),
(1809, 'Bahalbaria', 'বহলবাড়ীয়া', 3, 25, 199, 10696, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:31'),
(1810, 'Talbaria', 'তালবাড়ীয়া', 3, 25, 199, 10697, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:33'),
(1811, 'Baruipara', 'বারুইপাড়া', 3, 25, 199, 10698, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:35'),
(1812, 'Fulbaria', 'ফুলবাড়ীয়া', 3, 25, 199, 10699, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:36'),
(1813, 'Amla', 'আমলা', 3, 25, 199, 10700, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:38'),
(1814, 'Sadarpur', 'সদরপুর', 3, 25, 199, 10701, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:39'),
(1815, 'Chhatian', 'ছাতিয়ান', 3, 25, 199, 10702, 1, 1, 1, '2021-02-13 15:18:23', '2023-02-22 03:10:41'),
(1816, 'Poradaha', 'পোড়াদহ', 3, 25, 199, 10703, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:42'),
(1817, 'Kursha', 'কুর্শা', 3, 25, 199, 10704, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:44'),
(1818, 'Ambaria', 'আমবাড়ীয়া', 3, 25, 199, 10705, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:45'),
(1819, 'Dhubail', 'ধূবইল', 3, 25, 199, 10706, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:47'),
(1820, 'Malihad', 'মালিহাদ', 3, 25, 199, 10707, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:48'),
(1821, 'Daulatpur', 'দৌলতপুর', 3, 25, 200, 10708, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:50'),
(1822, 'Adabaria', 'ড়ীয়া', 3, 25, 200, 10709, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:52'),
(1823, 'Hogolbaria', 'হোগলবাড়ীয়া', 3, 25, 200, 10710, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:53'),
(1824, 'Boalia', 'বোয়ালি', 3, 25, 200, 10711, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:55'),
(1825, 'Philipnagor', 'ফিলিপনগর', 3, 25, 200, 10712, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:56'),
(1826, 'Aria', 'আড়িয়া', 3, 25, 200, 10713, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:58'),
(1827, 'Khalishakundi', 'খলিশাকুন্ডি', 3, 25, 200, 10714, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:10:59'),
(1828, 'Chilmary', 'চিলমারী', 3, 25, 200, 10715, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:01'),
(1829, 'Mothurapur', 'মথুরাপুর', 3, 25, 200, 10716, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:03'),
(1830, 'Pragpur', 'প্রাগপুর', 3, 25, 200, 10717, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:04'),
(1831, 'Piarpur', 'পিয়ারপুর', 3, 25, 200, 10718, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:06'),
(1832, 'Moricha', 'মরিচা', 3, 25, 200, 10719, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:07'),
(1833, 'Refaitpur', 'রিফাইতপুর', 3, 25, 200, 10720, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:09'),
(1834, 'Ramkrishnopur', 'রামকৃষ্ণপুর', 3, 25, 200, 10721, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:10'),
(1835, 'Dharampur', 'ধরমপুর', 3, 25, 201, 10722, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:13'),
(1836, 'Bahirchar', 'বাহিরচর', 3, 25, 201, 10723, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:14'),
(1837, 'Mukarimpur', 'মোকারিমপুর', 3, 25, 201, 10724, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:16'),
(1838, 'Juniadah', 'জুনিয়াদহ', 3, 25, 201, 10725, 1, 1, 1, '2021-02-13 15:18:24', '2023-02-22 03:11:18'),
(1839, 'Chandgram', 'চাঁদগ্রাম', 3, 25, 201, 10726, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:19'),
(1840, 'Bahadurpur', 'বাহাদুরপুর', 3, 25, 201, 10727, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:22'),
(1841, 'Dhaneshwargati', 'ধনেশ্বরগাতী', 3, 26, 202, 10728, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:23'),
(1842, 'Talkhari', 'তালখড়ি', 3, 26, 202, 10729, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:25'),
(1843, 'Arpara', 'আড়পাড়া', 3, 26, 202, 10730, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:27'),
(1844, 'Shatakhali', 'শতখালী', 3, 26, 202, 10731, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:28'),
(1845, 'Shalikha', 'শালিখা', 3, 26, 202, 10732, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:32'),
(1846, 'Bunagati', 'বুনাগাতী', 3, 26, 202, 10733, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:34'),
(1847, 'Gongarampur', 'গঙ্গারামপুর', 3, 26, 202, 10734, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:35'),
(1848, 'Goyespur', 'গয়েশপুর', 3, 26, 203, 10735, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:37'),
(1849, 'Sreekol', 'শ্রীকোল', 3, 26, 203, 10736, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:39'),
(1850, 'Dariapur', 'দ্বারিয়াপুর', 3, 26, 203, 10737, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:42'),
(1851, 'Kadirpara', 'কাদিরপাড়া', 3, 26, 203, 10738, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:44'),
(1852, 'Shobdalpur', 'সব্দালপুর', 3, 26, 203, 10739, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:47'),
(1853, 'Sreepur', 'শ্রীপুর', 3, 26, 203, 10740, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:48'),
(1854, 'Nakol', 'নাকোল', 3, 26, 203, 10741, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:50'),
(1855, 'Amalshar', 'আমলসার', 3, 26, 203, 10742, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:52'),
(1856, 'Hazipur', 'হাজীপুর', 3, 26, 204, 10743, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:54'),
(1857, 'Atharokhada', 'আঠারখাদা', 3, 26, 204, 10744, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:55'),
(1858, 'Kosundi', 'কছুন্দী', 3, 26, 204, 10745, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:11:57'),
(1859, 'Bogia', 'বগিয়া', 3, 26, 204, 10746, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:00'),
(1860, 'Hazrapur', 'হাজরাপুর', 3, 26, 204, 10747, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:02'),
(1861, 'Raghobdair', 'রাঘবদাইড়', 3, 26, 204, 10748, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:04'),
(1862, 'Jagdal', 'জগদল', 3, 26, 204, 10749, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:07'),
(1863, 'Chawlia', 'চাউলিয়া', 3, 26, 204, 10750, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:08'),
(1864, 'Satrijitpur', 'শত্রুজিৎপুর', 3, 26, 204, 10751, 1, 1, 1, '2021-02-13 15:18:25', '2023-02-22 03:12:10'),
(1865, 'Baroilpolita', 'বেরইল পলিতা', 3, 26, 204, 10752, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:11'),
(1866, 'Kuchiamora', 'কুচিয়ামো', 3, 26, 204, 10753, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:13'),
(1867, 'Gopalgram', 'গোপালগ্রাম', 3, 26, 204, 10754, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:14'),
(1868, 'Moghi', 'মঘী', 3, 26, 204, 10755, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:16'),
(1869, 'Digha', 'দীঘা', 3, 26, 205, 10756, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:17'),
(1870, 'Nohata', 'নহাটা', 3, 26, 205, 10757, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:19'),
(1871, 'Palashbaria', 'পলাশবাড়ীয়া', 3, 26, 205, 10758, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:20'),
(1872, 'Babukhali', 'বাবুখালী', 3, 26, 205, 10759, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:22'),
(1873, 'Balidia', 'বালিদিয়া', 3, 26, 205, 10760, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:24'),
(1874, 'Binodpur', 'বিনোদপুর', 3, 26, 205, 10761, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:26'),
(1875, 'Mohammadpur', 'মহম্মদপুর', 3, 26, 205, 10762, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:28'),
(1876, 'Rajapur', 'রাজাপুর', 3, 26, 205, 10763, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:29'),
(1877, 'Horidhali', 'হরিঢালী', 3, 27, 206, 10764, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:32'),
(1878, 'Goroikhali', 'গড়ইখালী', 3, 27, 206, 10765, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:33'),
(1879, 'Kopilmuni', 'কপিলমুনি', 3, 27, 206, 10766, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:35'),
(1880, 'Lota', 'লতা', 3, 27, 206, 10767, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:37'),
(1881, 'Deluti', 'দেলুটি', 3, 27, 206, 10768, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:38'),
(1882, 'Loskor', 'লস্কর', 3, 27, 206, 10769, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:40'),
(1883, 'Godaipur', 'গদাইপুর', 3, 27, 206, 10770, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:42'),
(1884, 'Raruli', 'রাড়ুলী', 3, 27, 206, 10771, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:44'),
(1885, 'Chandkhali', 'চাঁদখালী', 3, 27, 206, 10772, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:46'),
(1886, 'Soladana', 'সোলাদানা', 3, 27, 206, 10773, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:48'),
(1887, 'Fultola', 'ফুলতলা', 3, 27, 207, 10774, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:50'),
(1888, 'Damodar', 'দামোদর', 3, 27, 207, 10775, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:52'),
(1889, 'Atra Gilatola', 'আটরা গিলাতলা', 3, 27, 207, 10776, 1, 1, 1, '2021-02-13 15:18:26', '2023-02-22 03:12:54'),
(1890, 'Jamira', 'জামিরা', 3, 27, 207, 10777, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:12:56'),
(1891, 'Senhati', 'সেনহাটি', 3, 27, 208, 10778, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:12:58'),
(1892, 'Gajirhat', 'গাজীরহাট', 3, 27, 208, 10779, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:00'),
(1893, 'Barakpur', 'বারাকপুর', 3, 27, 208, 10780, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:02'),
(1894, 'Aronghata', 'আড়ংঘাটা', 3, 27, 208, 10781, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:03'),
(1895, 'Jogipol', 'যোগীপোল', 3, 27, 208, 10782, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:06'),
(1896, 'Digholia', 'দিঘলিয়া', 3, 27, 208, 10783, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:07'),
(1897, 'Aichgati', 'আইচগাতী', 3, 27, 209, 10784, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:09'),
(1898, 'Srifoltola', 'শ্রীফলতলা', 3, 27, 209, 10785, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:11'),
(1899, 'Noihati', 'নৈহাটি', 3, 27, 209, 10786, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:12'),
(1900, 'Tsb', 'টিএসবি', 3, 27, 209, 10787, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:15'),
(1901, 'Ghatvog', 'ঘাটভোগ', 3, 27, 209, 10788, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:18'),
(1902, 'Terokhada', 'তেরখাদা', 3, 27, 210, 10789, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:19'),
(1903, 'Chagladoho', 'ছাগলাদহ', 3, 27, 210, 10790, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:21'),
(1904, 'Barasat', 'বারাসাত', 3, 27, 210, 10791, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:22'),
(1905, 'Sochiadaho', 'সাচিয়াদাহ', 3, 27, 210, 10792, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:25'),
(1906, 'Modhupur', 'মধুপুর', 3, 27, 210, 10793, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:27'),
(1907, 'Ajgora', 'আজগড়া', 3, 27, 210, 10794, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:29'),
(1908, 'Dumuria', 'ডুমুরিয়া', 3, 27, 211, 10795, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:30'),
(1909, 'Magurghona', 'মাগুরাঘোনা', 3, 27, 211, 10796, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:32'),
(1910, 'Vandarpara', 'ভান্ডারপাড়া', 3, 27, 211, 10797, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:33'),
(1911, 'Sahos', 'সাহস', 3, 27, 211, 10798, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:35'),
(1912, 'Rudaghora', 'রুদাঘরা', 3, 27, 211, 10799, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:37'),
(1913, 'Ghutudia', 'গুটুদিয়া', 3, 27, 211, 10800, 1, 1, 1, '2021-02-13 15:18:27', '2023-02-22 03:13:39'),
(1914, 'Shovna', 'শোভনা', 3, 27, 211, 10801, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:42'),
(1915, 'Khornia', 'খর্ণিয়া', 3, 27, 211, 10802, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:44'),
(1916, 'Atlia', 'আটলিয়া', 3, 27, 211, 10803, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:45'),
(1917, 'Dhamalia', 'ধামালিয়া', 3, 27, 211, 10804, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:47'),
(1918, 'Raghunathpur', 'রঘুনাথপুর', 3, 27, 211, 10805, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:49'),
(1919, 'Rongpur', 'রংপুর', 3, 27, 211, 10806, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:50'),
(1920, 'Shorafpur', 'শরাফপুর', 3, 27, 211, 10807, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:52'),
(1921, 'Magurkhali', 'মাগুরখালি', 3, 27, 211, 10808, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:54'),
(1922, 'Botiaghata', 'বটিয়াঘাটা', 3, 27, 212, 10809, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:55'),
(1923, 'Amirpur', 'আমিরপুর', 3, 27, 212, 10810, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:57'),
(1924, 'Gongarampur', 'গঙ্গারামপুর', 3, 27, 212, 10811, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:13:59'),
(1925, 'Surkhali', 'সুরখালী', 3, 27, 212, 10812, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:00'),
(1926, 'Vandarkot', 'ভান্ডারকোট', 3, 27, 212, 10813, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:04'),
(1927, 'Baliadanga', 'বালিয়াডাঙ্গা', 3, 27, 212, 10814, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:06'),
(1928, 'Jolma', 'জলমা', 3, 27, 212, 10815, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:08'),
(1929, 'Dakop', 'দাকোপ', 3, 27, 213, 10816, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:09'),
(1930, 'Bajua', 'বাজুয়া', 3, 27, 213, 10817, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:11'),
(1931, 'Kamarkhola', 'কামারখোলা', 3, 27, 213, 10818, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:13'),
(1932, 'Tildanga', 'তিলডাঙ্গা', 3, 27, 213, 10819, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:16');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1933, 'Sutarkhali', 'সুতারখালী', 3, 27, 213, 10820, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:18'),
(1934, 'Laudoba', 'লাউডোব', 3, 27, 213, 10821, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:19'),
(1935, 'Pankhali', 'পানখালী', 3, 27, 213, 10822, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:21'),
(1936, 'Banishanta', 'বানিশান্তা', 3, 27, 213, 10823, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:22'),
(1937, 'Koilashgonj', 'কৈলাশগঞ্জ', 3, 27, 213, 10824, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:24'),
(1938, 'Koyra', 'কয়রা', 3, 27, 214, 10825, 1, 1, 1, '2021-02-13 15:18:28', '2023-02-22 03:14:26'),
(1939, 'Moharajpur', 'মহারাজপুর', 3, 27, 214, 10826, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:28'),
(1940, 'Moheswaripur', 'মহেশ্বরীপুর', 3, 27, 214, 10827, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:30'),
(1941, 'North Bedkashi', 'উত্তর বেদকাশী', 3, 27, 214, 10828, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:31'),
(1942, 'South Bedkashi', 'দক্ষিণ বেদকাশী', 3, 27, 214, 10829, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:33'),
(1943, 'Amadi', 'আমাদি', 3, 27, 214, 10830, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:35'),
(1944, 'Bagali', 'বাগালী', 3, 27, 214, 10831, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:37'),
(1945, 'Betaga', 'বেতাগা', 3, 28, 215, 10832, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:38'),
(1946, 'Lakhpur', 'লখপুর', 3, 28, 215, 10833, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:40'),
(1947, 'Fakirhat', 'ফকিরহাট', 3, 28, 215, 10834, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:42'),
(1948, 'Bahirdia-Mansa', 'বাহিরদিয়া-মানসা', 3, 28, 215, 10835, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:44'),
(1949, 'Piljanga', 'পিলজংগ', 3, 28, 215, 10836, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:46'),
(1950, 'Naldha-Mouvhog', 'নলধা-মৌভোগ', 3, 28, 215, 10837, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:47'),
(1951, 'Mulghar', 'মূলঘর', 3, 28, 215, 10838, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:49'),
(1952, 'Suvhadia', 'শুভদিয়া', 3, 28, 215, 10839, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:50'),
(1953, 'Karapara', 'কাড়াপাড়া', 3, 28, 216, 10840, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:52'),
(1954, 'Bamorta', 'বেমরতা', 3, 28, 216, 10841, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:53'),
(1955, 'Gotapara', 'গোটাপাড়া', 3, 28, 216, 10842, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:55'),
(1956, 'Bishnapur', 'বিষ্ণুপুর', 3, 28, 216, 10843, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:57'),
(1957, 'Baruipara', 'বারুইপাড়া', 3, 28, 216, 10844, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:14:58'),
(1958, 'Jatharapur', 'যাত্রাপুর', 3, 28, 216, 10845, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:15:00'),
(1959, 'Shaitgomboj', 'ষাটগুম্বজ', 3, 28, 216, 10846, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:15:01'),
(1960, 'Khanpur', 'খানপুর', 3, 28, 216, 10847, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:15:03'),
(1961, 'Rakhalgachi', 'রাখালগাছি', 3, 28, 216, 10848, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:15:05'),
(1962, 'Dema', 'ডেমা', 3, 28, 216, 10849, 1, 1, 1, '2021-02-13 15:18:29', '2023-02-22 03:15:06'),
(1963, 'Udoypur', 'উদয়পুর', 3, 28, 217, 10850, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:08'),
(1964, 'Chunkhola', 'চুনখোলা', 3, 28, 217, 10851, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:09'),
(1965, 'Gangni', 'গাংনী', 3, 28, 217, 10852, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:11'),
(1966, 'Kulia', 'কুলিয়া', 3, 28, 217, 10853, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:12'),
(1967, 'Gaola', 'গাওলা', 3, 28, 217, 10854, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:14'),
(1968, 'Kodalia', 'কোদালিয়া', 3, 28, 217, 10855, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:15'),
(1969, 'Atjuri', 'আটজুড়ী', 3, 28, 217, 10856, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:17'),
(1970, 'Dhanshagor', 'ধানসাগর', 3, 28, 218, 10857, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:18'),
(1971, 'Khontakata', 'খোন্তাকাটা', 3, 28, 218, 10858, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:20'),
(1972, 'Rayenda', 'রায়েন্দা', 3, 28, 218, 10859, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:21'),
(1973, 'Southkhali', 'সাউথখালী', 3, 28, 218, 10860, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:23'),
(1974, 'Gouramva', 'গৌরম্ভা', 3, 28, 219, 10861, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:24'),
(1975, 'Uzzalkur', 'উজলকুড়', 3, 28, 219, 10862, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:26'),
(1976, 'Baintala', 'বাইনতলা', 3, 28, 219, 10863, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:28'),
(1977, 'Rampal', 'রামপাল', 3, 28, 219, 10864, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:30'),
(1978, 'Rajnagar', 'রাজনগর', 3, 28, 219, 10865, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:31'),
(1979, 'Hurka', 'হুড়কা', 3, 28, 219, 10866, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:33'),
(1980, 'Perikhali', 'পেড়িখালী', 3, 28, 219, 10867, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:35'),
(1981, 'Vospatia', 'ভোজপাতিয়া', 3, 28, 219, 10868, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:36'),
(1982, 'Mollikerbar', 'মল্লিকেরবেড়', 3, 28, 219, 10869, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:38'),
(1983, 'Bastoli', 'বাঁশতলী', 3, 28, 219, 10870, 1, 1, 1, '2021-02-13 15:18:30', '2023-02-22 03:15:39'),
(1984, 'Teligati', 'তেলিগাতী', 3, 28, 220, 10871, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:41'),
(1985, 'Panchakaran', 'পঞ্চকরণ', 3, 28, 220, 10872, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:42'),
(1986, 'Putikhali', 'পুটিখালী', 3, 28, 220, 10873, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:44'),
(1987, 'Daibagnyahati', 'দৈবজ্ঞহাটি', 3, 28, 220, 10874, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:45'),
(1988, 'Ramchandrapur', 'রামচন্দ্রপুর', 3, 28, 220, 10875, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:47'),
(1989, 'Chingrakhali', 'চিংড়াখালী', 3, 28, 220, 10876, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:49'),
(1990, 'Jiudhara', 'জিউধরা', 3, 28, 220, 10877, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:50'),
(1991, 'Hoglapasha', 'হোগলাপাশা', 3, 28, 220, 10878, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:52'),
(1992, 'Banagram', 'বনগ্রাম', 3, 28, 220, 10879, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:53'),
(1993, 'Balaibunia', 'বলইবুনিয়া', 3, 28, 220, 10880, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:55'),
(1994, 'Hoglabunia', 'হোগলাবুনিয়া', 3, 28, 220, 10881, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:56'),
(1995, 'Baharbunia', 'বহরবুনিয়া', 3, 28, 220, 10882, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:15:58'),
(1996, 'Morrelganj', 'মোড়েলগঞ্জ', 3, 28, 220, 10883, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:00'),
(1997, 'Khaulia', 'খাউলিয়া', 3, 28, 220, 10884, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:01'),
(1998, 'Nishanbaria', 'নিশানবাড়িয়া', 3, 28, 220, 10885, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:03'),
(1999, 'Baraikhali', 'বারইখালী', 3, 28, 220, 10886, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:04'),
(2000, 'Gojalia', 'গজালিয়া', 3, 28, 221, 10887, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:06'),
(2001, 'Dhopakhali', 'ধোপাখালী', 3, 28, 221, 10888, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:07'),
(2002, 'Moghia', 'মঘিয়া', 3, 28, 221, 10889, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:09'),
(2003, 'Kachua', 'কচুয়া', 3, 28, 221, 10890, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:10'),
(2004, 'Gopalpur', 'গোপালপুর', 3, 28, 221, 10891, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:12'),
(2005, 'Raripara', 'রাড়ীপাড়া', 3, 28, 221, 10892, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:13'),
(2006, 'Badhal', 'বাধাল', 3, 28, 221, 10893, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:15'),
(2007, 'Burrirdangga', 'বুড়িরডাঙ্গা', 3, 28, 222, 10894, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:16'),
(2008, 'Mithakhali', 'মিঠাখালী', 3, 28, 222, 10895, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:18'),
(2009, 'Sonailtala', 'সোনাইলতলা', 3, 28, 222, 10896, 1, 1, 1, '2021-02-13 15:18:31', '2023-02-22 03:16:19'),
(2010, 'Chadpai', 'চাঁদপাই', 3, 28, 222, 10897, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:21'),
(2011, 'Chila', 'চিলা', 3, 28, 222, 10898, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:22'),
(2012, 'Sundarban', 'সুন্দরবন', 3, 28, 222, 10899, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:24'),
(2013, 'Barobaria', 'বড়বাড়িয়া', 3, 28, 223, 10900, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:26'),
(2014, 'Kalatala', 'কলাতলা', 3, 28, 223, 10901, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:27'),
(2015, 'Hizla', 'হিজলা', 3, 28, 223, 10902, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:29'),
(2016, 'Shibpur', 'শিবপুর', 3, 28, 223, 10903, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:30'),
(2017, 'Chitalmari', 'চিতলমারী', 3, 28, 223, 10904, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:32'),
(2018, 'Charbaniri', 'চরবানিয়ারী', 3, 28, 223, 10905, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:33'),
(2019, 'Shantoshpur', 'সন্তোষপুর', 3, 28, 223, 10906, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:35'),
(2020, 'Sadhuhati', 'সাধুহাটী', 3, 29, 224, 10907, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:36'),
(2021, 'Modhuhati', 'মধুহাটী', 3, 29, 224, 10908, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:38'),
(2022, 'Saganna', 'সাগান্না', 3, 29, 224, 10909, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:39'),
(2023, 'Halidhani', 'হলিধানী', 3, 29, 224, 10910, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:41'),
(2024, 'Kumrabaria', 'কুমড়াবাড়ীয়া', 3, 29, 224, 10911, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:43'),
(2025, 'Ganna', 'গান্না', 3, 29, 224, 10912, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:44'),
(2026, 'Maharazpur', 'মহারাজপুর', 3, 29, 224, 10913, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:46'),
(2027, 'Paglakanai', 'পাগলাকানাই', 3, 29, 224, 10914, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:47'),
(2028, 'Porahati', 'পোড়াহাটী', 3, 29, 224, 10915, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:49'),
(2029, 'Harishongkorpur', 'হরিশংকরপুর', 3, 29, 224, 10916, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:50'),
(2030, 'Padmakar', 'পদ্মাকর', 3, 29, 224, 10917, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:52'),
(2031, 'Dogachhi', 'দোগাছি', 3, 29, 224, 10918, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:54'),
(2032, 'Furshondi', 'ফুরসন্দি', 3, 29, 224, 10919, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:55'),
(2033, 'Ghorshal', 'ঘোড়শাল', 3, 29, 224, 10920, 1, 1, 1, '2021-02-13 15:18:32', '2023-02-22 03:16:57'),
(2034, 'Kalicharanpur', 'কালীচরণপুর', 3, 29, 224, 10921, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:16:58'),
(2035, 'Surat', 'সুরাট', 3, 29, 224, 10922, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:00'),
(2036, 'Naldanga', 'নলডাঙ্গা', 3, 29, 224, 10923, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:01'),
(2037, 'Tribeni', 'ত্রিবেনী', 3, 29, 225, 10924, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:03'),
(2038, 'Mirzapur', 'মির্জাপুর', 3, 29, 225, 10925, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:04'),
(2039, 'Dignagore', 'দিগনগর', 3, 29, 225, 10926, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:06'),
(2040, 'Kancherkol', 'কাঁচেরকোল', 3, 29, 225, 10927, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:07'),
(2041, 'Sarutia', 'সারুটিয়া', 3, 29, 225, 10928, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:09'),
(2042, 'Hakimpur', 'হাকিমপুর', 3, 29, 225, 10929, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:10'),
(2043, 'Dhaloharachandra', 'ধলহরাচন্দ্র', 3, 29, 225, 10930, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:12'),
(2044, 'Manoharpur', 'মনোহরপুর', 3, 29, 225, 10931, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:13'),
(2045, 'Bogura', 'বগুড়া', 3, 29, 225, 10932, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:15'),
(2046, 'Abaipur', 'আবাইপুর', 3, 29, 225, 10933, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:16'),
(2047, 'Nityanandapur', 'নিত্যানন্দপুর', 3, 29, 225, 10934, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:18'),
(2048, 'Umedpur', 'উমেদপুর', 3, 29, 225, 10935, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:20'),
(2049, 'Dudshar', 'দুধসর', 3, 29, 225, 10936, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:21'),
(2050, 'Fulhari', 'ফুলহরি', 3, 29, 225, 10937, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:23'),
(2051, 'Bhayna', 'ভায়না', 3, 29, 226, 10938, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:24'),
(2052, 'Joradah', 'জোড়াদহ', 3, 29, 226, 10939, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:26'),
(2053, 'Taherhuda', 'তাহেরহুদা', 3, 29, 226, 10940, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:27'),
(2054, 'Daulatpur', 'দৌলতপুর', 3, 29, 226, 10941, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:29'),
(2055, 'Kapashatia', 'কাপাশহাটিয়া', 3, 29, 226, 10942, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:30'),
(2056, 'Falsi', 'ফলসী', 3, 29, 226, 10943, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:32'),
(2057, 'Raghunathpur', 'রঘুনাথপুর', 3, 29, 226, 10944, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:33'),
(2058, 'Chandpur', 'চাঁদপুর', 3, 29, 226, 10945, 1, 1, 1, '2021-02-13 15:18:33', '2023-02-22 03:17:35'),
(2059, 'Sundarpurdurgapur', 'সুন্দরপুর-দূর্গাপুর', 3, 29, 227, 10946, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:36'),
(2060, 'Jamal', 'জামাল', 3, 29, 227, 10947, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:38'),
(2061, 'Kola', 'কোলা', 3, 29, 227, 10948, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:40'),
(2062, 'Niamatpur', 'নিয়ামতপুর', 3, 29, 227, 10949, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:41'),
(2063, 'Simla-Rokonpur', 'শিমলা-রোকনপুর', 3, 29, 227, 10950, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:43'),
(2064, 'Trilochanpur', 'ত্রিলোচনপুর', 3, 29, 227, 10951, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:44'),
(2065, 'Raygram', 'রায়গ্রাম', 3, 29, 227, 10952, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:46'),
(2066, 'Maliat', 'মালিয়াট', 3, 29, 227, 10953, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:47'),
(2067, 'Barabazar', 'বারবাজার', 3, 29, 227, 10954, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:49'),
(2068, 'Kashtabhanga', 'কাষ্টভাঙ্গা', 3, 29, 227, 10955, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:50'),
(2069, 'Rakhalgachhi', 'রাখালগাছি', 3, 29, 227, 10956, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:52'),
(2070, 'Sabdalpur', 'সাবদালপুর', 3, 29, 228, 10957, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:53'),
(2071, 'Dora', 'দোড়া', 3, 29, 228, 10958, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:55'),
(2072, 'Kushna', 'কুশনা', 3, 29, 228, 10959, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:56'),
(2073, 'Baluhar', 'বলুহর', 3, 29, 228, 10960, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:58'),
(2074, 'Elangi', 'এলাঙ্গী', 3, 29, 228, 10961, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:17:59'),
(2075, 'Sbk', 'এস, বি, কে', 3, 29, 229, 10962, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:01'),
(2076, 'Fatepur', 'ফতেপুর', 3, 29, 229, 10963, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:03'),
(2077, 'Panthapara', 'পান্থপাড়া', 3, 29, 229, 10964, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:04'),
(2078, 'Swaruppur', 'স্বরুপপুর', 3, 29, 229, 10965, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:06'),
(2079, 'Shyamkur', 'শ্যামকুড়', 3, 29, 229, 10966, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:07'),
(2080, 'Nepa', 'নেপা', 3, 29, 229, 10967, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:09'),
(2081, 'Kazirber', 'কাজীরবেড়', 3, 29, 229, 10968, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:10'),
(2082, 'Banshbaria', 'বাঁশবাড়ীয়া', 3, 29, 229, 10969, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:12'),
(2083, 'Jadabpur', 'যাদবপুর', 3, 29, 229, 10970, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:13'),
(2084, 'Natima', 'নাটিমা', 3, 29, 229, 10971, 1, 1, 1, '2021-02-13 15:18:34', '2023-02-22 03:18:15'),
(2085, 'Manderbaria', 'মান্দারবাড়ীয়া', 3, 29, 229, 10972, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:16'),
(2086, 'Azampur', 'আজমপুর', 3, 29, 229, 10973, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:18'),
(2087, 'Basanda', 'বাসন্ডা', 4, 30, 230, 10974, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:19'),
(2088, 'Binoykati', 'বিনয়কাঠী', 4, 30, 230, 10975, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:21'),
(2089, 'Gabharamchandrapur', 'গাভারামচন্দ্রপুর', 4, 30, 230, 10976, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:22'),
(2090, 'Keora', 'কেওড়া', 4, 30, 230, 10977, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:24'),
(2091, 'Kirtipasha', 'কীর্তিপাশা', 4, 30, 230, 10978, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:25'),
(2092, 'Nabagram', 'নবগ্রাম', 4, 30, 230, 10979, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:27'),
(2093, 'Nathullabad', 'নথুলল্লাবাদ', 4, 30, 230, 10980, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:28'),
(2094, 'Ponabalia', 'পোনাবালিয়া', 4, 30, 230, 10981, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:30'),
(2095, 'Sekherhat', 'শেখেরহাট', 4, 30, 230, 10982, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:32'),
(2096, 'Gabkhandhansiri', 'গাবখান ধানসিঁড়ি', 4, 30, 230, 10983, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:33'),
(2097, 'Amua', 'আমুয়া', 4, 30, 231, 10984, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:35'),
(2098, 'Awrabunia', 'আওরাবুনিয়া', 4, 30, 231, 10985, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:36'),
(2099, 'Chenchrirampur', 'চেঁচরীরামপুর', 4, 30, 231, 10986, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:38'),
(2100, 'Kanthalia', 'কাঠালিয়া', 4, 30, 231, 10987, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:39'),
(2101, 'Patikhalghata', 'পাটিখালঘাটা', 4, 30, 231, 10988, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:41'),
(2102, 'Shaulajalia', 'শৌলজালিয়া', 4, 30, 231, 10989, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:42'),
(2103, 'Subidpur', 'সুবিদপুর', 4, 30, 232, 10990, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:44'),
(2104, 'Siddhakati', 'সিদ্ধকাঠী', 4, 30, 232, 10991, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:45'),
(2105, 'Ranapasha', 'রানাপাশা', 4, 30, 232, 10992, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:47'),
(2106, 'Nachanmohal', 'নাচনমহল', 4, 30, 232, 10993, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:49'),
(2107, 'Mollahat', 'মোল্লারহাট', 4, 30, 232, 10994, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:50'),
(2108, 'Magar', 'মগর', 4, 30, 232, 10995, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:52'),
(2109, 'Kusanghal', 'কুশঙ্গল', 4, 30, 232, 10996, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:53'),
(2110, 'Kulkathi', 'কুলকাঠী', 4, 30, 232, 10997, 1, 1, 1, '2021-02-13 15:18:35', '2023-02-22 03:18:55'),
(2111, 'Dapdapia', 'দপদপিয়া', 4, 30, 232, 10998, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:18:56'),
(2112, 'Bharabpasha', 'ভৈরবপাশা', 4, 30, 232, 10999, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:18:58'),
(2113, 'Suktagarh', 'শুক্তাগড়', 4, 30, 233, 11000, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:18:59'),
(2114, 'Saturia', 'সাতুরিয়া', 4, 30, 233, 11001, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:01'),
(2115, 'Mathbari', 'মঠবাড়ী', 4, 30, 233, 11002, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:02'),
(2116, 'Galua', 'গালুয়া', 4, 30, 233, 11003, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:04'),
(2117, 'Baraia', 'বড়ইয়া', 4, 30, 233, 11004, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:05'),
(2118, 'Rajapur', 'রাজাপুর', 4, 30, 233, 11005, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:07'),
(2119, 'Adabaria', 'আদাবারিয়া', 4, 31, 234, 11006, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:08'),
(2120, 'Bauphal', 'বাউফল', 4, 31, 234, 11007, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:10'),
(2121, 'Daspara', 'দাস পাড়া', 4, 31, 234, 11008, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:11'),
(2122, 'Kalaiya', 'কালাইয়া', 4, 31, 234, 11009, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:13'),
(2123, 'Nawmala', 'নওমালা', 4, 31, 234, 11010, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:15'),
(2124, 'Najirpur', 'নাজিরপুর', 4, 31, 234, 11011, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:16'),
(2125, 'Madanpura', 'মদনপুরা', 4, 31, 234, 11012, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:18'),
(2126, 'Boga', 'বগা', 4, 31, 234, 11013, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:19'),
(2127, 'Kanakdia', 'কনকদিয়া', 4, 31, 234, 11014, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:21'),
(2128, 'Shurjamoni', 'সূর্য্যমনি', 4, 31, 234, 11015, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:22'),
(2129, 'Keshabpur', 'কেশবপুর', 4, 31, 234, 11016, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:24'),
(2130, 'Dhulia', 'ধুলিয়া', 4, 31, 234, 11017, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:25'),
(2131, 'Kalisuri', 'কালিশুরী', 4, 31, 234, 11018, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:27'),
(2132, 'Kachipara', 'কাছিপাড়া', 4, 31, 234, 11019, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:28'),
(2133, 'Laukathi', 'লাউকাঠী', 4, 31, 235, 11020, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:30'),
(2134, 'Lohalia', 'লোহালিয়া', 4, 31, 235, 11021, 1, 1, 1, '2021-02-13 15:18:36', '2023-02-22 03:19:31'),
(2135, 'Kamalapur', 'কমলাপুর', 4, 31, 235, 11022, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:33'),
(2136, 'Jainkathi', 'জৈনকাঠী', 4, 31, 235, 11023, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:34'),
(2137, 'Kalikapur', 'কালিকাপুর', 4, 31, 235, 11024, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:36'),
(2138, 'Badarpur', 'বদরপুর', 4, 31, 235, 11025, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:37'),
(2139, 'Itbaria', 'ইটবাড়ীয়া', 4, 31, 235, 11026, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:39'),
(2140, 'Marichbunia', 'মরিচবুনিয়া', 4, 31, 235, 11027, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:41'),
(2141, 'Auliapur', 'আউলিয়াপুর', 4, 31, 235, 11028, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:42'),
(2142, 'Chotobighai', 'ছোট বিঘাই', 4, 31, 235, 11029, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:44'),
(2143, 'Borobighai', 'বড় বিঘাই', 4, 31, 235, 11030, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:45'),
(2144, 'Madarbunia', 'মাদারবুনিয়া', 4, 31, 235, 11031, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:47'),
(2145, 'Pangasia', 'পাংগাশিয়া', 4, 31, 236, 11032, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:48'),
(2146, 'Muradia', 'মুরাদিয়া', 4, 31, 236, 11033, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:50'),
(2147, 'Labukhali', 'লেবুখালী', 4, 31, 236, 11034, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:51'),
(2148, 'Angaria', 'আংগারিয়া', 4, 31, 236, 11035, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:53'),
(2149, 'Sreerampur', 'শ্রীরামপুর', 4, 31, 236, 11036, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:54'),
(2150, 'Bashbaria', 'বাঁশবাড়ীয়া', 4, 31, 237, 11037, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:56'),
(2151, 'Rangopaldi', 'রণগোপালদী', 4, 31, 237, 11038, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:57'),
(2152, 'Alipur', 'আলীপুর', 4, 31, 237, 11039, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:19:59'),
(2153, 'Betagi Shankipur', 'বেতাগী সানকিপুর', 4, 31, 237, 11040, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:20:00'),
(2154, 'Dashmina', 'দশমিনা', 4, 31, 237, 11041, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:20:02'),
(2155, 'Baharampur', 'বহরমপুর', 4, 31, 237, 11042, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:20:04'),
(2156, 'Chakamaia', 'চাকামইয়া', 4, 31, 238, 11043, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:20:05'),
(2157, 'Tiakhali', 'টিয়াখালী', 4, 31, 238, 11044, 1, 1, 1, '2021-02-13 15:18:37', '2023-02-22 03:20:07'),
(2158, 'Lalua', 'লালুয়া', 4, 31, 238, 11045, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:08'),
(2159, 'Dhankhali', 'ধানখালী', 4, 31, 238, 11046, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:10'),
(2160, 'Mithagonj', 'মিঠাগঞ্জ', 4, 31, 238, 11047, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:11'),
(2161, 'Nilgonj', 'নীলগঞ্জ', 4, 31, 238, 11048, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:13'),
(2162, 'Dulaser', 'ধুলাসার', 4, 31, 238, 11049, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:14'),
(2163, 'Latachapli', 'লতাচাপলী', 4, 31, 238, 11050, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:16'),
(2164, 'Mahipur', 'মহিপুর', 4, 31, 238, 11051, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:18'),
(2165, 'Dalbugonj', 'ডালবুগঞ্জ', 4, 31, 238, 11052, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:19'),
(2166, 'Baliatali', 'বালিয়াতলী', 4, 31, 238, 11053, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:21'),
(2167, 'Champapur', 'চম্পাপুর', 4, 31, 238, 11054, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:22'),
(2168, 'Madhabkhali', 'মাধবখালী', 4, 31, 239, 11055, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:24'),
(2169, 'Mirzaganj', 'মির্জাগঞ্জ', 4, 31, 239, 11056, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:25'),
(2170, 'Amragachia', 'আমড়াগাছিয়া', 4, 31, 239, 11057, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:27'),
(2171, 'Deuli Subidkhali', 'দেউলী সুবিদখালী', 4, 31, 239, 11058, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:28'),
(2172, 'Kakrabunia', 'কাকড়াবুনিয়া', 4, 31, 239, 11059, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:30'),
(2173, 'Majidbaria', 'মজিদবাড়িয়া', 4, 31, 239, 11060, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:31'),
(2174, 'Amkhola', 'আমখোলা', 4, 31, 240, 11061, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:33'),
(2175, 'Golkhali', 'গোলখালী', 4, 31, 240, 11062, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:35'),
(2176, 'Galachipa', 'গলাচিপা', 4, 31, 240, 11063, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:36'),
(2177, 'Panpatty', 'পানপট্টি', 4, 31, 240, 11064, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:38'),
(2178, 'Ratandi Taltali', 'রতনদী তালতলী', 4, 31, 240, 11065, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:39'),
(2179, 'Dakua', 'ডাকুয়া', 4, 31, 240, 11066, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:41'),
(2180, 'Chiknikandi', 'চিকনিকান্দী', 4, 31, 240, 11067, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:42'),
(2181, 'Gazalia', 'গজালিয়া', 4, 31, 240, 11068, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:44'),
(2182, 'Charkajol', 'চরকাজল', 4, 31, 240, 11069, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:46'),
(2183, 'Charbiswas', 'চরবিশ্বাস', 4, 31, 240, 11070, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:47'),
(2184, 'Bakulbaria', 'বকুলবাড়ীয়া', 4, 31, 240, 11071, 1, 1, 1, '2021-02-13 15:18:38', '2023-02-22 03:20:49'),
(2185, 'Kalagachhia', 'কলাগাছিয়া', 4, 31, 240, 11072, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:20:51'),
(2186, 'Rangabali', 'রাঙ্গাবালী', 4, 31, 241, 11073, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:20:52'),
(2187, 'Barobaisdia', 'বড়বাইশদিয়া', 4, 31, 241, 11074, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:20:54'),
(2188, 'Chattobaisdia', 'ছোটবাইশদিয়া', 4, 31, 241, 11075, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:20:56'),
(2189, 'Charmontaz', 'চরমোন্তাজ', 4, 31, 241, 11076, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:20:58'),
(2190, 'Chalitabunia', 'চালিতাবুনিয়া', 4, 31, 241, 11077, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:00'),
(2191, 'Shikder Mallik', 'শিকদার মল্লিক', 4, 32, 242, 11078, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:04'),
(2192, 'Kodomtala', 'কদমতলা', 4, 32, 242, 11079, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:07'),
(2193, 'Durgapur', 'দূর্গাপুর', 4, 32, 242, 11080, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:08'),
(2194, 'Kolakhali', 'কলাখালী', 4, 32, 242, 11081, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:10'),
(2195, 'Tona', 'টোনা', 4, 32, 242, 11082, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:11'),
(2196, 'Shariktola', 'শরিকতলা', 4, 32, 242, 11083, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:13'),
(2197, 'Shankorpasa', 'শংকরপাশা', 4, 32, 242, 11084, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:14'),
(2198, 'Mativangga', 'মাটিভাংগা', 4, 32, 243, 11085, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:16'),
(2199, 'Malikhali', 'মালিখালী', 4, 32, 243, 11086, 1, 1, 1, '2021-02-13 15:18:39', '2023-02-22 03:21:18'),
(2200, 'Daulbari Dobra', 'দেউলবাড়ী দোবড়া', 4, 32, 243, 11087, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:19'),
(2201, 'Dirgha', 'দীর্ঘা', 4, 32, 243, 11088, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:21'),
(2202, 'Kolardoania', 'কলারদোয়ানিয়া', 4, 32, 243, 11089, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:22'),
(2203, 'Sriramkathi', 'শ্রীরামকাঠী', 4, 32, 243, 11090, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:24'),
(2204, 'Shakhmatia', 'সেখমাটিয়া', 4, 32, 243, 11091, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:25'),
(2205, 'Nazirpur Sadar', 'নাজিরপুর সদর', 4, 32, 243, 11092, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:27'),
(2206, 'Shakharikathi', 'শাখারীকাঠী', 4, 32, 243, 11093, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:28'),
(2207, 'Sayna Rogunathpur', 'সয়না রঘুনাথপুর', 4, 32, 244, 11094, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:30'),
(2208, 'Amrazuri', 'আমড়াজুড়ি', 4, 32, 244, 11095, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:31'),
(2209, 'Kawkhali Sadar', 'কাউখালি সদর', 4, 32, 244, 11096, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:33'),
(2210, 'Chirapara', 'চিরাপাড়া', 4, 32, 244, 11097, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:34'),
(2211, 'Shialkhathi', 'শিয়ালকাঠী', 4, 32, 244, 11098, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:36'),
(2212, 'Balipara', 'বালিপাড়া', 4, 32, 245, 11099, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:37'),
(2213, 'Pattashi', 'পত্তাশি', 4, 32, 245, 11100, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:39'),
(2214, 'Parerhat', 'পাড়েরহাট', 4, 32, 245, 11101, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:41'),
(2215, 'Vitabaria', 'ভিটাবাড়িয়া', 4, 32, 246, 11102, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:42'),
(2216, 'Nodmulla', 'নদমূলা শিয়ালকাঠী', 4, 32, 246, 11103, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:44'),
(2217, 'Telikhali', 'তেলিখালী', 4, 32, 246, 11104, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:45'),
(2218, 'Ekree', 'ইকড়ী', 4, 32, 246, 11105, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:47'),
(2219, 'Dhaoa', 'ধাওয়া', 4, 32, 246, 11106, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:48'),
(2220, 'Vandaria Sadar', 'ভান্ডারিয়া সদর', 4, 32, 246, 11107, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:50'),
(2221, 'Gouripur', 'গৌরীপুর', 4, 32, 246, 11108, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:51'),
(2222, 'Tuskhali', 'তুষখালী', 4, 32, 247, 11109, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:53'),
(2223, 'Dhanisafa', 'ধানীসাফা', 4, 32, 247, 11110, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:54'),
(2224, 'Mirukhali', 'মিরুখালী', 4, 32, 247, 11111, 1, 1, 1, '2021-02-13 15:18:40', '2023-02-22 03:21:56'),
(2225, 'Tikikata', 'টিকিকাটা', 4, 32, 247, 11112, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:21:57'),
(2226, 'Betmor Rajpara', 'বেতমোর রাজপাড়া', 4, 32, 247, 11113, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:21:59'),
(2227, 'Amragachia', 'আমড়াগাছিয়া', 4, 32, 247, 11114, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:00'),
(2228, 'Shapleza', 'শাপলেজা', 4, 32, 247, 11115, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:02'),
(2229, 'Daudkhali', 'দাউদখালী', 4, 32, 247, 11116, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:04'),
(2230, 'Mathbaria', 'মঠবাড়িয়া', 4, 32, 247, 11117, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:05'),
(2231, 'Baramasua', 'বড়মাছুয়া', 4, 32, 247, 11118, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:07'),
(2232, 'Haltagulishakhali', 'হলতাগুলিশাখালী', 4, 32, 247, 11119, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:08'),
(2233, 'Boldia', 'বলদিয়া', 4, 32, 248, 11120, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:10'),
(2234, 'Sohagdal', 'সোহাগদল', 4, 32, 248, 11121, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:12'),
(2235, 'Atghorkuriana', 'আটঘর কুড়িয়ানা', 4, 32, 248, 11122, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:13'),
(2236, 'Jolabari', 'জলাবাড়ী', 4, 32, 248, 11123, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:15'),
(2237, 'Doyhary', 'দৈহারী', 4, 32, 248, 11124, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:16'),
(2238, 'Guarekha', 'গুয়ারেখা', 4, 32, 248, 11125, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:18'),
(2239, 'Somudoykathi', 'সমুদয়কাঠী', 4, 32, 248, 11126, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:19'),
(2240, 'Sutiakathi', 'সুটিয়াকাঠী', 4, 32, 248, 11127, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:21'),
(2241, 'Sarengkathi', 'সারেংকাঠী', 4, 32, 248, 11128, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:22'),
(2242, 'Shorupkathi', 'স্বরুপকাঠী', 4, 32, 248, 11129, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:24'),
(2243, 'Raipasha Karapur', 'রায়পাশা কড়াপুর', 4, 33, 249, 11130, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:25'),
(2244, 'Kashipur', 'কাশীপুর', 4, 33, 249, 11131, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:27'),
(2245, 'Charbaria', 'চরবাড়িয়া', 4, 33, 249, 11132, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:28'),
(2246, 'Shyastabad', 'সায়েস্তাবাদ', 4, 33, 249, 11133, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:30'),
(2247, 'Charmonai', 'চরমোনাই', 4, 33, 249, 11134, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:31'),
(2248, 'Zagua', 'জাগুয়া', 4, 33, 249, 11135, 1, 1, 1, '2021-02-13 15:18:41', '2023-02-22 03:22:33'),
(2249, 'Charcowa', 'চরকাউয়া', 4, 33, 249, 11136, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:35'),
(2250, 'Chandpura', 'চাঁদপুরা', 4, 33, 249, 11137, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:36'),
(2251, 'Tungibaria', 'টুঙ্গীবাড়িয়া', 4, 33, 249, 11138, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:38'),
(2252, 'Chandramohan', 'চন্দ্রমোহন', 4, 33, 249, 11139, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:39'),
(2253, 'Charamaddi', 'চরামদ্দি', 4, 33, 250, 11140, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:41'),
(2254, 'Charade', 'চরাদি', 4, 33, 250, 11141, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:42'),
(2255, 'Darial', 'দাড়িয়াল', 4, 33, 250, 11142, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:44'),
(2256, 'Dudhal', 'দুধল', 4, 33, 250, 11143, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:45'),
(2257, 'Durgapasha', 'দুর্গাপাশা', 4, 33, 250, 11144, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:47'),
(2258, 'Faridpur', 'ফরিদপুর', 4, 33, 250, 11145, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:48'),
(2259, 'Kabai', 'কবাই', 4, 33, 250, 11146, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:50'),
(2260, 'Nalua', 'নলুয়া', 4, 33, 250, 11147, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:51'),
(2261, 'Kalashkathi', 'কলসকাঠী', 4, 33, 250, 11148, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:53'),
(2262, 'Garuria', 'গারুরিয়া', 4, 33, 250, 11149, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:54'),
(2263, 'Bharpasha', 'ভরপাশা', 4, 33, 250, 11150, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:56'),
(2264, 'Rangasree', 'রঙ্গশ্রী', 4, 33, 250, 11151, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:57'),
(2265, 'Padreeshibpur', 'পাদ্রিশিবপুর', 4, 33, 250, 11152, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:22:59'),
(2266, 'Niamoti', 'নিয়ামতি', 4, 33, 250, 11153, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:00'),
(2267, 'Jahangir Nagar', 'জাহাঙ্গীর নগর', 4, 33, 251, 11154, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:02'),
(2268, 'Kaderpur', 'কেদারপুর', 4, 33, 251, 11155, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:04'),
(2269, 'Deherhoti', 'দেহেরগতি', 4, 33, 251, 11156, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:05'),
(2270, 'Chandpasha', 'চাঁদপাশা', 4, 33, 251, 11157, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:07'),
(2271, 'Rahamtpur', 'রহমতপুর', 4, 33, 251, 11158, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:09'),
(2272, 'Madhbpasha', 'মাধবপাশা', 4, 33, 251, 11159, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:10'),
(2273, 'Shatla', 'সাতলা', 4, 33, 252, 11160, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:12'),
(2274, 'Harta', 'হারতা', 4, 33, 252, 11161, 1, 1, 1, '2021-02-13 15:18:42', '2023-02-22 03:23:14'),
(2275, 'Jalla', 'জল্লা', 4, 33, 252, 11162, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:17'),
(2276, 'Otra', 'ওটরা', 4, 33, 252, 11163, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:18'),
(2277, 'Sholok', 'শোলক', 4, 33, 252, 11164, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:20'),
(2278, 'Barakhota', 'বরাকোঠা', 4, 33, 252, 11165, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:22'),
(2279, 'Bamrail', 'বামরাইল', 4, 33, 252, 11166, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:24'),
(2280, 'Shikerpur Wazirpur', 'শিকারপুর উজিরপুর', 4, 33, 252, 11167, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:25'),
(2281, 'Gouthia', 'গুঠিয়া', 4, 33, 252, 11168, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:27'),
(2282, 'Bisharkandi', 'বিশারকান্দি', 4, 33, 253, 11169, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:28'),
(2283, 'Illuhar', 'ইলুহার', 4, 33, 253, 11170, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:30'),
(2284, 'Sayedkathi', 'সৈয়দকাঠী', 4, 33, 253, 11171, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:31'),
(2285, 'Chakhar', 'চাখার', 4, 33, 253, 11172, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:33'),
(2286, 'Saliabakpur', 'সলিয়াবাকপুর', 4, 33, 253, 11173, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:34'),
(2287, 'Baishari', 'বাইশারী', 4, 33, 253, 11174, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:36'),
(2288, 'Banaripara', 'বানারিপাড়া', 4, 33, 253, 11175, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:38'),
(2289, 'Udykhati', 'উদয়কাঠী', 4, 33, 253, 11176, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:39'),
(2290, 'Khanjapur', 'খাঞ্জাপুর', 4, 33, 254, 11177, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:41'),
(2291, 'Barthi', 'বার্থী', 4, 33, 254, 11178, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:42'),
(2292, 'Chandshi', 'চাঁদশী', 4, 33, 254, 11179, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:44'),
(2293, 'Mahilara', 'মাহিলারা', 4, 33, 254, 11180, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:45'),
(2294, 'Nalchira', 'নলচিড়া', 4, 33, 254, 11181, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:47'),
(2295, 'Batajore', 'বাটাজোর', 4, 33, 254, 11182, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:48'),
(2296, 'Sarikal', 'সরিকল', 4, 33, 254, 11183, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:50'),
(2297, 'Rajihar', 'রাজিহার', 4, 33, 255, 11184, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:51'),
(2298, 'Bakal', 'বাকাল', 4, 33, 255, 11185, 1, 1, 1, '2021-02-13 15:18:43', '2023-02-22 03:23:53'),
(2299, 'Bagdha', 'বাগধা', 4, 33, 255, 11186, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:23:54'),
(2300, 'Goila', 'গৈলা', 4, 33, 255, 11187, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:23:56'),
(2301, 'Ratnapur', 'রত্নপুর', 4, 33, 255, 11188, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:23:57'),
(2302, 'Andarmanik', 'আন্দারমানিক', 4, 33, 256, 11189, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:23:59'),
(2303, 'Lata', 'লতা', 4, 33, 256, 11190, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:01'),
(2304, 'Charakkorea', 'চরএককরিয়া', 4, 33, 256, 11191, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:02'),
(2305, 'Ulania', 'উলানিয়া', 4, 33, 256, 11192, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:04'),
(2306, 'Mehendigong', 'মেহেন্দিগঞ্জ', 4, 33, 256, 11193, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:05'),
(2307, 'Biddanandapur', 'বিদ্যানন্দনপুর', 4, 33, 256, 11194, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:07'),
(2308, 'Bhashanchar', 'ভাষানচর', 4, 33, 256, 11195, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:08'),
(2309, 'Jangalia', 'জাঙ্গালিয়া', 4, 33, 256, 11196, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:10'),
(2310, 'Alimabad', 'আলিমাবাদ', 4, 33, 256, 11197, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:11'),
(2311, 'Chandpur', 'চানপুর', 4, 33, 256, 11198, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:13'),
(2312, 'Darirchar Khajuria', 'দড়িরচর খাজুরিয়া', 4, 33, 256, 11199, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:14'),
(2313, 'Gobindapur', 'গোবিন্দপুর', 4, 33, 256, 11200, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:16'),
(2314, 'Chargopalpur', 'চরগোপালপুর', 4, 33, 256, 11201, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:17'),
(2315, 'Batamara', 'বাটামারা', 4, 33, 257, 11202, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:19'),
(2316, 'Nazirpur', 'নাজিরপুর', 4, 33, 257, 11203, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:20'),
(2317, 'Safipur', 'সফিপুর', 4, 33, 257, 11204, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:22'),
(2318, 'Gaschua', 'গাছুয়া', 4, 33, 257, 11205, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:24'),
(2319, 'Charkalekha', 'চরকালেখা', 4, 33, 257, 11206, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:25'),
(2320, 'Muladi', 'মুলাদী', 4, 33, 257, 11207, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:27'),
(2321, 'Kazirchar', 'কাজিরচর', 4, 33, 257, 11208, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:28'),
(2322, 'Harinathpur', 'হরিনাথপুর', 4, 33, 258, 11209, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:30'),
(2323, 'Memania', 'মেমানিয়া', 4, 33, 258, 11210, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:31'),
(2324, 'Guabaria', 'গুয়াবাড়িয়া', 4, 33, 258, 11211, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:33'),
(2325, 'Barjalia', 'বড়জালিয়া', 4, 33, 258, 11212, 1, 1, 1, '2021-02-13 15:18:44', '2023-02-22 03:24:34'),
(2326, 'Hizla Gourabdi', 'হিজলা গৌরাব্দি', 4, 33, 258, 11213, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:36'),
(2327, 'Dhulkhola', 'ধুলখোলা', 4, 33, 258, 11214, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:37'),
(2328, 'Razapur', 'রাজাপুর', 4, 34, 259, 11215, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:39'),
(2329, 'Ilisha', 'ইলিশা', 4, 34, 259, 11216, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:40'),
(2330, 'Westilisa', 'পশ্চিম ইলিশা', 4, 34, 259, 11217, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:42'),
(2331, 'Kachia', 'কাচিয়া', 4, 34, 259, 11218, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:43'),
(2332, 'Bapta', 'বাপ্তা', 4, 34, 259, 11219, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:45'),
(2333, 'Dhania', 'ধনিয়া', 4, 34, 259, 11220, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:46'),
(2334, 'Shibpur', 'শিবপুর', 4, 34, 259, 11221, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:48'),
(2335, 'Alinagor', 'আলীনগর', 4, 34, 259, 11222, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:50'),
(2336, 'Charshamya', 'চরসামাইয়া', 4, 34, 259, 11223, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:51'),
(2337, 'Vhelumia', ' ভেলুমিয়া', 4, 34, 259, 11224, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:53'),
(2338, 'Vheduria', 'ভেদুরিয়া', 4, 34, 259, 11225, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:54'),
(2339, 'North Digholdi', 'উত্তর দিঘলদী', 4, 34, 259, 11226, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:56'),
(2340, 'South Digholdi', 'দক্ষিণ দিঘলদী', 4, 34, 259, 11227, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:57'),
(2341, 'Boromanika', 'বড় মানিকা', 4, 34, 260, 11228, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:24:59'),
(2342, 'Deula', 'দেউলা', 4, 34, 260, 11229, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:00'),
(2343, 'Kutuba', 'কুতুবা', 4, 34, 260, 11230, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:02'),
(2344, 'Pakshia', 'পক্ষিয়া', 4, 34, 260, 11231, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:03'),
(2345, 'Kachia', 'কাচিয়া', 4, 34, 260, 11232, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:05'),
(2346, 'Osmangonj', 'ওসমানগঞ্জ', 4, 34, 261, 11233, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:06'),
(2347, 'Aslampur', 'আছলামপুর', 4, 34, 261, 11234, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:08'),
(2348, 'Zinnagor', 'জিন্নাগড়', 4, 34, 261, 11235, 1, 1, 1, '2021-02-13 15:18:45', '2023-02-22 03:25:09'),
(2349, 'Aminabad', 'আমিনাবাদ', 4, 34, 261, 11236, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:11'),
(2350, 'Nilkomol', 'নীলকমল', 4, 34, 261, 11237, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:13'),
(2351, 'Charmadraj', 'চরমাদ্রাজ', 4, 34, 261, 11238, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:14'),
(2352, 'Awajpur', 'আওয়াজপুর', 4, 34, 261, 11239, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:16'),
(2353, 'Awajpur', 'আওয়াজপুর', 4, 34, 261, 11240, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:17'),
(2354, 'Charkolmi', 'চরকলমী', 4, 34, 261, 11241, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:19'),
(2355, 'Charmanika', 'চরমানিকা', 4, 34, 261, 11242, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:20'),
(2356, 'Hazarigonj', 'হাজারীগঞ্জ', 4, 34, 261, 11243, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:22'),
(2357, 'Jahanpur', 'জাহানপুর', 4, 34, 261, 11244, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:23'),
(2358, 'Nurabad', 'নুরাবাদ', 4, 34, 261, 11245, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:25'),
(2359, 'Rasulpur', 'রসুলপুর', 4, 34, 261, 11246, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:26'),
(2360, 'Kukrimukri', 'কুকরীমূকরী', 4, 34, 261, 11247, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:28'),
(2361, 'Abubakarpur', 'আবুবকরপুর', 4, 34, 261, 11248, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:29'),
(2362, 'Abdullahpur', 'আবদুল্লাহ', 4, 34, 261, 11249, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:31'),
(2363, 'Nazrulnagar', 'নজরুল নগর', 4, 34, 261, 11250, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:32'),
(2364, 'Mujibnagar', 'মুজিব নগর', 4, 34, 261, 11251, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:34'),
(2365, 'Dalchar', 'ঢালচর', 4, 34, 261, 11252, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:35'),
(2366, 'Madanpur', 'মদনপুর', 4, 34, 262, 11253, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:37'),
(2367, 'Madua', 'মেদুয়া', 4, 34, 262, 11254, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:39'),
(2368, 'Charpata', 'চরপাতা', 4, 34, 262, 11255, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:40'),
(2369, 'North Joy Nagar', 'উত্তর জয়নগর', 4, 34, 262, 11256, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:42'),
(2370, 'South Joy Nagar', 'দক্ষিন জয়নগর', 4, 34, 262, 11257, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:43'),
(2371, 'Char Khalipa', 'চর খলিফা', 4, 34, 262, 11258, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:45'),
(2372, 'Sayedpur', 'সৈয়দপুর', 4, 34, 262, 11259, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:46'),
(2373, 'Hazipur', 'হাজীপুর', 4, 34, 262, 11260, 1, 1, 1, '2021-02-13 15:18:46', '2023-02-22 03:25:48'),
(2374, 'Vhovanipur', 'ভবানীপুর', 4, 34, 262, 11261, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:49'),
(2375, 'Hazirhat', 'হাজীর হাট', 4, 34, 263, 11262, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:51'),
(2376, 'Monpura', 'মনপুরা', 4, 34, 263, 11263, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:52'),
(2377, 'North Sakuchia', 'উত্তর সাকুচিয়া', 4, 34, 263, 11264, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:54'),
(2378, 'South Sakuchia', 'দক্ষিন সাকুচিয়া', 4, 34, 263, 11265, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:55'),
(2379, 'Chanchra', 'চাচঁড়া', 4, 34, 264, 11266, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:57'),
(2380, 'Shambupur', 'শম্ভুপুর', 4, 34, 264, 11267, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:25:59'),
(2381, 'Sonapur', 'সোনাপুর', 4, 34, 264, 11268, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:01'),
(2382, 'Chadpur', 'চাঁদপুর', 4, 34, 264, 11269, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:02'),
(2383, 'Baro Molongchora', 'বড় মলংচড়া', 4, 34, 264, 11270, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:04'),
(2384, 'Badarpur', 'বদরপুর', 4, 34, 265, 11271, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:05'),
(2385, 'Charbhuta', 'চরভূতা', 4, 34, 265, 11272, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:07'),
(2386, 'Kalma', ' কালমা', 4, 34, 265, 11273, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:09'),
(2387, 'Dholigour Nagar', 'ধলীগৌর নগর', 4, 34, 265, 11274, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:10'),
(2388, 'Lalmohan', 'লালমোহন', 4, 34, 265, 11275, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:12'),
(2389, 'Lord Hardinge', 'লর্ড হার্ডিঞ্জ', 4, 34, 265, 11276, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:13'),
(2390, 'Ramagonj', 'রমাগঞ্জ', 4, 34, 265, 11277, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:15'),
(2391, 'Paschim Char Umed', 'পশ্চিম চর উমেদ', 4, 34, 265, 11278, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:16'),
(2392, 'Farajgonj', 'ফরাজগঞ্জ', 4, 34, 265, 11279, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:18'),
(2393, 'Amtali', 'আমতলী', 4, 35, 266, 11280, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:19'),
(2394, 'Gulishakhali', 'গুলিশাখালী', 4, 35, 266, 11281, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:22'),
(2395, 'Athrogasia', 'আঠারগাছিয়া', 4, 35, 266, 11282, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:24'),
(2396, 'Kukua', 'কুকুয়া', 4, 35, 266, 11283, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:26'),
(2397, 'Haldia', 'হলদিয়া', 4, 35, 266, 11284, 1, 1, 1, '2021-02-13 15:18:47', '2023-02-22 03:26:27'),
(2398, 'Chotobogi', 'ছোটবগী', 4, 35, 266, 11285, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:29'),
(2399, 'Arpangasia', 'আড়পাঙ্গাশিয়া', 4, 35, 266, 11286, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:31'),
(2400, 'Chowra', 'চাওড়া', 4, 35, 266, 11287, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:32'),
(2401, 'M. Baliatali', 'এম. বালিয়াতলী', 4, 35, 267, 11288, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:34'),
(2402, 'Noltona', 'নলটোনা', 4, 35, 267, 11289, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:35'),
(2403, 'Bodorkhali', 'বদরখালী', 4, 35, 267, 11290, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:37'),
(2404, 'Gowrichanna', 'গৌরিচন্না', 4, 35, 267, 11291, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:39'),
(2405, 'Fuljhuri', 'ফুলঝুড়ি', 4, 35, 267, 11292, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:40');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(2406, 'Keorabunia', 'কেওড়াবুনিয়া', 4, 35, 267, 11293, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:42'),
(2407, 'Ayla Patakata', 'আয়লা পাতাকাটা', 4, 35, 267, 11294, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:43'),
(2408, 'Burirchor', 'বুড়িরচর', 4, 35, 267, 11295, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:45'),
(2409, 'Dhalua', 'ঢলুয়া', 4, 35, 267, 11296, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:46'),
(2410, 'Barguna', 'বরগুনা', 4, 35, 267, 11297, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:48'),
(2411, 'Bibichini', 'বিবিচিন', 4, 35, 268, 11298, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:49'),
(2412, 'Betagi', 'বেতাগী', 4, 35, 268, 11299, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:51'),
(2413, 'Hosnabad', 'হোসনাবাদ', 4, 35, 268, 11300, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:52'),
(2414, 'Mokamia', 'মোকামিয়া', 4, 35, 268, 11301, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:54'),
(2415, 'Buramajumder', 'বুড়ামজুমদার', 4, 35, 268, 11302, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:55'),
(2416, 'Kazirabad', 'কাজীরাবাদ', 4, 35, 268, 11303, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:57'),
(2417, 'Sarisamuri', 'সরিষামুড়ী', 4, 35, 268, 11304, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:26:59'),
(2418, 'Bukabunia', 'বুকাবুনিয়া', 4, 35, 269, 11305, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:27:00'),
(2419, 'Bamna', 'বামনা', 4, 35, 269, 11306, 1, 1, 1, '2021-02-13 15:18:48', '2023-02-22 03:27:02'),
(2420, 'Ramna', 'রামনা', 4, 35, 269, 11307, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:03'),
(2421, 'Doutola', 'ডৌয়াতলা', 4, 35, 269, 11308, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:05'),
(2422, 'Raihanpur', 'রায়হানপুর', 4, 35, 270, 11309, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:06'),
(2423, 'Nachnapara', 'নাচনাপাড়া', 4, 35, 270, 11310, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:08'),
(2424, 'Charduany', 'চরদুয়ানী', 4, 35, 270, 11311, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:09'),
(2425, 'Patharghata', 'পাথরঘাটা', 4, 35, 270, 11312, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:11'),
(2426, 'Kalmegha', 'কালমেঘা', 4, 35, 270, 11313, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:13'),
(2427, 'Kakchira', 'কাকচিঢ়া', 4, 35, 270, 11314, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:14'),
(2428, 'Kathaltali', 'কাঠালতলী', 4, 35, 270, 11315, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:16'),
(2429, 'Karibaria', 'কড়ইবাড়ীয়া', 4, 35, 271, 11316, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:17'),
(2430, 'Panchakoralia', 'পচাকোড়ালিয়া', 4, 35, 271, 11317, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:19'),
(2431, 'Barabagi', 'বড়বগি', 4, 35, 271, 11318, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:20'),
(2432, 'Chhotabagi', 'ছোটবগি', 4, 35, 271, 11319, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:22'),
(2433, 'Nishanbaria', 'নিশানবাড়ীয়া', 4, 35, 271, 11320, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:23'),
(2434, 'Sarikkhali', 'শারিকখালি', 4, 35, 271, 11321, 1, 1, 1, '2021-02-13 15:18:49', '2023-02-22 03:27:27'),
(2435, 'Sonakata', 'সোনাকাটা', 4, 35, 271, 11322, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:29'),
(2436, 'Tazpur', 'তাজপুর', 5, 36, 284, 11323, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:31'),
(2437, 'Umorpur', 'উমরপুর', 5, 36, 284, 11324, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:32'),
(2438, 'West Poilanpur', 'পশ্চিম পৈলনপুর', 5, 36, 284, 11325, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:34'),
(2439, 'East Poilanpur', 'পূর্ব পৈলনপুর', 5, 36, 272, 11326, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:36'),
(2440, 'Boaljur', 'বোয়ালজুর', 5, 36, 272, 11327, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:38'),
(2441, 'Burungabazar', 'বুরুঙ্গাবাজার', 5, 36, 284, 11328, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:39'),
(2442, 'Goalabazar', 'গোয়ালাবাজার', 5, 36, 284, 11329, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:41'),
(2443, 'Doyamir', 'দয়ামীর', 5, 36, 284, 11330, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:42'),
(2444, 'Usmanpur', 'উসমানপুর', 5, 36, 284, 11331, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:44'),
(2445, 'Dewanbazar', 'দেওয়ান বাজার', 5, 36, 272, 11332, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:45'),
(2446, 'West Gouripur', 'পশ্চিম গৌরীপুর', 5, 36, 272, 11333, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:47'),
(2447, 'East Gouripur', 'পূর্ব গৌরীপুর', 5, 36, 272, 11334, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:49'),
(2448, 'Balaganj', 'বালাগঞ্জ', 5, 36, 272, 11335, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:50'),
(2449, 'Sadipur', 'সাদিরপুর', 5, 36, 284, 11336, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:52'),
(2450, 'Tilpara', 'তিলপাড়া', 5, 36, 273, 11337, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:53'),
(2451, 'Alinagar', 'আলীনগর', 5, 36, 273, 11338, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:55'),
(2452, 'Charkhai', 'চরখাই', 5, 36, 273, 11339, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:56'),
(2453, 'Dubag', 'দুবাগ', 5, 36, 273, 11340, 1, 1, 1, '2021-02-13 15:18:50', '2023-02-22 03:27:58'),
(2454, 'Sheola', 'শেওলা', 5, 36, 273, 11341, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:27:59'),
(2455, 'Kurarbazar', 'কুড়ারবাজার', 5, 36, 273, 11342, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:01'),
(2456, 'Mathiura', 'মাথিউরা', 5, 36, 273, 11343, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:02'),
(2457, 'Mullapur', 'মোল্লাপুর', 5, 36, 273, 11344, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:04'),
(2458, 'Muria', 'মুড়িয়া', 5, 36, 273, 11345, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:05'),
(2459, 'Lauta', 'লাউতা', 5, 36, 273, 11346, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:07'),
(2460, 'Rampasha', 'রামপাশা', 5, 36, 274, 11347, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:09'),
(2461, 'Lamakazi', 'লামাকাজী', 5, 36, 274, 11348, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:10'),
(2462, 'Khajanchi', 'খাজাঞ্চী', 5, 36, 274, 11349, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:12'),
(2463, 'Alankari', 'অলংকারী', 5, 36, 274, 11350, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:13'),
(2464, 'Dewkalash', 'দেওকলস', 5, 36, 274, 11351, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:15'),
(2465, 'Bishwanath', 'বিশ্বনাথ', 5, 36, 274, 11352, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:16'),
(2466, 'Doshghar', 'দশঘর', 5, 36, 274, 11353, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:18'),
(2467, 'Daulatpur', 'দৌলতপুর', 5, 36, 274, 11354, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:19'),
(2468, 'Telikhal', 'তেলিখাল', 5, 36, 275, 11355, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:21'),
(2469, 'Islampur Paschim', 'ইসলামপুর পশ্চিম', 5, 36, 275, 11356, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:22'),
(2470, 'Islampur Purba', 'ইসলামপুর পূর্ব', 5, 36, 275, 11357, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:24'),
(2471, 'Isakalas', 'ইসাকলস', 5, 36, 275, 11358, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:25'),
(2472, 'Uttor Ronikhai', 'উত্তর রনিখাই', 5, 36, 275, 11359, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:27'),
(2473, 'Dakkin Ronikhai', 'দক্ষিন রনিখাই', 5, 36, 275, 11360, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:28'),
(2474, 'Ghilachora', 'ঘিলাছড়া', 5, 36, 276, 11361, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:30'),
(2475, 'Fenchuganj', 'ফেঞ্চুগঞ্জ', 5, 36, 276, 11362, 1, 1, 1, '2021-02-13 15:18:51', '2023-02-22 03:28:31'),
(2476, 'Uttar Kushiara', 'উত্তর কুশিয়ারা', 5, 36, 276, 11363, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:33'),
(2477, 'Uttar Fenchuganj', 'উত্তর ফেঞ্চুগঞ্জ', 5, 36, 276, 11364, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:35'),
(2478, 'Maijgaon', 'মাইজগাঁও', 5, 36, 276, 11365, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:36'),
(2479, 'Golapganj', 'গোলাপগঞ্জ', 5, 36, 277, 11366, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:38'),
(2480, 'Fulbari', 'ফুলবাড়ী', 5, 36, 277, 11367, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:39'),
(2481, 'Lakshmipasha', 'লক্ষ্মীপাশা', 5, 36, 277, 11368, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:41'),
(2482, 'Budhbaribazar', 'বুধবারীবাজার', 5, 36, 277, 11369, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:43'),
(2483, 'Dhakadakshin', 'ঢাকাদক্ষিন', 5, 36, 277, 11370, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:44'),
(2484, 'Sharifganj', 'শরিফগঞ্জ', 5, 36, 277, 11371, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:46'),
(2485, 'Uttar Badepasha', 'উত্তর বাদেপাশা', 5, 36, 277, 11372, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:47'),
(2486, 'Lakshanaband', 'লক্ষনাবন্দ', 5, 36, 277, 11373, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:49'),
(2487, 'Bhadeshwar', 'ভাদেশ্বর', 5, 36, 277, 11374, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:50'),
(2488, 'West Amura', 'পশ্চিম আমুরা', 5, 36, 277, 11375, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:52'),
(2489, 'Fothepur', 'ফতেপুর', 5, 36, 278, 11376, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:53'),
(2490, 'Rustampur', 'রুস্তমপুর', 5, 36, 278, 11377, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:55'),
(2491, 'Paschim Jaflong', 'পশ্চিম জাফলং', 5, 36, 278, 11378, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:56'),
(2492, 'Purba Jaflong', 'পূর্ব জাফলং', 5, 36, 278, 11379, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:58'),
(2493, 'Lengura', 'লেঙ্গুড়া', 5, 36, 278, 11380, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:28:59'),
(2494, 'Alirgaon', 'আলীরগাঁও', 5, 36, 278, 11381, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:01'),
(2495, 'Nandirgaon', 'নন্দিরগাঁও', 5, 36, 278, 11382, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:02'),
(2496, 'Towakul', 'তোয়াকুল', 5, 36, 278, 11383, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:04'),
(2497, 'Daubari', 'ডৌবাড়ী', 5, 36, 278, 11384, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:05'),
(2498, 'Nijpat', 'নিজপাট', 5, 36, 279, 11385, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:07'),
(2499, 'Jaintapur', 'জৈন্তাপুর', 5, 36, 279, 11386, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:09'),
(2500, 'Charikatha', 'চারিকাটা', 5, 36, 279, 11387, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:10'),
(2501, 'Darbast', 'দরবস্ত', 5, 36, 279, 11388, 1, 1, 1, '2021-02-13 15:18:52', '2023-02-22 03:29:12'),
(2502, 'Fatehpur', 'ফতেপুর', 5, 36, 279, 11389, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:14'),
(2503, 'Chiknagul', 'চিকনাগুল', 5, 36, 279, 11390, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:16'),
(2504, 'Rajagonj', 'রাজাগঞ্জ', 5, 36, 280, 11391, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:18'),
(2505, 'Lakshiprashad Purbo', 'লক্ষীপ্রাসাদ পূর্ব', 5, 36, 280, 11392, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:20'),
(2506, 'Lakshiprashad Pashim', 'লক্ষীপ্রাসাদ পশ্চিম', 5, 36, 280, 11393, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:21'),
(2507, 'Digirpar Purbo', 'দিঘিরপার পূর্ব', 5, 36, 280, 11394, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:23'),
(2508, 'Satbakh', 'সাতবাক', 5, 36, 280, 11395, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:25'),
(2509, 'Barachotul', 'বড়চতুল', 5, 36, 280, 11396, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:26'),
(2510, 'Kanaighat', 'কানাইঘাট', 5, 36, 280, 11397, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:28'),
(2511, 'Dakhin Banigram', 'দক্ষিন বানিগ্রাম', 5, 36, 280, 11398, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:29'),
(2512, 'Jinghabari', 'ঝিঙ্গাবাড়ী', 5, 36, 280, 11399, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:31'),
(2513, 'Jalalabad', 'জালালাবাদ', 5, 36, 281, 11400, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:32'),
(2514, 'Hatkhula', 'হাটখোলা', 5, 36, 281, 11401, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:34'),
(2515, 'Khadimnagar', 'খাদিমনগর', 5, 36, 281, 11402, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:35'),
(2516, 'Khadimpara', 'খাদিমপাড়া', 5, 36, 281, 11403, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:37'),
(2517, 'Tultikor', 'টুলটিকর', 5, 36, 281, 11404, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:38'),
(2518, 'Tukerbazar', 'টুকেরবাজার', 5, 36, 281, 11405, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:40'),
(2519, 'Mugolgaon', 'মোগলগাও', 5, 36, 281, 11406, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:42'),
(2520, 'Kandigaon', 'কান্দিগাও', 5, 36, 281, 11407, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:43'),
(2521, 'Manikpur', 'মানিকপুর', 5, 36, 282, 11408, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:45'),
(2522, 'Sultanpur', 'সুলতানপুর', 5, 36, 282, 11409, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:46'),
(2523, 'Barohal', 'বারহাল', 5, 36, 282, 11410, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:48'),
(2524, 'Birorsri', 'বিরশ্রী', 5, 36, 282, 11411, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:49'),
(2525, 'Kajalshah', 'কাজলশার', 5, 36, 282, 11412, 1, 1, 1, '2021-02-13 15:18:53', '2023-02-22 03:29:51'),
(2526, 'Kolachora', 'কলাছড়া', 5, 36, 282, 11413, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:29:52'),
(2527, 'Zakiganj', 'জকিগঞ্জ', 5, 36, 282, 11414, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:29:54'),
(2528, 'Barothakuri', 'বারঠাকুরী', 5, 36, 282, 11415, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:29:56'),
(2529, 'Kaskanakpur', 'কসকনকপুর', 5, 36, 282, 11416, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:29:57'),
(2530, 'Lalabazar', 'লালাবাজার', 5, 36, 283, 11417, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:29:59'),
(2531, 'Moglabazar', 'মোগলাবাজার', 5, 36, 283, 11418, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:00'),
(2532, 'Boroikandi', 'বড়ইকান্দি', 5, 36, 283, 11419, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:02'),
(2533, 'Silam', 'সিলাম', 5, 36, 283, 11420, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:03'),
(2534, 'Daudpur', 'দাউদপুর', 5, 36, 283, 11421, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:05'),
(2535, 'Mollargaon', 'মোল্লারগাঁও', 5, 36, 283, 11422, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:07'),
(2536, 'Kuchai', 'কুচাই', 5, 36, 283, 11423, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:08'),
(2537, 'Kamalbazar', 'কামালবাজার', 5, 36, 283, 11424, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:10'),
(2538, 'Jalalpur', 'জালালপুর', 5, 36, 283, 11425, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:11'),
(2539, 'Tetli', 'তেতলী', 5, 36, 283, 11426, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:13'),
(2540, 'Talimpur', 'তালিমপুর', 5, 37, 285, 11427, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:15'),
(2541, 'Borni', 'বর্ণি', 5, 37, 285, 11428, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:16'),
(2542, 'Dasherbazar', 'দাসেরবাজার', 5, 37, 285, 11429, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:18'),
(2543, 'Nizbahadurpur', 'নিজবাহাদুরপুর', 5, 37, 285, 11430, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:19'),
(2544, 'Uttar Shahbajpur', 'উত্তর শাহবাজপুর', 5, 37, 285, 11431, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:21'),
(2545, 'Dakkhin Shahbajpur', 'দক্ষিণ শাহবাজপুর', 5, 37, 285, 11432, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:22'),
(2546, 'Talimpur', 'তালিমপুর', 5, 37, 285, 11433, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:24'),
(2547, 'Baralekha', 'বড়লেখা', 5, 37, 285, 11434, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:25'),
(2548, 'Dakshinbhag Uttar', 'দক্ষিণভাগ (উত্তর)', 5, 37, 285, 11435, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:27'),
(2549, 'Dakshinbhag Dakkhin', 'দক্ষিণভাগ (দক্ষিণ)', 5, 37, 285, 11436, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:28'),
(2550, 'Sujanagar', 'সুজানগর', 5, 37, 285, 11437, 1, 1, 1, '2021-02-13 15:18:54', '2023-02-22 03:30:30'),
(2551, 'Adampur', 'আদমপুর', 5, 37, 286, 11438, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:31'),
(2552, 'Patanushar', 'পতনঊষার', 5, 37, 286, 11439, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:34'),
(2553, 'Madhabpur', 'মাধবপুর', 5, 37, 286, 11440, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:36'),
(2554, 'Rahimpur', 'রহিমপুর', 5, 37, 286, 11441, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:37'),
(2555, 'Shamshernagar', 'শমশেরনগর', 5, 37, 286, 11442, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:39'),
(2556, 'Kamalgonj', 'কমলগঞ্জ', 5, 37, 286, 11443, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:40'),
(2557, 'Islampur', 'ইসলামপুর', 5, 37, 286, 11444, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:42'),
(2558, 'Munshibazar', 'মুন্সিবাজার', 5, 37, 286, 11445, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:43'),
(2559, 'Alinagar', 'আলী নগর', 5, 37, 286, 11446, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:45'),
(2560, 'Baramchal', 'বরমচাল', 5, 37, 287, 11447, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:46'),
(2561, 'Bhukshimail', 'ভূকশিমইল', 5, 37, 287, 11448, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:48'),
(2562, 'Joychandi', 'জয়চন্ডি', 5, 37, 287, 11449, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:49'),
(2563, 'Brammanbazar', 'ব্রাহ্মণবাজার', 5, 37, 287, 11450, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:51'),
(2564, 'Kadipur', 'কাদিপুর', 5, 37, 287, 11451, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:52'),
(2565, 'Kulaura', 'কুলাউড়া', 5, 37, 287, 11452, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:54'),
(2566, 'Rauthgaon', 'রাউৎগাঁও', 5, 37, 287, 11453, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:56'),
(2567, 'Tilagaon', 'টিলাগাঁও', 5, 37, 287, 11454, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:57'),
(2568, 'Sharifpur', 'শরীফপুর', 5, 37, 287, 11455, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:30:59'),
(2569, 'Prithimpassa', 'পৃথিমপাশা', 5, 37, 287, 11456, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:31:01'),
(2570, 'Kormodha', 'কর্মধা', 5, 37, 287, 11457, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:31:02'),
(2571, 'Bhatera', 'ভাটেরা', 5, 37, 287, 11458, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:31:04'),
(2572, 'Hazipur', 'হাজীপুর', 5, 37, 287, 11459, 1, 1, 1, '2021-02-13 15:18:55', '2023-02-22 03:31:06'),
(2573, 'Amtail', 'আমতৈল', 5, 37, 288, 11460, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:07'),
(2574, 'Khalilpur', 'খলিলপুর', 5, 37, 288, 11461, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:09'),
(2575, 'Monumukh', 'মনুমুখ', 5, 37, 288, 11462, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:10'),
(2576, 'Kamalpur', 'কামালপুর', 5, 37, 288, 11463, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:12'),
(2577, 'Apar Kagabala', 'আপার কাগাবলা', 5, 37, 288, 11464, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:13'),
(2578, 'Akhailkura', 'আখাইলকুড়া', 5, 37, 288, 11465, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:15'),
(2579, 'Ekatuna', 'একাটুনা', 5, 37, 288, 11466, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:16'),
(2580, 'Chadnighat', 'চাঁদনীঘাট', 5, 37, 288, 11467, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:18'),
(2581, 'Konokpur', 'কনকপুর', 5, 37, 288, 11468, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:19'),
(2582, 'Nazirabad', 'নাজিরাবাদ', 5, 37, 288, 11469, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:21'),
(2583, 'Mostafapur', 'মোস্তফাপুর', 5, 37, 288, 11470, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:22'),
(2584, 'Giasnagar', 'গিয়াসনগর', 5, 37, 288, 11471, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:24'),
(2585, 'Fotepur', 'ফতেপুর', 5, 37, 289, 11472, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:25'),
(2586, 'Uttorbhag', 'উত্তরভাগ', 5, 37, 289, 11473, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:27'),
(2587, 'Munsibazar', 'মুন্সিবাজার', 5, 37, 289, 11474, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:28'),
(2588, 'Panchgaon', 'পাঁচগাঁও', 5, 37, 289, 11475, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:30'),
(2589, 'Rajnagar', 'রাজনগর', 5, 37, 289, 11476, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:32'),
(2590, 'Tengra', 'টেংরা', 5, 37, 289, 11477, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:33'),
(2591, 'Kamarchak', 'কামারচাক', 5, 37, 289, 11478, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:35'),
(2592, 'Munsurnagar', 'মনসুরনগর', 5, 37, 289, 11479, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:36'),
(2593, 'Mirzapur', 'মির্জাপুর', 5, 37, 290, 11480, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:38'),
(2594, 'Bhunabir', 'ভূনবীর', 5, 37, 290, 11481, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:39'),
(2595, 'Sreemangal', 'শ্রীমঙ্গল', 5, 37, 290, 11482, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:41'),
(2596, 'Sindurkhan', 'সিন্দুরখান', 5, 37, 290, 11483, 1, 1, 1, '2021-02-13 15:18:56', '2023-02-22 03:31:42'),
(2597, 'Kalapur', 'কালাপুর', 5, 37, 290, 11484, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:44'),
(2598, 'Ashidron', 'আশিদ্রোন', 5, 37, 290, 11485, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:45'),
(2599, 'Rajghat', 'রাজঘাট', 5, 37, 290, 11486, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:47'),
(2600, 'Kalighat', 'কালীঘাট', 5, 37, 290, 11487, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:48'),
(2601, 'Satgaon', 'সাতগাঁও', 5, 37, 290, 11488, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:50'),
(2602, 'Jafornagar', 'জায়ফরনগর', 5, 37, 291, 11489, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:51'),
(2603, 'West Juri', 'পশ্চিম জুড়ী', 5, 37, 291, 11490, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:53'),
(2604, 'Gualbari', 'গোয়ালবাড়ী', 5, 37, 291, 11491, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:54'),
(2605, 'Sagornal', 'সাগরনাল', 5, 37, 291, 11492, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:56'),
(2606, 'Fultola', 'ফুলতলা', 5, 37, 291, 11493, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:57'),
(2607, 'Eastjuri', 'পুর্ব জুড়ী', 5, 37, 291, 11494, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:31:59'),
(2608, 'Barabhakoir Paschim', 'বড় ভাকৈর (পশ্চিম)', 5, 38, 292, 11495, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:01'),
(2609, 'Barabhakoir Purba', 'বড় ভাকৈর (পূর্ব)', 5, 38, 292, 11496, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:02'),
(2610, 'Inatganj', 'ইনাতগঞ্জ', 5, 38, 292, 11497, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:04'),
(2611, 'Digholbak', 'দীঘলবাক', 5, 38, 292, 11498, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:05'),
(2612, 'Aushkandi', 'আউশকান্দি', 5, 38, 292, 11499, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:07'),
(2613, 'Kurshi', 'কুর্শি', 5, 38, 292, 11500, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:08'),
(2614, 'Kargoan', 'করগাঁও', 5, 38, 292, 11501, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:10'),
(2615, 'Nabiganj Sadar', 'নবীগঞ্জ সদর', 5, 38, 292, 11502, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:11'),
(2616, 'Bausha', 'বাউসা', 5, 38, 292, 11503, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:13'),
(2617, 'Debparra', 'দেবপাড়া', 5, 38, 292, 11504, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:14'),
(2618, 'Gaznaipur', 'গজনাইপুর', 5, 38, 292, 11505, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:16'),
(2619, 'Kaliarbhanga', 'কালিয়ারভাংগা', 5, 38, 292, 11506, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:18'),
(2620, 'Paniumda', 'পানিউমদা', 5, 38, 292, 11507, 1, 1, 1, '2021-02-13 15:18:57', '2023-02-22 03:32:19'),
(2621, 'Snanghat', 'স্নানঘাট', 5, 38, 293, 11508, 1, 1, 1, '2021-02-13 15:18:58', '2023-02-22 03:32:21'),
(2622, 'Putijuri', 'পুটিজুরী', 5, 38, 293, 11509, 1, 1, 1, '2021-02-13 15:18:58', '2023-02-22 03:32:22'),
(2623, 'Satkapon', 'সাতকাপন', 5, 38, 293, 11510, 1, 1, 1, '2021-02-13 15:18:58', '2023-02-22 03:32:24'),
(2624, 'Bahubal Sadar', 'বাহুবল সদর', 5, 38, 293, 11511, 1, 1, 1, '2021-02-13 15:18:58', '2023-02-22 03:32:25'),
(2625, 'Lamatashi', 'লামাতাশী', 5, 38, 293, 11512, 1, 1, 1, '2021-02-13 15:18:58', '2023-02-22 03:32:27'),
(2626, 'Mirpur', 'মিরপুর', 5, 38, 293, 11513, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:28'),
(2627, 'Bhadeshwar', 'ভাদেশ্বর', 5, 38, 293, 11514, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:30'),
(2628, 'Shibpasha', 'শিবপাশা', 5, 38, 294, 11515, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:31'),
(2629, 'Kakailsao', 'কাকাইলছেও', 5, 38, 294, 11516, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:33'),
(2630, 'Ajmiriganj Sadar', 'আজমিরীগঞ্জ সদর', 5, 38, 294, 11517, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:34'),
(2631, 'Badolpur', 'বদলপুর', 5, 38, 294, 11518, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:36'),
(2632, 'Jolsuka', 'জলসুখা', 5, 38, 294, 11519, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:37'),
(2633, 'Baniachong North East', 'বানিয়াচং উত্তর পূর্ব', 5, 38, 295, 11520, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:39'),
(2634, 'Baniachong North West', 'বানিয়াচং উত্তর পশ্চিম', 5, 38, 295, 11521, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:40'),
(2635, 'Baniachong South East', 'বানিয়াচং দক্ষিণ পূর্ব', 5, 38, 295, 11522, 1, 1, 1, '2021-02-13 15:18:59', '2023-02-22 03:32:42'),
(2636, 'Baniachong South West', 'বানিয়াচং দক্ষিণ পশ্চিম', 5, 38, 295, 11523, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:44'),
(2637, 'Daulatpur', 'দৌলতপুর', 5, 38, 295, 11524, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:45'),
(2638, 'Khagaura', 'খাগাউড়া', 5, 38, 295, 11525, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:47'),
(2639, 'Baraiuri', 'বড়ইউড়ি', 5, 38, 295, 11526, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:49'),
(2640, 'Kagapasha', 'কাগাপাশা', 5, 38, 295, 11527, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:51'),
(2641, 'Pukra', 'পুকড়া', 5, 38, 295, 11528, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:53'),
(2642, 'Subidpur', 'সুবিদপুর', 5, 38, 295, 11529, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:55'),
(2643, 'Makrampur', 'মক্রমপুর', 5, 38, 295, 11530, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:56'),
(2644, 'Sujatpur', 'সুজাতপুর', 5, 38, 295, 11531, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:32:58'),
(2645, 'Mandari', 'মন্দরী', 5, 38, 295, 11532, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:33:00'),
(2646, 'Muradpur', 'মুরাদপুর', 5, 38, 295, 11533, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:33:02'),
(2647, 'Pailarkandi', 'পৈলারকান্দি', 5, 38, 295, 11534, 1, 1, 1, '2021-02-13 15:19:00', '2023-02-22 03:33:03'),
(2648, 'Lakhai', 'লাখাই', 5, 38, 296, 11535, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:05'),
(2649, 'Murakari', 'মোড়াকরি', 5, 38, 296, 11536, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:07'),
(2650, 'Muriauk', 'মুড়িয়াউক', 5, 38, 296, 11537, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:08'),
(2651, 'Bamoi', 'বামৈ', 5, 38, 296, 11538, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:10'),
(2652, 'Karab', 'করাব', 5, 38, 296, 11539, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:11'),
(2653, 'Bulla', 'বুল্লা', 5, 38, 296, 11540, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:13'),
(2654, 'Gazipur', 'গাজীপুর', 5, 38, 297, 11541, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:14'),
(2655, 'Ahammadabad', 'আহম্মদাবাদ', 5, 38, 297, 11542, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:16'),
(2656, 'Deorgach', 'দেওরগাছ', 5, 38, 297, 11543, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:17'),
(2657, 'Paikpara', 'পাইকপাড়া', 5, 38, 297, 11544, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:19'),
(2658, 'Shankhala', 'শানখলা', 5, 38, 297, 11545, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:20'),
(2659, 'Chunarughat', 'চুনারুঘাট', 5, 38, 297, 11546, 1, 1, 1, '2021-02-13 15:19:01', '2023-02-22 03:33:22'),
(2660, 'Ubahata', 'উবাহাটা', 5, 38, 297, 11547, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:24'),
(2661, 'Shatiajuri', 'সাটিয়াজুরী', 5, 38, 297, 11548, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:25'),
(2662, 'Ranigaon', 'রাণীগাঁও', 5, 38, 297, 11549, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:27'),
(2663, 'Mirashi', 'মিরাশী', 5, 38, 297, 11550, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:29'),
(2664, 'Lukra', 'লুকড়া', 5, 38, 298, 11551, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:30'),
(2665, 'Richi', 'রিচি', 5, 38, 298, 11552, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:32'),
(2666, 'Teghoria', 'তেঘরিয়া', 5, 38, 298, 11553, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:33'),
(2667, 'Poil', 'পইল', 5, 38, 298, 11554, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:35'),
(2668, 'Gopaya', 'গোপায়া', 5, 38, 298, 11555, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:36'),
(2669, 'Rajiura', 'রাজিউড়া', 5, 38, 298, 11556, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:38'),
(2670, 'Nurpur', 'নুরপুর', 5, 38, 298, 11557, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:39'),
(2671, 'Shayestaganj', 'শায়েস্তাগঞ্জ', 5, 38, 298, 11558, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:41'),
(2672, 'Nijampur', 'নিজামপুর', 5, 38, 298, 11559, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:42'),
(2673, 'Laskerpur', 'লস্করপুর', 5, 38, 298, 11560, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:44'),
(2674, 'Dharmaghar', 'ধর্মঘর', 5, 38, 299, 11561, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:45'),
(2675, 'Choumohani', 'চৌমুহনী', 5, 38, 299, 11562, 1, 1, 1, '2021-02-13 15:19:02', '2023-02-22 03:33:47'),
(2676, 'Bahara', 'বহরা', 5, 38, 299, 11563, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:48'),
(2677, 'Adaoir', 'আদাঐর', 5, 38, 299, 11564, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:50'),
(2678, 'Andiura', 'আন্দিউড়া', 5, 38, 299, 11565, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:51'),
(2679, 'Shahjahanpur', 'শাহজাহানপুর', 5, 38, 299, 11566, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:53'),
(2680, 'Jagadishpur', 'জগদীশপুর', 5, 38, 299, 11567, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:55'),
(2681, 'Bulla', 'বুল্লা', 5, 38, 299, 11568, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:56'),
(2682, 'Noapara', 'নোয়াপাড়া', 5, 38, 299, 11569, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:33:58'),
(2683, 'Chhatiain', 'ছাতিয়াইন', 5, 38, 299, 11570, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:00'),
(2684, 'Bagashura', 'বাঘাসুরা', 5, 38, 299, 11571, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:01'),
(2685, 'Jahangirnagar', 'জাহাঙ্গীরনগর', 5, 39, 300, 11572, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:03'),
(2686, 'Rangarchar', 'রংগারচর', 5, 39, 300, 11573, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:04'),
(2687, 'Aptabnagar', 'আপ্তাবনগর', 5, 39, 300, 11574, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:06'),
(2688, 'Gourarang', 'গৌরারং', 5, 39, 300, 11575, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:07'),
(2689, 'Mollapara', 'মোল্লাপাড়া', 5, 39, 300, 11576, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:09'),
(2690, 'Laxmansree', 'লক্ষণশ্রী', 5, 39, 300, 11577, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:10'),
(2691, 'Kathair', 'কাঠইর', 5, 39, 300, 11578, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:12'),
(2692, 'Surma', 'সুরমা', 5, 39, 300, 11579, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:13'),
(2693, 'Mohonpur', 'মোহনপুর', 5, 39, 300, 11580, 1, 1, 1, '2021-02-13 15:19:03', '2023-02-22 03:34:15'),
(2694, 'Shimulbak', 'শিমুলবাক', 5, 39, 301, 11581, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:16'),
(2695, 'Paschim Pagla', 'পশ্চিম পাগলা', 5, 39, 301, 11582, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:18'),
(2696, 'Joykalash', 'জয়কলস', 5, 39, 301, 11583, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:20'),
(2697, 'Purba Pagla', 'পূর্ব পাগলা', 5, 39, 301, 11584, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:21'),
(2698, 'Patharia', 'পাথারিয়া', 5, 39, 301, 11585, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:23'),
(2699, 'Purba Birgaon', 'পূর্ব বীরগাঁও', 5, 39, 301, 11586, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:24'),
(2700, 'Dargapasha', 'দরগাপাশা', 5, 39, 301, 11587, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:26'),
(2701, 'Paschim Birgaon', 'পশ্চিম বীরগাঁও', 5, 39, 301, 11588, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:27'),
(2702, 'Palash', 'পলাশ', 5, 39, 302, 11589, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:29'),
(2703, 'Solukabad', 'সলুকাবাদ', 5, 39, 302, 11590, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:30'),
(2704, 'Dhanpur', 'ধনপুর', 5, 39, 302, 11591, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:32'),
(2705, 'Badaghat South', 'বাদাঘাট দক্ষিণ', 5, 39, 302, 11592, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:33'),
(2706, 'Fatepur', 'ফতেপুর', 5, 39, 302, 11593, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:35'),
(2707, 'Islampur', 'ইসলামপুর', 5, 39, 303, 11594, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:36'),
(2708, 'Noarai', 'নোয়ারাই', 5, 39, 303, 11595, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:38'),
(2709, 'Chhatak Sadar', 'ছাতক সদর', 5, 39, 303, 11596, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:39'),
(2710, 'Kalaruka', 'কালারুকা', 5, 39, 303, 11597, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:41'),
(2711, 'Gobindganj-Syedergaon', 'গোবিন্দগঞ্জ-সৈদেরগাঁও', 5, 39, 303, 11598, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:42'),
(2712, 'Chhaila Afjalabad', 'ছৈলা আফজলাবাদ', 5, 39, 303, 11599, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:44'),
(2713, 'Khurma North', 'খুরমা উত্তর', 5, 39, 303, 11600, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:46'),
(2714, 'Khurma South', 'খুরমা দক্ষিণ', 5, 39, 303, 11601, 1, 1, 1, '2021-02-13 15:19:04', '2023-02-22 03:34:47'),
(2715, 'Chormohalla', 'চরমহল্লা', 5, 39, 303, 11602, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:49'),
(2716, 'Jauwabazar', 'জাউয়া বাজার', 5, 39, 303, 11603, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:50'),
(2717, 'Singchapair', 'সিংচাপইড়', 5, 39, 303, 11604, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:52'),
(2718, 'Dolarbazar', 'দোলারবাজার', 5, 39, 303, 11605, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:53'),
(2719, 'Bhatgaon', 'ভাতগাঁও', 5, 39, 303, 11606, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:55'),
(2720, 'Kolkolia', 'কলকলিয়া', 5, 39, 304, 11607, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:57'),
(2721, 'Patli', 'পাটলী', 5, 39, 304, 11608, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:34:58'),
(2722, 'Mirpur', 'মীরপুর', 5, 39, 304, 11609, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:00'),
(2723, 'Chilaura Holdipur', 'চিলাউড়া হলদিপুর', 5, 39, 304, 11610, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:01'),
(2724, 'Raniganj', 'রানীগঞ্জ', 5, 39, 304, 11611, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:03'),
(2725, 'Syedpur Shaharpara', 'সৈয়দপুর শাহাড়পাড়া', 5, 39, 304, 11612, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:04'),
(2726, 'Asharkandi', 'আশারকান্দি', 5, 39, 304, 11613, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:06'),
(2727, 'Pailgaon', 'পাইলগাঁও', 5, 39, 304, 11614, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:07'),
(2728, 'Banglabazar', 'বাংলাবাজার', 5, 39, 305, 11615, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:09'),
(2729, 'Norsingpur', 'নরসিংহপুর', 5, 39, 305, 11616, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:10'),
(2730, 'Dowarabazar', 'দোয়ারাবাজার', 5, 39, 305, 11617, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:12'),
(2731, 'Mannargaon', 'মান্নারগাঁও', 5, 39, 305, 11618, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:13'),
(2732, 'Pandargaon', 'পান্ডারগাঁও', 5, 39, 305, 11619, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:15'),
(2733, 'Dohalia', 'দোহালিয়া', 5, 39, 305, 11620, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:17'),
(2734, 'Laxmipur', 'লক্ষীপুর', 5, 39, 305, 11621, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:18'),
(2735, 'Boglabazar', 'বোগলাবাজার', 5, 39, 305, 11622, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:20'),
(2736, 'Surma', 'সুরমা', 5, 39, 305, NULL, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:21'),
(2737, 'Sreepur North', 'শ্রীপুর উত্তর', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:23'),
(2738, 'Sreepur South', 'শ্রীপুর দক্ষিণ', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:05', '2023-02-22 03:35:24'),
(2739, 'Bordal South', 'বড়দল দক্ষিণ', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:26'),
(2740, 'Bordal North', 'বড়দল উত্তর', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:27'),
(2741, 'Badaghat', 'বাদাঘাট', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:29'),
(2742, 'Tahirpur Sadar', 'তাহিরপুর সদর', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:30'),
(2743, 'Balijuri', 'বালিজুরী', 5, 39, 306, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:32'),
(2744, 'Bongshikunda North', 'বংশীকুন্ডা উত্তর', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:33'),
(2745, 'Bongshikunda South', 'বংশীকুন্ডা দক্ষিণ', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:35'),
(2746, 'Chamordani', 'চামরদানী', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:37'),
(2747, 'Madhyanagar', 'মধ্যনগর', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:38'),
(2748, 'Paikurati', 'পাইকুরাটী', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:40'),
(2749, 'Selbarash', 'সেলবরষ', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:41'),
(2750, 'Dharmapasha Sadar', 'ধর্মপাশা সদর', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:43'),
(2751, 'Joyasree', 'জয়শ্রী', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:44'),
(2752, 'Sukhair Rajapur North', 'সুখাইড় রাজাপুর উত্তর', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:46'),
(2753, 'Sukhair Rajapur South', 'সুখাইড় রাজাপুর দক্ষিণ', 5, 39, 307, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:48'),
(2754, 'Beheli', 'বেহেলী', 5, 39, 308, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:49'),
(2755, 'Sachnabazar', 'সাচনাবাজার', 5, 39, 308, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:51'),
(2756, 'Bhimkhali', 'ভীমখালী', 5, 39, 308, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:52'),
(2757, 'Fenerbak', 'ফেনারবাক', 5, 39, 308, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:54'),
(2758, 'Jamalganj Sadar', 'জামালগঞ্জ সদর', 5, 39, 308, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:56'),
(2759, 'Atgaon', 'আটগাঁও', 5, 39, 309, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:57'),
(2760, 'Habibpur', 'হবিবপুর', 5, 39, 309, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:35:59'),
(2761, 'Bahara', 'বাহারা', 5, 39, 309, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:36:00'),
(2762, 'Shalla Sadar', 'শাল্লা সদর', 5, 39, 309, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:36:02'),
(2763, 'Rafinagar', 'রফিনগর', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:36:03'),
(2764, 'Bhatipara', 'ভাটিপাড়া', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:06', '2023-02-22 03:36:05'),
(2765, 'Rajanagar', 'রাজানগর', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:06'),
(2766, 'Charnarchar', 'চরনারচর', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:08'),
(2767, 'Derai Sarmangal', 'দিরাই সরমঙ্গল', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:09'),
(2768, 'Karimpur', 'করিমপুর', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:11'),
(2769, 'Jagddol', 'জগদল', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:12'),
(2770, 'Taral', 'তাড়ল', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:14'),
(2771, 'Kulanj', 'কুলঞ্জ', 5, 39, 310, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:15'),
(2772, 'Amlaba', 'আমলাব', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:07', '2023-02-22 03:36:17'),
(2773, 'Bajnaba', 'বাজনাব', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:19'),
(2774, 'Belabo', 'বেলাব', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:20'),
(2775, 'Binnabayd', 'বিন্নাবাইদ', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:22'),
(2776, 'Charuzilab', 'চরউজিলাব', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:23'),
(2777, 'Naraynpur', 'নারায়নপুর', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:25'),
(2778, 'Sallabad', 'সল্লাবাদ', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:26'),
(2779, 'Patuli', 'পাটুলী', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:28'),
(2780, 'Diara', 'দেয়ারা মডেল', 6, 40, 311, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:29'),
(2781, 'Barachapa', 'বড়চাপা', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:31'),
(2782, 'Chalakchar', 'চালাকচর', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:32'),
(2783, 'Charmandalia', 'চরমান্দালিয়া', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:34'),
(2784, 'Ekduaria', 'একদুয়ারিয়া', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:08', '2023-02-22 03:36:35'),
(2785, 'Gotashia', 'গোতাশিয়া', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:37'),
(2786, 'Kanchikata', 'কাচিকাটা', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:38'),
(2787, 'Khidirpur', 'খিদিরপুর', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:40'),
(2788, 'Shukundi', 'শুকুন্দি', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:41'),
(2789, 'Dawlatpur', 'দৌলতপুর', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:43'),
(2790, 'Krisnopur', 'কৃষ্ণপুর', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:44'),
(2791, 'Labutala', 'লেবুতলা', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:46'),
(2792, 'Chandanbari', 'চন্দনবাড়ী', 6, 40, 312, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:48'),
(2793, 'Alokbali', 'আলোকবালী', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:49'),
(2794, 'Chardighaldi', 'চরদিঘলদী', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:51'),
(2795, 'Chinishpur', 'চিনিশপুর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:52'),
(2796, 'Hajipur', 'হাজীপুর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:54'),
(2797, 'Karimpur', 'করিমপুর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:55'),
(2798, 'Khathalia', 'কাঠালিয়া', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:57'),
(2799, 'Nuralapur', 'নূরালাপুর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:36:58'),
(2800, 'Mahishasura', 'মহিষাশুড়া', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:00'),
(2801, 'Meherpara', 'মেহেড়পাড়া', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:01'),
(2802, 'Nazarpur', 'নজরপুর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:03'),
(2803, 'Paikarchar', 'পাইকারচর', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:04'),
(2804, 'Panchdona', 'পাঁচদোনা', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:06'),
(2805, 'Silmandi', 'শিলমান্দী', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:07'),
(2806, 'Amdia', 'আমদিয়া ২', 6, 40, 313, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:09'),
(2807, 'Danga', 'ডাংঙ্গা', 6, 40, 314, NULL, 1, 1, 1, '2021-02-13 15:19:09', '2023-02-22 03:37:10'),
(2808, 'Charsindur', 'চরসিন্দুর', 6, 40, 314, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:12'),
(2809, 'Jinardi', 'জিনারদী', 6, 40, 314, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:14'),
(2810, 'Gazaria', 'গজারিয়া', 6, 40, 314, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:15'),
(2811, 'Chanpur', 'চানপুর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:17'),
(2812, 'Alipura', 'অলিপুরা', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:18'),
(2813, 'Amirganj', 'আমিরগঞ্জ', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:20'),
(2814, 'Adiabad', 'আদিয়াবাদ', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:21'),
(2815, 'Banshgari', 'বাঁশগাড়ী', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:23'),
(2816, 'Chanderkandi', 'চান্দেরকান্দি', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:25'),
(2817, 'Chararalia', 'চরআড়ালিয়া', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:26'),
(2818, 'Charmadhua', 'চরমধুয়া', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:28'),
(2819, 'Charsubuddi', 'চরসুবুদ্দি', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:29'),
(2820, 'Daukarchar', 'ডৌকারচর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:31'),
(2821, 'Hairmara', 'হাইরমারা', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:32'),
(2822, 'Maheshpur', 'মহেষপুর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:34'),
(2823, 'Mirzanagar', 'মির্জানগর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:35'),
(2824, 'Mirzarchar', 'মির্জারচর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:37'),
(2825, 'Nilakhya', 'নিলক্ষ্যা', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:38'),
(2826, 'Palashtali', 'পলাশতলী', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:40'),
(2827, 'Paratali', 'পাড়াতলী', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:41'),
(2828, 'Sreenagar', 'শ্রীনগর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:43'),
(2829, 'Roypura', 'রায়পুরা', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:45'),
(2830, 'Musapur', 'মুছাপুর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:46'),
(2831, 'Uttar Bakharnagar', 'উত্তর বাখরনগর', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:10', '2023-02-22 03:37:48'),
(2832, 'Marjal', 'মরজাল', 6, 40, 315, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:49'),
(2833, 'Dulalpur', 'দুলালপুর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:51'),
(2834, 'Joynagar', 'জয়নগর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:52'),
(2835, 'Sadharchar', 'সাধারচর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:54'),
(2836, 'Masimpur', 'মাছিমপুর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:55'),
(2837, 'Chakradha', 'চক্রধা', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:57'),
(2838, 'Joshar', 'যোশর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:37:58'),
(2839, 'Baghabo', 'বাঘাব', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:00'),
(2840, 'Ayubpur', 'আয়ুবপুর', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:01'),
(2841, 'Putia', 'পুটিয়া', 6, 40, 316, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:03'),
(2842, 'Bahadursadi', 'বাহাদুরশাদী', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:04'),
(2843, 'Baktarpur', 'বক্তারপুর', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:06'),
(2844, 'Jamalpurnew', 'জামালপুর', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:08'),
(2845, 'Jangalia', 'জাঙ্গালিয়া', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:09'),
(2846, 'Moktarpur', 'মোক্তারপুর', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:11'),
(2847, 'Nagari', 'নাগরী', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:12'),
(2848, 'Tumulia', 'তুমুলিয়া', 6, 41, 317, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:14'),
(2849, 'Atabaha', 'আটাবহ', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:16'),
(2850, 'Boali', 'বোয়ালী', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:17'),
(2851, 'Chapair', 'চাপাইর', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:19'),
(2852, 'Dhaliora', 'ঢালজোড়া', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:20'),
(2853, 'Fulbaria', 'ফুলবাড়ীয়া', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:22'),
(2854, 'Madhyapara', 'মধ্যপাড়া', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:23'),
(2855, 'Mouchak', 'মৌচাক', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:25'),
(2856, 'Sutrapur', 'সূত্রাপুর', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:26'),
(2857, 'Srifaltali', 'শ্রীফলতলী', 6, 41, 318, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:28'),
(2858, 'Barishaba', 'বারিষাব', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:29'),
(2859, 'Ghagotia', 'ঘাগটিয়া', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:11', '2023-02-22 03:38:31'),
(2860, 'Kapasia', 'কাপাসিয়া', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:33'),
(2861, 'Chandpur', 'চাঁদপুর', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:35'),
(2862, 'Targoan', 'তরগাঁও', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:36'),
(2863, 'Karihata', 'কড়িহাতা', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:38'),
(2864, 'Tokh', 'টোক', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:39'),
(2865, 'Sinhasree', 'সিংহশ্রী', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:41'),
(2866, 'Durgapur', 'দূর্গাপুর', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:43'),
(2867, 'Sonmania', 'সনমানিয়া', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:44'),
(2868, 'Rayed', 'রায়েদ', 6, 41, 319, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:46'),
(2869, 'Baria', 'বাড়ীয়া', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:47'),
(2870, 'Basan', 'বাসন', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:49'),
(2871, 'Gachha', 'গাছা', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:50'),
(2872, 'Kashimpur', 'কাশিমপুর', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:52'),
(2873, 'Kayaltia', 'কাউলতিয়া', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:53'),
(2874, 'Konabari', 'কোনাবাড়ী', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:56'),
(2875, 'Mirzapur', 'মির্জাপুর', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:38:58'),
(2876, 'Pubail', 'পূবাইল', 6, 41, 320, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:00'),
(2877, 'Barmi', 'বরমী', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:02');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(2878, 'Gazipur', 'গাজীপুর', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:04'),
(2879, 'Gosinga', 'গোসিংগা', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:06'),
(2880, 'Maona', 'মাওনা', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:08'),
(2881, 'Kaoraid', 'কাওরাইদ', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:10'),
(2882, 'Prahladpur', 'প্রহলাদপুর', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:12'),
(2883, 'Rajabari', 'রাজাবাড়ী', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:14'),
(2884, 'Telihati', 'তেলিহাটী', 6, 41, 321, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:16'),
(2885, 'Binodpur', 'বিনোদপুর', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:12', '2023-02-22 03:39:18'),
(2886, 'Tulasar', 'তুলাসার', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:19'),
(2887, 'Palong', 'পালং', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:22'),
(2888, 'Domshar', 'ডোমসার', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:24'),
(2889, 'Rudrakar', 'রুদ্রকর', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:26'),
(2890, 'Angaria', 'আংগারিয়া', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:27'),
(2891, 'Chitolia', 'চিতলয়া', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:29'),
(2892, 'Mahmudpur', 'মাহমুদপুর', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:32'),
(2893, 'Chikondi', 'চিকন্দি', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:33'),
(2894, 'Chandrapur', 'চন্দ্রপুর', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:35'),
(2895, 'Shulpara', 'শৌলপাড়া', 6, 42, 322, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:37'),
(2896, 'Kedarpur', 'কেদারপুর', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:38'),
(2897, 'Dingamanik', 'ডিংগামানিক', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:40'),
(2898, 'Garishar', 'ঘড়িষার', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:41'),
(2899, 'Nowpara', 'নওপাড়া', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:43'),
(2900, 'Moktererchar', 'মোত্তারেরচর', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:45'),
(2901, 'Charatra', 'চরআত্রা', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:46'),
(2902, 'Rajnagar', 'রাজনগর', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:48'),
(2903, 'Japsa', 'জপসা', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:49'),
(2904, 'Vojeshwar', 'ভোজেশ্বর', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:51'),
(2905, 'Fategongpur', 'ফতেজংপুর', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:53'),
(2906, 'Bijari', 'বিঝারি', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:55'),
(2907, 'Vumkhara', 'ভূমখাড়া', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:13', '2023-02-22 03:39:57'),
(2908, 'Nashason', 'নশাসন', 6, 42, 323, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:39:58'),
(2909, 'Zajira Sadar', 'জাজিরা সদর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:00'),
(2910, 'Mulna', 'মূলনা', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:02'),
(2911, 'Barokandi', 'বড়কান্দি', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:03'),
(2912, 'Bilaspur', 'বিলাসপুর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:05'),
(2913, 'Kundarchar', 'কুন্ডেরচর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:06'),
(2914, 'Palerchar', 'পালেরচর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:08'),
(2915, 'Purba Nawdoba', 'পুর্ব নাওডোবা', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:14', '2023-02-22 03:40:09'),
(2916, 'Nawdoba', 'নাওডোবা', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:11'),
(2917, 'Shenerchar', 'সেনেরচর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:12'),
(2918, 'Bknagar', 'বি. কে. নগর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:14'),
(2919, 'Barogopalpur', 'বড়গোপালপুর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:15'),
(2920, 'Jaynagor', 'জয়নগর', 6, 42, 324, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:17'),
(2921, 'Nager Para', 'নাগের পাড়া', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:18'),
(2922, 'Alaolpur', 'আলাওলপুর', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:20'),
(2923, 'Kodalpur', 'কোদালপুর', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:21'),
(2924, 'Goshairhat', 'গোসাইরহাট', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:23'),
(2925, 'Edilpur', 'ইদিলপুর', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:25'),
(2926, 'Nalmuri', 'নলমুড়ি', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:26'),
(2927, 'Samontasar', 'সামন্তসার', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:28'),
(2928, 'Kuchipatti', 'কুচাইপট্টি', 6, 42, 325, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:29'),
(2929, 'Ramvadrapur', 'রামভদ্রপুর', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:31'),
(2930, 'Mahisar', 'মহিষার', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:32'),
(2931, 'Saygaon', 'ছয়গাঁও', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:34'),
(2932, 'Narayanpur', 'নারায়নপুর', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:36'),
(2933, 'D.M Khali', 'ডি.এম খালি', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:37'),
(2934, 'Charkumaria', 'চরকুমারিয়া', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:39'),
(2935, 'Sakhipur', 'সখিপুর', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:40'),
(2936, 'Kachikata', 'কাচিকাঁটা', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:42'),
(2937, 'North Tarabunia', 'উত্তর তারাবুনিয়া', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:43'),
(2938, 'Charvaga', 'চরভাগা', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:45'),
(2939, 'Arsinagar', 'আরশিনগর', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:15', '2023-02-22 03:40:46'),
(2940, 'South Tarabunia', 'দক্ষিন তারাবুনিয়া', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:48'),
(2941, 'Charsensas', 'চরসেনসাস', 6, 42, 326, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:49'),
(2942, 'Shidulkura', 'শিধলকুড়া', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:51'),
(2943, 'Kaneshar', 'কনেস্বর', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:52'),
(2944, 'Purba Damudya', 'পুর্ব ডামুড্যা', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:54'),
(2945, 'Islampur', 'ইসলামপুর', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:55'),
(2946, 'Dankati', 'ধানকাটি', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:57'),
(2947, 'Sidya', 'সিড্যা', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:40:59'),
(2948, 'Darulaman', 'দারুল আমান', 6, 42, 327, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:00'),
(2949, 'Satgram', 'সাতগ্রাম', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:02'),
(2950, 'Duptara', 'দুপ্তারা', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:03'),
(2951, 'Brahammandi', 'ব্রা‏হ্মন্দী', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:05'),
(2952, 'Fatepur', 'ফতেপুর', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:07'),
(2953, 'Bishnandi', 'বিশনন্দী', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:08'),
(2954, 'Mahmudpur', 'মাহমুদপুর', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:10'),
(2955, 'Highjadi', 'হাইজাদী', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:11'),
(2956, 'Uchitpura', 'উচিৎপুরা', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:13'),
(2957, 'Kalapaharia', 'কালাপাহাড়িয়া', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:14'),
(2958, 'Kagkanda', 'খাগকান্দা', 6, 43, 328, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:16'),
(2959, 'Musapur', 'মুছাপুর', 6, 43, 329, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:17'),
(2960, 'Modonpur', 'মদনপুর', 6, 43, 329, NULL, 1, 1, 1, '2021-02-13 15:19:16', '2023-02-22 03:41:19'),
(2961, 'Bandar', 'বন্দর', 6, 43, 329, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:20'),
(2962, 'Dhamgar', 'ধামগর', 6, 43, 329, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:22'),
(2963, 'Kolagathia', ' কলাগাছিয়া', 6, 43, 329, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:24'),
(2964, 'Alirtek', 'আলিরটেক', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:25'),
(2965, 'Kashipur', 'কাশীপুর', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:27'),
(2966, 'Kutubpur', 'কুতুবপুর', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:28'),
(2967, 'Gognagar', 'গোগনগর', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:30'),
(2968, 'Baktaboli', 'বক্তাবলী', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:31'),
(2969, 'Enayetnagor', 'এনায়েত নগর', 6, 43, 330, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:33'),
(2970, 'Murapara', 'মুড়াপাড়া', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:34'),
(2971, 'Bhulta', 'ভূলতা', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:36'),
(2972, 'Golakandail', 'গোলাকান্দাইল', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:37'),
(2973, 'Daudpur', 'দাউদপুর', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:39'),
(2974, 'Rupganj', 'রূপগঞ্জ', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:40'),
(2975, 'Kayetpara', 'কায়েতপাড়া', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:42'),
(2976, 'Bholobo', 'ভোলাব', 6, 43, 331, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:43'),
(2977, 'Pirojpur', 'পিরোজপুর', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:45'),
(2978, 'Shambhupura', 'শম্ভুপুরা', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:47'),
(2979, 'Mograpara', 'মোগরাপাড়া', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:48'),
(2980, 'Baidyerbazar', 'বৈদ্যেরবাজার', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:50'),
(2981, 'Baradi', 'বারদী', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:52'),
(2982, 'Noagaon', 'নোয়াগাঁও', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:53'),
(2983, 'Jampur', 'জামপুর', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:55'),
(2984, 'Sadipur', 'সাদীপুর', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:57'),
(2985, 'Sonmandi', 'সনমান্দি', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:41:58'),
(2986, 'Kanchpur', 'কাচপুর', 6, 43, 332, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:42:00'),
(2987, 'Basail', 'বাসাইল', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:17', '2023-02-22 03:42:01'),
(2988, 'Kanchanpur', 'কাঞ্চনপুর', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:03'),
(2989, 'Habla', 'হাবলা', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:04'),
(2990, 'Kashil', 'কাশিল', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:06'),
(2991, 'Fulki', 'ফুলকি', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:07'),
(2992, 'Kauljani', 'কাউলজানী', 6, 44, 333, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:09'),
(2993, 'Arjuna', 'অর্জুনা', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:10'),
(2994, 'Gabshara', 'গাবসারা', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:12'),
(2995, 'Falda', 'ফলদা', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:14'),
(2996, 'Gobindashi', 'গোবিন্দাসী', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:15'),
(2997, 'Aloa', 'আলোয়া', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:17'),
(2998, 'Nikrail', 'নিকরাইল', 6, 44, 334, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:18'),
(2999, 'Deuli', 'দেউলী', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:20'),
(3000, 'Lauhati', 'লাউহাটি', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:21'),
(3001, 'Patharail', 'পাথরাইল', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:23'),
(3002, 'Delduar', 'দেলদুয়ার', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:24'),
(3003, 'Fazilhati', 'ফাজিলহাটি', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:26'),
(3004, 'Elasin', 'এলাসিন', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:28'),
(3005, 'Atia', 'আটিয়া', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:29'),
(3006, 'Dubail', 'ডুবাইল', 6, 44, 335, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:31'),
(3007, 'Deulabari', 'দেউলাবাড়ী', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:32'),
(3008, 'Ghatail', 'ঘাটাইল', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:34'),
(3009, 'Jamuria', 'জামুরিয়া', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:35'),
(3010, 'Lokerpara', 'লোকেরপাড়া', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:38'),
(3011, 'Anehola', 'আনেহলা', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:40'),
(3012, 'Dighalkandia', 'দিঘলকান্দি', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:41'),
(3013, 'Digar', 'দিগড়', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:18', '2023-02-22 03:42:43'),
(3014, 'Deopara', 'দেওপাড়া', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:44'),
(3015, 'Sandhanpur', 'সন্ধানপুর', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:46'),
(3016, 'Rasulpur', 'রসুলপুর', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:47'),
(3017, 'Dhalapara', 'ধলাপাড়া', 6, 44, 336, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:49'),
(3018, 'Hadera', 'হাদিরা', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:51'),
(3019, 'Jhawail', 'ঝাওয়াইল', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:52'),
(3020, 'Nagdashimla', 'নগদাশিমলা', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:54'),
(3021, 'Dhopakandi', 'ধোপাকান্দি', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:55'),
(3022, 'Alamnagor', 'আলমনগর', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:57'),
(3023, 'Hemnagor', 'হেমনগর', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:42:58'),
(3024, 'Mirzapur', 'মির্জাপুর', 6, 44, 337, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:00'),
(3025, 'Alokdia', 'আলোকদিয়া', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:01'),
(3026, 'Aushnara', 'আউশনারা', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:03'),
(3027, 'Aronkhola', 'অরণখোলা', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:04'),
(3028, 'Sholakuri', 'শোলাকুড়ি', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:06'),
(3029, 'Golabari', 'গোলাবাড়ী', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:07'),
(3030, 'Mirjabari', 'মির্জাবাড়ী', 6, 44, 338, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:09'),
(3031, 'Mahera', 'মহেড়া', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:11'),
(3032, 'Jamurki', 'জামুর্কী', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:12'),
(3033, 'Fatepur', 'ফতেপুর', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:14'),
(3034, 'Banail', 'বানাইল', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:15'),
(3035, 'Anaitara', 'আনাইতারা', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:17'),
(3036, 'Warshi', 'ওয়ার্শী', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:18'),
(3037, 'Bhatram', 'ভাতগ্রাম', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:19', '2023-02-22 03:43:20'),
(3038, 'Bahuria', 'বহুরিয়া', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:21'),
(3039, 'Gorai', 'গোড়াই', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:23'),
(3040, 'Ajgana', 'আজগানা', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:24'),
(3041, 'Tarafpur', 'তরফপুর', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:26'),
(3042, 'Bastail', 'বাঁশতৈল', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:27'),
(3043, 'Baora', 'ভাওড়া', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:29'),
(3044, 'Latifpur', 'লতিফপুর', 6, 44, 339, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:31'),
(3045, 'Bharra', 'ভারড়া', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:32'),
(3046, 'Sahabathpur', 'সহবতপুর', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:34'),
(3047, 'Goyhata', 'গয়হাটা', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:35'),
(3048, 'Solimabad', 'সলিমাবাদ', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:37'),
(3049, 'Nagorpur', 'নাগরপুর', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:38'),
(3050, 'Mamudnagor', 'মামুদনগর', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:40'),
(3051, 'Mokna', 'মোকনা', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:42'),
(3052, 'Pakutia', 'পাকুটিয়া', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:43'),
(3053, 'Bekrah Atgram', 'বেকরা আটগ্রাম', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:45'),
(3054, 'Dhuburia', 'ধুবড়িয়া', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:46'),
(3055, 'Bhadra', 'ভাদ্রা', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:48'),
(3056, 'Doptior', 'দপ্তিয়র', 6, 44, 340, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:49'),
(3057, 'Kakrajan', 'কাকড়াজান', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:51'),
(3058, 'Gajaria', 'গজারিয়া', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:52'),
(3059, 'Jaduppur', 'যাদবপুর', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:54'),
(3060, 'Hatibandha', 'হাতীবান্ধা', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:55'),
(3061, 'Kalia', 'কালিয়া', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:57'),
(3062, 'Dariapur', 'দরিয়াপুর', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:20', '2023-02-22 03:43:58'),
(3063, 'Kalmegha', 'কালমেঘা', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:00'),
(3064, 'Baharatoil', 'বহেড়াতৈল', 6, 44, 341, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:01'),
(3065, 'Mogra', 'মগড়া', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:03'),
(3066, 'Gala', 'গালা', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:05'),
(3067, 'Gharinda', 'ঘারিন্দা', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:06'),
(3068, 'Karatia', 'করটিয়া', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:08'),
(3069, 'Silimpur', 'ছিলিমপুর', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:09'),
(3070, 'Porabari', 'পোড়াবাড়ী', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:11'),
(3071, 'Dyenna', 'দাইন্যা', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:12'),
(3072, 'Baghil', 'বাঘিল', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:14'),
(3073, 'Kakua', 'কাকুয়া', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:16'),
(3074, 'Hugra', 'হুগড়া', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:17'),
(3075, 'Katuli', 'কাতুলী', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:19'),
(3076, 'Mahamudnagar', 'মাহমুদনগর', 6, 44, 342, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:20'),
(3077, 'Durgapur', 'দুর্গাপুর', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:22'),
(3078, 'Birbashinda', 'বীরবাসিন্দা', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:23'),
(3079, 'Narandia', 'নারান্দিয়া', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:25'),
(3080, 'Shahadebpur', 'সহদেবপুর', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:26'),
(3081, 'Kokdahara', 'কোকডহরা', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:28'),
(3082, 'Balla', 'বল্লা', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:29'),
(3083, 'Salla', 'সল্লা', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:31'),
(3084, 'Nagbari', 'নাগবাড়ী', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:33'),
(3085, 'Bangra', 'বাংড়া', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:34'),
(3086, 'Paikora', 'পাইকড়া', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:36'),
(3087, 'Dashokia', 'দশকিয়া', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:37'),
(3088, 'Parkhi', 'পারখী', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:39'),
(3089, 'Gohaliabari', 'গোহালিয়াবাড়ী', 6, 44, 343, NULL, 1, 1, 1, '2021-02-13 15:19:21', '2023-02-22 03:44:40'),
(3090, 'Dhopakhali', 'ধোপাখালী', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:42'),
(3091, 'Paiska', 'পাইস্কা', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:43'),
(3092, 'Mushuddi', 'মুশুদ্দি', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:45'),
(3093, 'Bolibodrow', 'বলিভদ্র', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:46'),
(3094, 'Birtara', 'বীরতারা', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:48'),
(3095, 'Baniajan', 'বানিয়াজান', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:49'),
(3096, 'Jadunathpur', 'যদুনাথপুর', 6, 44, 344, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:51'),
(3097, 'Chawganga', 'চৌগাংগা', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:52'),
(3098, 'Joysiddi', 'জয়সিদ্ধি', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:54'),
(3099, 'Alonjori', 'এলংজুরী', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:55'),
(3100, 'Badla', 'বাদলা', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:57'),
(3101, 'Boribari', 'বড়িবাড়ি', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:44:58'),
(3102, 'Itna', 'ইটনা', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:00'),
(3103, 'Mriga', 'মৃগা', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:02'),
(3104, 'Dhonpur', 'ধনপুর', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:03'),
(3105, 'Raytoti', 'রায়টুটি', 6, 45, 345, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:05'),
(3106, 'Banagram', 'বনগ্রাম', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:06'),
(3107, 'Shahasram Dhuldia', 'সহশ্রাম ধুলদিয়া', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:08'),
(3108, 'Kargaon', 'কারগাঁও', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:09'),
(3109, 'Chandpur', 'চান্দপুর', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:11'),
(3110, 'Mumurdia', 'মুমুরদিয়া', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:12'),
(3111, 'Acmita', 'আচমিতা', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:14'),
(3112, 'Mosua', 'মসূয়া', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:15'),
(3113, 'Lohajuree', 'লোহাজুরী', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:17'),
(3114, 'Jalalpur', 'জালালপুর', 6, 45, 346, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:18'),
(3115, 'Sadekpur', 'সাদেকপুর', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:22', '2023-02-22 03:45:20'),
(3116, 'Aganagar', 'আগানগর', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:21'),
(3117, 'Shimulkandi', 'শিমুলকান্দি', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:23'),
(3118, 'Gajaria', 'গজারিয়া', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:25'),
(3119, 'Kalika Prashad', 'কালিকা প্রসাদ', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:26'),
(3120, 'Sreenagar', 'শ্রীনগর', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:28'),
(3121, 'Shibpur', 'শিবপুর', 6, 45, 347, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:29'),
(3122, 'Taljanga', 'তালজাঙ্গা', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:31'),
(3123, 'Rauti', 'রাউতি', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:32'),
(3124, 'Dhola', 'ধলা', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:34'),
(3125, 'Jawar', 'জাওয়ার', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:35'),
(3126, 'Damiha', 'দামিহা', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:37'),
(3127, 'Digdair', 'দিগদাইর', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:38'),
(3128, 'Tarail-Sachail', 'তাড়াইল-সাচাইল', 6, 45, 348, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:40'),
(3129, 'Jinari', 'জিনারী', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:41'),
(3130, 'Gobindapur', 'গোবিন্দপুর', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:43'),
(3131, 'Sidhla', 'সিদলা', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:44'),
(3132, 'Araibaria', 'আড়াইবাড়িয়া', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:46'),
(3133, 'Sahedal', 'সাহেদল', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:47'),
(3134, 'Pumdi', 'পুমদি', 6, 45, 349, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:49'),
(3135, 'Jangalia', 'জাঙ্গালিয়া', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:50'),
(3136, 'Hosendi', 'হোসেনদি', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:52'),
(3137, 'Narandi', 'নারান্দি', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:54'),
(3138, 'Shukhia', 'সুখিয়া', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:55'),
(3139, 'Patuavabga', 'পটুয়াভাঙ্গা', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:57'),
(3140, 'Chandipasha', 'চান্দিপাশা', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:45:58'),
(3141, 'Charfaradi', 'চারফারাদি', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:23', '2023-02-22 03:46:00'),
(3142, 'Burudia', 'বুড়ুদিয়া', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:02'),
(3143, 'Egarasindur', 'ইজারাসিন্দুর', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:04'),
(3144, 'Pakundia', 'পাকন্দিয়া', 6, 45, 350, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:06'),
(3145, 'Ramdi', 'রামদী', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:07'),
(3146, 'Osmanpur', 'উছমানপুর', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:09'),
(3147, 'Chhaysuti', 'ছয়সূতী', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:11'),
(3148, 'Salua', 'সালুয়া', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:13'),
(3149, 'Gobaria Abdullahpur', 'গোবরিয়া আব্দুল্লাহপুর', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:14'),
(3150, 'Faridpur', 'ফরিদপুর', 6, 45, 351, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:16'),
(3151, 'Rashidabad', 'রশিদাবাদ', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:18'),
(3152, 'Latibabad', 'লতিবাবাদ', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:20'),
(3153, 'Maizkhapan', 'মাইজখাপন', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:22'),
(3154, 'Mohinanda', 'মহিনন্দ', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:23'),
(3155, 'Joshodal', 'যশোদল', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:25'),
(3156, 'Bowlai', 'বৌলাই', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:26'),
(3157, 'Binnati', 'বিন্নাটি', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:28'),
(3158, 'Maria', 'মারিয়া', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:29'),
(3159, 'Chowddoshata', 'চৌদ্দশত', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:31'),
(3160, 'Karshakarial', 'কর্শাকড়িয়াইল', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:32'),
(3161, 'Danapatuli', 'দানাপাটুলী', 6, 45, 352, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:34'),
(3162, 'Kadirjangal', 'কাদিরজঙ্গল', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:35'),
(3163, 'Gujadia', 'গুজাদিয়া', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:37'),
(3164, 'Kiraton', 'কিরাটন', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:39'),
(3165, 'Barogharia', 'বারঘড়িয়া', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:40'),
(3166, 'Niamatpur', 'নিয়ামতপুর', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:42'),
(3167, 'Dehunda', 'দেহুন্দা', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:24', '2023-02-22 03:46:43'),
(3168, 'Sutarpara', 'সুতারপাড়া', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:45'),
(3169, 'Gunodhar', 'গুনধর', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:46'),
(3170, 'Joyka', 'জয়কা', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:48'),
(3171, 'Zafrabad', 'জাফরাবাদ', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:49'),
(3172, 'Noabad', 'নোয়াবাদ', 6, 45, 353, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:51'),
(3173, 'Kailag', 'কৈলাগ', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:52'),
(3174, 'Pirijpur', 'পিরিজপুর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:55'),
(3175, 'Gazirchar', 'গাজীরচর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:57'),
(3176, 'Hilochia', 'হিলচিয়া', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:46:59'),
(3177, 'Maijchar9', 'মাইজচর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:01'),
(3178, 'Homypur', 'হুমাইপর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:03'),
(3179, 'Halimpur', 'হালিমপুর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:05'),
(3180, 'Sararchar', 'সরারচর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:07'),
(3181, 'Dilalpur', 'দিলালপুর', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:10'),
(3182, 'Dighirpar', 'দিঘীরপাড়', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:11'),
(3183, 'Boliardi', 'বলিয়ার্দী', 6, 45, 354, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:13'),
(3184, 'Dewghar', 'দেওঘর', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:14'),
(3185, 'Kastul', 'কাস্তুল', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:16'),
(3186, 'Austagram Sadar', 'অষ্টগ্রাম সদর', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:17'),
(3187, 'Bangalpara', 'বাঙ্গালপাড়া', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:19'),
(3188, 'Kalma', 'কলমা', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:21'),
(3189, 'Adampur', 'আদমপুর', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:22'),
(3190, 'Khyerpur-Abdullahpur', 'খয়েরপুর-আব্দুল্লাপুর', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:24'),
(3191, 'Purba Austagram', 'পূর্ব অষ্টগ্রাম', 6, 45, 355, NULL, 1, 1, 1, '2021-02-13 15:19:25', '2023-02-22 03:47:25'),
(3192, 'Gopdighi', 'গোপদিঘী', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:27'),
(3193, 'Mithamoin', 'মিঠামইন', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:28'),
(3194, 'Dhaki', 'ঢাকী', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:30'),
(3195, 'Ghagra', 'ঘাগড়া', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:31'),
(3196, 'Keoarjore', 'কেওয়ারজোর', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:33'),
(3197, 'Katkhal', 'কাটখাল', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:34'),
(3198, 'Bairati', 'বৈরাটি', 6, 45, 356, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:36'),
(3199, 'Chatirchar', 'ছাতিরচর', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:37'),
(3200, 'Guroi', 'গুরই', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:39'),
(3201, 'Jaraitala', 'জারইতলা', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:41'),
(3202, 'Nikli Sadar', 'নিকলী সদর', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:42'),
(3203, 'Karpasa', 'কারপাশা', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:44'),
(3204, 'Dampara', 'দামপাড়া', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:45'),
(3205, 'Singpur', 'সিংপুর', 6, 45, 357, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:47'),
(3206, 'Balla', 'বাল্লা', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:48'),
(3207, 'Gala', 'গালা', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:50'),
(3208, 'Chala', 'চালা', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:51'),
(3209, 'Blara', 'বলড়া', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:53'),
(3210, 'Harukandi', 'হারুকান্দি', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:55'),
(3211, 'Baira', 'বয়রা', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:56'),
(3212, 'Ramkrishnapur', 'রামকৃঞ্চপুর', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:58'),
(3213, 'Gopinathpur', 'গোপীনাথপুর', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:47:59'),
(3214, 'Kanchanpur', 'কাঞ্চনপুর', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:48:01'),
(3215, 'Lacharagonj', 'লেছড়াগঞ্জ', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:48:02'),
(3216, 'Sutalorie', 'সুতালড়ী', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:48:04'),
(3217, 'Dhulsura', 'ধূলশুড়া', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:48:05'),
(3218, 'Azimnagar', 'আজিমনগর', 6, 46, 358, NULL, 1, 1, 1, '2021-02-13 15:19:26', '2023-02-22 03:48:07'),
(3219, 'Baried', 'বরাইদ', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:08'),
(3220, 'Dighulia', 'দিঘুলিয়া', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:10'),
(3221, 'Baliyati', 'বালিয়াটি', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:11'),
(3222, 'Dargram', 'দড়গ্রাম', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:13'),
(3223, 'Tilli', 'তিল্লী', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:14'),
(3224, 'Hargaj', 'হরগজ', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:16'),
(3225, 'Saturia', 'সাটুরিয়া', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:18'),
(3226, 'Dhankora', 'ধানকোড়া', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:19'),
(3227, 'Fukurhati', 'ফুকুরহাটি', 6, 46, 359, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:21'),
(3228, 'Betila-Mitara', 'বেতিলা-মিতরা', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:22'),
(3229, 'Jagir', 'জাগীর', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:24'),
(3230, 'Atigram', 'আটিগ্রাম', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:25'),
(3231, 'Dighi', 'দিঘী', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:27'),
(3232, 'Putile', 'পুটাইল', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:28'),
(3233, 'Hatipara', 'হাটিপাড়া', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:30'),
(3234, 'Vararia', 'ভাড়ারিয়া', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:31'),
(3235, 'Nbogram', 'নবগ্রাম', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:33'),
(3236, 'Garpara', 'গড়পাড়া', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:34'),
(3237, 'Krishnapur', 'কৃঞ্চপুর', 6, 46, 360, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:36'),
(3238, 'Paila', 'পয়লা', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:37'),
(3239, 'Shingzuri', 'সিংজুড়ী', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:39'),
(3240, 'Baliyakhora', 'বালিয়াখোড়া', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:41'),
(3241, 'Gior', 'ঘিওর', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:42'),
(3242, 'Bartia', 'বড়টিয়া', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:44'),
(3243, 'Baniazuri', 'বানিয়াজুড়ী', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:45'),
(3244, 'Nalee', 'নালী', 6, 46, 361, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:47'),
(3245, 'Teota', 'তেওতা', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:48'),
(3246, 'Utholi', 'উথলী', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:50'),
(3247, 'Shibaloy', 'শিবালয়', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:27', '2023-02-22 03:48:51'),
(3248, 'Ulayel', 'উলাইল', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:48:53'),
(3249, 'Aruoa', 'আরুয়া', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:48:54'),
(3250, 'Mohadebpur', 'মহাদেবপুর', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:48:56'),
(3251, 'Shimulia', 'শিমুলিয়া', 6, 46, 362, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:48:57'),
(3252, 'Charkataree', 'চরকাটারী', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:48:59'),
(3253, 'Bachamara', 'বাচামারা', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:00'),
(3254, 'Baghutia', 'বাঘুটিয়া', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:02'),
(3255, 'Zionpur', 'জিয়নপুর', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:04'),
(3256, 'Khalshi', 'খলশী', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:05'),
(3257, 'Chakmirpur', 'চকমিরপুর', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:07'),
(3258, 'Klia', 'কলিয়া', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:08'),
(3259, 'Dhamswar', 'ধামশ্বর', 6, 46, 363, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:10'),
(3260, 'Buyra', 'বায়রা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:11'),
(3261, 'Talebpur', 'তালেবপুর', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:13'),
(3262, 'Singiar', 'সিংগাইর', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:14'),
(3263, 'Baldhara', 'বলধারা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:16'),
(3264, 'Zamsha', 'জামশা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:17'),
(3265, 'Charigram', 'চারিগ্রাম', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:19'),
(3266, 'Shayesta', 'শায়েস্তা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:20'),
(3267, 'Joymonto', 'জয়মন্টপ', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:22'),
(3268, 'Dhalla', 'ধল্লা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:23'),
(3269, 'Jamirta', 'জার্মিতা', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:25'),
(3270, 'Chandhar', 'চান্দহর', 6, 46, 364, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:26'),
(3271, 'Savar', 'সাভার', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:28'),
(3272, 'Birulia', 'বিরুলিয়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:30'),
(3273, 'Dhamsona', 'ধামসোনা', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:28', '2023-02-22 03:49:31'),
(3274, 'Shimulia', 'শিমুলিয়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:33'),
(3275, 'Ashulia', 'আশুলিয়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:35'),
(3276, 'Yearpur', 'ইয়ারপুর', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:36'),
(3277, 'Vakurta', 'ভাকুর্তা', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:38'),
(3278, 'Pathalia', 'পাথালিয়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:40'),
(3279, 'Bongaon', 'বনগাঁও', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:41'),
(3280, 'Kaundia', 'কাউন্দিয়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:43'),
(3281, 'Tetuljhora', 'তেঁতুলঝোড়া', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:45'),
(3282, 'Aminbazar', 'আমিনবাজার', 6, 47, 365, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:46'),
(3283, 'Chauhat', 'চৌহাট', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:48'),
(3284, 'Amta', 'আমতা', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:49'),
(3285, 'Balia', 'বালিয়া', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:51'),
(3286, 'Jadabpur', 'যাদবপুর', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:52'),
(3287, 'Baisakanda', 'বাইশাকান্দা', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:54'),
(3288, 'Kushura', 'কুশুরা', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:56'),
(3289, 'Gangutia', 'গাংগুটিয়া', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:57'),
(3290, 'Sanora', 'সানোড়া', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:49:59'),
(3291, 'Sutipara', 'সূতিপাড়া', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:00'),
(3292, 'Sombhag', 'সোমভাগ', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:02'),
(3293, 'Vararia', 'ভাড়ারিয়া', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:03'),
(3294, 'Dhamrai', 'ধামরাই', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:05'),
(3295, 'Kulla', 'কুল্লা', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:06'),
(3296, 'Rowail', 'রোয়াইল', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:08'),
(3297, 'Suapur', 'সুয়াপুর', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:09'),
(3298, 'Nannar', 'নান্নার', 6, 47, 366, NULL, 1, 1, 1, '2021-02-13 15:19:29', '2023-02-22 03:50:11'),
(3299, 'Hazratpur', 'হযরতপুর', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:12'),
(3300, 'Kalatia', 'কলাতিয়া', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:14'),
(3301, 'Taranagar', 'তারানগর', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:16'),
(3302, 'Sakta', 'শাক্তা', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:17'),
(3303, 'Ruhitpur', 'রোহিতপুর', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:19'),
(3304, 'Basta', 'বাস্তা', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:20'),
(3305, 'Kalindi', 'কালিন্দি', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:22'),
(3306, 'Zinzira', 'জিনজিরা', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:23'),
(3307, 'Suvadda', 'শুভাঢ্যা', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:25'),
(3308, 'Taghoria', 'তেঘরিয়া', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:26'),
(3309, 'Konda', 'কোন্ডা', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:28'),
(3310, 'Aganagar', 'আগানগর', 6, 47, 367, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:29'),
(3311, 'Shikaripara', 'শিকারীপাড়া', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:31'),
(3312, 'Joykrishnapur', 'জয়কৃষ্ণপুর', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:32'),
(3313, 'Baruakhali', 'বারুয়াখালী', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:34'),
(3314, 'Nayansree', 'নয়নশ্রী', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:35'),
(3315, 'Sholla', 'শোল্লা', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:37'),
(3316, 'Jantrail', 'যন্ত্রাইল', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:38'),
(3317, 'Bandura', 'বান্দুরা', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:40'),
(3318, 'Kalakopa', 'কলাকোপা', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:42'),
(3319, 'Bakshanagar', 'বক্সনগর', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:43'),
(3320, 'Barrah', 'বাহ্রা', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:45'),
(3321, 'Kailail', 'কৈলাইল', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:46'),
(3322, 'Agla', 'আগলা', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:48'),
(3323, 'Galimpur', 'গালিমপুর', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:30', '2023-02-22 03:50:49'),
(3324, 'Churain', 'চুড়াইন', 6, 47, 368, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:51'),
(3325, 'Nayabari', 'নয়াবাড়ী', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:52'),
(3326, 'Kusumhathi', 'কুসুমহাটি', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:54'),
(3327, 'Raipara', 'রাইপাড়া', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:55'),
(3328, 'Sutarpara', 'সুতারপাড়া', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:57'),
(3329, 'Narisha', 'নারিশা', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:50:58'),
(3330, 'Muksudpur', 'মুকসুদপুর', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:00'),
(3331, 'Mahmudpur', 'মাহমুদপুর', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:02'),
(3332, 'Bilaspur', 'বিলাসপুর', 6, 47, 369, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:03'),
(3333, 'Rampal', 'রামপাল', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:05'),
(3334, 'Panchashar', 'পঞ্চসার', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:06'),
(3335, 'Bajrajogini', 'বজ্রযোগিনী', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:08'),
(3336, 'Mohakali', 'মহাকালী', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:09'),
(3337, 'Charkewar', 'চরকেওয়ার', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:11'),
(3338, 'Mollakandi', 'মোল্লাকান্দি', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:12'),
(3339, 'Adhara', 'আধারা', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:14'),
(3340, 'Shiloy', 'শিলই', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:15'),
(3341, 'Banglabazar', 'বাংলাবাজার', 6, 48, 370, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:17'),
(3342, 'Baraikhali', 'বাড়েখাল', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:18'),
(3343, 'Hashara', 'হাসাড়া', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:20'),
(3344, 'Birtara', 'বাড়তারা', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:21'),
(3345, 'Shologhor', 'ষোলঘর', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:23'),
(3346, 'Sreenagar', 'শ্রীনগর', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:24'),
(3347, 'Patabhog', 'পাঢাভোগ', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:31', '2023-02-22 03:51:26'),
(3348, 'Shamshiddi', 'শ্যামসিদ্দি', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:28'),
(3349, 'Kolapara', 'কুলাপাড়া', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:29'),
(3350, 'Vaggakol', 'ভাগ্যকুল', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:31'),
(3351, 'Bagra', 'বাঘড়া', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:32'),
(3352, 'Rarikhal', 'রাঢ়ীখাল', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:34'),
(3353, 'Kukutia', 'কুকুটিয়া', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:35'),
(3354, 'Atpara', 'আটপাড়া', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:37'),
(3355, 'Tantor', 'তন্তর', 6, 48, 371, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:38'),
(3356, 'Chitracoat', 'চিত্রকোট', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:40'),
(3357, 'Sekhornagar', 'শেখরনগার', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:41'),
(3358, 'Rajanagar', 'রাজানগর', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:43'),
(3359, 'Keyain', 'কেয়াইন', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:44'),
(3360, 'Basail', 'বাসাইল', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:46'),
(3361, 'Baluchar', 'বালুচর', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:47'),
(3362, 'Latabdi', 'লতাব্দী', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:49');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(3363, 'Rasunia', 'রশুনিয়া', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:50'),
(3364, 'Ichhapura', 'ইছাপুরা', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:52'),
(3365, 'Bairagadi', 'বয়রাগাদি', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:54'),
(3366, 'Malkhanagar', 'মালখানগর', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:55'),
(3367, 'Madhypara', 'মধ্যপাড়া', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:57'),
(3368, 'Kola', 'কোলা', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:51:58'),
(3369, 'Joyinshar', 'জৈনসার', 6, 48, 372, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:52:00'),
(3370, 'Medinimandal', 'মেদিনীমন্ডল', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:52:01'),
(3371, 'Kumarbhog', 'কুমারভোগ', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:52:03'),
(3372, 'Haldia', 'হলদিয়া', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:52:04'),
(3373, 'Kanaksar', 'কনকসার', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:32', '2023-02-22 03:52:06'),
(3374, 'Lohajang-Teotia', 'লৌহজং-তেওটিয়া', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:07'),
(3375, 'Bejgaon', 'বেজগাঁও', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:09'),
(3376, 'Baultoli', 'বৌলতলী', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:10'),
(3377, 'Khidirpara', 'খিদিরপাড়া', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:12'),
(3378, 'Gaodia', 'গাওদিয়া', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:13'),
(3379, 'Kalma', 'কলমা', 6, 48, 373, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:15'),
(3380, 'Gajaria', 'গজারিয়া', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:17'),
(3381, 'Baushia', 'বাউশিয়া', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:18'),
(3382, 'Vaberchar', 'ভবেরচর', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:20'),
(3383, 'Baluakandi', 'বালুয়াকান্দী', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:21'),
(3384, 'Tengarchar', 'টেংগারচর', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:23'),
(3385, 'Hosendee', 'হোসেন্দী', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:24'),
(3386, 'Guagachia', 'গুয়াগাছিয়া', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:26'),
(3387, 'Imampur', 'ইমামপুর', 6, 48, 374, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:27'),
(3388, 'Betka', 'বেতকা', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:29'),
(3389, 'Abdullapur', 'আব্দুল্লাপুর', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:30'),
(3390, 'Sonarong Tongibari', 'সোনারং টংগীবাড়ী', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:32'),
(3391, 'Autshahi', 'আউটশাহী', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:33'),
(3392, 'Arial Baligaon', 'আড়িয়ল বালিগাঁও', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:35'),
(3393, 'Dhipur', 'ধীপুর', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:36'),
(3394, 'Kathadia Shimolia', 'কাঠাদিয়া শিমুলিয়া', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:38'),
(3395, 'Joslong', 'যশলং', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:39'),
(3396, 'Panchgaon', 'পাঁচগাও', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:41'),
(3397, 'Kamarkhara', 'কামারখাড়া', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:42'),
(3398, 'Hasailbanari', 'হাসাইল বানারী', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:44'),
(3399, 'Dighirpar', 'দিঘীরপাড়', 6, 48, 375, NULL, 1, 1, 1, '2021-02-13 15:19:33', '2023-02-22 03:52:46'),
(3400, 'Mijanpur', 'মিজানপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:47'),
(3401, 'Borat', 'বরাট', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:49'),
(3402, 'Chandoni', 'চন্দনী', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:50'),
(3403, 'Khangonj', 'খানগঞ্জ', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:52'),
(3404, 'Banibaha', 'বানীবহ', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:54'),
(3405, 'Dadshee', 'দাদশী', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:56'),
(3406, 'Mulghar', 'মুলঘর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:57'),
(3407, 'Basantapur', 'বসন্তপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:52:59'),
(3408, 'Khankhanapur', 'খানখানাপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:00'),
(3409, 'Alipur', 'আলীপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:02'),
(3410, 'Ramkantapur', 'রামকান্তপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:03'),
(3411, 'Shahidwahabpur', 'শহীদওহাবপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:05'),
(3412, 'Panchuria', 'পাঁচুরিয়া', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:06'),
(3413, 'Sultanpur', 'সুলতানপুর', 6, 49, 376, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:08'),
(3414, 'Doulatdia', 'দৌলতদিয়া', 6, 49, 377, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:09'),
(3415, 'Debugram', 'দেবগ্রাম', 6, 49, 377, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:11'),
(3416, 'Uzancar', 'উজানচর', 6, 49, 377, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:12'),
(3417, 'Chotovakla', 'ছোটভাকলা', 6, 49, 377, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:14'),
(3418, 'Bahadurpur', 'বাহাদুরপুর', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:15'),
(3419, 'Habashpur', 'হাবাসপুর', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:17'),
(3420, 'Jashai', 'যশাই', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:18'),
(3421, 'Babupara', 'বাবুপাড়া', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:20'),
(3422, 'Mourat', 'মৌরাট', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:22'),
(3423, 'Patta', 'পাট্টা', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:23'),
(3424, 'Sarisha', 'সরিষা', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:34', '2023-02-22 03:53:25'),
(3425, 'Kalimahar', 'কলিমহর', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:26'),
(3426, 'Kasbamajhail', 'কসবামাজাইল', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:28'),
(3427, 'Machhpara', 'মাছপাড়া', 6, 49, 378, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:30'),
(3428, 'Islampur', 'ইসলামপুর', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:32'),
(3429, 'Baharpur', 'বহরপুর', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:33'),
(3430, 'Nawabpur', 'নবাবপুর', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:35'),
(3431, 'Narua', 'নারুয়া', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:36'),
(3432, 'Baliakandi', 'বালিয়াকান্দি', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:38'),
(3433, 'Janjal', 'জঙ্গল', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:46'),
(3434, 'Jamalpur', 'জামালপুর', 6, 49, 379, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:48'),
(3435, 'Kalukhali', 'কালুখালী', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:49'),
(3436, 'Ratandia', 'রতনদিয়া', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:51'),
(3437, 'Kalikapur', 'কালিকাপুর', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:52'),
(3438, 'Boalia', 'বোয়ালিয়া', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:54'),
(3439, 'Majbari', 'মাজবাড়ী', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:55'),
(3440, 'Madapur', 'মদাপুর', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:57'),
(3441, 'Shawrail', 'সাওরাইল', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:53:58'),
(3442, 'Mrigi', 'মৃগী', 6, 49, 380, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:00'),
(3443, 'Sirkhara', 'শিড়খাড়া', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:01'),
(3444, 'Bahadurpur', 'বাহাদুরপুর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:03'),
(3445, 'Kunia', 'কুনিয়া', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:04'),
(3446, 'Peyarpur', 'পেয়ারপুর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:06'),
(3447, 'Kandua', 'কেন্দুয়া', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:08'),
(3448, 'Mastofapur', 'মস্তফাপুর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:09'),
(3449, 'Dudkhali', 'দুধখালী', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:11'),
(3450, 'Kalikapur', 'কালিকাপুর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:35', '2023-02-22 03:54:12'),
(3451, 'Chilarchar', 'ছিলারচর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:14'),
(3452, 'Panchkhola', 'পাঁচখোলা', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:15'),
(3453, 'Ghatmajhi', 'ঘটমাঝি', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:17'),
(3454, 'Jhaoudi', 'ঝাউদী', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:18'),
(3455, 'Khoajpur', 'খোয়াজপুর', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:20'),
(3456, 'Rasti', 'রাস্তি', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:21'),
(3457, 'Dhurail', 'ধুরাইল', 6, 50, 381, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:23'),
(3458, 'Shibchar', 'শিবচর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:24'),
(3459, 'Ditiyakhando', 'দ্বিতীয়খন্ড', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:26'),
(3460, 'Nilokhe', 'নিলখি', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:27'),
(3461, 'Bandarkhola', 'বন্দরখোলা', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:29'),
(3462, 'Charjanazat', 'চরজানাজাত', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:31'),
(3463, 'Madbarerchar', 'মাদবরেরচর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:32'),
(3464, 'Panchar', 'পাঁচচর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:34'),
(3465, 'Sannasirchar', 'সন্যাসিরচর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:35'),
(3466, 'Kathalbari', 'কাঁঠালবাড়ী', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:37'),
(3467, 'Kutubpur', 'কুতুবপুর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:39'),
(3468, 'Kadirpur', 'কাদিরপুর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:40'),
(3469, 'Vhandarikandi', 'ভান্ডারীকান্দি', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:42'),
(3470, 'Bahertala South', 'বহেরাতলা দক্ষিণ', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:43'),
(3471, 'Baheratala North', 'বহেরাতলা উত্তর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:45'),
(3472, 'Baskandi', 'বাঁশকান্দি', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:47'),
(3473, 'Umedpur', 'উমেদপুর', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:49'),
(3474, 'Vhadrasion', 'ভদ্রাসন', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:50'),
(3475, 'Shiruail', 'শিরুয়াইল', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:52'),
(3476, 'Dattapara', 'দত্তপাড়া', 6, 50, 382, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:53'),
(3477, 'Alinagar', 'আলীনগর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:55'),
(3478, 'Baligram', 'বালীগ্রাম', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:36', '2023-02-22 03:54:56'),
(3479, 'Basgari', 'বাঁশগাড়ী', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:54:58'),
(3480, 'Chardoulatkhan', 'চরদৌলতখান', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:54:59'),
(3481, 'Dashar', 'ডাসার', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:01'),
(3482, 'Enayetnagor', 'এনায়েতনগর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:02'),
(3483, 'Gopalpur', 'গোপালপুর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:04'),
(3484, 'Koyaria', 'কয়ারিয়া', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:06'),
(3485, 'Kazibakai', 'কাজীবাকাই', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:07'),
(3486, 'Laxmipur', 'লক্ষীপুর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:09'),
(3487, 'Nabogram', 'নবগ্রাম', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:10'),
(3488, 'Ramjanpur', 'রমজানপুর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:12'),
(3489, 'Shahebrampur', 'সাহেবরামপুর', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:13'),
(3490, 'Shikarmongol', 'শিকারমঙ্গল', 6, 50, 383, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:15'),
(3491, 'Haridasdi-Mahendrodi', 'হরিদাসদী-মহেন্দ্রদী', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:16'),
(3492, 'Kadambari', 'কদমবাড়ী', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:18'),
(3493, 'Bajitpur', 'বাজিতপুর', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:19'),
(3494, 'Amgram', 'আমগ্রাম', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:21'),
(3495, 'Rajoir', 'রাজৈর', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:22'),
(3496, 'Khaliya', 'খালিয়া', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:24'),
(3497, 'Ishibpur', 'ইশিবপুর', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:25'),
(3498, 'Badarpasa', 'বদরপাশা', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:27'),
(3499, 'Kabirajpur', 'কবিরাজপুর', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:28'),
(3500, 'Hosenpur', 'হোসেনপুর', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:30'),
(3501, 'Paikpara', 'পাইকপাড়া', 6, 50, 384, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:32'),
(3502, 'Jalalabad', 'জালালাবাদ', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:33'),
(3503, 'Shuktail', 'শুকতাইল', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:35'),
(3504, 'Chandradighalia', 'চন্দ্রদিঘলিয়া', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:37', '2023-02-22 03:55:36'),
(3505, 'Gopinathpur', 'গোপীনাথপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:38'),
(3506, 'Paikkandi', 'পাইককান্দি', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:39'),
(3507, 'Urfi', 'উরফি', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:41'),
(3508, 'Lotifpur', 'লতিফপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:42'),
(3509, 'Satpar', 'সাতপাড়', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:44'),
(3510, 'Sahapur', 'সাহাপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:45'),
(3511, 'Horidaspur', 'হরিদাসপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:47'),
(3512, 'Ulpur', 'উলপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:48'),
(3513, 'Nizra', 'নিজড়া', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:50'),
(3514, 'Karpara', 'করপাড়া', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:51'),
(3515, 'Durgapur', 'দুর্গাপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:53'),
(3516, 'Kajulia', 'কাজুলিয়া', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:55'),
(3517, 'Majhigati', 'মাঝিগাতী', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:56'),
(3518, 'Roghunathpur', 'রঘুনাথপুর', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:58'),
(3519, 'Gobra', 'গোবরা', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:55:59'),
(3520, 'Borashi', 'বোড়াশী', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:01'),
(3521, 'Kati', 'কাঠি', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:03'),
(3522, 'Boultali', 'বৌলতলী', 6, 51, 385, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:04'),
(3523, 'Kashiani', 'কাশিয়ানী', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:06'),
(3524, 'Hatiara', 'হাতিয়াড়া', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:07'),
(3525, 'Fukura', 'ফুকরা', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:09'),
(3526, 'Rajpat', 'রাজপাট', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:10'),
(3527, 'Bethuri', 'বেথুড়ী', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:12'),
(3528, 'Nijamkandi', 'নিজামকান্দি', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:13'),
(3529, 'Sajail', 'সাজাইল', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:15'),
(3530, 'Mamudpur', 'মাহমুদপুর', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:38', '2023-02-22 03:56:16'),
(3531, 'Maheshpur', 'মহেশপুর', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:18'),
(3532, 'Orakandia', 'ওড়াকান্দি', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:19'),
(3533, 'Parulia', 'পারুলিয়া', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:21'),
(3534, 'Ratail', 'রাতইল', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:22'),
(3535, 'Puisur', 'পুইশুর', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:24'),
(3536, 'Singa', 'সিংগা', 6, 51, 386, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:25'),
(3537, 'Kushli', 'কুশলী', 6, 51, 387, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:27'),
(3538, 'Gopalpur', 'গোপালপুর', 6, 51, 387, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:29'),
(3539, 'Patgati', 'পাটগাতী', 6, 51, 387, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:30'),
(3540, 'Borni', 'বর্ণি', 6, 51, 387, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:32'),
(3541, 'Dumaria', 'ডুমরিয়া', 6, 51, 387, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:33'),
(3542, 'Sadullapur', 'সাদুল্লাপুর', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:35'),
(3543, 'Ramshil', 'রামশীল', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:36'),
(3544, 'Bandhabari', 'বান্ধাবাড়ী', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:38'),
(3545, 'Kolabari', 'কলাবাড়ী', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:39'),
(3546, 'Kushla', 'কুশলা', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:41'),
(3547, 'Amtoli', 'আমতলী', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:44'),
(3548, 'Pinjuri', 'পিঞ্জুরী', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:48'),
(3549, 'Ghaghor', 'ঘাঘর', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:51'),
(3550, 'Radhaganj', 'রাধাগঞ্জ', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:52'),
(3551, 'Hiron', 'হিরণ', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:54'),
(3552, 'Kandi', 'কান্দি', 6, 51, 388, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:56'),
(3553, 'Ujani', 'উজানী', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:57'),
(3554, 'Nanikhir', 'ননীক্ষীর', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:56:59'),
(3555, 'Dignagar', 'দিগনগর', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:57:00'),
(3556, 'Poshargati', 'পশারগাতি', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:57:02'),
(3557, 'Gobindopur', 'গোবিন্দপুর', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:39', '2023-02-22 03:57:03'),
(3558, 'Khandarpara', 'খান্দারপাড়া', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:05'),
(3559, 'Bohugram', 'বহুগ্রাম', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:06'),
(3560, 'Banshbaria', 'বাশঁবাড়িয়া', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:08'),
(3561, 'Vabrashur', 'ভাবড়াশুর', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:09'),
(3562, 'Moharajpur', 'মহারাজপুর', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:11'),
(3563, 'Batikamari', 'বাটিকামারী', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:12'),
(3564, 'Jalirpar', 'জলিরপাড়', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:14'),
(3565, 'Raghdi', 'রাঘদী', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:15'),
(3566, 'Gohala', 'গোহালা', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:17'),
(3567, 'Mochna', 'মোচনা', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:19'),
(3568, 'Kashalia', 'কাশালিয়া', 6, 51, 389, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:20'),
(3569, 'Ishangopalpur', 'ঈশানগোপালপুর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:22'),
(3570, 'Charmadbdia', 'চরমাধবদিয়া', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:23'),
(3571, 'Aliabad', 'আলিয়াবাদ', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:25'),
(3572, 'Uttarchannel', 'নর্থচ্যানেল', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:26'),
(3573, 'Decreerchar', 'ডিক্রিরচর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:28'),
(3574, 'Majchar', 'মাচ্চর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:29'),
(3575, 'Krishnanagar', 'কৃষ্ণনগর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:31'),
(3576, 'Ambikapur', 'অম্বিকাপুর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:32'),
(3577, 'Kanaipur', 'কানাইপুর', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:34'),
(3578, 'Kaijuri', 'কৈজুরী', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:40', '2023-02-22 03:57:35'),
(3579, 'Greda', 'গেরদা', 6, 52, 390, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:37'),
(3580, 'Buraich', 'বুড়াইচ', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:38'),
(3581, 'Alfadanga', 'আলফাডাঙ্গা', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:40'),
(3582, 'Tagarbanda', 'টগরবন্দ', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:41'),
(3583, 'Bana', 'বানা', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:43'),
(3584, 'Panchuria', 'পাঁচুড়িয়া', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:45'),
(3585, 'Gopalpur', 'গোপালপুর', 6, 52, 391, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:46'),
(3586, 'Boalmari', 'বোয়ালমারী', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:48'),
(3587, 'Dadpur', 'দাদপুর', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:49'),
(3588, 'Chatul', 'চতুল', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:51'),
(3589, 'Ghoshpur', 'ঘোষপুর', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:52'),
(3590, 'Gunbaha', 'গুনবহা', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:54'),
(3591, 'Chandpur', 'চাঁদপুর', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:55'),
(3592, 'Parameshwardi', 'পরমেশ্বরদী', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:57'),
(3593, 'Satair', 'সাতৈর', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:57:58'),
(3594, 'Rupapat', 'রূপাপাত', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:58:00'),
(3595, 'Shekhar', 'শেখর', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:58:01'),
(3596, 'Moyna', 'ময়না', 6, 52, 392, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:58:03'),
(3597, 'Char Bisnopur', 'চর বিষ্ণুপুর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:41', '2023-02-22 03:58:05'),
(3598, 'Akoter Char', 'আকোটের চর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:06'),
(3599, 'Char Nasirpur', 'চর নাসিরপুর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:08'),
(3600, 'Narikel Bariya', 'নারিকেল বাড়িয়া', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:09'),
(3601, 'Bhashanchar', 'ভাষানচর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:11'),
(3602, 'Krishnapur', 'কৃষ্ণপুর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:12'),
(3603, 'Sadarpur', 'সদরপুর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:14'),
(3604, 'Char Manair', 'চর মানাইর', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:15'),
(3605, 'Dhaukhali', 'ঢেউখালী', 6, 52, 393, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:17'),
(3606, 'Charjashordi', 'চরযশোরদী', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:18'),
(3607, 'Purapara', 'পুরাপাড়া', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:20'),
(3608, 'Laskardia', 'লস্করদিয়া', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:21'),
(3609, 'Ramnagar', 'রামনগর', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:23'),
(3610, 'Kaichail', 'কাইচাইল', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:24'),
(3611, 'Talma', 'তালমা', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:26'),
(3612, 'Fulsuti', 'ফুলসুতি', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:27'),
(3613, 'Dangi', 'ডাঙ্গী', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:29'),
(3614, 'Kodalia Shohidnagar', 'কোদালিয়া শহিদনগর', 6, 52, 394, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:30'),
(3615, 'Gharua', 'ঘারুয়া', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:32'),
(3616, 'Nurullagonj', 'নুরুল্যাগঞ্জ', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:34'),
(3617, 'Manikdha', 'মানিকদহ', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:35'),
(3618, 'Kawlibera', 'কাউলিবেড়া', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:37'),
(3619, 'Nasirabad', 'নাছিরাবাদ', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:38'),
(3620, 'Tujerpur', 'তুজারপুর', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:40'),
(3621, 'Algi', 'আলগী', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:41'),
(3622, 'Chumurdi', 'চুমুরদী', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:43'),
(3623, 'Kalamridha', 'কালামৃধা', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:44'),
(3624, 'Azimnagor', 'আজিমনগর', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:46'),
(3625, 'Chandra', 'চান্দ্রা', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:42', '2023-02-22 03:58:47'),
(3626, 'Hamirdi', 'হামিরদী', 6, 52, 395, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:49'),
(3627, 'Gazirtek', 'গাজীরটেক', 6, 52, 396, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:50'),
(3628, 'Char Bhadrasan', 'চর ভদ্রাসন', 6, 52, 396, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:52'),
(3629, 'Char Harirampur', 'চর হরিরামপুর', 6, 52, 396, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:53'),
(3630, 'Char Jahukanda', 'চর ঝাউকান্দা', 6, 52, 396, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:55'),
(3631, 'Madhukhali', 'মধুখালী', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:57'),
(3632, 'Jahapur', 'জাহাপুর', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:58:58'),
(3633, 'Gazna', 'গাজনা', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:00'),
(3634, 'Megchami', 'মেগচামী', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:01'),
(3635, 'Raipur', 'রায়পুর', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:03'),
(3636, 'Bagat', 'বাগাট', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:04'),
(3637, 'Dumain', 'ডুমাইন', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:06'),
(3638, 'Nowpara', 'নওপাড়া', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:07'),
(3639, 'Kamarkhali', 'কামারখালী', 6, 52, 397, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:09'),
(3640, 'Bhawal', 'ভাওয়াল', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:10'),
(3641, 'Atghar', 'আটঘর', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:43', '2023-02-22 03:59:12'),
(3642, 'Mazadia', 'মাঝারদিয়া', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:13'),
(3643, 'Ballabhdi', 'বল্লভদী', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:15'),
(3644, 'Gatti', 'গট্টি', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:16'),
(3645, 'Jadunandi', 'যদুনন্দী', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:18'),
(3646, 'Ramkantapur', 'রামকান্তপুর', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:20'),
(3647, 'Sonapur', 'সোনাপুর', 6, 52, 398, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:21'),
(3648, 'Panchagarh Sadar', 'পঞ্চগড় সদর', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:23'),
(3649, 'Satmara', 'সাতমেরা', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:24'),
(3650, 'Amarkhana', 'অমরখানা', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:26'),
(3651, 'Haribhasa', 'হাড়িভাসা', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:27'),
(3652, 'Chaklahat', 'চাকলাহাট', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:29'),
(3653, 'Hafizabad', 'হাফিজাবাদ', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:30'),
(3654, 'Kamat Kajol Dighi', 'কামাত কাজল দীঘি', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:32'),
(3655, 'Dhakkamara', 'ধাক্কামারা', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:34'),
(3656, 'Magura', 'মাগুরা', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:35'),
(3657, 'Garinabari', 'গরিনাবাড়ী', 7, 53, 399, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:37'),
(3658, 'Chilahati', 'চিলাহাটি', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:38'),
(3659, 'Shaldanga', 'শালডাঙ্গা', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:44', '2023-02-22 03:59:40'),
(3660, 'Debiganj Sadar', 'দেবীগঞ্জ সদর', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:41'),
(3661, 'Pamuli', 'পামুলী', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:43'),
(3662, 'Sundardighi', 'সুন্দরদিঘী', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:45'),
(3663, 'Sonahar Mollikadaha', 'সোনাহার মল্লিকাদহ', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:46'),
(3664, 'Tepriganj', 'টেপ্রীগঞ্জ', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:48'),
(3665, 'Dandopal', 'দন্ডপাল', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:49'),
(3666, 'Debiduba', 'দেবীডুবা', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:51'),
(3667, 'Chengthi Hazra Danga', 'চেংঠী হাজরা ডাঙ্গা', 7, 53, 400, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:52'),
(3668, 'Jholaishal Shiri', 'ঝলইশাল শিরি', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:54'),
(3669, 'Moidandighi', 'ময়দান দীঘি', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:55'),
(3670, 'Banghari', 'বেংহারী', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:57'),
(3671, 'Kajoldighi Kaligonj', 'কাজলদীঘি কালিগঞ্জ', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 03:59:58'),
(3672, 'Boroshoshi', 'বড়শশী', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 04:00:00'),
(3673, 'Chandanbari', 'চন্দনবাড়ী', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 04:00:02'),
(3674, 'Marea Bamonhat', 'মাড়েয়া বামনহাট', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 04:00:03'),
(3675, 'Boda', 'বোদা', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 04:00:05'),
(3676, 'Sakoa', 'সাকোয়া', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:45', '2023-02-22 04:00:06'),
(3677, 'Pachpir', 'পাচপীর', 7, 53, 401, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:08'),
(3678, 'Mirgapur', 'মির্জাপুর', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:09'),
(3679, 'Radhanagar', 'রাধানগর', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:11'),
(3680, 'Toria', 'তোড়িয়া', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:12'),
(3681, 'Balarampur', 'বলরামপুর', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:14'),
(3682, 'Alowakhowa', 'আলোয়াখোয়া', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:15'),
(3683, 'Dhamor', 'ধামোর', 7, 53, 402, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:17'),
(3684, 'Banglabandha', 'বাংলাবান্ধা', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:18'),
(3685, 'Bhojoanpur', 'ভজনপুর', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:20'),
(3686, 'Bhojoanpur', 'ভজনপুর', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:22'),
(3687, 'Buraburi', 'বুড়াবুড়ী', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:23'),
(3688, 'Debnagar', 'দেবনগর', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:25'),
(3689, 'Salbahan', 'শালবাহান', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:26'),
(3690, 'Tentulia', 'তেতুলিয়া', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:28'),
(3691, 'Timaihat', 'তিমাইহাট', 7, 53, 403, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:29'),
(3692, 'Joypur', 'জয়পুর', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:31'),
(3693, 'Binodnagar', 'বিনোদনগর', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:32'),
(3694, 'Golapgonj', 'গোলাপগঞ্জ', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:34'),
(3695, 'Shalkhuria', 'শালখুরিয়া', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:35'),
(3696, 'Putimara', 'পুটিমারা', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:37'),
(3697, 'Bhaduria', 'ভাদুরিয়া', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:38'),
(3698, 'Daudpur', 'দাউদপুর', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:40'),
(3699, 'Mahmudpur', 'মাহামুদপুর', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:41'),
(3700, 'Kushdaha', 'কুশদহ', 7, 54, 404, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:43'),
(3701, 'Shibrampur', 'শিবরামপুর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:44'),
(3702, 'Polashbari', 'পলাশবাড়ী', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:46', '2023-02-22 04:00:46'),
(3703, 'Shatagram', 'শতগ্রাম', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:47'),
(3704, 'Paltapur', 'পাল্টাপুর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:49'),
(3705, 'Sujalpur', 'সুজালপুর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:51'),
(3706, 'Nijpara', 'নিজপাড়া', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:52'),
(3707, 'Mohammadpur', 'মোহাম্মদপুর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:54'),
(3708, 'Bhognagar', 'ভোগনগর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:55'),
(3709, 'Sator', 'সাতোর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:57'),
(3710, 'Mohonpur', 'মোহনপুর', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:00:58'),
(3711, 'Moricha', 'মরিচা', 7, 54, 405, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:00'),
(3712, 'Bulakipur', 'বুলাকীপুর', 7, 54, 406, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:01'),
(3713, 'Palsha', 'পালশা', 7, 54, 406, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:03'),
(3714, 'Singra', 'সিংড়া', 7, 54, 406, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:04'),
(3715, 'Ghoraghat', 'ঘোড়াঘাট', 7, 54, 406, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:06'),
(3716, 'Mukundopur', 'মুকুন্দপুর', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:07'),
(3717, 'Katla', 'কাটলা', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:09'),
(3718, 'Khanpur', 'খানপুর', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:10'),
(3719, 'Dior', 'দিওড়', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:12'),
(3720, 'Binail', 'বিনাইল', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:14'),
(3721, 'Jatbani', 'জোতবানী', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:15'),
(3722, 'Poliproyagpur', 'পলিপ্রয়াগপুর', 7, 54, 407, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:17'),
(3723, 'Belaichandi', 'বেলাইচন্ডি', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:18'),
(3724, 'Monmothopur', 'মন্মথপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:20'),
(3725, 'Rampur', 'রামপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:21'),
(3726, 'Polashbari', 'পলাশবাড়ী', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:23'),
(3727, 'Chandipur', 'চন্ডীপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:47', '2023-02-22 04:01:24'),
(3728, 'Mominpur', 'মোমিনপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:26'),
(3729, 'Mostofapur', 'মোস্তফাপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:27'),
(3730, 'Habra', 'হাবড়া', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:29'),
(3731, 'Hamidpur', 'হামিদপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:30'),
(3732, 'Harirampur', 'হরিরামপুর', 7, 54, 408, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:32'),
(3733, 'Nafanagar', 'নাফানগর', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:33'),
(3734, 'Eshania', 'ঈশানিয়া', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:35'),
(3735, 'Atgaon', 'আটগাঁও', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:36'),
(3736, 'Shatail', 'ছাতইল', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:38'),
(3737, 'Rongaon', 'রনগাঁও', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:40'),
(3738, 'Murshidhat', 'মুর্শিদহাট', 7, 54, 409, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:41'),
(3739, 'Dabor', 'ডাবোর', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:43'),
(3740, 'Rasulpur', 'রসুলপুর', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:44'),
(3741, 'Mukundapur', 'মুকুন্দপুর', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:46'),
(3742, 'Targao', 'তারগাঁও', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:47'),
(3743, 'Ramchandrapur', 'রামচন্দ্রপুর', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:49'),
(3744, 'Sundarpur', 'সুন্দরপুর', 7, 54, 410, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:50'),
(3745, 'Aloary', 'এলুয়াড়ী', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:52'),
(3746, 'Aladipur', 'আলাদিপুর', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:53'),
(3747, 'Kagihal', 'কাজীহাল', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:55'),
(3748, 'Bethdighi', 'বেতদিঘী', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:56'),
(3749, 'Khairbari', 'খয়েরবাড়ী', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:58'),
(3750, 'Daulatpur', 'দৌলতপুর', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:01:59'),
(3751, 'Shibnagor', 'শিবনগর', 7, 54, 411, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:02:01'),
(3752, 'Chealgazi', 'চেহেলগাজী', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:02:03'),
(3753, 'Sundorbon', 'সুন্দরবন', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:02:04'),
(3754, 'Fazilpur', 'ফাজিলপুর', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:02:06'),
(3755, 'Shekpura', 'শেখপুরা', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:48', '2023-02-22 04:02:07'),
(3756, 'Shashora', 'শশরা', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:09'),
(3757, 'Auliapur', 'আউলিয়াপুর', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:10'),
(3758, 'Uthrail', 'উথরাইল', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:12'),
(3759, 'Sankarpur', 'শংকরপুর', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:13'),
(3760, 'Askorpur', 'আস্করপুর', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:15'),
(3761, 'Kamalpur', 'কমলপুর', 7, 54, 412, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:16'),
(3762, 'Alihat', 'আলীহাট', 7, 54, 413, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:18'),
(3763, 'Khattamadobpara', 'খট্টামাধবপাড়া', 7, 54, 413, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:19'),
(3764, 'Boalder', 'বোয়ালদার', 7, 54, 413, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:21'),
(3765, 'Alokjhari', 'আলোকঝাড়ী', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:22'),
(3766, 'Bherbheri', 'ভেড়ভেড়ী', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:24'),
(3767, 'Angarpara', 'আঙ্গারপাড়া', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:26'),
(3768, 'Goaldihi', 'গোয়ালডিহি', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:27'),
(3769, 'Bhabki', 'ভাবকী', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:29'),
(3770, 'Khamarpara', 'খামারপাড়া', 7, 54, 414, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:31'),
(3771, 'Azimpur', 'আজিমপুর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:32'),
(3772, 'Farakkabad', 'ফরাক্কাবাদ', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:34'),
(3773, 'Dhamoir', 'ধামইর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:36'),
(3774, 'Shohorgram', 'শহরগ্রাম', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:37'),
(3775, 'Birol', 'বিরল', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:39'),
(3776, 'Bhandra', 'ভান্ডারা', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:40'),
(3777, 'Bijora', 'বিজোড়া', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:42'),
(3778, 'Dharmapur', 'ধর্মপুর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:44'),
(3779, 'Mongalpur', 'মঙ্গলপুর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:45'),
(3780, 'Ranipukur', 'রাণীপুকুর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:47'),
(3781, 'Rajarampur', 'রাজারামপুর', 7, 54, 415, NULL, 1, 1, 1, '2021-02-13 15:19:49', '2023-02-22 04:02:48'),
(3782, 'Nashratpur', 'নশরতপুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:02:50'),
(3783, 'Satnala', 'সাতনালা', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:02:51'),
(3784, 'Fatejangpur', 'ফতেজংপুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:02:59'),
(3785, 'Isobpur', 'ইসবপুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:01'),
(3786, 'Abdulpur', 'আব্দুলপুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:03'),
(3787, 'Amarpur', 'অমরপুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:04'),
(3788, 'Auliapukur', 'আউলিয়াপুকুর', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:06'),
(3789, 'Saitara', 'সাইতারা', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:08'),
(3790, 'Viail', 'ভিয়াইল', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:09'),
(3791, 'Punotti', 'পুনট্টি', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:11'),
(3792, 'Tetulia', 'তেতুলিয়া', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:12'),
(3793, 'Alokdihi', 'আলোকডিহি', 7, 54, 416, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:14'),
(3794, 'Rajpur', 'রাজপুর', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:15'),
(3795, 'Harati', 'হারাটি', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:17'),
(3796, 'Mogolhat', 'মোগলহাট', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:18'),
(3797, 'Gokunda', 'গোকুন্ডা', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:20'),
(3798, 'Barobari', 'বড়বাড়ী', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:21'),
(3799, 'Kulaghat', 'কুলাঘাট', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:23'),
(3800, 'Mohendranagar', 'মহেন্দ্রনগর', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:24'),
(3801, 'Khuniagachh', 'খুনিয়াগাছ', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:26'),
(3802, 'Panchagram', 'পঞ্চগ্রাম', 7, 55, 417, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:27'),
(3803, 'Bhotmari', 'ভোটমারী', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:29'),
(3804, 'Modati', 'মদাতী', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:31'),
(3805, 'Dologram', 'দলগ্রাম', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:32'),
(3806, 'Tushbhandar', 'তুষভান্ডার', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:34'),
(3807, 'Goral', 'গোড়ল', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:35'),
(3808, 'Chondropur', 'চন্দ্রপুর', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:37'),
(3809, 'Cholbola', 'চলবলা', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:50', '2023-02-22 04:03:38'),
(3810, 'Kakina', 'কাকিনা', 7, 55, 418, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:40'),
(3811, 'Barokhata', 'বড়খাতা', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:41'),
(3812, 'Goddimari', 'গড্ডিমারী', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:43'),
(3813, 'Singimari', 'সিংগীমারী', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:44'),
(3814, 'Tongvhanga', 'টংভাঙ্গা', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:47'),
(3815, 'Sindurna', 'সিন্দুর্ণা', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:48'),
(3816, 'Paticapara', 'পাটিকাপাড়া', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:50'),
(3817, 'Nowdabas', 'নওদাবাস', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:51'),
(3818, 'Gotamari', 'গোতামারী', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:53'),
(3819, 'Vhelaguri', 'ভেলাগুড়ি', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:54'),
(3820, 'Shaniajan', 'সানিয়াজান', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:56'),
(3821, 'Fakirpara', 'ফকিরপাড়া', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:57'),
(3822, 'Dawabari', 'ডাউয়াবাড়ী', 7, 55, 419, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:03:59'),
(3823, 'Sreerampur', 'শ্রীরামপুর', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:04:00'),
(3824, 'Patgram', 'পাটগ্রাম', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:04:02'),
(3825, 'Jagatber', 'জগতবেড়', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:51', '2023-02-22 04:04:04'),
(3826, 'Kuchlibari', 'কুচলিবাড়ী', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:05'),
(3827, 'Jongra', 'জোংড়া', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:07'),
(3828, 'Baura', 'বাউড়া', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:08'),
(3829, 'Dahagram', 'দহগ্রাম', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:10'),
(3830, 'Burimari', 'বুড়িমারী', 7, 55, 420, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:11'),
(3831, 'Bhelabari', 'ভেলাবাড়ী', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:13'),
(3832, 'Bhadai', 'ভাদাই', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:14'),
(3833, 'Kamlabari', 'কমলাবাড়ী', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:16'),
(3834, 'Durgapur', 'দূর্গাপুর', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:17'),
(3835, 'Sarpukur', 'সারপুকুর', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:19'),
(3836, 'Saptibari', 'সাপ্টিবাড়ী', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:20'),
(3837, 'Palashi', 'পলাশী', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:22'),
(3838, 'Mohishkhocha', 'মহিষখোচা', 7, 55, 421, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:23'),
(3839, 'Kamarpukur', 'কামারপুকুর', 7, 56, 422, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:25'),
(3840, 'Kasiram Belpukur', 'কাশিরাম বেলপুকুর', 7, 56, 422, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:27'),
(3841, 'Bangalipur', 'বাঙ্গালীপুর', 7, 56, 422, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:28'),
(3842, 'Botlagari', 'বোতলাগাড়ী', 7, 56, 422, NULL, 1, 1, 1, '2021-02-13 15:19:52', '2023-02-22 04:04:30'),
(3843, 'Khata Madhupur', 'খাতা মধুপুর', 7, 56, 422, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:31');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(3844, 'Gomnati', 'গোমনাতি', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:33'),
(3845, 'Bhogdaburi', 'ভোগডাবুড়ী', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:34'),
(3846, 'Ketkibari', 'কেতকীবাড়ী', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:36'),
(3847, 'Jorabari', 'জোড়াবাড়ী', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:37'),
(3848, 'Bamunia', 'বামুনীয়া', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:39'),
(3849, 'Panga Motukpur', 'পাংগা মটকপুর', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:40'),
(3850, 'Boragari', 'বোড়াগাড়ী', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:42'),
(3851, 'Domar', 'ডোমার', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:43'),
(3852, 'Sonaray', 'সোনারায়', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:45'),
(3853, 'Harinchara', 'হরিণচরা', 7, 56, 423, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:46'),
(3854, 'Paschim Chhatnay', 'পশ্চিম ছাতনাই', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:48'),
(3855, 'Balapara', 'বালাপাড়া', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:50'),
(3856, 'Dimla Sadar', 'ডিমলা সদর', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:51'),
(3857, 'Khogakharibari', 'খগা খড়িবাড়ী', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:53'),
(3858, 'Gayabari', 'গয়াবাড়ী', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:54'),
(3859, 'Noutara', 'নাউতারা', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:56'),
(3860, 'Khalisha Chapani', 'খালিশা চাপানী', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:58'),
(3861, 'Jhunagach Chapani', 'ঝুনাগাছ চাপানী', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:53', '2023-02-22 04:04:59'),
(3862, 'Tepa Khribari', 'টেপা খরীবাড়ী', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:01'),
(3863, 'Purba Chhatnay', 'পুর্ব ছাতনাই', 7, 56, 424, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:02'),
(3864, 'Douabari', 'ডাউয়াবাড়ী', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:04'),
(3865, 'Golmunda', 'গোলমুন্ডা', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:05'),
(3866, 'Balagram', 'বালাগ্রাম', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:07'),
(3867, 'Golna', 'গোলনা', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:08'),
(3868, 'Dharmapal', 'ধর্মপাল', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:10'),
(3869, 'Simulbari', 'শিমুলবাড়ী', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:11'),
(3870, 'Mirganj', 'মীরগঞ্জ', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:13'),
(3871, 'Kathali', 'কাঠালী', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:15'),
(3872, 'Khutamara', 'খুটামারা', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:16'),
(3873, 'Shaulmari', 'শৌলমারী', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:18'),
(3874, 'Kaimari', 'কৈমারী', 7, 56, 425, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:19'),
(3875, 'Barabhita', 'বড়ভিটা', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:21'),
(3876, 'Putimari', 'পুটিমারী', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:23'),
(3877, 'Nitai', 'নিতাই', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:24'),
(3878, 'Bahagili', 'বাহাগিলি', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:26'),
(3879, 'Chandkhana', 'চাঁদখানা', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:27'),
(3880, 'Kishoreganj', 'কিশোরগঞ্জ', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:29'),
(3881, 'Ranachandi', 'রনচন্ডি', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:30'),
(3882, 'Garagram', 'গাড়াগ্রাম', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:32'),
(3883, 'Magura', 'মাগুরা', 7, 56, 426, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:33'),
(3884, 'Chaora Bargacha', 'চওড়া বড়গাছা', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:35'),
(3885, 'Gorgram', 'গোড়গ্রাম', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:36'),
(3886, 'Khoksabari', 'খোকসাবাড়ী', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:54', '2023-02-22 04:05:38'),
(3887, 'Palasbari', 'পলাশবাড়ী', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:39'),
(3888, 'Ramnagar', 'রামনগর', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:41'),
(3889, 'Kachukata', 'কচুকাটা', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:42'),
(3890, 'Panchapukur', 'পঞ্চপুকুর', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:44'),
(3891, 'Itakhola', 'ইটাখোলা', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:46'),
(3892, 'Kundapukur', 'কুন্দপুকুর', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:47'),
(3893, 'Sonaray', 'সোনারায়', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:49'),
(3894, 'Songalsi', 'সংগলশী', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:50'),
(3895, 'Charaikhola', 'চড়াইখোলা', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:52'),
(3896, 'Chapra Sarnjami', 'চাপড়া সরঞ্জানী', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:53'),
(3897, 'Lakshmicha', 'লক্ষ্মীচাপ', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:55'),
(3898, 'Tupamari', 'টুপামারী', 7, 56, 427, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:56'),
(3899, 'Rasulpur', 'রসুলপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:58'),
(3900, 'Noldanga', 'নলডাঙ্গা', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:05:59'),
(3901, 'Damodorpur', 'দামোদরপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:01'),
(3902, 'Jamalpur', 'জামালপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:02'),
(3903, 'Faridpur', 'ফরিদপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:04'),
(3904, 'Dhaperhat', 'ধাপেরহাট', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:05'),
(3905, 'Idilpur', 'ইদিলপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:07'),
(3906, 'Vatgram', 'ভাতগ্রাম', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:09'),
(3907, 'Bongram', 'বনগ্রাম', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:10'),
(3908, 'Kamarpara', 'কামারপাড়া', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:12'),
(3909, 'Khodkomor', 'খোদকোমরপুর', 7, 57, 428, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:13'),
(3910, 'Laxmipur', 'লক্ষ্মীপুর', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:15'),
(3911, 'Malibari', 'মালীবাড়ী', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:16'),
(3912, 'Kuptola', 'কুপতলা', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:55', '2023-02-22 04:06:18'),
(3913, 'Shahapara', 'সাহাপাড়া', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:19'),
(3914, 'Ballamjhar', 'বল্লমঝাড়', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:21'),
(3915, 'Ramchandrapur', 'রামচন্দ্রপুর', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:22'),
(3916, 'Badiakhali', 'বাদিয়াখালী', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:24'),
(3917, 'Boali', 'বোয়ালী', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:26'),
(3918, 'Ghagoa', 'ঘাগোয়া', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:27'),
(3919, 'Gidari', 'গিদারী', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:29'),
(3920, 'Kholahati', 'খোলাহাটী', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:30'),
(3921, 'Mollarchar', 'মোল্লারচর', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:32'),
(3922, 'Kamarjani', 'কামারজানি', 7, 57, 429, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:33'),
(3923, 'Kishoregari', 'কিশোরগাড়ী', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:35'),
(3924, 'Hosenpur', 'হোসেনপুর', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:36'),
(3925, 'Palashbari', 'পলাশবাড়ী', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:38'),
(3926, 'Barisal', 'বরিশাল', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:39'),
(3927, 'Mohdipur', 'মহদীপুর', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:41'),
(3928, 'Betkapa', 'বেতকাপা', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:42'),
(3929, 'Pobnapur', 'পবনাপুর', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:44'),
(3930, 'Monohorpur', 'মনোহরপুর', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:45'),
(3931, 'Harinathpur', 'হরিণাথপুর', 7, 57, 430, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:47'),
(3932, 'Padumsahar', 'পদুমশহর', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:48'),
(3933, 'Varotkhali', 'ভরতখালী', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:50'),
(3934, 'Saghata', 'সাঘাটা', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:52'),
(3935, 'Muktinagar', 'মুক্তিনগর', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:53'),
(3936, 'Kachua', 'কচুয়া', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:55'),
(3937, 'Ghuridah', 'ঘুরিদহ', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:56'),
(3938, 'Holdia', 'হলদিয়া', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:58'),
(3939, 'Jumarbari', 'জুমারবাড়ী', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:56', '2023-02-22 04:06:59'),
(3940, 'Kamalerpara', 'কামালেরপাড়া', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:01'),
(3941, 'Bonarpara', 'বোনারপাড়া', 7, 57, 431, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:02'),
(3942, 'Kamdia', 'কামদিয়া', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:04'),
(3943, 'Katabari', 'কাটাবাড়ী', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:05'),
(3944, 'Shakhahar', 'শাখাহার', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:07'),
(3945, 'Rajahar', 'রাজাহার', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:08'),
(3946, 'Sapmara', 'সাপমারা', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:10'),
(3947, 'Dorbosto', 'দরবস্ত ইয়নিয়ন', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:12'),
(3948, 'Talukkanupur', 'তালুককানুপুর', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:13'),
(3949, 'Nakai', 'নাকাই', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:15'),
(3950, 'Harirampur', 'হরিরামপুর', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:16'),
(3951, 'Rakhalburuj', 'রাখালবুরুজ', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:18'),
(3952, 'Phulbari', 'ফুলবাড়ী', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:19'),
(3953, 'Gumaniganj', 'গুমানীগঞ্জ', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:21'),
(3954, 'Kamardoho', 'কামারদহ', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:22'),
(3955, 'Kochasahar', 'কোচাশহর', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:24'),
(3956, 'Shibpur', 'শিবপুর', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:25'),
(3957, 'Mahimaganj', 'মহিমাগঞ্জ', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:27'),
(3958, 'Shalmara', 'শালমারা', 7, 57, 432, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:28'),
(3959, 'Bamondanga', 'বামনডাঙ্গা', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:30'),
(3960, 'Sonaroy', 'সোনারায়', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:31'),
(3961, 'Tarapur', 'তারাপুর', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:33'),
(3962, 'Belka', 'বেলকা', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:34'),
(3963, 'Dohbond', 'দহবন্দ', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:57', '2023-02-22 04:07:36'),
(3964, 'Sorbanondo', 'সর্বানন্দ', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:38'),
(3965, 'Ramjibon', 'রামজীবন', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:39'),
(3966, 'Dhopadanga', 'ধোপাডাঙ্গা', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:41'),
(3967, 'Chaporhati', 'ছাপরহাটী', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:42'),
(3968, 'Shantiram', 'শান্তিরাম', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:44'),
(3969, 'Konchibari', 'কঞ্চিবাড়ী', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:45'),
(3970, 'Sreepur', 'শ্রীপুর', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:47'),
(3971, 'Chandipur', 'চন্ডিপুর', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:48'),
(3972, 'Kapasia', 'কাপাসিয়া', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:50'),
(3973, 'Haripur', 'হরিপুর', 7, 57, 433, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:51'),
(3974, 'Kanchipara', 'কঞ্চিপাড়া', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:53'),
(3975, 'Uria', 'উড়িয়া', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:55'),
(3976, 'Udakhali', 'উদাখালী', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:56'),
(3977, 'Gazaria', 'গজারিয়া', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:58'),
(3978, 'Phulchari', 'ফুলছড়ি', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:07:59'),
(3979, 'Erendabari', 'এরেন্ডাবাড়ী', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:01'),
(3980, 'Fazlupur', 'ফজলুপুর', 7, 57, 434, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:02'),
(3981, 'Ruhea', 'রুহিয়া', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:04'),
(3982, 'Akhanagar', 'আখানগর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:05'),
(3983, 'Ahcha', 'আকচা', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:07'),
(3984, 'Baragaon', 'বড়গাঁও', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:09'),
(3985, 'Balia', 'বালিয়া', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:10'),
(3986, 'Auliapur', 'আউলিয়াপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:12'),
(3987, 'Chilarang', 'চিলারং', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:13'),
(3988, 'Rahimanpur', 'রহিমানপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:15'),
(3989, 'Roypur', 'রায়পুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:16'),
(3990, 'Jamalpur', 'জামালপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:58', '2023-02-22 04:08:18'),
(3991, 'Mohammadpur', 'মোহাম্মদপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:19'),
(3992, 'Salandar', 'সালন্দর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:21'),
(3993, 'Gareya', 'গড়েয়া', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:22'),
(3994, 'Rajagaon', 'রাজাগাঁও', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:24'),
(3995, 'Debipur', 'দেবীপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:25'),
(3996, 'Nargun', 'নারগুন', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:27'),
(3997, 'Jagannathpur', 'জগন্নাথপুর', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:29'),
(3998, 'Sukhanpukhari', 'শুখানপুকুরী', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:30'),
(3999, 'Begunbari', 'বেগুনবাড়ী', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:32'),
(4000, 'Ruhia Pashchim', 'রুহিয়া পশ্চিম', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:33'),
(4001, 'Dholarhat', 'ঢোলারহাট', 7, 58, 435, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:35'),
(4002, 'Bhomradaha', 'ভোমরাদহ', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:37'),
(4003, 'Kosharaniganj', 'কোষারাণীগঞ্জ', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:40'),
(4004, 'Khangaon', 'খনগাঁও', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:41'),
(4005, 'Saidpur', 'সৈয়দপুর', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:43'),
(4006, 'Pirganj', 'পীরগঞ্জ', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:44'),
(4007, 'Hajipur', 'হাজীপুর', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:46'),
(4008, 'Daulatpur', 'দৌলতপুর', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:48'),
(4009, 'Sengaon', 'সেনগাঁও', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:50'),
(4010, 'Jabarhat', 'জাবরহাট', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:51'),
(4011, 'Bairchuna', 'বৈরচুনা', 7, 58, 436, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:53'),
(4012, 'Dhormogarh', 'ধর্মগড়', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:54'),
(4013, 'Nekmorod', 'নেকমরদ', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:56'),
(4014, 'Hosengaon', 'হোসেনগাঁও', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:57'),
(4015, 'Lehemba', 'লেহেম্বা', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:08:59'),
(4016, 'Bachor', 'বাচোর', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:09:00'),
(4017, 'Kashipur', 'কাশিপুর', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:09:02'),
(4018, 'Ratore', 'রাতোর', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:19:59', '2023-02-22 04:09:04'),
(4019, 'Nonduar', 'নন্দুয়ার', 7, 58, 437, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:05'),
(4020, 'Gedura', 'গেদুড়া', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:07'),
(4021, 'Amgaon', 'আমগাঁও', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:08'),
(4022, 'Bakua', 'বকুয়া', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:10'),
(4023, 'Dangipara', 'ডাঙ্গীপাড়া', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:11'),
(4024, 'Haripur', 'হরিপুর', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:13'),
(4025, 'Bhaturia', 'ভাতুরিয়া', 7, 58, 438, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:14'),
(4026, 'Paria', 'পাড়িয়া', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:16'),
(4027, 'Charol', 'চারোল', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:17'),
(4028, 'Dhontola', 'ধনতলা', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:19'),
(4029, 'Boropalashbari', 'বড়পলাশবাড়ী', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:20'),
(4030, 'Duosuo', 'দুওসুও', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:22'),
(4031, 'Vanor', 'ভানোর', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:23'),
(4032, 'Amjankhore', 'আমজানখোর', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:25'),
(4033, 'Borobari', 'বড়বাড়ী', 7, 58, 439, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:26'),
(4034, 'Mominpur', 'মমিনপুর', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:28'),
(4035, 'Horidebpur', 'হরিদেবপুর', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:30'),
(4036, 'Uttam', 'উত্তম', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:31'),
(4037, 'Porshuram', 'পরশুরাম', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:33'),
(4038, 'Topodhan', 'তপোধন', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:34'),
(4039, 'Satgara', 'সাতগারা', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:36'),
(4040, 'Rajendrapur', 'রাজেন্দ্রপুর', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:37'),
(4041, 'Sadwapuskoroni', 'সদ্যপুস্করনী', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:39'),
(4042, 'Chandanpat', 'চন্দনপাট', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:40'),
(4043, 'Dorshona', 'দর্শানা', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:00', '2023-02-22 04:09:42'),
(4044, 'Tampat', 'তামপাট', 7, 59, 440, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:43'),
(4045, 'Betgari', 'বেতগাড়ী', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:45'),
(4046, 'Kholeya', 'খলেয়া', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:47'),
(4047, 'Borobil', 'বড়বিল', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:48'),
(4048, 'Kolcondo', 'কোলকোন্দ', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:50'),
(4049, 'Gongachora', 'গংগাচড়া', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:52'),
(4050, 'Gojoghonta', 'গজঘন্টা', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:53'),
(4051, 'Morneya', 'মর্ণেয়া', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:55'),
(4052, 'Alambiditor', 'আলমবিদিতর', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:56'),
(4053, 'Lakkhitari', 'লক্ষীটারী', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:58'),
(4054, 'Nohali', 'নোহালী', 7, 59, 441, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:09:59'),
(4055, 'Kurshatara', 'কুর্শা', 7, 59, 442, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:01'),
(4056, 'Alampur', 'আলমপুর', 7, 59, 442, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:02'),
(4057, 'Soyar', 'সয়ার', 7, 59, 442, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:04'),
(4058, 'Ikorchali', 'ইকরচালী', 7, 59, 442, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:05'),
(4059, 'Hariarkuthi', 'হাড়িয়ারকুঠি', 7, 59, 442, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:07'),
(4060, 'Radhanagar', 'রাধানগর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:01', '2023-02-22 04:10:08'),
(4061, 'Gopinathpur', 'গোপীনাথপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:10'),
(4062, 'Modhupur', 'মধুপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:11'),
(4063, 'Kutubpur', 'কুতুবপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:13'),
(4064, 'Bishnapur', 'বিষ্ণপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:15'),
(4065, 'Kalupara', 'কালুপাড়া', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:16'),
(4066, 'Lohanipara', 'লোহানীপাড়া', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:18'),
(4067, 'Gopalpur', 'গোপালপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:19'),
(4068, 'Damodorpur', 'দামোদরপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:21'),
(4069, 'Ramnathpurupb', 'রামনাথপুর', 7, 59, 443, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:22'),
(4070, 'Khoragach', 'খোরাগাছ', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:24'),
(4071, 'Ranipukur', 'রাণীপুকুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:25'),
(4072, 'Payrabond', 'পায়রাবন্দ', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:27'),
(4073, 'Vangni', 'ভাংনী', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:28'),
(4074, 'Balarhat', 'বালারহাট', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:30'),
(4075, 'Kafrikhal', 'কাফ্রিখাল', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:31'),
(4076, 'Latibpur', 'লতিবপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:33'),
(4077, 'Chengmari', 'চেংমারী', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:34'),
(4078, 'Moyenpur', 'ময়েনপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:36'),
(4079, 'Baluya Masimpur', 'বালুয়া মাসিমপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:38'),
(4080, 'Borobala', 'বড়বালা', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:39'),
(4081, 'Mirzapur', 'মির্জাপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:41'),
(4082, 'Imadpur', 'ইমাদপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:42'),
(4083, 'Milonpur', 'মিলনপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:02', '2023-02-22 04:10:44'),
(4084, 'Mgopalpur', 'গোপালপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:46'),
(4085, 'Durgapur', 'দূর্গাপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:47'),
(4086, 'Boro Hazratpur', 'বড় হযরতপুর', 7, 59, 444, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:49'),
(4087, 'Chattracol', 'চৈত্রকোল', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:50'),
(4088, 'Vendabari', 'ভেন্ডাবাড়ী', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:52'),
(4089, 'Borodargah', 'বড়দরগাহ', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:53'),
(4090, 'Kumedpur', 'কুমেদপুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:55'),
(4091, 'Modankhali', 'মদনখালী', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:56'),
(4092, 'Tukuria', 'টুকুরিয়া', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:58'),
(4093, 'Boro Alampur', 'বড় আলমপুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:10:59'),
(4094, 'Raypur', 'রায়পুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:01'),
(4095, 'Pirgonj', 'পীরগঞ্জ', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:02'),
(4096, 'Shanerhat', 'শানেরহাট', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:04'),
(4097, 'Mithipur', 'মিঠিপুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:05'),
(4098, 'Ramnathpur', 'রামনাথপুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:07'),
(4099, 'Chattra', 'চতরা', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:09'),
(4100, 'Kabilpur', 'কাবিলপুর', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:10'),
(4101, 'Pachgachi', 'পাঁচগাছী', 7, 59, 445, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:12'),
(4102, 'Sarai', 'সারাই', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:13'),
(4103, 'Balapara', 'বালাপাড়া', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:15'),
(4104, 'Shahidbag', 'শহীদবাগ', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:16'),
(4105, 'Haragach', 'হারাগাছ', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:18'),
(4106, 'Tepamodhupur', 'টেপামধুপুর', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:19'),
(4107, 'Kurshaupk', 'কুর্শা', 7, 59, 446, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:21'),
(4108, 'Kollyani', 'কল্যাণী', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:22'),
(4109, 'Parul', 'পারুল', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:24'),
(4110, 'Itakumari', 'ইটাকুমারী', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:03', '2023-02-22 04:11:26'),
(4111, 'Saula', 'ছাওলা', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:27'),
(4112, 'Kandi', 'কান্দি', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:29'),
(4113, 'Pirgacha', 'পীরগাছা', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:30'),
(4114, 'Annodanagar', 'অন্নদানগর', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:32'),
(4115, 'Tambulpur', 'তাম্বুলপুর', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:33'),
(4116, 'Koikuri', 'কৈকুড়ী', 7, 59, 447, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:35'),
(4117, 'Holokhana', 'হলোখানা', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:36'),
(4118, 'Ghogadhoh', 'ঘোগাদহ', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:38'),
(4119, 'Belgacha', 'বেলগাছা', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:39'),
(4120, 'Mogolbasa', 'মোগলবাসা', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:41'),
(4121, 'Panchgachi', 'পাঁচগাছি', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:42'),
(4122, 'Jatrapur', 'যাত্রাপুর', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:44'),
(4123, 'Kanthalbari', 'কাঁঠালবাড়ী', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:45'),
(4124, 'Bhogdanga', 'ভোগডাঙ্গা', 7, 60, 448, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:47'),
(4125, 'Ramkhana', 'রামখানা', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:48'),
(4126, 'Raigonj', 'রায়গঞ্জ', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:50'),
(4127, 'Bamondanga', 'বামনডাঙ্গা', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:51'),
(4128, 'Berubari', 'বেরুবাড়ী', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:53'),
(4129, 'Sontaspur', 'সন্তোষপুর', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:55'),
(4130, 'Hasnabad', 'হাসনাবাদ', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:56'),
(4131, 'Newyashi', 'নেওয়াশী', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:58'),
(4132, 'Bhitorbond', 'ভিতরবন্দ', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:11:59'),
(4133, 'Kaligonj', 'কালীগঞ্জ', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:12:01'),
(4134, 'Noonkhawa', 'নুনখাওয়া', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:12:02'),
(4135, 'Narayanpur', 'নারায়নপুর', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:12:04'),
(4136, 'Kedar', 'কেদার', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:12:05'),
(4137, 'Kachakata', 'কঁচাকাঁটা', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:04', '2023-02-22 04:12:07'),
(4138, 'Bollobherkhas', 'বল্লভেরখাস', 7, 60, 449, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:08'),
(4139, 'Pathordubi', 'পাথরডুবি', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:10'),
(4140, 'Shilkhuri', 'শিলখুড়ি', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:11'),
(4141, 'Tilai', 'তিলাই', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:13'),
(4142, 'Paikarchara', 'পাইকেরছড়া', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:14'),
(4143, 'Bhurungamari', 'ভূরুঙ্গামারী', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:16'),
(4144, 'Joymonirhat', 'জয়মনিরহাট', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:18'),
(4145, 'Andharirjhar', 'আন্ধারীরঝাড়', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:19'),
(4146, 'Char-Bhurungamari', 'চর-ভূরুঙ্গামারী', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:21'),
(4147, 'Bangasonahat', 'বঙ্গসোনাহাট', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:22'),
(4148, 'Boldia', 'বলদিয়া', 7, 60, 450, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:24'),
(4149, 'Nawdanga', 'নাওডাঙ্গা', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:25'),
(4150, 'Shimulbari', 'শিমুলবাড়ী', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:27'),
(4151, 'Phulbari', 'ফুলবাড়ী', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:28'),
(4152, 'Baravita', 'বড়ভিটা', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:30'),
(4153, 'Bhangamor', 'ভাঙ্গামোড়', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:31'),
(4154, 'Kashipur', 'কাশিপুর', 7, 60, 451, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:33'),
(4155, 'Chinai', 'ছিনাই', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:34'),
(4156, 'Rajarhat', 'রাজারহাট', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:36'),
(4157, 'Nazimkhan', 'নাজিমখাঁন', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:38'),
(4158, 'Gharialdanga', 'ঘড়িয়ালডাঙ্গা', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:39'),
(4159, 'Chakirpashar', 'চাকিরপশার', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:41'),
(4160, 'Biddanondo', 'বিদ্যানন্দ', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:42'),
(4161, 'Umarmajid', 'উমর মজিদ', 7, 60, 452, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:44'),
(4162, 'Daldalia', 'দলদলিয়া', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:05', '2023-02-22 04:12:45'),
(4163, 'Durgapur', 'দুর্গাপুর', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:47'),
(4164, 'Pandul', 'পান্ডুল', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:48'),
(4165, 'Buraburi', 'বুড়াবুড়ী', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:50'),
(4166, 'Dharanibari', 'ধরণীবাড়ী', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:51'),
(4167, 'Dhamsreni', 'ধামশ্রেণী', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:53'),
(4168, 'Gunaigas', 'গুনাইগাছ', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:54'),
(4169, 'Bazra', 'বজরা', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:56'),
(4170, 'Tobockpur', 'তবকপুর', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:57'),
(4171, 'Hatia', 'হাতিয়া', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:12:59'),
(4172, 'Begumgonj', 'বেগমগঞ্জ', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:01'),
(4173, 'Shahabiar Alga', 'সাহেবের আলগা', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:02'),
(4174, 'Thetrai', 'থেতরাই', 7, 60, 453, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:04'),
(4175, 'Ranigonj', 'রাণীগঞ্জ', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:05'),
(4176, 'Nayarhat', 'নয়ারহাট', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:07'),
(4177, 'Thanahat', 'থানাহাট', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:08'),
(4178, 'Ramna', 'রমনা', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:10'),
(4179, 'Chilmari', 'চিলমারী', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:11'),
(4180, 'Austomirchar', 'অষ্টমীর চর', 7, 60, 454, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:13'),
(4181, 'Dadevanga', 'দাঁতভাঙ্গা', 7, 60, 455, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:14'),
(4182, 'Shoulemari', 'শৌলমারী', 7, 60, 455, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:16'),
(4183, 'Bondober', 'বন্দবেড়', 7, 60, 455, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:17'),
(4184, 'Rowmari', 'রৌমারী', 7, 60, 455, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:19'),
(4185, 'Jadurchar', 'যাদুরচর', 7, 60, 455, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:20'),
(4186, 'Rajibpur', 'রাজিবপুর', 7, 60, 456, NULL, 1, 1, 1, '2021-02-13 15:20:06', '2023-02-22 04:13:22'),
(4187, 'Kodalkati', 'কোদালকাটি', 7, 60, 456, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:24'),
(4188, 'Mohongonj', 'মোহনগঞ্জ', 7, 60, 456, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:25'),
(4189, 'Kamararchor', 'কামারের চর', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:27'),
(4190, 'Chorsherpur', 'চরশেরপুর', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:28'),
(4191, 'Bajitkhila', 'বাজিতখিলা', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:30'),
(4192, 'Gajir Khamar', 'গাজির খামার', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:31'),
(4193, 'Dhola', 'ধলা', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:33'),
(4194, 'Pakuriya', 'পাকুরিয়া', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:35'),
(4195, 'Vatshala', 'ভাতশালা', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:36'),
(4196, 'Losmonpur', 'লছমনপুর', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:38'),
(4197, 'Rouha', 'রৌহা', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:39'),
(4198, 'Kamariya', 'কামারিয়া', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:41'),
(4199, 'Chor Mochoriya', 'চর মোচারিয়া', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:43'),
(4200, 'Chorpokhimari', 'চর পক্ষীমারি', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:45'),
(4201, 'Betmari Ghughurakandi', 'বেতমারি ঘুঘুরাকান্দি', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:47'),
(4202, 'Balairchar', 'বলাইরচর', 8, 61, 457, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:48'),
(4203, 'Puraga', 'পোড়াগাও', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:50'),
(4204, 'Nonni', 'নন্নী', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:52'),
(4205, 'Morichpuran', 'মরিচপুরাণ', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:53'),
(4206, 'Rajnogor', 'রাজনগর', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:55'),
(4207, 'Nayabil', 'নয়াবীল', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:56'),
(4208, 'Ramchondrokura', 'রামচন্দ্রকুড়া', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:13:58'),
(4209, 'Kakorkandhi', 'কাকরকান্দি', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:14:00'),
(4210, 'Nalitabari', 'নালিতাবাড়ী', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:14:01'),
(4211, 'Juganiya', 'যোগনীয়া', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:07', '2023-02-22 04:14:03'),
(4212, 'Bagber', 'বাঘবেড়', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:05'),
(4213, 'Koloshpar', 'কলসপাড়', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:07'),
(4214, 'Rupnarayankura', 'রূপনারায়নকুড়া', 8, 61, 458, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:08'),
(4215, 'Ranishimul', 'রানীশিমুল', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:10'),
(4216, 'Singabaruna', 'সিংগাবরুনা', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:12'),
(4217, 'Kakilakura', 'কাকিলাকুড়া', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:14'),
(4218, 'Tatihati', 'তাতীহাটি', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:16'),
(4219, 'Gosaipur', 'গোশাইপুর', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:17'),
(4220, 'Sreebordi', 'শ্রীবরদী', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:19'),
(4221, 'Bhelua', 'ভেলুয়া', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:20'),
(4222, 'Kharia Kazirchar', 'খড়িয়া কাজিরচর', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:22'),
(4223, 'Kurikahonia', 'কুড়িকাহনিয়া', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:24'),
(4224, 'Garjaripa', 'গড়জরিপা', 8, 61, 459, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:25'),
(4225, 'Gonopoddi', 'গণপদ্দী', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:27'),
(4226, 'Nokla', 'নকলা', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:28'),
(4227, 'Urpha', 'উরফা', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:30'),
(4228, 'Gourdwar', 'গৌড়দ্বার', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:31'),
(4229, 'Baneshwardi', 'বানেশ্বর্দী', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:33'),
(4230, 'Pathakata', 'পাঠাকাটা', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:34'),
(4231, 'Talki', 'টালকী', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:36'),
(4232, 'Choraustadhar', 'চরঅষ্টধর', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:38'),
(4233, 'Chandrakona', 'চন্দ্রকোনা', 8, 61, 460, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:39'),
(4234, 'Kansa', 'কাংশা', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:41'),
(4235, 'Dansail', 'ধানশাইল', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:42'),
(4236, 'Nolkura', 'নলকুড়া', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:44'),
(4237, 'Gouripur', 'গৌরিপুর', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:08', '2023-02-22 04:14:45'),
(4238, 'Jhenaigati', 'ঝিনাইগাতী', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:47'),
(4239, 'Hatibandha', 'হাতিবান্দা', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:48'),
(4240, 'Malijhikanda', 'মালিঝিকান্দা', 8, 61, 461, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:50'),
(4241, 'Deukhola', 'দেওখোলা', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:51'),
(4242, 'Naogaon', 'নাওগাঁও', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:53'),
(4243, 'Putijana', 'পুটিজানা', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:54'),
(4244, 'Kushmail', 'কুশমাইল', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:56'),
(4245, 'Fulbaria', 'ফুলবাড়ীয়া', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:57'),
(4246, 'Bakta', 'বাক্তা', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:14:59'),
(4247, 'Rangamatia', 'রাঙ্গামাটিয়া', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:00'),
(4248, 'Enayetpur', 'এনায়েতপুর', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:02'),
(4249, 'Kaladaha', 'কালাদহ', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:04'),
(4250, 'Radhakanai', 'রাধাকানাই', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:05'),
(4251, 'Asimpatuli', 'আছিমপাটুলী', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:07'),
(4252, 'Vobanipur', 'ভবানীপুর', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:08'),
(4253, 'Balian', 'বালিয়ান', 8, 62, 462, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:10'),
(4254, 'Dhanikhola', 'ধানীখোলা', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:11'),
(4255, 'Bailor', 'বৈলর', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:13'),
(4256, 'Kanthal', 'কাঁঠাল', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:14'),
(4257, 'Kanihari', 'কানিহারী', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:16'),
(4258, 'Trishal', 'ত্রিশাল', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:17'),
(4259, 'Harirampur', 'হরিরামপুর', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:19'),
(4260, 'Sakhua', 'সাখুয়া', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:20'),
(4261, 'Balipara', 'বালিপাড়া', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:22'),
(4262, 'Mokshapur', 'মোক্ষপুর', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:23'),
(4263, 'Mathbari', 'মঠবাড়ী', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:25'),
(4264, 'Amirabari', 'আমিরাবাড়ী', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:09', '2023-02-22 04:15:26'),
(4265, 'Rampur', 'রামপুর', 8, 62, 463, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:28'),
(4266, 'Uthura', 'উথুরা', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:30'),
(4267, 'Meduari', 'মেদুয়ারী', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:31'),
(4268, 'Varadoba', 'ভরাডোবা', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:33'),
(4269, 'Dhitpur', 'ধীতপুর', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:34'),
(4270, 'Dakatia', 'ডাকাতিয়া', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:36'),
(4271, 'Birunia', 'বিরুনিয়া', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:38'),
(4272, 'Bhaluka', 'ভালুকা', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:40'),
(4273, 'Mallikbari', 'মল্লিকবাড়ী', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:41'),
(4274, 'Kachina', 'কাচিনা', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:43'),
(4275, 'Habirbari', 'হবিরবাড়ী', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:44'),
(4276, 'Rajoi', 'রাজৈ', 8, 62, 464, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:46'),
(4277, 'Dulla', 'দুল্লা', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:47'),
(4278, 'Borogram', 'বড়গ্রাম', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:49'),
(4279, 'Tarati', 'তারাটি', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:50'),
(4280, 'Kumargata', 'কুমারগাতা', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:52'),
(4281, 'Basati', 'বাশাটি', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:53'),
(4282, 'Mankon', 'মানকোন', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:55'),
(4283, 'Ghoga', 'ঘোগা', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:57'),
(4284, 'Daogaon', 'দাওগাঁও', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:15:59'),
(4285, 'Kashimpur', 'কাশিমপুর', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:10', '2023-02-22 04:16:00'),
(4286, 'Kheruajani', 'খেরুয়াজানী', 8, 62, 465, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:02'),
(4287, 'Austadhar', 'অষ্টধার', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:03'),
(4288, 'Bororchar', 'বোররচর', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:05'),
(4289, 'Dapunia', 'দাপুনিয়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:06'),
(4290, 'Aqua', 'আকুয়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:08'),
(4291, 'Khagdohor', 'খাগডহর', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:09'),
(4292, 'Charnilaxmia', 'চরনিলক্ষিয়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:11'),
(4293, 'Kushtia', 'কুষ্টিয়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:12'),
(4294, 'Paranganj', 'পরানগঞ্জ', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:14'),
(4295, 'Sirta', 'সিরতা', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:16'),
(4296, 'Char Ishwardia', 'চর ঈশ্বরদিয়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:17'),
(4297, 'Ghagra', 'ঘাগড়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:19'),
(4298, 'Vabokhali', 'ভাবখালী', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:20'),
(4299, 'Boyra', 'বয়ড়া', 8, 62, 466, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:22'),
(4300, 'Dakshin Maijpara', 'দক্ষিণ মাইজপাড়া', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:23'),
(4301, 'Gamaritola', 'গামারীতলা', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:25'),
(4302, 'Dhobaura', 'ধোবাউড়া', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:26'),
(4303, 'Porakandulia', 'পোড়াকান্দুলিয়া', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:28'),
(4304, 'Goatala', 'গোয়াতলা', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:29'),
(4305, 'Ghoshgaon', 'ঘোষগাঁও', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:11', '2023-02-22 04:16:31'),
(4306, 'Baghber', 'বাঘবেড়', 8, 62, 467, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:32'),
(4307, 'Rambhadrapur', 'রামভদ্রপুর', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:34'),
(4308, 'Sondhara', 'ছনধরা', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:35'),
(4309, 'Vaitkandi', 'ভাইটকান্দি', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:37'),
(4310, 'Singheshwar', 'সিংহেশ্বর', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:38'),
(4311, 'Phulpur', 'ফুলপুর', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:40'),
(4312, 'Banihala', 'বানিহালা', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:42'),
(4313, 'Biska', 'বিস্কা', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:43'),
(4314, 'Baola', 'বওলা', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:45'),
(4315, 'Payari', 'পয়ারী', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:46'),
(4316, 'Balia', 'বালিয়া', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:48'),
(4317, 'Rahimganj', 'রহিমগঞ্জ', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:49'),
(4318, 'Balikha', 'বালিখা', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:51'),
(4319, 'Kakni', 'কাকনী', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:52'),
(4320, 'Dhakua', 'ঢাকুয়া', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:54'),
(4321, 'Rupasi', 'রূপসী', 8, 62, 468, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:55'),
(4322, 'Tarakanda', 'তারাকান্দা', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:57'),
(4323, 'Galagaon', 'গালাগাঁও', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:16:58'),
(4324, 'Kamargaon', 'কামারগাঁও', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:00');
INSERT INTO `master_unions` (`id`, `union_name`, `union_name_bn`, `division_id`, `district_id`, `upazila_id`, `union_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(4325, 'Kamaria', 'কামারিয়া', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:01'),
(4326, 'Rampur', 'রামপুর', 8, 62, 474, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:03'),
(4327, 'Bhubankura', 'ভূবনকুড়া', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:04'),
(4328, 'Jugli', 'জুগলী', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:06'),
(4329, 'Kaichapur', 'কৈচাপুর', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:08'),
(4330, 'Haluaghat', 'হালুয়াঘাট', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:12', '2023-02-22 04:17:09'),
(4331, 'Gazirbhita', 'গাজিরভিটা', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:11'),
(4332, 'Bildora', 'বিলডোরা', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:12'),
(4333, 'Sakuai', 'শাকুয়াই', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:14'),
(4334, 'Narail', 'নড়াইল', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:15'),
(4335, 'Dhara', 'ধারা', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:17'),
(4336, 'Dhurail', 'ধুরাইল', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:18'),
(4337, 'Amtoil', 'আমতৈল', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:20'),
(4338, 'Swadeshi', 'স্বদেশী', 8, 62, 469, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:21'),
(4339, 'Sahanati', 'সহনাটি', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:23'),
(4340, 'Achintapur', 'অচিন্তপুর', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:24'),
(4341, 'Mailakanda', 'মইলাকান্দা', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:26'),
(4342, 'Bokainagar', 'বোকাইনগর', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:27'),
(4343, 'Gouripur', 'গৌরীপুর', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:29'),
(4344, 'Maoha', 'মাওহা', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:31'),
(4345, 'Ramgopalpur', 'রামগোপালপুর', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:32'),
(4346, 'Douhakhola', 'ডৌহাখলা', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:34'),
(4347, 'Bhangnamari', 'ভাংনামারী', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:35'),
(4348, 'Sidhla', 'সিধলা', 8, 62, 470, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:37'),
(4349, 'Rasulpur', 'রসুলপুর', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:38'),
(4350, 'Barobaria', 'বারবারিয়া', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:40'),
(4351, 'Charalgi', 'চরআলগী', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:41'),
(4352, 'Saltia', 'সালটিয়া', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:43'),
(4353, 'Raona', 'রাওনা', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:44'),
(4354, 'Longair', 'লংগাইর', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:13', '2023-02-22 04:17:46'),
(4355, 'Paithol', 'পাইথল', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:47'),
(4356, 'Gafargaon', 'গফরগাঁও', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:49'),
(4357, 'Josora', 'যশরা', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:51'),
(4358, 'Moshakhali', 'মশাখালী', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:52'),
(4359, 'Panchbagh', 'পাঁচবাগ', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:54'),
(4360, 'Usthi', 'উস্থি', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:55'),
(4361, 'Dotterbazar', 'দত্তেরবাজার', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:57'),
(4362, 'Niguari', 'নিগুয়ারী', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:17:58'),
(4363, 'Tangabo', 'টাংগাব', 8, 62, 471, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:00'),
(4364, 'Iswarganj', 'ঈশ্বরগঞ্জ', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:01'),
(4365, 'Sarisha', 'সরিষা', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:03'),
(4366, 'Sohagi', 'সোহাগী', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:04'),
(4367, 'Atharabari', 'আঠারবাড়ী', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:06'),
(4368, 'Rajibpur', 'রাজিবপুর', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:07'),
(4369, 'Maijbagh', 'মাইজবাগ', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:09'),
(4370, 'Magtula', 'মগটুলা', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:10'),
(4371, 'Jatia', 'জাটিয়া', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:12'),
(4372, 'Uchakhila', 'উচাখিলা', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:14'),
(4373, 'Tarundia', 'তারুন্দিয়া', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:15'),
(4374, 'Barahit', 'বড়হিত', 8, 62, 472, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:17'),
(4375, 'Batagoir', 'বেতাগৈর', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:18'),
(4376, 'Nandail', 'নান্দাইল', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:20'),
(4377, 'Chandipasha', 'চন্ডীপাশা', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:14', '2023-02-22 04:18:21'),
(4378, 'Gangail', 'গাংগাইল', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:23'),
(4379, 'Rajgati', 'রাজগাতী', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:25'),
(4380, 'Muajjempur', 'মোয়াজ্জেমপুর', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:26'),
(4381, 'Sherpur', 'শেরপুর', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:28'),
(4382, 'Singroil', 'সিংরইল', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:29'),
(4383, 'Achargaon', 'আচারগাঁও', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:31'),
(4384, 'Mushulli', 'মুশুল্লী', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:32'),
(4385, 'Kharua', 'খারুয়া', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:34'),
(4386, 'Jahangirpur', 'জাহাঙ্গীরপুর', 8, 62, 473, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:35'),
(4387, 'Kendua', 'কেন্দুয়া', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:37'),
(4388, 'Sharifpur', 'শরিফপুর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:38'),
(4389, 'Laxirchar', 'লক্ষীরচর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:40'),
(4390, 'Tolshirchar', 'তুলশীরচর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:42'),
(4391, 'Itail', 'ইটাইল', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:43'),
(4392, 'Narundi', 'নরুন্দী', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:45'),
(4393, 'Ghorada', 'ঘোড়াধাপ', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:46'),
(4394, 'Bashchara', 'বাশঁচড়া', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:48'),
(4395, 'Ranagacha', 'রানাগাছা', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:49'),
(4396, 'Sheepur', 'শ্রীপুর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:51'),
(4397, 'Shahbajpur', 'শাহবাজপুর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:52'),
(4398, 'Titpalla', 'তিতপল্লা', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:54'),
(4399, 'Mesta', 'মেষ্টা', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:55'),
(4400, 'Digpait', 'দিগপাইত', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:57'),
(4401, 'Rashidpur', 'রশিদপুর', 8, 63, 475, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:18:58'),
(4402, 'Durmot', 'দুরমুট', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:19:00'),
(4403, 'Kulia', 'কুলিয়া', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:15', '2023-02-22 04:19:01'),
(4404, 'Mahmudpur', 'মাহমুদপুর', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:03'),
(4405, 'Nangla', 'নাংলা', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:04'),
(4406, 'Nayanagar', 'নয়ানগর', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:06'),
(4407, 'Adra', 'আদ্রা', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:08'),
(4408, 'Charbani Pakuria', 'চরবানী পাকুরিয়া', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:09'),
(4409, 'Fulkucha', 'ফুলকোচা', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:11'),
(4410, 'Ghuserpara', 'ঘোষেরপাড়া', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:12'),
(4411, 'Jhaugara', 'ঝাউগড়া', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:14'),
(4412, 'Shuampur', 'শ্যামপুর', 8, 63, 476, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:15'),
(4413, 'Kulkandi', 'কুলকান্দি', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:17'),
(4414, 'Belghacha', 'বেলগাছা', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:18'),
(4415, 'Chinaduli', 'চিনাডুলী', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:20'),
(4416, 'Shapdari', 'সাপধরী', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:21'),
(4417, 'Noarpara', 'নোয়ারপাড়া', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:23'),
(4418, 'Islampur', 'ইসলামপুর', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:24'),
(4419, 'Partharshi', 'পাথশী', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:26'),
(4420, 'Palabandha', 'পলবান্ধা', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:27'),
(4421, 'Gualerchar', 'গোয়ালেরচর', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:29'),
(4422, 'Gaibandha', 'গাইবান্ধা', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:31'),
(4423, 'Charputimari', 'চরপুটিমারী', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:32'),
(4424, 'Chargualini', 'চরগোয়ালীনি', 8, 63, 477, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:34'),
(4425, 'Dungdhara', 'ডাংধরা', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:35'),
(4426, 'Char Amkhawa', 'চর আমখাওয়া', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:37'),
(4427, 'Parram Rampur', 'পাররাম রামপুর', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:38'),
(4428, 'Hatibanga', 'হাতীভাঙ্গা', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:40'),
(4429, 'Bahadurabad', 'বাহাদুরাবাদ', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:16', '2023-02-22 04:19:41'),
(4430, 'Chikajani', 'চিকাজানী', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:43'),
(4431, 'Chukaibari', 'চুকাইবাড়ী', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:44'),
(4432, 'Dewangonj', 'দেওয়ানগঞ্জ', 8, 63, 478, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:46'),
(4433, 'Satpoa', 'সাতপোয়া', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:47'),
(4434, 'Pogaldigha', 'পোগলদিঘা', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:49'),
(4435, 'Doail', 'ডোয়াইল', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:50'),
(4436, 'Aona', 'আওনা', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:52'),
(4437, 'Pingna', 'পিংনা', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:54'),
(4438, 'Bhatara', 'ভাটারা', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:55'),
(4439, 'Kamrabad', 'কামরাবাদ', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:57'),
(4440, 'Mahadan', 'মহাদান', 8, 63, 479, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:19:58'),
(4441, 'Char Pakerdah', 'চর পাকেরদহ', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:00'),
(4442, 'Karaichara', 'কড়ইচড়া', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:01'),
(4443, 'Gunaritala', 'গুনারীতলা', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:03'),
(4444, 'Balijuri', 'বালিজুড়ী', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:04'),
(4445, 'Jorekhali', 'জোড়খালী', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:06'),
(4446, 'Adarvita', 'আদারভিটা', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:07'),
(4447, 'Sidhuli', 'সিধুলী', 8, 63, 480, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:09'),
(4448, 'Danua', 'ধানুয়া', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:10'),
(4449, 'Bagarchar', 'বগারচর', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:12'),
(4450, 'Battajore', 'বাট্রাজোড়', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:13'),
(4451, 'Shadurpara', 'সাধুরপাড়া', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:15'),
(4452, 'Bakshigonj', 'বকসীগঞ্জ', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:16'),
(4453, 'Nilakhia', 'নিলক্ষিয়া', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:18'),
(4454, 'Merurchar', 'মেরুরচর', 8, 63, 481, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:19'),
(4455, 'Asma', 'আসমা', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:21'),
(4456, 'Chhiram', 'চিরাম', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:23'),
(4457, 'Baushi', 'বাউশী', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:24'),
(4458, 'Barhatta', 'বারহাট্টা', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:17', '2023-02-22 04:20:26'),
(4459, 'Raypur', 'রায়পুর', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:27'),
(4460, 'Sahata', 'সাহতা', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:29'),
(4461, 'Singdha', 'সিংধা', 8, 64, 482, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:30'),
(4462, 'Durgapur', 'দূর্গাপুর', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:32'),
(4463, 'Kakoirgora', 'কাকৈরগড়া', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:33'),
(4464, 'Kullagora', 'কুল্লাগড়া', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:35'),
(4465, 'Chandigarh', 'চণ্ডিগড়', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:36'),
(4466, 'Birisiri', 'বিরিশিরি', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:38'),
(4467, 'Bakaljora', 'বাকলজোড়া', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:39'),
(4468, 'Gawkandia', 'গাঁওকান্দিয়া', 8, 64, 483, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:41'),
(4469, 'Asujia', 'আশুজিয়া', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:42'),
(4470, 'Dalpa', 'দলপা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:44'),
(4471, 'Goraduba', 'গড়াডোবা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:45'),
(4472, 'Gonda', 'গণ্ডা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:47'),
(4473, 'Sandikona', 'সান্দিকোনা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:48'),
(4474, 'Maska', 'মাসকা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:50'),
(4475, 'Bolaishimul', 'বলাইশিমুল', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:52'),
(4476, 'Noapara', 'নওপাড়া', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:53'),
(4477, 'Kandiura', 'কান্দিউড়া', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:55'),
(4478, 'Chirang', 'চিরাং', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:56'),
(4479, 'Roailbari Amtala', 'রোয়াইলবাড়ী আমতলা', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:58'),
(4480, 'Paikura', 'পাইকুড়া', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:20:59'),
(4481, 'Muzafarpur', 'মোজাফরপুর', 8, 64, 484, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:01'),
(4482, 'Shormushia', 'স্বরমুশিয়া', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:02'),
(4483, 'Shunoi', 'শুনই', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:04'),
(4484, 'Lunesshor', 'লুনেশ্বর', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:05'),
(4485, 'Baniyajan', 'বানিয়াজান', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:07'),
(4486, 'Teligati', 'তেলিগাতী', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:18', '2023-02-22 04:21:08'),
(4487, 'Duoj', 'দুওজ', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:10'),
(4488, 'Sukhari', 'সুখারী', 8, 64, 485, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:11'),
(4489, 'Fathepur', 'ফতেপুর', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:13'),
(4490, 'Nayekpur', 'নায়েকপুর', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:14'),
(4491, 'Teosree', 'তিয়শ্রী', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:16'),
(4492, 'Magan', 'মাঘান', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:18'),
(4493, 'Gobindasree', 'গেবিন্দশ্রী', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:19'),
(4494, 'Madan', 'মদন', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:21'),
(4495, 'Chandgaw', 'চানগাঁও', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:22'),
(4496, 'Kytail', 'কাইটাল', 8, 64, 486, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:24'),
(4497, 'Krishnapur', 'কৃষ্ণপুর', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:25'),
(4498, 'Nogor', 'নগর', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:27'),
(4499, 'Chakua', 'চাকুয়া', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:28'),
(4500, 'Khaliajuri', 'খালিয়াজুরী', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:30'),
(4501, 'Mendipur', 'মেন্দিপুর', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:31'),
(4502, 'Gazipur', 'গাজীপুর', 8, 64, 487, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:33'),
(4503, 'Koilati', 'কৈলাটী', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:34'),
(4504, 'Najirpur', 'নাজিরপুর', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:36'),
(4505, 'Pogla', 'পোগলা', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:37'),
(4506, 'Kolmakanda', 'কলমাকান্দা', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:39'),
(4507, 'Rongchati', 'রংছাতি', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:40'),
(4508, 'Lengura', 'লেংগুরা', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:42'),
(4509, 'Borokhapon', 'বড়খাপন', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:43'),
(4510, 'Kharnoi', 'খারনৈ', 8, 64, 488, NULL, 1, 1, 1, '2021-02-13 15:20:19', '2023-02-22 04:21:45'),
(4511, 'Borokashia Birampur', 'বড়কাশিয়া বিরামপুর', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:47'),
(4512, 'Borotoli Banihari', 'বড়তলী বানিহারী', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:48'),
(4513, 'Tetulia', 'তেতুলিয়া', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:51'),
(4514, 'Maghan Siadar', 'মাঘান সিয়াদার', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:53'),
(4515, 'Somaj Sohildeo', 'সমাজ সহিলদেও', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:54'),
(4516, 'Suair', 'সুয়াইর', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:56'),
(4517, 'Gaglajur', 'গাগলাজুর', 8, 64, 489, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:57'),
(4518, 'Khalishaur', 'খলিশাউড়', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:21:59'),
(4519, 'Ghagra', 'ঘাগড়া', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:00'),
(4520, 'Jaria', 'জারিয়া', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:02'),
(4521, 'Narandia', 'নারান্দিয়া', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:03'),
(4522, 'Bishkakuni', 'বিশকাকুনী', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:05'),
(4523, 'Bairaty', 'বৈরাটী', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:07'),
(4524, 'Hogla', 'হোগলা', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:08'),
(4525, 'Gohalakanda', 'গোহালাকান্দা', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:10'),
(4526, 'Dhalamulgaon', 'ধলামুলগাঁও', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:11'),
(4527, 'Agia', 'আগিয়া', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:13'),
(4528, 'Purbadhala', 'পূর্বধলা', 8, 64, 490, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:14'),
(4529, 'Chollisha', 'চল্লিশা', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:16'),
(4530, 'Kailati', 'কাইলাটি', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:20', '2023-02-22 04:22:17'),
(4531, 'Dokkhin Bishiura', 'দক্ষিণ বিশিউড়া', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:19'),
(4532, 'Modonpur', 'মদনপুর', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:20'),
(4533, 'Amtola', 'আমতলা', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:22'),
(4534, 'Lokkhiganj', 'লক্ষীগঞ্জ', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:23'),
(4535, 'Singher Bangla', 'সিংহের বাংলা', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:25'),
(4536, 'Thakurakona', 'ঠাকুরাকোণা', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:26'),
(4537, 'Mougati', 'মৌগাতি', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:28'),
(4538, 'Rouha', 'রৌহা', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:30'),
(4539, 'Medni', 'মেদনী', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:31'),
(4540, 'Kaliara Babragati', 'কালিয়ারা গাবরাগাতি', 8, 64, 491, NULL, 1, 1, 1, '2021-02-13 15:20:21', '2023-02-22 04:22:33'),
(4541, 'Bokchor', 'বকচর ', 7, 57, 432, NULL, 1, 1, 1, '2021-03-01 18:55:52', '2023-02-22 04:22:34'),
(4542, 'Nowhatta', 'নওহাট্টা ', 2, 15, 134, NULL, 1, 1, 1, '2021-05-24 10:16:45', '2023-02-22 04:22:36'),
(4543, 'Bonogram', 'বনগ্রাম', 7, 57, 428, 1, NULL, NULL, 1, '2023-01-24 03:26:04', '2023-01-24 03:26:04');

-- --------------------------------------------------------

--
-- Table structure for table `master_upazilas`
--

CREATE TABLE `master_upazilas` (
  `id` bigint UNSIGNED NOT NULL,
  `upazila_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `upazila_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` bigint UNSIGNED NOT NULL,
  `upazila_code` int UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_upazilas`
--

INSERT INTO `master_upazilas` (`id`, `upazila_name`, `upazila_name_bn`, `district_id`, `upazila_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Debidwar', 'দেবিদ্বার', 1, 7777, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(2, 'Barura', 'বরুড়া', 1, 7778, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(3, 'Brahmanpara', 'ব্রাহ্মণপাড়া', 1, 7779, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(4, 'Chandina', 'চান্দিনা', 1, 7780, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(5, 'Chauddagram', 'চৌদ্দগ্রাম', 1, 7781, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(6, 'Daudkandi', 'দাউদকান্দি', 1, 7782, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(7, 'Homna', 'হোমনা', 1, 7783, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(8, 'Laksam', 'লাকসাম', 1, 7784, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(9, 'Muradnagar', 'মুরাদনগর', 1, 7785, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(10, 'Nangalkot', 'নাঙ্গলকোট', 1, 7786, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(11, 'Comilla Sadar', 'কুমিল্লা সদর', 1, 7787, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(12, 'Meghna', 'মেঘনা', 1, 7788, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(13, 'Monohargonj', 'মনোহরগঞ্জ', 1, 7789, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(14, 'Sadarsouth', 'সদর দক্ষিণ', 1, 7790, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(15, 'Titas', 'তিতাস', 1, 7791, 1, 1, 1, '2021-02-13 16:16:29', '2021-02-13 16:16:29'),
(16, 'Burichang', 'বুড়িচং', 1, 7792, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(17, 'Lalmai', 'লালমাই', 1, 7793, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(18, 'Chhagalnaiya', 'ছাগলনাইয়া', 2, 7794, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(19, 'Feni Sadar', 'ফেনী সদর', 2, 7795, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(20, 'Sonagazi', 'সোনাগাজী', 2, 7796, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(21, 'Fulgazi', 'ফুলগাজী', 2, 7797, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(22, 'Parshuram', 'পরশুরাম', 2, 7798, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(23, 'Daganbhuiyan', 'দাগনভূঞা', 2, 7799, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(24, 'Brahmanbaria Sadar', 'ব্রাহ্মণবাড়িয়া সদর', 3, 7800, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(25, 'Kasba', 'কসবা', 3, 7801, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(26, 'Nasirnagar', 'নাসিরনগর', 3, 7802, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(27, 'Sarail', 'সরাইল', 3, 7803, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(28, 'Ashuganj', 'আশুগঞ্জ', 3, 7804, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(29, 'Akhaura', 'আখাউড়া', 3, 7805, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(30, 'Nabinagar', 'নবীনগর', 3, 7806, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(31, 'Bancharampur', 'বাঞ্ছারামপুর', 3, 7807, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(32, 'Bijoynagar', 'বিজয়নগর', 3, 7808, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(33, 'Rangamati Sadar', 'রাঙ্গামাটি সদর', 4, 7809, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(34, 'Kaptai', 'কাপ্তাই', 4, 7810, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(35, 'Kawkhali', 'কাউখালী', 4, 7811, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(36, 'Baghaichari', 'বাঘাইছড়ি', 4, 7812, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(37, 'Barkal', 'বরকল', 4, 7813, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(38, 'Langadu', 'লংগদু', 4, 7814, 1, 1, 1, '2021-02-13 16:16:30', '2021-02-13 16:16:30'),
(39, 'Rajasthali', 'রাজস্থলী', 4, 7815, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(40, 'Belaichari', 'বিলাইছড়ি', 4, 7816, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(41, 'Juraichari', 'জুরাছড়ি', 4, 7817, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(42, 'Naniarchar', 'নানিয়ারচর', 4, 7818, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(43, 'Noakhali Sadar', 'নোয়াখালী সদর', 5, 7819, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(44, 'Companiganj', 'কোম্পানীগঞ্জ', 5, 7820, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(45, 'Begumganj', 'বেগমগঞ্জ', 5, 7821, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(46, 'Hatia', 'হাতিয়া', 5, 7822, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(47, 'Subarnachar', 'সুবর্ণচর', 5, 7823, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(48, 'Kabirhat', 'কবিরহাট', 5, 7824, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(49, 'Senbug', 'সেনবাগ', 5, 7825, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(50, 'Chatkhil', 'চাটখিল', 5, 7826, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(51, 'Sonaimori', 'সোনাইমুড়ী', 5, 7827, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(52, 'Haimchar', 'হাইমচর', 6, 7828, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(53, 'Kachua', 'কচুয়া', 6, 7829, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(54, 'Shahrasti', 'শাহরাস্তি	', 6, 7830, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(55, 'Chandpur Sadar', 'চাঁদপুর সদর', 6, 7831, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(56, 'Matlab South', 'মতলব দক্ষিণ', 6, 7832, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(57, 'Hajiganj', 'হাজীগঞ্জ', 6, 7833, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(58, 'Matlab North', 'মতলব উত্তর', 6, 7834, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(59, 'Faridgonj', 'ফরিদগঞ্জ', 6, 7835, 1, 1, 1, '2021-02-13 16:16:31', '2021-02-13 16:16:31'),
(60, 'Lakshmipur Sadar', 'লক্ষ্মীপুর সদর', 7, 7836, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(61, 'Kamalnagar', 'কমলনগর', 7, 7837, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(62, 'Raipur', 'রায়পুর', 7, 7838, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(63, 'Ramgati', 'রামগতি', 7, 7839, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(64, 'Ramganj', 'রামগঞ্জ', 7, 7840, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(65, 'Rangunia', 'রাঙ্গুনিয়া', 8, 7841, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(66, 'Sitakunda', 'সীতাকুন্ড', 8, 7842, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(67, 'Mirsharai', 'মীরসরাই', 8, 7843, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(68, 'Patiya', 'পটিয়া', 8, 7844, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(69, 'Sandwip', 'সন্দ্বীপ', 8, 7845, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(70, 'Banshkhali', 'বাঁশখালী', 8, 7846, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(71, 'Boalkhali', 'বোয়ালখালী', 8, 7847, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(72, 'Anwara', 'আনোয়ারা', 8, 7848, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(73, 'Chandanaish', 'চন্দনাইশ', 8, 7849, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(74, 'Satkania', 'সাতকানিয়া', 8, 7850, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(75, 'Lohagara', 'লোহাগাড়া', 8, 7851, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(76, 'Hathazari', 'হাটহাজারী', 8, 7852, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(77, 'Fatikchhari', 'ফটিকছড়ি', 8, 7853, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(78, 'Raozan', 'রাউজান', 8, 7854, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(79, 'Karnafuli', 'কর্ণফুলী', 8, 7855, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(80, 'Coxsbazar Sadar', 'কক্সবাজার সদর', 9, 7856, 1, 1, 1, '2021-02-13 16:16:32', '2021-02-13 16:16:32'),
(81, 'Chakaria', 'চকরিয়া', 9, 7857, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(82, 'Kutubdia', 'কুতুবদিয়া', 9, 7858, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(83, 'Ukhiya', 'উখিয়া', 9, 7859, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(84, 'Moheshkhali', 'মহেশখালী', 9, 7860, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(85, 'Pekua', 'পেকুয়া', 9, 7861, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(86, 'Ramu', 'রামু', 9, 7862, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(87, 'Teknaf', 'টেকনাফ', 9, 7863, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(88, 'Khagrachhari Sadar', 'খাগড়াছড়ি সদর', 10, 7864, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(89, 'Dighinala', 'দিঘীনালা', 10, 7865, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(90, 'Panchari', 'পানছড়ি', 10, 7866, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(91, 'Laxmichhari', 'লক্ষীছড়ি', 10, 7867, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(92, 'Mohalchari', 'মহালছড়ি', 10, 7868, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(93, 'Manikchari', 'মানিকছড়ি', 10, 7869, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(94, 'Ramgarh', 'রামগড়', 10, 7870, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(95, 'Matiranga', 'মাটিরাঙ্গা', 10, 7871, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(96, 'Guimara', 'গুইমারা', 10, 7872, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(97, 'Bandarban Sadar', 'বান্দরবান সদর', 11, 7873, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(98, 'Alikadam', 'আলীকদম', 11, 7874, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(99, 'Naikhongchhari', 'নাইক্ষ্যংছড়ি', 11, 7875, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(100, 'Rowangchhari', 'রোয়াংছড়ি', 11, 7876, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(101, 'Lama', 'লামা', 11, 7877, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(102, 'Ruma', 'রুমা', 11, 7878, 1, 1, 1, '2021-02-13 16:16:33', '2021-02-13 16:16:33'),
(103, 'Thanchi', 'থানচি', 11, 7879, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(104, 'Belkuchi', 'বেলকুচি', 12, 7880, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(105, 'Chauhali', 'চৌহালি', 12, 7881, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(106, 'Kamarkhand', 'কামারখন্দ', 12, 7882, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(107, 'Kazipur', 'কাজীপুর', 12, 7883, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(108, 'Raigonj', 'রায়গঞ্জ', 12, 7884, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(109, 'Shahjadpur', 'শাহজাদপুর', 12, 7885, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(110, 'Sirajganj Sadar', 'সিরাজগঞ্জ সদর', 12, 7886, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(111, 'Tarash', 'তাড়াশ', 12, 7887, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(112, 'Ullapara', 'উল্লাপাড়া', 12, 7888, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(113, 'Sujanagar', 'সুজানগর', 13, 7889, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(114, 'Ishwardi', 'ঈশ্বরদী', 13, 7890, 1, 1, 1, '2021-02-13 16:16:34', '2021-06-02 18:01:00'),
(115, 'Bhangura', 'ভাঙ্গুড়া', 13, 7891, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(116, 'Pabna Sadar', 'পাবনা সদর', 13, 7892, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(117, 'Bera', 'বেড়া', 13, 7893, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(118, 'Atghoria', 'আটঘরিয়া', 13, 7894, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(119, 'Chatmohar', 'চাটমোহর', 13, 7895, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(120, 'Santhia', 'সাঁথিয়া', 13, 7896, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(121, 'Faridpur', 'ফরিদপুর', 13, 7897, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(122, 'Kahaloo', 'কাহালু', 14, 7898, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(123, 'Bogra Sadar', 'বগুড়া সদর', 14, 7899, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(124, 'Shariakandi', 'সারিয়াকান্দি', 14, 7900, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(125, 'Shajahanpur', 'শাজাহানপুর', 14, 7901, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(126, 'Dupchanchia', 'দুপচাচিঁয়া', 14, 7902, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(127, 'Adamdighi', 'আদমদিঘি', 14, 7903, 1, 1, 1, '2021-02-13 16:16:34', '2021-02-13 16:16:34'),
(128, 'Nondigram', 'নন্দিগ্রাম', 14, 7904, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(129, 'Sonatala', 'সোনাতলা', 14, 7905, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(130, 'Dhunot', 'ধুনট', 14, 7906, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(131, 'Gabtali', 'গাবতলী', 14, 7907, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(132, 'Sherpur', 'শেরপুর', 14, 7908, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(133, 'Shibganj', 'শিবগঞ্জ', 14, 7909, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(134, 'Paba', 'পবা', 15, 7910, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(135, 'Durgapur', 'দুর্গাপুর', 15, 7911, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(136, 'Mohonpur', 'মোহনপুর', 15, 7912, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(137, 'Charghat', 'চারঘাট', 15, 7913, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(138, 'Puthia', 'পুঠিয়া', 15, 7914, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(139, 'Bagha', 'বাঘা', 15, 7915, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(140, 'Godagari', 'গোদাগাড়ী', 15, 7916, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(141, 'Tanore', 'তানোর', 15, 7917, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(142, 'Bagmara', 'বাগমারা', 15, 7918, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(143, 'Natore Sadar', 'নাটোর সদর', 16, 7919, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(144, 'Singra', 'সিংড়া', 16, 7920, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(145, 'Baraigram', 'বড়াইগ্রাম', 16, 7921, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(146, 'Bagatipara', 'বাগাতিপাড়া', 16, 7922, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(147, 'Lalpur', 'লালপুর', 16, 7923, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(148, 'Gurudaspur', 'গুরুদাসপুর', 16, 7924, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(149, 'Naldanga', 'নলডাঙ্গা', 16, 7925, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(150, 'Akkelpur', 'আক্কেলপুর', 17, 7926, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(151, 'Kalai', 'কালাই', 17, 7927, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(152, 'Khetlal', 'ক্ষেতলাল', 17, 7928, 1, 1, 1, '2021-02-13 16:16:35', '2021-02-13 16:16:35'),
(153, 'Panchbibi', 'পাঁচবিবি', 17, 7929, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(154, 'Joypurhat Sadar', 'জয়পুরহাট সদর', 17, 7930, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(155, 'Chapainawabganj Sadar', 'চাঁপাইনবাবগঞ্জ সদর', 18, 7931, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(156, 'Gomostapur', 'গোমস্তাপুর', 18, 7932, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(157, 'Nachol', 'নাচোল', 18, 7933, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(158, 'Bholahat', 'ভোলাহাট', 18, 7934, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(159, 'Shibganj', 'শিবগঞ্জ', 18, 7935, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(160, 'Mohadevpur', 'মহাদেবপুর', 19, 7936, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(161, 'Badalgachi', 'বদলগাছী', 19, 7937, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(162, 'Patnitala', 'পত্নিতলা', 19, 7938, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(163, 'Dhamuirahata', 'ধামইরহাট', 19, 7939, 1, 1, 1, '2021-02-13 16:16:36', '2021-06-02 17:59:42'),
(164, 'Niamatpur', 'নিয়ামতপুর', 19, 7940, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(165, 'Manda', 'মান্দা', 19, 7941, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(166, 'Atrai', 'আত্রাই', 19, 7942, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(167, 'Raninagar', 'রাণীনগর', 19, 7943, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(168, 'Naogaon Sadar', 'নওগাঁ সদর', 19, 7944, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(169, 'Porsha', 'পোরশা', 19, 7945, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(170, 'Sapahar', 'সাপাহার', 19, 7946, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(171, 'Manirampur', 'মণিরামপুর', 20, 7947, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(172, 'Abhaynagar', 'অভয়নগর', 20, 7948, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(173, 'Bagherpara', 'বাঘারপাড়া', 20, 7949, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(174, 'Chougachha', 'চৌগাছা', 20, 7950, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(175, 'Jhikargacha', 'ঝিকরগাছা', 20, 7951, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(176, 'Keshabpur', 'কেশবপুর', 20, 7952, 1, 1, 1, '2021-02-13 16:16:36', '2021-02-13 16:16:36'),
(177, 'Jessore Sadar', 'যশোর সদর', 20, 7953, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(178, 'Sharsha', 'শার্শা', 20, 7954, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(179, 'Assasuni', 'আশাশুনি', 21, 7955, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(180, 'Debhata', 'দেবহাটা', 21, 7956, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(181, 'Kalaroa', 'কলারোয়া', 21, 7957, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(182, 'Satkhira Sadar', 'সাতক্ষীরা সদর', 21, 7958, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(183, 'Shyamnagar', 'শ্যামনগর', 21, 7959, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(184, 'Tala', 'তালা', 21, 7960, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(185, 'Kaliganj', 'কালিগঞ্জ', 21, 7961, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(186, 'Mujibnagar', 'মুজিবনগর', 22, 7962, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(187, 'Meherpur Sadar', 'মেহেরপুর সদর', 22, 7963, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(188, 'Gangni', 'গাংনী', 22, 7964, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(189, 'Narail Sadar', 'নড়াইল সদর', 23, 7965, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(190, 'Lohagara', 'লোহাগড়া', 23, 7966, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(191, 'Kalia', 'কালিয়া', 23, 7967, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(192, 'Chuadanga Sadar', 'চুয়াডাঙ্গা সদর', 24, 7968, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(193, 'Alamdanga', 'আলমডাঙ্গা', 24, 7969, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(194, 'Damurhuda', 'দামুড়হুদা', 24, 7970, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(195, 'Jibannagar', 'জীবননগর', 24, 7971, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(196, 'Kushtia Sadar', 'কুষ্টিয়া সদর', 25, 7972, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(197, 'Kumarkhali', 'কুমারখালী', 25, 7973, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(198, 'Khoksa', 'খোকসা', 25, 7974, 1, 1, 1, '2021-02-13 16:16:37', '2021-02-13 16:16:37'),
(199, 'Mirpur', 'মিরপুর', 25, 7975, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(200, 'Daulatpur', 'দৌলতপুর', 25, 7976, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(201, 'Bheramara', 'ভেড়ামারা', 25, 7977, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(202, 'Shalikha', 'শালিখা', 26, 7978, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(203, 'Sreepur', 'শ্রীপুর', 26, 7979, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(204, 'Magura Sadar', 'মাগুরা সদর', 26, 7980, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(205, 'Mohammadpur', 'মহম্মদপুর', 26, 7981, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(206, 'Paikgasa', 'পাইকগাছা', 27, 7982, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(207, 'Fultola', 'ফুলতলা', 27, 7983, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(208, 'Digholia', 'দিঘলিয়া', 27, 7984, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(209, 'Rupsha', 'রূপসা', 27, 7985, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(210, 'Terokhada', 'তেরখাদা', 27, 7986, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(211, 'Dumuria', 'ডুমুরিয়া', 27, 7987, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(212, 'Batiaghata ', 'বাটিয়াঘাটা', 27, 7988, 1, 1, 1, '2021-02-13 16:16:38', '2021-03-22 18:10:28'),
(213, 'Dakop', 'দাকোপ', 27, 7989, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(214, 'Koyra', 'কয়রা', 27, 7990, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(215, 'Fakirhat', 'ফকিরহাট', 28, 7991, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(216, 'Bagerhat Sadar', 'বাগেরহাট সদর', 28, 7992, 1, 1, 1, '2021-02-13 16:16:38', '2021-02-13 16:16:38'),
(217, 'Mollahat', 'মোল্লাহাট', 28, 7993, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(218, 'Sarankhola', 'শরণখোলা', 28, 7994, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(219, 'Rampal', 'রামপাল', 28, 7995, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(220, 'Morrelganj', 'মোড়েলগঞ্জ', 28, 7996, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(221, 'Kachua', 'কচুয়া', 28, 7997, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(222, 'Mongla', 'মোংলা', 28, 7998, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(223, 'Chitalmari', 'চিতলমারী', 28, 7999, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(224, 'Jhenaidah Sadar', 'ঝিনাইদহ সদর', 29, 8000, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(225, 'Shailkupa', 'শৈলকুপা', 29, 8001, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(226, 'Harinakundu', 'হরিণাকুন্ডু', 29, 8002, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(227, 'Kaliganj', 'কালীগঞ্জ', 29, 8003, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(228, 'Kotchandpur', 'কোটচাঁদপুর', 29, 8004, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(229, 'Moheshpur', 'মহেশপুর', 29, 8005, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(230, 'Jhalakathi Sadar', 'ঝালকাঠি সদর', 30, 8006, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(231, 'Kathalia', 'কাঠালিয়া', 30, 8007, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(232, 'Nalchity', 'নলছিটি', 30, 8008, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(233, 'Rajapur', 'রাজাপুর', 30, 8009, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(234, 'Bauphal', 'বাউফল', 31, 8010, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(235, 'Patuakhali Sadar', 'পটুয়াখালী সদর', 31, 8011, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(236, 'Dumki', 'দুমকি', 31, 8012, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(237, 'Dashmina', 'দশমিনা', 31, 8013, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(238, 'Kalapara', 'কলাপাড়া', 31, 8014, 1, 1, 1, '2021-02-13 16:16:39', '2021-02-13 16:16:39'),
(239, 'Mirzaganj', 'মির্জাগঞ্জ', 31, 8015, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(240, 'Galachipa', 'গলাচিপা', 31, 8016, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(241, 'Rangabali', 'রাঙ্গাবালী', 31, 8017, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(242, 'Pirojpur Sadar', 'পিরোজপুর সদর', 32, 8018, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(243, 'Nazirpur', 'নাজিরপুর', 32, 8019, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(244, 'Kawkhali', 'কাউখালী', 32, 8020, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(245, 'Zianagar', 'জিয়ানগর', 32, 8021, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(246, 'Bhandaria', 'ভান্ডারিয়া', 32, 8022, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(247, 'Mathbaria', 'মঠবাড়ীয়া', 32, 8023, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(248, 'Nesarabad', 'নেছারাবাদ', 32, 8024, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(249, 'Barisal Sadar', 'বরিশাল সদর', 33, 8025, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(250, 'Bakerganj', 'বাকেরগঞ্জ', 33, 8026, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(251, 'Babuganj', 'বাবুগঞ্জ', 33, 8027, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(252, 'Wazirpur', 'উজিরপুর', 33, 8028, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(253, 'Banaripara', 'বানারীপাড়া', 33, 8029, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(254, 'Gournadi', 'গৌরনদী', 33, 8030, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(255, 'Agailjhara', 'আগৈলঝাড়া', 33, 8031, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(256, 'Mehendiganj', 'মেহেন্দিগঞ্জ', 33, 8032, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(257, 'Muladi', 'মুলাদী', 33, 8033, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(258, 'Hizla', 'হিজলা', 33, 8034, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(259, 'Bhola Sadar', 'ভোলা সদর', 34, 8035, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(260, 'Borhan Uddin', 'বোরহান উদ্দিন', 34, 8036, 1, 1, 1, '2021-02-13 16:16:40', '2021-06-04 11:09:24'),
(261, 'Charfesson', 'চরফ্যাশন', 34, 8037, 1, 1, 1, '2021-02-13 16:16:40', '2021-02-13 16:16:40'),
(262, 'Doulatkhan', 'দৌলতখান', 34, 8038, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(263, 'Monpura', 'মনপুরা', 34, 8039, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(264, 'Tazumuddin', 'তজুমদ্দিন', 34, 8040, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(265, 'Lalmohan', 'লালমোহন', 34, 8041, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(266, 'Amtali', 'আমতলী', 35, 8042, 1, 1, 1, '2021-02-13 16:16:41', '2021-12-19 05:38:06'),
(267, 'Barguna Sadar', 'বরগুনা সদর', 35, 8043, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(268, 'Betagi', 'বেতাগী', 35, 8044, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(269, 'Bamna', 'বামনা', 35, 8045, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(270, 'Pathorghata', 'পাথরঘাটা', 35, 8046, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(271, 'Taltali', 'তালতলি', 35, 8047, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(272, 'Balaganj', 'বালাগঞ্জ', 36, 8048, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(273, 'Beanibazar ', 'বিয়ানীবাজার', 36, 8049, 1, 1, 1, '2021-02-13 16:16:41', '2021-06-02 17:46:39'),
(274, 'Bishwanath', 'বিশ্বনাথ', 36, 8050, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(275, 'Companiganj', 'কোম্পানীগঞ্জ', 36, 8051, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(276, 'Fenchuganj', 'ফেঞ্চুগঞ্জ', 36, 8052, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(277, 'Golapganj', 'গোলাপগঞ্জ', 36, 8053, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(278, 'Gowainghat', 'গোয়াইনঘাট', 36, 8054, 1, 1, 1, '2021-02-13 16:16:41', '2021-02-13 16:16:41'),
(279, 'Jaintiapur', 'জৈন্তাপুর', 36, 8055, 1, 1, 1, '2021-02-13 16:16:42', '2021-02-13 16:16:42'),
(280, 'Kanaighat', 'কানাইঘাট', 36, 8056, 1, 1, 1, '2021-02-13 16:16:42', '2021-02-13 16:16:42'),
(281, 'Sylhet Sadar', 'সিলেট সদর', 36, 8057, 1, 1, 1, '2021-02-13 16:16:42', '2021-02-13 16:16:42'),
(282, 'Zakiganj', 'জকিগঞ্জ', 36, 8058, 1, 1, 1, '2021-02-13 16:16:42', '2021-02-13 16:16:42'),
(283, 'Dakshinsurma', 'দক্ষিণ সুরমা', 36, 8059, 1, 1, 1, '2021-02-13 16:16:42', '2021-02-13 16:16:42'),
(284, 'Osmaninagar', 'ওসমানী নগর', 36, 8060, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(285, 'Borolekha ', 'বড়লেখা', 37, 8061, 1, 1, 1, '2021-02-13 16:16:43', '2021-06-02 17:43:53'),
(286, 'Kamolganj', 'কমলগঞ্জ', 37, 8062, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(287, 'Kulaura', 'কুলাউড়া', 37, 8063, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(288, 'Moulvibazar Sadar', 'মৌলভীবাজার সদর', 37, 8064, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(289, 'Rajnagar', 'রাজনগর', 37, 8065, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(290, 'Sreemangal', 'শ্রীমঙ্গল', 37, 8066, 1, 1, 1, '2021-02-13 16:16:43', '2021-02-13 16:16:43'),
(291, 'Juri', 'জুড়ী', 37, 8067, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(292, 'Nabiganj', 'নবীগঞ্জ', 38, 8068, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(293, 'Bahubal', 'বাহুবল', 38, 8069, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(294, 'Ajmiriganj', 'আজমিরীগঞ্জ', 38, 8070, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(295, 'Baniachong', 'বানিয়াচং', 38, 8071, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(296, 'Lakhai', 'লাখাই', 38, 8072, 1, 1, 1, '2021-02-13 16:16:44', '2021-02-13 16:16:44'),
(297, 'Chunarughat', 'চুনারুঘাট', 38, 8073, 1, 1, 1, '2021-02-13 16:16:45', '2021-02-13 16:16:45'),
(298, 'Habiganj Sadar', 'হবিগঞ্জ সদর', 38, 8074, 1, 1, 1, '2021-02-13 16:16:45', '2021-02-13 16:16:45'),
(299, 'Madhabpur', 'মাধবপুর', 38, 8075, 1, 1, 1, '2021-02-13 16:16:45', '2021-02-13 16:16:45'),
(300, 'Sunamganj Sadar', 'সুনামগঞ্জ সদর', 39, 8076, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(301, 'South Sunamganj', 'দক্ষিণ সুনামগঞ্জ', 39, 8077, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(302, 'Bishwambarpur', 'বিশ্বম্ভরপুর', 39, 8078, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(303, 'Chhatak', 'ছাতক', 39, 8079, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(304, 'Jagannathpur', 'জগন্নাথপুর', 39, 8080, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(305, 'Dowarabazar', 'দোয়ারাবাজার', 39, 8081, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(306, 'Tahirpur', 'তাহিরপুর', 39, 8082, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(307, 'Dharmapasha', 'ধর্মপাশা', 39, 8083, 1, 1, 1, '2021-02-13 16:16:46', '2021-02-13 16:16:46'),
(308, 'Jamalganj', 'জামালগঞ্জ', 39, 8084, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(309, 'Shalla', 'শাল্লা', 39, 8085, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(310, 'Derai', 'দিরাই', 39, 8086, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(311, 'Belabo', 'বেলাবো', 40, 8087, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(312, 'Monohardi', 'মনোহরদী', 40, 8088, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(313, 'Narsingdi Sadar', 'নরসিংদী সদর', 40, 8089, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(314, 'Palash', 'পলাশ', 40, 8090, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(315, 'Raipura', 'রায়পুরা', 40, 8091, 1, 1, 1, '2021-02-13 16:16:47', '2021-02-13 16:16:47'),
(316, 'Shibpur', 'শিবপুর', 40, 8092, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(317, 'Kaliganj', 'কালীগঞ্জ', 41, 8093, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(318, 'Kaliakair', 'কালিয়াকৈর', 41, 8094, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(319, 'Kapasia', 'কাপাসিয়া', 41, 8095, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(320, 'Gazipur Sadar', 'গাজীপুর সদর', 41, 8096, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(321, 'Sreepur', 'শ্রীপুর', 41, 8097, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(322, 'Shariatpur Sadar', 'শরিয়তপুর সদর', 42, 8098, 1, 1, 1, '2021-02-13 16:16:48', '2021-02-13 16:16:48'),
(323, 'Naria', 'নড়িয়া', 42, 8099, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(324, 'Zajira', 'জাজিরা', 42, 8100, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(325, 'Gosairhat', 'গোসাইরহাট', 42, 8101, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(326, 'Bhedarganj', 'ভেদরগঞ্জ', 42, 8102, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(327, 'Damudya', 'ডামুড্যা', 42, 8103, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(328, 'Araihazar', 'আড়াইহাজার', 43, 8104, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(329, 'Bandar', 'বন্দর', 43, 8105, 1, 1, 1, '2021-02-13 16:16:49', '2021-02-13 16:16:49'),
(330, 'Narayanganj Sadar', 'নারায়নগঞ্জ সদর', 43, 8106, 1, 1, 1, '2021-02-13 16:16:50', '2021-02-13 16:16:50'),
(331, 'Rupganj', 'রূপগঞ্জ', 43, 8107, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(332, 'Sonargaon', 'সোনারগাঁ', 43, 8108, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(333, 'Basail', 'বাসাইল', 44, 8109, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(334, 'Bhuapur', 'ভুয়াপুর', 44, 8110, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(335, 'Delduar', 'দেলদুয়ার', 44, 8111, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(336, 'Ghatail', 'ঘাটাইল', 44, 8112, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(337, 'Gopalpur', 'গোপালপুর', 44, 8113, 1, 1, 1, '2021-02-13 16:16:51', '2021-02-13 16:16:51'),
(338, 'Madhupur', 'মধুপুর', 44, 8114, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(339, 'Mirzapur', 'মির্জাপুর', 44, 8115, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(340, 'Nagarpur', 'নাগরপুর', 44, 8116, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(341, 'Sakhipur', 'সখিপুর', 44, 8117, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(342, 'Tangail Sadar', 'টাঙ্গাইল সদর', 44, 8118, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(343, 'Kalihati', 'কালিহাতী', 44, 8119, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(344, 'Dhanbari', 'ধনবাড়ী', 44, 8120, 1, 1, 1, '2021-02-13 16:16:52', '2021-02-13 16:16:52'),
(345, 'Itna', 'ইটনা', 45, 8121, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(346, 'Katiadi', 'কটিয়াদী', 45, 8122, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(347, 'Bhairab', 'ভৈরব', 45, 8123, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(348, 'Tarail', 'তাড়াইল', 45, 8124, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(349, 'Hossainpur', 'হোসেনপুর', 45, 8125, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(350, 'Pakundia', 'পাকুন্দিয়া', 45, 8126, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(351, 'Kuliarchar', 'কুলিয়ারচর', 45, 8127, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(352, 'Kishoreganj Sadar', 'কিশোরগঞ্জ সদর', 45, 8128, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(353, 'Karimgonj', 'করিমগঞ্জ', 45, 8129, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(354, 'Bajitpur', 'বাজিতপুর', 45, 8130, 1, 1, 1, '2021-02-13 16:16:53', '2021-02-13 16:16:53'),
(355, 'Austagram', 'অষ্টগ্রাম', 45, 8131, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(356, 'Mithamoin', 'মিঠামইন', 45, 8132, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(357, 'Nikli', 'নিকলী', 45, 8133, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(358, 'Harirampur', 'হরিরামপুর', 46, 8134, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(359, 'Saturia', 'সাটুরিয়া', 46, 8135, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(360, 'Manikganj Sadar', 'মানিকগঞ্জ সদর', 46, 8136, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(361, 'Gior', 'ঘিওর', 46, 8137, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(362, 'Shibaloy', 'শিবালয়', 46, 8138, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(363, 'Doulatpur', 'দৌলতপুর', 46, 8139, 1, 1, 1, '2021-02-13 16:16:54', '2021-02-13 16:16:54'),
(364, 'Singair', 'সিংগাইর', 46, 8140, 1, 1, 1, '2021-02-13 16:16:55', '2021-06-02 17:18:07'),
(365, 'Savar', 'সাভার', 47, 8141, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(366, 'Dhamrai', 'ধামরাই', 47, 8142, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(367, 'Keraniganj', 'কেরাণীগঞ্জ', 47, 8143, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(368, 'Nawabganj', 'নবাবগঞ্জ', 47, 8144, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(369, 'Dohar', 'দোহার', 47, 8145, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(370, 'Munshiganj Sadar', 'মুন্সিগঞ্জ সদর', 48, 8146, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(371, 'Sreenagar', 'শ্রীনগর', 48, 8147, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(372, 'Sirajdikhan', 'সিরাজদিখান', 48, 8148, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(373, 'Louhajanj', 'লৌহজং', 48, 8149, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(374, 'Gajaria', 'গজারিয়া', 48, 8150, 1, 1, 1, '2021-02-13 16:16:55', '2021-02-13 16:16:55'),
(375, 'Tongibari', 'টংগীবাড়ি', 48, 8151, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(376, 'Rajbari Sadar', 'রাজবাড়ী সদর', 49, 8152, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(377, 'Goalanda', 'গোয়ালন্দ', 49, 8153, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(378, 'Pangsa', 'পাংশা', 49, 8154, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(379, 'Baliakandi', 'বালিয়াকান্দি', 49, 8155, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(380, 'Kalukhali', 'কালুখালী', 49, 8156, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(381, 'Madaripur Sadar', 'মাদারীপুর সদর', 50, 8157, 1, 1, 1, '2021-02-13 16:16:56', '2021-02-13 16:16:56'),
(382, 'Shibchar', 'শিবচর', 50, 8158, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(383, 'Kalkini', 'কালকিনি', 50, 8159, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(384, 'Rajoir', 'রাজৈর', 50, 8160, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(385, 'Gopalganj Sadar', 'গোপালগঞ্জ সদর', 51, 8161, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(386, 'Kashiani', 'কাশিয়ানী', 51, 8162, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(387, 'Tungipara', 'টুংগীপাড়া', 51, 8163, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(388, 'Kotalipara', 'কোটালীপাড়া', 51, 8164, 1, 1, 1, '2021-02-13 16:16:57', '2021-02-13 16:16:57'),
(389, 'Muksudpur', 'মুকসুদপুর', 51, 8165, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(390, 'Faridpur Sadar', 'ফরিদপুর সদর', 52, 8166, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(391, 'Alfadanga', 'আলফাডাঙ্গা', 52, 8167, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(392, 'Boalmari', 'বোয়ালমারী', 52, 8168, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(393, 'Sadarpur', 'সদরপুর', 52, 8169, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(394, 'Nagarkanda', 'নগরকান্দা', 52, 8170, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(395, 'Bhanga', 'ভাঙ্গা', 52, 8171, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(396, 'Charbhadrasan', 'চরভদ্রাসন', 52, 8172, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(397, 'Madhukhali', 'মধুখালী', 52, 8173, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(398, 'Saltha', 'সালথা', 52, 8174, 1, 1, 1, '2021-02-13 16:16:58', '2021-02-13 16:16:58'),
(399, 'Panchagarh Sadar', 'পঞ্চগড় সদর', 53, 8175, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(400, 'Debiganj', 'দেবীগঞ্জ', 53, 8176, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(401, 'Boda', 'বোদা', 53, 8177, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(402, 'Atwari', 'আটোয়ারী', 53, 8178, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(403, 'Tetulia', 'তেতুলিয়া', 53, 8179, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(404, 'Nawabganj', 'নবাবগঞ্জ', 54, 8180, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(405, 'Birganj', 'বীরগঞ্জ', 54, 8181, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(406, 'Ghoraghat', 'ঘোড়াঘাট', 54, 8182, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(407, 'Birampur', 'বিরামপুর', 54, 8183, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(408, 'Parbatipur', 'পার্বতীপুর', 54, 8184, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(409, 'Bochaganj', 'বোচাগঞ্জ', 54, 8185, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(410, 'Kaharol', 'কাহারোল', 54, 8186, 1, 1, 1, '2021-02-13 16:16:59', '2021-02-13 16:16:59'),
(411, 'Fulbari', 'ফুলবাড়ী', 54, 8187, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(412, 'Dinajpur Sadar', 'দিনাজপুর সদর', 54, 8188, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(413, 'Hakimpur', 'হাকিমপুর', 54, 8189, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(414, 'Khansama', 'খানসামা', 54, 8190, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(415, 'Birol', 'বিরল', 54, 8191, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(416, 'Chirirbandar', 'চিরিরবন্দর', 54, 8192, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(417, 'Lalmonirhat Sadar', 'লালমনিরহাট সদর', 55, 8193, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(418, 'Kaliganj', 'কালীগঞ্জ', 55, 8194, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(419, 'Hatibandha', 'হাতীবান্ধা', 55, 8195, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(420, 'Patgram', 'পাটগ্রাম', 55, 8196, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(421, 'Aditmari', 'আদিতমারী', 55, 8197, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(422, ' Saidpur', 'সৈয়দপুর', 56, 8198, 1, 1, 1, '2021-02-13 16:17:00', '2021-06-04 12:15:09'),
(423, 'Domar', 'ডোমার', 56, 8199, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(424, 'Dimla', 'ডিমলা', 56, 8200, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(425, 'Jaldhaka', 'জলঢাকা', 56, 8201, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(426, 'Kishorganj', 'কিশোরগঞ্জ', 56, 8202, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(427, 'Nilphamari Sadar', 'নীলফামারী সদর', 56, 8203, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(428, 'Sadullapur', 'সাদুল্লাপুর', 57, 8204, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(429, 'Gaibandha Sadar', 'গাইবান্ধা সদর', 57, 8205, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(430, 'Palashbari', 'পলাশবাড়ী', 57, 8206, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(431, 'Saghata', 'সাঘাটা', 57, 8207, 1, 1, 1, '2021-02-13 16:17:00', '2021-02-13 16:17:00'),
(432, 'Gobindaganj', 'গোবিন্দগঞ্জ', 57, 8208, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(433, 'Sundarganj', 'সুন্দরগঞ্জ', 57, 8209, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(434, 'Phulchari', 'ফুলছড়ি', 57, 8210, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(435, 'Thakurgaon Sadar', 'ঠাকুরগাঁও সদর', 58, 8211, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(436, 'Pirganj', 'পীরগঞ্জ', 58, 8212, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(437, 'Ranisankail', 'রাণীশংকৈল', 58, 8213, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(438, 'Haripur', 'হরিপুর', 58, 8214, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(439, 'Baliadangi', 'বালিয়াডাঙ্গী', 58, 8215, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(440, 'Rangpur Sadar', 'রংপুর সদর', 59, 8216, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(441, 'Gangachara', 'গংগাচড়া', 59, 8217, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(442, 'Taragonj', 'তারাগঞ্জ', 59, 8218, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(443, 'Badargonj', 'বদরগঞ্জ', 59, 8219, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(444, 'Mithapukur', 'মিঠাপুকুর', 59, 8220, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(445, 'Pirgonj', 'পীরগঞ্জ', 59, 8221, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(446, 'Kaunia', 'কাউনিয়া', 59, 8222, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(447, 'Pirgacha', 'পীরগাছা', 59, 8223, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(448, 'Kurigram Sadar', 'কুড়িগ্রাম সদর', 60, 8224, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(449, 'Nageshwari', 'নাগেশ্বরী', 60, 8225, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(450, 'Bhurungamari', 'ভুরুঙ্গামারী', 60, 8226, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(451, 'Phulbari', 'ফুলবাড়ী', 60, 8227, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(452, 'Rajarhat', 'রাজারহাট', 60, 8228, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(453, 'Ulipur', 'উলিপুর', 60, 8229, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(454, 'Chilmari', 'চিলমারী', 60, 8230, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(455, 'Rowmari', 'রৌমারী', 60, 8231, 1, 1, 1, '2021-02-13 16:17:01', '2021-02-13 16:17:01'),
(456, 'Charrajibpur', 'চর রাজিবপুর', 60, 8232, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(457, 'Sherpur Sadar', 'শেরপুর সদর', 61, 8233, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(458, 'Nalitabari', 'নালিতাবাড়ী', 61, 8234, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(459, 'Sreebordi', 'শ্রীবরদী', 61, 8235, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(460, 'Nokla', 'নকলা', 61, 8236, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(461, 'Jhenaigati', 'ঝিনাইগাতী', 61, 8237, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(462, 'Fulbaria', 'ফুলবাড়ীয়া', 62, 8238, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(463, 'Trishal', 'ত্রিশাল', 62, 8239, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(464, 'Bhaluka', 'ভালুকা', 62, 8240, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(465, 'Muktagacha', 'মুক্তাগাছা', 62, 8241, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(466, 'Mymensingh Sadar', 'ময়মনসিংহ সদর', 62, 8242, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(467, 'Dhobaura', 'ধোবাউড়া', 62, 8243, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(468, 'Phulpur', 'ফুলপুর', 62, 8244, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(469, 'Haluaghat', 'হালুয়াঘাট', 62, 8245, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(470, 'Gouripur', 'গৌরীপুর', 62, 8246, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(471, 'Gafargaon', 'গফরগাঁও', 62, 8247, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(472, 'Iswarganj', 'ঈশ্বরগঞ্জ', 62, 8248, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(473, 'Nandail', 'নান্দাইল', 62, 8249, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(474, 'Tarakanda', 'তারাকান্দা', 62, 8250, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(475, 'Jamalpur Sadar', 'জামালপুর সদর', 63, 8251, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(476, 'Melandah', 'মেলান্দহ', 63, 8252, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(477, 'Islampur', 'ইসলামপুর', 63, 8253, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(478, 'Dewangonj', 'দেওয়ানগঞ্জ', 63, 8254, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(479, 'Sarishabari', 'সরিষাবাড়ী', 63, 8255, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(480, 'Madarganj', 'মাদারগঞ্জ', 63, 8256, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(481, 'Bokshiganj', 'বকশীগঞ্জ', 63, 8257, 1, 1, 1, '2021-02-13 16:17:02', '2021-02-13 16:17:02'),
(482, 'Barhatta', 'বারহাট্টা', 64, 8258, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(483, 'Durgapur', 'দুর্গাপুর', 64, 8259, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(484, 'Kendua', 'কেন্দুয়া', 64, 8260, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(485, 'Atpara', 'আটপাড়া', 64, 8261, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(486, 'Madan', 'মদন', 64, 8262, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(487, 'Khaliajuri', 'খালিয়াজুরী', 64, 8263, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(488, 'Kalmakanda', 'কলমাকান্দা', 64, 8264, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(489, 'Mohongonj', 'মোহনগঞ্জ', 64, 8265, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(490, 'Purbadhala', 'পূর্বধলা', 64, 8266, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(491, 'Netrokona Sadar', 'নেত্রকোণা সদর', 64, 8267, 1, 1, 1, '2021-02-13 16:17:03', '2021-02-13 16:17:03'),
(492, 'Baroiyarhat', 'বড়ইয়ারহাট', 8, 8268, 1, 1, 1, '2021-06-04 11:21:57', '2021-06-04 11:21:57'),
(493, 'Nazirhat', 'নাজিরহাট', 8, 8269, 1, 1, 1, '2021-06-04 11:23:02', '2021-06-04 11:23:02'),
(494, 'Boakhali', 'বোখালী', 8, 8270, 1, 1, 1, '2021-06-04 11:26:43', '2021-06-04 11:26:43'),
(495, 'Chengaracara', 'চেঙ্গারচারা', 6, 8271, 1, 1, 1, '2021-06-04 12:10:16', '2021-06-04 12:10:16'),
(496, ' Chowmuhani ', 'চৌমুহনী', 5, 8272, 1, 1, 1, '2021-06-04 13:00:39', '2021-06-04 13:00:39'),
(497, 'Bashurhat', 'বসুরহাট', 5, 8273, 1, 1, 1, '2021-06-04 13:12:08', '2021-06-04 13:12:08'),
(498, 'Shaistaganj ', 'শায়েস্তাগঞ্জ', 38, 8274, 1, 1, 1, '2021-06-04 16:29:34', '2021-06-04 16:29:34'),
(499, 'Mahal', 'মহল', 14, 8275, 1, 1, 1, '2021-06-04 16:52:54', '2021-06-04 16:52:54'),
(500, 'Santahar', 'সান্তাহার', 14, 8276, 1, 1, 1, '2021-06-04 16:58:30', '2021-06-04 16:58:30'),
(501, 'Talora', 'তালোড়া', 14, 8277, 1, 1, 1, '2021-06-04 17:07:26', '2021-06-04 17:07:26'),
(502, 'Ullahpara', 'উল্লাহপাড়া', 13, 8278, 1, 1, 1, '2021-06-04 17:21:01', '2021-06-04 17:21:01'),
(503, 'Kazipur ', 'কাজিপুর', 13, 8279, 1, 1, 1, '2021-06-04 17:23:19', '2021-06-04 17:23:19'),
(504, 'Belkuchi ', 'বেলকুচি', 13, 8280, 1, 1, 1, '2021-06-04 17:25:58', '2021-06-04 17:25:58'),
(505, 'Nazipur', 'Nazipur', 19, 8281, 1, 1, 1, '2021-06-04 17:34:53', '2021-06-04 17:34:53'),
(506, 'Dhaka North City Corporation', 'ঢাকা উত্তর সিটি কর্পোরেশন', 47, 8282, 1, 1, 1, '2021-10-29 18:40:02', '2021-10-29 18:40:02'),
(507, 'Dhaka South City Corporation', 'ঢাকা দক্ষিণ সিটি কর্পোরেশন', 47, 8283, 1, 1, 1, '2021-10-29 18:40:39', '2021-10-29 18:40:39'),
(508, 'Indurkani', 'ইন্দুরকানী', 32, 8284, 1, 1, 1, '2022-01-30 04:02:34', '2022-01-30 04:02:34');

-- --------------------------------------------------------

--
-- Table structure for table `master_wards`
--

CREATE TABLE `master_wards` (
  `id` bigint UNSIGNED NOT NULL,
  `type` int NOT NULL COMMENT '1=City Corpoation, 2=Pauroshoba,3=Union',
  `city_corporation_id` bigint UNSIGNED DEFAULT NULL,
  `division_id` bigint UNSIGNED DEFAULT NULL,
  `district_id` bigint UNSIGNED DEFAULT NULL,
  `upazila_id` bigint UNSIGNED DEFAULT NULL,
  `union_id` bigint UNSIGNED DEFAULT NULL,
  `pauroshoba_id` bigint UNSIGNED DEFAULT NULL,
  `municipality_id` int DEFAULT NULL,
  `ward_code` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_wards`
--

INSERT INTO `master_wards` (`id`, `type`, `city_corporation_id`, `division_id`, `district_id`, `upazila_id`, `union_id`, `pauroshoba_id`, `municipality_id`, `ward_code`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, 0, 0, 0, 0, NULL, 2222, 1, 1, 1, '2021-05-01 12:09:27', '2021-05-02 10:35:12'),
(2, 1, 3, 0, 0, 0, 0, 0, NULL, 2223, 1, 1, 1, '2021-05-01 12:13:08', '2021-05-01 12:13:08'),
(3, 2, 0, 2, 15, 134, 0, 1, NULL, 2224, 2, 2, 1, '2021-05-02 10:35:56', '2021-05-02 10:35:56'),
(4, 2, 0, 2, 19, 168, 0, 2, NULL, 2225, 2, 2, 1, '2021-05-02 10:36:31', '2021-05-02 10:36:31'),
(5, 2, 0, 2, 19, 162, 0, 3, NULL, 2226, 2, 2, 1, '2021-05-02 10:36:50', '2021-05-02 10:36:50'),
(6, 2, 0, 2, 18, 155, 0, 4, NULL, 2227, 2, 2, 1, '2021-05-02 10:37:23', '2021-05-02 10:37:23'),
(7, 1, 4, 0, 0, 0, 0, 0, NULL, 2228, 2, 2, 1, '2021-05-02 11:15:36', '2021-05-02 11:15:36'),
(8, 1, 2, 0, 0, 0, 0, 0, NULL, 2229, 1, 1, 1, '2021-05-23 12:26:31', '2021-05-23 12:26:31'),
(9, 1, 2, 0, 0, 0, 0, 0, NULL, 2230, 1, 1, 1, '2021-05-23 12:26:52', '2021-05-23 12:26:52'),
(10, 1, 5, 0, 0, 0, 0, 0, NULL, 2231, 1, 1, 1, '2021-05-23 12:34:26', '2021-05-23 12:34:26'),
(11, 2, 0, 6, 41, 317, 0, 5, NULL, 2232, 1, 1, 1, '2021-05-23 12:38:57', '2021-05-23 12:38:57'),
(12, 2, 0, 6, 41, 319, 0, 6, NULL, 2233, 1, 1, 1, '2021-05-23 12:39:25', '2021-05-23 12:39:25'),
(13, 2, 0, 6, 40, 312, 0, 7, NULL, 2234, 1, 1, 1, '2021-05-23 12:51:27', '2021-05-23 12:51:27'),
(14, 3, 0, 6, 47, 365, 3271, 0, NULL, 2235, 96, 96, 1, '2021-06-07 21:12:44', '2021-06-07 21:12:44'),
(15, 1, 5, 0, 0, 0, 0, 0, NULL, 2236, 1, 1, 1, '2021-06-12 00:51:34', '2021-06-12 00:51:34'),
(16, 1, 1, 0, 0, 0, 0, 0, NULL, 2237, 183, 183, 1, '2021-08-08 00:05:18', '2021-08-08 00:05:18'),
(17, 3, 0, 6, 47, 367, 3299, 0, NULL, 2238, 183, 183, 1, '2021-08-08 00:06:17', '2021-08-08 00:06:17'),
(18, 2, 0, 6, 43, 328, 0, 126, NULL, 2239, 1, 1, 1, '2021-09-05 21:58:49', '2021-09-05 21:58:49'),
(19, 3, 0, 2, 13, 114, 1043, 0, NULL, 2240, 1, 1, 1, '2021-09-08 21:12:52', '2021-09-08 21:12:52'),
(20, 3, 0, 1, 7, 60, 573, 0, NULL, 2241, 1, 1, 1, '2021-09-29 00:59:05', '2021-09-29 00:59:05'),
(21, 2, 0, 2, 13, 114, 0, 42, NULL, 2242, 1, 1, 1, '2021-10-20 22:56:24', '2021-10-20 22:56:24'),
(22, 1, 12, 0, 0, 0, 0, 0, NULL, 2243, 1, 1, 1, '2021-10-20 22:57:47', '2021-10-20 22:57:47'),
(23, 2, 0, 7, 54, 412, 0, 212, NULL, 2244, 1, 1, 1, '2021-10-20 23:02:53', '2021-10-20 23:02:53'),
(24, 2, 0, 6, 47, 367, 0, 320, NULL, 2245, 1, 1, 1, '2021-11-15 02:47:17', '2021-11-15 02:47:17'),
(25, 1, 1, 0, 0, 0, 0, 0, NULL, 2246, 1, 1, 1, '2021-11-15 03:33:37', '2021-11-15 03:33:37'),
(26, 1, 11, 0, 0, 0, 0, 0, NULL, 2247, 1, 1, 1, '2021-11-19 18:51:18', '2021-11-19 18:51:18'),
(27, 1, 2, 0, 0, 0, 0, 0, NULL, 2248, 1, 1, 1, '2021-11-23 00:42:32', '2021-11-23 00:42:32'),
(28, 1, 6, 0, 0, 0, 0, 0, 0, 2249, NULL, NULL, 1, '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(29, 1, 10, 0, 0, 0, 0, 0, 0, 2250, NULL, NULL, 1, '2023-01-24 04:19:21', '2023-01-24 04:19:21'),
(30, 2, 0, 7, 57, 429, 0, 0, 233, 2251, NULL, NULL, 1, '2023-01-24 04:21:10', '2023-01-24 04:21:10'),
(31, 2, 0, 6, 47, 506, 0, 0, 37, 2252, NULL, NULL, 1, '2023-02-23 07:18:52', '2023-02-23 07:18:52'),
(32, 2, 0, 6, 47, 506, 0, 0, 126, 2253, NULL, NULL, 1, '2023-02-28 07:00:19', '2023-02-28 07:00:19'),
(33, 2, 0, 6, 47, 365, 0, 0, 226, 2254, NULL, NULL, 1, '2023-02-28 07:29:13', '2023-02-28 07:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `master_ward_details`
--

CREATE TABLE `master_ward_details` (
  `id` bigint UNSIGNED NOT NULL,
  `master_ward_id` bigint UNSIGNED NOT NULL,
  `ward_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ward_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `master_ward_details`
--

INSERT INTO `master_ward_details` (`id`, `master_ward_id`, `ward_name`, `ward_name_bn`, `created_at`, `updated_at`) VALUES
(2, 2, 'Khalishpur-45', 'খালিশপুর-৪৫', '2021-05-01 12:13:08', '2021-05-01 12:13:08'),
(3, 3, '10', '10', '2021-05-02 10:35:56', '2021-05-02 10:35:56'),
(4, 4, '11', '11', '2021-05-02 10:36:31', '2021-05-02 10:36:31'),
(5, 5, '12', '12', '2021-05-02 10:36:50', '2021-05-02 10:36:50'),
(6, 6, '13', '13', '2021-05-02 10:37:23', '2021-05-02 10:37:23'),
(7, 7, '15', '15', '2021-05-02 11:15:36', '2021-05-02 11:15:36'),
(10, 10, 'Ward-1', 'Ward-1', '2021-05-23 12:34:26', '2021-05-23 12:34:26'),
(11, 11, 'Ward-1', 'Ward-1', '2021-05-23 12:38:57', '2021-05-23 12:38:57'),
(12, 12, 'Ward-1', 'Ward-1', '2021-05-23 12:39:25', '2021-05-23 12:39:25'),
(13, 13, 'Ward-1', 'Ward-1', '2021-05-23 12:51:27', '2021-05-23 12:51:27'),
(14, 14, 'Ward1', 'Ward1', '2021-06-07 21:12:44', '2021-06-07 21:12:44'),
(15, 15, 'Ward-1', 'Ward-1', '2021-06-12 00:51:34', '2021-06-12 00:51:34'),
(16, 16, '12', '12', '2021-08-08 00:05:18', '2021-08-08 00:05:18'),
(17, 17, '12', '12', '2021-08-08 00:06:17', '2021-08-08 00:06:17'),
(18, 18, 'Ward-1', 'ওয়ার্ড-১', '2021-09-05 21:58:49', '2021-09-05 21:58:49'),
(19, 19, '2', '২', '2021-09-08 21:12:52', '2021-09-08 21:12:52'),
(23, 21, 'Ward-1', 'ওয়ার্ড-১', '2021-10-20 22:56:24', '2021-10-20 22:56:24'),
(24, 22, 'Ward-1', 'ওয়ার্ড-১', '2021-10-20 22:57:47', '2021-10-20 22:57:47'),
(25, 23, 'Ward-1', 'ওয়ার্ড-১', '2021-10-20 23:02:53', '2021-10-20 23:02:53'),
(26, 24, 'Word-1', 'ওয়ার্ড-১', '2021-11-15 02:47:17', '2021-11-15 02:47:17'),
(27, 25, 'Word-2', 'ওয়ার্ড-২', '2021-11-15 03:33:37', '2021-11-15 03:33:37'),
(28, 25, 'Word-3', 'ওয়ার্ড-৩', '2021-11-15 03:33:37', '2021-11-15 03:33:37'),
(30, 1, 'Ward-3', 'ওয়ার্ড -৩', '2021-11-15 04:09:46', '2021-11-15 04:09:46'),
(31, 8, 'Ward-2', 'ওয়ার্ড-২', '2021-11-15 04:10:20', '2021-11-15 04:10:20'),
(32, 9, 'Ward-3', 'ওয়ার্ড-৩', '2021-11-15 04:10:38', '2021-11-15 04:10:38'),
(33, 26, 'Ward-1', 'ওয়ার্ড-১', '2021-11-19 18:51:18', '2021-11-19 18:51:18'),
(34, 26, 'Ward-2', 'ওয়ার্ড-২', '2021-11-19 18:51:18', '2021-11-19 18:51:18'),
(35, 27, '1', '১', '2021-11-23 00:42:32', '2021-11-23 00:42:32'),
(36, 20, 'Ward- 1', 'ওয়ার্ড- ১', '2021-11-23 00:54:26', '2021-11-23 00:54:26'),
(37, 20, '2', '২', '2021-11-23 00:54:26', '2021-11-23 00:54:26'),
(38, 20, '3', '৩', '2021-11-23 00:54:26', '2021-11-23 00:54:26'),
(39, 28, 'Ward No - 01', 'ওয়ার্ড নং - ০১', '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(40, 28, 'Ward No - 02', 'ওয়ার্ড নং - ০২', '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(41, 28, 'Ward No - 03', 'ওয়ার্ড নং - ০৩', '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(42, 28, 'Ward No - 04', 'ওয়ার্ড নং - ০৪', '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(43, 28, 'Ward No - 05', 'ওয়ার্ড নং - ০৫', '2022-12-27 11:15:13', '2022-12-27 11:15:13'),
(44, 29, 'Ward 1', 'ওয়ার্ড 1', '2023-01-24 04:19:21', '2023-01-24 04:19:21'),
(45, 29, 'Ward 2', 'ওয়ার্ড 2', '2023-01-24 04:19:21', '2023-01-24 04:19:21'),
(46, 30, 'Ward 1', 'ওয়ার্ড 1', '2023-01-24 04:21:10', '2023-01-24 04:21:10'),
(47, 30, 'Ward 2', 'ওয়ার্ড 2', '2023-01-24 04:21:10', '2023-01-24 04:21:10'),
(48, 31, 'dhamrai ward', 'dhamrai ward bn', '2023-02-23 07:18:52', '2023-02-23 07:18:52'),
(49, 32, 'test ward', 'test ward bn', '2023-02-28 07:00:19', '2023-02-28 07:00:19'),
(50, 33, 'Boda 1', 'বোদা-১', '2023-02-28 07:29:13', '2023-02-28 07:29:13');

-- --------------------------------------------------------

--
-- Table structure for table `message_template`
--

CREATE TABLE `message_template` (
  `id` bigint UNSIGNED NOT NULL,
  `template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_web_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `message_template`
--

INSERT INTO `message_template` (`id`, `template`, `mobile_text`, `email_web_text`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Send Next Template', 'Your Application has been proceed to next step', 'Your Application has been proceed to next step', 1, NULL, 2, '2022-05-31 12:49:28', '2022-06-01 06:59:28'),
(2, 'Send Next Template 1', 'Your Application has been proceed to next step 1', 'Your Application has been proceed to next step 1', NULL, NULL, 1, '2022-06-01 04:20:33', '2022-06-01 05:36:54'),
(3, 'df', 'sdf', 'sdf', NULL, NULL, 2, '2022-06-01 04:59:43', '2022-06-01 05:37:08');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2020_12_12_070410_create_master_countries_table', 1),
(6, '2020_12_12_100551_create_master_org_profiless_table', 1),
(7, '2020_12_13_045749_create_master_office_types_table', 1),
(9, '2020_12_13_052744_create_master_components_table', 1),
(10, '2020_12_13_053157_create_master_org_components_table', 1),
(11, '2020_12_13_054133_create_master_modules_table', 1),
(12, '2020_12_13_054200_create_master_org_modules_table', 1),
(13, '2020_12_15_041245_create_master_services_table', 1),
(14, '2020_12_15_041516_create_master_menus_table', 1),
(16, '2020_12_15_045735_create_assign_designations_table', 1),
(17, '2020_12_21_095046_create_master_grades_table', 1),
(18, '2020_12_27_044244_create_master_complain_types_table', 1),
(19, '2020_12_27_044649_create_master_complain_designations_table', 1),
(20, '2020_12_27_044938_create_com_complain_infos_table', 1),
(21, '2020_12_27_045959_create_master_complain_chains_table', 1),
(22, '2020_12_27_050849_create_master_notification_types_table', 1),
(23, '2020_12_27_053526_create_master_notification_settings_table', 1),
(24, '2020_12_27_054103_create_not_notification_templates_table', 1),
(25, '2020_12_27_070424_create_user_logs_table', 1),
(26, '2020_12_29_041711_create_not_circulate_notices_table', 1),
(27, '2020_12_29_052801_create_com_committees_table', 1),
(28, '2020_12_29_053444_create_com_committee_reports_table', 1),
(29, '2020_12_29_053751_create_com_approve_table', 1),
(30, '2020_12_29_053928_create_com_reject_table', 1),
(31, '2020_12_30_052721_create_master_document_categories_table', 1),
(32, '2020_12_30_053049_create_doc_doc_infos_table', 1),
(33, '2021_01_05_040919_create_master_banks_table', 1),
(34, '2021_01_05_041252_create_master_branchs_table', 1),
(35, '2021_01_06_104414_create_cmt_committees_table', 1),
(36, '2021_01_06_104530_create_cmt_agenda_table', 1),
(37, '2021_01_06_104655_create_cmt_meeting_minutes_table', 1),
(38, '2021_01_06_104955_create_cmt_committee_members_table', 1),
(39, '2021_01_06_105107_create_cmt_expenses_table', 1),
(40, '2021_01_07_052137_create_com_complain_cycle_table', 1),
(41, '2021_02_02_115532_create_master_dialog_settings_table', 1),
(42, '2021_03_02_062109_create_master_eligibility_types_table', 1),
(43, '2021_03_02_062615_create_master_contents_table', 1),
(44, '2021_03_02_062857_create_master_content_eligibility_table', 1),
(45, '2021_03_02_063150_create_master_faqs_table', 1),
(46, '2021_03_02_102422_create_master_payment_services_table', 1),
(47, '2021_03_14_065355_creat_master_fiscal_years_table', 1),
(52, '2021_09_02_101422_create_portal_footers_table', 1),
(53, '2021_09_02_101459_create_portal_headers_table', 1),
(54, '2021_09_02_101550_create_portal_service_categories_table', 1),
(55, '2021_09_02_101609_create_portal_service_customer_types_table', 1),
(60, '2021_09_13_052932_portal_news', 1),
(61, '2021_09_13_062141_portal_notice', 1),
(62, '2021_09_13_062439_portal_faq', 1),
(63, '2021_09_16_103050_create_portal_social_media_links', 1),
(66, '2021_12_05_050426_create_message_template_table', 1),
(67, '2021_12_05_100550_create_notification_settings_table', 1),
(68, '2021_12_07_121408_create_device_tokens_table', 1),
(69, '2021_12_07_125415_create_notifications_table', 1),
(70, '2021_12_12_163857_create_ministry_dashboard_menus_table', 1),
(71, '2022_06_05_114911_create_portal_ministry_entries_table', 2),
(72, '2022_06_06_113950_create_portal_ex_organizations_table', 3),
(73, '2021_09_02_101619_create_portal_services_table', 4),
(74, '2021_09_02_101633_create_portal_service_attachments_table', 4),
(75, '2021_09_02_101727_create_portal_service_fees_table', 4),
(76, '2021_09_05_092654_create_portal_service_customers_table', 4),
(77, '2021_09_22_071411_create_portal_service_org_table', 4),
(78, '2021_09_26_090540_create_portal_service_permissions_table', 4),
(80, '2022_06_16_055157_create_component_designations_table', 5),
(85, '2022_06_19_095653_create_panels_table', 6),
(86, '2022_06_19_095703_create_menus_table', 6),
(93, '2020_12_12_071542_create_master_divisions_table', 7),
(94, '2020_12_12_080027_create_master_districts_table', 7),
(95, '2020_12_12_080449_create_master_upazilas_table', 7),
(96, '2020_12_12_080819_create_master_unions_table', 7),
(97, '2021_04_11_051224_create_master_city_corporations_table', 7),
(98, '2021_04_11_051320_create_master_pauroshobas_table', 7),
(99, '2021_04_12_033836_create_master_wards_table', 7),
(100, '2021_04_12_034914_create_master_ward_details_table', 7),
(101, '2020_12_13_051151_create_master_offices_table', 8),
(102, '2020_12_15_044659_create_master_designations_table', 9),
(103, '2022_06_29_062456_create_service_eligibility_types_table', 9),
(104, '2022_12_12_064605_create_portal_abouts_table', 10);

-- --------------------------------------------------------

--
-- Table structure for table `ministry_dashboard_menus`
--

CREATE TABLE `ministry_dashboard_menus` (
  `id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sorting_order` int DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `message_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `recipient_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `sender_id` bigint UNSIGNED NOT NULL DEFAULT '0',
  `url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `read_status` tinyint NOT NULL DEFAULT '1' COMMENT '1 = unread, 2 = read',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_settings`
--

CREATE TABLE `notification_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `module_id` bigint UNSIGNED DEFAULT NULL,
  `service_id` bigint UNSIGNED DEFAULT NULL,
  `menu_id` bigint UNSIGNED DEFAULT NULL,
  `template_id` bigint UNSIGNED DEFAULT NULL,
  `button_id` bigint UNSIGNED DEFAULT NULL,
  `mobile_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_web_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `media_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Mobile, 2=Email, 3=Web',
  `recipient_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1=Sender, 2=Receiver',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_settings`
--

INSERT INTO `notification_settings` (`id`, `component_id`, `module_id`, `service_id`, `menu_id`, `template_id`, `button_id`, `mobile_text`, `email_web_text`, `media_id`, `recipient_id`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(6, 1, 1, 1, 1, 2, 3, '0181325632', 'web or email address', '[2,3,1]', '[1,2,3]', NULL, NULL, 1, '2022-06-01 04:40:06', '2022-06-01 05:00:34');

-- --------------------------------------------------------

--
-- Table structure for table `not_circulate_notices`
--

CREATE TABLE `not_circulate_notices` (
  `id` bigint UNSIGNED NOT NULL,
  `notice_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notice_title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `notice_for` int NOT NULL,
  `office_id` bigint UNSIGNED DEFAULT NULL,
  `designation_id` bigint UNSIGNED DEFAULT NULL,
  `notice_date` date NOT NULL,
  `notice_time` time DEFAULT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `notification_type_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `not_notification_templates`
--

CREATE TABLE `not_notification_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `notification_type_id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `component_id` bigint UNSIGNED NOT NULL,
  `module_id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `menu_id` bigint UNSIGNED NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portal_abouts`
--

CREATE TABLE `portal_abouts` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=active, 0=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_abouts`
--

INSERT INTO `portal_abouts` (`id`, `description`, `description_bn`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, '<p class=\"ql-align-justify\">কাঙ্ক্ষিত মানের সেবা নিশ্চিতকরণের মাধ্যমে নাগরিক প্রত্যাশা পূরণ সুশাসন প্রতিষ্টার অন্যতম শর্ত হিসেবে স্বীকৃত । নাগরিক সেবা প্রদানের লক্ষ্যে বর্তমান সরকার নানামুখী পদক্ষেপ গ্রহণ ও বাস্তবায়নে নিরলসভাবে কাজ করে যাচ্ছে। সরকারী অফিসের মাধ্যমে প্রদেয় সেবার মান কাঙ্ক্ষিত পর্যায়ে উন্নীতকরণ তথা সুশাসন প্রতিষ্টার লক্ষ্যে অন্যান্য কার্যক্রমের পাশাপাশি প্রদেয় সেবা সম্পর্কে জনগণকে অবহিতকরণ এবং সেবা কার্যক্রমে স্বচ্ছতা ও জবাবদিহিতা নিশ্চিতকরণে সরকার কর্তৃক বিভিন্ন উদ্যোগ নেয়া হয়েছে। সরকারের এ সংক্রান্ত নীতি নির্ধারণী পদক্ষেপ গ্রহণ এবং আন্তরিক প্রচেষ্টার ফলে পূর্বের যে কোন সময়ের থেকে সরকারি অফিসের সেবার মান বহুলাংশে উন্নততর হয়েছে । বর্তমানে বাংলাদেশ তৃতীয় বিশ্বের উন্নয়নশীল দেশে পরিণত হয়েছে । সচেতনতা ও জীবনমানে উন্নয়নের কারণে বেড়েছে জনগণের প্রত্যাশাও । বর্ধিত প্রত্যাশার পাশাপাশি তথ্য প্রযুক্তির উৎকর্ষ সাধনের মাধ্যমে রুপকল্প ২০৪১ এর লক্ষ্যসমূহ অর্জন ও বাস্তবায়নের প্রয়োজনে নাগরিক সেবার মান উন্নয়নকে আরও গুরুত্বপূর্ণ করে তুলেছে।</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">উপরিউক্ত&nbsp;বাস্তবতায় তথ্য প্রযুক্তির সর্বোচ্চ ব্যাবহারের মাধ্যমে জনগণের দোরগোড়ায় সেবা পৌঁছানোর লক্ষ্যে বর্তমান সরকার নাগরিক সেবাসমূহের পদ্বতি সহজিকরণের (<strong>Service Process Simplification-SPS</strong>) লক্ষ্যে বিভিন্ন কার্যক্রম গ্রহণ ও বাস্তবায়নের পদক্ষেপ নেয়া হয়েছে। এ কার্যক্রমের আওতায় বাণিজ্য মন্ত্রণালয় সেবা পদ্বতি সহজিকরণ ও সেবাসমূহকে এক জায়গায় প্রাপ্তির সুবিধার্থে&nbsp; <strong>ইন্টিগ্রেটেড ডিজিটাল সার্ভিস ডেলিভারি প্লাটফর্ম </strong>সফটওয়্যার বাস্তবায়নের লক্ষ্যে এই পোর্টাল প্রস্তুত করা হয়েছে , যার মাধ্যমে নাগরিকগণের সেবা প্রাপ্তিতে সময়, ব্যয় ও যাতায়াত হ্রাস পাবে ।</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">এই পোর্টালের মাধ্যমে বর্তমান নাগরিক সেবাসমুহকে (যা ক্রমান্বয়ে বৃদ্ধি পাবে) খাত, ধরণ, দফতর&nbsp;/সংস্থা&nbsp;অনুসারে সন্নিবেশ করা হয়েছে – যার মাধ্যমে জনগণ খুব সহজে সরকারি দফতর&nbsp;/সংস্থা হতে প্রদেয় সেবাসমুহ সম্পর্কে কার্যকর ধারণা লাভ করা সম্ভব হবে। এখানে প্রতিটি সেবার বিপরীতে প্রয়োজনীয় তথ্যাদি সন্নিবেশ করা হয়েছে। কি প্রক্রিয়ায় , কত খরচে, কার মাধ্যমে, কত সময়ে এবং কি কি প্রয়োজনীয় কাগজপত্রের মাধ্যমে সেবাসমুহ পাওয়া যাবে তা বিস্তারিতভাবে উল্লেখ করা হয়েছে। পাশাপাশি প্রতিটি সেবার সেবাপদ্বতির ধাপসমুহ বর্ণনা করা হয়েছে। ফলে সেবাপ্রত্যাশী জনগণ প্রত্যাশিত সেবার প্রতিটি ধাপ সম্পর্কে ধারণা লাভ করতে পারবেন। এই পোর্টালটির মান উন্নীতকরণ এবং সর্বাধিক সংখ্যক সেবার তথ্য প্রদানের লক্ষ্যে পর্যায়ক্রমে সকল দফতর&nbsp;/সংস্থার&nbsp;সেবাসমুহকে এখানে সংযোজন করা হবে। জনপ্রত্যাশা পুরণকল্পে এই মন্ত্রণালয়ের বিভিন্ন দপ্তরের ই-সেবাসমুহকে ভবিষ্যতে এ পোর্টালের মাধ্যমে&nbsp;প্রদান করা সম্ভব হবে।</p>', '<p class=\"ql-align-justify\">কাঙ্ক্ষিত মানের সেবা নিশ্চিতকরণের মাধ্যমে নাগরিক প্রত্যাশা পূরণ সুশাসন প্রতিষ্টার অন্যতম শর্ত হিসেবে স্বীকৃত । নাগরিক সেবা প্রদানের লক্ষ্যে বর্তমান সরকার নানামুখী পদক্ষেপ গ্রহণ ও বাস্তবায়নে নিরলসভাবে কাজ করে যাচ্ছে। সরকারী অফিসের মাধ্যমে প্রদেয় সেবার মান কাঙ্ক্ষিত পর্যায়ে উন্নীতকরণ তথা সুশাসন প্রতিষ্টার লক্ষ্যে অন্যান্য কার্যক্রমের পাশাপাশি প্রদেয় সেবা সম্পর্কে জনগণকে অবহিতকরণ এবং সেবা কার্যক্রমে স্বচ্ছতা ও জবাবদিহিতা নিশ্চিতকরণে সরকার কর্তৃক বিভিন্ন উদ্যোগ নেয়া হয়েছে। সরকারের এ সংক্রান্ত নীতি নির্ধারণী পদক্ষেপ গ্রহণ এবং আন্তরিক প্রচেষ্টার ফলে পূর্বের যে কোন সময়ের থেকে সরকারি অফিসের সেবার মান বহুলাংশে উন্নততর হয়েছে । বর্তমানে বাংলাদেশ তৃতীয় বিশ্বের উন্নয়নশীল দেশে পরিণত হয়েছে । সচেতনতা ও জীবনমানে উন্নয়নের কারণে বেড়েছে জনগণের প্রত্যাশাও । বর্ধিত প্রত্যাশার পাশাপাশি তথ্য প্রযুক্তির উৎকর্ষ সাধনের মাধ্যমে রুপকল্প ২০৪১ এর লক্ষ্যসমূহ অর্জন ও বাস্তবায়নের প্রয়োজনে নাগরিক সেবার মান উন্নয়নকে আরও গুরুত্বপূর্ণ করে তুলেছে।</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">উপরিউক্ত&nbsp;বাস্তবতায় তথ্য প্রযুক্তির সর্বোচ্চ ব্যাবহারের মাধ্যমে জনগণের দোরগোড়ায় সেবা পৌঁছানোর লক্ষ্যে বর্তমান সরকার নাগরিক সেবাসমূহের পদ্বতি সহজিকরণের (<strong>Service Process Simplification-SPS</strong>) লক্ষ্যে বিভিন্ন কার্যক্রম গ্রহণ ও বাস্তবায়নের পদক্ষেপ নেয়া হয়েছে। এ কার্যক্রমের আওতায় বাণিজ্য মন্ত্রণালয় সেবা পদ্বতি সহজিকরণ ও সেবাসমূহকে এক জায়গায় প্রাপ্তির সুবিধার্থে <strong>ইন্টিগ্রেটেড ডিজিটাল সার্ভিস ডেলিভারি প্লাটফর্ম&nbsp;</strong>সফটওয়্যার বাস্তবায়নের লক্ষ্যে এই পোর্টাল প্রস্তুত করা হয়েছে , যার মাধ্যমে নাগরিকগণের সেবা প্রাপ্তিতে সময়, ব্যয় ও যাতায়াত হ্রাস পাবে ।</p><p class=\"ql-align-justify\"><br></p><p class=\"ql-align-justify\">এই পোর্টালের মাধ্যমে বর্তমান নাগরিক সেবাসমুহকে (যা ক্রমান্বয়ে বৃদ্ধি পাবে) খাত, ধরণ, দফতর&nbsp;/সংস্থা&nbsp;অনুসারে সন্নিবেশ করা হয়েছে – যার মাধ্যমে জনগণ খুব সহজে সরকারি দফতর&nbsp;/সংস্থা হতে প্রদেয় সেবাসমুহ সম্পর্কে কার্যকর ধারণা লাভ করা সম্ভব হবে। এখানে প্রতিটি সেবার বিপরীতে প্রয়োজনীয় তথ্যাদি সন্নিবেশ করা হয়েছে। কি প্রক্রিয়ায় , কত খরচে, কার মাধ্যমে, কত সময়ে এবং কি কি প্রয়োজনীয় কাগজপত্রের মাধ্যমে সেবাসমুহ পাওয়া যাবে তা বিস্তারিতভাবে উল্লেখ করা হয়েছে। পাশাপাশি প্রতিটি সেবার সেবাপদ্বতির ধাপসমুহ বর্ণনা করা হয়েছে। ফলে সেবাপ্রত্যাশী জনগণ প্রত্যাশিত সেবার প্রতিটি ধাপ সম্পর্কে ধারণা লাভ করতে পারবেন। এই পোর্টালটির মান উন্নীতকরণ এবং সর্বাধিক সংখ্যক সেবার তথ্য প্রদানের লক্ষ্যে পর্যায়ক্রমে সকল দফতর&nbsp;/সংস্থার&nbsp;সেবাসমুহকে এখানে সংযোজন করা হবে। জনপ্রত্যাশা পুরণকল্পে এই মন্ত্রণালয়ের বিভিন্ন দপ্তরের ই-সেবাসমুহকে ভবিষ্যতে এ পোর্টালের মাধ্যমে&nbsp;প্রদান করা সম্ভব হবে।</p>', 1, 1, 1, '2023-01-01 10:01:25', '2023-01-01 10:03:14');

-- --------------------------------------------------------

--
-- Table structure for table `portal_ex_organizations`
--

CREATE TABLE `portal_ex_organizations` (
  `id` bigint UNSIGNED NOT NULL,
  `ministry_id` bigint UNSIGNED NOT NULL,
  `ex_org_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ex_org_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_ex_organizations`
--

INSERT INTO `portal_ex_organizations` (`id`, `ministry_id`, `ex_org_name`, `ex_org_name_bn`, `logo`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 6, 'new org en', 'new org bn', '/portal/ex_org-logo/7402741655122419.png', NULL, NULL, 1, '2022-06-06 10:26:55', '2022-06-13 10:13:40'),
(2, 6, 'sss', 'ddd', '/portal/ex_org-logo/6096201655122375.png', NULL, NULL, 1, '2022-06-06 10:40:43', '2022-06-13 10:14:22');

-- --------------------------------------------------------

--
-- Table structure for table `portal_faqs`
--

CREATE TABLE `portal_faqs` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_faqs`
--

INSERT INTO `portal_faqs` (`id`, `title`, `title_bn`, `description`, `description_bn`, `user_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Export Trophy and CIP', 'রপ্তানি ট্রফি এবং সিআইপি', 'In order to control the price of some essential commodities like sugar, lentil, soybean oil, gram and dates etc., TCB sells and supplies them at affordable prices to the general consumers. The products are sold through dealers in designated shops and mobile trucks for various emergencies including Holy Ramadan, Eid-ul-Fitr, Eid-ul-Azha and Puja Parban. All these sales and distribution activities of TCB are done through dealers. So appointing the right dealer is very important for TCB. At the time of appointing a dealer, the applicant should attach the following documents along with the application as per the sample authority.', 'চিনি, মসুর ডাল, সয়াবিন তেল, ছোলা এবং খেজুর ইত্যাদির মতো কিছু নিত্যপ্রয়োজনীয় পণ্যের দাম নিয়ন্ত্রণের জন্য টিসিবি সাধারণ ভোক্তাদের কাছে সাশ্রয়ী মূল্যে বিক্রি করে এবং সরবরাহ করে। পবিত্র রমজান, ঈদ-উল-ফিতর, ঈদ-উল-আযহা এবং পূজা পার্বণ সহ বিভিন্ন জরুরী পরিস্থিতিতে নির্ধারিত দোকানে এবং মোবাইল ট্রাকে পণ্যগুলি ডিলারের মাধ্যমে বিক্রি করা হয়। টিসিবির এসব বিক্রয় ও বিতরণ কার্যক্রম ডিলারদের মাধ্যমে সম্পন্ন হয়। তাই সঠিক ডিলার নিয়োগ টিসিবির জন্য খুবই গুরুত্বপূর্ণ। একজন ডিলার নিয়োগের সময়, আবেদনকারীকে নমুনা কর্তৃপক্ষ অনুসারে আবেদনের সাথে নিম্নলিখিত নথি সংযুক্ত করতে হবে।', 1, 1, '2022-06-08 09:20:55', '2022-10-14 01:10:34'),
(2, 'Fair calendar', 'ফেয়ার ক্যালেন্ডার', 'Hrough the trade fair management system component, at the beginning of the financial year, proposals for fairs of different countries are collected, fair calendars are prepared, and the participation of interested exhibitors in various international fairs is arranged under the fair calendar. A letter of recommendation is prepared for obtaining a visa to facilitate participation in the fair. Also publishing circulars for participation in Dhaka International Trade Fair, accepting applications and overall organizing the fair.', 'ট্রেড ফেয়ার ম্যানেজমেন্ট সিস্টেম কম্পোনেন্টের মাধ্যমে, আর্থিক বছরের শুরুতে, বিভিন্ন দেশের মেলার প্রস্তাবনা সংগ্রহ করা হয়, মেলা ক্যালেন্ডার তৈরি করা হয় এবং বিভিন্ন আন্তর্জাতিক মেলায় আগ্রহী প্রদর্শকদের অংশগ্রহণ মেলা ক্যালেন্ডারের অধীনে সাজানো হয়। মেলায় অংশগ্রহণের সুবিধার্থে ভিসা পাওয়ার জন্য সুপারিশের একটি চিঠি প্রস্তুত করা হয়। এছাড়াও ঢাকা আন্তর্জাতিক বাণিজ্য মেলায় অংশগ্রহণের জন্য সার্কুলার প্রকাশ করা, আবেদন গ্রহণ করা এবং মেলার সার্বিক আয়োজন করা।', 1, 1, '2022-06-08 09:21:24', '2022-10-04 08:37:59'),
(3, 'Ministry of Commerce', 'বাণিজ্য মন্ত্রণালয়', 'The main responsibility for the expansion of the country\'s industrial sector and the formulation of up-to-date policies and strategies rests primarily with the Ministry of Industries. The private sector is the main driving force in the country\'s industrialization.', ' দেশের শিল্প খাতের সম্প্রসারণ এবং যুগোপযোগী নীতিমালা এবং কৌশল নির্ধারণের মূল দায়িত্ব প্রধানতঃ শিল্প মন্ত্রণালয়ের ওপর ন্যাস্ত। দেশের শিল্পায়নে বেসরকারি খাত হচ্ছে মূল চালিকা শক্তি।', 1, 1, '2022-06-08 09:25:21', '2022-10-14 01:11:00'),
(4, 'TCB Dealership License Application (New/Renew)', 'টিসিবি ডিলারশিপ লাইসেন্সের আবেদন (নতুন/নবায়ন)', 'In order to control the price of some essential commodities like sugar, lentil, soybean oil, gram and dates etc., TCB sells and supplies them at affordable prices to the general consumers. The products are sold through dealers in designated shops and mobile trucks for various emergencies including Holy Ramadan, Eid-ul-Fitr, Eid-ul-Azha and Puja Parban. All these sales and distribution activities of TCB are done through dealers. So appointing the right dealer is very important for TCB. At the time of appointing a dealer, the applicant should attach the following documents along with the application as per the sample authority.', 'চিনি, মসুর ডাল, সয়াবিন তেল, ছোলা এবং খেজুর ইত্যাদির মতো কিছু নিত্যপ্রয়োজনীয় পণ্যের দাম নিয়ন্ত্রণের জন্য টিসিবি সাধারণ ভোক্তাদের কাছে সাশ্রয়ী মূল্যে বিক্রি করে এবং সরবরাহ করে। পবিত্র রমজান, ঈদ-উল-ফিতর, ঈদ-উল-আযহা এবং পূজা পার্বণ সহ বিভিন্ন জরুরী পরিস্থিতিতে নির্ধারিত দোকানে এবং মোবাইল ট্রাকে পণ্যগুলি ডিলারের মাধ্যমে বিক্রি করা হয়। টিসিবির এসব বিক্রয় ও বিতরণ কার্যক্রম ডিলারদের মাধ্যমে সম্পন্ন হয়। তাই সঠিক ডিলার নিয়োগ টিসিবির জন্য খুবই গুরুত্বপূর্ণ। একজন ডিলার নিয়োগের সময়, আবেদনকারীকে নমুনা কর্তৃপক্ষ অনুসারে আবেদনের সাথে নিম্নলিখিত নথি সংযুক্ত করতে হবে।', 1, 1, '2022-10-10 09:15:55', '2022-10-14 01:10:00');

-- --------------------------------------------------------

--
-- Table structure for table `portal_footers`
--

CREATE TABLE `portal_footers` (
  `id` bigint UNSIGNED NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `portal_headers`
--

CREATE TABLE `portal_headers` (
  `id` bigint UNSIGNED NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `helpline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_headers`
--

INSERT INTO `portal_headers` (`id`, `logo`, `title`, `title_bn`, `description`, `description_bn`, `helpline`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, '/portal/header/6836651662609155.png', 'Ministry of Commerce Service Portal', 'বাণিজ্য মন্ত্রণালয় সেবা পোর্টাল', 'All Commerce Services in One Address', 'সকল বাণিজ্য সেবা এক ঠিকানায়', '01711378181', NULL, NULL, 1, '2022-06-15 08:50:10', '2022-11-09 05:41:18');

-- --------------------------------------------------------

--
-- Table structure for table `portal_ministry_entries`
--

CREATE TABLE `portal_ministry_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `ministry_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ministry_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_ministry_entries`
--

INSERT INTO `portal_ministry_entries` (`id`, `ministry_name`, `ministry_name_bn`, `logo`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'dd dfa ', 'fdfd dd', '/portal/ministry-logo/2935701665390141.jpeg', NULL, NULL, 1, '2022-06-05 10:25:26', '2022-10-10 06:22:21'),
(5, 'new en', 'new bn fd', '/portal/ministry-logo/8622161655121767.png', NULL, NULL, 2, '2022-06-06 05:10:33', '2022-06-13 10:02:48'),
(6, 'Ministry of Commerce', 'বাণিজ্য মন্ত্রণালয়', '/portal/ministry-logo/9218291655121700.png', NULL, NULL, 1, '2022-06-06 07:37:53', '2022-06-13 10:01:40'),
(7, 'app', 'app bn', '/portal/ministry-logo/6260591655121881.jpeg', NULL, NULL, 1, '2022-06-12 04:43:14', '2022-06-13 10:04:41');

-- --------------------------------------------------------

--
-- Table structure for table `portal_news`
--

CREATE TABLE `portal_news` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` bigint NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_news`
--

INSERT INTO `portal_news` (`id`, `title`, `title_bn`, `description`, `description_bn`, `status`, `logo`, `user_id`, `created_at`, `updated_at`) VALUES
(32, 'Official recruitment circular for the post of Commercial Counselor and First Secretary at Commercial Wing of Bangladesh Embassy', 'বাংলাদেশ দূতাবাসের বাণিজ্যিক উইং এ কমার্শিয়াল কাউন্সেলর এবং প্রথম সচিব পদে কর্মকর্তা নিয়োগ বিজ্ঞপ্তি', 'Official recruitment circular for the post of Commercial Counselor and First Secretary at Commercial Wing of Bangladesh Embassy', 'বাংলাদেশ দূতাবাসের বাণিজ্যিক উইং এ কমার্শিয়াল কাউন্সেলর এবং প্রথম সচিব পদে কর্মকর্তা নিয়োগ বিজ্ঞপ্তি', 1, '/news/3978201669120200.png', 1, '2022-06-16 04:59:23', '2022-11-22 06:30:01'),
(33, 'Bangladesh Trade & Investment Summit 2021', 'বাংলাদেশ ট্রেড অ্যান্ড ইনভেস্টমেন্ট সামিট ২০২১', 'Bangladesh Trade & Investment Summit 2021', 'বাংলাদেশ ট্রেড অ্যান্ড ইনভেস্টমেন্ট সামিট ২০২১', 1, '/news/3029521669120192.jpeg', 1, '2022-06-16 05:05:20', '2022-11-22 06:29:52'),
(34, 'Official recruitment circular for the post of Commercial Counselor and First Secretary at Commercial Wing of Bangladesh Embassy', 'বাংলাদেশ দূতাবাসের বাণিজ্যিক উইং এ কমার্শিয়াল কাউন্সেলর এবং প্রথম সচিব পদে কর্মকর্তা নিয়োগ বিজ্ঞপ্তি', 'Official recruitment circular for the post of Commercial Counselor and First Secretary at Commercial Wing of Bangladesh Embassy', 'বাংলাদেশ দূতাবাসের বাণিজ্যিক উইং এ কমার্শিয়াল কাউন্সেলর এবং প্রথম সচিব পদে কর্মকর্তা নিয়োগ বিজ্ঞপ্তি', 1, '/news/9595921669120157.png', 1, '2022-10-04 08:13:48', '2022-11-22 06:29:17'),
(35, 'The Framework Agreement on Facilitation of Cross-border Paperless Trade in Asia and the Pacific” enters into force on 20 Feb 2021', 'এশিয়া ও প্রশান্ত মহাসাগরীয় অঞ্চলে ক্রস-বর্ডার পেপারলেস ট্রেডের সুবিধার উপর ফ্রেমওয়ার্ক চুক্তি” ২০ ফেব্রুয়ারি ২০২১ এ কার্যকর হয়', 'The Framework Agreement on Facilitation of Cross-border Paperless Trade in Asia and the Pacific” enters into force on 20 Feb 2021', 'এশিয়া ও প্রশান্ত মহাসাগরীয় অঞ্চলে ক্রস-বর্ডার পেপারলেস ট্রেডের সুবিধার উপর ফ্রেমওয়ার্ক চুক্তি” ২০ ফেব্রুয়ারি ২০২১ এ কার্যকর হয়', 1, '/news/3761531669120116.jpeg', 1, '2022-10-10 09:28:54', '2022-11-22 06:28:36'),
(36, 'The Framework Agreement on Facilitation of Cross-border Paperless Trade in Asia and the Pacific” enters into force on 20 Feb 2021', 'এশিয়া ও প্রশান্ত মহাসাগরীয় অঞ্চলে ক্রস-বর্ডার পেপারলেস ট্রেডের সুবিধার উপর ফ্রেমওয়ার্ক চুক্তি” ২০ ফেব্রুয়ারি ২০২১ এ কার্যকর হয়', 'The Framework Agreement on Facilitation of Cross-border Paperless Trade in Asia and the Pacific” enters into force on 20 Feb 2021', 'এশিয়া ও প্রশান্ত মহাসাগরীয় অঞ্চলে ক্রস-বর্ডার পেপারলেস ট্রেডের সুবিধার উপর ফ্রেমওয়ার্ক চুক্তি” ২০ ফেব্রুয়ারি ২০২১ এ কার্যকর হয়', 1, '/news/9459921669120089.jpeg', 1, '2022-10-10 09:30:07', '2022-11-22 06:28:10'),
(37, 'Bangladesh Trade & Investment Summit 2021', 'বাংলাদেশ ট্রেড অ্যান্ড ইনভেস্টমেন্ট সামিট ২০২১', 'Bangladesh Trade & Investment Summit 2021', 'বাংলাদেশ ট্রেড অ্যান্ড ইনভেস্টমেন্ট সামিট ২০২১', 1, '/news/2667161669120020.jpeg', 1, '2022-10-10 09:34:09', '2022-11-22 06:27:00');

-- --------------------------------------------------------

--
-- Table structure for table `portal_notices`
--

CREATE TABLE `portal_notices` (
  `id` bigint UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` bigint NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_notices`
--

INSERT INTO `portal_notices` (`id`, `title`, `title_bn`, `description`, `description_bn`, `user_id`, `created_at`, `attachment`, `updated_at`, `status`) VALUES
(1, 'License issue in favor of Election Monitoring Forum', 'লাইসেন্স ইস্যু ইলেকশন মনিটরিং ফোরাম এর অনুকূলে', 'In view of the above matters and the originating application, the exporting company (1) M/s Ripa Enterprises (2) Tiger Trading\n(3) ARPITA TRADE INTERNATIONAL (4) Capital Export Import & Co. (5) Arif Sea Foods\n(6) M/S. Durga Puja to SAZZAD ENTERPRISE (7) POPULAR TRADE SYNDICATE (8) Unique Consortium Ltd.\nOn this occasion, the validity of the permit for the export of hilsa fish to India is 05 October 2022, keeping the previous conditions unchanged.\nThe range is increased according to the instructions.', 'উপর্যুক্তর্যু বিষয় ও সূত্রোস্থ আবেদনের পরিপ্রেক্ষিতে রপ্তানিকারক প্রতিষ্ঠান (১) মেসার্স রিপা এন্টারপ্রাইজ (২) টাইগার ট্রেডিং\n(৩) ARPITA TRADE INTERNATIONAL (৪) Capital Export Import & Co. (৫) Arif Sea Foods\n(৬) M/S. SAZZAD ENTERPRISE  (৭) পপুলার ট্রেড সিন্ডিকেট (৮) ইউনিক কনসোর্টিয়ার্টি ম লিমিটেড-কে দূর্গা পূজা\nউপলক্ষ্যে ভা রতে ইলিশ মাছ রপ্তানির অনুমতিপত্রের মেয়াদ পূর্বের র্বে শর্তসর্ত মূহ অপরিবর্তিত র্তি রেখে আগামী ০৫ অক্টোবর ২০২২ তারিখ\nপর্যন্তর্য নির্দেশর্দেক্রমে বর্ধিত কর্ধি রা হলো।', 1, '2022-06-13 10:02:44', 'storage/PortalNotice/62a727648be22.pdf', '2022-11-23 02:43:57', 1),
(2, 'Extension of Hilsa fish export permit to India on the occasion of upcoming Durga Puja', 'আসন্ন দুর্গাপুজা উপলক্ষ্যে ভারতে ইলিশ মাছ রপ্তানির অনুমতিপত্রের মেয়াদ বৃদ্ধিকরণ', 'In view of the above matters and the originating application, the exporting company (1) M/s Ripa Enterprises (2) Tiger Trading\n(3) ARPITA TRADE INTERNATIONAL (4) Capital Export Import & Co. (5) Arif Sea Foods\n(6) M/S. Durga Puja to SAZZAD ENTERPRISE (7) POPULAR TRADE SYNDICATE (8) Unique Consortium Ltd.\nOn this occasion, the validity of the permit for the export of hilsa fish to India is 05 October 2022, keeping the previous conditions unchanged.\nThe range is increased according to the instructions.', 'উপর্যুক্তর্যু বিষয় ও সূত্রোস্থ আবেদনের পরিপ্রেক্ষিতে রপ্তানিকারক প্রতিষ্ঠান (১) মেসার্স রিপা এন্টারপ্রাইজ (২) টাইগার ট্রেডিং\n(৩) ARPITA TRADE INTERNATIONAL (৪) Capital Export Import & Co. (৫) Arif Sea Foods\n(৬) M/S. SAZZAD ENTERPRISE  (৭) পপুলার ট্রেড সিন্ডিকেট (৮) ইউনিক কনসোর্টিয়ার্টি ম লিমিটেড-কে দূর্গা পূজা\nউপলক্ষ্যে ভা রতে ইলিশ মাছ রপ্তানির অনুমতিপত্রের মেয়াদ পূর্বের র্বে শর্তসর্ত মূহ অপরিবর্তিত র্তি রেখে আগামী ০৫ অক্টোবর ২০২২ তারিখ\nপর্যন্তর্য নির্দেশর্দেক্রমে বর্ধিত কর্ধি রা হলো।', 1, '2022-06-13 10:05:17', 'storage/PortalNotice/62a727fd3da81.pdf', '2022-11-23 02:43:34', 1),
(3, 'Bangladesh Match Manufacturers Association Dormant Organization Declaration', 'Bangladesh Match Manufacturers Association Dormant Organization Declaration', 'বাংলাদেশ ম্যাচ ম্যানুফ্যাকচারার্স এসোসিয়েশন সুপ্ত সংগঠন ঘোষণাপত্র', 'বাংলাদেশ ম্যাচ ম্যানুফ্যাকচারার্স এসোসিয়েশন সুপ্ত সংগঠন ঘোষণাপত্র', 1, '2022-06-13 10:05:41', 'storage/PortalNotice/62aad8f705b65.xls', '2022-11-23 02:42:59', 1),
(4, 'Regarding the non-increase in the hours of Mr. Md. Omar Farooq, Assistant Numerologist-cum-Computer Operator working in the Commercial Wing of the Bangladesh High Commission, Ottawa, Canada, Ministry of Commerce', 'বাণিজ্য মন্ত্রণালয়ের কানাডার অটোয়াস্থ বাংলাদেশ হাই কমিশনের বাণিজ্যিক উইংএ কর্মরত সাঁট মুদ্রাক্ষরিক কাম-কম্পিউটার অপারেটর জনাব মো: ওমর ফারুকের সময় বৃদ্ধি না করা সংক্রান্ত', 'Bangladesh High Commission, Ottawa, Canada Letter No.-19.9991.300.01.001.18.225, dated: 15 September 2022 Regarding the above matters and sources, it is kindly informed that the Commercial Wing of Bangladesh High Commission, Ottawa, Canada, Ministry of Commerce The term of appointment of Mr. Md. Omar Farooq as a computer operator in the High Commission has completed 04 years on 29 April 2022. He was directed on 10 June 2021 to make arrangements to return to the Ministry of Commerce on deputation (copy attached). Later, according to the recruitment policy of the Mission, he was transferred from his current position on May 12, 2022 and transferred to the Ministry of Commerce and to join the transferred position by July 31, 2022 (copy attached). But he did not join the ministry within the said period which is a disciplinary offence. He further complained that he did not receive the order of transfer in time which is not correct, copies/proofs of sending letters at various times are preserved in this file. He has already stayed in the Mission for 4 years and 5 months and as a letter was issued on 25th September, 2022 directing him to return to the Ministry by 15th October, 2022, it appears that it would not be appropriate to consider his application for extension of time.', 'কানাডার অটোয়াস্থ বাংলাদেশ হাইকমিশনের পত্র নং -১৯.৯৯৯১.৩০০.০১.০০১.১৮.২২৫, তা রি খ: ১৫ সে প্টে ম্বর ২০২২ উপর্যুক্তর্যু বিষয় ও সূত্রের পরিপ্রক্ষিতে সদয় অবগতির জন্য জানানো যাচ্ছে যে, বাণিজ্য মন্ত্রণালয়ের কানাডার অটোয়াস্থ বাংলাদেশ হাইকমিশনের বাণিজ্যিক উইং এ কর্মরতর্ম সাঁ ট মুদ্রাক্ষরিক কাম- কম্পিউটার অপারেটর জনাব মো: ওমর ফারুক এর হাই কমিশনে পদায়নের মেয়াদ ২৯ এপ্রিল ২০২২ তারিখে ০৪ বছর পূর্ণ হয়েছে । তাকে বদলিমূলে স্বপদে বাণিজ্য মন্ত্রণালয়ে ফেরত আসার প্রস্তুতি গ্রহণের জন্য ১০ জুন ২০২১ তারিখে নির্দেশর্দেনা দেয়া হয় (কপি সংযুক্ত)। পরবর্তীতে মিশনে নিয়োগ সংক্রান্ত নীতিমালা অনুযায়ী তাকে ১২ মে ২০২২ তারিখে বর্তমা র্ত ন কর্মস্থর্ম ল হতে প্রত্যাহারপূর্বক র্ব বাণিজ্য মন্ত্রণালয় বদলি করে ৩১ জুলাই ২০২২ তারিখের মধ্যে বদলিকৃত কর্মস্থর্ম লে যোগদানের নির্দেশর্দেনা প্রদান করা হয় (কপি সংযুক্ত)। কিন্তু তিনি উক্ত সময়ের মধ্যে অত্র মন্ত্রণালয়ে যোগদান করেননি যা শৃঙ্খলাজনিত অপরাধ। উপরন্তু বদলির আদেশ তিনি যথাসময়ে পাননি মর্মে অভিযোগ করেন যা সঠিক নয়, বিভিন্ন সময়ে পত্র প্রেরণের কপি/প্রমাণক অত্র কার্যা লয়ে সংরক্ষিত রয়েছে। তিনি ইতোমধ্যে ৪ বছর ৫ মাস মিশনে অবস্থান করেছেন এবং তাকে ১৫ অক্টোবর ২০২২ তারিখের মধ্যে মন্ত্রণালয়ে ফে রত আসার জন্য নির্দেশর্দেনা প্রদান করে ২৫ সেপ্টেম্বর, ২০২২ পত্র দেয়া হয়েছে বিধায় তার সময় বৃদ্ধির আবেদন বিবেচনা করা সমীচীন হবে না মর্মে প্রতিয়মান হয়।', 1, '2022-10-04 07:52:51', 'storage/PortalNotice/633c0273934d6.pdf', '2022-11-23 02:41:25', 1);

-- --------------------------------------------------------

--
-- Table structure for table `portal_services`
--

CREATE TABLE `portal_services` (
  `id` bigint UNSIGNED NOT NULL,
  `service_type_id` tinyint NOT NULL COMMENT '1=IDSDP, 2=API, 3=Link',
  `component_id` bigint UNSIGNED DEFAULT NULL,
  `ministry_id` bigint UNSIGNED DEFAULT NULL,
  `ex_org_id` bigint UNSIGNED DEFAULT NULL,
  `service_category_id` bigint UNSIGNED NOT NULL,
  `api_manager` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_bn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `process` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operating_procedure` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `days_of_disposal` int NOT NULL DEFAULT '0',
  `applied_service` int NOT NULL DEFAULT '0',
  `target_customer` int NOT NULL DEFAULT '0',
  `service_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `is_featured` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=yes, 0=no',
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_services`
--

INSERT INTO `portal_services` (`id`, `service_type_id`, `component_id`, `ministry_id`, `ex_org_id`, `service_category_id`, `api_manager`, `name`, `name_bn`, `description`, `description_bn`, `image`, `process`, `form_attachment`, `policy_attachment`, `operating_procedure`, `days_of_disposal`, `applied_service`, `target_customer`, `service_url`, `status`, `is_featured`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(39, 1, 9, NULL, NULL, 12, NULL, 'Invitation of Applications for Participation in International Trade Fairs held Abroad', 'বিদেশে অনুষ্ঠিত আন্তর্জাতিক বাণিজ্য মেলায় অংশগ্রহনের জন্য আবেদনপত্র আহবান', '<p>In the International Trade Fair, domestic-foreigners, government/private firms, companies/individuals who are interested in getting pavilion/stall/restaurant space allocation are published notices, applications are accepted and overall the fair is organized.</p>', '<p>আন্তর্জাতিক বাণিজ্য মেলায় প্যাভিলিয়ন/স্টল/রেষ্টুরেন্ট স্পেস বরাদ্দ এর জন্য আগ্রহী দেশি- বিদেশি, সরকারী/বেসরকারী ফার্ম, কোম্পানি/বাক্তি বর্গের মেলায় অংশগ্রহনের জন্য বিজ্ঞপ্তি প্রকাশ  হয় এবং আবেদন গ্রহন করা হয়ে থাকে।</p>', '/portal/service/3177531669126676.jpeg', '/portal/service/2759671662035500.png', NULL, NULL, NULL, 30, 0, 0, '/portal/itf-participation-circular', 2, '1', 1, 1, '2022-06-12 09:36:35', '2023-02-05 06:29:46'),
(40, 2, NULL, 6, 1, 2, 'storage/portal/service/62a71691e5b86.pdf', 'safasd', 'fsaf', 'saf', 'saf', '/portal/service/9737431655117457.jpeg', '', '', NULL, '', 40, 0, 400, '', 1, '1', 1, 1, '2022-06-13 04:40:12', '2022-06-13 08:50:57'),
(41, 1, 9, NULL, NULL, 12, '', 'Applications for Product Exhibition in International Trade Fairs held Abroad', 'বিদেশে অনুষ্ঠিত আন্তর্জাতিক বাণিজ্য মেলায় পন্য প্রদর্শনীর জন্য আবেদনপত্র আহবান', '<p>Under the fair calendar, arrangements are made for the participation of interested exhibitors in various international fairs and assistance is provided to these participants for exhibiting various products.</p>', '<p>মেলা ক্যালেন্ডারের অধীনে বিভিন্ন আন্তর্জাতিক মেলায় আগ্রহী প্রদর্শকদের অংশগ্রহনের ব্যবস্থা করা হয় এবং এ অংশগ্রহণকারীদের বিভিন্ন পন্য প্রদর্শনের জন্য সহায়তা প্রদান করা হয়। </p>', '/portal/service/1498801669126038.jpeg', '/portal/service/1688541662035472.png', '', NULL, '', 0, 0, 0, '/portal/itf-circular-exhibition', 2, '1', 1, 1, '2022-06-13 05:09:34', '2023-02-05 06:31:41'),
(42, 1, 9, NULL, NULL, 12, '', 'Collection of fair proposals for preparation of the international trade fair calendar at the beginning of the financial year', 'অর্থ বছরের শুরুতে আন্তর্জাতিক বাণিজ্য মেলা ক্যালেন্ডার প্রণয়নের জন্য মেলার প্রস্তাব সংগ্রহ', '<p>At the beginning of the financial year, proposals for fairs held in different countries are collected and the fair calendar is formulated.</p>', '<p>অর্থবছরের শুরুতে বিভিন্ন দেশে অনুষ্ঠিত মেলার প্রস্তাব সংগ্রহ করে মেলা ক্যালেন্ডার প্রণয়ন করা হয়। </p>', '/portal/service/3610641669126333.jpeg', '', '', NULL, '', 0, 0, 0, '/portal/itf-calendar-circular', 2, '1', 1, 1, '2022-06-13 06:07:57', '2023-01-12 06:41:20'),
(43, 3, NULL, 6, 1, 2, '', 'gggg', 'ggg', 'asdf', 'asf', '/storage/portal/service/3423021655118517.jpeg', 'storage/portal/service/62a71ab5aff92.xls', '', NULL, '', 500, 0, 100, 'common-services/portal/list', 1, '1', 1, 1, '2022-06-13 09:08:37', '2022-06-13 09:08:37'),
(44, 1, 10, NULL, NULL, 13, '', 'CIP selection and announcement', 'সিআইপি নির্বাচন ও ঘোষণা প্রদান', '<p>The Ministry of Commerce encourages Bangladeshi entrepreneurs to develop, expand and increase the nature and volume of export trade in order to enrich and consolidate the national economy. In view of that, the entrepreneurs who make a significant contribution to the growth of Bangladesh\'s exports are awarded at the appropriate state level. An automated system has been developed to modernize, simplify and integrate these incentive activities, so that Bangladeshi entrepreneurs can easily apply for these appropriate state awards and the Ministry of Commerce can easily monitor and administrative them.</p>', '<p>বাণিজ্য মন্ত্রণালয়, জাতীয় অর্থনীতিকে সমৃদ্ধ ও সুসংহত করার স্বার্থে রপ্তানি বাণিজ্যের উন্নয়ন, সম্প্রসারন এবং রপ্তানির প্রকৃতি ও পরিমান ব্যাপকতর করার লক্ষ্যে বাংলাদেশী উদ্দ্যোক্তাদেরকে উৎসাহ প্রদান করা হয়। তারই পরিপ্রেক্ষিতে বাংলাদেশের রপ্তানি বৃদ্ধিতে যে সকল উদ্দ্যোক্তা উল্লেখযোগ্য অবদান রাখে তাদেরকে যথোপযুক্ত রাষ্ট্রীয় পর্যায়ে পুরষ্কারে ভূষিত করা হয়। এই উৎসাহ প্রদান কর্মকাণ্ডকে আধুনিক, সহজতর ও সমপুযুক্ত করার জন্য অটোমেটেড সিস্টেম ডেভেলপমেন্ট করা হয়েছে, যাতে করে খুব সহজে বাংলাদেশি উদ্যোক্তাগণ এই যথোপযুক্ত রাষ্ট্রীয় পুরষ্কারের  জন্য আবেদন করতে পারে এবং বাণিজ্য মন্ত্রণালয় সহজে তা মনিটরিং ও ব্যাবস্থাপনা করতে পারে।</p>', '/portal/service/1090611669185244.jpeg', '/portal/service/6083171662035410.png', 'storage/portal/service/63a298f6c051b.pdf', 'storage/portal/service/63a298f6c47db.pdf', '', 180, 0, 800, '/export-trophy-cip-panel/circular', 1, '1', 1, 1, '2022-06-13 09:14:18', '2022-12-21 04:26:14'),
(45, 1, 6, NULL, NULL, 11, '', 'Research & Other Request Activities ', 'গবেষণা এবং অন্যান্য কার্যক্রমের অনুরোধ ', 'To set in motion the country’s foreign trade management in a professional manner by developing trade and business knowledge of the public and private sector practitioners through top quality research.', 'উচ্চমানের গবেষণার মাধ্যমে সরকারি ও বেসরকারি খাতের অনুশীলনকারীদের বাণিজ্য ও ব্যবসায়িক জ্ঞান বিকাশের মাধ্যমে পেশাদার পদ্ধতিতে দেশের বৈদেশিক বাণিজ্য ব্যবস্থাপনাকে গতিশীল করা।', '/portal/service/7762221665403563.jpeg', '', '', NULL, '', 0, 0, 0, '/bfti-panel/research-and-other-request-list', 1, '1', 1, 1, '2022-09-05 10:23:18', '2022-11-22 04:17:42'),
(46, 1, 6, NULL, NULL, 11, '', 'Policy Review Request', 'পলিসি পর্যালোচনার  অনুরোধ', '<p>To set in motion the country’s foreign trade management in a professional manner by developing trade and business knowledge of the public and private sector practitioners through top quality policy advice &amp; also providing policy support to the government and the private sector trade bodies and associations on existing and emerging trade-related issues.</p>', '<p>উচ্চ মানের পলিসি পরামর্শের মাধ্যমে সরকারি ও বেসরকারি খাতের অনুশীলনকারীদের বাণিজ্য ও ব্যবসায়িক জ্ঞান বিকাশের মাধ্যমে পেশাদার পদ্ধতিতে দেশের বৈদেশিক বাণিজ্য ব্যবস্থাপনাকে গতিশীল করা এবং বিদ্যমান এবং উদীয়মান বাণিজ্য-সম্পর্কিত বিষয়ে সরকার এবং বেসরকারী খাতের বাণিজ্য সংস্থা এবং সমিতিগুলিকে পলিসি সহায়তা প্রদান করা হয়।</p>', '/portal/service/5138761665406221.jpeg', '', 'storage/portal/service/63a2c6547d181.pdf', 'storage/portal/service/63a2c6547db7e.pdf', '', 0, 0, 0, '/bfti-panel/policy-request-entry', 1, '1', 1, 1, '2022-09-05 10:24:54', '2022-12-21 07:39:48'),
(47, 1, 4, NULL, NULL, 12, '', 'Policy Review', 'পলিসি পর্যালোচনা', 'Associations can request to Business Promotion Council for any type of policy change. Business Promotion Council reviews Policy Requests and forward to the Ministry of Commerce for approval for change policy.', 'অ্যাসোসিয়েশন যে কোনও ধরনের নীতি পরিবর্তনের জন্য বিজনেস প্রমোশন কাউন্সিল এর কাছে অনুরোধ করতে পারে। বিজনেস প্রমোশন কাউন্সিল নীতি পরিবর্তনের অনুরোধগুলি পর্যালোচনা করে এবং নীতি পরিবর্তনের অনুমোদনের জন্য বাণিজ্য মন্ত্রণালয়ের নিকট প্রেরণ করে।', '/portal/service/1444481669116190.jpeg', '', '', NULL, '', 183, 0, 88, '-', 2, '1', 1, 1, '2022-09-06 03:34:02', '2022-11-22 23:57:15'),
(48, 1, 10, NULL, NULL, 13, '', 'Selection and distribution of National Export Trophy', 'জাতীয় রপ্তানী ট্রফি নির্বাচন ও বিতরণ', '<p>The Ministry of Commerce encourages Bangladeshi exporters and entrepreneurs to develop, expand and increase the nature and volume of export trade for the sake of enriching and consolidating the national economy. In view of that, the institutes and organizations which have made a significant contribution to the growth of Bangladesh\'s exports are awarded at the appropriate state level. Automated systems have been developed to modernize, simplify and streamline these incentive activities, so that exporting firms and organizations can easily apply for these appropriate state awards and the Ministry of Commerce can easily monitor and administrative them.</p>', '<p>বাণিজ্য মন্ত্রণালয়, জাতীয় অর্থনীতিকে সমৃদ্ধ ও সুসংহত করার স্বার্থে রপ্তানি বাণিজ্যের উন্নয়ন, সম্প্রসারন এবং রপ্তানির প্রকৃতি ও পরিমান ব্যাপকতর করার লক্ষ্যে বাংলাদেশী রপ্তানিকারক প্রতিষ্ঠান ও উদ্দ্যোক্তাদেরকে উৎসাহ প্রদান করা হয়। তারই পরিপ্রেক্ষিতে বাংলাদেশের রপ্তানি বৃদ্ধিতে যে সকল প্রতিষ্ঠান এবং সংস্থা উল্লেখযোগ্য অবদান রাখে তাদেরকে যথোপযুক্ত রাষ্ট্রীয় পর্যায়ে পুরষ্কারে ভূষিত করা হয়। এই উৎসাহ প্রদান কর্মকাণ্ডকে আধুনিক, সহজতর ও সমপুযুক্ত করার জন্য অটোমেটেড সিস্টেম ডেভেলপমেন্ট করা হয়েছে, যাতে করে খুব সহজে রপ্তানিকারক প্রতিষ্ঠান এবং সংস্থা এই যথোপযুক্ত রাষ্ট্রীয় পুরষ্কারের  জন্য আবেদন করতে পারে এবং বাণিজ্য মন্ত্রণালয় সহজে তা মনিটরিং ও ব্যাবস্থাপনা করতে পারে।</p>', '/portal/service/9853861669186116.jpeg', '', 'storage/portal/service/638c592a539d6.pdf', 'storage/portal/service/63a29837425f5.pdf', '', 180, 0, 800, '/export-trophy-cip-panel/circular', 1, '1', 1, 1, '2022-09-06 03:52:25', '2022-12-21 04:23:03'),
(49, 1, 4, NULL, NULL, 12, '', 'After Proposal approval BPC funding for individual program submission', 'প্রস্তাব অনুমোদনের পরে তহবিল প্রদান এবং পৃথক প্রোগ্রামের প্রস্তাব', 'The e-business management system component consists of an organization called the Business Promotion Council. It is an organization under the Ministry of Commerce. As a council-type organization of the government, BPC provides training and contracts with associations. BPC promotes various associations of its own 7 sectors and from bottom to top of manufacturing of finished goods. It does not deal only with manufactured goods like other agencies of the Ministry of Commerce. It provides 15 different services in G2B format with citizens as the end beneficiaries. The component will cover all services with its entire life cycle to be more simple and useful for the target group. This component will promote business groups aiming to achieve targets with government funding initiatives and objectives.\nMainly associations will give proposal after getting circular. After approval of proposal, association will give individual program requests. BPC will approve those programs and after that associations will request for advance payment. In this way BPC will receive final bill request through this service and will disburse final payment.', 'ই-বিজ ম্যানেজমেন্ট সিস্টেমের কম্পোনেন্টটি বিজনেস প্রোমোশন কাউন্সিল নামে একটি সংস্থা নিয়ে গঠিত। এটি বাণিজ্য মন্ত্রণালয়ের অধীনস্থ একটি প্রতিষ্ঠান। সরকারের একটি কাউন্সিল টাইপ সংস্থা হিসাবে, বিপিসি প্রশিক্ষণ প্রদান করে এবং অ্যাসোসিয়েশনগুলির সাথে চুক্তি করে। বিপিসি তার নিজস্ব ৭টি সেক্টরের বিভিন্ন অ্যাসোসিয়েশন এবং তৈরি পণ্যের উৎপাদনের শুরু থেকে শেষ পর্যন্ত প্রোমোট করে। এটি বাণিজ্য মন্ত্রণালয়ের অন্যান্য সংস্থার মতো শুধুমাত্র তৈরি পণ্য নিয়ে কাজ করে না। এটি জি টু বি ফর্ম্যাটে ১৫টি বিভিন্ন পরিষেবা প্রদান করে যার মধ্যে শেষ পর্যন্ত সুবিধাভোগী হিসেবে নাগরিকদের অন্তর্ভুক্ত করা হয়। কম্পোনেন্টটি কাঙ্ক্ষিত ভোক্তার জন্য আরও সহজ এবং উপযোগী হবে। এই কম্পোনেন্টটি সরকারী অর্থায়নের উদ্যোগ এবং উদ্দেশ্যের সাথে লক্ষ্যমাত্রা অর্জনের লক্ষ্যে ব্যবসায়িক গোষ্ঠীগুলিকে প্রোমোট করবে।\nসার্কুলার পাওয়ার পরই মূলত অ্যাসোসিয়েশনগুলো প্রস্তাব দেবে। প্রস্তাব অনুমোদনের পর, অ্যাসোসিয়েশন পৃথক প্রোগ্রামের অনুরোধ দেবে৷ বিপিসি সেই প্রোগ্রামগুলিকে অনুমোদন করবে এবং তারপরে অ্যাসোসিয়েশনগুলি অগ্রিম অর্থপ্রদানের জন্য অনুরোধ করবে৷ এইভাবে বিপিসি এই পরিষেবার মাধ্যমে চূড়ান্ত বিলের অনুরোধ পাবে এবং চূড়ান্ত অর্থ প্রদান করবে৷', '/portal/service/6284031669115198.jpeg', '', '', NULL, '', 30, 0, 88, '-', 2, '1', 1, 1, '2022-09-06 03:55:08', '2022-11-22 23:57:04'),
(50, 1, 4, NULL, NULL, 12, '', 'Business  Promotion', 'ব্যবসায়ের প্রচার-প্রচারণা', '<p>Citizens can get sector-wise product specifications, details &amp; contact information in this service menu. With the help of this Service, anyone can get information about their desired product.</p>', '<p>নাগরিকরা এই পরিষেবা মেনুতে সেক্টরভিত্তিক পণ্যের স্পেসিফিকেশন, বিশদ বিবরণ এবং যোগাযোগের তথ্য পেতে পারেন। এই পরিষেবার সাহায্যে, যে কেউ তাদের পছন্দসই পণ্য সম্পর্কে তথ্য পেতে পারেন।</p>', NULL, '', '', NULL, '', 0, 0, 5000, '/portal/bpc-landing-page', 2, '1', 1, 1, '2022-09-06 04:04:31', '2023-02-13 09:12:34'),
(51, 1, 7, NULL, NULL, 1, '', 'TCB Dealer Recruitment Application (New/Renew)', 'টিসিবি ডিলার নিয়োগের আবেদন (নতুন/নবায়ন)', '<p>In order to control the price of some essential commodities like sugar, lentil, soybean oil, gram and dates etc., TCB sells and supplies them at affordable prices to the general consumers. The products are sold through dealers in designated shops and mobile trucks for various emergencies including Holy Ramadan, Eid-ul-Fitr, Eid-ul-Azha and Puja Parban. All these sales and distribution activities of TCB are done through dealers. So appointing the right dealer is very important for TCB. At the time of appointing a dealer, the applicant should attach the following documents along with the application as per the sample authority.\n</p>', '<p>কতিপয় নিত্যপ্রয়োজনীয় পণ্য সামগ্রী যথাঃ চিনি, মশুর ডাল , সয়াবিন তেল, ছোলা ও খেজুর ইত্যাদির মূল্য নিয়ন্ত্রণে রাখার লক্ষ্যে টিসিবি ভোক্তা সাধারণের নিকট সাশ্রয়ী মূল্যে বিক্রয় ও সরবরাহ করে থাকে। পবিত্র রমজান, ইদ-উল ফিতর, ইদ-উল আযহা ও পূজা পার্বণসহ বিভিন্ন জরুরী প্রয়োজনে ডিলারদের মাধ্যমে নির্ধারিত দোকান ও ভ্রাম্যমাণ ট্রাকে উক্ত পণ্যসমূহ বিক্রয় করা হয়। টিসিবি’র এসকল বিক্রয় ও বিতরণ কার্যক্রম ডিলারদের মাধ্যমে সম্পন্ন করা হয়ে থাকে। তাই যথাযথ ডিলার নিয়োগ করা টিসিবি’র জন্য অত্যন্ত গুরুত্বপূর্ণ ।\n</p>', '/portal/service/4195461664710577.jpeg', '', 'storage/portal/service/63abcdc7a341b.pdf', 'storage/portal/service/63abcc9b1034c.pdf', '', 80, 0, 0, '/dealer-panel/applications', 1, '1', 1, 1, '2022-09-06 04:17:58', '2022-12-28 04:01:59'),
(54, 1, 11, NULL, NULL, 3, '', 'Name Clearance', 'নামের ছাড়করণ', '<p>All institutions in Bangladesh can easily receive the services and collect the license by paying online for the registration, annual document submission after registration, and declaration of completion of the institution, which will reduce both the time and cost.</p>', '<p>বাংলাদেশের সকল প্রতিষ্ঠানের নাম এঁর ছাড়পত্র প্রদান, নিবন্ধন, নিবন্ধন পরবর্তী বাৎসরিক আবশ্যক ডকুমেন্ট সাবমিট এবং প্রতিষ্ঠানের সমাপ্তি ঘোষণা ইত্যাদি সেবা অনলাইনে অর্থ পরিশোধ করে খুব সহজেই সেবা গুলো গ্রহণ এবং লাইসেন্স সংগ্রহ করতে পারবে যা সময় এবং খরচ উভয় এরই সংক্ষেপন করবে।</p>', NULL, '', '', NULL, '', 0, 0, 0, 'http://134.119.217.113:8050/rjsc-portal/home', 1, '1', 1, 1, '2022-09-06 04:24:24', '2023-01-15 10:38:55'),
(59, 1, 8, NULL, NULL, 13, '', 'Recommending Financial Incentives', 'আর্থিক প্রণোদনা প্রদানের জন্য সুপারিশ প্রদান', 'Bangladesh Trade & Tariff Commission refers applications for financial incentives to Ministry of Commerce.', 'বাংলাদেশ বাণিজ্য ও ট্যারিফ কমিশন আবেদনকারীর আর্থিক প্রণোদনার জন্য করা আবেদনগুলো বাণিজ্য মন্ত্রণালয়ের কাছে প্রেরণ করে থাকে।', '/portal/service/2618961669112996.jpeg', '', '', NULL, '', 60, 0, 600, '-', 2, '1', 1, 1, '2022-09-08 06:12:10', '2022-11-22 22:18:33'),
(60, 1, 8, NULL, NULL, 13, '', 'Recommendation for rationalization of tariff rate in the interest of development of domestic industry', 'দেশীয় শিল্প বিকাশের স্বার্থে শুল্ক হার যৌক্তিকীকরণের সুপারিশ প্রণয়ন', 'Bangladesh Trade & Tariff Commission follows the policy of maintaining a rational tariff structure under the protection and preservation of interests of the domestic industries. The Commission generally follows the formula of imposing the lowest duty rate on primary raw materials, a relatively high but uniform duty rate on secondary goods, and a duty rate higher than that on secondary goods on all finished goods. Further, the level of support is determined by analyzing the cost of production, productivity and relevant data of the concerned industry to support the domestic industry.', 'বাংলাদেশ বাণিজ্য ও ট্যারিফ কমিশন দেশীয় শিল্পের স্বার্থ সংরক্ষণ ও সংরক্ষণের অধীনে একটি যৌক্তিক শুল্ক কাঠামো বজায় রাখার নীতি অনুসরণ করে। কমিশন সাধারণত প্রাথমিক কাঁচামালের উপর সর্বনিম্ন শুল্ক হার, মাধ্যমিক পণ্যের উপর তুলনামূলকভাবে উচ্চ কিন্তু অভিন্ন শুল্ক হার এবং সমস্ত সমাপ্ত পণ্যের উপর গৌণ পণ্যের তুলনায় উচ্চতর শুল্ক হারের সূত্র অনুসরণ করে। অধিকন্তু, দেশীয় শিল্পকে সমর্থন করার জন্য উৎপাদন খরচ, উৎপাদনশীলতা এবং সংশ্লিষ্ট শিল্পের প্রাসঙ্গিক তথ্য বিশ্লেষণ করে সহায়তার মাত্রা নির্ধারণ করা হয়।', '/portal/service/2415341669113381.jpeg', '', '', NULL, '', 120, 0, 400, '-', 2, '1', 1, 1, '2022-09-08 06:30:29', '2022-11-22 04:36:21'),
(61, 1, 8, NULL, NULL, 13, '', 'Provide support for anti-dumping duties', 'এন্টি-ডাম্পিং শুল্ক আরোপ সংক্রান্ত কার্যক্রমে সহায়তা প্রদান', 'According to the relevant agreement of the World Trade Organization (WTO), if the product produced in a country is exported to Bangladesh at a price lower than the country\'s normal price (usually the local market price), that product will be considered dumping in Bangladesh. The Commission deals with detection of dumped goods, levy of duty and collection of anti-dumping duty, and assessment of damages as per rules.', 'বিশ্ব বাণিজ্য সংস্থার (ডব্লিউটিও) প্রাসঙ্গিক চুক্তি অনুযায়ী, কোনো দেশে উৎপাদিত পণ্য দেশের স্বাভাবিক মূল্যের (সাধারণত স্থানীয় বাজার মূল্যের) চেয়ে কম মূল্যে বাংলাদেশে রপ্তানি করা হলে সেই পণ্যটি ডাম্পিং হিসেবে বিবেচিত হবে। বাংলাদেশ কমিশন ডাম্প করা পণ্য সনাক্তকরণ, শুল্ক ধার্য এবং এন্টি-ডাম্পিং শুল্ক সংগ্রহ এবং নিয়ম অনুসারে ক্ষতির মূল্যায়ন নিয়ে কাজ করে।', '/portal/service/6621711669113678.jpeg', '', '', NULL, '', 548, 0, 0, '-', 2, '1', 1, 1, '2022-09-08 07:00:45', '2022-11-22 05:00:36'),
(62, 1, 8, NULL, NULL, 13, '', 'Providing assistance in countervailing duty enforcement proceedings', 'কাউন্টারভেলিং শুল্ক আরোপ সংক্রান্ত কার্যক্রমে সহায়তা প্রদান', 'Many countries provide various types of subsidies on industrial products to promote their own industries. Which may damage the local industry if it enters the Bangladeshi market. Identifying and taxing subsidized products and levying countervailing duty and assessing interest under the Act to protect local industry from such unfair competition.', 'অনেক দেশ তাদের নিজস্ব শিল্পের প্রচারের জন্য শিল্প পণ্যের উপর বিভিন্ন ধরনের ভর্তুকি প্রদান করে। যা বাংলাদেশের বাজারে প্রবেশ করলে স্থানীয় শিল্পের ক্ষতি হতে পারে। এই ধরনের অন্যায্য প্রতিযোগিতা থেকে স্থানীয় শিল্পকে রক্ষা করার জন্য ভর্তুকিযুক্ত পণ্যগুলি চিহ্নিত করা এবং কর আরোপ করা এবং কাউন্টারভেলিং শুল্ক আরোপ এবং আইনের অধীনে সুদের মূল্যায়ন।', '/portal/service/4797931669113765.jpeg', '', '', NULL, '', 548, 0, 0, '-', 2, '1', 1, 1, '2022-09-08 07:05:29', '2022-11-22 04:42:45'),
(63, 1, 8, NULL, NULL, 13, '', 'Provide assistance in safeguard duty related activities ', 'সেইফগার্ড শুল্ক আরোপ সংক্রান্ত কার্যক্রমে সহায়তা প্রদান', 'If the volume of imports of a product increases at an unexpected rate, it may cause loss of interest or threat of loss of interest to industries producing similar products domestically. In that case, the government takes safeguard measures or imposes safeguard duty as a temporary conservation measure to protect the domestic producers from damages/losses.', 'যদি কোনো পণ্যের আমদানির পরিমাণ অপ্রত্যাশিত হারে বৃদ্ধি পায়, তাহলে তা অভ্যন্তরীণভাবে অনুরূপ পণ্য উৎপাদনকারী শিল্পের জন্য সুদের ক্ষতি বা সুদ হারানোর হুমকির কারণ হতে পারে। সেক্ষেত্রে, সরকার দেশীয় উৎপাদকদের ক্ষতি/ধ্বংস থেকে রক্ষা করার জন্য একটি অস্থায়ী সংরক্ষণ ব্যবস্থা হিসাবে সুরক্ষা ব্যবস্থা গ্রহণ করে বা সুরক্ষা শুল্ক আরোপ করে।', '/portal/service/7738801669113847.jpeg', '', '', NULL, '', 240, 0, 0, '-', 2, '1', 1, 1, '2022-09-08 07:06:29', '2022-11-22 05:12:35'),
(70, 1, 5, NULL, NULL, 2, '', 'Small Tea Garden Registration & Renewal', 'ক্ষুদ্র চা বাগান নিবন্ধন ও নবায়ন', 'Registration and renewal of small tea Garden under Bangladesh Tea Board through this service, users can apply online and receive licenses online. And after expiry, the user can renew the application online.', 'বাংলাদেশ চা বোর্ডের আওতাধীন ক্ষুদ্র চা বাগান নিবন্ধন ও নবায়ন এই সেবাটির মাধ্যমে ব্যাবহারকারী অনলাইন এর মাধ্যমে আবেদন করতে পারবেন এবং অনলাইন এর মাধ্যমে লাইসেন্স গ্রহন করতে পারবেন। এবং মেয়াদ শেষ হওয়ার পর আবার আবেদনটি আনলাইনের মাধ্যমে নবায়ন করতে পারবেন।   ', NULL, '', '', NULL, '', 0, 0, 0, '/tea-garden-panel/tea-garden-application-form', 1, '1', 1, 1, '2022-09-12 05:24:55', '2022-12-04 05:18:48'),
(71, 1, 5, NULL, NULL, 2, '', 'Tea Factory Registration & Renewal', 'চা কারখানা নিবন্ধন ও নবায়ন', 'Registration and renewal of tea factorie under Bangladesh Tea Board through this service, users can apply online and receive licenses online. And after expiry, the user can renew the application online.', 'বাংলাদেশ চা বোর্ডের আওতাধীন চা কারখানা নিবন্ধন ও নবায়ন এই সেবাটির মাধ্যমে ব্যাবহারকারী অনলাইন এর মাধ্যমে আবেদন করতে পারবেন এবং অনলাইন এর মাধ্যমে লাইসেন্স গ্রহন করতে পারবেন। এবং মেয়াদ শেষ হওয়ার পর আবার আবেদনটি আনলাইনের মাধ্যমে নবায়ন করতে পারবেন।   ', NULL, '', '', NULL, '', 0, 0, 0, '/tea-garden-panel/tea-factory-application-form', 1, '1', 1, 1, '2022-09-12 05:28:07', '2022-12-04 05:13:51'),
(73, 1, 5, NULL, NULL, 2, '', 'Small Tea Farmers Registration & Renewal', 'ক্ষুদ্র চা চাষীদের নিবন্ধন ও নবায়ন', 'Registration and renewal of small tea farmers under Bangladesh Tea Board Through this service, small tea farmers can apply online and receive licenses online. And after expiry, the user can renew the application online.', 'বাংলাদেশ চা বোর্ডের আওতাধীন ক্ষুদ্র চা চাষীদের নিবন্ধন ও নবায়ন এই সেবাটির মাধ্যমে ক্ষুদ্র চা চাষিগণ অনলাইন এর মাধ্যমে আবেদন করতে পারবেন এবং অনলাইন এর মাধ্যমে লাইসেন্স গ্রহন করতে পারবেন। এবং মেয়াদ শেষ হওয়ার পর আবার আবেদনটি আনলাইনের মাধ্যমে নবায়ন করতে পারবেন।  ', NULL, '', '', NULL, '', 0, 0, 0, '/tea-garden-panel/tea-farmer-application-form', 1, '1', 1, 1, '2022-09-12 05:36:27', '2022-12-04 05:16:22'),
(75, 1, 5, NULL, NULL, 12, '', 'Tea Seedling/Plant Supply', 'উন্নত জাতের চা চারা/বীজ সরবরাহ', 'The head office of Bangladesh Tea Research Institute (BTRI) is located in Srimangal, surrounded by the lush greenery of the state of tea. It was established on 28 February 1957. The institute has so far developed 23 clones and 5 seeds with high yield and attractive quality. If you want to supply these advanced varieties of tea seedlings/seeds, you can apply online.', 'চায়ের রাজ্যখ্যাত সবুজ শ্যামলে ঘেরা শ্রীমঙ্গলে অবস্থিত বাংলাদেশ চা গবেষণা ইনস্টিটিউট (বিটিআরআই) এর প্রধান কার্যালয়। ১৯৫৭ সালে ২৮ ফেব্রুয়ারি এটি প্রতিষ্ঠিত হয়েছে। এ ইনষ্টিটিউট এ যাবৎ উচ্চ ফলনশীল ও আকর্ষনীয় গুনগতমান সম্পন্ন ২৩ টি ক্লোন ও ৫টি বীজজাত উদ্ভাবন করেছে। এই সকল উন্নত জাতের চা চারা/বীজ সরবরাহ করতে চাইলে অনলাইন এর মাধ্যমে আবেদন করতে পারবেন । ', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:40:10', '2022-11-23 01:48:01'),
(76, 1, 5, NULL, NULL, 10, '', 'Soil Samples Test', 'মাটির নমুনা পরীক্ষা', 'Fertility refers to the amount of plant food material in the soil. The more nutrients (minerals) stored in the soil, the more fertile the soil. As time goes on the fertility of land decreases. It has been observed that cultivated land loses 30-40% of its organic matter within 20-30 years of opening. In order to determine the level of fertilizer application, the fertility of the cultivated land, and what material is stored in the land, should be known by analyzing the soil.', 'মটিতে উদ্ভিদের খাদ্য উপাদানের পরিমানের উপর উর্বরতা নিদের্শ করে। যে মাটিতে যত বেশী পরিমান খাদ্যপ্রান (খনিজ পদার্থ) মজুদ সে মাটি তত বেশী উর্বর। সময় যতই যেতে থাকে জমির উর্বরা শক্তি ততই কমতে থাকে। দেখা গেছে, উন্মুক্ত করার ২০-৩০ বছরে মধ্যেই আবাদী জমি এর ৩০-৪০% জৈব পদার্থ হারিয়ে ফেলে। সার প্রয়োগের মাত্রা নির্ধারনের জন্য আবাদী জমির উর্বরতা অর্থাৎ জমিতে কি কি উপাদান কি পরিমান মজুদ তা মাটি বিশ্লেষন করে জেনে নিতে হবে।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:41:37', '2022-11-23 02:03:04'),
(77, 1, 5, NULL, NULL, 10, '', 'Green Leaf Analysis', 'সবুজপাতা বিশ্লেষণ', 'The green leaf analysis test should be done to determine the quality of tea leaves.', 'চা পাতার গুণগত মাণ নির্নয় করার জন্যই সবুজপাতা বিশ্লেষণ পরীক্ষাটি করতে হয় ।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:42:55', '2022-11-23 02:02:49'),
(78, 1, 5, NULL, NULL, 10, '', 'Soil Worm Insect Test', 'মাটির কৃমি পোকা পরীক্ষা', 'Earthworms are tiny, microscopic thread-like organisms that live in the soil. They live on the ground. Microscopic and microscopic insects. Looks like thread or semai shape. Young roots absorb sap. As a result, gall forms in the roots. Seedlings are weakened and stunted by the attack. Leaves appear yellow and discolored. Plant growth is disrupted. Earthworm testing is required to know the extent of earthworm impact on land or soil.', 'মাটিতে বসবাসকারী অতিক্ষুদ্র, আনুবীক্ষনীক সূতা বা সেমাই আকৃতি প্রাণীকে কৃমিপোকা বলে। এরা মাটিতে বাস করে। অতিক্ষুদ্র ও আণুবীক্ষণিক পোকা। দেখতে সূতা বা সেমাই আকৃতির। কচি শিকড়ের রস শোষণ করে। ফলে শিকড়ে গিট তৈরি হয়। আক্রমনে চারা দুর্বল ও রুগ্ন হয়। পাতা হলুদ ও বিবর্ণ দেখায়। চারার বৃদ্ধি ব্যাহত হয়। জমিতে বা মাটিতে  কৃমি পোকার প্রভাব কি পরিমাণ আছে এই সম্পর্কে জানার জন্যে মাটির কৃমি পোকা পরীক্ষা করতে হয়। ', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:46:55', '2022-11-23 02:02:30'),
(79, 1, 5, NULL, NULL, 10, '', 'Chemical Fertilizer Test', 'রাসায়নিক সার পরীক্ষা', 'Chemical fertilizers should be tested to analyze and determine their quality of chemical fertilizers.', 'রাসায়নিক সারের নমুনা বিশ্লেষণ ও গুণগত মাণ নির্নয় করার জন্যই রাসায়নিক সার পরীক্ষা করতে হয়।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:48:18', '2022-11-23 02:02:14'),
(80, 1, 5, NULL, NULL, 10, '', 'Organic Compost Test', 'জৈব কম্পোস্ট পরীক্ষা', 'Organic compost should be tested to analyze and determine the quality of organic manure samples.\n', 'জৈব সারের নমুনা বিশ্লেষণ ও গুণগত মাণ নির্নয় করার জন্যই জৈব কম্পোস্ট পরীক্ষা করতে হয়।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 05:49:14', '2022-11-23 02:02:02'),
(81, 1, 5, NULL, NULL, 10, '', 'Dolomite/ Lime Test', 'ডলোমাইট / চুন পরীক্ষা', 'Limestone/dolomite test should be done to know the acidity level of the soil.', ' মাটিতে অম্লত্বের পরিমাণ কতটুকু আছে এই সম্পর্কে জানার জন্য  চুনসার/ডলোমাইট পরীক্ষা করতে হয়।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 06:24:28', '2022-11-23 02:01:50'),
(82, 1, 5, NULL, NULL, 10, '', 'Water Sample Test', 'পানির নমুনা পরীক্ষা', 'Water samples should be tested to see how much water there is in the tea garden or nursery land or soil.', 'চা বাগানে অথাবা নার্সারির জমি অথবা মাটির মধ্যে পানির পরিমান কতটুকু আছে তা দেখার জন্যে পানির নমুনা পরীক্ষা করতে হয়।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 06:25:49', '2022-11-23 02:01:37'),
(85, 1, 5, NULL, NULL, 10, '', 'Pesticide Efficacy Analysis', 'পেস্টিসাইডের কার্যকারিতা বিশ্লেষণ', 'Worms are the main pest in the garden or nursery. They live on the ground. Microscopic and microscopic insects. Looks like thread or semai shapes. Young roots absorb sap. As a result, all forms in the roots. Seedlings are weakened and stunted by the attack. Leaves appear yellow and discolored. Plant growth is disrupted. However, today the main insect in tea may become secondary again. On the other hand, a minor pest can also turn into a major pest. In order to know the correct control method for these harmful worms, it is necessary to have some familiarity with these worms, and for this, it is necessary to analyze the effectiveness of pesticides.', 'কৃমিপোকা বগান অথবা নার্সারীর প্রধানতম পেষ্ট। এরা মাটিতে বাস করে। অতিক্ষুদ্র ও আণুবীক্ষণিক পোকা। দেখতে সূতা বা সেমাই আকৃতির। কচি শিকড়ের রস শোষণ করে। ফলে শিকড়ে গিট তৈরি হয়। আক্রমনে চারা দুর্বল ও রুগ্ন হয়। পাতা হলুদ ও বিবর্ণ দেখায়। চারার বৃদ্ধি ব্যাহত হয়। তবে আজ চায়ে যে কীট মুখ্য কাল তা আবার গৌন হতে পারে। অপরদিকে কোন গৌন কীট মুখ্য কীটেও পরিনত হতে পারে। ক্ষতিকর এসব কৃমিপোকা সঠিক দমন পদ্ধতি জানতে হলে এসব কৃমিপোকা সঙ্গে কিছুটা পরিচয় থাকা প্রয়োজন এই জন্য পেস্টিসাইডের কার্যকারিতা বিশ্লেষণ করা প্রয়োজন। ', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 06:45:55', '2022-11-23 02:01:22'),
(86, 1, 5, NULL, NULL, 10, '', 'Residue Level Analysis of Pesticides', 'পেস্টিসাইডের রেসিডিউ মাত্রা বিশ্লেষণ', 'Worms are the main pest of the garden or nursery. They live on the ground. Microscopic and microscopic insects. Looks like thread or semai shape. Young roots absorb sap. As a result, gall forms in the roots. Seedlings are weakened and stunted by the attack. Leaves appear yellow and discolored. Plant growth is disrupted. However, today the main insect in tea may become secondary again. On the other hand, a minor pest can also turn into a major pest. In order to know the correct control method of these harmful worms, it is necessary to have some familiarity with these worms, for this it is necessary to analyze the residue level of pesticides.', 'কৃমিপোকা বগান অথবা নার্সারীর প্রধানতম পেষ্ট। এরা মাটিতে বাস করে। অতিক্ষুদ্র ও আণুবীক্ষণিক পোকা। দেখতে সূতা বা সেমাই আকৃতির। কচি শিকড়ের রস শোষণ করে। ফলে শিকড়ে গিট তৈরি হয়। আক্রমনে চারা দুর্বল ও রুগ্ন হয়। পাতা হলুদ ও বিবর্ণ দেখায়। চারার বৃদ্ধি ব্যাহত হয়। তবে আজ চায়ে যে কীট মুখ্য কাল তা আবার গৌন হতে পারে। অপরদিকে কোন গৌন কীট মুখ্য কীটেও পরিনত হতে পারে। ক্ষতিকর এসব কৃমিপোকা সঠিক দমন পদ্ধতি জানতে হলে এসব কৃমিপোকা সঙ্গে কিছুটা পরিচয় থাকা প্রয়োজন এই জন্য পেস্টিসাইডের রেসিডিউ মাত্রা বিশ্লেষণ করা প্রয়োজন। \n', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 06:47:06', '2022-11-23 02:01:10'),
(87, 1, 5, NULL, NULL, 10, '', 'Sample Analysis of Made Tea', 'তৈরি চায়ের স্যাম্পল বিশ্লেষণ', 'Analyzing tea samples and testing tea samples to determine quality.', 'চায়ের নমুনা বিশ্লেষণ ও গুণগত মাণ নির্নয় করার জন্যই তৈরি চায়ের স্যাম্পল বিশ্লেষণ পরীক্ষা করতে হয়।', NULL, '', '', NULL, '', 0, 0, 0, '-', 2, '1', 1, 1, '2022-09-12 06:48:12', '2022-11-23 01:52:12'),
(92, 1, 5, NULL, NULL, 12, '', 'Professional Course Management', 'প্রফেশনাল কোর্স ম্যানেজমেন্ট', '<p>Professional Course Management organized by the Project Development Unit under the Bangladesh Tea Board, users can apply online to receive this service.</p>', '<p>বাংলাদেশ চা বোর্ডের আওতাধীন প্রকল্প উন্নয়ন ইউনিট কর্তৃক আয়োজিত প্রফেশনাল কোর্স ম্যানেজমেন্ট এই সেবাটির গ্রহণ করার জন্য ব্যাবহারকারী অনলাইন এর মাধ্যমে আবেদন করতে পারবেন।</p>', NULL, '', 'storage/portal/service/63a29a2cb691c.pdf', 'storage/portal/service/63a29a2cbaca0.pdf', '', 0, 0, 0, '/tea-garden-panel/tea-farmer-application-form', 2, '1', 1, 1, '2022-09-21 02:48:43', '2023-02-15 08:19:53');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_attachments`
--

CREATE TABLE `portal_service_attachments` (
  `id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_attachments`
--

INSERT INTO `portal_service_attachments` (`id`, `service_id`, `name`, `name_bn`, `created_at`, `updated_at`) VALUES
(60, 40, 'asfd', 'safdsaf', '2022-06-13 08:53:12', '2022-06-13 08:53:12'),
(61, 40, 'ss', 'dfd', '2022-06-13 08:53:13', '2022-06-13 08:53:13'),
(66, 43, 'asf', 'asfsa', '2022-06-13 09:11:29', '2022-06-13 09:11:29'),
(555, 63, 'Products Import per annum papers', 'বার্ষিক পণ্য আমদানির পরিমানের কাগজপত্র', '2022-11-23 00:15:53', '2022-11-23 00:15:53'),
(556, 62, 'Tariff rates of both countries.', 'উভয় দেশের শুল্ক হার।', '2022-11-23 00:16:13', '2022-11-23 00:16:13'),
(557, 61, 'Tariff & Product rates of both countries.', 'উভয় দেশের শুল্ক এবং পণ্যের মূল্যের হার।', '2022-11-23 00:16:35', '2022-11-23 00:16:35'),
(561, 60, 'Tariff & Products comparative  rates of related countries.', 'সংশ্লিষ্ট দেশের শুল্ক ও পণ্যের তুলনামূলক হার।', '2022-11-23 00:17:18', '2022-11-23 00:17:18'),
(562, 59, 'Trade License', 'ট্রেড লাইসেন্স', '2022-11-23 00:18:02', '2022-11-23 00:18:02'),
(563, 59, 'TIN Certificate', 'টিআইএন সার্টিফিকেট', '2022-11-23 00:18:02', '2022-11-23 00:18:02'),
(614, 47, 'Policy Supporting Documents.', 'পলিসি সংক্রান্ত নথি।', '2022-11-23 02:13:11', '2022-11-23 02:13:11'),
(615, 49, 'Proposal related documents.', 'প্রস্তাব সংক্রান্ত নথি।', '2022-11-23 02:13:50', '2022-11-23 02:13:50'),
(737, 45, 'Research Related Document ', 'গবেষণা সম্পর্কিত ডকুমেন্ট ', '2022-11-23 22:38:33', '2022-11-23 22:38:33'),
(783, 48, 'Photograph of the applicant', 'আবেদনকারীর ছবি', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(784, 48, 'The Latest Tax Year Income Tax Certificate', 'সর্বশেষ করবর্ষের আয়কর সনদ', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(785, 48, 'VAT Certificate', 'মুল্য সংযোজন কর সমর্থনীয় সনদ', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(786, 48, 'Custom Duty Certificate', 'কাস্টম ডিউটি পরিশোধের সমর্থনীয় সনদ', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(787, 48, 'Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue', 'আয়কর/মূসক/শুল্ক খেলাপি নয় মর্মে জাতীয় রাজস্ব বোর্ড এর প্রত্যয়নপত্র', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(788, 48, 'Related Banks Non-Loan Defaulter Certificate', 'সংশ্লিষ্ট বাণিজ্যিক ব্যাংক/ব্যাংকসমূহ হতে ঋণ খেলাপী নয় প্রত্যয়নপত্র', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(789, 48, 'Certificate of Incorporation', 'ইনকর্পোরেশন সার্টিফিকেট', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(790, 48, 'Bank PRC (Last Fiscal Year)', 'ব্যাংক পিআরসি (গত অর্থবছর)', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(791, 48, 'Bank PRC (Latest Fiscal Year)', 'ব্যাংক পিআরসি (সর্বশেষ অর্থবছর)', '2022-12-21 04:23:03', '2022-12-21 04:23:03'),
(792, 44, 'Photograph of the applicant', 'আবেদনকারীর ছবি', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(793, 44, 'The Latest Tax Year Income Tax Certificate', 'সর্বশেষ করবর্ষের আয়কর সনদ', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(794, 44, 'VAT Certificate', 'মুল্য সংযোজন কর সমর্থনীয় সনদ', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(795, 44, 'Custom Duty Certificate', 'কাস্টম ডিউটি পরিশোধের সমর্থনীয় সনদ', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(796, 44, 'Income Tax/VAT/Non-Duty Defaulter Certificate certified by National Board of Revenue', 'আয়কর/মূসক/শুল্ক খেলাপি নয় মর্মে জাতীয় রাজস্ব বোর্ড এর প্রত্যয়নপত্র', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(797, 44, 'Related Banks Non-Loan Defaulter Certificate', 'সংশ্লিষ্ট বাণিজ্যিক ব্যাংক/ব্যাংকসমূহ হতে ঋণ খেলাপী নয় প্রত্যয়নপত্র', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(798, 44, 'Certificate of Incorporation', 'ইনকর্পোরেশন সার্টিফিকেট', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(799, 44, 'Bank PRC (Last Fiscal Year)', 'ব্যাংক পিআরসি (গত অর্থবছর)', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(800, 44, 'Bank PRC (Latest Fiscal Year)', 'ব্যাংক পিআরসি (সর্বশেষ অর্থবছর)', '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(801, 46, 'Policy Documents', 'পলিসি নথিপত্র ', '2022-12-21 07:39:48', '2022-12-21 07:39:48'),
(906, 51, 'Bank Solvency Certificate (Copy)', 'দুই কপি ছবি।', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(907, 51, 'Trade License (grocer)', 'ট্রেড লাইসেন্স (মুদি ব্যবসায়ী)', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(908, 51, 'Bank Solvency Certificate', 'ব্যাংক সলভেন্সী সার্টিফিকেট', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(909, 51, 'National Identity Card (NID)', 'জাতীয় পরিচয় পত্র (এনাইডি)', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(910, 51, 'Income Tax Certificate (TIN)', 'আয়কর সনদপত্র (টিন)', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(911, 51, 'Shop Rent Deed/Proof of Ownership', 'দোকান ভাড়ার দলিল/ মালিকানার প্রমানক।', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(912, 51, 'VAT Registration Certificate (if any)', 'ভ্যাট নিবন্ধন সনদপত্র (যদি থাকে)', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(913, 51, 'Citizenship certificate issued by Chairman/ Municipality/ Ward Councilor', 'চেয়ারম্যান/ পৌরসভা / ওয়ার্ড কাউন্সিলর কর্তৃক প্রদত্ত নাগরিকত্ত সনদ।', '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(965, 39, 'Applicant Photo (Passport Size)', 'আবেদনকারীর ছবি (পাসপোর্ট সাইজ)', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(966, 39, 'Trade License', 'ট্রেড লাইসেন্স', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(967, 39, 'Vat Registration Certificate', 'ভ্যাট রেজিস্ট্রেশন সার্টিফিকেট', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(968, 39, 'PRC (Issued by Bangladesh Bank).', 'বিশেষজ্ঞ নিবন্ধন প্রশংসাপত্র', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(969, 39, 'Updated tax settlement certificate', 'প্রসিড রিয়ালাইজেশন সার্টিফিকেট (পিআরসি) (বাংলাদেশ ব্যাংক কর্তৃক ইস্যু করা)', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(970, 39, 'Chamber/Trade Association member certificate', 'ট্যাক্স সেটেলমেন্ট সার্টিফিকেট', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(971, 39, 'Bank Solvency Certificate', 'চেম্বার/বাণিজ্য সমিতির সদস্যের সার্টিফিকেট', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(972, 39, 'National ID (NID)', 'ব্যাংক সলভেন্সি সার্টিফিকেট', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(973, 39, 'Signature', 'জাতীয় পরিচয়পত্র (NID)', '2023-02-05 06:29:46', '2023-02-05 06:29:46'),
(974, 41, 'Copy of Trade License', 'ট্রেড লাইসেন্সের কপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(975, 41, 'Certificate of Incorporation/ Memorandum and Article of Association', 'ইনকর্পোরেশনের প্রশংসাপত্র/স্মারকলিপি এবং অ্যাসোসিয়েশনের নিবন্ধন ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(976, 41, 'Copy of Export Registration Certificate', 'রপ্তানি নিবন্ধন প্রশংসাপত্রের অনুলিপি', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(977, 41, 'Copy of Latest Tax Return Certificate', 'সর্বশেষ ট্যাক্স রিটার্ন সার্টিফিকেটের কপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(978, 41, 'Copy of Latest VAT Registration Certificate', 'সর্বশেষ ভ্যাট নিবন্ধন প্রশংসাপত্রের অনুলিপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(979, 41, 'Copy of Registration Certificate of EPB', 'ইপিবি এর রেজিস্ট্রেশন সার্টিফিকেটের কপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(980, 41, 'Copy of Latest Proceeds Realization Certificate (PRC)', 'সর্বশেষ প্রসিড রিয়ালাইজেশন সার্টিফিকেট (PRC) এর কপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(981, 41, 'Copy of Passport (Bio-Page)', 'পাসপোর্টের কপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(982, 41, 'Two Copies of Photographs of Each Representative (Passport Size)', 'প্রত্যেক প্রতিনিধির দুই কপি ফটোগ্রাফ (পাসপোর্ট সাইজ) ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(983, 41, 'Copy of Previous VISA’s especially countries with relevance', 'পূর্ববর্তী ভিসার বিশেষ করে প্রাসঙ্গিক দেশগুলির অনুলিপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(984, 41, 'Product Images', 'পণ্যের ছবি', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(985, 41, 'Product Description', 'পণ্যের বর্ণনা ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(986, 41, 'Copies of Awarded International Certificates (Quality/ Compliance/ Others)', 'আন্তর্জাতিক প্রশংসাপত্রের অনুলিপি ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(987, 41, 'Representative Signature', 'প্রতিনিধির স্বাক্ষর ', '2023-02-05 06:31:41', '2023-02-05 06:31:41'),
(992, 50, 'Business Card', 'বিজনেস কার্ড', '2023-02-13 09:35:24', '2023-02-13 09:35:24');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_categories`
--

CREATE TABLE `portal_service_categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_categories`
--

INSERT INTO `portal_service_categories` (`id`, `name`, `name_bn`, `logo`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'License', 'লাইসেন্স', '/portal/service-category/8048031662541610.png', NULL, NULL, 1, '2022-06-05 09:39:37', '2022-09-07 07:06:50'),
(2, 'Registration', 'নিবন্ধন', '/portal/service-category/5909451662541600.png', NULL, NULL, 1, '2022-06-06 04:02:55', '2022-09-07 07:06:40'),
(3, 'Clearance', 'ছাড়পত্র', '/portal/service-category/5156331662541594.png', NULL, NULL, 1, '2022-06-16 05:51:57', '2022-09-07 07:06:34'),
(10, 'Testing', 'টেস্টিং', '/portal/service-category/1423881662541536.png', NULL, NULL, 1, '2022-09-05 07:50:37', '2022-09-07 07:05:36'),
(11, 'Research & Policy', 'গবেষণা এবং নীতিমালা', '/portal/service-category/9022281662543446.png', NULL, NULL, 1, '2022-09-05 07:50:52', '2022-11-22 23:12:27'),
(12, 'Others', 'বিবিধ', '/portal/service-category/5870841662541505.png', NULL, NULL, 1, '2022-09-05 07:51:09', '2022-09-07 07:05:05'),
(13, 'Trade & Tariff ', 'বাণিজ্য ও শুল্ক', '/portal/service-category/7807801662967756.png', NULL, NULL, 1, '2022-09-12 05:29:16', '2022-09-12 05:29:16');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_customers`
--

CREATE TABLE `portal_service_customers` (
  `id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `customer_type_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_customers`
--

INSERT INTO `portal_service_customers` (`id`, `service_id`, `customer_type_id`, `created_at`, `updated_at`) VALUES
(19, 39, 1, '2022-06-12 09:36:37', '2022-06-12 09:36:37'),
(20, 40, 1, '2022-06-13 04:40:14', '2022-06-13 04:40:14'),
(21, 41, 1, '2022-06-13 05:09:35', '2022-06-13 05:09:35'),
(22, 42, 1, '2022-06-13 06:07:58', '2022-06-13 06:07:58'),
(23, 43, 1, '2022-06-13 09:08:38', '2022-06-13 09:08:38'),
(24, 44, 1, '2022-06-13 09:14:20', '2022-06-13 09:14:20'),
(35, 50, 1, '2022-09-06 04:04:31', '2022-09-06 04:04:31'),
(36, 51, 2, '2022-09-06 04:17:58', '2022-09-06 04:17:58'),
(41, 54, 8, '2022-09-06 04:24:24', '2022-09-06 04:24:24'),
(48, 60, 5, '2022-09-08 06:30:29', '2022-09-08 06:30:29'),
(49, 61, 4, '2022-09-08 07:00:45', '2022-09-08 07:00:45'),
(50, 61, 5, '2022-09-08 07:00:45', '2022-09-08 07:00:45'),
(51, 59, 4, '2022-09-08 07:01:47', '2022-09-08 07:01:47'),
(52, 62, 5, '2022-09-08 07:05:29', '2022-09-08 07:05:29'),
(53, 62, 4, '2022-09-08 07:05:29', '2022-09-08 07:05:29'),
(54, 63, 4, '2022-09-08 07:06:29', '2022-09-08 07:06:29'),
(55, 63, 5, '2022-09-08 07:06:29', '2022-09-08 07:06:29'),
(63, 70, 8, '2022-09-12 05:24:55', '2022-09-12 05:24:55'),
(64, 71, 8, '2022-09-12 05:28:07', '2022-09-12 05:28:07'),
(68, 75, 8, '2022-09-12 05:40:10', '2022-09-12 05:40:10'),
(69, 76, 8, '2022-09-12 05:41:37', '2022-09-12 05:41:37'),
(70, 77, 8, '2022-09-12 05:42:55', '2022-09-12 05:42:55'),
(71, 78, 8, '2022-09-12 05:46:55', '2022-09-12 05:46:55'),
(72, 79, 8, '2022-09-12 05:48:18', '2022-09-12 05:48:18'),
(73, 80, 8, '2022-09-12 05:49:14', '2022-09-12 05:49:14'),
(74, 81, 8, '2022-09-12 06:24:28', '2022-09-12 06:24:28'),
(75, 82, 8, '2022-09-12 06:25:49', '2022-09-12 06:25:49'),
(78, 85, 8, '2022-09-12 06:45:55', '2022-09-12 06:45:55'),
(79, 86, 8, '2022-09-12 06:47:06', '2022-09-12 06:47:06'),
(80, 87, 8, '2022-09-12 06:48:12', '2022-09-12 06:48:12'),
(85, 92, 8, '2022-09-21 02:48:43', '2022-09-21 02:48:43'),
(90, 51, 1, '2022-10-04 08:49:08', '2022-10-04 08:49:08'),
(91, 44, 5, '2022-11-22 21:57:11', '2022-11-22 21:57:11'),
(92, 48, 1, '2022-11-22 21:59:40', '2022-11-22 21:59:40'),
(93, 48, 5, '2022-11-22 21:59:40', '2022-11-22 21:59:40'),
(96, 45, 8, '2022-11-22 23:14:47', '2022-11-22 23:14:47'),
(97, 46, 8, '2022-11-22 23:15:29', '2022-11-22 23:15:29'),
(98, 49, 7, '2022-11-22 23:57:04', '2022-11-22 23:57:04'),
(99, 47, 7, '2022-11-22 23:57:15', '2022-11-22 23:57:15'),
(100, 54, 1, '2022-11-23 00:15:03', '2022-11-23 00:15:03'),
(101, 63, 1, '2022-11-23 00:15:53', '2022-11-23 00:15:53'),
(102, 62, 1, '2022-11-23 00:16:13', '2022-11-23 00:16:13'),
(103, 61, 1, '2022-11-23 00:16:35', '2022-11-23 00:16:35'),
(104, 60, 4, '2022-11-23 00:16:49', '2022-11-23 00:16:49'),
(105, 60, 1, '2022-11-23 00:16:49', '2022-11-23 00:16:49'),
(106, 59, 5, '2022-11-23 00:17:04', '2022-11-23 00:17:04'),
(107, 59, 1, '2022-11-23 00:17:04', '2022-11-23 00:17:04'),
(109, 86, 6, '2022-11-23 01:59:37', '2022-11-23 01:59:37'),
(110, 92, 6, '2022-11-23 02:00:49', '2022-11-23 02:00:49'),
(111, 85, 6, '2022-11-23 02:01:32', '2022-11-23 02:01:32'),
(112, 82, 6, '2022-11-23 02:01:46', '2022-11-23 02:01:46'),
(113, 81, 6, '2022-11-23 02:01:56', '2022-11-23 02:01:56'),
(114, 80, 6, '2022-11-23 02:02:09', '2022-11-23 02:02:09'),
(115, 79, 6, '2022-11-23 02:02:21', '2022-11-23 02:02:21'),
(116, 78, 6, '2022-11-23 02:02:46', '2022-11-23 02:02:46'),
(117, 73, 6, '2022-11-23 02:03:31', '2022-11-23 02:03:31'),
(118, 71, 1, '2022-11-23 02:03:58', '2022-11-23 02:03:58'),
(119, 70, 1, '2022-11-23 02:04:11', '2022-11-23 02:04:11');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_customer_types`
--

CREATE TABLE `portal_service_customer_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_customer_types`
--

INSERT INTO `portal_service_customer_types` (`id`, `name`, `name_bn`, `image`, `created_by`, `updated_by`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Merchant', 'ব্যবসায়ী', '/customer-type/image/6772831662541490.png', NULL, NULL, 1, '2022-06-06 10:47:28', '2022-09-07 07:04:51'),
(2, 'Dealer', 'ডিলার', '/customer-type/image/1322611662541483.png', NULL, NULL, 1, '2022-06-13 08:31:49', '2022-09-07 07:04:43'),
(4, 'Importer', 'আমদানীকারক', '/customer-type/image/8802381662541462.png', NULL, NULL, 1, '2022-06-16 06:04:08', '2022-09-07 07:04:22'),
(5, 'Exporter', 'রপ্তানিকারক', '/customer-type/image/6715251662541453.png', NULL, NULL, 1, '2022-06-16 06:07:16', '2022-09-07 07:04:13'),
(6, 'General', 'সার্বজনীন', '/customer-type/image/7191121662541439.png', NULL, NULL, 1, '2022-09-05 07:25:52', '2022-11-23 01:59:01'),
(7, 'Association', 'সংগঠন', '/customer-type/image/7449441662541427.png', NULL, NULL, 1, '2022-09-05 07:26:39', '2022-11-22 23:53:17'),
(8, 'Others', 'বিবিধ', '/customer-type/image/3615261662541341.png', NULL, NULL, 1, '2022-09-05 07:44:10', '2022-09-07 07:02:21');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_fees`
--

CREATE TABLE `portal_service_fees` (
  `id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_bn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_fees`
--

INSERT INTO `portal_service_fees` (`id`, `service_id`, `name`, `name_bn`, `amount`, `created_at`, `updated_at`) VALUES
(71, 40, 'asfa', 'sfsafd', 10.00, '2022-06-13 08:54:30', '2022-06-13 08:54:30'),
(72, 40, 'sfds', 'fsf', 800.00, '2022-06-13 08:54:31', '2022-06-13 08:54:31'),
(86, 43, 'fasfd', 'saf', 400.00, '2022-06-13 09:11:30', '2022-06-13 09:11:30'),
(223, 44, 'sdf', 'sf', 40.00, '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(224, 44, 'eee', 'ee', 80.00, '2022-12-21 04:26:14', '2022-12-21 04:26:14'),
(290, 51, 'Application fee', 'আবেদন ফি', 5000.00, '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(291, 51, 'License fee', 'লাইসেন্স ফি', 10000.00, '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(292, 51, 'security deposit', 'জামানত', 30000.00, '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(293, 51, 'Renewal Fee', 'নবায়ন ফি', 10000.00, '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(294, 51, 'Renewal Late fee', 'নবায়ন বিলম্ব ফি', 1000.00, '2023-01-08 04:09:37', '2023-01-08 04:09:37'),
(296, 39, 'Export Registration Certificate', 'স্বাক্ষর', 400.00, '2023-02-05 06:29:46', '2023-02-05 06:29:46');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_org`
--

CREATE TABLE `portal_service_org` (
  `id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `org_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_org`
--

INSERT INTO `portal_service_org` (`id`, `service_id`, `org_id`, `created_at`, `updated_at`) VALUES
(30, 39, 2, '2022-06-12 09:36:36', '2022-06-12 09:36:36'),
(31, 41, 2, '2022-06-13 05:09:35', '2022-06-13 05:09:35'),
(32, 42, 2, '2022-06-13 06:07:58', '2022-06-13 06:07:58'),
(33, 44, 2, '2022-06-13 09:14:19', '2022-06-13 09:14:19'),
(34, 44, 1, '2022-09-01 10:30:10', '2022-09-01 10:30:10'),
(37, 45, 10, '2022-09-05 10:23:18', '2022-09-05 10:23:18'),
(39, 46, 10, '2022-09-05 10:24:54', '2022-09-05 10:24:54'),
(40, 47, 8, '2022-09-06 03:34:02', '2022-09-06 03:34:02'),
(43, 48, 2, '2022-09-06 03:52:25', '2022-09-06 03:52:25'),
(44, 48, 1, '2022-09-06 03:52:25', '2022-09-06 03:52:25'),
(45, 49, 8, '2022-09-06 03:55:08', '2022-09-06 03:55:08'),
(46, 50, 8, '2022-09-06 04:04:31', '2022-09-06 04:04:31'),
(47, 51, 7, '2022-09-06 04:17:58', '2022-09-06 04:17:58'),
(62, 51, 2, '2022-09-08 06:04:46', '2022-09-08 06:04:46'),
(65, 59, 4, '2022-09-08 06:12:10', '2022-09-08 06:12:10'),
(66, 60, 4, '2022-09-08 06:30:29', '2022-09-08 06:30:29'),
(67, 61, 4, '2022-09-08 07:00:45', '2022-09-08 07:00:45'),
(68, 62, 4, '2022-09-08 07:05:29', '2022-09-08 07:05:29'),
(69, 63, 4, '2022-09-08 07:06:29', '2022-09-08 07:06:29'),
(76, 70, 5, '2022-09-12 05:24:55', '2022-09-12 05:24:55'),
(77, 71, 5, '2022-09-12 05:28:07', '2022-09-12 05:28:07'),
(79, 73, 5, '2022-09-12 05:36:27', '2022-09-12 05:36:27'),
(81, 75, 5, '2022-09-12 05:40:10', '2022-09-12 05:40:10'),
(82, 76, 5, '2022-09-12 05:41:37', '2022-09-12 05:41:37'),
(83, 77, 5, '2022-09-12 05:42:55', '2022-09-12 05:42:55'),
(84, 78, 5, '2022-09-12 05:46:55', '2022-09-12 05:46:55'),
(85, 79, 5, '2022-09-12 05:48:18', '2022-09-12 05:48:18'),
(86, 80, 5, '2022-09-12 05:49:14', '2022-09-12 05:49:14'),
(87, 81, 5, '2022-09-12 06:24:28', '2022-09-12 06:24:28'),
(88, 82, 5, '2022-09-12 06:25:49', '2022-09-12 06:25:49'),
(91, 85, 5, '2022-09-12 06:45:55', '2022-09-12 06:45:55'),
(92, 86, 5, '2022-09-12 06:47:06', '2022-09-12 06:47:06'),
(93, 87, 5, '2022-09-12 06:48:12', '2022-09-12 06:48:12'),
(98, 92, 5, '2022-09-21 02:48:43', '2022-09-21 02:48:43'),
(103, 54, 15, '2022-11-23 03:15:18', '2022-11-23 03:15:18');

-- --------------------------------------------------------

--
-- Table structure for table `portal_service_permissions`
--

CREATE TABLE `portal_service_permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `service_id` bigint UNSIGNED NOT NULL,
  `pr_apply_btn` tinyint NOT NULL DEFAULT '1',
  `pr_attachment_form` tinyint NOT NULL DEFAULT '1',
  `pr_service_applied` tinyint NOT NULL DEFAULT '1',
  `pr_service_time` tinyint NOT NULL DEFAULT '1',
  `pr_target_customer` tinyint NOT NULL DEFAULT '1',
  `pr_fees` tinyint NOT NULL DEFAULT '1',
  `pr_service_process` tinyint NOT NULL DEFAULT '1',
  `pr_rating` tinyint NOT NULL DEFAULT '1',
  `pr_policy` tinyint NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `portal_service_permissions`
--

INSERT INTO `portal_service_permissions` (`id`, `service_id`, `pr_apply_btn`, `pr_attachment_form`, `pr_service_applied`, `pr_service_time`, `pr_target_customer`, `pr_fees`, `pr_service_process`, `pr_rating`, `pr_policy`, `created_at`, `updated_at`) VALUES
(18, 39, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-06-12 09:36:39', '2022-11-22 08:12:59'),
(19, 40, 0, 0, 1, 1, 1, 1, 0, 0, 1, '2022-06-13 04:40:15', '2022-06-13 04:40:15'),
(20, 41, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-06-13 05:09:35', '2023-01-12 06:41:32'),
(21, 42, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-06-13 06:07:59', '2023-01-12 06:41:20'),
(22, 43, 0, 0, 1, 1, 1, 1, 0, 1, 1, '2022-06-13 09:08:39', '2022-06-13 09:11:31'),
(23, 44, 1, 1, 0, 1, 0, 0, 0, 0, 1, '2022-06-13 09:14:22', '2022-12-21 04:26:14'),
(24, 45, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-05 10:23:18', '2022-10-10 09:45:22'),
(25, 46, 1, 1, 0, 0, 0, 0, 0, 0, 1, '2022-09-05 10:24:54', '2022-12-21 07:39:48'),
(26, 47, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-06 03:34:02', '2022-11-23 02:13:11'),
(27, 48, 1, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-06 03:52:25', '2022-12-05 11:05:36'),
(28, 49, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-06 03:55:08', '2022-11-23 02:13:50'),
(29, 50, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-06 04:04:31', '2022-11-22 23:25:20'),
(30, 51, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2022-09-06 04:17:58', '2023-01-08 04:09:37'),
(33, 54, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-06 04:24:24', '2023-01-15 10:34:49'),
(38, 59, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-08 06:12:10', '2022-11-23 00:18:02'),
(39, 60, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-08 06:30:29', '2022-11-23 00:17:18'),
(40, 61, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-08 07:00:45', '2022-11-22 04:41:18'),
(41, 62, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-08 07:05:29', '2022-11-22 04:42:45'),
(42, 63, 0, 0, 0, 1, 0, 0, 0, 0, 1, '2022-09-08 07:06:29', '2022-11-22 04:44:07'),
(49, 70, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:24:55', '2022-12-04 04:41:49'),
(50, 71, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:28:07', '2022-12-04 04:42:04'),
(52, 73, 1, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:36:27', '2022-12-04 04:42:19'),
(54, 75, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:40:10', '2022-09-12 05:40:10'),
(55, 76, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:41:37', '2022-09-12 05:41:37'),
(56, 77, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:42:55', '2022-09-12 05:42:55'),
(57, 78, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:46:55', '2022-09-12 05:46:55'),
(58, 79, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:48:18', '2022-09-12 05:48:18'),
(59, 80, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 05:49:14', '2022-09-12 05:49:14'),
(60, 81, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 06:24:28', '2022-09-12 06:24:28'),
(61, 82, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 06:25:49', '2022-09-12 06:25:49'),
(64, 85, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 06:45:55', '2022-09-12 06:45:55'),
(65, 86, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 06:47:06', '2022-09-12 06:47:06'),
(66, 87, 0, 0, 0, 0, 0, 0, 0, 0, 1, '2022-09-12 06:48:12', '2022-09-12 06:48:12'),
(71, 92, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2022-09-21 02:48:43', '2023-02-14 09:07:21');

-- --------------------------------------------------------

--
-- Table structure for table `portal_social_media_links`
--

CREATE TABLE `portal_social_media_links` (
  `id` bigint UNSIGNED NOT NULL,
  `facebook` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `twitter` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `pinterest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `share` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `service_eligibility_types`
--

CREATE TABLE `service_eligibility_types` (
  `id` bigint UNSIGNED NOT NULL,
  `type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name_bn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `updated_by` bigint UNSIGNED DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1' COMMENT '1=active, 2=inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logs`
--

CREATE TABLE `user_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_id` bigint UNSIGNED NOT NULL,
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `execution_type` int NOT NULL COMMENT '0=insert, 1=update,2=delete',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assign_designations`
--
ALTER TABLE `assign_designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assign_designations_org_id_foreign` (`org_id`),
  ADD KEY `assign_designations_office_type_id_foreign` (`office_type_id`),
  ADD KEY `assign_designations_office_id_foreign` (`office_id`),
  ADD KEY `assign_designations_designation_id_foreign` (`designation_id`);

--
-- Indexes for table `cmt_agenda`
--
ALTER TABLE `cmt_agenda`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cmt_agenda_org_id_foreign` (`org_id`),
  ADD KEY `cmt_agenda_cmt_committee_id_foreign` (`cmt_committee_id`),
  ADD KEY `cmt_agenda_meeting_number_index` (`meeting_number`),
  ADD KEY `cmt_agenda_memo_number_index` (`memo_number`),
  ADD KEY `cmt_agenda_memo_issue_date_index` (`memo_issue_date`),
  ADD KEY `cmt_agenda_agenda_name_index` (`agenda_name`),
  ADD KEY `cmt_agenda_agenda_name_bn_index` (`agenda_name_bn`),
  ADD KEY `cmt_agenda_meeting_date_index` (`meeting_date`);

--
-- Indexes for table `cmt_committees`
--
ALTER TABLE `cmt_committees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cmt_committees_org_id_foreign` (`org_id`),
  ADD KEY `cmt_committees_committee_name_index` (`committee_name`),
  ADD KEY `cmt_committees_committee_name_bn_index` (`committee_name_bn`),
  ADD KEY `cmt_committees_formation_date_index` (`formation_date`);

--
-- Indexes for table `cmt_committee_members`
--
ALTER TABLE `cmt_committee_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cmt_committee_members_cmt_committee_id_foreign` (`cmt_committee_id`),
  ADD KEY `cmt_committee_members_user_id_index` (`user_id`);

--
-- Indexes for table `cmt_expenses`
--
ALTER TABLE `cmt_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cmt_expenses_org_id_foreign` (`org_id`),
  ADD KEY `cmt_expenses_cmt_committee_id_foreign` (`cmt_committee_id`),
  ADD KEY `cmt_expenses_cmt_agenda_id_foreign` (`cmt_agenda_id`),
  ADD KEY `cmt_expenses_fiscal_year_index` (`fiscal_year`),
  ADD KEY `cmt_expenses_date_index` (`date`);

--
-- Indexes for table `cmt_meeting_minutes`
--
ALTER TABLE `cmt_meeting_minutes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cmt_meeting_minutes_org_id_foreign` (`org_id`),
  ADD KEY `cmt_meeting_minutes_cmt_committee_id_foreign` (`cmt_committee_id`),
  ADD KEY `cmt_meeting_minutes_cmt_agenda_id_foreign` (`cmt_agenda_id`);

--
-- Indexes for table `component_designations`
--
ALTER TABLE `component_designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `component_designations_org_id_foreign` (`org_id`),
  ADD KEY `component_designations_component_id_foreign` (`component_id`),
  ADD KEY `component_designations_designation_id_foreign` (`designation_id`);

--
-- Indexes for table `com_approve`
--
ALTER TABLE `com_approve`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_approve_complain_id_foreign` (`complain_id`);

--
-- Indexes for table `com_committees`
--
ALTER TABLE `com_committees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_committees_complain_id_foreign` (`complain_id`),
  ADD KEY `com_committees_designation_id_foreign` (`designation_id`);

--
-- Indexes for table `com_committee_reports`
--
ALTER TABLE `com_committee_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_committee_reports_complain_id_foreign` (`complain_id`);

--
-- Indexes for table `com_complain_cycle`
--
ALTER TABLE `com_complain_cycle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_complain_cycle_complain_id_foreign` (`complain_id`),
  ADD KEY `com_complain_cycle_sender_id_index` (`sender_id`),
  ADD KEY `com_complain_cycle_receiver_id_index` (`receiver_id`);

--
-- Indexes for table `com_complain_infos`
--
ALTER TABLE `com_complain_infos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_complain_infos_org_id_foreign` (`org_id`),
  ADD KEY `com_complain_infos_component_id_foreign` (`component_id`),
  ADD KEY `com_complain_infos_module_id_foreign` (`module_id`),
  ADD KEY `com_complain_infos_division_id_foreign` (`division_id`),
  ADD KEY `com_complain_infos_district_id_foreign` (`district_id`),
  ADD KEY `com_complain_infos_upazila_id_foreign` (`upazila_id`),
  ADD KEY `com_complain_infos_union_id_foreign` (`union_id`),
  ADD KEY `com_complain_infos_com_title_index` (`com_title`),
  ADD KEY `com_complain_infos_com_title_bn_index` (`com_title_bn`),
  ADD KEY `com_complain_infos_mobile_no_index` (`mobile_no`),
  ADD KEY `com_complain_infos_email_index` (`email`);

--
-- Indexes for table `com_reject`
--
ALTER TABLE `com_reject`
  ADD PRIMARY KEY (`id`),
  ADD KEY `com_reject_complain_id_foreign` (`complain_id`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `doc_doc_infos`
--
ALTER TABLE `doc_doc_infos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doc_doc_infos_org_id_foreign` (`org_id`),
  ADD KEY `doc_doc_infos_category_id_foreign` (`category_id`),
  ADD KEY `doc_doc_infos_doc_title_index` (`doc_title`),
  ADD KEY `doc_doc_infos_doc_title_bn_index` (`doc_title_bn`);

--
-- Indexes for table `external_menus`
--
ALTER TABLE `external_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `external_menus_external_panel_id_foreign` (`external_panel_id`),
  ADD KEY `external_menus_name_index` (`name`),
  ADD KEY `external_menus_name_bn_index` (`name_bn`);

--
-- Indexes for table `external_panels`
--
ALTER TABLE `external_panels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `external_panels_component_id_foreign` (`component_id`),
  ADD KEY `external_panels_name_index` (`name`),
  ADD KEY `external_panels_name_bn_index` (`name_bn`);

--
-- Indexes for table `master_banks`
--
ALTER TABLE `master_banks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_banks_component_id_foreign` (`component_id`),
  ADD KEY `master_banks_org_id_foreign` (`org_id`),
  ADD KEY `master_banks_bank_name_index` (`bank_name`),
  ADD KEY `master_banks_bank_name_bn_index` (`bank_name_bn`);

--
-- Indexes for table `master_branchs`
--
ALTER TABLE `master_branchs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_branchs_org_id_foreign` (`org_id`),
  ADD KEY `master_branchs_bank_id_foreign` (`bank_id`),
  ADD KEY `master_branchs_branch_name_index` (`branch_name`),
  ADD KEY `master_branchs_branch_name_bn_index` (`branch_name_bn`);

--
-- Indexes for table `master_city_corporations`
--
ALTER TABLE `master_city_corporations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_city_corporations_city_corporation_code_unique` (`city_corporation_code`),
  ADD KEY `master_city_corporations_division_id_foreign` (`division_id`),
  ADD KEY `master_city_corporations_district_id_foreign` (`district_id`),
  ADD KEY `master_city_corporations_city_corporation_name_index` (`city_corporation_name`),
  ADD KEY `master_city_corporations_city_corporation_name_bn_index` (`city_corporation_name_bn`);

--
-- Indexes for table `master_complain_chains`
--
ALTER TABLE `master_complain_chains`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_complain_chains_org_id_foreign` (`org_id`),
  ADD KEY `master_complain_chains_designation_id_foreign` (`designation_id`);

--
-- Indexes for table `master_complain_designations`
--
ALTER TABLE `master_complain_designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_complain_designations_org_id_foreign` (`org_id`),
  ADD KEY `master_complain_designations_designation_id_foreign` (`designation_id`);

--
-- Indexes for table `master_complain_types`
--
ALTER TABLE `master_complain_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_complain_types_com_type_name_index` (`com_type_name`),
  ADD KEY `master_complain_types_com_type_name_bn_index` (`com_type_name_bn`);

--
-- Indexes for table `master_components`
--
ALTER TABLE `master_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_components_component_name_index` (`component_name`),
  ADD KEY `master_components_component_name_bn_index` (`component_name_bn`);

--
-- Indexes for table `master_contents`
--
ALTER TABLE `master_contents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_contents_component_id_foreign` (`component_id`),
  ADD KEY `master_contents_service_id_foreign` (`service_id`);

--
-- Indexes for table `master_content_eligibility`
--
ALTER TABLE `master_content_eligibility`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_content_eligibility_master_content_id_foreign` (`master_content_id`);

--
-- Indexes for table `master_countries`
--
ALTER TABLE `master_countries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_countries_country_code_unique` (`country_code`),
  ADD KEY `master_countries_country_name_index` (`country_name`),
  ADD KEY `master_countries_country_name_bn_index` (`country_name_bn`);

--
-- Indexes for table `master_designations`
--
ALTER TABLE `master_designations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_designations_org_id_foreign` (`org_id`),
  ADD KEY `master_designations_designation_index` (`designation`),
  ADD KEY `master_designations_designation_bn_index` (`designation_bn`);

--
-- Indexes for table `master_dialogue_settings`
--
ALTER TABLE `master_dialogue_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_dialogue_settings_dialogue_index` (`dialogue`),
  ADD KEY `master_dialogue_settings_dialogue_bn_index` (`dialogue_bn`);

--
-- Indexes for table `master_districts`
--
ALTER TABLE `master_districts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_districts_district_code_unique` (`district_code`),
  ADD KEY `master_districts_division_id_foreign` (`division_id`),
  ADD KEY `master_districts_district_name_index` (`district_name`),
  ADD KEY `master_districts_district_name_bn_index` (`district_name_bn`);

--
-- Indexes for table `master_divisions`
--
ALTER TABLE `master_divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_divisions_division_code_unique` (`division_code`),
  ADD KEY `master_divisions_country_id_foreign` (`country_id`),
  ADD KEY `master_divisions_division_name_index` (`division_name`),
  ADD KEY `master_divisions_division_name_bn_index` (`division_name_bn`);

--
-- Indexes for table `master_document_categories`
--
ALTER TABLE `master_document_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_document_categories_category_name_index` (`category_name`),
  ADD KEY `master_document_categories_category_name_bn_index` (`category_name_bn`);

--
-- Indexes for table `master_eligibility_types`
--
ALTER TABLE `master_eligibility_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_eligibility_types_type_name_index` (`type_name`),
  ADD KEY `master_eligibility_types_type_name_bn_index` (`type_name_bn`);

--
-- Indexes for table `master_faqs`
--
ALTER TABLE `master_faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_faqs_component_id_foreign` (`component_id`),
  ADD KEY `master_faqs_service_id_foreign` (`service_id`),
  ADD KEY `master_faqs_question_index` (`question`),
  ADD KEY `master_faqs_question_bn_index` (`question_bn`);

--
-- Indexes for table `master_fiscal_years`
--
ALTER TABLE `master_fiscal_years`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_fiscal_years_year_index` (`year`),
  ADD KEY `master_fiscal_years_start_date_index` (`start_date`),
  ADD KEY `master_fiscal_years_end_date_index` (`end_date`);

--
-- Indexes for table `master_grades`
--
ALTER TABLE `master_grades`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_grades_grade_name_index` (`grade_name`),
  ADD KEY `master_grades_grade_name_bn_index` (`grade_name_bn`);

--
-- Indexes for table `master_menus`
--
ALTER TABLE `master_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_menus_module_id_foreign` (`module_id`),
  ADD KEY `master_menus_component_id_foreign` (`component_id`),
  ADD KEY `master_menus_service_id_foreign` (`service_id`),
  ADD KEY `master_menus_menu_name_index` (`menu_name`),
  ADD KEY `master_menus_menu_name_bn_index` (`menu_name_bn`);

--
-- Indexes for table `master_modules`
--
ALTER TABLE `master_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_modules_component_id_foreign` (`component_id`),
  ADD KEY `master_modules_module_name_index` (`module_name`),
  ADD KEY `master_modules_module_name_bn_index` (`module_name_bn`);

--
-- Indexes for table `master_notification_settings`
--
ALTER TABLE `master_notification_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_notification_settings_org_id_foreign` (`org_id`),
  ADD KEY `master_notification_settings_component_id_foreign` (`component_id`),
  ADD KEY `master_notification_settings_module_id_foreign` (`module_id`),
  ADD KEY `master_notification_settings_service_id_foreign` (`service_id`),
  ADD KEY `master_notification_settings_menu_id_foreign` (`menu_id`),
  ADD KEY `master_notification_settings_notification_type_id_foreign` (`notification_type_id`);

--
-- Indexes for table `master_notification_types`
--
ALTER TABLE `master_notification_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_notification_types_not_type_name_index` (`not_type_name`),
  ADD KEY `master_notification_types_not_type_name_bn_index` (`not_type_name_bn`);

--
-- Indexes for table `master_offices`
--
ALTER TABLE `master_offices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_offices_org_id_foreign` (`org_id`),
  ADD KEY `master_offices_office_type_id_foreign` (`office_type_id`),
  ADD KEY `master_offices_country_id_foreign` (`country_id`),
  ADD KEY `master_offices_division_id_foreign` (`division_id`),
  ADD KEY `master_offices_district_id_foreign` (`district_id`),
  ADD KEY `master_offices_office_name_index` (`office_name`),
  ADD KEY `master_offices_office_name_bn_index` (`office_name_bn`);

--
-- Indexes for table `master_office_types`
--
ALTER TABLE `master_office_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_office_types_org_id_foreign` (`org_id`),
  ADD KEY `master_office_types_office_type_name_index` (`office_type_name`),
  ADD KEY `master_office_types_office_type_name_bn_index` (`office_type_name_bn`);

--
-- Indexes for table `master_org_components`
--
ALTER TABLE `master_org_components`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_org_components_component_id_foreign` (`component_id`),
  ADD KEY `master_org_components_org_id_foreign` (`org_id`);

--
-- Indexes for table `master_org_modules`
--
ALTER TABLE `master_org_modules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_org_modules_module_id_foreign` (`module_id`),
  ADD KEY `master_org_modules_org_id_foreign` (`org_id`);

--
-- Indexes for table `master_org_profiles`
--
ALTER TABLE `master_org_profiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_org_profiles_org_name_index` (`org_name`),
  ADD KEY `master_org_profiles_org_name_bn_index` (`org_name_bn`);

--
-- Indexes for table `master_pauroshobas`
--
ALTER TABLE `master_pauroshobas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_pauroshobas_pauroshoba_code_unique` (`pauroshoba_code`),
  ADD KEY `master_pauroshobas_division_id_foreign` (`division_id`),
  ADD KEY `master_pauroshobas_district_id_foreign` (`district_id`),
  ADD KEY `master_pauroshobas_upazila_id_foreign` (`upazila_id`),
  ADD KEY `master_pauroshobas_pauroshoba_name_index` (`pauroshoba_name`),
  ADD KEY `master_pauroshobas_pauroshoba_name_bn_index` (`pauroshoba_name_bn`);

--
-- Indexes for table `master_payment_services`
--
ALTER TABLE `master_payment_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_payment_services_org_id_foreign` (`org_id`),
  ADD KEY `master_payment_services_module_id_foreign` (`module_id`),
  ADD KEY `master_payment_services_component_id_foreign` (`component_id`),
  ADD KEY `master_payment_services_service_id_foreign` (`service_id`);

--
-- Indexes for table `master_services`
--
ALTER TABLE `master_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_services_module_id_foreign` (`module_id`),
  ADD KEY `master_services_component_id_foreign` (`component_id`),
  ADD KEY `master_services_service_name_index` (`service_name`),
  ADD KEY `master_services_service_name_bn_index` (`service_name_bn`);

--
-- Indexes for table `master_thanas`
--
ALTER TABLE `master_thanas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_thanas_thana_code_unique` (`thana_code`),
  ADD KEY `master_thanas_district_id_foreign` (`district_id`),
  ADD KEY `master_thanas_thana_name_index` (`thana_name`),
  ADD KEY `master_thanas_thana_name_bn_index` (`thana_name_bn`);

--
-- Indexes for table `master_unions`
--
ALTER TABLE `master_unions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_unions_union_code_unique` (`union_code`),
  ADD KEY `master_unions_division_id_foreign` (`division_id`),
  ADD KEY `master_unions_district_id_foreign` (`district_id`),
  ADD KEY `master_unions_upazila_id_foreign` (`upazila_id`),
  ADD KEY `master_unions_union_name_index` (`union_name`),
  ADD KEY `master_unions_union_name_bn_index` (`union_name_bn`);

--
-- Indexes for table `master_upazilas`
--
ALTER TABLE `master_upazilas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `master_upazilas_upazila_code_unique` (`upazila_code`),
  ADD KEY `master_upazilas_district_id_foreign` (`district_id`),
  ADD KEY `master_upazilas_upazila_name_index` (`upazila_name`),
  ADD KEY `master_upazilas_upazila_name_bn_index` (`upazila_name_bn`);

--
-- Indexes for table `master_wards`
--
ALTER TABLE `master_wards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `master_ward_details`
--
ALTER TABLE `master_ward_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `master_ward_details_master_ward_id_foreign` (`master_ward_id`),
  ADD KEY `master_ward_details_ward_name_index` (`ward_name`),
  ADD KEY `master_ward_details_ward_name_bn_index` (`ward_name_bn`);

--
-- Indexes for table `message_template`
--
ALTER TABLE `message_template`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_template_template_index` (`template`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ministry_dashboard_menus`
--
ALTER TABLE `ministry_dashboard_menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ministry_dashboard_menus_component_id_foreign` (`component_id`),
  ADD KEY `ministry_dashboard_menus_menu_name_index` (`menu_name`),
  ADD KEY `ministry_dashboard_menus_menu_name_bn_index` (`menu_name_bn`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_recipient_id_index` (`recipient_id`),
  ADD KEY `notifications_sender_id_index` (`sender_id`);

--
-- Indexes for table `notification_settings`
--
ALTER TABLE `notification_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notification_settings_template_id_foreign` (`template_id`);

--
-- Indexes for table `not_circulate_notices`
--
ALTER TABLE `not_circulate_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `not_circulate_notices_org_id_foreign` (`org_id`),
  ADD KEY `not_circulate_notices_office_id_foreign` (`office_id`),
  ADD KEY `not_circulate_notices_designation_id_foreign` (`designation_id`),
  ADD KEY `not_circulate_notices_notification_type_id_foreign` (`notification_type_id`),
  ADD KEY `not_circulate_notices_notice_title_index` (`notice_title`),
  ADD KEY `not_circulate_notices_notice_title_bn_index` (`notice_title_bn`),
  ADD KEY `not_circulate_notices_notice_date_index` (`notice_date`);

--
-- Indexes for table `not_notification_templates`
--
ALTER TABLE `not_notification_templates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `not_notification_templates_org_id_foreign` (`org_id`),
  ADD KEY `not_notification_templates_component_id_foreign` (`component_id`),
  ADD KEY `not_notification_templates_module_id_foreign` (`module_id`),
  ADD KEY `not_notification_templates_service_id_foreign` (`service_id`),
  ADD KEY `not_notification_templates_menu_id_foreign` (`menu_id`),
  ADD KEY `not_notification_templates_notification_type_id_foreign` (`notification_type_id`),
  ADD KEY `not_notification_templates_title_index` (`title`),
  ADD KEY `not_notification_templates_title_bn_index` (`title_bn`);

--
-- Indexes for table `portal_abouts`
--
ALTER TABLE `portal_abouts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portal_ex_organizations`
--
ALTER TABLE `portal_ex_organizations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_ex_organizations_ministry_id_foreign` (`ministry_id`),
  ADD KEY `portal_ex_organizations_ex_org_name_index` (`ex_org_name`),
  ADD KEY `portal_ex_organizations_ex_org_name_bn_index` (`ex_org_name_bn`);

--
-- Indexes for table `portal_faqs`
--
ALTER TABLE `portal_faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_faqs_title_index` (`title`),
  ADD KEY `portal_faqs_title_bn_index` (`title_bn`);

--
-- Indexes for table `portal_footers`
--
ALTER TABLE `portal_footers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `portal_headers`
--
ALTER TABLE `portal_headers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_headers_title_index` (`title`),
  ADD KEY `portal_headers_title_bn_index` (`title_bn`);

--
-- Indexes for table `portal_ministry_entries`
--
ALTER TABLE `portal_ministry_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_ministry_entries_ministry_name_index` (`ministry_name`),
  ADD KEY `portal_ministry_entries_ministry_name_bn_index` (`ministry_name_bn`);

--
-- Indexes for table `portal_news`
--
ALTER TABLE `portal_news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_news_title_index` (`title`),
  ADD KEY `portal_news_title_bn_index` (`title_bn`);

--
-- Indexes for table `portal_notices`
--
ALTER TABLE `portal_notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_notices_title_index` (`title`),
  ADD KEY `portal_notices_title_bn_index` (`title_bn`);

--
-- Indexes for table `portal_services`
--
ALTER TABLE `portal_services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_services_component_id_foreign` (`component_id`),
  ADD KEY `portal_services_service_category_id_foreign` (`service_category_id`),
  ADD KEY `portal_services_ministry_id_foreign` (`ministry_id`),
  ADD KEY `portal_services_ex_org_id_foreign` (`ex_org_id`),
  ADD KEY `portal_services_service_type_id_index` (`service_type_id`),
  ADD KEY `portal_services_name_index` (`name`),
  ADD KEY `portal_services_name_bn_index` (`name_bn`);

--
-- Indexes for table `portal_service_attachments`
--
ALTER TABLE `portal_service_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_attachments_service_id_foreign` (`service_id`),
  ADD KEY `portal_service_attachments_name_index` (`name`),
  ADD KEY `portal_service_attachments_name_bn_index` (`name_bn`);

--
-- Indexes for table `portal_service_categories`
--
ALTER TABLE `portal_service_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_categories_name_index` (`name`),
  ADD KEY `portal_service_categories_name_bn_index` (`name_bn`);

--
-- Indexes for table `portal_service_customers`
--
ALTER TABLE `portal_service_customers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_customers_service_id_foreign` (`service_id`),
  ADD KEY `portal_service_customers_customer_type_id_foreign` (`customer_type_id`);

--
-- Indexes for table `portal_service_customer_types`
--
ALTER TABLE `portal_service_customer_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_customer_types_name_index` (`name`),
  ADD KEY `portal_service_customer_types_name_bn_index` (`name_bn`);

--
-- Indexes for table `portal_service_fees`
--
ALTER TABLE `portal_service_fees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_fees_service_id_foreign` (`service_id`),
  ADD KEY `portal_service_fees_name_index` (`name`),
  ADD KEY `portal_service_fees_name_bn_index` (`name_bn`);

--
-- Indexes for table `portal_service_org`
--
ALTER TABLE `portal_service_org`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_org_service_id_foreign` (`service_id`),
  ADD KEY `portal_service_org_org_id_foreign` (`org_id`);

--
-- Indexes for table `portal_service_permissions`
--
ALTER TABLE `portal_service_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portal_service_permissions_service_id_foreign` (`service_id`);

--
-- Indexes for table `portal_social_media_links`
--
ALTER TABLE `portal_social_media_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `service_eligibility_types`
--
ALTER TABLE `service_eligibility_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `service_eligibility_types_type_name_unique` (`type_name`);

--
-- Indexes for table `user_logs`
--
ALTER TABLE `user_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username_index` (`username`),
  ADD KEY `uid_index` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assign_designations`
--
ALTER TABLE `assign_designations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `cmt_agenda`
--
ALTER TABLE `cmt_agenda`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cmt_committees`
--
ALTER TABLE `cmt_committees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cmt_committee_members`
--
ALTER TABLE `cmt_committee_members`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cmt_expenses`
--
ALTER TABLE `cmt_expenses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cmt_meeting_minutes`
--
ALTER TABLE `cmt_meeting_minutes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `component_designations`
--
ALTER TABLE `component_designations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `com_approve`
--
ALTER TABLE `com_approve`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `com_committees`
--
ALTER TABLE `com_committees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `com_committee_reports`
--
ALTER TABLE `com_committee_reports`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `com_complain_cycle`
--
ALTER TABLE `com_complain_cycle`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `com_complain_infos`
--
ALTER TABLE `com_complain_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `com_reject`
--
ALTER TABLE `com_reject`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `doc_doc_infos`
--
ALTER TABLE `doc_doc_infos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `external_menus`
--
ALTER TABLE `external_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `external_panels`
--
ALTER TABLE `external_panels`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `master_banks`
--
ALTER TABLE `master_banks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `master_branchs`
--
ALTER TABLE `master_branchs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_city_corporations`
--
ALTER TABLE `master_city_corporations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `master_complain_chains`
--
ALTER TABLE `master_complain_chains`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `master_complain_designations`
--
ALTER TABLE `master_complain_designations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `master_complain_types`
--
ALTER TABLE `master_complain_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `master_components`
--
ALTER TABLE `master_components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `master_contents`
--
ALTER TABLE `master_contents`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_content_eligibility`
--
ALTER TABLE `master_content_eligibility`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_countries`
--
ALTER TABLE `master_countries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `master_designations`
--
ALTER TABLE `master_designations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `master_dialogue_settings`
--
ALTER TABLE `master_dialogue_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `master_districts`
--
ALTER TABLE `master_districts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `master_divisions`
--
ALTER TABLE `master_divisions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `master_document_categories`
--
ALTER TABLE `master_document_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `master_eligibility_types`
--
ALTER TABLE `master_eligibility_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_faqs`
--
ALTER TABLE `master_faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_fiscal_years`
--
ALTER TABLE `master_fiscal_years`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `master_grades`
--
ALTER TABLE `master_grades`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_menus`
--
ALTER TABLE `master_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `master_modules`
--
ALTER TABLE `master_modules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `master_notification_settings`
--
ALTER TABLE `master_notification_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_notification_types`
--
ALTER TABLE `master_notification_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `master_offices`
--
ALTER TABLE `master_offices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `master_office_types`
--
ALTER TABLE `master_office_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `master_org_components`
--
ALTER TABLE `master_org_components`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `master_org_modules`
--
ALTER TABLE `master_org_modules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_org_profiles`
--
ALTER TABLE `master_org_profiles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `master_pauroshobas`
--
ALTER TABLE `master_pauroshobas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=321;

--
-- AUTO_INCREMENT for table `master_payment_services`
--
ALTER TABLE `master_payment_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `master_services`
--
ALTER TABLE `master_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `master_thanas`
--
ALTER TABLE `master_thanas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `master_unions`
--
ALTER TABLE `master_unions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4544;

--
-- AUTO_INCREMENT for table `master_upazilas`
--
ALTER TABLE `master_upazilas`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=509;

--
-- AUTO_INCREMENT for table `master_wards`
--
ALTER TABLE `master_wards`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `master_ward_details`
--
ALTER TABLE `master_ward_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `message_template`
--
ALTER TABLE `message_template`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT for table `ministry_dashboard_menus`
--
ALTER TABLE `ministry_dashboard_menus`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_settings`
--
ALTER TABLE `notification_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `not_circulate_notices`
--
ALTER TABLE `not_circulate_notices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `not_notification_templates`
--
ALTER TABLE `not_notification_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portal_abouts`
--
ALTER TABLE `portal_abouts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portal_ex_organizations`
--
ALTER TABLE `portal_ex_organizations`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `portal_faqs`
--
ALTER TABLE `portal_faqs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `portal_footers`
--
ALTER TABLE `portal_footers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `portal_headers`
--
ALTER TABLE `portal_headers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `portal_ministry_entries`
--
ALTER TABLE `portal_ministry_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `portal_news`
--
ALTER TABLE `portal_news`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `portal_notices`
--
ALTER TABLE `portal_notices`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `portal_services`
--
ALTER TABLE `portal_services`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `portal_service_attachments`
--
ALTER TABLE `portal_service_attachments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=993;

--
-- AUTO_INCREMENT for table `portal_service_categories`
--
ALTER TABLE `portal_service_categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `portal_service_customers`
--
ALTER TABLE `portal_service_customers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT for table `portal_service_customer_types`
--
ALTER TABLE `portal_service_customer_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `portal_service_fees`
--
ALTER TABLE `portal_service_fees`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=297;

--
-- AUTO_INCREMENT for table `portal_service_org`
--
ALTER TABLE `portal_service_org`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=104;

--
-- AUTO_INCREMENT for table `portal_service_permissions`
--
ALTER TABLE `portal_service_permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `portal_social_media_links`
--
ALTER TABLE `portal_social_media_links`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_eligibility_types`
--
ALTER TABLE `service_eligibility_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logs`
--
ALTER TABLE `user_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_designations`
--
ALTER TABLE `assign_designations`
  ADD CONSTRAINT `assign_designations_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `master_designations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assign_designations_office_id_foreign` FOREIGN KEY (`office_id`) REFERENCES `master_offices` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assign_designations_office_type_id_foreign` FOREIGN KEY (`office_type_id`) REFERENCES `master_office_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `assign_designations_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cmt_agenda`
--
ALTER TABLE `cmt_agenda`
  ADD CONSTRAINT `cmt_agenda_cmt_committee_id_foreign` FOREIGN KEY (`cmt_committee_id`) REFERENCES `cmt_committees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cmt_agenda_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cmt_committees`
--
ALTER TABLE `cmt_committees`
  ADD CONSTRAINT `cmt_committees_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cmt_committee_members`
--
ALTER TABLE `cmt_committee_members`
  ADD CONSTRAINT `cmt_committee_members_cmt_committee_id_foreign` FOREIGN KEY (`cmt_committee_id`) REFERENCES `cmt_committees` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cmt_expenses`
--
ALTER TABLE `cmt_expenses`
  ADD CONSTRAINT `cmt_expenses_cmt_agenda_id_foreign` FOREIGN KEY (`cmt_agenda_id`) REFERENCES `cmt_agenda` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cmt_expenses_cmt_committee_id_foreign` FOREIGN KEY (`cmt_committee_id`) REFERENCES `cmt_committees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cmt_expenses_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cmt_meeting_minutes`
--
ALTER TABLE `cmt_meeting_minutes`
  ADD CONSTRAINT `cmt_meeting_minutes_cmt_agenda_id_foreign` FOREIGN KEY (`cmt_agenda_id`) REFERENCES `cmt_agenda` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cmt_meeting_minutes_cmt_committee_id_foreign` FOREIGN KEY (`cmt_committee_id`) REFERENCES `cmt_committees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cmt_meeting_minutes_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `component_designations`
--
ALTER TABLE `component_designations`
  ADD CONSTRAINT `component_designations_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `component_designations_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `master_designations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `component_designations_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_approve`
--
ALTER TABLE `com_approve`
  ADD CONSTRAINT `com_approve_complain_id_foreign` FOREIGN KEY (`complain_id`) REFERENCES `com_complain_infos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_committees`
--
ALTER TABLE `com_committees`
  ADD CONSTRAINT `com_committees_complain_id_foreign` FOREIGN KEY (`complain_id`) REFERENCES `com_complain_infos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_committees_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `master_designations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_committee_reports`
--
ALTER TABLE `com_committee_reports`
  ADD CONSTRAINT `com_committee_reports_complain_id_foreign` FOREIGN KEY (`complain_id`) REFERENCES `com_complain_infos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_complain_cycle`
--
ALTER TABLE `com_complain_cycle`
  ADD CONSTRAINT `com_complain_cycle_complain_id_foreign` FOREIGN KEY (`complain_id`) REFERENCES `com_complain_infos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_complain_infos`
--
ALTER TABLE `com_complain_infos`
  ADD CONSTRAINT `com_complain_infos_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `master_districts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `master_divisions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `master_modules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_union_id_foreign` FOREIGN KEY (`union_id`) REFERENCES `master_unions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `com_complain_infos_upazila_id_foreign` FOREIGN KEY (`upazila_id`) REFERENCES `master_upazilas` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `com_reject`
--
ALTER TABLE `com_reject`
  ADD CONSTRAINT `com_reject_complain_id_foreign` FOREIGN KEY (`complain_id`) REFERENCES `com_complain_infos` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doc_doc_infos`
--
ALTER TABLE `doc_doc_infos`
  ADD CONSTRAINT `doc_doc_infos_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `master_document_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `doc_doc_infos_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `external_menus`
--
ALTER TABLE `external_menus`
  ADD CONSTRAINT `external_menus_external_panel_id_foreign` FOREIGN KEY (`external_panel_id`) REFERENCES `external_panels` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `external_panels`
--
ALTER TABLE `external_panels`
  ADD CONSTRAINT `external_panels_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`);

--
-- Constraints for table `master_banks`
--
ALTER TABLE `master_banks`
  ADD CONSTRAINT `master_banks_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_banks_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_branchs`
--
ALTER TABLE `master_branchs`
  ADD CONSTRAINT `master_branchs_bank_id_foreign` FOREIGN KEY (`bank_id`) REFERENCES `master_banks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_branchs_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_city_corporations`
--
ALTER TABLE `master_city_corporations`
  ADD CONSTRAINT `master_city_corporations_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `master_districts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_city_corporations_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `master_divisions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_complain_chains`
--
ALTER TABLE `master_complain_chains`
  ADD CONSTRAINT `master_complain_chains_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `master_designations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_complain_chains_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_complain_designations`
--
ALTER TABLE `master_complain_designations`
  ADD CONSTRAINT `master_complain_designations_designation_id_foreign` FOREIGN KEY (`designation_id`) REFERENCES `master_designations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_complain_designations_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_contents`
--
ALTER TABLE `master_contents`
  ADD CONSTRAINT `master_contents_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_contents_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `master_services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_content_eligibility`
--
ALTER TABLE `master_content_eligibility`
  ADD CONSTRAINT `master_content_eligibility_master_content_id_foreign` FOREIGN KEY (`master_content_id`) REFERENCES `master_contents` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_designations`
--
ALTER TABLE `master_designations`
  ADD CONSTRAINT `master_designations_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_districts`
--
ALTER TABLE `master_districts`
  ADD CONSTRAINT `master_districts_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `master_divisions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_divisions`
--
ALTER TABLE `master_divisions`
  ADD CONSTRAINT `master_divisions_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `master_countries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_faqs`
--
ALTER TABLE `master_faqs`
  ADD CONSTRAINT `master_faqs_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_faqs_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `master_services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_menus`
--
ALTER TABLE `master_menus`
  ADD CONSTRAINT `master_menus_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_menus_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `master_modules` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_modules`
--
ALTER TABLE `master_modules`
  ADD CONSTRAINT `master_modules_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_notification_settings`
--
ALTER TABLE `master_notification_settings`
  ADD CONSTRAINT `master_notification_settings_component_id_foreign` FOREIGN KEY (`component_id`) REFERENCES `master_components` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_notification_settings_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `master_menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_notification_settings_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `master_modules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_notification_settings_notification_type_id_foreign` FOREIGN KEY (`notification_type_id`) REFERENCES `master_notification_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_notification_settings_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_notification_settings_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `master_services` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_offices`
--
ALTER TABLE `master_offices`
  ADD CONSTRAINT `master_offices_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `master_countries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_offices_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `master_districts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_offices_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `master_divisions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_offices_office_type_id_foreign` FOREIGN KEY (`office_type_id`) REFERENCES `master_office_types` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_offices_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_office_types`
--
ALTER TABLE `master_office_types`
  ADD CONSTRAINT `master_office_types_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_org_modules`
--
ALTER TABLE `master_org_modules`
  ADD CONSTRAINT `master_org_modules_module_id_foreign` FOREIGN KEY (`module_id`) REFERENCES `master_modules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `master_org_modules_org_id_foreign` FOREIGN KEY (`org_id`) REFERENCES `master_org_profiles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `master_thanas`
--
ALTER TABLE `master_thanas`
  ADD CONSTRAINT `master_thanas_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `master_districts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
