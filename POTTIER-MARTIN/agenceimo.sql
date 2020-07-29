-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 29, 2020 at 02:28 PM
-- Server version: 5.7.19
-- PHP Version: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agenceimo`
--

-- --------------------------------------------------------

--
-- Table structure for table `adresse`
--

CREATE TABLE `adresse` (
  `idAdresse` int(11) NOT NULL,
  `codePostal` int(11) NOT NULL,
  `ville` varchar(255) NOT NULL,
  `rue` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commentairelogement`
--

CREATE TABLE `commentairelogement` (
  `idCommentaireLogement` int(11) NOT NULL,
  `descriptif` tinytext NOT NULL,
  `dateAjout` date NOT NULL,
  `idLogement` int(11) NOT NULL,
  `idUtilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `commentaireproprietaire`
--

CREATE TABLE `commentaireproprietaire` (
  `idCommentaireProprietaire` int(11) NOT NULL,
  `descriptif` tinytext NOT NULL,
  `dateAjout` date NOT NULL,
  `idUtilisateur` int(11) NOT NULL,
  `idProprietaire` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `idGenre` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `logement`
--

CREATE TABLE `logement` (
  `idLogement` int(11) NOT NULL,
  `nbPieces` int(11) DEFAULT NULL,
  `nbChambres` int(11) DEFAULT NULL,
  `surface` int(11) DEFAULT NULL,
  `tarif` int(11) DEFAULT NULL,
  `description` tinytext,
  `reference` int(11) DEFAULT NULL,
  `performanceEnergetique` varchar(255) DEFAULT NULL,
  `ges` varchar(255) DEFAULT NULL,
  `idStatut` int(11) NOT NULL,
  `idPrestation` int(11) NOT NULL,
  `idTypeLogement` int(11) NOT NULL,
  `idProprietaire` int(11) NOT NULL,
  `idAdresse` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

CREATE TABLE `photo` (
  `idPhoto` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `commentaire` tinytext,
  `idLogement` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `prestation`
--

CREATE TABLE `prestation` (
  `idPrestation` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `proprietaire`
--

CREATE TABLE `proprietaire` (
  `idProprietaire` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `telephone` varchar(45) NOT NULL,
  `email` varchar(255) NOT NULL,
  `idGenre` int(11) NOT NULL,
  `idAdresse` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `statut`
--

CREATE TABLE `statut` (
  `idStatut` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `typelogement`
--

CREATE TABLE `typelogement` (
  `idTypeLogement` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `idGenre` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adresse`
--
ALTER TABLE `adresse`
  ADD PRIMARY KEY (`idAdresse`);

--
-- Indexes for table `commentairelogement`
--
ALTER TABLE `commentairelogement`
  ADD PRIMARY KEY (`idCommentaireLogement`,`idLogement`,`idUtilisateur`),
  ADD KEY `fk_commentaire_logement_agence_idx` (`idLogement`),
  ADD KEY `fk_commentaire_logement_utilisateur1_idx` (`idUtilisateur`);

--
-- Indexes for table `commentaireproprietaire`
--
ALTER TABLE `commentaireproprietaire`
  ADD PRIMARY KEY (`idCommentaireProprietaire`,`idUtilisateur`,`idProprietaire`),
  ADD KEY `fk_commentaire_proprietaire_utilisateur1_idx` (`idUtilisateur`),
  ADD KEY `fk_commentaire_proprietaire_proprietaire1_idx` (`idProprietaire`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`idGenre`);

--
-- Indexes for table `logement`
--
ALTER TABLE `logement`
  ADD PRIMARY KEY (`idLogement`,`idStatut`,`idPrestation`,`idTypeLogement`,`idProprietaire`,`idAdresse`),
  ADD KEY `fk_logement_agence_statut1_idx` (`idStatut`),
  ADD KEY `fk_logement_agence_type_prestation1_idx` (`idPrestation`),
  ADD KEY `fk_logement_agence_type_logement1_idx` (`idTypeLogement`),
  ADD KEY `fk_logement_agence_proprietaire1_idx` (`idProprietaire`),
  ADD KEY `fk_logement_agence_adresse1_idx` (`idAdresse`);

--
-- Indexes for table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`idPhoto`,`idLogement`),
  ADD KEY `fk_photos_logement_agence1_idx` (`idLogement`);

--
-- Indexes for table `prestation`
--
ALTER TABLE `prestation`
  ADD PRIMARY KEY (`idPrestation`);

--
-- Indexes for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD PRIMARY KEY (`idProprietaire`,`idGenre`,`idAdresse`),
  ADD KEY `fk_proprietaire_genre1_idx` (`idGenre`),
  ADD KEY `fk_proprietaire_adresse1_idx` (`idAdresse`);

--
-- Indexes for table `statut`
--
ALTER TABLE `statut`
  ADD PRIMARY KEY (`idStatut`);

--
-- Indexes for table `typelogement`
--
ALTER TABLE `typelogement`
  ADD PRIMARY KEY (`idTypeLogement`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`,`idGenre`),
  ADD KEY `fk_utilisateur_genre1_idx` (`idGenre`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commentairelogement`
--
ALTER TABLE `commentairelogement`
  ADD CONSTRAINT `fk_commentaire_logement_agence` FOREIGN KEY (`idLogement`) REFERENCES `logement` (`idLogement`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commentaire_logement_utilisateur1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `commentaireproprietaire`
--
ALTER TABLE `commentaireproprietaire`
  ADD CONSTRAINT `fk_commentaire_proprietaire_proprietaire1` FOREIGN KEY (`idProprietaire`) REFERENCES `proprietaire` (`idProprietaire`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commentaire_proprietaire_utilisateur1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `logement`
--
ALTER TABLE `logement`
  ADD CONSTRAINT `fk_logement_agence_adresse1` FOREIGN KEY (`idAdresse`) REFERENCES `adresse` (`idAdresse`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_logement_agence_proprietaire1` FOREIGN KEY (`idProprietaire`) REFERENCES `proprietaire` (`idProprietaire`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_logement_agence_statut1` FOREIGN KEY (`idStatut`) REFERENCES `statut` (`idStatut`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_logement_agence_type_logement1` FOREIGN KEY (`idTypeLogement`) REFERENCES `typelogement` (`idTypeLogement`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_logement_agence_type_prestation1` FOREIGN KEY (`idPrestation`) REFERENCES `prestation` (`idPrestation`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `photo`
--
ALTER TABLE `photo`
  ADD CONSTRAINT `fk_photos_logement_agence1` FOREIGN KEY (`idLogement`) REFERENCES `logement` (`idLogement`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `proprietaire`
--
ALTER TABLE `proprietaire`
  ADD CONSTRAINT `fk_proprietaire_adresse1` FOREIGN KEY (`idAdresse`) REFERENCES `adresse` (`idAdresse`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_proprietaire_genre1` FOREIGN KEY (`idGenre`) REFERENCES `genre` (`idGenre`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD CONSTRAINT `fk_utilisateur_genre1` FOREIGN KEY (`idGenre`) REFERENCES `genre` (`idGenre`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
