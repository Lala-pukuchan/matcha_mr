-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: db:3306
-- 生成日時: 2024 年 11 月 25 日 15:48
-- サーバのバージョン： 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP のバージョン: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- データベース: `matcha`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `blocked`
--

CREATE TABLE `blocked` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `blocked_to_user_id` varchar(256) NOT NULL,
  `blocked_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `blocked`
--

INSERT INTO `blocked` (`id`, `from_user_id`, `blocked_to_user_id`, `blocked_at`) VALUES
(3, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '2024-02-23 04:59:03');

-- --------------------------------------------------------

--
-- テーブルの構造 `liked`
--

CREATE TABLE `liked` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `liked_to_user_id` varchar(256) NOT NULL,
  `liked_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `liked`
--

INSERT INTO `liked` (`id`, `from_user_id`, `liked_to_user_id`, `liked_at`) VALUES
(22, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-14 16:10:02'),
(26, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'e4707942-09b2-4667-a9e8-e87b75b594c7', '2024-02-15 09:56:30'),
(27, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-15 09:56:33'),
(28, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '2024-02-15 09:56:38'),
(29, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-16 05:02:43'),
(30, '57457753-b995-41bd-9c9e-f78d7b0d6699', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 06:10:05'),
(31, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '57457753-b995-41bd-9c9e-f78d7b0d6699', '2024-02-20 06:11:29'),
(34, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-07-22 14:25:01'),
(37, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10 20:08:35'),
(41, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-11-08 10:27:24'),
(42, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-08 10:27:37'),
(43, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-11-08 10:28:11'),
(44, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:36:34'),
(45, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '8727a67e-1a50-48bb-b854-355c3ec200ea', '2024-11-08 10:36:35'),
(46, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '9ec4c4ca-978b-434d-8302-b4ad68565c4c', '2024-11-08 10:36:36'),
(47, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'e4707942-09b2-4667-a9e8-e87b75b594c7', '2024-11-08 10:36:37'),
(48, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '2024-11-08 10:36:39'),
(49, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'ee583dd0-4da8-4b77-848f-78a515a0fc22', '2024-11-08 10:36:40'),
(50, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '77743911-bb39-408b-af66-d84df45d73fa', '2024-11-08 10:36:41'),
(51, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:39:20'),
(52, '511c3f3b-0200-4c5c-9745-8060e2403673', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:57:41'),
(53, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 10:58:28'),
(54, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 11:01:31'),
(55, '511c3f3b-0200-4c5c-9745-8060e2403673', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-11-08 11:02:27'),
(56, '511c3f3b-0200-4c5c-9745-8060e2403673', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-08 11:03:12'),
(59, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '2024-11-25 15:40:41'),
(60, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-25 15:40:55'),
(64, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:42:17'),
(65, '63fb855d-5267-4caa-a038-1a1274f67796', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-25 15:42:38'),
(67, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:43:38'),
(68, '63fb855d-5267-4caa-a038-1a1274f67796', 'e9bea5f8-453c-4715-8532-163c0c348dfb', '2024-11-25 15:43:40'),
(69, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '750f838c-356f-4c1d-8ad2-0b4e76882595', '2024-11-25 15:44:38');

-- --------------------------------------------------------

--
-- テーブルの構造 `matched`
--

CREATE TABLE `matched` (
  `id` int(11) NOT NULL,
  `matched_user_id_first` varchar(256) NOT NULL,
  `matched_user_id_second` varchar(256) NOT NULL,
  `matched_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `matched`
--

INSERT INTO `matched` (`id`, `matched_user_id_first`, `matched_user_id_second`, `matched_at`) VALUES
(4, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-15 09:56:30'),
(5, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-16 05:02:43'),
(6, '57457753-b995-41bd-9c9e-f78d7b0d6699', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 06:11:29'),
(12, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:24'),
(13, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:37'),
(14, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:39:20'),
(15, '511c3f3b-0200-4c5c-9745-8060e2403673', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:58:28'),
(16, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 11:02:27'),
(18, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '2024-11-25 15:40:55'),
(19, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:42:38'),
(21, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:43:40');

-- --------------------------------------------------------

--
-- テーブルの構造 `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `to_user_id` varchar(256) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `messages`
--

INSERT INTO `messages` (`id`, `room_id`, `from_user_id`, `to_user_id`, `message`, `sent_at`) VALUES
(6, 2, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'Hello Eric, I\'m spam', '2024-08-10 20:09:29');

-- --------------------------------------------------------

--
-- テーブルの構造 `notifications`
--

CREATE TABLE `notifications` (
  `id` varchar(36) NOT NULL,
  `user_id` varchar(256) NOT NULL,
  `type` varchar(256) NOT NULL,
  `message` text NOT NULL,
  `from_user_id` varchar(256) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `checked` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `message`, `from_user_id`, `timestamp`, `checked`) VALUES
('04d949ee-77fd-4005-b7e0-11133f2936eb', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:39', 0),
('08a99de3-3561-4880-a3bf-d95a8383d4fe', '511c3f3b-0200-4c5c-9745-8060e2403673', 'match', 'You have a new match with Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:58:28', 1),
('08f8aa39-6adb-4a61-9c13-c5fc677e6c5c', '55f6c362-94c2-4fdb-9bc9-5da9d463393a', 'like', 'You received a like from spam', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-25 15:40:41', 1),
('0c747739-2447-4758-b99c-cca880acca85', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'like', 'You received a like from Arthur', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 10:57:41', 0),
('17404899-3f44-43bd-b5fe-3c82d55274d3', '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', 'unlike', 'You received an unlike from BigGayAl', 'e9bea5f8-453c-4715-8532-163c0c348dfb', '2024-11-25 15:44:26', 0),
('255d7be3-4c61-4206-99d3-2915c2316e7d', '511c3f3b-0200-4c5c-9745-8060e2403673', 'like', 'You received a like from Heidi', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-11-08 11:01:31', 1),
('2bfa8276-9348-48e1-a6a1-26bc588ed7ce', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'match', 'You have a new match with Liane', '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '2024-11-25 15:40:55', 1),
('2d22ebfb-37a4-4fd7-a9a2-9d2df771e84a', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'like', 'You received a like from Liane', '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '2024-11-25 15:40:55', 1),
('324d21d4-d03b-489a-9839-eefb962226d1', '63fb855d-5267-4caa-a038-1a1274f67796', 'like', 'You received a like from BigGayAl', 'e9bea5f8-453c-4715-8532-163c0c348dfb', '2024-11-25 15:43:38', 0),
('39eaab34-42f4-409c-b374-b0e548cae48a', 'ee583dd0-4da8-4b77-848f-78a515a0fc22', 'viewed', 'Your profile was viewed by Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 11:43:45', 0),
('3ad4d27e-a8ee-410e-89cc-10baad5a0fc7', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'match', 'You have a new match with Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:24', 1),
('3ef90382-0f11-4a6b-8fd6-2f553c6c8095', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'match', 'You have a new match with Garrison', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:42:38', 0),
('40167cda-8a84-43f9-88d3-c61c015d837b', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'like', 'You received a like from Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:24', 1),
('4edee811-3626-4067-b48e-ebd604eae68c', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'viewed', 'Your profile was viewed by Heidi', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-11-08 11:03:38', 0),
('5766f7fe-c93c-4ded-8e25-bd212795e917', 'ee583dd0-4da8-4b77-848f-78a515a0fc22', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:40', 0),
('660b6621-4971-4f36-a4f3-6317b59f985a', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'like', 'You received a like from Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:28:11', 0),
('6a89fb0d-a6be-4daf-baaf-277d361335d7', '750f838c-356f-4c1d-8ad2-0b4e76882595', 'like', 'You received a like from BigGayAl', 'e9bea5f8-453c-4715-8532-163c0c348dfb', '2024-11-25 15:44:38', 0),
('6efc77c4-12a6-416b-b7e4-eb20581c49ec', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'match', 'You have a new match with Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:37', 1),
('72575446-8dc3-4712-be58-dde14e98f8f0', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'match', 'You have a new match with Arthur', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 11:02:27', 0),
('7b3adbc5-6b8f-4cad-9075-d76f7fe7b824', '63fb855d-5267-4caa-a038-1a1274f67796', 'like', 'You received a like from spam', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-11-25 15:42:17', 0),
('874d667f-89b7-4618-986a-2c2472201e4e', '9ec4c4ca-978b-434d-8302-b4ad68565c4c', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:36', 0),
('912f611a-c406-43b4-803f-0cf355a44f5c', '77743911-bb39-408b-af66-d84df45d73fa', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:41', 0),
('99f56ee0-e3a0-43ed-9223-98b1368ad702', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'like', 'You received a like from Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:39:20', 0),
('9ade5c93-1e60-42f4-a0e7-85e7c0411af6', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'like', 'You received a like from Garrison', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:42:38', 0),
('aa526162-a8de-4bc2-877c-daf6c069c548', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:34', 0),
('af16eda0-c4a3-4f5a-9eec-94713b62a9b0', 'e9bea5f8-453c-4715-8532-163c0c348dfb', 'like', 'You received a like from Garrison', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:43:40', 0),
('b9bf3b8a-0a19-4673-9574-a72a9d9289e5', '8727a67e-1a50-48bb-b854-355c3ec200ea', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:35', 0),
('bfbf50c6-b76e-49bd-b75d-75941c14c320', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'like', 'You received a like from Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:27:37', 1),
('d4fedbe3-f114-4bcb-b961-5f0a5d75c3d5', 'e9bea5f8-453c-4715-8532-163c0c348dfb', 'match', 'You have a new match with Garrison', '63fb855d-5267-4caa-a038-1a1274f67796', '2024-11-25 15:43:40', 0),
('d8054473-caf5-4436-8b5c-af3d021547c2', 'e4707942-09b2-4667-a9e8-e87b75b594c7', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:36:37', 0),
('e7228c88-3021-4f28-b50e-57fade1b2dfe', '511c3f3b-0200-4c5c-9745-8060e2403673', 'like', 'You received a like from Mariko', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '2024-11-08 10:58:28', 1),
('f22423c2-8df6-4ec4-96d5-5aff56fc48a4', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'like', 'You received a like from Arthur', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 11:02:27', 0),
('f24c0387-a2a0-4f50-8f3b-fce164053422', 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'match', 'You have a new match with Eric', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 10:39:20', 0),
('f60ce529-d9fb-401e-830d-d82a6b4e28e7', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'like', 'You received a like from Arthur', '511c3f3b-0200-4c5c-9745-8060e2403673', '2024-11-08 11:03:12', 1);

-- --------------------------------------------------------

--
-- テーブルの構造 `rooms`
--

CREATE TABLE `rooms` (
  `room_id` int(11) NOT NULL,
  `user_id_first` varchar(256) NOT NULL,
  `user_id_second` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `rooms`
--

INSERT INTO `rooms` (`room_id`, `user_id_first`, `user_id_second`) VALUES
(2, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd'),
(4, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273'),
(5, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b'),
(6, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd'),
(7, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '8727a67e-1a50-48bb-b854-355c3ec200ea'),
(8, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '9ec4c4ca-978b-434d-8302-b4ad68565c4c'),
(9, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'e4707942-09b2-4667-a9e8-e87b75b594c7'),
(10, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7'),
(11, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'ee583dd0-4da8-4b77-848f-78a515a0fc22'),
(12, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '77743911-bb39-408b-af66-d84df45d73fa'),
(13, '511c3f3b-0200-4c5c-9745-8060e2403673', 'efe21ca7-f46f-4c7b-b816-a9858cffced5'),
(14, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '511c3f3b-0200-4c5c-9745-8060e2403673'),
(15, '511c3f3b-0200-4c5c-9745-8060e2403673', '97ff9f6e-aa79-45cd-9641-5f649447d6c4'),
(17, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '55f6c362-94c2-4fdb-9bc9-5da9d463393a'),
(21, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '63fb855d-5267-4caa-a038-1a1274f67796'),
(22, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '63fb855d-5267-4caa-a038-1a1274f67796'),
(23, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '750f838c-356f-4c1d-8ad2-0b4e76882595');

-- --------------------------------------------------------

--
-- テーブルの構造 `room_messages`
--

CREATE TABLE `room_messages` (
  `message_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `message` text NOT NULL,
  `sent_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- テーブルの構造 `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `tag`
--

INSERT INTO `tag` (`id`, `name`) VALUES
(43, 'Alternative Music'),
(33, 'Art Galleries'),
(47, 'Artisanal Coffee'),
(34, 'Biking'),
(45, 'Book Clubs'),
(26, 'Camping'),
(49, 'Concept Stores'),
(42, 'Craft Beer'),
(46, 'Farmers Markets'),
(28, 'fighting'),
(39, 'Indie Films'),
(40, 'Local Markets'),
(44, 'Meditation'),
(38, 'Minimalism'),
(24, 'Music'),
(35, 'Organic Food'),
(37, 'Photography'),
(25, 'Piano'),
(50, 'Programming'),
(48, 'Second-Hand Shopping'),
(36, 'Street Art'),
(27, 'Study'),
(29, 'Surf'),
(41, 'Sustainability'),
(51, 'Travel'),
(31, 'Vegan'),
(32, 'Vintage'),
(23, 'wine'),
(30, 'Yoga');

-- --------------------------------------------------------

--
-- テーブルの構造 `user`
--

CREATE TABLE `user` (
  `id` varchar(256) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `age` int(11) NOT NULL DEFAULT 0,
  `gender` varchar(256) NOT NULL DEFAULT '',
  `preference` varchar(256) NOT NULL DEFAULT '',
  `biography` varchar(256) NOT NULL DEFAULT '',
  `profilePic` varchar(256) NOT NULL DEFAULT '',
  `isRealUser` tinyint(1) NOT NULL,
  `status` varchar(256) NOT NULL DEFAULT 'offline',
  `pic1` varchar(256) NOT NULL DEFAULT '',
  `pic2` varchar(256) NOT NULL DEFAULT '',
  `pic3` varchar(256) NOT NULL DEFAULT '',
  `pic4` varchar(256) NOT NULL DEFAULT '',
  `pic5` varchar(256) NOT NULL DEFAULT '',
  `longitude` decimal(10,6) NOT NULL DEFAULT 2.319370,
  `latitude` decimal(10,6) NOT NULL DEFAULT 48.896120,
  `match_ratio` int(11) NOT NULL DEFAULT 0,
  `fake_account` tinyint(1) NOT NULL DEFAULT 0,
  `last_active` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `user`
--

INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `isRealUser`, `status`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES
('1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'tsujimarico@gmail.com', 'Eric', 'Eric', 'Cartman', '$2b$10$Tp.qBIVSD2OZXudA/S8NY.lt9XdM3nTPfHkNJ7VXvvFdBEych14ie', 1, 30, 'male', 'female', 'Screw guys, I\'m going home', 'http://localhost:4000/uploads/eric-cartman_380.webp', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 75, 0, '2024-11-08 10:40:18'),
('3d3638e4-a5aa-4ce9-95c6-e9a4bb4b2caa', 'ruruover1105@gmail.com', 'ABC123@', 'Kobayashi', 'Ruru', '$2b$10$dNJoYchwO0uPCCeJDnUIRO4bb.ggKctS0qRhxeXmoZxyFeCysa5om', 1, 25, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('41a84720-a3e3-4970-bd74-916b34e51df8', 'ruruover1105@gmail.com', 'a', 'Kobayashi', 'Ruru-', '$2b$10$AYhZWiTiwqoQ0oM1FRxUiOfPs4bNvv7twzPNj45dqWEuxDT4UtqT2', 1, 30, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('511c3f3b-0200-4c5c-9745-8060e2403673', 'robe.de.chambre6@gmail.com', 'Arthur', 'Tutur', 'Tutur', '$2b$10$mMeyD8HTZ4pYRikmQHDcXOkOgGo0HXh46boskxN6hztxKCOnlfs6S', 1, 29, 'male', 'female', 'ca va ?', 'http://localhost:4000/uploads/5EF45C61-3F9A-4567-A7E1-978AD64C32FF.jpeg', 1, 'offline', 'http://localhost:4000/uploads/IMG_2369.jpeg', '', '', '', '', 2.319370, 48.896120, 67, 0, '2024-11-25 15:47:53'),
('55f6c362-94c2-4fdb-9bc9-5da9d463393a', 'tsujimarico@gmail.com', 'Liane', 'Cartman', 'Liane', '$2b$10$aV90iO1DubgZt2DgyzuNN.8jw1RdVeuDueGuBI4trCIoEe5JOhY66', 1, 30, 'female', 'female', 'Hello my muffin', 'http://localhost:4000/uploads/Liam_Cartman.jpg', 1, 'offline', '', '', '', '', '', 2.319370, 48.896120, 100, 0, '2024-11-25 15:45:47'),
('63fb855d-5267-4caa-a038-1a1274f67796', 'tsujimarico@gmail.com', 'Garrison', 'Garrison', 'Herbert', '$2b$10$j1lzlXI2i.IlhyQfUd2OyOlFzX8YF4YJcRhQWcEVGAv/hN3adEy6e', 1, 30, 'male', 'no', 'I\'m garrison', 'http://localhost:4000/uploads/mrgarrison.png', 1, 'online', '', '', '', '', '', 2.319370, 48.896120, 100, 0, '2024-11-25 15:43:45'),
('70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', 'ruruover1105@gmail.com', 'collis', 'collis', 'Leadford', '$2b$10$A0ARrMOo7b286GAtS37GHuIcQeI9YtlnpeTWGhfvyHYHauENE4Wwm', 1, 36, 'male', 'no', 'music is my life', 'http://localhost:4000/uploads/pexels-collis-3031391.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', '', 2.336175, 48.885805, 0, 0, NULL),
('73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'ruruover1105@gmail.com', 'Linda', 'Richard', 'Linda', '$2b$10$iOoNh3LTkwcHF9/HcX1wLO1G1YlIAwf9l7yxaRFpLtW03SEbOduMW', 1, 32, 'female', 'male', 'let\'s drink together', 'http://localhost:4000/uploads/pexels-andrea-piacquadio-733872.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 2.336149, 48.885829, 100, 0, NULL),
('750f838c-356f-4c1d-8ad2-0b4e76882595', 'ruruover1105@gmail.com', 'nitin', 'khajotia', 'nitin', '$2b$10$Dgrs9IqicLEyqlYwbRXUuencXAjJ38851foMKIZ/wEsng0Fzlk5na', 1, 40, 'male', 'male', 'be strong', 'http://localhost:4000/uploads/pexels-nitin-khajotia-1516680.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('77743911-bb39-408b-af66-d84df45d73fa', 'ruruover1105@gmail.com', 'jeffrey', 'reed', 'jeffrey', '$2b$10$TsT46xB3rKlQH1nApfWiGuDGjjyR0LmfWpdkkm.h0U3gV2VUtaftq', 1, 18, 'male', 'female', 'study math', 'http://localhost:4000/uploads/pexels-jeffrey-reed-769690.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 100, 0, NULL),
('78a685aa-07f0-4f57-9285-e35ee7c7c7aa', 'ruruover1105@gmail.com', 'ferreira', 'kamiz', 'ferreira', '$2b$10$/VCzQq3FwiwzAfb8ozfVBuGdB40kn0FxlFZ3M3sYIF.XYseOiKVXu', 1, 30, 'female', 'female', 'love', 'http://localhost:4000/uploads/pexels-kamiz-ferreira-2218786.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('8727a67e-1a50-48bb-b854-355c3ec200ea', 'ruruover1105@gmail.com', 'stephan', 'Guard', 'Stephan', '$2b$10$mMYjgSdxFG0uVcGeOePBqeL3GhiEVDo/9fZOOiZ1xeWLyuD9nP4ia', 1, 30, 'male', 'female', 'have fun', 'http://localhost:4000/uploads/stephanie-cook-NDCy2-9JhUs-unsplash.jpg', 0, 'offline', '', '', '', '', '', 2.336185, 48.885884, 0, 0, NULL),
('97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'robe.de.chambre6@gmail.com', 'spam', 'Marie', 'Marie', '$2b$10$tgYWH4V4gcYAraf1wsmCue.vbf8uzpoHXhFfeNZiC5BAdIz.imtRa', 1, 30, 'female', 'no', 'I\'m test User', 'http://localhost:4000/uploads/11_girl.png', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 67, 0, '2024-11-25 15:47:17'),
('9ec4c4ca-978b-434d-8302-b4ad68565c4c', 'ruruover1105@gmail.com', 'melo', 'italo', 'melo', '$2b$10$ZV9Gi0zu4nRZki30973SG.W0aXFLIiUO9haCBygmC4GXBGRSCU2Qe', 1, 28, 'male', 'female', 'let\'s chill', 'http://localhost:4000/uploads/pexels-italo-melo-2379005.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 2.336149, 48.885829, 0, 0, NULL),
('bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'tsujimarico@gmail.com', 'Heidi', 'Turner', 'Heidi', '$2b$10$qu0pKMWYofEdhv7ddFJvS.1fFot6UIZjWy/AbRPLUN5aaefDj78pG', 1, 30, 'female', 'male', 'Hi Eric', 'http://localhost:4000/uploads/alter-egos-heidi-turner-w-hat.png', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 50, 0, '2024-11-08 11:05:13'),
('c27c9ee4-f2f3-47b5-a33b-361916016dc1', 'ruruover1105@gmail.com', 'lucas', 'pezeta', 'lucas', '$2b$10$ic7gHvggUomiVkK27v64cOZ7jU3dnArQOkHG2lUP4UJlZ4azwRsRS', 1, 35, 'female', 'male', 'take a break', 'http://localhost:4000/uploads/pexels-lucas-pezeta-2112714.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.319370, 48.896120, 0, 0, NULL),
('e4707942-09b2-4667-a9e8-e87b75b594c7', 'ruruover1105@gmail.com', 'spencer', 'selover', 'spencer', '$2b$10$UkNeBpejAsvZlQxNbmvqt.9bTFm4dTqynLZz9VShf1Y/wZ2Uw2hnG', 1, 28, 'male', 'female', 'hello', 'http://localhost:4000/uploads/pexels-spencer-selover-775358.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 0, 1, NULL),
('e9bea5f8-453c-4715-8532-163c0c348dfb', 'tsujimarico@gmail.com', 'BigGayAl', 'BigGayAl', 'BigGayAl', '$2b$10$7Iy.pfbjgY/6oFriUzLPJOBuF1xWxwcTikw/2GXiCk9FXNkXA5dmG', 1, 30, 'male', 'male', 'Hello my sweeties', 'http://localhost:4000/uploads/biggayal.png', 1, 'offline', '', '', '', '', '', 2.319370, 48.896120, 50, 0, '2024-11-25 15:45:26'),
('ee583dd0-4da8-4b77-848f-78a515a0fc22', 'ruruover1105@gmail.com', 'Kebin', 'Edimbara', 'Kebin', '$2b$10$8SVuv2h6911KE14EKpgtJuNCb7dJdnYIWjXBjC5OyDqw2j4BcnKPO', 1, 40, 'male', 'female', 'let\'s drink beer', 'http://localhost:4000/uploads/jack-finnigan-rriAI0nhcbc-unsplash.jpg', 0, 'offline', '', '', '', '', '', -0.113968, 51.506734, 0, 0, NULL),
('efe21ca7-f46f-4c7b-b816-a9858cffced5', 'robe.de.chambre6@gmail.com', 'Mariko', 'Mariko', 'Tsuji', '$2b$10$HwEdGtB1pzLLK4GQv1Ov8uY1GF3yhMDIZASRS4Grgx79F2SqtG5ZW', 1, 34, 'female', 'male', 'Bonjour je suis mariko', 'http://localhost:4000/uploads/0126DE72-9C85-4835-8828-508A0A5291BA.jpeg', 1, 'offline', 'http://localhost:4000/uploads/1d4dbb0d-64d2-486b-88fc-745fd4432ad9.jpeg', 'http://localhost:4000/uploads/IMG_2366.jpeg', '', '', '', 2.319370, 48.896120, 25, 0, '2024-11-25 15:38:28'),
('f586f458-36ca-4396-96e1-fa2a573baa73', 'ruruover1105@gmail.com', 'Test', 'Kobayashi', 'Ruru', '$2b$10$2uIIFdtI8nEVPPZMPjzHbe1ZerFyDIxMgkgivmDOCBipXc1ZslzEO', 1, 27, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', 'ruruover1105@gmail.com', 'Heim', 'Libard', 'Heim', '$2b$10$.f5/yVVDr/.hoT9XG3HyU.yVcyRQfaWCLJEJtKqmb8O1i5U9VcSWW', 1, 26, 'male', 'female', 'nature', 'http://localhost:4000/uploads/elijah-hiett-umfpFoKxIVg-unsplash.jpg', 0, 'offline', '', '', '', '', '', 139.845830, 35.752097, 0, 0, NULL);

-- --------------------------------------------------------

--
-- テーブルの構造 `usertag`
--

CREATE TABLE `usertag` (
  `id` int(11) NOT NULL,
  `user_id` varchar(256) NOT NULL,
  `tag_id` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `usertag`
--

INSERT INTO `usertag` (`id`, `user_id`, `tag_id`) VALUES
(1, '78a685aa-07f0-4f57-9285-e35ee7c7c7aa', '26'),
(2, '78a685aa-07f0-4f57-9285-e35ee7c7c7aa', '24'),
(3, '68867222-65e4-41de-b606-d79120b88220', '26'),
(4, '68867222-65e4-41de-b606-d79120b88220', '24'),
(5, '68867222-65e4-41de-b606-d79120b88220', '27'),
(6, '750f838c-356f-4c1d-8ad2-0b4e76882595', '2'),
(7, '750f838c-356f-4c1d-8ad2-0b4e76882595', '8'),
(8, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '24'),
(9, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '29'),
(10, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '27'),
(11, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '29'),
(12, '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '24'),
(13, '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '25'),
(14, '77743911-bb39-408b-af66-d84df45d73fa', '24'),
(15, '77743911-bb39-408b-af66-d84df45d73fa', '27'),
(16, '8727a67e-1a50-48bb-b854-355c3ec200ea', '27'),
(17, '8727a67e-1a50-48bb-b854-355c3ec200ea', '29'),
(18, '8727a67e-1a50-48bb-b854-355c3ec200ea', '24'),
(19, '8727a67e-1a50-48bb-b854-355c3ec200ea', '25'),
(20, '8727a67e-1a50-48bb-b854-355c3ec200ea', '24'),
(21, '8727a67e-1a50-48bb-b854-355c3ec200ea', '27'),
(22, 'ee583dd0-4da8-4b77-848f-78a515a0fc22', '24'),
(23, 'ee583dd0-4da8-4b77-848f-78a515a0fc22', '27'),
(24, 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '27'),
(25, 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '29'),
(95, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '26'),
(96, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '28'),
(97, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '24'),
(98, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '25'),
(99, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '27'),
(100, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '29'),
(101, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '23'),
(102, '511c3f3b-0200-4c5c-9745-8060e2403673', '40'),
(103, '511c3f3b-0200-4c5c-9745-8060e2403673', '48'),
(104, '511c3f3b-0200-4c5c-9745-8060e2403673', '23'),
(105, '511c3f3b-0200-4c5c-9745-8060e2403673', '50'),
(106, '511c3f3b-0200-4c5c-9745-8060e2403673', '51'),
(116, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '24'),
(117, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '25'),
(118, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '23'),
(128, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '43'),
(129, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '42'),
(130, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '24'),
(131, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '37'),
(132, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '25'),
(133, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', '23'),
(134, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '43'),
(135, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '33'),
(136, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '47'),
(137, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '34'),
(138, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '45'),
(139, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '26'),
(140, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '49'),
(141, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '42'),
(142, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '46'),
(143, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '28'),
(144, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '39'),
(145, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '40'),
(146, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '44'),
(147, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '38'),
(148, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '24'),
(149, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '35'),
(150, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '37'),
(151, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '25'),
(152, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '50'),
(153, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '48'),
(154, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '36'),
(155, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '27'),
(156, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '29'),
(157, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '41'),
(158, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '51'),
(159, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '31'),
(160, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '32'),
(161, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '23'),
(162, '55f6c362-94c2-4fdb-9bc9-5da9d463393a', '30'),
(163, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '43'),
(164, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '33'),
(165, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '47'),
(166, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '34'),
(167, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '45'),
(168, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '26'),
(169, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '49'),
(170, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '42'),
(171, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '46'),
(172, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '28'),
(173, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '39'),
(174, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '40'),
(175, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '44'),
(176, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '38'),
(177, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '24'),
(178, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '35'),
(179, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '37'),
(180, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '25'),
(181, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '50'),
(182, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '48'),
(183, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '36'),
(184, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '27'),
(185, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '29'),
(186, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '41'),
(187, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '51'),
(188, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '31'),
(189, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '32'),
(190, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '23'),
(191, 'e9bea5f8-453c-4715-8532-163c0c348dfb', '30'),
(192, '63fb855d-5267-4caa-a038-1a1274f67796', '43'),
(193, '63fb855d-5267-4caa-a038-1a1274f67796', '33'),
(194, '63fb855d-5267-4caa-a038-1a1274f67796', '47'),
(195, '63fb855d-5267-4caa-a038-1a1274f67796', '34'),
(196, '63fb855d-5267-4caa-a038-1a1274f67796', '45'),
(197, '63fb855d-5267-4caa-a038-1a1274f67796', '26'),
(198, '63fb855d-5267-4caa-a038-1a1274f67796', '49'),
(199, '63fb855d-5267-4caa-a038-1a1274f67796', '42'),
(200, '63fb855d-5267-4caa-a038-1a1274f67796', '46'),
(201, '63fb855d-5267-4caa-a038-1a1274f67796', '28'),
(202, '63fb855d-5267-4caa-a038-1a1274f67796', '39'),
(203, '63fb855d-5267-4caa-a038-1a1274f67796', '40'),
(204, '63fb855d-5267-4caa-a038-1a1274f67796', '44'),
(205, '63fb855d-5267-4caa-a038-1a1274f67796', '38'),
(206, '63fb855d-5267-4caa-a038-1a1274f67796', '24'),
(207, '63fb855d-5267-4caa-a038-1a1274f67796', '35'),
(208, '63fb855d-5267-4caa-a038-1a1274f67796', '37'),
(209, '63fb855d-5267-4caa-a038-1a1274f67796', '25'),
(210, '63fb855d-5267-4caa-a038-1a1274f67796', '50'),
(211, '63fb855d-5267-4caa-a038-1a1274f67796', '48'),
(212, '63fb855d-5267-4caa-a038-1a1274f67796', '36'),
(213, '63fb855d-5267-4caa-a038-1a1274f67796', '27'),
(214, '63fb855d-5267-4caa-a038-1a1274f67796', '29'),
(215, '63fb855d-5267-4caa-a038-1a1274f67796', '41'),
(216, '63fb855d-5267-4caa-a038-1a1274f67796', '51'),
(217, '63fb855d-5267-4caa-a038-1a1274f67796', '31'),
(218, '63fb855d-5267-4caa-a038-1a1274f67796', '32'),
(219, '63fb855d-5267-4caa-a038-1a1274f67796', '23'),
(220, '63fb855d-5267-4caa-a038-1a1274f67796', '30'),
(221, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '51'),
(222, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '23'),
(223, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '30');

-- --------------------------------------------------------

--
-- テーブルの構造 `viewed`
--

CREATE TABLE `viewed` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `viewed_to_user_id` varchar(256) NOT NULL,
  `viewed_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `viewed`
--

INSERT INTO `viewed` (`id`, `from_user_id`, `viewed_to_user_id`, `viewed_at`) VALUES
(91, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19 00:00:00'),
(92, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19 00:00:00'),
(93, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 00:00:00'),
(94, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 00:00:00'),
(95, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20 00:00:00'),
(96, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20 00:00:00'),
(97, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23 00:00:00'),
(98, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23 00:00:00'),
(99, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '0095667e-3e81-4db3-810a-f79122dc81ff', '2024-04-24 00:00:00'),
(100, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '0095667e-3e81-4db3-810a-f79122dc81ff', '2024-04-24 00:00:00'),
(101, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-04-24 00:00:00'),
(102, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-04-24 00:00:00'),
(103, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '10a04618-9820-4ab4-abd9-98b5697421c5', '2024-04-24 00:00:00'),
(104, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '10a04618-9820-4ab4-abd9-98b5697421c5', '2024-04-24 00:00:00'),
(105, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'ef14890f-0c63-47ed-b5be-21d4490eff43', '2024-04-24 00:00:00'),
(106, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'ef14890f-0c63-47ed-b5be-21d4490eff43', '2024-04-24 00:00:00'),
(107, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '17249c28-7a44-4bc6-bf73-d5bcad2bef82', '2024-04-24 00:00:00'),
(108, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '17249c28-7a44-4bc6-bf73-d5bcad2bef82', '2024-04-24 00:00:00'),
(109, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '3096ee74-0065-49cd-a67b-e26c94d0b1ba', '2024-04-24 00:00:00'),
(110, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '3096ee74-0065-49cd-a67b-e26c94d0b1ba', '2024-04-24 00:00:00'),
(111, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '003bc2f3-bfbe-4471-86e5-a61f220c9d12', '2024-04-24 00:00:00'),
(112, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '003bc2f3-bfbe-4471-86e5-a61f220c9d12', '2024-04-24 00:00:00'),
(113, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1d35bfa2-6db1-4dc1-ac23-23cb44ff1a57', '2024-04-24 00:00:00'),
(114, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1d35bfa2-6db1-4dc1-ac23-23cb44ff1a57', '2024-04-24 00:00:00'),
(115, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '8727a67e-1a50-48bb-b854-355c3ec200ea', '2024-04-24 00:00:00'),
(116, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '8727a67e-1a50-48bb-b854-355c3ec200ea', '2024-04-24 00:00:00'),
(117, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '2024-04-24 00:00:00'),
(118, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '2024-04-24 00:00:00'),
(119, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0b39699d-9e9d-45d7-bc6e-011c36697b90', '2024-04-24 00:00:00'),
(120, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0b39699d-9e9d-45d7-bc6e-011c36697b90', '2024-04-24 00:00:00'),
(121, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0256716d-98db-462a-bc42-4f13bd7c2922', '2024-04-24 00:00:00'),
(122, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0256716d-98db-462a-bc42-4f13bd7c2922', '2024-04-24 00:00:00'),
(123, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'eb7f1e94-8865-4feb-b213-4a8a429c0bcb', '2024-04-24 00:00:00'),
(124, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'eb7f1e94-8865-4feb-b213-4a8a429c0bcb', '2024-04-24 00:00:00'),
(125, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '70b3135b-3012-45f0-94f9-665bb5538a97', '2024-04-24 00:00:00'),
(126, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '70b3135b-3012-45f0-94f9-665bb5538a97', '2024-04-24 00:00:00'),
(127, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22 00:00:00'),
(128, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22 00:00:00'),
(129, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09 00:00:00'),
(130, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09 00:00:00'),
(131, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09 00:00:00'),
(132, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09 00:00:00'),
(133, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10 00:00:00'),
(134, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10 00:00:00'),
(135, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-17 00:00:00'),
(136, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-17 00:00:00'),
(137, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-11-08 11:03:38'),
(138, 'efe21ca7-f46f-4c7b-b816-a9858cffced5', 'ee583dd0-4da8-4b77-848f-78a515a0fc22', '2024-11-08 11:43:45');

--
-- ダンプしたテーブルのインデックス
--

--
-- テーブルのインデックス `blocked`
--
ALTER TABLE `blocked`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `liked`
--
ALTER TABLE `liked`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `matched`
--
ALTER TABLE `matched`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `from_user_id` (`from_user_id`),
  ADD KEY `to_user_id` (`to_user_id`),
  ADD KEY `fk_room_id` (`room_id`);

--
-- テーブルのインデックス `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `user_id_first` (`user_id_first`),
  ADD KEY `user_id_second` (`user_id_second`);

--
-- テーブルのインデックス `room_messages`
--
ALTER TABLE `room_messages`
  ADD PRIMARY KEY (`message_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `from_user_id` (`from_user_id`);

--
-- テーブルのインデックス `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_id` (`name`);

--
-- テーブルのインデックス `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `usertag`
--
ALTER TABLE `usertag`
  ADD PRIMARY KEY (`id`);

--
-- テーブルのインデックス `viewed`
--
ALTER TABLE `viewed`
  ADD PRIMARY KEY (`id`);

--
-- ダンプしたテーブルの AUTO_INCREMENT
--

--
-- テーブルの AUTO_INCREMENT `blocked`
--
ALTER TABLE `blocked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- テーブルの AUTO_INCREMENT `liked`
--
ALTER TABLE `liked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- テーブルの AUTO_INCREMENT `matched`
--
ALTER TABLE `matched`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- テーブルの AUTO_INCREMENT `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- テーブルの AUTO_INCREMENT `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- テーブルの AUTO_INCREMENT `room_messages`
--
ALTER TABLE `room_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- テーブルの AUTO_INCREMENT `usertag`
--
ALTER TABLE `usertag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=224;

--
-- テーブルの AUTO_INCREMENT `viewed`
--
ALTER TABLE `viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- ダンプしたテーブルの制約
--

--
-- テーブルの制約 `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `fk_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`from_user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`to_user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- テーブルの制約 `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`user_id_first`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`user_id_second`) REFERENCES `user` (`id`);

--
-- テーブルの制約 `room_messages`
--
ALTER TABLE `room_messages`
  ADD CONSTRAINT `room_messages_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  ADD CONSTRAINT `room_messages_ibfk_2` FOREIGN KEY (`from_user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
