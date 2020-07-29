-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  mer. 29 juil. 2020 à 13:12
-- Version du serveur :  5.7.24
-- Version de PHP :  7.2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `bdd`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`stewen`@`localhost` PROCEDURE `getOwnerAddress` (IN `ownerId` INT)  NO SQL
SELECT * from ownersaddress where idOwner = ownerId$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

CREATE TABLE `address` (
  `id` int(11) NOT NULL,
  `streetNumber` int(5) NOT NULL,
  `streetType` varchar(5) NOT NULL,
  `address` text NOT NULL,
  `cp` int(10) NOT NULL,
  `city` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `benefit`
--

CREATE TABLE `benefit` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `galleries`
--

CREATE TABLE `galleries` (
  `id` int(11) NOT NULL,
  `idHousing` int(11) NOT NULL,
  `url` text NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `historique`
--

CREATE TABLE `historique` (
  `housingsId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `housings`
--

CREATE TABLE `housings` (
  `id` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `addressId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `housings`
--

INSERT INTO `housings` (`id`, `typeId`, `addressId`) VALUES
(1, 1, 1),
(2, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `housingscomments`
--

CREATE TABLE `housingscomments` (
  `idHousing` int(11) NOT NULL,
  `comment` text NOT NULL,
  `creationDate` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `housingsdetails`
--

CREATE TABLE `housingsdetails` (
  `idHousing` int(11) NOT NULL,
  `numberPieces` int(11) NOT NULL,
  `numberRoom` int(11) NOT NULL,
  `area` int(11) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `internalReference` varchar(255) NOT NULL,
  `energeticPerformance` varchar(255) NOT NULL,
  `emissionIndex` varchar(255) NOT NULL,
  `typePrestationId` int(11) NOT NULL,
  `statusId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `housingsdetails`
--

INSERT INTO `housingsdetails` (`idHousing`, `numberPieces`, `numberRoom`, `area`, `rate`, `description`, `internalReference`, `energeticPerformance`, `emissionIndex`, `typePrestationId`, `statusId`) VALUES
(1, 6, 2, 90, '400.25', 'une maison', 'blabla', 'blabla', 'blabla', 1, 2),
(2, 6, 2, 90, '150.25', 'une maison', 'blabla', 'blabla', 'blabla', 1, 2);

--
-- Déclencheurs `housingsdetails`
--
DELIMITER $$
CREATE TRIGGER `rate` AFTER UPDATE ON `housingsdetails` FOR EACH ROW IF(NEW.rate != OLD.rate) THEN
            INSERT INTO `historique`(`housingsId`, `type`, `value`) VALUES (NEW.idHousing,"rate",NEW.rate);
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `status_check` AFTER UPDATE ON `housingsdetails` FOR EACH ROW IF(NEW.statusId != OLD.statusId) THEN
            INSERT INTO `historique`(`housingsId`, `type`, `value`) VALUES (NEW.idHousing,"status",NEW.statusId);
END IF
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `log`
--

CREATE TABLE `log` (
  `id` int(11) NOT NULL,
  `user` varchar(255) NOT NULL,
  `action` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `log`
--

INSERT INTO `log` (`id`, `user`, `action`, `date`) VALUES
(1, 'Stewen', 'inserted', '2020-07-29 13:40:05');

-- --------------------------------------------------------

--
-- Structure de la table `owners`
--

CREATE TABLE `owners` (
  `id` int(11) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `owners`
--

INSERT INTO `owners` (`id`, `lastName`, `firstName`) VALUES
(4, 'Xavier', 'Niel');

-- --------------------------------------------------------

--
-- Structure de la table `ownersaddress`
--

CREATE TABLE `ownersaddress` (
  `idOwner` int(11) NOT NULL,
  `streetNumber` int(3) NOT NULL,
  `streetType` varchar(5) NOT NULL,
  `address` text NOT NULL,
  `cp` int(5) NOT NULL,
  `city` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `ownersaddress`
--

INSERT INTO `ownersaddress` (`idOwner`, `streetNumber`, `streetType`, `address`, `cp`, `city`, `country`) VALUES
(4, 3, 'rue', 'sarah vaughan', 35770, 'vern sur seiche', 'france');

-- --------------------------------------------------------

--
-- Structure de la table `ownerscomments`
--

CREATE TABLE `ownerscomments` (
  `idOwner` int(11) NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ownerscomplements`
--

CREATE TABLE `ownerscomplements` (
  `idOwner` int(11) NOT NULL,
  `phone` int(10) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ownershousings`
--

CREATE TABLE `ownershousings` (
  `idOwner` int(11) NOT NULL,
  `idHousing` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `ownershousings`
--

INSERT INTO `ownershousings` (`idOwner`, `idHousing`) VALUES
(4, 1),
(4, 2);

-- --------------------------------------------------------

--
-- Structure de la table `status`
--

CREATE TABLE `status` (
  `id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `type`
--

CREATE TABLE `type` (
  `id` int(11) NOT NULL,
  `content` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(3, 'Stewen', 'toto');

--
-- Déclencheurs `users`
--
DELIMITER $$
CREATE TRIGGER `new user` AFTER INSERT ON `users` FOR EACH ROW INSERT INTO `log`(`user`, `action`, `date`) VALUES (NEW.username, 'inserted', NOW())
$$
DELIMITER ;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `benefit`
--
ALTER TABLE `benefit`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idHousing` (`idHousing`);

--
-- Index pour la table `historique`
--
ALTER TABLE `historique`
  ADD PRIMARY KEY (`housingsId`);

--
-- Index pour la table `housings`
--
ALTER TABLE `housings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addressId` (`addressId`),
  ADD KEY `typeId` (`typeId`);

--
-- Index pour la table `housingscomments`
--
ALTER TABLE `housingscomments`
  ADD PRIMARY KEY (`idHousing`);

--
-- Index pour la table `housingsdetails`
--
ALTER TABLE `housingsdetails`
  ADD PRIMARY KEY (`idHousing`),
  ADD KEY `housingsdetails_ibfk_2` (`statusId`),
  ADD KEY `typePrestationId` (`typePrestationId`);

--
-- Index pour la table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owners`
--
ALTER TABLE `owners`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ownersaddress`
--
ALTER TABLE `ownersaddress`
  ADD PRIMARY KEY (`idOwner`);

--
-- Index pour la table `ownerscomments`
--
ALTER TABLE `ownerscomments`
  ADD PRIMARY KEY (`idOwner`);

--
-- Index pour la table `ownerscomplements`
--
ALTER TABLE `ownerscomplements`
  ADD PRIMARY KEY (`idOwner`);

--
-- Index pour la table `ownershousings`
--
ALTER TABLE `ownershousings`
  ADD KEY `idHousing` (`idHousing`),
  ADD KEY `idOwner` (`idOwner`);

--
-- Index pour la table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `benefit`
--
ALTER TABLE `benefit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `log`
--
ALTER TABLE `log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `owners`
--
ALTER TABLE `owners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `status`
--
ALTER TABLE `status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_ibfk_1` FOREIGN KEY (`id`) REFERENCES `housings` (`addressId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `benefit`
--
ALTER TABLE `benefit`
  ADD CONSTRAINT `benefit_ibfk_1` FOREIGN KEY (`id`) REFERENCES `housingsdetails` (`typePrestationId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `galleries`
--
ALTER TABLE `galleries`
  ADD CONSTRAINT `galleries_ibfk_1` FOREIGN KEY (`idHousing`) REFERENCES `housingsdetails` (`idHousing`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `housings`
--
ALTER TABLE `housings`
  ADD CONSTRAINT `housings_ibfk_1` FOREIGN KEY (`id`) REFERENCES `ownershousings` (`idHousing`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `housingscomments`
--
ALTER TABLE `housingscomments`
  ADD CONSTRAINT `housingscomments_ibfk_1` FOREIGN KEY (`idHousing`) REFERENCES `housingsdetails` (`idHousing`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `housingsdetails`
--
ALTER TABLE `housingsdetails`
  ADD CONSTRAINT `housingsdetails_ibfk_1` FOREIGN KEY (`idHousing`) REFERENCES `housings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ownersaddress`
--
ALTER TABLE `ownersaddress`
  ADD CONSTRAINT `ownersaddress_ibfk_1` FOREIGN KEY (`idOwner`) REFERENCES `owners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ownerscomments`
--
ALTER TABLE `ownerscomments`
  ADD CONSTRAINT `ownerscomments_ibfk_1` FOREIGN KEY (`idOwner`) REFERENCES `owners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ownerscomplements`
--
ALTER TABLE `ownerscomplements`
  ADD CONSTRAINT `ownerscomplements_ibfk_1` FOREIGN KEY (`idOwner`) REFERENCES `owners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ownershousings`
--
ALTER TABLE `ownershousings`
  ADD CONSTRAINT `ownershousings_ibfk_1` FOREIGN KEY (`idOwner`) REFERENCES `owners` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `status_ibfk_1` FOREIGN KEY (`id`) REFERENCES `housingsdetails` (`statusId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `type`
--
ALTER TABLE `type`
  ADD CONSTRAINT `type_ibfk_1` FOREIGN KEY (`id`) REFERENCES `housings` (`typeId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
