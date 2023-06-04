-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2023 at 09:47 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cool_coders`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `sno` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` int(10) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact_us`
--

INSERT INTO `contact_us` (`sno`, `name`, `email`, `phone`, `msg`, `date`) VALUES
(1, 'first post', 'firstpost@gmail.com', 1234545441, 'This is the demo post', '2023-05-02 20:03:13'),
(2, 'Anubhav', 'adi17272@gmail.com', 2147483647, 'dadadas', '2023-05-02 20:49:35'),
(3, 'dass', 'sadi17272@gmail.com', 2147483647, 'sfssdsddsdssd', '2023-05-04 19:47:23'),
(4, 'Rahul Kalra', 'ab1121@gmail.com', 2147483647, 'nnnbnbnn', '2023-05-04 19:49:05'),
(5, 'dass', 'freaAFESDZ@qwew.com', 2147483647, ' mmmmmm', '2023-05-04 19:52:31'),
(6, 'dass', 'freaAFESDZ@qwew.com', 2147483647, ' mmmmmm', '2023-05-04 19:59:00'),
(7, 'dass', 'ab1121@gmail.com', 2147483647, 'nnmnmn m', '2023-05-04 19:59:20'),
(8, 'GUN', 'gadi17272@gmail.com', 2147483647, 'bgghghghgh', '2023-05-04 20:05:43'),
(9, 'ditya', 'di17272@gmail.com', 2147483647, 'nnmnnn', '2023-05-04 20:07:00'),
(10, 'dass', 'ab1121@gmail.com', 2147483647, 'adfafafas', '2023-05-04 20:09:23'),
(11, 'Aditya', 'freaAFESDZ@qwew.com', 2147483647, 'n n n mnnm nm', '2023-05-04 20:17:17'),
(12, 'dass', 'ladi17272@gmail.com', 34567890, 'mm,m ,mm m ', '2023-05-04 20:27:42'),
(13, 'dass', 'freaAFESDZ@qwew.com', 2147483647, '  n nm m  nm m nm ', '2023-05-04 20:29:33'),
(14, 'dass', 'adi17272@gmail.com', 2147483647, 'mnmnmm, ,m', '2023-05-04 20:46:01');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `Sno` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `tagline` varchar(20) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` varchar(500) NOT NULL,
  `img_file` varchar(50) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`Sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'First Title', 'Frrate dar first had', 'First-Post', 'This is my first post through flask in this site. blah blah', 'post-bg.jpg', '2023-06-02 12:31:46'),
(2, 'Second Post', 'srrate dar second', 'Second-Post', 'This is the second post in the blog website.', 'post-bg.jpg', '2023-05-31 15:02:27'),
(3, 'Third Post', 'Post is 3rd', '3rd-Post', 'I wasn\'t sure what to expect from From. I\'ve read everything from it\'s like Lost to it\'s a generic h', '', '2023-05-31 15:20:47'),
(4, '4th Post', 'Post is fourth', 'fourth-Post', 'I wasn\'t sure what to expect from From. I\'ve read everything from it\'s like Lost to it\'s a generic h', '', '2023-05-31 15:20:47'),
(5, 'Fifth post', 'Post is 5th', 'Fifth-Post', 'I wasn\'t sure what to expect from From. I\'ve read everything from it\'s like Lost to it\'s a generic h', '', '2023-05-31 15:22:04'),
(6, 'Sixth Post', 'Post is sixth', 'sixth-Post', 'I wasn\'t sure what to expect from From. I\'ve read everything from it\'s like Lost to it\'s a generic h', '', '2023-05-31 15:22:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`Sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `Sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
