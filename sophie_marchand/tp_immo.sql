-- phpMyAdmin SQL Dump
-- version 4.9.2deb1
-- https://www.phpmyadmin.net/
--
-- Hôte : mysql1:3306
-- Généré le :  mer. 29 juil. 2020 à 14:08
-- Version du serveur :  5.7.29
-- Version de PHP :  7.3.12-144

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tp_immo
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS tp_immo DEFAULT CHARACTER SET utf8 ;
USE tp_immo;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `tp_immo`
--

-- --------------------------------------------------------

--
-- Structure de la table `account_user`
--

CREATE TABLE `account_user` (
  `id_user` int(11) NOT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `pseudo` varchar(50) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `address`
--

CREATE TABLE `address` (
  `id_address` int(11) NOT NULL,
  `number` int(10) DEFAULT NULL,
  `street` varchar(500) DEFAULT NULL,
  `zip_code` varchar(10) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `FK_contact_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

CREATE TABLE `contact` (
  `id_contact` int(11) NOT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `FK_owner_id` int(11) DEFAULT NULL,
  `FK_address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `housing`
--

CREATE TABLE `housing` (
  `id_housing` int(11) NOT NULL,
  `type_housing` varchar(100) DEFAULT NULL,
  `nb_rooms` int(100) DEFAULT NULL,
  `nb_bedrooms` int(100) DEFAULT NULL,
  `surface` varchar(30) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rate` float DEFAULT NULL,
  `reference` varchar(50) DEFAULT NULL,
  `perf_energy` int(10) DEFAULT NULL,
  `index_ges` int(10) DEFAULT NULL,
  `service` varchar(50) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `FK_owner_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `owner`
--

CREATE TABLE `owner` (
  `id_owner` int(11) NOT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `gender` varchar(5) DEFAULT NULL,
  `FK_housing_id` int(11) DEFAULT NULL,
  `FK_contact_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `picture`
--

CREATE TABLE `picture` (
  `id_picture` int(11) NOT NULL,
  `name` varchar(500) DEFAULT NULL,
  `path` varchar(1000) DEFAULT NULL,
  `com_picture` varchar(1000) DEFAULT NULL,
  `FK_housing_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `user_comment`
--

CREATE TABLE `user_comment` (
  `id_comment` int(11) NOT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `FK_user_id` int(11) DEFAULT NULL,
  `FK_owner_id` int(11) DEFAULT NULL,
  `FK_housing_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `account_user`
--
ALTER TABLE `account_user`
  ADD PRIMARY KEY (`id_user`);

--
-- Index pour la table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id_address`),
  ADD KEY `FK_address_contact_id` (`FK_contact_id`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id_contact`),
  ADD KEY `FK_contact_owner_id` (`FK_owner_id`),
  ADD KEY `FK_contact_address_id` (`FK_address_id`);

--
-- Index pour la table `housing`
--
ALTER TABLE `housing`
  ADD PRIMARY KEY (`id_housing`),
  ADD KEY `FK_housing_owner_id_owner` (`FK_owner_id`);

--
-- Index pour la table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`id_owner`),
  ADD KEY `FK_owner_contact_id` (`FK_contact_id`),
  ADD KEY `FK_owner_housing_id` (`FK_housing_id`);

--
-- Index pour la table `picture`
--
ALTER TABLE `picture`
  ADD PRIMARY KEY (`id_picture`),
  ADD KEY `FK_picture_housing_id` (`FK_housing_id`);

--
-- Index pour la table `user_comment`
--
ALTER TABLE `user_comment`
  ADD PRIMARY KEY (`id_comment`),
  ADD KEY `FK_comment_user_id` (`FK_user_id`),
  ADD KEY `FK_comment_owner_id` (`FK_owner_id`),
  ADD KEY `FK_comment_housing_id` (`FK_housing_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `account_user`
--
ALTER TABLE `account_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `address`
--
ALTER TABLE `address`
  MODIFY `id_address` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
  MODIFY `id_contact` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `housing`
--
ALTER TABLE `housing`
  MODIFY `id_housing` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `owner`
--
ALTER TABLE `owner`
  MODIFY `id_owner` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `picture`
--
ALTER TABLE `picture`
  MODIFY `id_picture` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user_comment`
--
ALTER TABLE `user_comment`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `FK_address_contact_id` FOREIGN KEY (`FK_contact_id`) REFERENCES `contact` (`id_contact`);

--
-- Contraintes pour la table `contact`
--
ALTER TABLE `contact`
  ADD CONSTRAINT `FK_contact_address_id` FOREIGN KEY (`FK_address_id`) REFERENCES `address` (`id_address`),
  ADD CONSTRAINT `FK_contact_owner_id` FOREIGN KEY (`FK_owner_id`) REFERENCES `owner` (`id_owner`);

--
-- Contraintes pour la table `housing`
--
ALTER TABLE `housing`
  ADD CONSTRAINT `FK_housing_owner_id_owner` FOREIGN KEY (`FK_owner_id`) REFERENCES `owner` (`id_owner`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `owner`
--
ALTER TABLE `owner`
  ADD CONSTRAINT `FK_owner_contact_id` FOREIGN KEY (`FK_contact_id`) REFERENCES `contact` (`id_contact`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_owner_housing_id` FOREIGN KEY (`FK_housing_id`) REFERENCES `housing` (`id_housing`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `picture`
--
ALTER TABLE `picture`
  ADD CONSTRAINT `FK_picture_housing_id` FOREIGN KEY (`FK_housing_id`) REFERENCES `housing` (`id_housing`);

--
-- Contraintes pour la table `user_comment`
--
ALTER TABLE `user_comment`
  ADD CONSTRAINT `FK_comment_housing_id` FOREIGN KEY (`FK_housing_id`) REFERENCES `housing` (`id_housing`),
  ADD CONSTRAINT `FK_comment_owner_id` FOREIGN KEY (`FK_owner_id`) REFERENCES `owner` (`id_owner`),
  ADD CONSTRAINT `FK_comment_user_id` FOREIGN KEY (`FK_user_id`) REFERENCES `account_user` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
