-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- ホスト: db:3306
-- 生成日時: 2024 年 9 月 21 日 10:46
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
(35, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22 14:25:31'),
(36, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-10 20:07:33'),
(37, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10 20:08:35');

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
(8, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-07-22 14:25:31'),
(9, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-10 20:08:35');

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
(3, 1, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'Hello Eric', '2024-07-22 19:04:41'),
(4, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'sdfsdfd', '2024-08-10 20:06:10'),
(5, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'sdfdfdsd', '2024-08-10 20:06:12'),
(6, 2, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'Hello Eric, I\'m spam', '2024-08-10 20:09:29'),
(7, 1, 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'Arthur', '2024-08-12 13:39:16'),
(8, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'Mariko', '2024-08-12 13:39:23'),
(9, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'hgfhghgchjhhgghghfgfghjjgfdfdgfhjhkjhgfsdafdfhgjhkjgfdsfdghjhkjghdfsdafhgjhjghgfsdsadsfdgh', '2024-08-12 14:58:43'),
(10, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'jjjjllll', '2024-08-12 15:01:00'),
(11, 1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '<i>aa</>', '2024-08-12 15:02:21');

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
  `checked` boolean NOT NULL DEFAULT false,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
(1, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273'),
(2, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd');

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
(48, 'Second-Hand Shopping'),
(36, 'Street Art'),
(27, 'Study'),
(29, 'Surf'),
(41, 'Sustainability'),
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
('1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'tsujimarico@gmail.com', 'Eric', 'Eric', 'Cartman', '$2b$10$Tp.qBIVSD2OZXudA/S8NY.lt9XdM3nTPfHkNJ7VXvvFdBEych14ie', 1, 20, 'male', 'female', 'Screw guys, I\'m going home', 'http://localhost:4000/uploads/eric-cartman_380.webp', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 100, 0, '2024-08-17 11:26:20'),
('1b2fd45a-77f5-48fa-b112-c9fb2799707e', 'tsujimarico@gmail.com', 'mariko', 'mariko', 'mariko', '$2b$10$vybdSVFPBLqs3dJC7NsIRuuswS4dL/6dXjf04dMcdBqRKgfvO5hcW', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('3d3638e4-a5aa-4ce9-95c6-e9a4bb4b2caa', 'ruruover1105@gmail.com', 'ABC123@', 'Kobayashi', 'Ruru', '$2b$10$dNJoYchwO0uPCCeJDnUIRO4bb.ggKctS0qRhxeXmoZxyFeCysa5om', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('41a84720-a3e3-4970-bd74-916b34e51df8', 'ruruover1105@gmail.com', 'a', 'Kobayashi', 'Ruru-', '$2b$10$AYhZWiTiwqoQ0oM1FRxUiOfPs4bNvv7twzPNj45dqWEuxDT4UtqT2', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', 'ruruover1105@gmail.com', 'collis', 'collis', 'Leadford', '$2b$10$A0ARrMOo7b286GAtS37GHuIcQeI9YtlnpeTWGhfvyHYHauENE4Wwm', 1, 36, 'male', 'no', 'music is my life', 'http://localhost:4000/uploads/pexels-collis-3031391.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', '', 2.336175, 48.885805, 0, 0, NULL),
('73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'ruruover1105@gmail.com', 'Linda', 'Richard', 'Linda', '$2b$10$iOoNh3LTkwcHF9/HcX1wLO1G1YlIAwf9l7yxaRFpLtW03SEbOduMW', 1, 32, 'female', 'male', 'let\'s drink together', 'http://localhost:4000/uploads/pexels-andrea-piacquadio-733872.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 2.336149, 48.885829, 100, 0, NULL),
('750f838c-356f-4c1d-8ad2-0b4e76882595', 'ruruover1105@gmail.com', 'nitin', 'khajotia', 'nitin', '$2b$10$Dgrs9IqicLEyqlYwbRXUuencXAjJ38851foMKIZ/wEsng0Fzlk5na', 1, 0, 'male', 'male', 'be strong', 'http://localhost:4000/uploads/pexels-nitin-khajotia-1516680.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('77743911-bb39-408b-af66-d84df45d73fa', 'ruruover1105@gmail.com', 'jeffrey', 'reed', 'jeffrey', '$2b$10$TsT46xB3rKlQH1nApfWiGuDGjjyR0LmfWpdkkm.h0U3gV2VUtaftq', 1, 18, 'male', 'female', 'study math', 'http://localhost:4000/uploads/pexels-jeffrey-reed-769690.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 100, 0, NULL),
('78a310cf-7861-4637-8452-e83c96b77716', 'tsujimarico@gmail.com', 'marikomariko', 'mariko', 'mariko', '$2b$10$WQW27j7rVFF3cEg86Xi2C.oys7WDP20QMIumksjuc0qwfxqDgifwe', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('78a685aa-07f0-4f57-9285-e35ee7c7c7aa', 'ruruover1105@gmail.com', 'ferreira', 'kamiz', 'ferreira', '$2b$10$/VCzQq3FwiwzAfb8ozfVBuGdB40kn0FxlFZ3M3sYIF.XYseOiKVXu', 1, 0, 'female', 'female', 'love', 'http://localhost:4000/uploads/pexels-kamiz-ferreira-2218786.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0, NULL),
('8727a67e-1a50-48bb-b854-355c3ec200ea', 'ruruover1105@gmail.com', 'stephan', 'Guard', 'Stephan', '$2b$10$mMYjgSdxFG0uVcGeOePBqeL3GhiEVDo/9fZOOiZ1xeWLyuD9nP4ia', 1, 30, 'male', 'female', 'have fun', 'http://localhost:4000/uploads/stephanie-cook-NDCy2-9JhUs-unsplash.jpg', 0, 'offline', '', '', '', '', '', 2.336185, 48.885884, 0, 0, NULL),
('97ff9f6e-aa79-45cd-9641-5f649447d6c4', 'robe.de.chambre6@gmail.com', 'spam', 'spam', 'spam', '$2b$10$tgYWH4V4gcYAraf1wsmCue.vbf8uzpoHXhFfeNZiC5BAdIz.imtRa', 1, 0, 'female', 'male', '', 'http://localhost:4000/uploads/11_girl.png', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 100, 0, '2024-08-10 21:54:22'),
('9cc0b285-b413-4492-8193-e5431272f5f6', 'tsujimarico@gmail.com', 'Mamariko', 'Mamariko', 'Mamariko', '$2b$10$qlyVr9yUXCTSSFb4B6tlVevj9sybIqVz/E2Kxipq1MPwjjjnGZMzG', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('9ec4c4ca-978b-434d-8302-b4ad68565c4c', 'ruruover1105@gmail.com', 'melo', 'italo', 'melo', '$2b$10$ZV9Gi0zu4nRZki30973SG.W0aXFLIiUO9haCBygmC4GXBGRSCU2Qe', 1, 28, 'male', 'female', 'let\'s chill', 'http://localhost:4000/uploads/pexels-italo-melo-2379005.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 2.336149, 48.885829, 0, 0, NULL),
('a9c961e2-ed52-45d0-9d6a-b6117f6f9454', 'tsujimarico@icloud.com', 'TestUser', 'TSUJI', 'Mariko', '$2b$10$/MtaCdTrmVyBDJugRh3JY.JtfUfrRsWLc1AoGjBIRQfiuMkwMBkCC', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
('bd91dab6-9d53-4b06-92e1-a1bfdd271273', 'tsujimarico@gmail.com', 'Heidi', 'Turner', 'Heidi', '$2b$10$qu0pKMWYofEdhv7ddFJvS.1fFot6UIZjWy/AbRPLUN5aaefDj78pG', 1, 20, 'female', 'male', 'Hi Eric', 'http://localhost:4000/uploads/alter-egos-heidi-turner-w-hat.png', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, '2024-08-12 13:47:03'),
('c27c9ee4-f2f3-47b5-a33b-361916016dc1', 'ruruover1105@gmail.com', 'lucas', 'pezeta', 'lucas', '$2b$10$ic7gHvggUomiVkK27v64cOZ7jU3dnArQOkHG2lUP4UJlZ4azwRsRS', 1, 0, 'female', 'male', 'take a break', 'http://localhost:4000/uploads/pexels-lucas-pezeta-2112714.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.319370, 48.896120, 0, 0, NULL),
('e4707942-09b2-4667-a9e8-e87b75b594c7', 'ruruover1105@gmail.com', 'spencer', 'selover', 'spencer', '$2b$10$UkNeBpejAsvZlQxNbmvqt.9bTFm4dTqynLZz9VShf1Y/wZ2Uw2hnG', 1, 28, 'male', 'female', 'hello', 'http://localhost:4000/uploads/pexels-spencer-selover-775358.jpg', 0, 'offline', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 0, 1, NULL),
('ee583dd0-4da8-4b77-848f-78a515a0fc22', 'ruruover1105@gmail.com', 'Kebin', 'Edimbara', 'Kebin', '$2b$10$8SVuv2h6911KE14EKpgtJuNCb7dJdnYIWjXBjC5OyDqw2j4BcnKPO', 1, 40, 'male', 'female', 'let\'s drink beer', 'http://localhost:4000/uploads/jack-finnigan-rriAI0nhcbc-unsplash.jpg', 0, 'offline', '', '', '', '', '', -0.113968, 51.506734, 0, 0, NULL),
('f586f458-36ca-4396-96e1-fa2a573baa73', 'ruruover1105@gmail.com', 'Test', 'Kobayashi', 'Ruru', '$2b$10$2uIIFdtI8nEVPPZMPjzHbe1ZerFyDIxMgkgivmDOCBipXc1ZslzEO', 0, 0, '', '', '', '', 0, 'offline', '', '', '', '', '', 2.319370, 48.896120, 0, 0, NULL),
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
(73, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '26'),
(74, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '28'),
(75, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '24'),
(76, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '25'),
(77, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '27'),
(78, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '29'),
(79, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '23');

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
(128, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', 'bd91dab6-9d53-4b06-92e1-a1bfdd271273', '2024-07-22'),
(129, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09'),
(130, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09'),
(131, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09'),
(132, '06271afb-e5b9-4904-9e3f-74171083fcfa', '77743911-bb39-408b-af66-d84df45d73fa', '2024-08-09'),
(133, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10'),
(134, '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '2024-08-10'),
(135, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-17'),
(136, '1a4f2486-dcea-4876-bf73-e7ae6eb451bd', '97ff9f6e-aa79-45cd-9641-5f649447d6c4', '2024-08-17');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- テーブルの AUTO_INCREMENT `liked`
--
ALTER TABLE `liked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- テーブルの AUTO_INCREMENT `matched`
--
ALTER TABLE `matched`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- テーブルの AUTO_INCREMENT `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- テーブルの AUTO_INCREMENT `rooms`
--
ALTER TABLE `rooms`
  MODIFY `room_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- テーブルの AUTO_INCREMENT `room_messages`
--
ALTER TABLE `room_messages`
  MODIFY `message_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- テーブルの AUTO_INCREMENT `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- テーブルの AUTO_INCREMENT `usertag`
--
ALTER TABLE `usertag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- テーブルの AUTO_INCREMENT `viewed`
--
ALTER TABLE `viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

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
