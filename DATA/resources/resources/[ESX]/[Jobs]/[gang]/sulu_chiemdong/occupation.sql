-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 15, 2020 lúc 03:00 PM
-- Phiên bản máy phục vụ: 10.4.17-MariaDB
-- Phiên bản PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `hdcc`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `occupation`
--

CREATE TABLE `occupation` (
  `name` char(50) DEFAULT NULL,
  `gang_name` char(50) DEFAULT NULL,
  `lastcapture` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `occupation`
--

INSERT INTO `occupation` (`name`, `gang_name`, `lastcapture`) VALUES
('thunglungchet', 'macao', 1607872377),
('baibien', 'macao', 1607869739),
('songamazon', 'macao', 1607866732),
('chiem5', 'macao', 1607956457),
('chiem4', NULL, 0),
('chiem6', NULL, 0),
('chiem3', 'macao', 1607955545);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `occupation_point`
--

CREATE TABLE `occupation_point` (
  `gang_name` char(50) DEFAULT NULL,
  `point` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `occupation_point`
--

INSERT INTO `occupation_point` (`gang_name`, `point`) VALUES
('ballas', 4),
('heo', 0),
('police', 0),
('macao', 725);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
essentialmodeessentialmode