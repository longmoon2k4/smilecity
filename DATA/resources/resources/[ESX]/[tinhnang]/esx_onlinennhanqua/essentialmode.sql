-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th5 10, 2021 lúc 07:04 PM
-- Phiên bản máy phục vụ: 10.4.17-MariaDB
-- Phiên bản PHP: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `essentialmode`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nhanqua_online`
--

CREATE TABLE `nhanqua_online` (
  `identifier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `online` int(50) DEFAULT 0,
  `day1` varchar(150) NOT NULL,
  `day2` varchar(150) NOT NULL,
  `day3` varchar(150) NOT NULL,
  `day4` varchar(150) NOT NULL,
  `day5` varchar(150) NOT NULL,
  `day6` varchar(150) NOT NULL,
  `day7` varchar(150) NOT NULL,
  `day8` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `nhanqua_online`
--

INSERT INTO `nhanqua_online` (`identifier`, `online`, `day1`, `day2`, `day3`, `day4`, `day5`, `day6`, `day7`, `day8`) VALUES
('steam:11000011cfa450c', 3, '', '', '', '', '', '', '', '');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
