-- phpMyAdmin SQL Dump
-- version 5.2.1deb1
-- https://www.phpmyadmin.net/
--
-- Gazdă: localhost:3306
-- Timp de generare: mart. 29, 2023 la 07:14 AM
-- Versiune server: 10.11.2-MariaDB-1
-- Versiune PHP: 8.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Bază de date: `sms_wannabe`
--

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `uzyszkodnik`
--

CREATE TABLE `uzyszkodnik` (
  `id` int(11) NOT NULL,
  `login` tinytext NOT NULL,
  `hasz_hasla` tinytext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Eliminarea datelor din tabel `uzyszkodnik`
--

INSERT INTO `uzyszkodnik` (`id`, `login`, `hasz_hasla`) VALUES
(1, 'cokolwiek', '$2y$10$zUNynIBqr5nyGppf.wM.kOgW7zL.KvdpvVX.C4Buj/ZJLJldypKNG'),
(2, 'ezn', '$2y$10$A1POWdwIx9R2UHpxa0ZraeOqn5ktyq3NerfOLnV0XdV.qPaFaG60O'),
(3, 'damjes', '$2y$10$/8mPy17Qx.LDEYLonERpVeWUNT5tGWonY1lC3fVfTJhd0tAFtH0Vu');

-- --------------------------------------------------------

--
-- Structură tabel pentru tabel `wiadomosc`
--

CREATE TABLE `wiadomosc` (
  `id` int(11) NOT NULL,
  `od` int(11) NOT NULL,
  `do` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `tresc` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_polish_ci;

--
-- Eliminarea datelor din tabel `wiadomosc`
--

INSERT INTO `wiadomosc` (`id`, `od`, `do`, `timestamp`, `tresc`) VALUES
(1, 2, 1, '2023-03-25 07:43:32', 'Siema, wpadaj na dni otwarte.'),
(2, 1, 2, '2023-03-25 07:44:39', 'I will pass...');

-- --------------------------------------------------------

--
-- Substitut structură pentru vizualizare `w_obie_strony`
-- (Vezi mai jos vizualizarea actuală)
--
CREATE TABLE `w_obie_strony` (
`id` int(11)
,`od` int(11)
,`kierunek` varchar(4)
,`do` int(11)
,`timestamp` timestamp /* mariadb-5.3 */
,`tresc` mediumtext
);

-- --------------------------------------------------------

--
-- Substitut structură pentru vizualizare `w_obie_z_loginem`
-- (Vezi mai jos vizualizarea actuală)
--
CREATE TABLE `w_obie_z_loginem` (
`id` int(11)
,`od` int(11)
,`kierunek` varchar(4)
,`do_login` tinytext
,`do_id` int(11)
,`timestamp` timestamp /* mariadb-5.3 */
,`tresc` mediumtext
);

-- --------------------------------------------------------

--
-- Structură pentru vizualizare `w_obie_strony`
--
DROP TABLE IF EXISTS `w_obie_strony`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `w_obie_strony`  AS SELECT `wiadomosc`.`id` AS `id`, `wiadomosc`.`od` AS `od`, 'Do: ' AS `kierunek`, `wiadomosc`.`do` AS `do`, `wiadomosc`.`timestamp` AS `timestamp`, `wiadomosc`.`tresc` AS `tresc` FROM `wiadomosc`union select `wiadomosc`.`id` AS `id`,`wiadomosc`.`do` AS `do`,'Od: ' AS `Name_exp_3`,`wiadomosc`.`od` AS `od`,`wiadomosc`.`timestamp` AS `timestamp`,`wiadomosc`.`tresc` AS `tresc` from `wiadomosc`  ;

-- --------------------------------------------------------

--
-- Structură pentru vizualizare `w_obie_z_loginem`
--
DROP TABLE IF EXISTS `w_obie_z_loginem`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `w_obie_z_loginem`  AS SELECT `w_obie_strony`.`id` AS `id`, `w_obie_strony`.`od` AS `od`, `w_obie_strony`.`kierunek` AS `kierunek`, `uzyszkodnik`.`login` AS `do_login`, `w_obie_strony`.`id` AS `do_id`, `w_obie_strony`.`timestamp` AS `timestamp`, `w_obie_strony`.`tresc` AS `tresc` FROM (`w_obie_strony` left join `uzyszkodnik` on(`w_obie_strony`.`do` = `uzyszkodnik`.`id`)) ;

--
-- Indexuri pentru tabele eliminate
--

--
-- Indexuri pentru tabele `uzyszkodnik`
--
ALTER TABLE `uzyszkodnik`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`) USING HASH;

--
-- Indexuri pentru tabele `wiadomosc`
--
ALTER TABLE `wiadomosc`
  ADD PRIMARY KEY (`id`),
  ADD KEY `od` (`od`),
  ADD KEY `do` (`do`);

--
-- AUTO_INCREMENT pentru tabele eliminate
--

--
-- AUTO_INCREMENT pentru tabele `uzyszkodnik`
--
ALTER TABLE `uzyszkodnik`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pentru tabele `wiadomosc`
--
ALTER TABLE `wiadomosc`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constrângeri pentru tabele eliminate
--

--
-- Constrângeri pentru tabele `wiadomosc`
--
ALTER TABLE `wiadomosc`
  ADD CONSTRAINT `wiadomosc_ibfk_1` FOREIGN KEY (`od`) REFERENCES `uzyszkodnik` (`id`) ON DELETE NO ACTION,
  ADD CONSTRAINT `wiadomosc_ibfk_2` FOREIGN KEY (`do`) REFERENCES `uzyszkodnik` (`id`) ON DELETE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
