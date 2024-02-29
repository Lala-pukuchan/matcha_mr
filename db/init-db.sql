-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db:3306
-- Generation Time: Feb 29, 2024 at 05:22 AM
-- Server version: 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP Version: 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `matcha`
--

-- --------------------------------------------------------

--
-- Table structure for table `blocked`
--

CREATE TABLE `blocked` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `blocked_to_user_id` varchar(256) NOT NULL,
  `blocked_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `blocked`
--

INSERT INTO `blocked` (`id`, `from_user_id`, `blocked_to_user_id`, `blocked_at`) VALUES
(3, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '2024-02-23 04:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `liked`
--

CREATE TABLE `liked` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `liked_to_user_id` varchar(256) NOT NULL,
  `liked_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `liked`
--

INSERT INTO `liked` (`id`, `from_user_id`, `liked_to_user_id`, `liked_at`) VALUES
(22, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-14 16:10:02'),
(26, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'e4707942-09b2-4667-a9e8-e87b75b594c7', '2024-02-15 09:56:30'),
(27, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-15 09:56:33'),
(28, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '2024-02-15 09:56:38'),
(29, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-16 05:02:43'),
(30, '57457753-b995-41bd-9c9e-f78d7b0d6699', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 06:10:05'),
(31, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '57457753-b995-41bd-9c9e-f78d7b0d6699', '2024-02-20 06:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `matched`
--

CREATE TABLE `matched` (
  `id` int(11) NOT NULL,
  `matched_user_id_first` varchar(256) NOT NULL,
  `matched_user_id_second` varchar(256) NOT NULL,
  `matched_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `matched`
--

INSERT INTO `matched` (`id`, `matched_user_id_first`, `matched_user_id_second`, `matched_at`) VALUES
(4, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-15 09:56:30'),
(5, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-16 05:02:43'),
(6, '57457753-b995-41bd-9c9e-f78d7b0d6699', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20 06:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `id` int(11) NOT NULL,
  `name` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tag`
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
-- Table structure for table `user`
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
  `fake_account` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `username`, `lastname`, `firstname`, `password`, `enabled`, `age`, `gender`, `preference`, `biography`, `profilePic`, `pic1`, `pic2`, `pic3`, `pic4`, `pic5`, `longitude`, `latitude`, `match_ratio`, `fake_account`) VALUES
('3d3638e4-a5aa-4ce9-95c6-e9a4bb4b2caa', 'ruruover1105@gmail.com', 'ABC123@', 'Kobayashi', 'Ruru', '$2b$10$dNJoYchwO0uPCCeJDnUIRO4bb.ggKctS0qRhxeXmoZxyFeCysa5om', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0),
('41a84720-a3e3-4970-bd74-916b34e51df8', 'ruruover1105@gmail.com', 'a', 'Kobayashi', 'Ruru-', '$2b$10$AYhZWiTiwqoQ0oM1FRxUiOfPs4bNvv7twzPNj45dqWEuxDT4UtqT2', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0),
('70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', 'ruruover1105@gmail.com', 'collis', 'collis', 'Leadford', '$2b$10$A0ARrMOo7b286GAtS37GHuIcQeI9YtlnpeTWGhfvyHYHauENE4Wwm', 1, 36, 'male', 'no', 'music is my life', 'http://localhost:4000/uploads/pexels-collis-3031391.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', '', 2.336175, 48.885805, 0, 0),
('73de925b-0b9a-4a11-a7c4-d95fec823a9b', 'ruruover1105@gmail.com', 'Linda', 'Richard', 'Linda', '$2b$10$iOoNh3LTkwcHF9/HcX1wLO1G1YlIAwf9l7yxaRFpLtW03SEbOduMW', 1, 32, 'female', 'male', 'let\'s drink together', 'http://localhost:4000/uploads/pexels-andrea-piacquadio-733872.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 2.336149, 48.885829, 75, 0),
('750f838c-356f-4c1d-8ad2-0b4e76882595', 'ruruover1105@gmail.com', 'nitin', 'khajotia', 'nitin', '$2b$10$Dgrs9IqicLEyqlYwbRXUuencXAjJ38851foMKIZ/wEsng0Fzlk5na', 1, 0, 'male', 'male', 'be strong', 'http://localhost:4000/uploads/pexels-nitin-khajotia-1516680.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0),
('77743911-bb39-408b-af66-d84df45d73fa', 'ruruover1105@gmail.com', 'jeffrey', 'reed', 'jeffrey', '$2b$10$TsT46xB3rKlQH1nApfWiGuDGjjyR0LmfWpdkkm.h0U3gV2VUtaftq', 1, 18, 'male', 'female', 'study math', 'http://localhost:4000/uploads/pexels-jeffrey-reed-769690.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 100, 0),
('78a685aa-07f0-4f57-9285-e35ee7c7c7aa', 'ruruover1105@gmail.com', 'ferreira', 'kamiz', 'ferreira', '$2b$10$/VCzQq3FwiwzAfb8ozfVBuGdB40kn0FxlFZ3M3sYIF.XYseOiKVXu', 1, 0, 'female', 'female', 'love', 'http://localhost:4000/uploads/pexels-kamiz-ferreira-2218786.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0),
('9ec4c4ca-978b-434d-8302-b4ad68565c4c', 'ruruover1105@gmail.com', 'melo', 'italo', 'melo', '$2b$10$ZV9Gi0zu4nRZki30973SG.W0aXFLIiUO9haCBygmC4GXBGRSCU2Qe', 1, 28, 'male', 'female', 'let\'s chill', 'http://localhost:4000/uploads/pexels-italo-melo-2379005.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 2.336149, 48.885829, 0, 0),
('c27c9ee4-f2f3-47b5-a33b-361916016dc1', 'ruruover1105@gmail.com', 'lucas', 'pezeta', 'lucas', '$2b$10$ic7gHvggUomiVkK27v64cOZ7jU3dnArQOkHG2lUP4UJlZ4azwRsRS', 1, 0, 'female', 'male', 'take a break', 'http://localhost:4000/uploads/pexels-lucas-pezeta-2112714.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 48.896120, 2.319370, 0, 0),
('e4707942-09b2-4667-a9e8-e87b75b594c7', 'ruruover1105@gmail.com', 'spencer', 'selover', 'spencer', '$2b$10$UkNeBpejAsvZlQxNbmvqt.9bTFm4dTqynLZz9VShf1Y/wZ2Uw2hnG', 1, 0, 'male', 'female', 'hello', 'http://localhost:4000/uploads/pexels-spencer-selover-775358.jpg', 'http://localhost:4000/uploads/pexels-daniel-torobekov-20058411.jpg', 'http://localhost:4000/uploads/pexels-jeremy-bishop-20145983.jpg', 'http://localhost:4000/uploads/pexels-alena-yanovich-20119386.jpg', 'http://localhost:4000/uploads/pexels-dilara-yÄ±lmaz-20200303.jpg', 'http://localhost:4000/uploads/pexels-elina-volkova-19985436.jpg', 2.336149, 48.885829, 0, 1),
('f586f458-36ca-4396-96e1-fa2a573baa73', 'ruruover1105@gmail.com', 'Test', 'Kobayashi', 'Ruru', '$2b$10$2uIIFdtI8nEVPPZMPjzHbe1ZerFyDIxMgkgivmDOCBipXc1ZslzEO', 0, 0, '', '', '', '', '', '', '', '', '', 2.319370, 48.896120, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `usertag`
--

CREATE TABLE `usertag` (
  `id` int(11) NOT NULL,
  `user_id` varchar(256) NOT NULL,
  `tag_id` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `usertag`
--

INSERT INTO `usertag` (`id`, `user_id`, `tag_id`) VALUES
(20, '78a685aa-07f0-4f57-9285-e35ee7c7c7aa', '26'),
(21, '78a685aa-07f0-4f57-9285-e35ee7c7c7aa', '24'),
(22, 'c27c9ee4-f2f3-47b5-a33b-361916016dc1', '26'),
(23, 'c27c9ee4-f2f3-47b5-a33b-361916016dc1', '24'),
(24, 'c27c9ee4-f2f3-47b5-a33b-361916016dc1', '27'),
(25, '750f838c-356f-4c1d-8ad2-0b4e76882595', '2'),
(26, '750f838c-356f-4c1d-8ad2-0b4e76882595', '8'),
(27, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '24'),
(28, 'e4707942-09b2-4667-a9e8-e87b75b594c7', '29'),
(43, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '27'),
(44, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '29'),
(45, '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '24'),
(46, '70326ac8-3f29-4faa-aed8-a72b3bfe9ca5', '25'),
(47, '77743911-bb39-408b-af66-d84df45d73fa', '24'),
(48, '77743911-bb39-408b-af66-d84df45d73fa', '27'),
(49, '9ec4c4ca-978b-434d-8302-b4ad68565c4c', '26'),
(50, '9ec4c4ca-978b-434d-8302-b4ad68565c4c', '25'),
(51, '9ec4c4ca-978b-434d-8302-b4ad68565c4c', '23');

-- --------------------------------------------------------

--
-- Table structure for table `viewed`
--

CREATE TABLE `viewed` (
  `id` int(11) NOT NULL,
  `from_user_id` varchar(256) NOT NULL,
  `viewed_to_user_id` varchar(256) NOT NULL,
  `viewed_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `viewed`
--

INSERT INTO `viewed` (`id`, `from_user_id`, `viewed_to_user_id`, `viewed_at`) VALUES
(91, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19'),
(92, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-19'),
(93, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20'),
(94, '77743911-bb39-408b-af66-d84df45d73fa', '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '2024-02-20'),
(95, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20'),
(96, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-20'),
(97, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23'),
(98, '73de925b-0b9a-4a11-a7c4-d95fec823a9b', '77743911-bb39-408b-af66-d84df45d73fa', '2024-02-23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blocked`
--
ALTER TABLE `blocked`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `liked`
--
ALTER TABLE `liked`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `matched`
--
ALTER TABLE `matched`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_id` (`name`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usertag`
--
ALTER TABLE `usertag`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `viewed`
--
ALTER TABLE `viewed`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blocked`
--
ALTER TABLE `blocked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `liked`
--
ALTER TABLE `liked`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `matched`
--
ALTER TABLE `matched`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `usertag`
--
ALTER TABLE `usertag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `viewed`
--
ALTER TABLE `viewed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
