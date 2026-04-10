-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 192.168.10.20
-- Generation Time: Apr 08, 2026 at 05:01 PM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Tooth_office`
--

-- --------------------------------------------------------

--
-- Table structure for table `AVIS`
--

CREATE DATABASE Tooth_office;
USE Tooth_office;

CREATE TABLE `AVIS` (
  `id_avis` int(11) NOT NULL,
  `note` double DEFAULT NULL,
  `commentaire` text DEFAULT NULL,
  `date_avis` date DEFAULT NULL,
  `id_cabinet` int(11) DEFAULT NULL,
  `id_patient` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `AVIS`
--

INSERT INTO `AVIS` (`id_avis`, `note`, `commentaire`, `date_avis`, `id_cabinet`, `id_patient`) VALUES
(1, 4.5, 'Très bon accueil et service rapide', '2026-04-05', 1, 1),
(2, 3, 'Temps d’attente un peu long mais bon traitement', '2026-04-06', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `CABINET`
--

CREATE TABLE `CABINET` (
  `id_cabinet` int(11) NOT NULL,
  `nom_cabinet` varchar(50) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `adresse` varchar(60) DEFAULT NULL,
  `logo` varchar(200) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `id_chef_cabinet` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CABINET`
--

INSERT INTO `CABINET` (`id_cabinet`, `nom_cabinet`, `tel`, `adresse`, `logo`, `description`, `id_chef_cabinet`) VALUES
(1, 'cabinet_keneya', '70230456', 'ACI 200', 'logo', 'Description tooth office', 1),
(2, 'Espoir  ', '60245617', 'BADALABOUGOU', 'logo', 'Daciyfoaeoafcigacvmiayca', 2);

-- --------------------------------------------------------

--
-- Table structure for table `CHEF_CABINET`
--

CREATE TABLE `CHEF_CABINET` (
  `id_chef_cabinet` int(11) NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `prenom` varchar(50) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `tel` varchar(50) DEFAULT NULL,
  `adresse` varchar(60) DEFAULT NULL,
  `motDePasse` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CHEF_CABINET`
--

INSERT INTO `CHEF_CABINET` (`id_chef_cabinet`, `nom`, `prenom`, `email`, `tel`, `adresse`, `motDePasse`) VALUES
(1, 'Diallo', 'Ali', 'alidaillo@gmail.com', '70230456', 'ACI 200', 'ali123'),
(2, 'Diarra', 'Fanene', 'diarrafanene@gmail.com', '70000000', 'ACI 200', 'fanene123');

-- --------------------------------------------------------

--
-- Table structure for table `CONSULTATION`
--

CREATE TABLE `CONSULTATION` (
  `id_consultation` int(11) NOT NULL,
  `date_consultation` date DEFAULT NULL,
  `diagnostic` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `id_patient` int(11) DEFAULT NULL,
  `id_dentiste` int(11) DEFAULT NULL,
  `id_rdv` int(11) DEFAULT NULL,
  `id_dossierMedical` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `CONSULTATION`
--

INSERT INTO `CONSULTATION` (`id_consultation`, `date_consultation`, `diagnostic`, `description`, `id_patient`, `id_dentiste`, `id_rdv`, `id_dossierMedical`) VALUES
(1, '2026-04-09', 'Carie dentaire', 'Présence d’une carie sur la molaire gauche, nettoyage et traitement recommandés', 1, 1, 1, NULL),
(2, '2026-04-10', 'Carie', 'Carie détectée sur la molaire, traitement recommandé', 1, 1, 1, 1),
(3, '2026-04-11', 'Gingivite', 'Inflammation des gencives, nettoyage conseillé', 2, 2, 2, 2),
(4, '2026-04-12', 'Dents saines', 'Contrôle général sans anomalie', 3, 1, 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `DENTISTE`
--

CREATE TABLE `DENTISTE` (
  `id_Dentiste` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telephone` varchar(50) NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `motDePasse` varchar(50) NOT NULL,
  `specialite` varchar(50) NOT NULL,
  `id_cabinet` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `DENTISTE`
--

INSERT INTO `DENTISTE` (`id_Dentiste`, `nom`, `prenom`, `email`, `telephone`, `adresse`, `motDePasse`, `specialité`, `id_cabinet`) VALUES
(1, 'Konaté', 'Idrissa', 'idrissakonate@gmail.com', '70245678', 'BADALABOUGOU', 'idrissa123', 'Generaliste', 1),
(2, 'Coulibaly', 'Mamadou', 'mamadou.coulibaly@gmail.com', '76001122', 'Bamako', 'dent123', 'Orthodontie', 1),
(3, 'Konate', 'Awa', 'awa.konate@gmail.com', '77002233', 'Bamako', 'pass456', 'Chirurgie dentaire', 1),
(4, 'Traore', 'Ibrahim', 'ibrahim.traore@gmail.com', '78003344', 'Kati', 'mdp789', 'Dentisterie générale', 1),
(5, 'Diallo', 'Fatou', 'fatou.diallo@gmail.com', '79004455', 'Bamako', 'secure321', 'Endodontie', 1);

-- --------------------------------------------------------

--
-- Table structure for table `DOSSIER_MEDICAL`
--

CREATE TABLE `DOSSIER_MEDICAL` (
  `id_dossierMedical` int(11) NOT NULL,
  `antecedents` varchar(100) NOT NULL,
  `allergies` varchar(100) NOT NULL,
  `historique` varchar(50) NOT NULL,
  `id_patient` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `PATIENT`
--

CREATE TABLE `PATIENT` (
  `id_patient` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `date_naissance` date DEFAULT NULL,
  `telephone` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `motDePasse` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `PATIENT`
--

INSERT INTO `PATIENT` (`id_patient`, `nom`, `prenom`, `date_naissance`, `telephone`, `email`, `adresse`, `motDePasse`) VALUES
(1, 'Diallo', 'Ali', '2000-03-04', '70230456', 'alidaillo@gmail.com', 'ACI 200', 'ali123'),
(2, 'Touré', 'Ali', '2026-04-08', '70230466', 'touredaillo@gmail.com', 'ACI 200', 'ali123'),
(3, 'Keita', 'Abdoulaye', '1995-06-15', '65001122', 'abdoulaye.keita@gmail.com', 'Bamako', NULL),
(4, 'Diallo', 'Aissata', '2000-03-22', '66002233', 'aissata.diallo@gmail.com', 'Kati', NULL),
(5, 'Traore', 'Moussa', '1988-11-10', '67003344', 'moussa.traore@gmail.com', 'Sikasso', NULL),
(6, 'Coulibaly', 'Fatoumata', '1992-08-05', '68004455', 'fatoumata.coulibaly@gmail.com', 'Segou', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `RENDEZ_VOUS`
--

CREATE TABLE `RENDEZ_VOUS` (
  `id_rdv` int(11) NOT NULL,
  `date_rdv` datetime DEFAULT NULL,
  `motif` varchar(50) DEFAULT NULL,
  `statut` int(11) DEFAULT NULL,
  `id_patient` int(11) DEFAULT NULL,
  `id_Secretaire` int(11) DEFAULT NULL,
  `id_Dentiste` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `RENDEZ_VOUS`
--

INSERT INTO `RENDEZ_VOUS` (`id_rdv`, `date_rdv`, `motif`, `statut`, `id_patient`, `id_Secretaire`, `id_Dentiste`) VALUES
(1, '2026-04-09 17:12:33', 'Mal à la Dent', 1, 1, NULL, 1),
(2, '2026-04-23 17:38:25', 'Mal à la Dent', 1, 2, NULL, 1),
(3, '2026-04-10 00:00:00', 'Consultation générale', 1, 1, NULL, 1),
(4, '2026-04-11 00:00:00', 'Douleur dentaire', 1, 2, NULL, 2),
(5, '2026-04-12 00:00:00', 'Détartrage', 1, 3, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `SECRETAIRE`
--

CREATE TABLE `SECRETAIRE` (
  `id_Secretaire` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `tel` varchar(50) NOT NULL,
  `adresse` varchar(50) NOT NULL,
  `motDePasse` varchar(50) NOT NULL,
  `id_cabinet` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `SECRETAIRE`
--

INSERT INTO `SECRETAIRE` (`id_Secretaire`, `nom`, `prenom`, `email`, `tel`, `adresse`, `motDePasse`, `id_cabinet`) VALUES
(1, 'Traore', 'Moussa', 'moussa.traore@gmail.com', '70112233', 'Kati', 'secret456', 1),
(2, 'Keita', 'Fatoumata', 'fatoumata.keita@gmail.com', '66223344', 'Sikasso', 'mdp789', 2);

-- --------------------------------------------------------

--
-- Table structure for table `TRAITEMENT`
--

CREATE TABLE `TRAITEMENT` (
  `id_traitement` int(11) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `date_debut` date DEFAULT NULL,
  `date_fin` date DEFAULT NULL,
  `type_traitement` varchar(50) NOT NULL,
  `id_consultation` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `TRAITEMENT`
--

INSERT INTO `TRAITEMENT` (`id_traitement`, `nom`, `description`, `date_debut`, `date_fin`, `type_traitement`, `id_consultation`) VALUES
(1, 'Traitement carie', 'Nettoyage de la carie et pose d’un composite', '2026-04-09', '2026-04-11', 'Curatif', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AVIS`
--
ALTER TABLE `AVIS`
  ADD PRIMARY KEY (`id_avis`),
  ADD KEY `id_cabinet` (`id_cabinet`),
  ADD KEY `fk_id_patient` (`id_patient`);

--
-- Indexes for table `CABINET`
--
ALTER TABLE `CABINET`
  ADD PRIMARY KEY (`id_cabinet`),
  ADD UNIQUE KEY `tel` (`tel`),
  ADD KEY `id_chef_cabinet` (`id_chef_cabinet`);

--
-- Indexes for table `CHEF_CABINET`
--
ALTER TABLE `CHEF_CABINET`
  ADD PRIMARY KEY (`id_chef_cabinet`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `tel` (`tel`);

--
-- Indexes for table `CONSULTATION`
--
ALTER TABLE `CONSULTATION`
  ADD PRIMARY KEY (`id_consultation`),
  ADD KEY `id_patient` (`id_patient`),
  ADD KEY `id_dentiste` (`id_dentiste`),
  ADD KEY `id_rdv` (`id_rdv`),
  ADD KEY `id_dossierMedical` (`id_dossierMedical`);

--
-- Indexes for table `DENTISTE`
--
ALTER TABLE `DENTISTE`
  ADD PRIMARY KEY (`id_Dentiste`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `telephone` (`telephone`),
  ADD KEY `id_cabinet` (`id_cabinet`);

--
-- Indexes for table `DOSSIER_MEDICAL`
--
ALTER TABLE `DOSSIER_MEDICAL`
  ADD PRIMARY KEY (`id_dossierMedical`),
  ADD KEY `id_patient` (`id_patient`);

--
-- Indexes for table `PATIENT`
--
ALTER TABLE `PATIENT`
  ADD PRIMARY KEY (`id_patient`),
  ADD UNIQUE KEY `telephone` (`telephone`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `RENDEZ_VOUS`
--
ALTER TABLE `RENDEZ_VOUS`
  ADD PRIMARY KEY (`id_rdv`),
  ADD KEY `id_patient` (`id_patient`),
  ADD KEY `id_Secretaire` (`id_Secretaire`),
  ADD KEY `id_Dentiste` (`id_Dentiste`);

--
-- Indexes for table `SECRETAIRE`
--
ALTER TABLE `SECRETAIRE`
  ADD PRIMARY KEY (`id_Secretaire`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `tel` (`tel`),
  ADD KEY `id_cabinet` (`id_cabinet`);

--
-- Indexes for table `TRAITEMENT`
--
ALTER TABLE `TRAITEMENT`
  ADD PRIMARY KEY (`id_traitement`),
  ADD KEY `id_consultation` (`id_consultation`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AVIS`
--
ALTER TABLE `AVIS`
  MODIFY `id_avis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `CABINET`
--
ALTER TABLE `CABINET`
  MODIFY `id_cabinet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `CHEF_CABINET`
--
ALTER TABLE `CHEF_CABINET`
  MODIFY `id_chef_cabinet` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `CONSULTATION`
--
ALTER TABLE `CONSULTATION`
  MODIFY `id_consultation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `DENTISTE`
--
ALTER TABLE `DENTISTE`
  MODIFY `id_Dentiste` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `DOSSIER_MEDICAL`
--
ALTER TABLE `DOSSIER_MEDICAL`
  MODIFY `id_dossierMedical` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PATIENT`
--
ALTER TABLE `PATIENT`
  MODIFY `id_patient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `RENDEZ_VOUS`
--
ALTER TABLE `RENDEZ_VOUS`
  MODIFY `id_rdv` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `SECRETAIRE`
--
ALTER TABLE `SECRETAIRE`
  MODIFY `id_Secretaire` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `TRAITEMENT`
--
ALTER TABLE `TRAITEMENT`
  MODIFY `id_traitement` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
