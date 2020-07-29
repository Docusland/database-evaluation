-- --------------------------------------------------------
-- Hôte :                        localhost
-- Version du serveur:           5.7.24 - MySQL Community Server (GPL)
-- SE du serveur:                Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Listage de la structure de la table agence. commentairelogement
DROP TABLE IF EXISTS `commentairelogement`;
CREATE TABLE IF NOT EXISTS `commentairelogement` (
  `idcommentairelogement` int(11) NOT NULL,
  `commentaire` varchar(45) DEFAULT NULL,
  `utilisateur_idutilisateur` int(11) NOT NULL,
  `logement_id` int(11) NOT NULL,
  PRIMARY KEY (`idcommentairelogement`,`utilisateur_idutilisateur`,`logement_id`),
  KEY `fk_commentairelogement_utilisateur1_idx` (`utilisateur_idutilisateur`),
  KEY `fk_commentairelogement_logement1_idx` (`logement_id`),
  CONSTRAINT `fk_commentairelogement_logement1` FOREIGN KEY (`logement_id`) REFERENCES `logement` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_commentairelogement_utilisateur1` FOREIGN KEY (`utilisateur_idutilisateur`) REFERENCES `utilisateur` (`idutilisateur`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. genre
DROP TABLE IF EXISTS `genre`;
CREATE TABLE IF NOT EXISTS `genre` (
  `idgenre` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idgenre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. historiquetarif
DROP TABLE IF EXISTS `historiquetarif`;
CREATE TABLE IF NOT EXISTS `historiquetarif` (
  `idhistoriquetarif` int(11) NOT NULL,
  `tarif` int(11) NOT NULL,
  `date_changement_tarif` datetime NOT NULL,
  `logement_id` int(11) NOT NULL,
  PRIMARY KEY (`idhistoriquetarif`,`logement_id`),
  KEY `fk_historiquetarif_logement1_idx` (`logement_id`),
  CONSTRAINT `fk_historiquetarif_logement1` FOREIGN KEY (`logement_id`) REFERENCES `logement` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. logement
DROP TABLE IF EXISTS `logement`;
CREATE TABLE IF NOT EXISTS `logement` (
  `id` int(11) NOT NULL,
  `adresse` varchar(150) NOT NULL,
  `nbPiece` int(11) NOT NULL,
  `nbChambre` int(11) NOT NULL,
  `surface` int(11) NOT NULL,
  `tarif` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `ref` varchar(45) NOT NULL,
  `per_energetique` int(11) NOT NULL,
  `prestation_idprestation` int(11) NOT NULL,
  `photo_idphoto` int(11) NOT NULL,
  `typelogement_idtypelogement` int(11) NOT NULL,
  `proprietaire_idproprietaire` int(11) NOT NULL,
  PRIMARY KEY (`id`,`prestation_idprestation`,`photo_idphoto`,`typelogement_idtypelogement`,`proprietaire_idproprietaire`),
  KEY `fk_logement_photo1_idx` (`photo_idphoto`),
  KEY `fk_logement_typelogement1_idx` (`typelogement_idtypelogement`),
  KEY `fk_logement_proprietaire1_idx` (`proprietaire_idproprietaire`),
  CONSTRAINT `fk_logement_photo1` FOREIGN KEY (`photo_idphoto`) REFERENCES `photo` (`idphoto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_logement_proprietaire1` FOREIGN KEY (`proprietaire_idproprietaire`) REFERENCES `proprietaire` (`idproprietaire`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_logement_typelogement1` FOREIGN KEY (`typelogement_idtypelogement`) REFERENCES `typelogement` (`idtypelogement`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. photo
DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `idphoto` int(11) NOT NULL,
  `chemin` varchar(150) NOT NULL,
  `commentaire` varchar(45) NOT NULL,
  `datesuppression` datetime DEFAULT NULL,
  PRIMARY KEY (`idphoto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. prestation
DROP TABLE IF EXISTS `prestation`;
CREATE TABLE IF NOT EXISTS `prestation` (
  `idprestation` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idprestation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. proprietaire
DROP TABLE IF EXISTS `proprietaire`;
CREATE TABLE IF NOT EXISTS `proprietaire` (
  `idproprietaire` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  `premon` varchar(45) NOT NULL,
  `genre_id` int(11) NOT NULL,
  `tel` varchar(20) NOT NULL DEFAULT 'Champs a remplir',
  `email` varchar(45) NOT NULL DEFAULT 'Champs a remplir',
  `adresse` varchar(45) NOT NULL DEFAULT 'Champs a remplir',
  `genre_idgenre` int(11) NOT NULL,
  PRIMARY KEY (`idproprietaire`,`genre_idgenre`),
  KEY `fk_proprietaire_genre1_idx` (`genre_idgenre`),
  CONSTRAINT `fk_proprietaire_genre1` FOREIGN KEY (`genre_idgenre`) REFERENCES `genre` (`idgenre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. temporalsavephoto
DROP TABLE IF EXISTS `temporalsavephoto`;
CREATE TABLE IF NOT EXISTS `temporalsavephoto` (
  `idtemporalsavephoto` int(11) NOT NULL,
  `chemin` varchar(150) NOT NULL,
  `suppressiondate` datetime NOT NULL,
  `photo_idphoto` int(11) NOT NULL,
  PRIMARY KEY (`idtemporalsavephoto`,`photo_idphoto`),
  KEY `fk_temporalsavephoto_photo1_idx` (`photo_idphoto`),
  CONSTRAINT `fk_temporalsavephoto_photo1` FOREIGN KEY (`photo_idphoto`) REFERENCES `photo` (`idphoto`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. typelogement
DROP TABLE IF EXISTS `typelogement`;
CREATE TABLE IF NOT EXISTS `typelogement` (
  `idtypelogement` int(11) NOT NULL,
  `nom` varchar(45) NOT NULL,
  PRIMARY KEY (`idtypelogement`),
  UNIQUE KEY `type_nom_UNIQUE` (`nom`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

-- Listage de la structure de la table agence. utilisateur
DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `idutilisateur` int(11) NOT NULL,
  `login` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  PRIMARY KEY (`idutilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Les données exportées n'étaient pas sélectionnées.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
