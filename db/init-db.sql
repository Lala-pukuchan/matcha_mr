-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: db:3306
-- 生成日時: 2024 年 7 月 24 日 13:38
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
(35, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22 14:25:31');

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
(8, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-07-22 14:25:31');

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
(1, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'test message', '2024-07-22 17:02:34'),
(2, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'Hi I\'m Eric', '2024-07-22 19:04:31'),
(3, 1, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'Hello Eric', '2024-07-22 19:04:41');

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
(1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273');

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
(26, 'camping'),
(28, 'fighting'),
(24, 'music'),
(25, 'piano'),
(27, 'study'),
(29, 'surf'),
(23, 'wine');

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

INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES
('003bc2f3-bfbe-4471-86e5-a61f220c9d12', 'gregory247@example.com', 'Gregory247', 'Thomas', 'Gregory', 'b20f2307f37c1f46b95d19146f5785706119f8e258056bffb8fda77f4e1c87be', 0, 39, 'male', 'female', 'Hi, I\'m Gregory Thomas, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 127.680932, 26.212401, 99, 1, NULL),
('00993433-3784-4c9c-80ac-870345c7d5a6', 'jacqueline356@example.com', 'Jacqueline356', 'Taylor', 'Jacqueline', 'b3404df0238de008c59c93768f3260f10e3f0df9468ba04a318d4ca57e0882f0', 1, 83, 'female', 'male', 'Hi, I\'m Jacqueline Taylor, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 21.011486, 52.225406, 14, 0, NULL),
('00b83920-d4bf-4969-8c78-e6a5fba5549d', 'diane484@example.com', 'Diane484', 'Williams', 'Diane', '96b86569b4ea564a40b2b74ac1068cee59f998826236bc6ad8d29e2e2452cb1b', 1, 22, 'female', 'male', 'Hi, I\'m Diane Williams, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -98.493629, 29.424122, 96, 0, NULL),
('011e1c78-fcba-4dc5-b64e-325bfb61df1d', 'christina482@example.com', 'Christina482', 'Rivera', 'Christina', 'd3ff94c15b26fbb67fff52a151f438e92d061451fba876bca90a80b35cc93383', 1, 61, 'female', 'male', 'Hi, I\'m Christina Rivera, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 4.031696, 49.258329, 33, 1, NULL),
('016da6c5-20a8-4e5a-9dcd-714374d63951', 'martha101@example.com', 'Martha101', 'Perez', 'Martha', '5c773b22ea79d367b38810e7e9ad108646ed62e231868cefb0b1280ea88ac4f0', 1, 76, 'female', 'male', 'Hi, I\'m Martha Perez, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 1.099971, 49.443232, 21, 1, NULL),
('019c1ed0-6d38-408e-ba0b-b7d5d397e691', 'margaret307@example.com', 'Margaret307', 'Garcia', 'Margaret', '53d6c1e29fd6c11778afcfeb16f13836757fc5eeee9054449394be89def27451', 1, 65, 'female', '', 'Hi, I\'m Margaret Garcia, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -121.886329, 37.338208, 53, 0, NULL),
('01c5d5ec-e619-4653-b3b8-494d0e9b2155', 'tyler73@example.com', 'Tyler73', 'Thompson', 'Tyler', 'e156770ced012a06461e24cd9a8318aae9a83acaab7b277ff104d4397e89be88', 0, 43, 'male', '', 'Hi, I\'m Tyler Thompson, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 139.829356, 35.841208, 89, 0, NULL),
('0201d327-a381-44df-810f-9a4d18ab1e67', 'nicole331@example.com', 'Nicole331', 'White', 'Nicole', 'e44ac9c3121547bd4779e4247ebc4e7110a7fafa7e2bb08e06b22c2bd0bd5088', 0, 83, 'female', 'male', 'Hi, I\'m Nicole White, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 5.369780, 43.296482, 7, 1, NULL),
('022ff74a-6932-4e86-ab00-f51445c4eab5', 'sarah481@example.com', 'Sarah481', 'Hall', 'Sarah', 'f748e0c6ddbce15c6c9299f550cb1b11a7ef8a11e708bb10f8cab851369cc4f8', 1, 89, 'female', 'male', 'Hi, I\'m Sarah Hall, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 3.057256, 50.629250, 56, 0, NULL),
('0256716d-98db-462a-bc42-4f13bd7c2922', 'betty246@example.com', 'Betty246', 'Jones', 'Betty', '5b04c6bae11dd60d65adf5ac248c93318e3764febc6aa7e082e1115bf1d626bf', 0, 28, 'female', '', 'Hi, I\'m Betty Jones, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 139.638026, 35.443708, 55, 0, NULL),
('03f5d150-f7a8-4dbb-9329-5cfc402e3e4f', 'samuel244@example.com', 'Samuel244', 'Nelson', 'Samuel', 'd48b70e3d55b878f47920f576cb9820cd501cf6cdb79b36c8b5a715c24adf96b', 1, 49, 'male', 'female', 'Hi, I\'m Samuel Nelson, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -82.998794, 39.961176, 73, 1, NULL),
('04785864-a32a-4227-8644-cc69453e588c', 'karen201@example.com', 'Karen201', 'Lewis', 'Karen', '4e697574c6e3693487942c34ff3279f02e9badfa8c7984a85b5da6e15500796f', 0, 37, 'female', 'male', 'Hi, I\'m Karen Lewis, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 130.401716, 33.590355, 99, 1, NULL),
('056a0864-72ec-4726-ace1-8687cf1cec16', 'jerry34@example.com', 'Jerry34', 'Miller', 'Jerry', '72f1ffa2d7a9c9d60c2369fffce54372eea054d567c77f8a518f4f4c06b3856a', 0, 95, 'male', 'female', 'Hi, I\'m Jerry Miller, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 7.261953, 43.710173, 73, 0, NULL),
('05eb74e7-e3fe-4b41-a104-26cd340bface', 'mary447@example.com', 'Mary447', 'Brown', 'Mary', '1fa167acb3897c75bf07787ba6b6015f4a8770fe98192c3ba30486bfb833d770', 0, 91, 'female', 'male', 'Hi, I\'m Mary Brown, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -96.796988, 32.776664, 23, 0, NULL),
('06d481dc-9663-460a-842a-cc6be52213fb', 'henry336@example.com', 'Henry336', 'Mitchell', 'Henry', '93e0da8f7f7ca607c07131341a9a4c9248194fe8b14c1cae5da0e92de275f339', 0, 41, 'male', 'female', 'Hi, I\'m Henry Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 4.402464, 51.219448, 5, 1, NULL),
('06ddbb51-0e57-49d9-a4ce-ee11c1b40c88', 'gloria433@example.com', 'Gloria433', 'Harris', 'Gloria', '1d45538b57dea3c938fa36947da196ba63d1303b6a1bc43923cea789fa7e055e', 1, 86, 'female', 'male', 'Hi, I\'m Gloria Harris, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 139.829356, 35.841208, 46, 0, NULL),
('083b6d89-4807-4890-9d13-bae7cbe7822e', 'joyce243@example.com', 'Joyce243', 'Rivera', 'Joyce', '65f0a7ff6740fc12e70ab8a4790505f8c241636b66f41261035547246bacd3db', 1, 79, 'female', 'male', 'Hi, I\'m Joyce Rivera, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 7.752111, 48.573405, 20, 1, NULL),
('08637ad9-c83d-4b3a-afaa-7fa3ee7092bd', 'alice236@example.com', 'Alice236', 'King', 'Alice', 'e7b5d6ded8878506f45842701ebf8e0beeed79d599b8e5f7f1dcad23998364b8', 0, 83, 'female', 'male', 'Hi, I\'m Alice King, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 5.369780, 43.296482, 72, 1, NULL),
('0b39699d-9e9d-45d7-bc6e-011c36697b90', 'nathan450@example.com', 'Nathan450', 'White', 'Nathan', '1ee29963737297e4eaa7d3f95993aa4f553e6f0611975372f09a8ab07dcec388', 0, 92, 'male', 'female', 'Hi, I\'m Nathan White, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 136.906398, 35.181446, 87, 0, NULL),
('0bf94c66-f13e-4ced-8ddb-ccb96eea4c40', 'joyce393@example.com', 'Joyce393', 'Garcia', 'Joyce', 'a302e4329086dad0cda1bb9965ab0408face71ead871a55fc9e05f2619c3e489', 1, 42, 'female', 'male', 'Hi, I\'m Joyce Garcia, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 133.919502, 34.655146, 18, 1, NULL),
('0caa01e0-75e7-454a-9893-a54d90b4232d', 'kyle17@example.com', 'Kyle17', 'Anderson', 'Kyle', '69bfb918de05145fba9dcee9688dfb23f6115845885e48fa39945eebb99d8527', 0, 81, 'male', 'female', 'Hi, I\'m Kyle Anderson, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 4.031696, 49.258329, 34, 0, NULL),
('0cd0681a-ff83-4696-bccc-e4db7ca0cd37', 'benjamin46@example.com', 'Benjamin46', 'Roberts', 'Benjamin', 'f7944ecca058c63c386de56353cddf278c98f3143bd4a00bb0b2015adb69ed39', 0, 58, 'male', 'female', 'Hi, I\'m Benjamin Roberts, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 132.455293, 34.385203, 70, 0, NULL),
('0d59fd63-5a36-44ba-9237-3f03ca18331f', 'laura472@example.com', 'Laura472', 'Nguyen', 'Laura', '3c4a87819a00d093209e85b27f51bc2ca59720131785cdf5229fa10909cb5b8d', 1, 37, 'female', 'male', 'Hi, I\'m Laura Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 136.656205, 36.561325, 9, 0, NULL),
('0f1b65ea-c1c7-4dcd-b042-df2c8f8cfed1', 'peter114@example.com', 'Peter114', 'Gonzalez', 'Peter', 'b9017426fea49b27d2d258db21d76dc99596b297493132bbe1829c98a4b33cc4', 0, 40, 'male', 'female', 'Hi, I\'m Peter Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -81.655651, 30.332184, 72, 0, NULL),
('0f319ff4-228a-4684-b452-d72f256d026f', 'raymond44@example.com', 'Raymond44', 'Johnson', 'Raymond', 'f9d07093d0de736c8881640c3e55714bebd5faf5d6ebbfb41e486e1660c8fc0e', 1, 31, 'male', 'female', 'Hi, I\'m Raymond Johnson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 139.829356, 35.841208, 70, 0, NULL),
('0f7d37ff-f0f1-4a36-8f79-ef40d707c88e', 'cynthia413@example.com', 'Cynthia413', 'Moore', 'Cynthia', 'b4398fe430be3daedd5bf60f8f6da7e6396495340c1bbdeccb8cebc69ef9d223', 0, 97, 'female', 'male', 'Hi, I\'m Cynthia Moore, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 7.752111, 48.573405, 23, 1, NULL),
('0f93ec95-fc03-433b-b624-571c5bf419e9', 'william365@example.com', 'William365', 'Johnson', 'William', '0f6af9c589ec047d80603a60c64d38c300cd36048219cc261691a2b6fe603453', 1, 41, 'male', '', 'Hi, I\'m William Johnson, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 5.369780, 43.296482, 14, 1, NULL),
('107c0908-4302-4c51-b56e-6617ea5a2fd6', 'kelly137@example.com', 'Kelly137', 'Miller', 'Kelly', '5246cce8a20f2dd8b319bad141b67a3618d264fd8a1007410a94b15f3ea44df7', 1, 88, 'female', 'male', 'Hi, I\'m Kelly Miller, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -98.493629, 29.424122, 25, 1, NULL),
('11005380-8ab0-48e6-a38e-715431b9638d', 'douglas454@example.com', 'Douglas454', 'Anderson', 'Douglas', '497c091097a384c38f17a586bcf31195dd0f987a7969e6f6878d432904235608', 0, 32, 'male', 'female', 'Hi, I\'m Douglas Anderson, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 135.502165, 34.693738, 74, 0, NULL),
('11d5087b-3e38-4316-86c0-e883f1ed9f5e', 'andrew388@example.com', 'Andrew388', 'Davis', 'Andrew', 'ba0160242f2100fb18dadfedd3c0b43a8f279c5c47a4ed09da1a892af8f200dc', 1, 47, 'male', 'male', 'Hi, I\'m Andrew Davis, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 135.768029, 35.011636, 7, 1, NULL),
('12e7410c-3385-4688-a263-cbeb8dadba0c', 'thomas71@example.com', 'Thomas71', 'Baker', 'Thomas', 'c4f0ad5f4a97c4ba3bc11f6d661db99bcc08cd3121e329363c7155984a0c7328', 1, 40, 'male', 'female', 'Hi, I\'m Thomas Baker, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 3.057256, 50.629250, 75, 1, NULL),
('13476f0b-762c-4000-a660-c7e771e7fc95', 'kevin105@example.com', 'Kevin105', 'Nguyen', 'Kevin', 'bb10f0c847be9e4cd43dca85e1e42763e357207c04598a082f276f8b7a36c8f7', 0, 71, 'male', 'female', 'Hi, I\'m Kevin Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 136.906398, 35.181446, 10, 0, NULL),
('136155b0-9e61-47c9-8353-74413a78c314', 'eric209@example.com', 'Eric209', 'Mitchell', 'Eric', 'c24ededb604746f61e8df8f6bfdc08664c29f8aed0aab8e06414da6aae07e7df', 1, 61, 'male', 'female', 'Hi, I\'m Eric Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -0.579180, 44.837789, 3, 0, NULL),
('142ae4c1-805a-419a-be2e-2a799e904fa8', 'richard297@example.com', 'Richard297', 'Roberts', 'Richard', '8b7e87869d0d4b42ea2f33817c84cb38d3739fc436ef9d069e1d17ab34b8d6db', 1, 72, 'male', 'female', 'Hi, I\'m Richard Roberts, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -118.243683, 34.052235, 83, 1, NULL),
('143b3da7-4031-4fd0-befa-9de8bc160285', 'daniel200@example.com', 'Daniel200', 'Sanchez', 'Daniel', 'e9a598c9884b2b4cc953d634b504b80692a42abbfda07e11f695582d58b04d1b', 0, 65, 'male', 'male', 'Hi, I\'m Daniel Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 4.031696, 49.258329, 68, 0, NULL),
('1452f3c9-eabf-4e67-8654-ef78f339909a', 'jack234@example.com', 'Jack234', 'Perez', 'Jack', '93ff4d79302417d6912b8c2620c1a5fcb8dbe305c1a351a8f3cd7560e3f4d4f2', 1, 34, 'male', 'female', 'Hi, I\'m Jack Perez, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -112.074037, 33.448377, 96, 1, NULL),
('14fdd975-62d2-4038-8add-9c67a098e430', 'nathan260@example.com', 'Nathan260', 'Adams', 'Nathan', '0e83e2961b15c8b105b435c1a14142e0e146c42b73e5d60719a8142455d7fdf1', 0, 54, 'male', 'female', 'Hi, I\'m Nathan Adams, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -98.493629, 29.424122, 25, 0, NULL),
('151ba97f-b08e-4271-bb69-177e0a23b88e', 'terry146@example.com', 'Terry146', 'Sanchez', 'Terry', '4872a853626492ff72109012c9110e97f1100437e595100c74ca04cb4d6bf526', 0, 81, 'male', 'female', 'Hi, I\'m Terry Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 7.752111, 48.573405, 54, 0, NULL),
('15fab44c-a98b-46d4-b48f-cd7708234bec', 'terry164@example.com', 'Terry164', 'Green', 'Terry', '47ff280e0bd430c979d828dd3a5a07749603b73233c5f0f418d6364b1431412f', 0, 83, 'male', 'female', 'Hi, I\'m Terry Green, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -81.655651, 30.332184, 10, 1, NULL),
('16ad81e7-2b05-47d6-a70d-167719658d0f', 'matthew198@example.com', 'Matthew198', 'Lee', 'Matthew', 'ac865eea92919e90a7b00df59f08ecb59bb4efa29f175059f0338df27c775b6e', 0, 44, 'male', 'female', 'Hi, I\'m Matthew Lee, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 3.057256, 50.629250, 72, 1, NULL),
('16f55af2-0d2b-4fee-a930-d63e479d68d8', 'kathryn360@example.com', 'Kathryn360', 'Walker', 'Kathryn', '113595dd1d777275bcd55c366620e807baa6523da61dea3e7d8b4e132af343e4', 0, 34, 'female', 'male', 'Hi, I\'m Kathryn Walker, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 141.354376, 43.062096, 20, 0, NULL),
('17249c28-7a44-4bc6-bf73-d5bcad2bef82', 'kelly469@example.com', 'Kelly469', 'Gonzalez', 'Kelly', '1ecf65b3ee740b4bccd018560b9e56519bb83293a9115f1d8e681dfbda3d46e7', 0, 82, 'female', 'female', 'Hi, I\'m Kelly Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -0.108740, 51.509897, 11, 1, NULL),
('19b53635-7018-406f-8616-561fad5a5ee4', 'zachary476@example.com', 'Zachary476', 'Rodriguez', 'Zachary', '20d2176b10fe55b65aa80bb7c8ba8ed26f59982401af1606aded2bc41a2f2ed9', 1, 74, 'male', 'female', 'Hi, I\'m Zachary Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 139.638026, 35.443708, 38, 0, NULL),
('19c791dc-b9c8-4056-b71e-220c4bb6ee95', 'frank151@example.com', 'Frank151', 'Davis', 'Frank', '9bbb50179d8b0770184054e69fc1693b0920694593c623fa98d1175448883d49', 0, 68, 'male', 'female', 'Hi, I\'m Frank Davis, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -122.419416, 37.774929, 72, 1, NULL),
('1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'tsujimarico@gmail.com', 'Eric', 'Eric', 'Cartman', '$2b$10$Tp.qBIVSD2OZXudA/S8NY.lt9XdM3nTPfHkNJ7VXvvFdBEych14ie', 1, 20, 'male', 'female', 'Screw guys, I\'m going home', 'http://localhost:4000/uploads/eric-cartman_380.webp', '', '', '', '', '', 2.319370, 48.896120, 100, 0, NULL),
('1a80aa5a-5403-45d1-80f0-528b3eefdac0', 'janet319@example.com', 'Janet319', 'Smith', 'Janet', '6f354365303d8fe34fbd64442362abc0a22bb14b29ba60962d2cabc5c765fcd6', 0, 97, 'female', 'male', 'Hi, I\'m Janet Smith, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 7.261953, 43.710173, 47, 0, NULL),
('1a8ddbc6-d5d4-40bb-be59-c8ebff6c6ea0', 'olivia375@example.com', 'Olivia375', 'Clark', 'Olivia', '08dfd7ab528c71b892487c2de261845a141687bc6d7d72ffe1fac6a22bb3ee59', 1, 22, 'female', 'male', 'Hi, I\'m Olivia Clark, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -5.984459, 37.389092, 95, 1, NULL),
('1afc5f34-93c6-4630-afba-637d89e65620', 'sharon149@example.com', 'Sharon149', 'Moore', 'Sharon', 'da6a634892307a507197dbb469069547cb35e45d38b23e154197027afcde091f', 0, 19, 'female', 'male', 'Hi, I\'m Sharon Moore, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 3.057256, 50.629250, 30, 0, NULL),
('1b0e659a-9d14-425d-aef3-b89a24652beb', 'jason315@example.com', 'Jason315', 'Campbell', 'Jason', '7bf6f852b82fecbad3ea9d6aa32572df3b07ae7a722a3b677ea876655ea21401', 0, 84, 'male', 'female', 'Hi, I\'m Jason Campbell, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 135.502165, 34.693738, 92, 1, NULL),
('1b2fd45a-77f5-48fa-b112-c9fb2799707e', 'tsujimarico@gmail.com', 'mariko', 'mariko', 'mariko', '$2b$10$vybdSVFPBLqs3dJC7NsIRuuswS4dL/6dXjf04dMcdBqRKgfvO5hcW', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('1b5e71e0-fbaf-40cc-85b2-e138daf6196b', 'christine332@example.com', 'Christine332', 'Rivera', 'Christine', 'c72b6bb122f78c06fbae395583e45ec46a007e787bbbc8b82e9118c69caee49a', 1, 31, 'female', 'male', 'Hi, I\'m Christine Rivera, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 4.031696, 49.258329, 64, 0, NULL),
('1bc26604-cba2-4053-b4db-01804960b707', 'brian35@example.com', 'Brian35', 'Torres', 'Brian', '5bd40f88c4a6b2c20256389878ec2b59515ca478eb3eb0f3673663273bcb639b', 0, 76, 'male', 'female', 'Hi, I\'m Brian Torres, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -82.998794, 39.961176, 65, 0, NULL),
('1bcc6831-0ded-49d9-9597-3e715a701ec8', 'carolyn165@example.com', 'Carolyn165', 'Green', 'Carolyn', '76be687ec273bc118d1e04a262aba9317d4e1bec72ce347625bab8826b80c62f', 0, 60, 'female', '', 'Hi, I\'m Carolyn Green, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -98.493629, 29.424122, 36, 0, NULL),
('1c78b69f-ad70-47fe-a972-04c1d4a3106b', 'pamela376@example.com', 'Pamela376', 'Nelson', 'Pamela', 'df798e0f4e851362525ff4194ec5d725dc98b5fda392be907f2984ba05de47ea', 0, 76, 'female', 'male', 'Hi, I\'m Pamela Nelson, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 4.835659, 45.764043, 32, 1, NULL),
('1cedf7ae-bc7e-4a18-acfa-2c8b08310cb6', 'patricia422@example.com', 'Patricia422', 'Rivera', 'Patricia', '4da0ca23b1c3a887c8a1437184b3bd334033d858ce5892145ff1f05c2ad04e02', 1, 84, 'female', 'male', 'Hi, I\'m Patricia Rivera, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 7.752111, 48.573405, 29, 0, NULL),
('1d05ec4a-e444-469e-850c-5e8129f8129e', 'benjamin343@example.com', 'Benjamin343', 'Johnson', 'Benjamin', 'a92c140f3ee2eda5d83ed575e2d3792f1d5d11476d518a5824fb0a74e2e0ce98', 1, 60, 'male', 'male', 'Hi, I\'m Benjamin Johnson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -75.165222, 39.952584, 75, 0, NULL),
('1d35bfa2-6db1-4dc1-ac23-23cb44ff1a57', 'george490@example.com', 'George490', 'Roberts', 'George', '5ad95e675ccdf4209cdd94a0af9f165f584637b4b9902984ab326fda9cf393eb', 0, 91, 'male', 'female', 'Hi, I\'m George Roberts, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -98.493629, 29.424122, 94, 0, NULL),
('1d4c19b4-c89d-4545-a654-a9de528b1930', 'martha169@example.com', 'Martha169', 'Flores', 'Martha', '9c7db31d09b8f1c9402e6a2c8c3d08a469425475d2fc6d80f8698061dae73d92', 1, 82, 'female', 'male', 'Hi, I\'m Martha Flores, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -87.629799, 41.878113, 30, 0, NULL),
('1f05d06f-b488-40e0-955c-3f2721f645a7', 'rebecca69@example.com', 'Rebecca69', 'Mitchell', 'Rebecca', '7109b84353bb31d935391d9294fe71155d9e618e1273b2f1531e912318610f60', 0, 62, 'female', 'male', 'Hi, I\'m Rebecca Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 4.835659, 45.764043, 83, 0, NULL),
('1f5dfa51-8ac5-429f-8547-07061eaf50ab', 'terry384@example.com', 'Terry384', 'Martinez', 'Terry', 'fa5523959ec698437ff4bc031b4b7405e357dd5a50d8a35be7f487b7d3101053', 1, 24, 'male', '', 'Hi, I\'m Terry Martinez, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 4.402464, 51.219448, 82, 1, NULL),
('1f99e7b4-af8b-4674-90aa-a4cb14a4a01c', 'betty31@example.com', 'Betty31', 'King', 'Betty', 'a4239ae1725466d26621f102d58c1541c84ff1142f4341c7b66be92e32396d45', 0, 72, 'female', 'male', 'Hi, I\'m Betty King, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -74.005974, 40.712776, 39, 0, NULL),
('1fd6b01a-3acf-45d9-8868-ee0211a3f90d', 'john478@example.com', 'John478', 'Sanchez', 'John', '471ce83d4c6bac3bdee762affbfcf06762566c2f19d758f18259cd1b7d066183', 0, 65, 'male', '', 'Hi, I\'m John Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -1.553621, 47.218371, 58, 1, NULL),
('1ff45d5b-f807-4825-a663-c21a6c686b14', 'charles11@example.com', 'Charles11', 'Clark', 'Charles', '53d453b0c08b6b38ae91515dc88d25fbecdd1d6001f022419629df844f8ba433', 1, 99, 'male', 'female', 'Hi, I\'m Charles Clark, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 139.829356, 35.841208, 78, 0, NULL),
('2035888f-f4e1-4b2d-b7ff-f02b52eb8982', 'john133@example.com', 'John133', 'Green', 'John', '8ec4150249673d68cdde05f8d364578e69878cc21f98205024403e68df7809f5', 0, 60, 'male', '', 'Hi, I\'m John Green, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 3.087025, 45.777222, 60, 0, NULL),
('239acb7f-cad1-4a5b-9dbb-d46acdfebfa8', 'kelly284@example.com', 'Kelly284', 'Lewis', 'Kelly', '955f60f12cffb5a942eda2b69d7cc312d216febfad3e80e00192c49a801f1b9b', 1, 81, 'female', 'male', 'Hi, I\'m Kelly Lewis, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 136.906398, 35.181446, 36, 1, NULL),
('23dc9f8c-bd9f-4c1e-8f59-0ac49a724e5d', 'austin253@example.com', 'Austin253', 'Gonzalez', 'Austin', '92ff640f693ad2e8c1884b6f19014386e6db613e3a2ee524cb93249320987cbe', 1, 26, 'male', 'female', 'Hi, I\'m Austin Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -4.486076, 48.390394, 44, 0, NULL),
('24ef05d2-268d-4209-98b4-4f480fe9bb5f', 'helen176@example.com', 'Helen176', 'Allen', 'Helen', '72d3f89ba93cb1e40a5811d2b6605bbd59d95bb046715f15ba8c1fc26219b4ce', 1, 59, 'female', 'male', 'Hi, I\'m Helen Allen, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', -95.369804, 29.760427, 34, 0, NULL),
('24f494a2-7e86-48bb-92c6-5ea89c658596', 'andrew467@example.com', 'Andrew467', 'Scott', 'Andrew', 'e0f3071c7dbb435b4c45852063960c8a40608cb58f4c476cf090df90224da516', 1, 89, 'male', 'female', 'Hi, I\'m Andrew Scott, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 3.057256, 50.629250, 26, 1, NULL),
('255a31ea-6081-4615-9c72-a207a90bae52', 'robert115@example.com', 'Robert115', 'Allen', 'Robert', 'c5b0eb31b1858c5768899883986d251cef6edfc2555e231f0dec7a7d16fbfa99', 1, 57, 'male', 'female', 'Hi, I\'m Robert Allen, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 135.768029, 35.011636, 53, 0, NULL),
('2650096d-797a-4ff0-8a65-7122921f6b71', 'jerry89@example.com', 'Jerry89', 'Smith', 'Jerry', 'e2498760a6015150f28936de701f73a4fc8797cfcdfdde37bfc5d2e1d377eef9', 0, 45, 'male', 'female', 'Hi, I\'m Jerry Smith, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -117.161084, 32.715738, 11, 0, NULL),
('270d3964-805f-4bc2-8c15-1b1b3c4108b3', 'austin477@example.com', 'Austin477', 'Johnson', 'Austin', '07e4d07c2f3cbf2c2e8f1f023e76bfc009af9fd79e7e84a4291ff6df0cb0b318', 0, 58, 'male', 'female', 'Hi, I\'m Austin Johnson, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 4.031696, 49.258329, 56, 0, NULL),
('27a1ae2a-9e86-4178-8581-43872713ca51', 'samantha372@example.com', 'Samantha372', 'Smith', 'Samantha', 'd67858210c83bf9012b5ffc3eda61647dad1e49adb1af507aa9fd74ce91738f5', 1, 47, 'female', '', 'Hi, I\'m Samantha Smith, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 140.869356, 38.268215, 39, 1, NULL),
('27b77193-07f7-4af6-825e-0d6a2e01f44b', 'brandon250@example.com', 'Brandon250', 'Taylor', 'Brandon', '726dd218523b90b195e16ee962a1a0001b297284a8b49fed235a0490b8f71d1e', 1, 93, 'male', 'female', 'Hi, I\'m Brandon Taylor, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', -5.984459, 37.389092, 66, 1, NULL),
('27e42f11-7b9e-40ef-ba20-f5ddfd1544e2', 'alexander33@example.com', 'Alexander33', 'Green', 'Alexander', 'ee13b7d4c8c0595dcabf6016290d65d8a50163569368db690595d5acaa5a168b', 0, 60, 'male', 'female', 'Hi, I\'m Alexander Green, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 1.099971, 49.443232, 41, 1, NULL),
('2865c5c9-8178-4075-be7e-21c0fde334d4', 'samantha363@example.com', 'Samantha363', 'Taylor', 'Samantha', 'e7e9e3a2efeec78362649bf2368fee3d6ce233d7d4a7f57f465a5e30d8e7e27d', 0, 49, 'female', '', 'Hi, I\'m Samantha Taylor, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -87.629799, 41.878113, 2, 0, NULL),
('291f62aa-d3cb-41ff-b0b3-1c289ec0dd44', 'noah316@example.com', 'Noah316', 'Lopez', 'Noah', '3f96201c59aba8d95f776105a88f4c7f46af190d328a8bc2d404031d0c7ddafd', 1, 28, 'male', 'female', 'Hi, I\'m Noah Lopez, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 130.557116, 31.596554, 37, 0, NULL),
('29c81fc5-b2ff-4066-901f-7c35b99966af', 'james347@example.com', 'James347', 'Garcia', 'James', '93500366f802487147a40177543f552f50d2909f79e4e927ef91d573e2a3f623', 0, 100, 'male', 'female', 'Hi, I\'m James Garcia, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 21.011486, 52.225406, 19, 1, NULL),
('2a80a812-f052-4104-8c1d-7d8ec3b724a3', 'hannah204@example.com', 'Hannah204', 'Taylor', 'Hannah', '5781c91a7f022f6b146981a13b2e1db3e2681b6374af6215038bd54a38f9b44c', 1, 59, 'female', 'male', 'Hi, I\'m Hannah Taylor, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 135.502165, 34.693738, 89, 0, NULL),
('2c01ec2b-7e60-4482-ab69-9088821443db', 'robert458@example.com', 'Robert458', 'Baker', 'Robert', 'f5f781dae7408ec717e77026492f5cd2eaed80756896370d78183a10f45affe1', 1, 96, 'male', 'female', 'Hi, I\'m Robert Baker, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 2.298280, 48.875312, 65, 0, NULL),
('2cf545fd-1d2c-4a36-b95a-b82c0de3d78d', 'frances157@example.com', 'Frances157', 'Lee', 'Frances', 'a330d64954e86d7bff4308548189dbebd937ad3fabc7d5ca4c9d7d9ec8ecb3f9', 0, 47, 'female', 'male', 'Hi, I\'m Frances Lee, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 1.099971, 49.443232, 55, 1, NULL),
('2d9b3f69-85ff-4e46-b32e-56c3e4d750ff', 'sean301@example.com', 'Sean301', 'White', 'Sean', 'a97d2d342cb484808da12a92cecad2534420c059c2ad5e286c21d533e74767a4', 1, 54, 'male', 'female', 'Hi, I\'m Sean White, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 5.369780, 43.296482, 62, 1, NULL),
('2e1f8ec9-8396-47fe-aba0-dc4040099761', 'arthur113@example.com', 'Arthur113', 'Harris', 'Arthur', 'aea8daf3a148ce45e76153ed649274b763a59ca0ef9236215bdcf1cfce4f2038', 1, 35, 'male', 'female', 'Hi, I\'m Arthur Harris, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', -118.243683, 34.052235, 26, 0, NULL),
('2e975394-96e1-4b7d-8244-66e5c48a65ff', 'jack123@example.com', 'Jack123', 'Gonzalez', 'Jack', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1, 36, 'male', 'female', 'Hi, I\'m Jack Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 138.388475, 34.971855, 69, 0, NULL),
('3096ee74-0065-49cd-a67b-e26c94d0b1ba', 'emily3@example.com', 'Emily3', 'Taylor', 'Emily', '5906ac361a137e2d286465cd6588ebb5ac3f5ae955001100bc41577c3d751764', 1, 45, 'female', 'female', 'Hi, I\'m Emily Taylor, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -4.486076, 48.390394, 76, 1, NULL),
('30e71bda-64d2-4234-8e1b-5d78b42cc4d7', 'julie415@example.com', 'Julie415', 'Lee', 'Julie', 'd785d59c5f8020e0eab194b76578233dbaf71bb10eb65e6265107ba6a6c68240', 1, 94, 'female', 'male', 'Hi, I\'m Julie Lee, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 7.261953, 43.710173, 61, 0, NULL),
('30efa239-4a1d-426f-8369-4d0392d8b2f0', 'ashley282@example.com', 'Ashley282', 'Nelson', 'Ashley', '5ab7caa69a434c5de62282ae244a1b9163c48281febe8b636bff85a11b3f87f4', 1, 87, 'female', 'male', 'Hi, I\'m Ashley Nelson, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -5.984459, 37.389092, 98, 0, NULL),
('312b6032-9958-45b7-930a-2867a101453f', 'terry323@example.com', 'Terry323', 'King', 'Terry', '2b87abd215c673396b53ca362a3268bdd524da945c942bf1d25cfd370c113ad7', 0, 30, 'male', '', 'Hi, I\'m Terry King, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -75.165222, 39.952584, 54, 0, NULL),
('312b666d-8b30-4e61-b383-cabfa6211fd0', 'michael325@example.com', 'Michael325', 'Sanchez', 'Michael', '98bb8874d267a22df94b4494d4c67c5456d84df9859025c6f3dfea9795929545', 0, 25, 'male', 'female', 'Hi, I\'m Michael Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -122.419416, 37.774929, 33, 1, NULL),
('313a2e2b-f903-4bcf-b1f4-567280656b0b', 'debra424@example.com', 'Debra424', 'Rivera', 'Debra', 'c804aa61727576c6efec4c91afe9eaaf28fe7795c705d21352739596e3a53897', 0, 98, 'female', 'male', 'Hi, I\'m Debra Rivera, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 15.063146, 45.079574, 12, 0, NULL),
('3181c0a5-80d9-4f9d-9870-f3fd52095801', 'anna206@example.com', 'Anna206', 'Perez', 'Anna', '77a3e31211f30c72e0a2307172b93a4abd354f03862daabe24a50b6bc678a43f', 0, 20, 'female', 'male', 'Hi, I\'m Anna Perez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 1.099971, 49.443232, 1, 1, NULL),
('323913ea-7f5a-4d23-bfef-f4731a86b610', 'judith138@example.com', 'Judith138', 'Rodriguez', 'Judith', 'e91302d3e7967b6f929769177a2239136805d840984767f98be1adbd4c879da1', 0, 93, 'female', 'male', 'Hi, I\'m Judith Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -112.074037, 33.448377, 88, 0, NULL),
('34300572-0aef-4a7b-8457-335b65a16214', 'henry374@example.com', 'Henry374', 'Jones', 'Henry', '04085aa4e78d600dcdab0ebddcd86a3f4c11b49f141a0bd945b9cda09f6e5f22', 1, 82, 'male', 'female', 'Hi, I\'m Henry Jones, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 141.354376, 43.062096, 85, 0, NULL),
('3549244e-71bb-4cfc-8904-be3c71176948', 'douglas361@example.com', 'Douglas361', 'Carter', 'Douglas', '05b4a629a16045837c62cc9cef06538f7fbf1c6f013b5c9368bb5fc6921f17b2', 1, 31, 'male', 'female', 'Hi, I\'m Douglas Carter, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -82.998794, 39.961176, 10, 1, NULL),
('35b8ea88-233f-47ec-8283-14295b801ed2', 'debra111@example.com', 'Debra111', 'Thomas', 'Debra', '19cb0711df0a5c9915c57bc8209b23da7b9ecae22627bc957eb25bcf53182a81', 0, 71, 'female', 'male', 'Hi, I\'m Debra Thomas, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 1.099971, 49.443232, 75, 1, NULL),
('35bc0bce-65db-4121-b5ea-dec4c011459b', 'kyle288@example.com', 'Kyle288', 'Wilson', 'Kyle', 'f15799ce0286d93d92f09de0731b10a7b7d218b8f6e8353beecf95c86261fcea', 1, 65, 'male', 'female', 'Hi, I\'m Kyle Wilson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -0.579180, 44.837789, 24, 0, NULL),
('362c216f-62f6-4d42-9667-93be7071c996', 'elizabeth309@example.com', 'Elizabeth309', 'Garcia', 'Elizabeth', '486570ec83fbd60b970d6455ac9b3d4777afd7cd6a0754a1c989419e4719f02e', 1, 41, 'female', 'male', 'Hi, I\'m Elizabeth Garcia, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -95.369804, 29.760427, 87, 0, NULL),
('36fde8f6-e37b-445d-a30e-47bcd0102fb3', 'joan58@example.com', 'Joan58', 'Roberts', 'Joan', '5613bf613df8da20ca171ba2110c3b2558506e8e0af57891dcf0c056f41b7718', 1, 38, 'female', 'female', 'Hi, I\'m Joan Roberts, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', -1.558626, 43.483152, 72, 1, NULL),
('373be787-b051-4a97-9a57-8701fba13d24', 'nicole129@example.com', 'Nicole129', 'Sanchez', 'Nicole', '1cf4314ed60f4e34ec6376a4f82ace4cd4faa7133552bd244bb129f73f3e4371', 1, 85, 'female', 'male', 'Hi, I\'m Nicole Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 3.717424, 51.054342, 0, 0, NULL),
('3910a8f6-5181-4a51-85fc-aabed118eead', 'rachel390@example.com', 'Rachel390', 'Johnson', 'Rachel', 'd9f8af1fb1b612158de3510408defa029cf893354174564faa954aad1d96b024', 1, 81, 'female', 'male', 'Hi, I\'m Rachel Johnson, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -74.005974, 40.712776, 38, 0, NULL),
('39444939-0350-40da-9d92-adf982948d13', 'raymond191@example.com', 'Raymond191', 'Miller', 'Raymond', '2643c17cade533e41409cbd5ada38df3b5490f14c54a53841e21e0113bb2c6c7', 0, 60, 'male', 'female', 'Hi, I\'m Raymond Miller, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 139.036413, 37.916192, 58, 0, NULL),
('395a87c8-9fb3-4a6b-9094-77cb1f59a7d0', 'betty381@example.com', 'Betty381', 'Moore', 'Betty', '55c736de37e1c1141a9b6f75f0bdc6a60d320d8978d2b551308ffdec690bef82', 1, 86, 'female', 'male', 'Hi, I\'m Betty Moore, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 7.261953, 43.710173, 98, 1, NULL),
('3986a0fa-fd0c-4d74-82d7-225bb10b7b56', 'jeremy349@example.com', 'Jeremy349', 'Miller', 'Jeremy', '218c002d2c9fd00fc6ad673e4a3426f6dde8553743198e320db7d43b608cf218', 1, 88, 'male', 'female', 'Hi, I\'m Jeremy Miller, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 136.656205, 36.561325, 16, 1, NULL),
('39f02aff-9291-421f-a4d2-63cba455af88', 'rachel170@example.com', 'Rachel170', 'Hall', 'Rachel', '0949bd843003e28c2714d7404dc0177b607e5ed5e9c6273cb9fc4cd8fed8abbe', 1, 54, 'female', 'male', 'Hi, I\'m Rachel Hall, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -122.419416, 37.774929, 82, 0, NULL),
('39fa15c1-b9fc-4702-bfd0-7cfb914fef4a', 'sean451@example.com', 'Sean451', 'Martinez', 'Sean', '1efd537673c3ceded2afeadb073f536f4ccf3a899c681f6422c9064ea1c1ad80', 0, 44, 'male', 'male', 'Hi, I\'m Sean Martinez, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 135.768029, 35.011636, 85, 1, NULL),
('3a0a376c-86fa-4a63-8bca-51e3dc7af107', 'emma354@example.com', 'Emma354', 'Anderson', 'Emma', '29d52472d0876c69d461af508c0c916cfd8c800e76deae6d10dbc084e034a80f', 0, 99, 'female', 'male', 'Hi, I\'m Emma Anderson, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 139.638026, 35.443708, 58, 0, NULL),
('3a85a884-d10f-40c9-929c-dfb2be5a2ebf', 'ann19@example.com', 'Ann19', 'Allen', 'Ann', '5790ac3d0b8ae8afc72c2c6fb97654f2b73651c328de0a3b74854ade562dd17a', 1, 83, 'female', 'male', 'Hi, I\'m Ann Allen, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -112.074037, 33.448377, 69, 0, NULL),
('3b103bba-a698-4899-9d08-74cdc45b2c88', 'ryan492@example.com', 'Ryan492', 'Mitchell', 'Ryan', '00b80021aa7daba081fc4e8c7df410c457c65f35f3d5151b185ebf2ec2e53333', 0, 64, 'male', 'female', 'Hi, I\'m Ryan Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -95.369804, 29.760427, 20, 0, NULL),
('3b222ddb-3b73-442c-8fb2-f696e2e8e5e2', 'richard91@example.com', 'Richard91', 'Wilson', 'Richard', 'a008bcb423edd46dd39bf5633677d70d7e92f05295fa94ad86d67ad5a97fa4a7', 1, 83, 'male', 'female', 'Hi, I\'m Richard Wilson, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 1.444209, 43.604652, 10, 0, NULL),
('3b2907fb-36bd-4901-a181-b41b8d125fdc', 'kyle285@example.com', 'Kyle285', 'Robinson', 'Kyle', '926e984e460cb11403634d29e6a1ed17eef1ad055cc7c4a91e1b78059d990b69', 1, 35, 'male', 'female', 'Hi, I\'m Kyle Robinson, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 1.099971, 49.443232, 67, 0, NULL),
('3bb0e724-2cfd-426b-803c-8e679ba366d8', 'arthur268@example.com', 'Arthur268', 'Hernandez', 'Arthur', 'e7e91ac7bda8d5747c5814e62fe2914c61a1bde7081620ef7c0f23d3e0a8db46', 0, 25, 'male', 'female', 'Hi, I\'m Arthur Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 13.402720, 52.517251, 31, 0, NULL),
('3d3638e4-a5aa-4ce9-95c6-e9a4bb4b2caa', 'ruruover1105@gmail.com', 'ABC123@', 'Kobayashi', 'Ruru', '$2b$10$dNJoYchwO0uPCCeJDnUIRO4bb.ggKctS0qRhxeXmoZxyFeCysa5om', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('3f3ea686-8b2a-4ef8-bd74-6c972c1b4ba2', 'rebecca379@example.com', 'Rebecca379', 'Hill', 'Rebecca', '23c9c26ab0b4edfc7b6fd3456a57a613092977d5cc48ba992d4571b07e43244d', 1, 22, 'female', 'female', 'Hi, I\'m Rebecca Hill, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -96.796988, 32.776664, 63, 0, NULL),
('3f5d2c14-a80c-4ef0-a1f4-20920b430507', 'linda416@example.com', 'Linda416', 'Ramirez', 'Linda', '35ac42835a4e9931ec4457d0551db565f6a1de75870c0b05666113e6b7262542', 1, 20, 'female', 'male', 'Hi, I\'m Linda Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 15.063146, 45.079574, 45, 0, NULL),
('3fa6cadc-4701-42a4-8f8b-d361556c2222', 'arthur394@example.com', 'Arthur394', 'Campbell', 'Arthur', 'ecda9ac1c612d393ec8e7a693de432954be460a92e8b106e2a90e2f105c04c9c', 1, 34, 'male', 'female', 'Hi, I\'m Arthur Campbell, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 136.656205, 36.561325, 85, 0, NULL),
('3fddef84-c264-467b-8404-b6cfddd1a36e', 'jacqueline220@example.com', 'Jacqueline220', 'Robinson', 'Jacqueline', '1c75f4aac31e15b1396467bc13060150906e6fb1b997b121c4936f2e1a50f943', 0, 31, 'female', 'male', 'Hi, I\'m Jacqueline Robinson, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 136.906398, 35.181446, 16, 1, NULL),
('4008e7f8-04a4-486f-bf61-f1529945ec01', 'brandon245@example.com', 'Brandon245', 'King', 'Brandon', 'ad2ed5a48a1bd0f3c93721247fd8e73fc7b04a74b399e77f49d430b10d826bc8', 1, 53, 'male', 'female', 'Hi, I\'m Brandon King, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -0.108740, 51.509897, 22, 1, NULL),
('4030d24e-b72b-4991-8239-25c450e13e66', 'noah47@example.com', 'Noah47', 'Jackson', 'Noah', '7ff9543ea5b226aeb9dcbf13672c32e62623e70edc4177512b169ec4e39846ea', 1, 59, 'male', 'female', 'Hi, I\'m Noah Jackson, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -87.629799, 41.878113, 39, 1, NULL),
('4056d000-ff7a-476b-81d4-45479e69dc00', 'gregory131@example.com', 'Gregory131', 'Rivera', 'Gregory', '4b8a7c00cee5d73f6a094a7095fba692247d3de6a261df071ab59db42df78bf5', 0, 83, 'male', '', 'Hi, I\'m Gregory Rivera, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', -98.493629, 29.424122, 20, 0, NULL),
('40ffebe3-54f6-4788-b4e4-72e5d7c37eac', 'gerald229@example.com', 'Gerald229', 'Smith', 'Gerald', '9e34badceb8139e4dbea404f379159c76582dacbf5c9c7789c7d223edd328ac2', 1, 53, 'male', 'male', 'Hi, I\'m Gerald Smith, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 4.402464, 51.219448, 97, 0, NULL),
('41316c50-5c3d-4fc3-8f93-2207a465faca', 'sean72@example.com', 'Sean72', 'Davis', 'Sean', 'caf36247fd592c6b1812c628345b69b920ece1c8ea3e15242862befcc8707288', 1, 100, 'male', 'female', 'Hi, I\'m Sean Davis, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -112.074037, 33.448377, 16, 1, NULL),
('414e7390-b7fd-4054-bedc-abb5e3548db8', 'judith461@example.com', 'Judith461', 'Green', 'Judith', 'de64b22192cfc98de0ee57b625c8ac18c70ea90cf0f10651c8e67c6e6879e7cb', 1, 38, 'female', '', 'Hi, I\'m Judith Green, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 3.717424, 51.054342, 90, 0, NULL),
('41828a0c-9838-4e62-b6a8-640fd3a3185e', 'lawrence118@example.com', 'Lawrence118', 'Rodriguez', 'Lawrence', '922a94711d4fcb2c512ca1463393d75ad3cccd820493f66afa1165ee70f24ebb', 1, 62, 'male', 'female', 'Hi, I\'m Lawrence Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 127.680932, 26.212401, 87, 1, NULL),
('418a4dad-0076-4f58-a651-45c85a0ec29d', 'kevin373@example.com', 'Kevin373', 'Nelson', 'Kevin', '2ca59d2ad54bc541955e86dc5eb4d1e2e479a59b6328a37bed4bad0a30bea7d9', 0, 28, 'male', 'female', 'Hi, I\'m Kevin Nelson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 3.087025, 45.777222, 66, 0, NULL),
('41a84720-a3e3-4970-bd74-916b34e51df8', 'ruruover1105@gmail.com', 'a', 'Kobayashi', 'Ruru-', '$2b$10$AYhZWiTiwqoQ0oM1FRxUiOfPs4bNvv7twzPNj45dqWEuxDT4UtqT2', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('42ba9c4d-c83c-4597-8d4c-dd910c67a5e5', 'brian132@example.com', 'Brian132', 'Davis', 'Brian', '376cd0595988f48b61e91a47e1c7e78cb2e42f73aa984c49851baad93548789e', 1, 51, 'male', '', 'Hi, I\'m Brian Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -75.165222, 39.952584, 51, 1, NULL),
('43261bd8-56e0-41f2-b241-d9dd5ff0f4f9', 'helen359@example.com', 'Helen359', 'Johnson', 'Helen', '7445656a4e3be8138a079e179acd97057530441366a43fddef8cba52623c2702', 0, 65, 'female', 'male', 'Hi, I\'m Helen Johnson, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -96.796988, 32.776664, 51, 1, NULL),
('435bd67c-8bae-4b62-82ce-f1b7231379b0', 'robert493@example.com', 'Robert493', 'Brown', 'Robert', '0d4be739566f3a43fa2f7be4f3e8b7235f4e62d042c7fe66289d3d6da0380bdc', 1, 61, 'male', 'female', 'Hi, I\'m Robert Brown, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', -0.579180, 44.837789, 41, 0, NULL),
('441fbde7-172c-4ed6-9381-b500457988f1', 'diane42@example.com', 'Diane42', 'Davis', 'Diane', 'fe404abb6785bd17ac4c937c2837d3ad6d6ac1ed17e099a89a9c5e18d1e936fe', 0, 68, 'female', 'male', 'Hi, I\'m Diane Davis, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 135.502165, 34.693738, 87, 1, NULL),
('44380bf9-2ff5-4c53-8b6b-930134430bbc', 'christina428@example.com', 'Christina428', 'Smith', 'Christina', 'ae0a2599cea0c5d7e9f98b54f0652f9a597626ae1b782cf21b4633f52477f9ee', 1, 71, 'female', 'male', 'Hi, I\'m Christina Smith, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 4.835659, 45.764043, 93, 1, NULL),
('45a5f012-7497-40e7-9718-92d340e51358', 'brandon275@example.com', 'Brandon275', 'Nguyen', 'Brandon', '21df5fa7385bcdab52383d2ec826e9a6ab3b0d803130b6e68f6034beca6ec4c7', 1, 31, 'male', 'female', 'Hi, I\'m Brandon Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 2.298280, 48.875312, 21, 0, NULL),
('47496682-0dfa-4a59-9408-85ee59bc139b', 'noah445@example.com', 'Noah445', 'Young', 'Noah', 'b0f656954b0c86ecd56c658286d200afbf82ed5e9c20939cab020fbbd761f448', 0, 95, 'male', 'female', 'Hi, I\'m Noah Young, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 138.388475, 34.971855, 15, 0, NULL),
('47d9a894-c087-4dab-903d-139aa3dca40d', 'amanda265@example.com', 'Amanda265', 'King', 'Amanda', '8250788247a1474360bf0817cce9e4d2ae4b178141230186aab3f57203356f6b', 1, 54, 'female', 'male', 'Hi, I\'m Amanda King, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -122.419416, 37.774929, 17, 0, NULL),
('483b3c08-b33f-4d71-a9dd-2eb60dfdc995', 'joshua272@example.com', 'Joshua272', 'Clark', 'Joshua', '76d970b23282220edf53388fcce316a8532cc22b7f22d0852cc55666d8b7c8cd', 1, 85, 'male', 'female', 'Hi, I\'m Joshua Clark, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 136.906398, 35.181446, 75, 1, NULL),
('4aec51aa-f2e1-4786-80bb-a67377b677b0', 'jack225@example.com', 'Jack225', 'Clark', 'Jack', '5c57dd893db405f9456cbbb49c94fcef85005c9185885a93b9499da5611dcc43', 0, 86, 'male', 'female', 'Hi, I\'m Jack Clark, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', -81.655651, 30.332184, 36, 1, NULL),
('4af81041-a0db-46cc-8179-a89dd37c1035', 'gregory242@example.com', 'Gregory242', 'Thompson', 'Gregory', '841993afee2bc177f686cb1758f9bb4e33341b581be49ceb83919571839f4eb0', 1, 31, 'male', 'female', 'Hi, I\'m Gregory Thompson, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 4.351721, 50.850346, 46, 0, NULL),
('4b10d6d7-e33a-4b73-8495-60a2392603c8', 'linda248@example.com', 'Linda248', 'Lewis', 'Linda', '5b4aeff8392d03972fe5a571b04cd6bcf7f7e5be075552e2a4efa90b9f1ad93d', 0, 26, 'female', '', 'Hi, I\'m Linda Lewis, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 136.906398, 35.181446, 21, 1, NULL),
('4c1d15c6-f5e0-483a-b907-78d69e9af527', 'heather396@example.com', 'Heather396', 'Lewis', 'Heather', '8d9a208fc205b757716aec7a9c47e53ebacc3c5a630e05c5339a1735737ef7dc', 0, 48, 'female', 'female', 'Hi, I\'m Heather Lewis, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 3.057256, 50.629250, 90, 1, NULL),
('4d60327a-210e-45b4-b72c-fed34c1cd635', 'pamela358@example.com', 'Pamela358', 'Taylor', 'Pamela', 'b76c393242f5e126a4313df1abf28e932d411592480a400df1bedbbfbf0a79fa', 0, 97, 'female', 'male', 'Hi, I\'m Pamela Taylor, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -5.984459, 37.389092, 69, 1, NULL),
('4d63cb18-b45b-4eb8-a544-ff6b887d67a2', 'cynthia158@example.com', 'Cynthia158', 'Williams', 'Cynthia', 'f31981caff7a925921ebfc00b5f1fc9355dc455504a86e3d85ea624dda77c097', 0, 59, 'female', 'male', 'Hi, I\'m Cynthia Williams, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -75.165222, 39.952584, 35, 0, NULL),
('4e070d0d-2a37-4344-b6c4-340c0ee4e5c8', 'jacqueline175@example.com', 'Jacqueline175', 'Jones', 'Jacqueline', 'c67600c5faaad96fd06fe335beaf9d16d9bbc134b31ddbf2481ed320180c576a', 1, 35, 'female', 'male', 'Hi, I\'m Jacqueline Jones, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -118.243683, 34.052235, 51, 1, NULL),
('4e1f823e-a2c7-4b34-8ccf-f5d7e28866bb', 'gloria152@example.com', 'Gloria152', 'Hall', 'Gloria', '5389dd6d1688b2f44a2a4c11ffe457b42e7b289e019d1df6d64287231eb6fa37', 1, 91, 'female', 'male', 'Hi, I\'m Gloria Hall, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -87.629799, 41.878113, 95, 1, NULL),
('4ebf1e05-ea73-4318-b2b1-304bad6d75a3', 'martha140@example.com', 'Martha140', 'Baker', 'Martha', 'e04a387e36bfe81fff02a09d9ef010c35466cc20ebd08b0c23be31a7f9bab368', 0, 67, 'female', '', 'Hi, I\'m Martha Baker, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 130.401716, 33.590355, 26, 1, NULL),
('4ec652d5-be74-4364-99b2-64c791c8385d', 'nicholas449@example.com', 'Nicholas449', 'Jackson', 'Nicholas', '19ff2289fb042a3255cb325b3618b35f29dd1a656ad25fabd8573a7b6b222f86', 1, 63, 'male', 'female', 'Hi, I\'m Nicholas Jackson, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 1.099971, 49.443232, 8, 1, NULL),
('4f3988a6-40af-4bfb-bc92-2916a819703c', 'arthur74@example.com', 'Arthur74', 'Smith', 'Arthur', '866cd269d3ff5014cece938df15524672537b7253b659875c9a8531f2d8d169c', 1, 78, 'male', '', 'Hi, I\'m Arthur Smith, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 138.388475, 34.971855, 63, 0, NULL),
('4f4fc3aa-7b7c-4bc9-b3da-ed18057755bb', 'kathryn54@example.com', 'Kathryn54', 'Baker', 'Kathryn', '49a9b3d96db1310ff79b9ae1cdb1e148b4d5995b7f889e5ad2b611f452fecf71', 0, 60, 'female', 'male', 'Hi, I\'m Kathryn Baker, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 138.388475, 34.971855, 40, 0, NULL),
('5038103b-d8c2-4f0f-b553-f4a9b877e2e7', 'jerry65@example.com', 'Jerry65', 'Williams', 'Jerry', '893f05cca9f0bdf66d78944a09e9cbe3a1ddc76838e329cae5d22a339b45e272', 1, 81, 'male', 'female', 'Hi, I\'m Jerry Williams, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 7.752111, 48.573405, 92, 1, NULL),
('508c5da3-0852-49c8-b127-376a1f450649', 'richard213@example.com', 'Richard213', 'Carter', 'Richard', '813b9b3bf8301f2a77d091f9e26b4ea05b7625ac3389e17456e16054a5ef052a', 0, 83, 'male', 'male', 'Hi, I\'m Richard Carter, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 132.455293, 34.385203, 89, 0, NULL);
INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES
('5182776b-4b72-4a0e-af49-9571a542211a', 'anthony119@example.com', 'Anthony119', 'Flores', 'Anthony', '3a124b5ae21189adc66dfd33c32e90fec5cbbc825d8ae6672f5ed89a7fea407b', 1, 28, 'male', 'female', 'Hi, I\'m Anthony Flores, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -4.486076, 48.390394, 79, 1, NULL),
('527f647b-f120-4b29-be7c-63097a9e14d7', 'kathleen432@example.com', 'Kathleen432', 'Hernandez', 'Kathleen', '2b215f19198f06003e733c665b3f16d8eb0fa66b96d64a2cf295657b86c95017', 0, 74, 'female', '', 'Hi, I\'m Kathleen Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 135.768029, 35.011636, 21, 1, NULL),
('52e73477-e33b-45bd-845e-61888b641198', 'austin397@example.com', 'Austin397', 'Martinez', 'Austin', 'c6899a89ae9c8c978d84057adc340f84d450a3a1f280977d9e9dec557a424655', 0, 34, 'male', 'female', 'Hi, I\'m Austin Martinez, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 132.455293, 34.385203, 34, 1, NULL),
('532ce41f-7b18-4975-a15a-6174fb9d5a74', 'jerry370@example.com', 'Jerry370', 'Young', 'Jerry', 'c2c424e2c258a2e53493b7526e8492bb02bfa9689f2a43ae27b1fbb96995050a', 0, 71, 'male', 'female', 'Hi, I\'m Jerry Young, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 133.919502, 34.655146, 73, 1, NULL),
('535630b7-13e9-4c62-8079-4a8eed6ac23c', 'brenda156@example.com', 'Brenda156', 'Williams', 'Brenda', 'be195fa37fdcb899887cab07f8e580a15f91a9faaa95297ca3217b103bcae285', 0, 79, 'female', 'male', 'Hi, I\'m Brenda Williams, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 139.829356, 35.841208, 12, 1, NULL),
('535ac85c-a605-47cb-8891-009b28b7ac40', 'samuel312@example.com', 'Samuel312', 'Hill', 'Samuel', 'd8d3b7a0aa973c9dd4da3058ccafbc9d4cee1d6d8ce51adfddf7b336ad85128b', 0, 94, 'male', 'female', 'Hi, I\'m Samuel Hill, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -3.703790, 40.416775, 40, 1, NULL),
('5372eedd-0576-4e0a-96e9-b29311680b9f', 'barbara6@example.com', 'Barbara6', 'Brown', 'Barbara', '598a1a400c1dfdf36974e69d7e1bc98593f2e15015eed8e9b7e47a83b31693d5', 0, 36, 'female', 'male', 'Hi, I\'m Barbara Brown, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 127.680932, 26.212401, 34, 0, NULL),
('53b409b5-4f7b-4349-8322-e8bb04adf564', 'katherine459@example.com', 'Katherine459', 'Campbell', 'Katherine', '1b7a9b4221e6c8bf98f63b383610f4cd3e552c20f2f564fb6c10b9101416275f', 1, 94, 'female', 'male', 'Hi, I\'m Katherine Campbell, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -96.796988, 32.776664, 68, 0, NULL),
('53f4f9bb-2909-441c-b1f4-cd8359d9c263', 'ashley280@example.com', 'Ashley280', 'Scott', 'Ashley', 'e2c10d9bc0e678dc14ee061410748b0bcd2571743f7aac8d9ebfb3a2cee9ec8f', 0, 35, 'female', 'male', 'Hi, I\'m Ashley Scott, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 4.351721, 50.850346, 16, 1, NULL),
('540e647d-28e0-45cb-a3ee-0122afd925a1', 'linda212@example.com', 'Linda212', 'Martinez', 'Linda', '644f72a3cc2b2729424618c7317594d4190928ff2150dff08c050d78ea59c779', 0, 95, 'female', 'male', 'Hi, I\'m Linda Martinez, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -97.743061, 30.267153, 64, 0, NULL),
('54a65fb7-c5e1-4a25-a49f-cadd94429378', 'rachel107@example.com', 'Rachel107', 'Hernandez', 'Rachel', '3cd4e74734d6a5afbaf9587f8a912079652e9bc0487322799410f11dd11cb44a', 0, 32, 'female', 'male', 'Hi, I\'m Rachel Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 1.444209, 43.604652, 59, 0, NULL),
('54a769fe-533a-4388-b322-555a546f105a', 'ethan377@example.com', 'Ethan377', 'Sanchez', 'Ethan', '14a010efd36fa7ca3d3c4bbd0f230cdcac4839cbc94daf25dadb69e9947a1579', 1, 52, 'male', 'male', 'Hi, I\'m Ethan Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 4.031696, 49.258329, 25, 0, NULL),
('551e0a57-b172-4e13-993a-bf069fe095e5', 'megan346@example.com', 'Megan346', 'Martinez', 'Megan', '2b21938e9a9c197eb86583e27aa64ffd308b1a4d5ba91c22eb08f28dd2e89442', 0, 31, 'female', 'female', 'Hi, I\'m Megan Martinez, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 136.906398, 35.181446, 47, 0, NULL),
('557eb771-ace0-4678-b656-80d77f6829b0', 'cynthia362@example.com', 'Cynthia362', 'Hall', 'Cynthia', 'b66405a6e995a21fe69f8bd67630e43a56f8dc70b8c3813769b75f3af11521f2', 1, 88, 'female', 'male', 'Hi, I\'m Cynthia Hall, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 4.835659, 45.764043, 47, 0, NULL),
('56355ec3-1c22-42b0-ad34-ba6fcc159392', 'donna218@example.com', 'Donna218', 'Scott', 'Donna', '42beb967d02a59c6e72579ea3fa13a6b5b035e1c2f411c247b65358440f26fa7', 0, 84, 'female', 'female', 'Hi, I\'m Donna Scott, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 3.717424, 51.054342, 83, 1, NULL),
('56830707-f912-4f93-a25a-9f8fb5af3962', 'cheryl305@example.com', 'Cheryl305', 'Lopez', 'Cheryl', 'a77125f6987a1f3dbe60f4507919c8fed816c2460fb4a7c632cfeb034cbc0445', 1, 83, 'female', 'male', 'Hi, I\'m Cheryl Lopez, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 139.036413, 37.916192, 8, 0, NULL),
('56f636f5-2740-4a39-bdbd-655da2e4ab00', 'steven184@example.com', 'Steven184', 'Martinez', 'Steven', '4c30e7c4e70dd93bca87a16d9a09f7116aa0789037af27be7bc36b5927fe2f09', 1, 78, 'male', 'female', 'Hi, I\'m Steven Martinez, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 4.835659, 45.764043, 0, 0, NULL),
('58d5cdd4-49c5-482f-a63c-4ef55abc8899', 'linda155@example.com', 'Linda155', 'Davis', 'Linda', 'a7200b31eeb58d8750480cf6bb58773ea94419b7d15e4c6fa63ead0f31d58388', 0, 19, 'female', 'male', 'Hi, I\'m Linda Davis, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 4.835659, 45.764043, 99, 0, NULL),
('58f3424a-7419-484f-bc4e-7faf904e44a2', 'zachary10@example.com', 'Zachary10', 'Adams', 'Zachary', 'aa4a9ea03fcac15b5fc63c949ac34e7b0fd17906716ac3b8e58c599cdc5a52f0', 0, 77, 'male', 'female', 'Hi, I\'m Zachary Adams, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 21.011486, 52.225406, 90, 1, NULL),
('596b1974-cad4-43f9-81b7-8f3c54164d32', 'mary102@example.com', 'Mary102', 'Gonzalez', 'Mary', '3233c5e43b1a0d2a03c8a6fc981fe3bad46b9fee5ca59d53f6a531325cd3a433', 0, 37, 'female', 'male', 'Hi, I\'m Mary Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -97.743061, 30.267153, 84, 0, NULL),
('59ad9ea2-d098-4e62-a1f4-3f3a790fcd5a', 'christian96@example.com', 'Christian96', 'Scott', 'Christian', '7d1efd5e066097bb201fe40e651bea92f53b9a3e8c99cd76e15030f9d072c2d8', 1, 98, 'male', 'female', 'Hi, I\'m Christian Scott, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 139.829356, 35.841208, 42, 1, NULL),
('5c2e13a5-c245-4061-a887-eac65d06b5fd', 'daniel423@example.com', 'Daniel423', 'Martinez', 'Daniel', '8634020cffbcdda5c0bbc116f2bea0a56c5c0c4e1e0099485fb161e3ce68dcf8', 1, 51, 'male', 'female', 'Hi, I\'m Daniel Martinez, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', -117.161084, 32.715738, 25, 0, NULL),
('5cb25de0-3178-4d91-8ab1-9029e3278eff', 'dennis13@example.com', 'Dennis13', 'White', 'Dennis', '48caafb68583936afd0d78a7bfd7046d2492fad94f3c485915f74bb60128620d', 1, 49, 'male', 'female', 'Hi, I\'m Dennis White, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 4.351721, 50.850346, 100, 0, NULL),
('5cbe4805-b3d5-483a-9d0f-6749a9b18566', 'jennifer455@example.com', 'Jennifer455', 'Hill', 'Jennifer', 'd4dd2565aa9d8eebfa084ae19a5d957911e06537ea1b4edef19309ea9c2661c9', 1, 84, 'female', 'male', 'Hi, I\'m Jennifer Hill, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 133.919502, 34.655146, 80, 0, NULL),
('5ccd83b4-a77e-4466-8e17-6bde5efe7f53', 'betty302@example.com', 'Betty302', 'Rodriguez', 'Betty', 'c706de3536b14ec2655ab91183af3ca52076d91a76e0ac69adb7e7c2ac29479c', 0, 67, 'female', 'male', 'Hi, I\'m Betty Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 2.173404, 41.385064, 61, 1, NULL),
('5d3c4c32-9f3a-42c1-8e9f-38de14ab69ba', 'tyler463@example.com', 'Tyler463', 'Mitchell', 'Tyler', '1d4daba704a5d59d3896a8648e0bf3aaa2daa4516812dfbfc1ef1a1360a230ff', 0, 61, 'male', 'female', 'Hi, I\'m Tyler Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -97.743061, 30.267153, 99, 0, NULL),
('5ead8027-11c6-44d8-8961-34c6e77ea166', 'steven427@example.com', 'Steven427', 'Davis', 'Steven', 'fb5608bd8945d507a43ea5f900970355a1a094c6c5aa2910e4d02acf92966577', 1, 89, 'male', 'female', 'Hi, I\'m Steven Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 7.261953, 43.710173, 73, 1, NULL),
('5f0bc55d-20f0-4c6f-beb2-415a5177e815', 'jeffrey227@example.com', 'Jeffrey227', 'Anderson', 'Jeffrey', '1696b5ba5612f38991eb9974ba86d438149297ff5055e6e31f3ae7f63e99fac1', 1, 93, 'male', '', 'Hi, I\'m Jeffrey Anderson, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -95.369804, 29.760427, 2, 1, NULL),
('5f0fc726-415c-40bf-98df-ef9cdfbfb4ae', 'patricia93@example.com', 'Patricia93', 'Taylor', 'Patricia', 'd7564185a138164df46bfd84a11627c0fdd37295b89ae7230afdd51c0c983b77', 1, 56, 'female', '', 'Hi, I\'m Patricia Taylor, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -0.108740, 51.509897, 21, 0, NULL),
('5f946879-5deb-4a4c-bf03-b851c48ac630', 'hannah258@example.com', 'Hannah258', 'Flores', 'Hannah', 'ff7fb48ec0bd80876c9c246d33d18efd0648bff6467fcc945db7f49692dab1e1', 1, 77, 'female', 'male', 'Hi, I\'m Hannah Flores, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -96.796988, 32.776664, 47, 0, NULL),
('6034065e-13fd-404f-adc5-4d082caf3c70', 'anthony279@example.com', 'Anthony279', 'Thompson', 'Anthony', '564172fb1a3b720c0d599d95e4e7e27c156c1ce32d47b747f8e13301f91720f0', 1, 30, 'male', 'female', 'Hi, I\'m Anthony Thompson, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 4.031696, 49.258329, 68, 0, NULL),
('60a3c154-fbe5-44ba-91d4-344a407f2866', 'benjamin352@example.com', 'Benjamin352', 'Sanchez', 'Benjamin', 'e036452de86077b0e77ff60fe42b8434147c8315d34bd1ed242013b2950238c7', 0, 80, 'male', '', 'Hi, I\'m Benjamin Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', -74.005974, 40.712776, 17, 0, NULL),
('6121bd77-ed90-47bf-93f5-c2de8557b8ff', 'austin299@example.com', 'Austin299', 'Mitchell', 'Austin', '7d0bda053612b3bbb570feedc41e95a951271f2373499bc7a7f71b0c5817939b', 1, 93, 'male', '', 'Hi, I\'m Austin Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -80.843127, 35.227087, 49, 0, NULL),
('613432eb-e786-412f-9b01-3835a7eb9983', 'douglas20@example.com', 'Douglas20', 'Perez', 'Douglas', '7535d8f2d8c35d958995610f971287288ab5e8c82a3c4fdc2b6fb5d757a5b9f8', 0, 97, 'male', 'female', 'Hi, I\'m Douglas Perez, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -95.369804, 29.760427, 36, 1, NULL),
('625774b0-d914-4faf-85de-964e3ae5cfd8', 'jean405@example.com', 'Jean405', 'Johnson', 'Jean', 'ef50857f809120af6975a1ca52b743bca063bea29748771085f90f5f46f4f225', 1, 59, 'female', 'male', 'Hi, I\'m Jean Johnson, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 3.876716, 43.610769, 46, 1, NULL),
('628713f1-63da-4848-996b-efff8c0706d3', 'jerry438@example.com', 'Jerry438', 'Allen', 'Jerry', '8ce1efcdfc5e9290dc58832e5ac3356abfdbbec324b8729ff9a6ca3544bf9bdb', 1, 75, 'male', 'female', 'Hi, I\'m Jerry Allen, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', -4.486076, 48.390394, 72, 1, NULL),
('62a26db9-205f-414b-bf61-f22ec05e0d38', 'laura294@example.com', 'Laura294', 'White', 'Laura', 'da08aa58ffff7bad63b4b92831a199615b6ef1e7b6a3f0a646c14d9e81226fc4', 0, 25, 'female', 'male', 'Hi, I\'m Laura White, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 136.906398, 35.181446, 100, 0, NULL),
('6477f9a2-c828-4e5c-a3d1-eefc2ab56c9f', 'victoria55@example.com', 'Victoria55', 'Allen', 'Victoria', '92b32cbd4cc1b06d83ec4c305c52d651b9c125a7b12dbb7c6a1cf796f6e389e5', 0, 91, 'female', 'male', 'Hi, I\'m Victoria Allen, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 130.401716, 33.590355, 53, 1, NULL),
('64e33f03-8781-48bd-8df8-a136370e479d', 'rebecca15@example.com', 'Rebecca15', 'King', 'Rebecca', 'c63c2d34ebe84032ad47b87af194fedd17dacf8222b2ea7f4ebfee3dd6db2dfb', 0, 73, 'female', 'male', 'Hi, I\'m Rebecca King, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -3.703790, 40.416775, 9, 0, NULL),
('64f4fcb0-9215-4c43-b892-7ce5fd944048', 'gary45@example.com', 'Gary45', 'Smith', 'Gary', '0528d31561cee040ee92e2857a2d71a373605b91da87d09ae5359a0689c45e6c', 1, 56, 'male', 'female', 'Hi, I\'m Gary Smith, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -95.369804, 29.760427, 23, 0, NULL),
('6553d177-4bdf-4f99-9649-280d2a62f2f5', 'jerry226@example.com', 'Jerry226', 'Rodriguez', 'Jerry', '75920b4a8744dae9fb38ff98574ed63d4820658f301bb2869999989d985c4892', 0, 73, 'male', 'female', 'Hi, I\'m Jerry Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 139.638026, 35.443708, 62, 1, NULL),
('6584230b-333e-446c-81d4-388879cc6a8c', 'jack68@example.com', 'Jack68', 'Scott', 'Jack', '88e43563eb048331cecc5f4f6823b2328bb482be858f5984ec8fe93e6bad1e78', 1, 47, 'male', '', 'Hi, I\'m Jack Scott, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -82.998794, 39.961176, 37, 0, NULL),
('6597f1bc-935b-46ae-92b6-18806aa0c324', 'steven491@example.com', 'Steven491', 'Garcia', 'Steven', 'd7d93e7eaede053b4df44ea7c905f7e21984f3d60a8c2aad90b13066eaa84f55', 0, 57, 'male', 'female', 'Hi, I\'m Steven Garcia, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -0.108740, 51.509897, 87, 0, NULL),
('66121e33-3b54-4225-b72c-a38d965d6c47', 'robert78@example.com', 'Robert78', 'Campbell', 'Robert', '98bbb2f3c8ffa8e403751db051f7b5a31498137940e50b01d237557a89bdd124', 0, 18, 'male', 'female', 'Hi, I\'m Robert Campbell, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -5.984459, 37.389092, 28, 0, NULL),
('66ccf0e9-05b1-45a5-8b60-fa3af83f1838', 'david186@example.com', 'David186', 'Gonzalez', 'David', 'b152fb0e61d328daa53519014576921b2bb7fca49bab8f6866f54cd950c9fccc', 1, 31, 'male', 'female', 'Hi, I\'m David Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 1.099971, 49.443232, 56, 0, NULL),
('674014d9-3643-4736-a697-a20ff4f82b3a', 'kyle162@example.com', 'Kyle162', 'Scott', 'Kyle', '1d5e797982553235906bb2798d893d390297ac13109f5183467e7f6532562087', 1, 93, 'male', 'female', 'Hi, I\'m Kyle Scott, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', -87.629799, 41.878113, 80, 0, NULL),
('6841c4b9-8161-4478-b2b9-56170b3aaa93', 'jennifer298@example.com', 'Jennifer298', 'Davis', 'Jennifer', 'bd879d249ffc4006cabf18d22130961b779259e60f54aa2e6624842c05fb4e4f', 1, 34, 'female', 'male', 'Hi, I\'m Jennifer Davis, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 127.680932, 26.212401, 36, 1, NULL),
('68565f43-d092-447f-95f8-d759862d8a46', 'christopher90@example.com', 'Christopher90', 'Sanchez', 'Christopher', 'a5536e54583b2a30f0a9048e0ac4be50d154e5c0b0b736ea23552154628f7142', 0, 97, 'male', 'female', 'Hi, I\'m Christopher Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 2.295753, 49.894067, 49, 0, NULL),
('6a1dee9f-d7c9-471b-9da0-7e23abca9df3', 'nicole417@example.com', 'Nicole417', 'Miller', 'Nicole', '4cf95d9dd55000c868ce4440333c25ab5b02c60b4f887c95400e49bda8a35a0e', 0, 29, 'female', 'male', 'Hi, I\'m Nicole Miller, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -121.886329, 37.338208, 51, 0, NULL),
('6a2e84a0-4d50-4d1b-bf89-154371bbd176', 'anthony122@example.com', 'Anthony122', 'Miller', 'Anthony', 'c660725919c1c20945cca28ed9944edaf8f4c6a11310c1024e30bd528d0f6c13', 0, 49, 'male', 'male', 'Hi, I\'m Anthony Miller, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -97.743061, 30.267153, 3, 1, NULL),
('6a34f76d-328c-4856-ae49-17eadf505fda', 'matthew408@example.com', 'Matthew408', 'Garcia', 'Matthew', 'e9bd30c134915c3561d4f2068fa36f26d11b792de12a8ce1ecce5be805f2c742', 0, 45, 'male', 'female', 'Hi, I\'m Matthew Garcia, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 21.011486, 52.225406, 26, 1, NULL),
('6aa98281-13ce-404e-8282-51e8f2ed4c82', 'patrick418@example.com', 'Patrick418', 'Hernandez', 'Patrick', 'c3d37ae3afe2befdda3f0cb2abe82701032503e944fdb9cd4fb16b93922064b9', 1, 59, 'male', 'female', 'Hi, I\'m Patrick Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 3.876716, 43.610769, 43, 0, NULL),
('6bdbc5c8-70a3-4c29-9e54-357bc10c161b', 'paul308@example.com', 'Paul308', 'Rivera', 'Paul', 'e3ca43d7686ffec5e0e3ad8f0880662302168468b850b3ca6c806eb42f157bc9', 0, 56, 'male', 'female', 'Hi, I\'m Paul Rivera, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 141.354376, 43.062096, 59, 1, NULL),
('6be578e9-4047-4dda-8dc3-e16a7feaba2a', 'timothy182@example.com', 'Timothy182', 'Jones', 'Timothy', '60f456aa7b7093a0e31ad9c559bcedbedb5443e2effffbe4a30c7b1a91ca6202', 1, 45, 'male', 'female', 'Hi, I\'m Timothy Jones, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 136.656205, 36.561325, 25, 1, NULL),
('6c804061-69c4-49ed-ad77-8e06c2a212f5', 'henry95@example.com', 'Henry95', 'Mitchell', 'Henry', 'ea1a2d06bbb09a6ea84f918fdb18ac17615365afa5ff09ac73eaf6e68cb5352f', 1, 100, 'male', 'female', 'Hi, I\'m Henry Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -81.655651, 30.332184, 82, 1, NULL),
('6d1fdeb2-e896-42df-85ef-d55509152781', 'pamela479@example.com', 'Pamela479', 'Wilson', 'Pamela', '8cb06c386439fea8c19a84579e6a3364753e5e67ed9c44bfa7505c8719e42294', 1, 97, 'female', 'male', 'Hi, I\'m Pamela Wilson, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 133.919502, 34.655146, 39, 1, NULL),
('6d6465d8-a491-49a8-96aa-a69da3cb1703', 'donald339@example.com', 'Donald339', 'Jones', 'Donald', 'ca571fd519347678d33a6b4cd6db28bf3905e7f6cc36ff111d5c2a1f364c1b2c', 0, 68, 'male', 'female', 'Hi, I\'m Donald Jones, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 13.402720, 52.517251, 43, 0, NULL),
('6dbe5a4f-0cbb-4d47-9066-50639cb70a79', 'jacqueline466@example.com', 'Jacqueline466', 'Ramirez', 'Jacqueline', '5a14b30c928ef86e29b055e410798bbe668f6f0b3495ca1c62c6b79fffb14096', 1, 84, 'female', 'male', 'Hi, I\'m Jacqueline Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', -95.369804, 29.760427, 92, 0, NULL),
('6ec09a78-7200-47f1-9e3d-865fb1a21040', 'nicole88@example.com', 'Nicole88', 'Young', 'Nicole', 'd40a16374040c8925cbef829db5fe9081e2b2e7fa968146b68a0555290ef0cb4', 1, 50, 'female', 'female', 'Hi, I\'m Nicole Young, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 3.876716, 43.610769, 59, 0, NULL),
('6f878620-bb15-4ca5-835c-0ff4c6d9dc1d', 'megan97@example.com', 'Megan97', 'Miller', 'Megan', '048a93fe25bed33f6e0d37f4ed4b53a39b2201ebe7dae0fad74eb52e7ce5c3bc', 1, 55, 'female', 'male', 'Hi, I\'m Megan Miller, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -4.486076, 48.390394, 78, 0, NULL),
('6fb30b60-f79f-4b37-9c7b-4557afe17a91', 'stephanie83@example.com', 'Stephanie83', 'Williams', 'Stephanie', 'a716312b9827d16a1b61a468c1760d0d315ec621f6223f90abf85579e1f50c61', 1, 93, 'female', 'male', 'Hi, I\'m Stephanie Williams, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 136.656205, 36.561325, 21, 0, NULL),
('70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', 'ruruover1105@gmail.com', 'collis', 'collis', 'Leadford', '$2b$10$A0ARrMOo7b286GAtS37GHuIcQeI9YtlnpeTWGhfvyHYHauENE4Wwm', 1, 36, 'male', 'no', 'music is my life', 'http://localhost:4000/uploads/pexels-collis-3031391.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', '', 2.336175, 48.885805, 0, 0, NULL),
('70965b6e-af44-43e7-9f46-c64a7b6521e5', 'martha183@example.com', 'Martha183', 'Flores', 'Martha', 'd45c7de35a59d9145ea3fcc4a3b6e2a6aa6abe00f97ae843e32a554666ab3c2b', 1, 61, 'female', 'male', 'Hi, I\'m Martha Flores, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', -74.005974, 40.712776, 2, 1, NULL),
('70aca927-e872-4c1a-917d-31201e8537ad', 'aaron233@example.com', 'Aaron233', 'Smith', 'Aaron', 'e1a540168a0e280dd1e4961c3404a0eae5464c1851ee4eb380ebc6bd5da844e2', 1, 64, 'male', 'female', 'Hi, I\'m Aaron Smith, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 139.829356, 35.841208, 10, 0, NULL),
('70b3135b-3012-45f0-94f9-665bb5538a97', 'catherine76@example.com', 'Catherine76', 'Walker', 'Catherine', 'e57a2fc7529930d46edee4d20ee17e70001fd51a267c11768f9a0dc6dab2fdc1', 1, 21, 'female', '', 'Hi, I\'m Catherine Walker, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 4.351721, 50.850346, 24, 0, NULL),
('70d4a254-6aaf-47ba-8475-67f49fabd57f', 'alexander342@example.com', 'Alexander342', 'White', 'Alexander', '45078644fe260c4bd70fc041d40c5aae1e4fba5942d50312cd32ff29ccca4d3b', 0, 70, 'male', 'female', 'Hi, I\'m Alexander White, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -122.419416, 37.774929, 37, 1, NULL),
('70fc1ffa-9d3e-40d4-8f8a-7f126dfd862d', 'dennis79@example.com', 'Dennis79', 'Thompson', 'Dennis', '2cc0d1f43b0e59cc929a49d62414227944658c64e5e449964efd054768e14173', 1, 77, 'male', 'female', 'Hi, I\'m Dennis Thompson, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 1.444209, 43.604652, 54, 0, NULL),
('716c2773-6844-4950-b266-99864109865f', 'michael228@example.com', 'Michael228', 'Wilson', 'Michael', '36a1582d66de6323ecddb97313863aee71a5c019b6d1b370da790b65a62a4883', 0, 38, 'male', '', 'Hi, I\'m Michael Wilson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 5.369780, 43.296482, 15, 0, NULL),
('72219c08-9a42-42bd-af6a-1ab102d9501c', 'olivia141@example.com', 'Olivia141', 'Clark', 'Olivia', '94bea607efe4e7435e1cac4a710e80ed915b722978463426d824d167da0fbf22', 1, 52, 'female', 'male', 'Hi, I\'m Olivia Clark, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 7.261953, 43.710173, 83, 1, NULL),
('72442cf9-77fd-40c5-a09a-eef1227e5207', 'tyler480@example.com', 'Tyler480', 'Jones', 'Tyler', '9bd058222e115131c5f079fb92cb026f9ea1baa6d22e47a753c2c67793a8a7e7', 1, 31, 'male', 'male', 'Hi, I\'m Tyler Jones, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -1.558626, 43.483152, 82, 0, NULL),
('7350a077-826a-4fa4-b710-ee45a66ac48f', 'steven43@example.com', 'Steven43', 'Jones', 'Steven', 'fe4597a9d0a16c51ab5c8224dae83f170b69cede0f1a7f40f447f163dcbf9295', 0, 80, 'male', '', 'Hi, I\'m Steven Jones, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -3.703790, 40.416775, 22, 0, NULL),
('73aaee6d-86dc-4fd6-b9eb-652d6b8c66bd', 'anna221@example.com', 'Anna221', 'Rodriguez', 'Anna', 'b9665b2b8959453eb7f2a9616584de471d8ad7b28fd9a61138bd468ad0a425a0', 0, 94, 'female', 'male', 'Hi, I\'m Anna Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -1.558626, 43.483152, 5, 0, NULL),
('73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'ruruover1105@gmail.com', 'Linda', 'Richard', 'Linda', '$2b$10$iOoNh3LTkwcHF9/HcX1wLO1G1YlIAwf9l7yxaRFpLtW03SEbOduMW', 1, 32, 'female', 'male', 'let\'s drink together', 'http://localhost:4000/uploads/pexels-andrea-piacquadio-733872.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 2.336149, 48.885829, 75, 0, NULL),
('74147d96-5ad7-48ff-9d6b-968c2edd7b4c', 'thomas61@example.com', 'Thomas61', 'Carter', 'Thomas', 'a94483aff86454580a66cf4794f417e1b406b6dde7de2e5796a4a0b3e07356b6', 0, 65, 'male', 'male', 'Hi, I\'m Thomas Carter, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 2.298280, 48.875312, 7, 1, NULL),
('7438eebf-e0fa-4003-b0e5-a676525562ea', 'dennis161@example.com', 'Dennis161', 'Scott', 'Dennis', '05b06265bf413273a8f8e46f81550618e6fa3c2576d098c49000a77acd180649', 1, 33, 'male', 'female', 'Hi, I\'m Dennis Scott, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 1.444209, 43.604652, 26, 1, NULL),
('750f838c-356f-4c1d-8ad2-0b4e76882595', 'ruruover1105@gmail.com', 'nitin', 'khajotia', 'nitin', '$2b$10$Dgrs9IqicLEyqlYwbRXUuencXAjJ38851foMKIZ/wEsng0Fzlk5na', 1, 0, 'male', 'male', 'be strong', 'http://localhost:4000/uploads/pexels-nitin-khajotia-1516680.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('76636f8f-3279-425a-88b5-53ad350a49df', 'george259@example.com', 'George259', 'Nelson', 'George', 'f0bb405ce12bbb22ac30e9dbc17d4a2c30fc6854f90a116c62a6fb0cc18541f0', 1, 53, 'male', 'female', 'Hi, I\'m George Nelson, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', -121.886329, 37.338208, 1, 1, NULL),
('773672a2-7541-4592-b0a4-cd30417b3fdc', 'lisa142@example.com', 'Lisa142', 'Hernandez', 'Lisa', '404efa37375fa762663841baaa7a82310f8b9fd5ea9cb687ac977b9d62d39d36', 1, 38, 'female', 'male', 'Hi, I\'m Lisa Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 133.919502, 34.655146, 68, 1, NULL),
('7741b1a3-7d3d-4f57-a542-c1c37b59119d', 'pamela283@example.com', 'Pamela283', 'Roberts', 'Pamela', '81f5e7c29c33431b0afd71d2d5f5e70b2edd99a30d1eacd389848486e86c2e77', 1, 68, 'female', 'male', 'Hi, I\'m Pamela Roberts, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -5.984459, 37.389092, 58, 1, NULL),
('77743911-bb39-408b-af66-d84df45d73fa', 'ruruover1105@gmail.com', 'jeffrey', 'reed', 'jeffrey', '$2b$10$TsT46xB3rKlQH1nApfWiGuDGjjyR0LmfWpdkkm.h0U3gV2VUtaftq', 1, 18, 'male', 'female', 'study math', 'http://localhost:4000/uploads/pexels-jeffrey-reed-769690.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 100, 0, NULL),
('780a8224-2cea-475a-bf38-538f533ade82', 'gary51@example.com', 'Gary51', 'Taylor', 'Gary', 'b799be36e0059d7867f1379a24171b2b09d91be5d2cac0a12d97c0302a6b07ce', 0, 20, 'male', 'female', 'Hi, I\'m Gary Taylor, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 2.295753, 49.894067, 49, 1, NULL),
('78a310cf-7861-4637-8452-e83c96b77716', 'tsujimarico@gmail.com', 'marikomariko', 'mariko', 'mariko', '$2b$10$WQW27j7rVFF3cEg86Xi2C.oys7WDP20QMIumksjuc0qwfxqDgifwe', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('78a685aa-07f0-4f57-9285-e35ee7c7c7aa', 'ruruover1105@gmail.com', 'ferreira', 'kamiz', 'ferreira', '$2b$10$/VCzQq3FwiwzAfb8ozfVBuGdB40kn0FxlFZ3M3sYIF.XYseOiKVXu', 1, 0, 'female', 'female', 'love', 'http://localhost:4000/uploads/pexels-kamiz-ferreira-2218786.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('78d4f161-d67f-4c52-a8a7-68fd363bb79b', 'olivia99@example.com', 'Olivia99', 'Flores', 'Olivia', '5f5b24ad65531525ddcccace0598dafaa386e30749babf12c7b0cda2af45c582', 1, 59, 'female', 'male', 'Hi, I\'m Olivia Flores, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 138.388475, 34.971855, 28, 1, NULL),
('7a00000b-2258-47f6-88b7-c21937ed76fe', 'jessica159@example.com', 'Jessica159', 'Moore', 'Jessica', '9be4dafaba88c5ac0c4109813438a86aa5fc2e0336d6b06739b1806f322e067c', 1, 21, 'female', 'male', 'Hi, I\'m Jessica Moore, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 130.557116, 31.596554, 26, 0, NULL),
('7ad56bf6-3e06-4267-b512-b5ee3e4780ba', 'gregory382@example.com', 'Gregory382', 'Campbell', 'Gregory', 'c54aff54b404b7106a2e76dfb146997c32094b0beed7de4cb3a99fe2cf08b3ee', 0, 72, 'male', 'male', 'Hi, I\'m Gregory Campbell, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 2.295753, 49.894067, 31, 0, NULL),
('7ae14fbf-c570-4e98-ac19-c4e597088fab', 'mark348@example.com', 'Mark348', 'Hall', 'Mark', '4a760153b507ab916cde1e1b9782d3bc69738dacbbb9a92ca01e9d2b00f1e759', 0, 69, 'male', 'female', 'Hi, I\'m Mark Hall, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 15.063146, 45.079574, 61, 1, NULL),
('7af55a0b-76e8-46b9-8ac0-71bbea98123c', 'heather262@example.com', 'Heather262', 'Garcia', 'Heather', '02d72e97cb2a12cc111547ac5fab78461e205e350dadb2b9d8486d9c885cbaa4', 1, 20, 'female', 'male', 'Hi, I\'m Heather Garcia, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 140.869356, 38.268215, 84, 1, NULL),
('7c9da382-97ea-4382-a12a-33176e97165f', 'dorothy215@example.com', 'Dorothy215', 'Campbell', 'Dorothy', '90b6070389842f54157e6e4a48588a9cc41ddb4ade1e3f4dfb952d4fab255c85', 1, 34, 'female', 'male', 'Hi, I\'m Dorothy Campbell, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 135.768029, 35.011636, 71, 1, NULL),
('7ca99827-9529-4ceb-9f62-73269d6aa14e', 'jack439@example.com', 'Jack439', 'Garcia', 'Jack', '5f076e646eb4ebd389d6caa20cc84e30da438d0896bf56dfb329b3d2624f945b', 1, 44, 'male', 'female', 'Hi, I\'m Jack Garcia, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 138.388475, 34.971855, 64, 0, NULL),
('7d0f1e6c-f78b-411e-85fd-e7351d7a14c9', 'linda172@example.com', 'Linda172', 'Williams', 'Linda', '5594588b81cd367e90ca5e4d6d882fa61f32badb098ee1ad557e1a7b57f17257', 0, 45, 'female', 'male', 'Hi, I\'m Linda Williams, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -4.486076, 48.390394, 42, 0, NULL),
('7d48f135-8fa2-43e7-85b2-f65fc68f1d42', 'sharon199@example.com', 'Sharon199', 'Adams', 'Sharon', 'a33445c8fe65518e988b1df0fa190de986b4f8428e077ebc645e70804e27d39c', 1, 36, 'female', 'male', 'Hi, I\'m Sharon Adams, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 4.031696, 49.258329, 73, 1, NULL),
('7ddc2895-4a81-46ae-9db5-8b9ad9dc82bc', 'melissa295@example.com', 'Melissa295', 'Davis', 'Melissa', 'bf6329e3b014e63d376747969a1ccd1b8d486fbdda1cdc3560f366d4b1c1dd22', 1, 19, 'female', 'male', 'Hi, I\'m Melissa Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 139.638026, 35.443708, 67, 0, NULL),
('7e34052c-f017-4236-a938-2bc57ea6cd77', 'mary364@example.com', 'Mary364', 'Mitchell', 'Mary', '2f639c8af2ad8d6bc3451c210153d9a82cb8a226d6c9b6836b26cd9d9205403a', 1, 53, 'female', 'male', 'Hi, I\'m Mary Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 3.087025, 45.777222, 88, 1, NULL),
('7e76a5f3-54a7-4fac-84c6-e2ae015c2305', 'jonathan367@example.com', 'Jonathan367', 'White', 'Jonathan', 'ecb5b0acff82af3ec07eded91679883dba2d7a57cef9725fc0dc530138c2e4c9', 0, 65, 'male', 'female', 'Hi, I\'m Jonathan White, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -122.419416, 37.774929, 41, 1, NULL),
('7ebd258f-fca9-4599-95a9-05414ac26382', 'paul440@example.com', 'Paul440', 'Roberts', 'Paul', '6a94e504587d55313f1263874f4725e3eda31746944c4a961c406b87bf54f402', 1, 57, 'male', 'female', 'Hi, I\'m Paul Roberts, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 135.768029, 35.011636, 40, 0, NULL),
('7eccb877-0d46-4299-9110-34473e6ce4d7', 'ashley303@example.com', 'Ashley303', 'Garcia', 'Ashley', '47eccaf210b519f43c06494401bbcc02066d6c54cc30a19a763a532c04c5c34c', 1, 44, 'female', 'female', 'Hi, I\'m Ashley Garcia, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -118.243683, 34.052235, 58, 1, NULL),
('7ef1956b-2fa2-4075-9f86-2e49c31a26be', 'brenda337@example.com', 'Brenda337', 'Hernandez', 'Brenda', '91a51aa7f8b3dcc3ecc49826291193c21dbe78f7109e9dae30446490a7d17fbc', 0, 33, 'female', 'male', 'Hi, I\'m Brenda Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 2.295753, 49.894067, 89, 1, NULL),
('7f5595e4-0ce2-4528-a6ae-77db52fe6772', 'terry435@example.com', 'Terry435', 'Walker', 'Terry', 'b86dc6ff0436f2b84e082922bf2563945db06a7ebbaae5cdb5109a52dc8f24f6', 1, 43, 'male', 'female', 'Hi, I\'m Terry Walker, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 2.173404, 41.385064, 50, 1, NULL),
('7f74b4e2-0a7f-4d5a-93e1-d6df2e63f9c2', 'sarah22@example.com', 'Sarah22', 'Robinson', 'Sarah', 'd23c1038532dc71d0a60a7fb3d330d7606b7520e9e5ee0ddcdb27ee1bd5bc0cd', 0, 85, 'female', 'male', 'Hi, I\'m Sarah Robinson, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 3.876716, 43.610769, 72, 1, NULL),
('8062b059-a51b-457b-a804-439f51b4ba8e', 'heather60@example.com', 'Heather60', 'Robinson', 'Heather', '25b30bd22b6218deda2022fccd2c726bd6da37b4b624ca72028b587bed7b8908', 1, 95, 'female', 'male', 'Hi, I\'m Heather Robinson, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 141.354376, 43.062096, 71, 0, NULL),
('808f7242-7f01-4c5b-a8db-210b7d89d373', 'stephen219@example.com', 'Stephen219', 'Walker', 'Stephen', 'bb3ad11b9f6d9216eefc0d9f487b2811934bfe59e85113cec9e8ae2c060261c2', 0, 100, 'male', 'male', 'Hi, I\'m Stephen Walker, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', -5.984459, 37.389092, 80, 1, NULL),
('81657544-b4a5-472c-a276-c6918d9fc0d5', 'noah193@example.com', 'Noah193', 'Young', 'Noah', 'a30ce92dc2ed0edc9480b4e7978d63f9bbbf165fe4f99d5d73740c823cc605d7', 1, 76, 'male', 'female', 'Hi, I\'m Noah Young, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 3.876716, 43.610769, 90, 0, NULL),
('81bfb157-9399-4456-91f6-0464673626ab', 'joan488@example.com', 'Joan488', 'Robinson', 'Joan', '5fea9b6b93faa8613e4d075ff43be853dbf10d2e5e5972d0585c04a5163791cd', 0, 35, 'female', 'male', 'Hi, I\'m Joan Robinson, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -98.493629, 29.424122, 19, 1, NULL),
('82069832-db5f-4516-b46a-2e81747a00db', 'stephen8@example.com', 'Stephen8', 'Robinson', 'Stephen', '57f3ebab63f156fd8f776ba645a55d96360a15eeffc8b0e4afe4c05fa88219aa', 0, 48, 'male', 'male', 'Hi, I\'m Stephen Robinson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -96.796988, 32.776664, 89, 0, NULL),
('822f5184-52a2-41a3-9121-5b2ae9c6f5e4', 'angela135@example.com', 'Angela135', 'Garcia', 'Angela', '41c52b123c21d057c0c940e03599bf91d66ff19f8aea217bc7519c39178bc748', 1, 87, 'female', 'male', 'Hi, I\'m Angela Garcia, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 132.455293, 34.385203, 43, 1, NULL),
('83c3e264-f789-4b67-9cae-d064d9ecf3be', 'frances436@example.com', 'Frances436', 'Torres', 'Frances', '638b74ea554faf26a799b05ea4b1009b9fd6cff8d4c1b6143f106a5005b305bf', 0, 99, 'female', 'male', 'Hi, I\'m Frances Torres, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 140.869356, 38.268215, 6, 0, NULL),
('84ab463a-2b0e-46cc-b52e-3858a195d333', 'jeremy163@example.com', 'Jeremy163', 'Young', 'Jeremy', '3799dc1c28c7ab7e57696aa15c6415615bbafb33ecd9a184c68fa88a6c6d2e77', 1, 89, 'male', 'female', 'Hi, I\'m Jeremy Young, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -80.843127, 35.227087, 9, 1, NULL),
('8529ea9a-fe50-4fde-bd81-62e92494da14', 'diane173@example.com', 'Diane173', 'Walker', 'Diane', '64dd501b7c8f70c466a854f0c905f6fbb96af29015b4e1c5d02df40c2ae84792', 0, 95, 'female', 'male', 'Hi, I\'m Diane Walker, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -95.369804, 29.760427, 97, 1, NULL),
('856070dc-7723-4fba-8e54-a865b8b05aba', 'shirley98@example.com', 'Shirley98', 'Torres', 'Shirley', '1a52ea1a2b0f7dbbc246387f37b6a1ee0bae2a7d3de65139e54dbd325a8cdf8d', 0, 71, 'female', 'male', 'Hi, I\'m Shirley Torres, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', -0.579180, 44.837789, 17, 1, NULL),
('858ab9cc-90d2-4479-9d0e-db90c3e5b43d', 'edward124@example.com', 'Edward124', 'Wilson', 'Edward', '33631376724e5d5480fa397dfcf03b66ad47b934ab495174d7058c38f2bb0087', 1, 51, 'male', 'female', 'Hi, I\'m Edward Wilson, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -81.655651, 30.332184, 62, 0, NULL),
('85bda754-0d61-4b91-8c3a-9436c4b60fb7', 'matthew52@example.com', 'Matthew52', 'Mitchell', 'Matthew', '9626a29ac1d7006741337f6ebc6a5a41cfdc3aa65d2b10ff9cda937c6a7fd35b', 0, 44, 'male', 'female', 'Hi, I\'m Matthew Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 13.402720, 52.517251, 5, 1, NULL),
('85d510ac-407c-4d96-b9a0-e189b7e901b0', 'judith326@example.com', 'Judith326', 'Nguyen', 'Judith', '2fc2980f8a9acaf990ba2c1cd4a562a0df3db8e4fbe482945d510980f81c30b9', 1, 43, 'female', 'male', 'Hi, I\'m Judith Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 136.906398, 35.181446, 39, 1, NULL),
('8702b339-2857-4dd3-9c40-550ecb26c989', 'nicholas410@example.com', 'Nicholas410', 'Walker', 'Nicholas', '9839577004662fe704df54b0e7a389ab5539743c2a69bba42e180f539a876ce6', 0, 47, 'male', 'female', 'Hi, I\'m Nicholas Walker, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', -112.074037, 33.448377, 81, 0, NULL),
('8719e4d7-a1e2-412c-a9a8-baaeed5e26a6', 'kyle18@example.com', 'Kyle18', 'Williams', 'Kyle', 'd2042d75a67922194c045da2600e1c92ff6d87e8fb6e0208606665f2d1dfa892', 1, 27, 'male', 'female', 'Hi, I\'m Kyle Williams, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 133.919502, 34.655146, 70, 1, NULL),
('8727a67e-1a50-48bb-b854-355c3ec200ea', 'ruruover1105@gmail.com', 'stephan', 'Guard', 'Stephan', '$2b$10$mMYjgSdxFG0uVcGeOePBqeL3GhiEVDo/9fZOOiZ1xeWLyuD9nP4ia', 1, 30, 'male', 'female', 'have fun', 'http://localhost:4000/uploads/stephanie-cook-NDCy2-9JhUs-unsplash.jpg', '', '', '', '', '', 2.336185, 48.885884, 0, 0, NULL),
('874287c1-d6cf-42e1-87e2-1015aa6e4139', 'samuel473@example.com', 'Samuel473', 'Miller', 'Samuel', '25c1fe42c495e799d2c99b081365d12e1da7caec283460ec164a332108eb2d15', 1, 81, 'male', 'female', 'Hi, I\'m Samuel Miller, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 7.752111, 48.573405, 83, 1, NULL),
('885090c6-6774-4f85-a74d-87e07891dd2e', 'lauren49@example.com', 'Lauren49', 'Moore', 'Lauren', '3cd00931dd1de5d07fcafb463ba5c4d95d31dca8a35480cac4a2beb771cb90df', 1, 68, 'female', 'male', 'Hi, I\'m Lauren Moore, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 141.354376, 43.062096, 51, 0, NULL),
('886c4fb1-78f0-413c-9449-d2851bbc8049', 'jacob21@example.com', 'Jacob21', 'Garcia', 'Jacob', '91a9ef3563010ea1af916083f9fb03a117d4d0d2a697f82368da1f737629f717', 0, 76, 'male', 'female', 'Hi, I\'m Jacob Garcia, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 1.099971, 49.443232, 57, 1, NULL),
('88b5a2ca-9295-4999-bcf2-1c496f00f283', 'laura136@example.com', 'Laura136', 'Roberts', 'Laura', '6684f5edecf3ee57dee572b07e1fe5754b1636e52daa5e9ab5aad347b2f0b870', 0, 30, 'female', 'male', 'Hi, I\'m Laura Roberts, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 3.057256, 50.629250, 78, 1, NULL),
('88c57f66-920a-4b95-bad8-0add1b261746', 'dennis214@example.com', 'Dennis214', 'Rivera', 'Dennis', '6b09f691894c543ee6ef078bd9e5db9a51ed30e3debcc9c1d008b49dbc47efad', 0, 49, 'male', 'female', 'Hi, I\'m Dennis Rivera, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -98.493629, 29.424122, 14, 0, NULL),
('8932d40f-62dd-45b9-a3ce-e684c0f9c7bf', 'steven28@example.com', 'Steven28', 'Johnson', 'Steven', '6f5ea1c4acc7a563ea8cb3381a55f0183a2394d679ebb7db8312e047bbf87e0d', 1, 81, 'male', '', 'Hi, I\'m Steven Johnson, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', -122.419416, 37.774929, 96, 1, NULL),
('89567159-bbfe-43ff-af41-954e9e32325d', 'keith296@example.com', 'Keith296', 'Martinez', 'Keith', '377196a13b7d95a4db87390e2813740a5e691d61a4ebb57552724d5c762dac9a', 1, 54, 'male', 'female', 'Hi, I\'m Keith Martinez, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -98.493629, 29.424122, 45, 0, NULL),
('8a459a74-8f72-407d-8970-63b6a1c486fd', 'michelle40@example.com', 'Michelle40', 'Baker', 'Michelle', '825e233a9d192f81d3f6780cb8e181af518054a8d9c83381882e573eed014df2', 0, 47, 'female', '', 'Hi, I\'m Michelle Baker, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -96.796988, 32.776664, 100, 0, NULL),
('8aeb33cf-d715-48f7-becd-85297a50f8dd', 'larry496@example.com', 'Larry496', 'Nguyen', 'Larry', 'a583ffc59a322e57c465251b142c4f98aa5bc74afe3eef5a2df63e27b5863dd6', 0, 24, 'male', 'female', 'Hi, I\'m Larry Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -75.165222, 39.952584, 77, 0, NULL),
('8c3a1994-8fce-439e-9f93-a26a833b023b', 'amanda112@example.com', 'Amanda112', 'Lopez', 'Amanda', 'd46b5cd9c1456e3059258a411faf8bbb0253c190cc5acb488f999e1b1421f83b', 1, 81, 'female', 'male', 'Hi, I\'m Amanda Lopez, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', -82.998794, 39.961176, 42, 0, NULL),
('8c6be0a0-eca5-4203-88da-e24daca7d608', 'jack322@example.com', 'Jack322', 'Gonzalez', 'Jack', 'ccb30e829fb873824f12610650b9459fbb3b25e55faf260beddd658255d7d22e', 0, 36, 'male', '', 'Hi, I\'m Jack Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -74.005974, 40.712776, 77, 1, NULL),
('8ccb56b7-fd22-4ac6-b2f6-d3b177af0aac', 'david127@example.com', 'David127', 'Harris', 'David', '4fa29f8e091719146327604cc5d6e112b1999134dbefbf05f991f5c0fd648017', 0, 78, 'male', 'female', 'Hi, I\'m David Harris, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -112.074037, 33.448377, 2, 0, NULL),
('8d399db9-1ac0-4588-ad4f-8ba8408f89d1', 'samantha443@example.com', 'Samantha443', 'Moore', 'Samantha', '82ad15bdf231fd487a591125b242831bc0f6ce720f9ab88c1c3fffe55e34c841', 0, 86, 'female', 'male', 'Hi, I\'m Samantha Moore, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 139.829356, 35.841208, 87, 1, NULL),
('8e6e6dd9-b85f-45d7-b687-55c9bff80c42', 'kyle278@example.com', 'Kyle278', 'Clark', 'Kyle', '8b496afc2a040ddb7aa88177e0516c9f31997160e8c489b4642c9d0d55a6e2d8', 0, 37, 'male', 'female', 'Hi, I\'m Kyle Clark, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 7.261953, 43.710173, 18, 0, NULL),
('8eb9f32e-4b7d-476b-b666-e811ac19d5de', 'douglas444@example.com', 'Douglas444', 'Williams', 'Douglas', '2ce45fb0bf5e07f9a599b713bf3981dfe94a0be138b18e74ceaed1f894cb0202', 1, 86, 'male', 'female', 'Hi, I\'m Douglas Williams, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 135.502165, 34.693738, 95, 0, NULL),
('8ef0b4b1-5e35-4a13-9980-f2c206aa1d31', 'thomas448@example.com', 'Thomas448', 'Flores', 'Thomas', 'e2fa70b68f37d38e4ff945dfe895d8a548ba0cda6f3230c8818629a106164e7a', 1, 31, 'male', '', 'Hi, I\'m Thomas Flores, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 2.295753, 49.894067, 44, 0, NULL),
('90076db9-de52-4c1a-96a5-5512f26cd2d8', 'nicole235@example.com', 'Nicole235', 'Sanchez', 'Nicole', 'ca22324a93e96ec588c9b9ed5c47f8337182bdb2378da0f409cd6d8b7174f5ee', 0, 27, 'female', 'male', 'Hi, I\'m Nicole Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 135.502165, 34.693738, 8, 0, NULL),
('9190206a-aaf5-4af6-bfe9-31e468e621b0', 'ruth389@example.com', 'Ruth389', 'Jackson', 'Ruth', '60cbbdd5ef5c88db04da55cfb05743475a24084cc75dff84abc026b58e7919e2', 0, 47, 'female', 'male', 'Hi, I\'m Ruth Jackson, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 135.195511, 34.690083, 84, 1, NULL),
('929dd0cb-0327-42b8-a4e5-ba27453d4705', 'carolyn421@example.com', 'Carolyn421', 'Martin', 'Carolyn', '0aa1ce901b2418145e83fbffea1297ca32c29ce5a5eb460a4159be8347e7dbed', 1, 88, 'female', 'male', 'Hi, I\'m Carolyn Martin, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -0.579180, 44.837789, 37, 1, NULL),
('92f2365e-b481-4c77-964a-12576f01ce62', 'maria7@example.com', 'Maria7', 'Baker', 'Maria', '5860836e8f13fc9837539a597d4086bfc0299e54ad92148d54538b5c3feefb7c', 1, 74, 'female', 'male', 'Hi, I\'m Maria Baker, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -118.243683, 34.052235, 16, 1, NULL),
('92f60426-9b27-4e92-9fcc-1ea470271053', 'paul494@example.com', 'Paul494', 'Hernandez', 'Paul', '4da5e3e139c5f28c170c9658d0934f97d8dccc27eda1ccd226f18660aad3be1d', 1, 88, 'male', 'female', 'Hi, I\'m Paul Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 7.261953, 43.710173, 55, 0, NULL),
('9425a1a6-2225-41ff-8187-181352f05d5a', 'dorothy333@example.com', 'Dorothy333', 'Jones', 'Dorothy', 'b251019da9d473a1fca39713db51d7f612c93faa88bfc2ebe4f07dcfd47fd266', 0, 94, 'female', 'male', 'Hi, I\'m Dorothy Jones, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -98.493629, 29.424122, 81, 0, NULL),
('94b6294c-b68e-4041-ae18-0bcfb727f6d8', 'joan392@example.com', 'Joan392', 'Hernandez', 'Joan', 'd29cbd0f5de559e06f811ba9c64123b69e8e6b84c4bb09e5095f05b984a85770', 0, 57, 'female', 'male', 'Hi, I\'m Joan Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 136.906398, 35.181446, 46, 1, NULL),
('9523ed41-8672-47d8-87d5-8478c12ca47a', 'kathleen380@example.com', 'Kathleen380', 'Jackson', 'Kathleen', '4456a1fcb1bd3961479c6c139cd7cc8fe415827c186a4810d03e3e9447d5c9bd', 0, 40, 'female', 'male', 'Hi, I\'m Kathleen Jackson, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 5.369780, 43.296482, 47, 1, NULL),
('955f3fc5-52e6-40e1-be0e-cedf4771b19d', 'linda252@example.com', 'Linda252', 'Jackson', 'Linda', '9e048385c3b8404ab3df0f98794b961db11b9f560f2c97a0e331f983b616b91e', 1, 29, 'female', 'male', 'Hi, I\'m Linda Jackson, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -1.553621, 47.218371, 55, 1, NULL),
('95702a6f-8645-43ed-a6fa-328cd8b05285', 'brenda386@example.com', 'Brenda386', 'Ramirez', 'Brenda', 'a2872c9e8228c1539b214fe7a8d91adc3705046d0b8e5f0cb4268ba0c3b7368c', 1, 51, 'female', 'male', 'Hi, I\'m Brenda Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -121.886329, 37.338208, 84, 0, NULL);
INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES
('95f6d58f-891e-425a-938f-346f4b712194', 'kathleen314@example.com', 'Kathleen314', 'Davis', 'Kathleen', 'ca6b157fdb0985287d92c4493e6837ce99f1927e374220b511ce020f52fd7cb1', 0, 80, 'female', 'male', 'Hi, I\'m Kathleen Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -118.243683, 34.052235, 38, 0, NULL),
('96cb9492-3fe8-4ae2-ab94-f32f05d63a3f', 'jeffrey256@example.com', 'Jeffrey256', 'Adams', 'Jeffrey', 'cbd1899da8525137a9255548990090624d1c545a083a48828d85b8cb9c550f43', 0, 67, 'male', 'female', 'Hi, I\'m Jeffrey Adams, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 136.906398, 35.181446, 94, 0, NULL),
('96d306e6-4afa-43f7-8354-c6b2fb2196dc', 'ashley255@example.com', 'Ashley255', 'Jones', 'Ashley', 'd99d016eba4dc377d4182e971a67e87cc54c4a27826e13bd4ca39060a0525fdb', 0, 41, 'female', 'male', 'Hi, I\'m Ashley Jones, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 132.455293, 34.385203, 57, 1, NULL),
('9714735e-06a5-4d3d-8978-55151f1e060d', 'patricia120@example.com', 'Patricia120', 'Torres', 'Patricia', '43d496703f53d1c01e3365c49d173c6130a00ff6a5d3e613c228bb5e7d23bec8', 0, 71, 'female', 'male', 'Hi, I\'m Patricia Torres, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -81.655651, 30.332184, 67, 0, NULL),
('97ba881c-dffd-440d-85aa-1946142ee5a5', 'emma29@example.com', 'Emma29', 'Jackson', 'Emma', '48a94846b2a7386432b90ad13bcf9c66f1efdd3a97e0e14968c262c412fe22c8', 1, 45, 'female', 'male', 'Hi, I\'m Emma Jackson, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 135.768029, 35.011636, 30, 1, NULL),
('97dfea24-8979-42e7-9e21-04ae3bbb1fe2', 'joan430@example.com', 'Joan430', 'Moore', 'Joan', '64ea23e86124b199b71fda952a2650c3300c8361bae3af43556360004c6ad987', 1, 63, 'female', 'male', 'Hi, I\'m Joan Moore, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -117.161084, 32.715738, 85, 0, NULL),
('985129f5-ccc1-4e0b-bd8d-0f903dd4884f', 'noah53@example.com', 'Noah53', 'Campbell', 'Noah', 'a60f6d009343ab015ee59fa2ff29e5aa12dd69aa7a7285f15e1fdec6ce7407d7', 0, 58, 'male', 'female', 'Hi, I\'m Noah Campbell, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 4.351721, 50.850346, 79, 0, NULL),
('9917a1aa-b6ac-4fd6-ba4f-89c79556cfcc', 'kathryn293@example.com', 'Kathryn293', 'Martinez', 'Kathryn', '9aa7e78d836399905ed187c9258088b0e773a8d18d6a867639d5874061f8658e', 0, 38, 'female', '', 'Hi, I\'m Kathryn Martinez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 1.099971, 49.443232, 25, 1, NULL),
('992393dd-17f4-4fa9-aeec-bb04dd3589a8', 'charles104@example.com', 'Charles104', 'Torres', 'Charles', '825242929f5adfd5c4b9318e95c1a83584367d888172d1453ef3a855ed704453', 0, 88, 'male', 'female', 'Hi, I\'m Charles Torres, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 2.295753, 49.894067, 67, 0, NULL),
('99573612-24be-421a-b883-0be5cd34b382', 'patrick464@example.com', 'Patrick464', 'Garcia', 'Patrick', '545b9ad305d8202424a439b3aeb89250aa6bb74dd1cf51e738393cb9d474e2e7', 1, 35, 'male', 'female', 'Hi, I\'m Patrick Garcia, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', -121.886329, 37.338208, 36, 1, NULL),
('99672653-ec0e-4466-8dea-77d839469d5a', 'mary64@example.com', 'Mary64', 'Miller', 'Mary', '863ecfd7228c0856c236ce48331bf756489d8faade33e7d8d8762c52841a4f58', 1, 64, 'female', 'male', 'Hi, I\'m Mary Miller, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 4.351721, 50.850346, 58, 0, NULL),
('996ec40d-99cb-46e1-a746-4336459707f0', 'janet77@example.com', 'Janet77', 'Baker', 'Janet', '3ce2c52df9e92052d433b2449b5f33dd97c344aaeffd9f5e006a3ae933126a5a', 1, 91, 'female', 'male', 'Hi, I\'m Janet Baker, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -95.369804, 29.760427, 73, 0, NULL),
('9a005b00-60c2-4f6a-9f1d-4fbc7f46c729', 'linda86@example.com', 'Linda86', 'Hernandez', 'Linda', 'a6ece1b636088887bed0d98612613b3700fe1425531d8726c5fc973a61e8dde3', 0, 72, 'female', 'male', 'Hi, I\'m Linda Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 2.173404, 41.385064, 44, 0, NULL),
('9a2d263c-117b-4528-9d63-178c530c6963', 'katherine452@example.com', 'Katherine452', 'Jones', 'Katherine', '59857bf565d3f2ae6cce0031c389699031bc4d5dfded48b9b7d0f860ab0f14c6', 1, 96, 'female', '', 'Hi, I\'m Katherine Jones, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -3.703790, 40.416775, 29, 1, NULL),
('9ae83745-c3e6-4c47-8f25-4c23c534702c', 'anna166@example.com', 'Anna166', 'Torres', 'Anna', '4bd56a2f187ee54db088bdcbc7e573152d8be76de702da40f98400344da74f45', 1, 69, 'female', 'male', 'Hi, I\'m Anna Torres, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 140.869356, 38.268215, 10, 1, NULL),
('9b20ef8d-c721-4daa-8150-db99daef0719', 'jessica290@example.com', 'Jessica290', 'Robinson', 'Jessica', 'e8b1715d9c90356415faac5f3d5309d993d19acbe00f4f76cbc345a007a3d30a', 0, 45, 'female', 'female', 'Hi, I\'m Jessica Robinson, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 133.919502, 34.655146, 43, 0, NULL),
('9b3b5571-843d-464f-bd91-b70eb81ac7f4', 'edward181@example.com', 'Edward181', 'Robinson', 'Edward', 'db6fddcae96fed748492477e226594b3d7cbc091b2901cbdb496258f6017a8da', 0, 52, 'male', 'female', 'Hi, I\'m Edward Robinson, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -5.984459, 37.389092, 47, 1, NULL),
('9c4a2a41-8bee-4791-99ad-7563a5d7c271', 'larry189@example.com', 'Larry189', 'White', 'Larry', '9950f5f8048174b5ff67e58193c5b2deb271dc7b4253f13bf64667017b769b83', 1, 55, 'male', 'female', 'Hi, I\'m Larry White, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 7.752111, 48.573405, 57, 1, NULL),
('9cc0b285-b413-4492-8193-e5431272f5f6', 'tsujimarico@gmail.com', 'Mamariko', 'Mamariko', 'Mamariko', '$2b$10$qlyVr9yUXCTSSFb4B6tlVevj9sybIqVz/E2Kxipq1MPwjjjnGZMzG', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('9cccbf26-44b5-4ef9-92fa-faa500dcbc06', 'ronald94@example.com', 'Ronald94', 'Robinson', 'Ronald', '639b2151255f1fadb444ef3fdcc9ade5fdb385395b338528746905ba8c52ba27', 0, 60, 'male', '', 'Hi, I\'m Ronald Robinson, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 3.717424, 51.054342, 86, 0, NULL),
('9cf73f51-9498-462c-b7cc-33e1fe0834af', 'brenda223@example.com', 'Brenda223', 'Ramirez', 'Brenda', '1f4a391b7cc36e2f63c283553b3ab4f9c04e77d79cd1afcc6734c3a55f731eec', 1, 34, 'female', 'male', 'Hi, I\'m Brenda Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -1.558626, 43.483152, 23, 0, NULL),
('9d55e87c-67d9-4a81-9111-d34668694bff', 'harold48@example.com', 'Harold48', 'Ramirez', 'Harold', '172e362eecb6dff98dbeb4a7c42367109c1b288ecf45ff271fb79acd352ba8f9', 1, 99, 'male', 'male', 'Hi, I\'m Harold Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 7.261953, 43.710173, 0, 0, NULL),
('9d98a5ae-14e0-4f17-b430-70e1d28e5dd6', 'emma178@example.com', 'Emma178', 'Young', 'Emma', '1d708582f753c5849445355e276afb64f5c1c309f23979d59c665f49fe13f9f0', 1, 35, 'female', 'male', 'Hi, I\'m Emma Young, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 140.869356, 38.268215, 28, 1, NULL),
('9ea19407-a708-4880-a327-ba8d43d20791', 'nicole344@example.com', 'Nicole344', 'Williams', 'Nicole', '1973b271faf221830075b0e8d760621dd6ba2c9548bdedbdf7db424acc92c87f', 1, 56, 'female', 'female', 'Hi, I\'m Nicole Williams, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -122.419416, 37.774929, 94, 0, NULL),
('9ec4c4ca-978b-434d-8302-b4ad68565c4c', 'ruruover1105@gmail.com', 'melo', 'italo', 'melo', '$2b$10$ZV9Gi0zu4nRZki30973SG.W0aXFLIiUO9haCBygmC4GXBGRSCU2Qe', 1, 28, 'male', 'female', 'let\'s chill', 'http://localhost:4000/uploads/pexels-italo-melo-2379005.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 2.336149, 48.885829, 0, 0, NULL),
('9f5297ba-6a66-477f-95c5-05444f3adeae', 'rebecca387@example.com', 'Rebecca387', 'Anderson', 'Rebecca', '75092dfe3be8d81f59e95ae0565dd2ca78bdb7027acd298d1e3c62199e1da320', 1, 99, 'female', 'male', 'Hi, I\'m Rebecca Anderson, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -98.493629, 29.424122, 0, 1, NULL),
('a22ee1a1-8f79-474c-96a6-359b2d2071ff', 'ethan25@example.com', 'Ethan25', 'Campbell', 'Ethan', '0b544d6d8da1d1af25318e97e0ac5f6bc70bba49919463dc0074ede01a49d381', 0, 67, 'male', 'female', 'Hi, I\'m Ethan Campbell, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -95.369804, 29.760427, 5, 0, NULL),
('a23d59f4-7923-4191-9937-298533e33ba9', 'jack335@example.com', 'Jack335', 'Torres', 'Jack', '33e8d96b74d3d35898642092d9501719fcc07fe66639b0229ae985187bf72bce', 1, 65, 'male', 'female', 'Hi, I\'m Jack Torres, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -112.074037, 33.448377, 28, 0, NULL),
('a25ac425-c020-4886-a97c-25ea4218c5ee', 'kathleen154@example.com', 'Kathleen154', 'Wilson', 'Kathleen', 'f0f3e48732b78498f8184c0f848677df155e6e71aa16722650447e654511abb1', 1, 59, 'female', 'male', 'Hi, I\'m Kathleen Wilson, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -87.629799, 41.878113, 27, 0, NULL),
('a2a6d47f-c670-4d0f-9a29-3e3abd547be6', 'andrea318@example.com', 'Andrea318', 'Roberts', 'Andrea', '9dbe4059bb7623c293b39d66a0cd27f9d806872b5b0df4f33b5266e9c0b4c135', 1, 68, 'female', 'male', 'Hi, I\'m Andrea Roberts, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 4.351721, 50.850346, 2, 1, NULL),
('a34456c6-9e1a-44fe-b3cf-907fb616db02', 'john446@example.com', 'John446', 'Lopez', 'John', '2c90060dae06ce761b51015bad8f2343a274c7144d135ab912d316c2cb8cad0b', 0, 39, 'male', 'female', 'Hi, I\'m John Lopez, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 21.011486, 52.225406, 26, 1, NULL),
('a3a95d4c-cd9c-4303-9ca9-f3ca13e276d2', 'victoria350@example.com', 'Victoria350', 'Harris', 'Victoria', 'b6d60c0501d4b27f505aae6b3edec725d1deb03352b64b894741d98da786662b', 1, 20, 'female', 'male', 'Hi, I\'m Victoria Harris, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -74.005974, 40.712776, 3, 0, NULL),
('a3f8ca9c-da8b-45f4-b70d-cf656653abd9', 'nicole277@example.com', 'Nicole277', 'Lewis', 'Nicole', '3b2f5b3b5febf284c16b2bd7da05f26dd403ff6d3f0190bc18444a42c3ca3829', 0, 55, 'female', '', 'Hi, I\'m Nicole Lewis, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 3.057256, 50.629250, 52, 0, NULL),
('a4e20e88-1880-4d97-969d-6adce449d0d9', 'kathleen180@example.com', 'Kathleen180', 'Robinson', 'Kathleen', 'cddd0f946a214cce0bc200f9ec0b46936ed483e87acfbe505a2dfec0ad9cf27b', 0, 32, 'female', 'male', 'Hi, I\'m Kathleen Robinson, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', -112.074037, 33.448377, 56, 0, NULL),
('a51a9382-e2cd-4ea9-a501-b9f7b8917aee', 'michael338@example.com', 'Michael338', 'Flores', 'Michael', '7ea24b3da50a71f79143520190418dad9c79577c14e8c9b4b53fa050e0be0924', 1, 69, 'male', 'female', 'Hi, I\'m Michael Flores, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -75.165222, 39.952584, 96, 1, NULL),
('a5418b15-1157-4c35-8d33-e92c5ef23f41', 'jeffrey462@example.com', 'Jeffrey462', 'Wilson', 'Jeffrey', 'e2518f2fb32cad66d4651481b591cb1be1a6eaa2ec960d65334ae7e7c23941b9', 0, 41, 'male', 'female', 'Hi, I\'m Jeffrey Wilson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -1.553621, 47.218371, 30, 0, NULL),
('a544d801-2bd2-403e-98bc-5135b7b3cd9e', 'charles292@example.com', 'Charles292', 'Torres', 'Charles', 'd3b2793dc3cfcb931e825b2babf0353310626e41dd529bcbe5d93bdb94d19966', 1, 62, 'male', 'female', 'Hi, I\'m Charles Torres, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -87.629799, 41.878113, 37, 1, NULL),
('a5cd9a5e-2a18-4ff5-938b-a482cc2bd144', 'kathleen108@example.com', 'Kathleen108', 'Clark', 'Kathleen', '2f17420c172e9e934450105eb1c36dd2614eed322e5df28451bede05ad0f2e71', 1, 88, 'female', 'male', 'Hi, I\'m Kathleen Clark, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 7.752111, 48.573405, 48, 0, NULL),
('a60174c1-0455-4b9b-a881-3b4272742c87', 'rebecca116@example.com', 'Rebecca116', 'Harris', 'Rebecca', '252acd35e7485aa79b5d30daedd4b463e164f0b2fb403e770a5445a6dc046f3e', 0, 51, 'female', 'male', 'Hi, I\'m Rebecca Harris, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', -1.553621, 47.218371, 9, 1, NULL),
('a68d238b-936c-4219-bca9-b7205eb85118', 'christina36@example.com', 'Christina36', 'Allen', 'Christina', '9777509ca199ac591368c5cfa9ef92b4879ff99098b7e34865172a5ea983542e', 1, 33, 'female', 'male', 'Hi, I\'m Christina Allen, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 139.638026, 35.443708, 83, 1, NULL),
('a6969dd6-0a83-486e-80dd-a868ce3f3475', 'andrew222@example.com', 'Andrew222', 'Martin', 'Andrew', 'facbd7953fa9ee64e1c57738eae96c5f32c415b370111de2b3cfa6b59b23ad00', 0, 43, 'male', 'male', 'Hi, I\'m Andrew Martin, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 135.768029, 35.011636, 54, 0, NULL),
('a6f5ad04-9386-4cb1-8b5e-a84bfb3a6b21', 'larry321@example.com', 'Larry321', 'Allen', 'Larry', 'a20aff106fe011d5dd696e3b7105200ff74331eeb8e865bb80ebd82b12665a07', 0, 73, 'male', 'female', 'Hi, I\'m Larry Allen, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 1.099971, 49.443232, 53, 1, NULL),
('a768f8e8-39fa-4b10-8b50-c9eab51c8fad', 'robert24@example.com', 'Robert24', 'Flores', 'Robert', 'fc8a9296208a0b281f84690423c5d77785e493f435e6292cc322840f543729d3', 1, 23, 'male', 'female', 'Hi, I\'m Robert Flores, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -5.984459, 37.389092, 18, 1, NULL),
('a76c0583-7764-4c6e-8106-68afc6d52df4', 'edward273@example.com', 'Edward273', 'Nguyen', 'Edward', '8386af341f6d011104809d1e7d05d88d988350078bc9a9b83a05c97ac57a182f', 0, 83, 'male', 'female', 'Hi, I\'m Edward Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 13.402720, 52.517251, 12, 0, NULL),
('a76d1f70-edfd-466c-8baf-f983afd86b8c', 'kathleen395@example.com', 'Kathleen395', 'Anderson', 'Kathleen', '0448b9982735d3bc82b8e1b92cefa945cc929435ccbddb233e3cd39a89372568', 1, 59, 'female', 'male', 'Hi, I\'m Kathleen Anderson, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -1.553621, 47.218371, 13, 0, NULL),
('a800329e-9173-4135-9bb9-c0b3fcf1f123', 'donald499@example.com', 'Donald499', 'Davis', 'Donald', '648fb94b2ccff190a7389c061a91f37b499d904f3401e15442c7ed0e5cf0dc64', 0, 24, 'male', 'female', 'Hi, I\'m Donald Davis, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -5.984459, 37.389092, 62, 1, NULL),
('a8265034-0fb5-48ae-9cba-13996bfcb232', 'patricia188@example.com', 'Patricia188', 'Walker', 'Patricia', '1abe2e185971bb5ff83d5bcf730934bd29b8f94ca0cce14cf06755122a5f4f7e', 0, 87, 'female', 'male', 'Hi, I\'m Patricia Walker, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 127.680932, 26.212401, 42, 0, NULL),
('a84fb676-59c7-48e7-b129-0e9386d6ebfb', 'timothy497@example.com', 'Timothy497', 'Rodriguez', 'Timothy', '464e4407c877291fde1746a2b45333b9907ab42ab6f331505e841e20029be12f', 1, 38, 'male', 'female', 'Hi, I\'m Timothy Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 138.388475, 34.971855, 72, 0, NULL),
('a936abb3-5b78-46c6-963f-cead9d3c90f4', 'kenneth317@example.com', 'Kenneth317', 'Jackson', 'Kenneth', '95070c7e35b9290f7bdf5dd5510f5da34aac789011ce7f9afe5329f8e43cb317', 1, 33, 'male', 'female', 'Hi, I\'m Kenneth Jackson, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 140.869356, 38.268215, 1, 0, NULL),
('a9abdf95-1d25-4f62-b0ac-a915745fbbe1', 'jacqueline403@example.com', 'Jacqueline403', 'Perez', 'Jacqueline', 'f8ffb0f0214d65542f26e68ebe949efff5d28f7b5069daf3906dc8358eda50b4', 1, 92, 'female', 'male', 'Hi, I\'m Jacqueline Perez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 135.502165, 34.693738, 57, 0, NULL),
('a9c961e2-ed52-45d0-9d6a-b6117f6f9454', 'tsujimarico@icloud.com', 'TestUser', 'TSUJI', 'Mariko', '$2b$10$/MtaCdTrmVyBDJugRh3JY.JtfUfrRsWLc1AoGjBIRQfiuMkwMBkCC', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('aa054b9a-5c79-4c41-942b-bb54dcf3adbc', 'charles211@example.com', 'Charles211', 'Allen', 'Charles', '6e2c900e224a38be84df8b91da0e2e36f9d07fcde6fdf5bd7539970d536dbab0', 1, 35, 'male', 'female', 'Hi, I\'m Charles Allen, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 7.261953, 43.710173, 96, 0, NULL),
('aa154681-5747-45d6-9263-5307610e0edd', 'ruth167@example.com', 'Ruth167', 'Carter', 'Ruth', '00cb62e42b8f2bbbf028ae9b3dee3ec4a9d4dfa8b87f1b0535f642eb3d40990f', 1, 49, 'female', 'male', 'Hi, I\'m Ruth Carter, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 135.768029, 35.011636, 99, 1, NULL),
('ab156ecb-fd2f-4fbf-a8c5-a91ec6d31df5', 'ruth100@example.com', 'Ruth100', 'White', 'Ruth', 'b3351ed9be23d5ad99cc73bdc1aed73913503f064534ead302d7485b72b072fe', 1, 73, 'female', 'male', 'Hi, I\'m Ruth White, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 130.557116, 31.596554, 23, 1, NULL),
('abccf8f1-021d-4b88-8d05-be32cc4217f4', 'diane139@example.com', 'Diane139', 'Davis', 'Diane', 'fd157624e9b66cea984775718a575eb50870e62afbdce868aed53f3c8e19f1f6', 1, 65, 'female', 'male', 'Hi, I\'m Diane Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 21.011486, 52.225406, 17, 0, NULL),
('ac64ec81-8d53-4f31-8921-b1734ee1be84', 'paul117@example.com', 'Paul117', 'Jackson', 'Paul', '8c64014ba541b903dfe05dbd56aa863f7b602b51eba38ecbe354dfdfe08076b7', 0, 56, 'male', 'female', 'Hi, I\'m Paul Jackson, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 7.261953, 43.710173, 82, 0, NULL),
('ad115e6d-e40e-4e13-889e-49df5b5e58c0', 'henry399@example.com', 'Henry399', 'Wilson', 'Henry', '7d01944bfefc6bf9862c93fd30ec0626ba46d91b31ba676fea4a8a47d9c706d2', 1, 40, 'male', 'female', 'Hi, I\'m Henry Wilson, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 130.557116, 31.596554, 62, 1, NULL),
('ad286472-dd26-4d82-bdb4-e84b8379d199', 'james70@example.com', 'James70', 'Flores', 'James', '34fe23cf9636ea9d587823e90887a150c7e22e6f330dcae8ff5d3fa1bbc37852', 1, 58, 'male', 'female', 'Hi, I\'m James Flores, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -80.843127, 35.227087, 12, 1, NULL),
('ad5a000e-e375-4e76-a619-2e97fc4a3b66', 'ethan121@example.com', 'Ethan121', 'Thompson', 'Ethan', '35b40e725f79eebee4d02e8faec9b81c683c5f9aa9ed4457d0cf0ee89ffb9c0c', 0, 74, 'male', 'male', 'Hi, I\'m Ethan Thompson, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 2.295753, 49.894067, 14, 1, NULL),
('add922ac-0f7b-4b4a-8b2d-d1e3229f6530', 'paul340@example.com', 'Paul340', 'Taylor', 'Paul', '099853d030f003820d3af7b33ef261a1d4c4ad61e52c6d2e111b7550b26d8ac3', 1, 26, 'male', 'female', 'Hi, I\'m Paul Taylor, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 4.351721, 50.850346, 47, 1, NULL),
('b0f95da5-8ff6-4bc0-9892-53c6db3eb7ad', 'benjamin130@example.com', 'Benjamin130', 'Hernandez', 'Benjamin', 'fdaf316691c0233b44908b805a61d61682233bcd8c3430cbc3a16d200ab908cd', 0, 89, 'male', 'female', 'Hi, I\'m Benjamin Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -0.579180, 44.837789, 85, 1, NULL),
('b0f981a7-3de0-4654-a86f-c17eff5a49d5', 'elizabeth369@example.com', 'Elizabeth369', 'Davis', 'Elizabeth', 'e34fd6a7063ba579920c589c278b352396bdc74e0b8d6a4da0bb58eb39c25e4a', 0, 64, 'female', 'male', 'Hi, I\'m Elizabeth Davis, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 139.036413, 37.916192, 14, 0, NULL),
('b13da92c-96c9-4355-91f3-5db144a23ae6', 'michael500@example.com', 'Michael500', 'Carter', 'Michael', '972a1cfe5af9e32289af80565ace978935c1646d58ef76c7297a753119efe535', 1, 56, 'male', '', 'Hi, I\'m Michael Carter, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 4.402464, 51.219448, 58, 0, NULL),
('b1645525-fdd2-49fc-9266-882735da7bb0', 'ronald4@example.com', 'Ronald4', 'White', 'Ronald', 'b97873a40f73abedd8d685a7cd5e5f85e4a9cfb83eac26886640a0813850122b', 1, 30, 'male', 'female', 'Hi, I\'m Ronald White, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -117.161084, 32.715738, 4, 0, NULL),
('b1cf5392-e862-4227-aaae-4b28b2c084d0', 'kathleen106@example.com', 'Kathleen106', 'Thompson', 'Kathleen', '44130b0a209dc581fac72493a9dfc8ccf4b9078508af9380bfe77d04ecb23159', 0, 18, 'female', 'male', 'Hi, I\'m Kathleen Thompson, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 141.354376, 43.062096, 70, 1, NULL),
('b1e22672-da0a-4876-ae23-365349afbb1e', 'lauren197@example.com', 'Lauren197', 'Perez', 'Lauren', 'e59e709de894de8d95bdf84f83f341778058a99dc3f147e5027fd4047b66742a', 1, 56, 'female', 'female', 'Hi, I\'m Lauren Perez, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 140.869356, 38.268215, 25, 1, NULL),
('b21df7d4-f004-4699-a24c-04046095cb55', 'katherine125@example.com', 'Katherine125', 'Ramirez', 'Katherine', 'f974ef14e161774091b3dd7350110d5a23b73e15d1fa68a69de0e6d981f76dac', 1, 58, 'female', 'male', 'Hi, I\'m Katherine Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 3.087025, 45.777222, 9, 1, NULL),
('b234d40b-ec57-4cb7-a36d-f2c343bcf5b6', 'lawrence59@example.com', 'Lawrence59', 'Baker', 'Lawrence', 'fe38739fb81956f6064587c7a78565fa71448c44408b48012122e7e7ea83e1a6', 0, 60, 'male', 'male', 'Hi, I\'m Lawrence Baker, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 2.298280, 48.875312, 51, 1, NULL),
('b36efb2c-87aa-4ac8-99b2-1eb0e987f89c', 'carl274@example.com', 'Carl274', 'Wilson', 'Carl', '2f70239f13814b3e18de8c1371d5abe2b6a02295cb8753f218f3db62c5a6f94d', 1, 26, 'male', 'female', 'Hi, I\'m Carl Wilson, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -75.165222, 39.952584, 30, 0, NULL),
('b3f3a161-186b-42cf-a85f-7d14cd89f024', 'elizabeth192@example.com', 'Elizabeth192', 'Carter', 'Elizabeth', '40d0cf3b61304e0ac3d5c3be5e10586912aa9a5c4d8abc8e4045c7b60ee59885', 0, 72, 'female', 'male', 'Hi, I\'m Elizabeth Carter, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -117.161084, 32.715738, 38, 1, NULL),
('b65ff3d4-ab5f-4336-a093-58bcbf5978db', 'ryan263@example.com', 'Ryan263', 'Nguyen', 'Ryan', '91927e5e1be4c42dad1681d5eee68031369c563beb66473872808eb87f12776c', 1, 68, 'male', 'female', 'Hi, I\'m Ryan Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 132.455293, 34.385203, 36, 0, NULL),
('b681dd31-ccb3-490b-a41a-5ba1808670ad', 'patricia267@example.com', 'Patricia267', 'Carter', 'Patricia', '1cec00e2e9dda8cccd6b605c4e249ca92a562a61163b1fcdea69bb3d448edec5', 0, 79, 'female', 'male', 'Hi, I\'m Patricia Carter, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 130.401716, 33.590355, 64, 0, NULL),
('b7387968-6ab3-49af-aac8-0c49479236cf', 'maria2@example.com', 'Maria2', 'Lee', 'Maria', '6cf615d5bcaac778352a8f1f3360d23f02f34ec182e259897fd6ce485d7870d4', 0, 100, 'female', 'male', 'Hi, I\'m Maria Lee, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -82.998794, 39.961176, 19, 0, NULL),
('b7466536-bf9c-4314-8198-c31e597e40ff', 'melissa328@example.com', 'Melissa328', 'Anderson', 'Melissa', 'd48eb36544e414ea803931905e129726d82b81b8a94891f81857e3ae2349eb58', 0, 83, 'female', 'male', 'Hi, I\'m Melissa Anderson, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 139.036413, 37.916192, 23, 0, NULL),
('b8063149-3662-482b-8f47-7fa1e43c1beb', 'joyce465@example.com', 'Joyce465', 'Wilson', 'Joyce', '7a01339c8e37c4e2ea186131f605829c790840bf8db01d2b2ef68fdb2016c2c0', 1, 63, 'female', 'male', 'Hi, I\'m Joyce Wilson, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 3.087025, 45.777222, 31, 0, NULL),
('b8ef1116-a438-4569-8a3c-432b730e9c2b', 'donna207@example.com', 'Donna207', 'Hill', 'Donna', 'be0b7cff1e179aec6628a376c80cc0a1c1de12bb16d49977c404c6d3e81e31e7', 0, 68, 'female', 'male', 'Hi, I\'m Donna Hill, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 4.835659, 45.764043, 5, 1, NULL),
('b92b4259-2625-486c-80cf-840941eec6de', 'michael56@example.com', 'Michael56', 'Jackson', 'Michael', '58bcc70c0e1ead10857a4b2deb02f167a42461fe5ff5b0040f93ef822b538c2c', 0, 21, 'male', 'female', 'Hi, I\'m Michael Jackson, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 130.557116, 31.596554, 8, 0, NULL),
('ba1fb655-7853-4208-9fd1-d77a3f138fb8', 'nicole32@example.com', 'Nicole32', 'Smith', 'Nicole', '078aa4687601ab09b1f7581014674b3bf1a3aa68b12c346d01024f1f5206f94b', 1, 82, 'female', 'male', 'Hi, I\'m Nicole Smith, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -75.165222, 39.952584, 58, 1, NULL),
('ba44b1b6-7113-489f-ab44-15e573bb3b7a', 'dennis185@example.com', 'Dennis185', 'Allen', 'Dennis', '815de4ef06543a0622dc70a859e50c52fa0f15bfc27da1d87c399dd077960bf0', 1, 23, 'male', 'female', 'Hi, I\'m Dennis Allen, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -121.886329, 37.338208, 38, 0, NULL),
('bb49c9c5-8178-44e2-88dc-ed73027d4840', 'adam103@example.com', 'Adam103', 'Adams', 'Adam', 'c14883c02091c283d24d22edf9adbcbd13cc43e564e47e30d600033885c49af5', 1, 28, 'male', 'female', 'Hi, I\'m Adam Adams, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -122.419416, 37.774929, 5, 1, NULL),
('bb4f4f23-203a-4157-8285-5300a03a75ec', 'virginia75@example.com', 'Virginia75', 'Torres', 'Virginia', 'd6afbbefeb937109f96b5f5421c8eb64694e8e2d4534cefffa5ba4a805f629f7', 0, 92, 'female', 'male', 'Hi, I\'m Virginia Torres, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 4.402464, 51.219448, 17, 0, NULL),
('bbbf35c7-d413-48a4-b6db-b35358018926', 'janet270@example.com', 'Janet270', 'Jones', 'Janet', 'c7210f6fd9c03ede3b09fdb4940441364c694247c221a5518a1218b8662ec091', 0, 86, 'female', 'male', 'Hi, I\'m Janet Jones, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -96.796988, 32.776664, 46, 1, NULL),
('bbd57dc3-99eb-4503-b235-13ce8cbc112e', 'noah304@example.com', 'Noah304', 'Hill', 'Noah', '710b89212f8ebfa75d3bbc0013a9726437cad4d615fcedc2f9a2b9fde4ea9618', 0, 39, 'male', 'female', 'Hi, I\'m Noah Hill, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 5.369780, 43.296482, 56, 1, NULL),
('bbdc7332-812b-448a-bd6f-bad5f5078c45', 'ruth368@example.com', 'Ruth368', 'Jones', 'Ruth', '506c0eac83293d59b4d5daee60aec11e587860770151abcb209f48cce167f1c5', 0, 73, 'female', 'male', 'Hi, I\'m Ruth Jones, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -117.161084, 32.715738, 45, 1, NULL),
('bc931057-53df-4c13-82d3-caf8c75d86eb', 'linda87@example.com', 'Linda87', 'Roberts', 'Linda', '0e3d1ff5111b4fe10af191b5bf69378159bd7ca6cba1eb7262a405c18088afe2', 0, 48, 'female', 'male', 'Hi, I\'m Linda Roberts, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 2.295753, 49.894067, 60, 1, NULL),
('bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'tsujimarico@gmail.com', 'Heidi', 'Turner', 'Heidi', '$2b$10$qu0pKMWYofEdhv7ddFJvS.1fFot6UIZjWy/AbRPLUN5aaefDj78pG', 1, 20, 'female', 'male', 'Hi Eric', 'http://localhost:4000/uploads/alter-egos-heidi-turner-w-hat.png', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('bdac9e43-ac7a-49ee-a7d8-caa94013364a', 'frank486@example.com', 'Frank486', 'Nguyen', 'Frank', '04f44bc44afb2db4ec4bb35219ec5bdb5878928c6a8f8ed4022b798be34a7b63', 0, 44, 'male', 'female', 'Hi, I\'m Frank Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 135.768029, 35.011636, 39, 0, NULL),
('bee12eaa-9e42-4330-a85d-ca95145739e0', 'lauren144@example.com', 'Lauren144', 'Mitchell', 'Lauren', 'ad6cd891ccf7d78ead86fb2788e8a32948d59b001706bce811750a9e77471060', 0, 92, 'female', 'male', 'Hi, I\'m Lauren Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 21.011486, 52.225406, 64, 0, NULL),
('bf55fdaf-2671-4b76-957a-4e5d19352867', 'sarah80@example.com', 'Sarah80', 'Jones', 'Sarah', '24069004ae289e583afeb41e969e0f2b8c1b7d80326dcf9be9ec7411698dd33b', 0, 72, 'female', 'male', 'Hi, I\'m Sarah Jones, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 1.444209, 43.604652, 3, 0, NULL),
('bf828e93-43f9-4475-accc-955cc8cd0b62', 'terry306@example.com', 'Terry306', 'White', 'Terry', '94bf4a2992d16ce1b312f68bf76fbd3c086a337b93483f1c64d41f5aad24a18a', 1, 73, 'male', 'female', 'Hi, I\'m Terry White, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 140.869356, 38.268215, 64, 0, NULL),
('c196d787-5c43-47e6-98cf-b63f3dfb0558', 'andrea313@example.com', 'Andrea313', 'Brown', 'Andrea', '9e07f1ae4172b657821db7f35e3f866617c66457605f4acd368790fe59ac7ace', 0, 69, 'female', 'male', 'Hi, I\'m Andrea Brown, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 141.354376, 43.062096, 48, 1, NULL),
('c1e587b3-128e-4237-a8be-4b9438c00a96', 'olivia62@example.com', 'Olivia62', 'Miller', 'Olivia', 'c1ce757c52862f31178c2e77cb391dc605735ea5416c50d2b68dd1c0f559049e', 0, 91, 'female', 'male', 'Hi, I\'m Olivia Miller, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 135.502165, 34.693738, 78, 1, NULL),
('c1fce341-bcad-4b0e-b293-ee2fd29222b6', 'stephen398@example.com', 'Stephen398', 'Garcia', 'Stephen', 'b25ec98163dc353cf3a6a3db6b69c2c72686fb288c68d2886006867f37d3f770', 1, 47, 'male', 'male', 'Hi, I\'m Stephen Garcia, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -0.579180, 44.837789, 86, 1, NULL),
('c27c9ee4-f2f3-47b5-a33b-361916016dc1', 'ruruover1105@gmail.com', 'lucas', 'pezeta', 'lucas', '$2b$10$ic7gHvggUomiVkK27v64cOZ7jU3dnArQOkHG2lUP4UJlZ4azwRsRS', 1, 0, 'female', 'male', 'take a break', 'http://localhost:4000/uploads/pexels-lucas-pezeta-2112714.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('c2b632db-105d-419f-8bbd-954e3f70f931', 'christopher378@example.com', 'Christopher378', 'Davis', 'Christopher', '3ded4ecba045cce05b65caf9b8ff463f8a5765b9d7090f421d0e16000bbde985', 0, 84, 'male', 'female', 'Hi, I\'m Christopher Davis, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 139.638026, 35.443708, 0, 1, NULL),
('c367ef9a-867c-4b41-8b97-c36acf2419e4', 'tyler217@example.com', 'Tyler217', 'Clark', 'Tyler', '02a6c8017999aa7f7d26abd074d9d95edcad0995817f779e85aea17df0958a9b', 1, 89, 'male', 'female', 'Hi, I\'m Tyler Clark, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 136.906398, 35.181446, 70, 1, NULL),
('c36f3835-0227-4170-9862-9a013c4a95ca', 'terry174@example.com', 'Terry174', 'Mitchell', 'Terry', 'fac7bb2af1d3028c0f5b71e22fc2c54c84eef25dde1d81bcde02127921ffe58a', 1, 54, 'male', 'female', 'Hi, I\'m Terry Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 138.388475, 34.971855, 8, 0, NULL),
('c3d1081a-c71f-4c06-a376-fa4744a0fa0b', 'heather411@example.com', 'Heather411', 'Wright', 'Heather', '31af7275407d6bd153d1bcd80c653a04bf86ee137820204a8b6cc8d387a1d863', 1, 22, 'female', 'male', 'Hi, I\'m Heather Wright, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -75.165222, 39.952584, 18, 0, NULL),
('c3d45636-ca99-4c57-9aca-fed3e4d10bed', 'gloria50@example.com', 'Gloria50', 'Allen', 'Gloria', 'b5d966eb0c2845953fab12c306c906a3561162262115c3b6fc19aead8d142157', 0, 40, 'female', 'male', 'Hi, I\'m Gloria Allen, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 21.011486, 52.225406, 38, 1, NULL),
('c4305262-40bb-4f40-a96a-ced31ab60a77', 'ethan414@example.com', 'Ethan414', 'Jones', 'Ethan', 'd9adc5d697ad911230438f45bf32ca88af0d52c85811fbe0673f1ee5f5774b11', 0, 23, 'male', '', 'Hi, I\'m Ethan Jones, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 139.036413, 37.916192, 12, 0, NULL),
('c43e83db-c632-4b89-abe3-fdcbdd11d3de', 'richard261@example.com', 'Richard261', 'Thompson', 'Richard', '24143f0869d2ed05acc3662513dc968e6a8211a95710f8e958a6f1e6f8be9333', 1, 48, 'male', 'female', 'Hi, I\'m Richard Thompson, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 127.680932, 26.212401, 57, 0, NULL),
('c47df429-d97d-4ddc-9aea-5d1c39875ab3', 'scott489@example.com', 'Scott489', 'Campbell', 'Scott', '928f2231a8f60acefe7b0d369fc429591d5c3440810792119e9c91f8bc29f456', 0, 32, 'male', '', 'Hi, I\'m Scott Campbell, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 2.298280, 48.875312, 84, 0, NULL),
('c4e1c53b-64c7-4acc-ab31-b4fafb462363', 'douglas237@example.com', 'Douglas237', 'Harris', 'Douglas', 'd20d5c8023c2aa5586c1ec8872e7e63cccaaa38dd027faa0261d2073bdc6d313', 1, 58, 'male', 'female', 'Hi, I\'m Douglas Harris, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 136.906398, 35.181446, 22, 0, NULL),
('c5112b2a-7b7c-43e6-9ec2-ff0cfc0601d7', 'carl404@example.com', 'Carl404', 'Nguyen', 'Carl', '4f93067daa8232d8a58468fa645d6c5ff3b3adb8614e26857fa96e69245dc565', 1, 41, 'male', 'female', 'Hi, I\'m Carl Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 4.351721, 50.850346, 67, 0, NULL),
('c59c2364-eddd-47ed-925b-779e094dae21', 'dorothy406@example.com', 'Dorothy406', 'Flores', 'Dorothy', 'c33e2a38dfc55c9f240ecdb7337eeac486a56d607220bf7f1d4281005115e022', 0, 65, 'female', 'male', 'Hi, I\'m Dorothy Flores, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', -122.419416, 37.774929, 40, 1, NULL),
('c701a1c3-db6b-4e90-b323-f4bfafd56722', 'betty251@example.com', 'Betty251', 'Scott', 'Betty', 'e806c83b9c005dcf5c1448856cfb758af071c024f8230e46f3db8f9d249bee8f', 1, 55, 'female', 'male', 'Hi, I\'m Betty Scott, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -5.984459, 37.389092, 66, 1, NULL),
('c71228ee-41e6-40cc-9aef-8d7a4e863f07', 'victoria210@example.com', 'Victoria210', 'Allen', 'Victoria', 'a757439e315efad24e88de219c390f2f5f956243826af4c970005a4660fdba66', 0, 95, 'female', 'male', 'Hi, I\'m Victoria Allen, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 15.063146, 45.079574, 53, 1, NULL),
('c7dafa90-2854-409a-999f-42c3f47f5e9d', 'daniel216@example.com', 'Daniel216', 'Johnson', 'Daniel', '77d0972aa80957c6c650d7f5ded32b8f9f0dde09f1ff3078662198f3a281e7fa', 0, 73, 'male', 'female', 'Hi, I\'m Daniel Johnson, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 3.876716, 43.610769, 25, 0, NULL),
('c80ff462-9051-47e4-a04b-f0fd5fa3f2e0', 'gloria334@example.com', 'Gloria334', 'Carter', 'Gloria', '100567712d35d0d9ceae055a7836d255f3cfd985948b2782ef8dda146d3452d6', 0, 78, 'female', 'male', 'Hi, I\'m Gloria Carter, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', -117.161084, 32.715738, 76, 0, NULL),
('c829c00b-152d-49fb-8666-2cec610ec04a', 'dorothy190@example.com', 'Dorothy190', 'Wright', 'Dorothy', '2ff69ea5a11144909b394342ed5f6cf5e73e062315bac91bc77a00605ed3bcf2', 1, 96, 'female', 'male', 'Hi, I\'m Dorothy Wright, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -118.243683, 34.052235, 34, 1, NULL),
('c89620e1-9b41-44f4-a2e5-7c6e122f1d67', 'john171@example.com', 'John171', 'Smith', 'John', 'e8470f49144e6d553cc6bc356fddd807a334b6ecced4b85f6846159dfe843af3', 1, 65, 'male', 'female', 'Hi, I\'m John Smith, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -98.493629, 29.424122, 28, 1, NULL),
('c919bb16-d28d-4695-af2d-2b774d68f905', 'ryan67@example.com', 'Ryan67', 'King', 'Ryan', 'fb8a6ce5d0214341f9c78591b4e4ef31050cc952a56ef18c3a597fe0dcb3cd49', 1, 67, 'male', 'female', 'Hi, I\'m Ryan King, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', -0.108740, 51.509897, 85, 0, NULL),
('c92af5b8-97ae-41cc-be88-059cd091fb1b', 'sarah407@example.com', 'Sarah407', 'Clark', 'Sarah', 'f58d8939192820eb8f4497ce5b80ada2b66a415d3f25b71a93751a400f387e0e', 1, 56, 'female', 'male', 'Hi, I\'m Sarah Clark, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 130.401716, 33.590355, 37, 0, NULL),
('c9e80a5e-8518-43a2-9c09-d5f949c63fb3', 'pamela147@example.com', 'Pamela147', 'Scott', 'Pamela', 'd601d7629b263221dd541a3131d865a9bcb087e3edc702867143a996803307ab', 1, 90, 'female', 'male', 'Hi, I\'m Pamela Scott, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 133.919502, 34.655146, 51, 1, NULL),
('cab1d404-9ff7-41d1-8cf9-31d79ad0382a', 'margaret160@example.com', 'Margaret160', 'Clark', 'Margaret', '4b186aeeafafbe519e8dc8252785bee2569109e6fa42d10e3243a174dead5949', 0, 72, 'female', 'male', 'Hi, I\'m Margaret Clark, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -81.655651, 30.332184, 16, 0, NULL),
('cb76eaaa-54ff-49a0-98f2-de73c5450183', 'kevin240@example.com', 'Kevin240', 'Lopez', 'Kevin', '21a0554f8829db9a4b8507d168038ccb1e29aefff7e54269b553a3cfd7b47a2f', 1, 75, 'male', 'female', 'Hi, I\'m Kevin Lopez, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -87.629799, 41.878113, 70, 1, NULL),
('cba148bc-c4c4-4e98-a0c0-b308f146a3a9', 'sarah5@example.com', 'Sarah5', 'Davis', 'Sarah', '8b2c86ea9cf2ea4eb517fd1e06b74f399e7fec0fef92e3b482a6cf2e2b092023', 1, 50, 'female', 'male', 'Hi, I\'m Sarah Davis, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -97.743061, 30.267153, 76, 1, NULL),
('cda27df7-3cac-4634-b368-6aa7e7f995db', 'brenda194@example.com', 'Brenda194', 'Smith', 'Brenda', 'b76a25ba350dc599b72e66a4bff6ce4ddb55c9d78468794e22ce4cccce78d41b', 0, 60, 'female', 'female', 'Hi, I\'m Brenda Smith, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 135.502165, 34.693738, 91, 0, NULL),
('cdb5aac9-44d6-438f-8917-07cff312d62d', 'gerald231@example.com', 'Gerald231', 'Robinson', 'Gerald', '0cd1a34f93572bb80a5bf493d220bb881030335ec17a4e358c6da73a1ec30b4a', 0, 42, 'male', 'female', 'Hi, I\'m Gerald Robinson, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -81.655651, 30.332184, 27, 1, NULL),
('cdef1d6c-44dd-4de1-8e69-7d117fe87b9a', 'sean128@example.com', 'Sean128', 'Ramirez', 'Sean', 'f11026cad6ec0b7bbe12d040560218f64c02cd99d9b2b47838ba081f1f54f0d4', 0, 79, 'male', 'female', 'Hi, I\'m Sean Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 3.876716, 43.610769, 98, 0, NULL),
('ce6e64bd-6fd9-40bc-8a09-3aa5d4040577', 'ann429@example.com', 'Ann429', 'Gonzalez', 'Ann', 'd5fb8fad4184ab1d64e11c23241c2c95e3296235a22ad6e2d7afb28bc827a087', 1, 50, 'female', 'male', 'Hi, I\'m Ann Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', -121.886329, 37.338208, 76, 0, NULL),
('cf688c46-b7e4-49b4-9f9d-93939fb5868d', 'kimberly412@example.com', 'Kimberly412', 'Green', 'Kimberly', '4b4740ddefd50b726b900de68234a47a77278fdda6bbec85971f1f86a7b03760', 1, 27, 'female', 'male', 'Hi, I\'m Kimberly Green, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 15.063146, 45.079574, 14, 1, NULL),
('cf730186-4ebe-40c8-9423-f0dd794d1fae', 'walter241@example.com', 'Walter241', 'Flores', 'Walter', '1771b93c93be72f381fded3e1be40020fc6995efdc8e2f29beb8470bbc214fb1', 1, 95, 'male', '', 'Hi, I\'m Walter Flores, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -1.558626, 43.483152, 53, 1, NULL),
('d0effbc7-9d1f-40d3-98fd-6bbcecd1dce8', 'lisa341@example.com', 'Lisa341', 'Lewis', 'Lisa', '3d62599696e3f220c22bf3cfb167d11efac2060de561cf197a209b7bf2ab91a8', 1, 26, 'female', 'male', 'Hi, I\'m Lisa Lewis, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 130.557116, 31.596554, 72, 1, NULL),
('d16ea305-1872-4895-8578-a6565326dc98', 'jeremy474@example.com', 'Jeremy474', 'King', 'Jeremy', 'cf1cbdc0f79fd942a0db33e94cbd999e5472836c4a9397546f6429ec2b52b90b', 0, 49, 'male', 'female', 'Hi, I\'m Jeremy King, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -121.886329, 37.338208, 48, 0, NULL),
('d2b9757b-9f53-430d-9ac1-d210410df64e', 'ryan475@example.com', 'Ryan475', 'Young', 'Ryan', 'f25f6c880b51484e66e12a0427b4a00cf2048028400a9b9e7cd15cd12d50c9e0', 0, 33, 'male', 'female', 'Hi, I\'m Ryan Young, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 141.354376, 43.062096, 18, 1, NULL),
('d2e11d1f-0578-438e-b3fb-2f7d9d0c916e', 'margaret16@example.com', 'Margaret16', 'Gonzalez', 'Margaret', '17a3379984b560dc311bb921b7a46b28aa5cb495667382f887a44a7fdbca7a7a', 0, 41, 'female', 'male', 'Hi, I\'m Margaret Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -87.629799, 41.878113, 32, 0, NULL),
('d355c717-90fa-4296-ada2-9c69334fa045', 'virginia351@example.com', 'Virginia351', 'Thompson', 'Virginia', 'e8ecbd5f57894752a099e3c66a35f3eb7b4ef3039323affad3d951b7ce1ac786', 1, 72, 'female', 'male', 'Hi, I\'m Virginia Thompson, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -80.843127, 35.227087, 19, 0, NULL),
('d3add5ed-c7b3-4775-813a-98668397f70b', 'carol23@example.com', 'Carol23', 'Rodriguez', 'Carol', '8b807aa0505a00b3ef49e26a2ade8e31fcd6c700d1a3aeee971b49d73da8e8ff', 0, 90, 'female', 'male', 'Hi, I\'m Carol Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 136.906398, 35.181446, 36, 1, NULL),
('d428fc62-80dd-442d-8738-3daf56ed5477', 'ashley409@example.com', 'Ashley409', 'Williams', 'Ashley', '478f2feae1e51632ce9c3f169aa7b3a014652d8be1d9c9cb556da34a992889cc', 1, 39, 'female', 'male', 'Hi, I\'m Ashley Williams, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', -118.243683, 34.052235, 78, 0, NULL),
('d44d57b6-7def-4f99-be05-2dfde24a1603', 'tyler456@example.com', 'Tyler456', 'Jackson', 'Tyler', 'c6ba91b90d922e159893f46c387e5dc1b3dc5c101a5a4522f03b987177a24a91', 0, 66, 'male', 'female', 'Hi, I\'m Tyler Jackson, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 3.087025, 45.777222, 48, 1, NULL),
('d4d11894-f57a-4a97-a30d-32c61093229c', 'karen37@example.com', 'Karen37', 'Sanchez', 'Karen', 'ca02485287fd4f05de9540613f8ba982e99080b66f8452024cb4c4cc3de7042e', 0, 82, 'female', 'male', 'Hi, I\'m Karen Sanchez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 139.829356, 35.841208, 26, 0, NULL),
('d5273379-b96e-457f-a0b6-9d50cd56ed37', 'pamela330@example.com', 'Pamela330', 'Torres', 'Pamela', '6c63e98377408187e8159816ee5e663f7b41e92389715b9497b65c651f91eb7c', 0, 66, 'female', 'male', 'Hi, I\'m Pamela Torres, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 21.011486, 52.225406, 28, 1, NULL),
('d5f7d878-b942-493b-81c5-c42ff70a882a', 'alexander286@example.com', 'Alexander286', 'Torres', 'Alexander', '574d5c20886103a820c51447ae39a8f9393b0d0f8eb9af89b6495fd7f62bd368', 1, 35, 'male', 'female', 'Hi, I\'m Alexander Torres, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', 7.261953, 43.710173, 59, 0, NULL),
('d68da095-8547-4bf2-ae42-872d23faae53', 'joan470@example.com', 'Joan470', 'Wright', 'Joan', 'd1f3de8667d57aa3d654818b9151312d70c8255c00c8f57186974600b2d5c70a', 1, 29, 'female', 'male', 'Hi, I\'m Joan Wright, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 3.876716, 43.610769, 99, 1, NULL),
('d9205bec-e881-48bb-aa89-6e8699873089', 'david26@example.com', 'David26', 'White', 'David', '869f2a98b0e3a6ea928ff0542330ea3c1e0ff8591801693350f1fc3f1e57e4c5', 1, 25, 'male', 'female', 'Hi, I\'m David White, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 3.717424, 51.054342, 87, 1, NULL),
('d944e532-ce00-4710-9c45-649a09e8015b', 'daniel434@example.com', 'Daniel434', 'Mitchell', 'Daniel', '29e84fd683cb4e83c51532459a4f76145ee79b479fccf98001726334fe5e6cd0', 1, 20, 'male', 'female', 'Hi, I\'m Daniel Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', -112.074037, 33.448377, 79, 1, NULL),
('d96d6e7a-5db9-4cff-9856-59037c556662', 'emily391@example.com', 'Emily391', 'Campbell', 'Emily', 'eb89c690f975fe498c07c1dbbc71bc56095d419f162a242a88ec7515a1c99694', 0, 95, 'female', 'male', 'Hi, I\'m Emily Campbell, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -80.843127, 35.227087, 72, 0, NULL),
('da315356-8e37-4bf1-81aa-69b6cf34fc69', 'gregory383@example.com', 'Gregory383', 'Baker', 'Gregory', '83e2700087256f7c3b463b80335b0b5fcdf95b8875ee86ed9d1eb32efc65a72b', 0, 39, 'male', 'female', 'Hi, I\'m Gregory Baker, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -0.579180, 44.837789, 86, 0, NULL),
('da53b85a-0a5a-4ac2-9eb6-591584c1a9cf', 'sarah92@example.com', 'Sarah92', 'Green', 'Sarah', '6a625e69e990b5f6a093a7b0acb4156ad7c8e705245f5b91e0aa740f90d1e173', 0, 84, 'female', '', 'Hi, I\'m Sarah Green, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 7.261953, 43.710173, 50, 0, NULL),
('da6e4816-8dba-4d19-8873-2bee0e783e9c', 'brandon148@example.com', 'Brandon148', 'Nguyen', 'Brandon', '0e810497cdad0ea5978e129e19ae8c288f1573f71669c50e1bd7968d1ee662dd', 0, 99, 'male', 'male', 'Hi, I\'m Brandon Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', -112.074037, 33.448377, 70, 1, NULL),
('dafd0453-0619-4221-a622-78db357b5568', 'ethan419@example.com', 'Ethan419', 'Adams', 'Ethan', 'a46066a4bdfcc41d4e41dc3a412c2b25d6ad515f2843ee4082c3774ea6cccdce', 0, 43, 'male', '', 'Hi, I\'m Ethan Adams, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 141.354376, 43.062096, 26, 1, NULL),
('db14f081-21a3-4eb9-a89a-6f901ef7c507', 'brandon143@example.com', 'Brandon143', 'Thompson', 'Brandon', '4e7388c7dae5f47d4aaaad0f4dd6fc6eb80be023949efeaad42594d7a85e5673', 1, 98, 'male', 'female', 'Hi, I\'m Brandon Thompson, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 135.768029, 35.011636, 51, 0, NULL),
('db2931a5-b874-43cf-91b3-e6c54673d45a', 'pamela287@example.com', 'Pamela287', 'Torres', 'Pamela', '0b6c8e215cabd3c0f9ca3a80cf383aebd098f120c834544eeacb528db199e87c', 0, 88, 'female', 'male', 'Hi, I\'m Pamela Torres, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -1.558626, 43.483152, 3, 0, NULL),
('db56666a-d3dc-4de0-a9be-f7b80a85ff78', 'olivia485@example.com', 'Olivia485', 'Robinson', 'Olivia', '1e8f558b715bf5aabdc5f4137ea4ff8ae4928a153f4eae46bdbe774e7c8975e9', 1, 60, 'female', 'male', 'Hi, I\'m Olivia Robinson, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 7.261953, 43.710173, 28, 1, NULL);
INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`, `last_active`) VALUES
('db57ff2a-9951-4621-99c9-b3c2dd03e3e9', 'justin134@example.com', 'Justin134', 'Davis', 'Justin', '29974380eff53400aaecf88ef63c5db77631b6da40a36853b4a8ab592f2c7cee', 1, 71, 'male', 'female', 'Hi, I\'m Justin Davis, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -82.998794, 39.961176, 45, 1, NULL),
('dbc33967-7631-4086-85a6-191a457ed13b', 'eric30@example.com', 'Eric30', 'Harris', 'Eric', '7c682dea8e934e04343374e3d25cd51edce9cbeb47f7034296052cb5cd6bed84', 0, 85, 'male', 'female', 'Hi, I\'m Eric Harris, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -0.579180, 44.837789, 80, 1, NULL),
('dc096a14-6b3b-4b1a-aecb-a5816e26a55d', 'susan471@example.com', 'Susan471', 'Wright', 'Susan', '4d0597f8460ffdea910ff90437dfb712f6d574f12c6ff084a4ac25d50c4befe6', 1, 78, 'female', 'male', 'Hi, I\'m Susan Wright, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 135.768029, 35.011636, 17, 1, NULL),
('dc728381-46d2-4d33-a5a4-8001f7463f9f', 'mary224@example.com', 'Mary224', 'Moore', 'Mary', '9e7c752907ee8665513be02acc0b0c09ffff0921e30511716c002a57485ac207', 0, 22, 'female', 'male', 'Hi, I\'m Mary Moore, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -1.553621, 47.218371, 18, 0, NULL),
('dd0a565b-c06c-4a1d-91f7-2efa9f003dfa', 'charles266@example.com', 'Charles266', 'Baker', 'Charles', 'fd7490dadbd4fc3545c29d0425dda31d2bd7f41f13695bfb030504e9de0e9daf', 1, 88, 'male', 'female', 'Hi, I\'m Charles Baker, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -80.843127, 35.227087, 5, 1, NULL),
('defe1388-d7ab-4a40-8257-c3f164609c7b', 'kenneth327@example.com', 'Kenneth327', 'Garcia', 'Kenneth', '17fcc4ada61980ca6551586072b9ebbbeaf48a5988491f0e122bc82a76e1c449', 1, 65, 'male', 'female', 'Hi, I\'m Kenneth Garcia, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 135.502165, 34.693738, 17, 1, NULL),
('df1edbf2-4be8-4c76-ba5d-e3d57a8dc295', 'william177@example.com', 'William177', 'Rodriguez', 'William', '3c378c9caf6bceb6cef4e8f0be4d0ed21f1abb2da4055540237b396ca22736ef', 0, 71, 'male', '', 'Hi, I\'m William Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -122.419416, 37.774929, 42, 1, NULL),
('df51da00-dd2e-4f3f-bda8-c8aecb85dda2', 'roger187@example.com', 'Roger187', 'Jones', 'Roger', '58952757fe382ed8fbf8dfa0ddeba6a7d9a46c67a442678658962661215886c0', 0, 95, 'male', 'male', 'Hi, I\'m Roger Jones, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', 139.638026, 35.443708, 52, 0, NULL),
('df65829e-e0e5-414f-b1a0-3db97bba6f78', 'megan230@example.com', 'Megan230', 'Wright', 'Megan', '6a327cabac103b73c91989448b04038e0540e03c1e466b9378346028f7e8090e', 0, 62, 'female', 'male', 'Hi, I\'m Megan Wright, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 133.919502, 34.655146, 20, 1, NULL),
('dfeaa5e7-06dc-4e76-a341-e003ed84c3a6', 'tyler203@example.com', 'Tyler203', 'Baker', 'Tyler', '92238160d01b5eb13c2068b95b9ee42d99aa3dae270fcd1a62dc64e874ad3642', 0, 23, 'male', 'female', 'Hi, I\'m Tyler Baker, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -112.074037, 33.448377, 5, 0, NULL),
('e1e0730d-7542-4509-a3d9-f5ab6824930d', 'steven426@example.com', 'Steven426', 'Hall', 'Steven', '3ff68a4a3ae5a24c5a3f3581814b081bfb881f1e69ed3e6ef503b4dcdf350066', 0, 61, 'male', 'male', 'Hi, I\'m Steven Hall, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 135.502165, 34.693738, 4, 0, NULL),
('e25ed936-c5a0-40d5-84a8-91d887d8828b', 'joshua109@example.com', 'Joshua109', 'Rivera', 'Joshua', '1df0dc0efb2f08b28cac248f58cd53e7b2aedc52c077377502aff69f24c71b60', 0, 23, 'male', 'male', 'Hi, I\'m Joshua Rivera, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -75.165222, 39.952584, 87, 0, NULL),
('e273cafa-9795-4b3c-85a7-8b3cf30fe8f5', 'james84@example.com', 'James84', 'Scott', 'James', '408184fd8069021a6d8c87e0d8c7e94784051d9202d64dbc921e9b0541fb41a0', 0, 96, 'male', 'female', 'Hi, I\'m James Scott, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -1.553621, 47.218371, 71, 0, NULL),
('e2854828-de42-4f15-b1fd-04f19a320801', 'ronald205@example.com', 'Ronald205', 'Hernandez', 'Ronald', '8a72fd92b00ad741fbb6d81043093ad52dc6e3935a7ce243b140a69c715b633d', 0, 41, 'male', 'female', 'Hi, I\'m Ronald Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -1.553621, 47.218371, 94, 1, NULL),
('e2c3e362-1cd1-489a-815e-682f28f1f51b', 'angela85@example.com', 'Angela85', 'Harris', 'Angela', '879fbfd675a34ad3b2724c4ec94988dc267c8e2492aa9dd8010964ca9c4c90fb', 0, 28, 'female', 'male', 'Hi, I\'m Angela Harris, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 141.354376, 43.062096, 40, 0, NULL),
('e2fb3d17-d3ea-4a71-91cf-be67a37c5449', 'dennis202@example.com', 'Dennis202', 'Davis', 'Dennis', 'fca4836976e56c23b1aa03a2815aef685b33e9bb1838130eaa6d30533c90bee1', 0, 63, 'male', 'female', 'Hi, I\'m Dennis Davis, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 136.656205, 36.561325, 11, 0, NULL),
('e361522f-7711-48f3-98d5-2ef0ffc8e90b', 'brian150@example.com', 'Brian150', 'Wilson', 'Brian', 'c2141786d5c40007fdda8d5cdf5b541213c82e3b408723b4fb0a80697123c002', 1, 66, 'male', 'male', 'Hi, I\'m Brian Wilson, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 13.402720, 52.517251, 64, 0, NULL),
('e46a2ced-705c-4072-b334-d2ad4cc6d31a', 'dorothy82@example.com', 'Dorothy82', 'Moore', 'Dorothy', 'f3ea05e3c808ef144db4f1d98793db15f1d0f6a0b6e149bafa4d876e9d560f25', 1, 86, 'female', '', 'Hi, I\'m Dorothy Moore, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 130.557116, 31.596554, 79, 0, NULL),
('e4707942-09b2-4667-a9e8-e87b75b594c7', 'ruruover1105@gmail.com', 'spencer', 'selover', 'spencer', '$2b$10$UkNeBpejAsvZlQxNbmvqt.9bTFm4dTqynLZz9VShf1Y/wZ2Uw2hnG', 1, 28, 'male', 'female', 'hello', 'http://localhost:4000/uploads/pexels-spencer-selover-775358.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 0, 1, NULL),
('e527175e-a544-4812-bfcf-072dcdc6e497', 'christian153@example.com', 'Christian153', 'Rivera', 'Christian', '495fa1f7a3b546c9ac14ced6a612f70085c7cfdd0a0b80e8bcf2d46229669a17', 0, 45, 'male', 'female', 'Hi, I\'m Christian Rivera, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 139.638026, 35.443708, 60, 1, NULL),
('e546476f-eb87-49d9-9308-b96ad448809c', 'stephen179@example.com', 'Stephen179', 'Hernandez', 'Stephen', '73bb8336af345d3f003b2c7cfeab3c5708bd33a141125fa50936ff28601a63ce', 1, 51, 'male', 'female', 'Hi, I\'m Stephen Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -98.493629, 29.424122, 68, 1, NULL),
('e6747921-f30d-4d04-8df3-2263d86f3fbd', 'janet1@example.com', 'Janet1', 'Wilson', 'Janet', '0b14d501a594442a01c6859541bcb3e8164d183d32937b851835442f69d5c94e', 1, 30, 'female', 'male', 'Hi, I\'m Janet Wilson, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', 2.295753, 49.894067, 87, 0, NULL),
('e6b03172-5d83-472a-a68b-622c9c9827bc', 'anna66@example.com', 'Anna66', 'Lee', 'Anna', '60dbb6453448c39993cdd41edf3451a7d5e0eaf298207ee001f110c4d7785c8c', 0, 92, 'female', 'male', 'Hi, I\'m Anna Lee, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -0.108740, 51.509897, 81, 1, NULL),
('e7364375-d08b-49f7-adc3-e0b04a98809d', 'alice437@example.com', 'Alice437', 'White', 'Alice', '968639ae56ca40812cdfb0d5514ccba22c174e4c201857812bbea01a60cdb4e1', 0, 62, 'female', 'male', 'Hi, I\'m Alice White, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 2.295753, 49.894067, 100, 1, NULL),
('e79bd5fc-1e4d-415a-a39e-b1784d1d8d05', 'benjamin457@example.com', 'Benjamin457', 'Anderson', 'Benjamin', '9b4309de591573363bbac84739d5f92adea382021c4ba48f409b8ab69f7e2622', 1, 74, 'male', '', 'Hi, I\'m Benjamin Anderson, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -80.843127, 35.227087, 36, 1, NULL),
('e8df53f2-d2b5-4ee7-a02b-82be0084bbc2', 'julie196@example.com', 'Julie196', 'Miller', 'Julie', '5d3823fd47d5bebae10bb00fdf568b06ab81487581366b88ae2967e06d029b92', 1, 33, 'female', 'male', 'Hi, I\'m Julie Miller, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 139.036413, 37.916192, 80, 0, NULL),
('e8e47210-4bd3-4c74-a034-146a8a45891d', 'alexander460@example.com', 'Alexander460', 'Lee', 'Alexander', '28fd0062d10d6c4e822d12eda902a56680b8550409cd5d3265952d75c5056d17', 1, 45, 'male', 'female', 'Hi, I\'m Alexander Lee, welcome to my profile!', 'http://localhost:4000/uploads/11_boy.png', '', '', '', '', '', 136.656205, 36.561325, 64, 1, NULL),
('e97bf379-2cdc-4b7c-8816-22f5e0e9f0a8', 'kevin324@example.com', 'Kevin324', 'Rodriguez', 'Kevin', 'a83ce4a76dc4f11c497984ee1911ae0d218e83c432a7ebdf09bbc5a0c95ea331', 0, 19, 'male', 'male', 'Hi, I\'m Kevin Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/4_boy.png', '', '', '', '', '', -112.074037, 33.448377, 83, 1, NULL),
('e9cd1acb-cf0d-4bc4-bf54-58b624397117', 'kelly63@example.com', 'Kelly63', 'Torres', 'Kelly', '1d4a516ebe2acdffd5da7ab190d0c61871ba892df25f528915a84e787360a78f', 0, 91, 'female', 'male', 'Hi, I\'m Kelly Torres, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 13.402720, 52.517251, 54, 1, NULL),
('eaeefee4-6614-47ee-8b86-b1419205e5dd', 'jonathan9@example.com', 'Jonathan9', 'Torres', 'Jonathan', '9323dd6786ebcbf3ac87357cc78ba1abfda6cf5e55cd01097b90d4a286cac90e', 1, 84, 'male', 'female', 'Hi, I\'m Jonathan Torres, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', -81.655651, 30.332184, 56, 1, NULL),
('eb253df1-7162-4a0c-a27c-8f6e463c8a18', 'carolyn420@example.com', 'Carolyn420', 'Smith', 'Carolyn', '4c2c7af6bb6ad5643b4956195d3a704e4089a7b97bbbdd550fcca416eb50c9c0', 1, 88, 'female', 'male', 'Hi, I\'m Carolyn Smith, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', 3.876716, 43.610769, 76, 0, NULL),
('eb2a23e7-5e45-4872-84d7-c20857e55f50', 'rebecca208@example.com', 'Rebecca208', 'Robinson', 'Rebecca', 'a1d6b3ff0a92f6cd6d23fed3abaa996197d7b8465f255645d7f249e78c0fe1d0', 0, 31, 'female', 'male', 'Hi, I\'m Rebecca Robinson, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 139.829356, 35.841208, 3, 1, NULL),
('eb2ad0b9-5e86-49bb-a62a-5788394c9b3f', 'jason371@example.com', 'Jason371', 'Torres', 'Jason', '565d0f68bfffa723b6f34a6fdbefba3fcdf660e1218c0f29c73c3b4a994a1b2a', 0, 38, 'male', 'female', 'Hi, I\'m Jason Torres, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 3.057256, 50.629250, 64, 1, NULL),
('eb43f8fe-3bf8-4f9b-9180-56ebd14d93dc', 'laura168@example.com', 'Laura168', 'Rodriguez', 'Laura', 'b82965828f5f2a8db739200213da6d77176ca8ec5dfcfb66d7ee3004dc9fc200', 1, 36, 'female', 'male', 'Hi, I\'m Laura Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/7_girl.png', '', '', '', '', '', 1.099971, 49.443232, 39, 0, NULL),
('eb7f1e94-8865-4feb-b213-4a8a429c0bcb', 'kimberly257@example.com', 'Kimberly257', 'Hill', 'Kimberly', '5f2006d5ed67d133e4331e7c4a9e179e4ba6511cd6465379f8d79f16493b9afb', 0, 19, 'female', 'male', 'Hi, I\'m Kimberly Hill, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 13.402720, 52.517251, 75, 1, NULL),
('ebbb82c1-3386-4488-97bb-ae072075532a', 'christina453@example.com', 'Christina453', 'Mitchell', 'Christina', 'b0c965fdb8358be01d397882b449ae17ee63a700c21db16c11a290b42f74531e', 1, 57, 'female', 'male', 'Hi, I\'m Christina Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 130.401716, 33.590355, 5, 0, NULL),
('ebdc12b5-b86b-4e6f-a6e9-0c8f22e995ee', 'benjamin345@example.com', 'Benjamin345', 'Roberts', 'Benjamin', '31457e06e2adb2178358e9fc6705e0b6f37e9b6ec9456e8890d28f292be9adc4', 0, 85, 'male', 'female', 'Hi, I\'m Benjamin Roberts, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 1.099971, 49.443232, 63, 1, NULL),
('ebf168ab-c4fa-411c-beaf-ecc1c54e2d04', 'carol495@example.com', 'Carol495', 'White', 'Carol', 'f85c0ecef319ec9daa0c63d7bbb988bc0bdf23be8f100cbaf44f3444fddb595c', 1, 88, 'female', 'male', 'Hi, I\'m Carol White, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 127.680932, 26.212401, 81, 1, NULL),
('ec889803-7d55-4597-87db-1666057f09b7', 'emma232@example.com', 'Emma232', 'Davis', 'Emma', '00d779e256d1ba7de18135735dc18c8b112cd7cadf3587e9c106b88a91b6933e', 1, 45, 'female', 'male', 'Hi, I\'m Emma Davis, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -75.165222, 39.952584, 63, 0, NULL),
('ec9ee3ef-a2a1-4357-ac68-ebe265d7d4d0', 'stephen320@example.com', 'Stephen320', 'Young', 'Stephen', '0e50d42543e59dbd849b7c37e286f0eafb5c1dc5965a0be1062e16ed91bf7070', 1, 74, 'male', 'female', 'Hi, I\'m Stephen Young, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', -112.074037, 33.448377, 25, 1, NULL),
('ed0c3311-6966-4277-afc0-198149c435f3', 'douglas400@example.com', 'Douglas400', 'Gonzalez', 'Douglas', '2aa0d714f56370e0b184341a69ab8304cc241f8da7f01306dfc29fff24739e99', 0, 23, 'male', 'female', 'Hi, I\'m Douglas Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 130.401716, 33.590355, 56, 0, NULL),
('ee583dd0-4da8-4b77-848f-78a515a0fc22', 'ruruover1105@gmail.com', 'Kebin', 'Edimbara', 'Kebin', '$2b$10$8SVuv2h6911KE14EKpgtJuNCb7dJdnYIWjXBjC5OyDqw2j4BcnKPO', 1, 40, 'male', 'female', 'let\'s drink beer', 'http://localhost:4000/uploads/jack-finnigan-rriAI0nhcbc-unsplash.jpg', '', '', '', '', '', -0.113968, 51.506734, 0, 0, NULL),
('ef14890f-0c63-47ed-b5be-21d4490eff43', 'amanda27@example.com', 'Amanda27', 'Garcia', 'Amanda', '9c7568513b9c85e73f3650c8b00e3259501096ccee9d3dbdae6ff5e84aabe3af', 1, 57, 'female', 'female', 'Hi, I\'m Amanda Garcia, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -4.486076, 48.390394, 21, 0, NULL),
('ef41c19e-e14a-4601-90f0-a031d5451fc4', 'keith249@example.com', 'Keith249', 'Campbell', 'Keith', '76446049622338e61c35f05647d99d82eea417951b3d7a4c7b5f09fa3f9282eb', 0, 75, 'male', 'female', 'Hi, I\'m Keith Campbell, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -117.161084, 32.715738, 100, 0, NULL),
('efe64d07-3f66-409e-a559-f7f7437ba132', 'maria110@example.com', 'Maria110', 'Hernandez', 'Maria', '95fb0af62545c323ad3da1c09717b417c9c5dbe4e2c9035432d0955116e287e9', 0, 77, 'female', 'male', 'Hi, I\'m Maria Hernandez, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', -87.629799, 41.878113, 23, 1, NULL),
('f0f72574-b97e-488f-94b1-cf449d4bb804', 'kathryn41@example.com', 'Kathryn41', 'Rivera', 'Kathryn', 'a13b6ab0bb26b7d8bf31628b3b524efade4ac5b02712a95210c0abda5148ec85', 1, 69, 'female', 'male', 'Hi, I\'m Kathryn Rivera, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -112.074037, 33.448377, 34, 1, NULL),
('f11a9a5e-73cb-4837-9cab-ae81024cd344', 'steven441@example.com', 'Steven441', 'Taylor', 'Steven', 'e188cbcba0e6bc3802abcecf3aadfe3a305ab63d83d7e6ab8dcfd6f6b401b122', 0, 86, 'male', 'female', 'Hi, I\'m Steven Taylor, welcome to my profile!', 'http://localhost:4000/uploads/7_boy.png', '', '', '', '', '', 130.401716, 33.590355, 49, 1, NULL),
('f2581cf0-8909-4d3e-a5ae-6fbb97b87b75', 'betty81@example.com', 'Betty81', 'Gonzalez', 'Betty', 'bef99eeb6e6389703b5318b99ea03d8d9187f9800374c466fd2a6ae64da3c8ee', 1, 56, 'female', 'male', 'Hi, I\'m Betty Gonzalez, welcome to my profile!', 'http://localhost:4000/uploads/3_girl.png', '', '', '', '', '', -97.743061, 30.267153, 91, 1, NULL),
('f35fdb6e-284c-4312-a8b7-72d205da9053', 'cheryl483@example.com', 'Cheryl483', 'Scott', 'Cheryl', '0d4bb35dd5698cbda62f5bfa66129e5c0e302b86c3d5d9962f2675bbb711bc50', 1, 84, 'female', 'male', 'Hi, I\'m Cheryl Scott, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -87.629799, 41.878113, 82, 1, NULL),
('f368b68e-9d19-470a-9b27-741d504ed9e0', 'arthur281@example.com', 'Arthur281', 'Jones', 'Arthur', 'b7ffe2f64113d6e3160e76dd79a88802960dd58af0c02f017ed6ec792e33786b', 1, 87, 'male', 'female', 'Hi, I\'m Arthur Jones, welcome to my profile!', 'http://localhost:4000/uploads/12_boy.png', '', '', '', '', '', 15.063146, 45.079574, 36, 0, NULL),
('f36c1431-e817-4803-a64a-2b3d00c69756', 'mark431@example.com', 'Mark431', 'Hall', 'Mark', '6ba76395d0d64328c74eb8da1ed7b2cf5816887759d1c33d131f7a24fe887aaf', 0, 31, 'male', 'female', 'Hi, I\'m Mark Hall, welcome to my profile!', 'http://localhost:4000/uploads/10_boy.png', '', '', '', '', '', 138.388475, 34.971855, 45, 0, NULL),
('f3ee4667-037b-45f3-901b-3dd1cbcbbf1b', 'gary329@example.com', 'Gary329', 'Lee', 'Gary', '94859f5aa3afd807f6cb88cc5b176be6ace7d9b6a13b8b32a76aa5b7fad5531a', 0, 66, 'male', 'female', 'Hi, I\'m Gary Lee, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 136.906398, 35.181446, 22, 0, NULL),
('f481f5c8-9c88-4f75-ac27-3ecd0234328c', 'paul264@example.com', 'Paul264', 'White', 'Paul', '34ee329f454de948a149842be8edb56beb439099ebcab4d072fb85166d826ba8', 1, 54, 'male', 'female', 'Hi, I\'m Paul White, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 3.876716, 43.610769, 50, 0, NULL),
('f586f458-36ca-4396-96e1-fa2a573baa73', 'ruruover1105@gmail.com', 'Test', 'Kobayashi', 'Ruru', '$2b$10$2uIIFdtI8nEVPPZMPjzHbe1ZerFyDIxMgkgivmDOCBipXc1ZslzEO', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('f5d7572e-2220-40ea-88d7-e0319700fd3b', 'laura12@example.com', 'Laura12', 'Flores', 'Laura', 'b3d17ebbe4f2b75d27b6309cfaae1487b667301a73951e7d523a039cd2dfe110', 0, 50, 'female', 'male', 'Hi, I\'m Laura Flores, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', 135.768029, 35.011636, 2, 1, NULL),
('f5e87a8b-1b51-465b-a6df-2b1ef1ac7161', 'patricia468@example.com', 'Patricia468', 'Mitchell', 'Patricia', '8a24642e40666b7a6eed8f4f9bc7597169c0c790c552408946551c3289f697ba', 1, 48, 'female', 'male', 'Hi, I\'m Patricia Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', -75.165222, 39.952584, 24, 0, NULL),
('f610059e-2c48-4504-947f-1cba839f00a1', 'ryan442@example.com', 'Ryan442', 'Nguyen', 'Ryan', 'c61e9d892c8d7d54fd00966cdd15801cc4f2b0a916213fc1d605843f94d69edc', 0, 27, 'male', 'female', 'Hi, I\'m Ryan Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/6_boy.png', '', '', '', '', '', 2.295753, 49.894067, 37, 0, NULL),
('f6b42285-c11d-4995-ae07-7834575a14da', 'scott289@example.com', 'Scott289', 'Green', 'Scott', '279a97f7db5ddae25a243bb20c7ae68ba11f492e4c8f9cb2ec4d6a012024440d', 0, 68, 'male', 'female', 'Hi, I\'m Scott Green, welcome to my profile!', 'http://localhost:4000/uploads/2_boy.png', '', '', '', '', '', -112.074037, 33.448377, 9, 0, NULL),
('f7031349-d86e-4c68-87aa-75a09aac5d5b', 'david271@example.com', 'David271', 'Harris', 'David', 'cdb46f420d93a5780facd6db889919714e26e873e6a2ed56ed2433e5e4f48a3c', 0, 42, 'male', 'male', 'Hi, I\'m David Harris, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', 2.298280, 48.875312, 25, 0, NULL),
('f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', 'ruruover1105@gmail.com', 'Heim', 'Libard', 'Heim', '$2b$10$.f5/yVVDr/.hoT9XG3HyU.yVcyRQfaWCLJEJtKqmb8O1i5U9VcSWW', 1, 26, 'male', 'female', 'nature', 'http://localhost:4000/uploads/elijah-hiett-umfpFoKxIVg-unsplash.jpg', '', '', '', '', '', 139.845830, 35.752097, 0, 0, NULL),
('f78602f6-57ea-460c-82c5-b1835d1ce999', 'hannah385@example.com', 'Hannah385', 'Green', 'Hannah', '1ca201d0057e58e3ec9f018e4a2b531d50851917cea4564b7bcfa2edafa76ec7', 1, 50, 'female', 'male', 'Hi, I\'m Hannah Green, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', -118.243683, 34.052235, 75, 1, NULL),
('f85e0395-80ef-4272-8b09-9f397305cf14', 'kyle366@example.com', 'Kyle366', 'Nguyen', 'Kyle', '1bcb5338a15573f210f25512239e6d9cd5c276b131874da6e00b3e84c91b8ca5', 0, 99, 'male', 'female', 'Hi, I\'m Kyle Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', 3.717424, 51.054342, 82, 1, NULL),
('f89aa21e-dfe4-4fdb-ac8b-7a0d1c97c4af', 'nicole14@example.com', 'Nicole14', 'Ramirez', 'Nicole', 'c6863e1db9b396ed31a36988639513a1c73a065fab83681f4b77adb648fac3d6', 0, 88, 'female', 'male', 'Hi, I\'m Nicole Ramirez, welcome to my profile!', 'http://localhost:4000/uploads/12_girl.png', '', '', '', '', '', 1.444209, 43.604652, 22, 1, NULL),
('f89f838b-a84e-4608-8a17-efcb6a28818a', 'mary401@example.com', 'Mary401', 'Davis', 'Mary', '721372cf54ed3707643772ffc45553f30f22de5f2095f1d39c07e84cd540ae71', 1, 42, 'female', 'male', 'Hi, I\'m Mary Davis, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 139.829356, 35.841208, 13, 1, NULL),
('f8b7a58f-3921-40e2-a519-a48b3a37b466', 'betty425@example.com', 'Betty425', 'Adams', 'Betty', 'da1b849ef2f18221cb652267c4af997a4048bfef5fc499380722a46527552a71', 1, 24, 'female', 'male', 'Hi, I\'m Betty Adams, welcome to my profile!', 'http://localhost:4000/uploads/8_girl.png', '', '', '', '', '', 1.444209, 43.604652, 33, 1, NULL),
('f928cef0-153a-4d5d-b57f-2bc96af2827b', 'gloria311@example.com', 'Gloria311', 'Thompson', 'Gloria', 'ef55646022592c1e67a7d3e69b7f324a34600563050aaab70f357d7d364b1a64', 1, 33, 'female', 'male', 'Hi, I\'m Gloria Thompson, welcome to my profile!', 'http://localhost:4000/uploads/9_girl.png', '', '', '', '', '', -95.369804, 29.760427, 96, 0, NULL),
('f9bb4c23-f840-4b5a-a22c-1e8daa610891', 'nancy357@example.com', 'Nancy357', 'Lopez', 'Nancy', 'b444c65816b6a46570bce73463324baf9ac08befc007a97648a1919d22a4a3bc', 1, 20, 'female', 'male', 'Hi, I\'m Nancy Lopez, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -80.843127, 35.227087, 31, 0, NULL),
('f9eb4c78-4a4e-4c35-a956-46a88c3f1ba2', 'kathryn239@example.com', 'Kathryn239', 'Rodriguez', 'Kathryn', '675d918146fd1148871ad40822ef990c5f0d8e195bacdbd21f2a5ed8b826a546', 0, 51, 'female', 'male', 'Hi, I\'m Kathryn Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', 3.087025, 45.777222, 14, 1, NULL),
('f9eb7df6-e38a-4b4a-9a41-269ccb8f3ae3', 'susan195@example.com', 'Susan195', 'Torres', 'Susan', 'd01be9a8818019da9b962035f3de9e6aa1ec1b15c96a9044508a5cd2bd226286', 1, 41, 'female', 'male', 'Hi, I\'m Susan Torres, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 2.173404, 41.385064, 19, 0, NULL),
('fa176e8b-7314-49a0-b70b-f1059e9abaa2', 'elizabeth126@example.com', 'Elizabeth126', 'Taylor', 'Elizabeth', 'd42ba32b8703fe9bcffc5c16b6c5679363d595724c63a0ed111ac59a1d467070', 0, 55, 'female', 'male', 'Hi, I\'m Elizabeth Taylor, welcome to my profile!', 'http://localhost:4000/uploads/5_girl.png', '', '', '', '', '', -95.369804, 29.760427, 76, 0, NULL),
('fa6f4e83-20e5-4321-8849-b767b5f69f76', 'debra39@example.com', 'Debra39', 'Wilson', 'Debra', 'f245ffb6352c8c101b0f9ed1187104f11e0a64622cc5da7082aef963dea5a83f', 1, 69, 'female', 'male', 'Hi, I\'m Debra Wilson, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', 139.036413, 37.916192, 45, 1, NULL),
('fb9f423b-9824-4ab2-8558-d76e1fd15e06', 'kathryn300@example.com', 'Kathryn300', 'Allen', 'Kathryn', 'be920dc7a7ed04be07aa8f4d5dff88e7b59a6015f54d7b269912e031375d2c30', 1, 25, 'female', 'male', 'Hi, I\'m Kathryn Allen, welcome to my profile!', 'http://localhost:4000/uploads/4_girl.png', '', '', '', '', '', -75.165222, 39.952584, 27, 1, NULL),
('fc1be141-f818-42ea-ab2a-9240c3a97e92', 'laura402@example.com', 'Laura402', 'Mitchell', 'Laura', '6ddabe8a5545722d98adf71a886c1ec7b2e7d074fc4d0a5639b7a391e4727650', 0, 52, 'female', 'male', 'Hi, I\'m Laura Mitchell, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', -0.579180, 44.837789, 97, 0, NULL),
('fc3c84c9-c254-4f18-8a8f-cace5cc0ad6b', 'carl145@example.com', 'Carl145', 'Carter', 'Carl', '03f7c686af0e3374975141ab84edb5a67b24fbff8f13df0cb808389138a8d360', 1, 49, 'male', 'female', 'Hi, I\'m Carl Carter, welcome to my profile!', 'http://localhost:4000/uploads/3_boy.png', '', '', '', '', '', 139.638026, 35.443708, 57, 0, NULL),
('fc894635-97a6-414b-80c3-c0e46916690d', 'sharon353@example.com', 'Sharon353', 'Miller', 'Sharon', '42245ec16e4d08d17312b0f7c814b2a5be84f9a23214842bf5ebbe808fbc26d1', 0, 80, 'female', 'male', 'Hi, I\'m Sharon Miller, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 4.402464, 51.219448, 89, 1, NULL),
('fc988356-3bc0-4ae7-87b9-340727fafc37', 'matthew487@example.com', 'Matthew487', 'Martinez', 'Matthew', '6c009162fb75ecde9b8911697d2823a4f70930827c896ead254bec1085a765fb', 0, 90, 'male', 'female', 'Hi, I\'m Matthew Martinez, welcome to my profile!', 'http://localhost:4000/uploads/9_boy.png', '', '', '', '', '', 2.295753, 49.894067, 60, 1, NULL),
('fcd546b6-9c9b-44d3-ab55-c41bb110e3db', 'george269@example.com', 'George269', 'Scott', 'George', '3a3851eb0432b0b29bad7a46fce1a034b64036cee22923cb91a39c097cc7b0d2', 0, 61, 'male', 'female', 'Hi, I\'m George Scott, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', -1.553621, 47.218371, 67, 0, NULL),
('fd6ebad4-d15a-43f6-b436-2d006733be5c', 'martha498@example.com', 'Martha498', 'Roberts', 'Martha', '127e5fbf2597cef61890d9d512d82513d1dac0a447677041bf05eeb5499844aa', 1, 83, 'female', 'male', 'Hi, I\'m Martha Roberts, welcome to my profile!', 'http://localhost:4000/uploads/10_girl.png', '', '', '', '', '', 21.011486, 52.225406, 80, 0, NULL),
('fde0e88d-faa3-44ee-af1a-54cb7a4dd681', 'gerald38@example.com', 'Gerald38', 'Young', 'Gerald', '014d020993865f93b80ec587e171554db5b45a1a46a9101510de52e148aa184f', 1, 98, 'male', 'female', 'Hi, I\'m Gerald Young, welcome to my profile!', 'http://localhost:4000/uploads/5_boy.png', '', '', '', '', '', 5.369780, 43.296482, 29, 0, NULL),
('fe5c3081-d3d1-4c90-a136-31edee51f813', 'andrea276@example.com', 'Andrea276', 'Lewis', 'Andrea', 'b824a3d804dc55ae2857a4e8932b2f140bdca39f387ea4eecbba23713ec02a71', 0, 86, 'female', 'male', 'Hi, I\'m Andrea Lewis, welcome to my profile!', 'http://localhost:4000/uploads/2_girl.png', '', '', '', '', '', -122.419416, 37.774929, 27, 1, NULL),
('fedd058a-e417-46bd-88d3-47ac3f987ce4', 'judith238@example.com', 'Judith238', 'Baker', 'Judith', '73383668dd42a36cc3d7fbc29cc08308c9a98a65433bb7a76f83693fea41735f', 0, 61, 'female', 'male', 'Hi, I\'m Judith Baker, welcome to my profile!', 'http://localhost:4000/uploads/1_girl.png', '', '', '', '', '', 136.906398, 35.181446, 21, 1, NULL),
('fef1f6c3-b473-47f9-9f79-9d4877dc8d0b', 'olivia355@example.com', 'Olivia355', 'Nguyen', 'Olivia', 'a2f6a92a709a0b9bfa8a9391b600348392999bca1f885568df7a4334503cba1f', 0, 53, 'female', 'male', 'Hi, I\'m Olivia Nguyen, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 130.401716, 33.590355, 50, 0, NULL),
('ff0047fc-8665-4f83-ae5e-9c9c8593c6ad', 'jacob291@example.com', 'Jacob291', 'Nelson', 'Jacob', 'eac59b921d864d3ceb20cc14b68ceafb71b1820073bed6cce44590f2ae60cd91', 1, 72, 'male', '', 'Hi, I\'m Jacob Nelson, welcome to my profile!', 'http://localhost:4000/uploads/8_boy.png', '', '', '', '', '', -5.984459, 37.389092, 13, 0, NULL),
('ff4130e5-1d8b-44e2-bc72-9dec4e9d385c', 'matthew310@example.com', 'Matthew310', 'Rodriguez', 'Matthew', 'bbcb0343da9bd12e2f25f276126953437808e9b6610d30e9a2546686e0d365a2', 1, 95, 'male', 'female', 'Hi, I\'m Matthew Rodriguez, welcome to my profile!', 'http://localhost:4000/uploads/1_boy.png', '', '', '', '', '', -95.369804, 29.760427, 21, 1, NULL),
('ff7b142b-c943-4fbf-aff2-18781fc30f3c', 'megan57@example.com', 'Megan57', 'Taylor', 'Megan', '5436508fb28e193da4a51c675d96e1d412d5e2ab3e128e509a27efccff2a9240', 1, 33, 'female', '', 'Hi, I\'m Megan Taylor, welcome to my profile!', 'http://localhost:4000/uploads/11_girl.png', '', '', '', '', '', 139.036413, 37.916192, 73, 0, NULL),
('ffd41eb6-cce3-434e-a32a-a542873c3099', 'ann254@example.com', 'Ann254', 'Miller', 'Ann', 'b16c276f602722f88c2f95a6858f976db90dc3e717e9272a74d925c3009629ab', 1, 78, 'female', 'male', 'Hi, I\'m Ann Miller, welcome to my profile!', 'http://localhost:4000/uploads/6_girl.png', '', '', '', '', '', 135.195511, 34.690083, 22, 0, NULL);

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
(52, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '26'),
(53, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '28'),
(54, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '24'),
(55, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '25'),
(56, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '27'),
(57, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '29'),
(58, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '23');

-- --------------------------------------------------------

--
-- テーブルの構造 `viewed`
--

CREATE TABLE `viewed` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `viewed_to_user_id` varchar(256) NOT NULL,
  `viewed_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- テーブルのデータのダンプ `viewed`
--

INSERT INTO `viewed` (`id`, `from_user_id`, `viewed_to_user_id`, `viewed_at`) VALUES
(91, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19'),
(92, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19'),
(93, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20'),
(94, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20'),
(95, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20'),
(96, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20'),
(97, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23'),
(98, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23'),
(99, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '0095667e-3e81-4db3-810a-f79122dc81ff', '2024-04-24'),
(100, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '0095667e-3e81-4db3-810a-f79122dc81ff', '2024-04-24'),
(101, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-04-24'),
(102, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-04-24'),
(103, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '10a04618-9820-4ab4-abd9-98b5697421c5', '2024-04-24'),
(104, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '10a04618-9820-4ab4-abd9-98b5697421c5', '2024-04-24'),
(105, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'ef14890f-0c63-47ed-b5be-21d4490eff43', '2024-04-24'),
(106, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'ef14890f-0c63-47ed-b5be-21d4490eff43', '2024-04-24'),
(107, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '17249c28-7a44-4bc6-bf73-d5bcad2bef82', '2024-04-24'),
(108, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '17249c28-7a44-4bc6-bf73-d5bcad2bef82', '2024-04-24'),
(109, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '3096ee74-0065-49cd-a67b-e26c94d0b1ba', '2024-04-24'),
(110, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '3096ee74-0065-49cd-a67b-e26c94d0b1ba', '2024-04-24'),
(111, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '003bc2f3-bfbe-4471-86e5-a61f220c9d12', '2024-04-24'),
(112, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '003bc2f3-bfbe-4471-86e5-a61f220c9d12', '2024-04-24'),
(113, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1d35bfa2-6db1-4dc1-ac23-23cb44ff1a57', '2024-04-24'),
(114, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1d35bfa2-6db1-4dc1-ac23-23cb44ff1a57', '2024-04-24'),
(115, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '8727a67e-1a50-48bb-b854-355c3ec200ea', '2024-04-24'),
(116, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '8727a67e-1a50-48bb-b854-355c3ec200ea', '2024-04-24'),
(117, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '2024-04-24'),
(118, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'f7124659-ea40-4df8-b2dc-f2f8c5f7b1b7', '2024-04-24'),
(119, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0b39699d-9e9d-45d7-bc6e-011c36697b90', '2024-04-24'),
(120, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0b39699d-9e9d-45d7-bc6e-011c36697b90', '2024-04-24'),
(121, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0256716d-98db-462a-bc42-4f13bd7c2922', '2024-04-24'),
(122, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '0256716d-98db-462a-bc42-4f13bd7c2922', '2024-04-24'),
(123, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'eb7f1e94-8865-4feb-b213-4a8a429c0bcb', '2024-04-24'),
(124, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'eb7f1e94-8865-4feb-b213-4a8a429c0bcb', '2024-04-24'),
(125, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '70b3135b-3012-45f0-94f9-665bb5538a97', '2024-04-24'),
(126, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '70b3135b-3012-45f0-94f9-665bb5538a97', '2024-04-24'),
(127, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22'),
(128, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- テーブルの AUTO_INCREMENT `liked`
--
ALTER TABLE `liked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- テーブルの AUTO_INCREMENT `matched`
--
ALTER TABLE `matched`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- テーブルの AUTO_INCREMENT `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- テーブルの AUTO_INCREMENT `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- テーブルの AUTO_INCREMENT `room_messages`
--
ALTER TABLE `room_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- テーブルの AUTO_INCREMENT `usertag`
--
ALTER TABLE `usertag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- テーブルの AUTO_INCREMENT `viewed`
--
ALTER TABLE `viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

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
