CREATE DATABASE IF NOT EXISTS immo;

USE immo;
DROP TABLE IF EXISTS genres;

CREATE TABLE genres (
                id_genre INT AUTO_INCREMENT NOT NULL,
                libelle_genre VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_genre)
);

DROP TABLE IF EXISTS utilisateurs;
CREATE TABLE utilisateurs (
                id_utilisateur INT AUTO_INCREMENT NOT NULL,
                nom_utilisateur VARCHAR(100) NOT NULL,
                prenom_utilisateur VARCHAR(100) NOT NULL,
                mot_passe VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_utilisateur)
);

DROP TABLE IF EXISTS proprietaires;
CREATE TABLE proprietaires (
                id_proprietaires INT AUTO_INCREMENT NOT NULL,
                nom_proprietaire VARCHAR(100) NOT NULL,
                prenom_proprietaires VARCHAR(100) NOT NULL,
                contact_proprietaires VARCHAR(100) NOT NULL,
                id_genre INT NOT NULL,
                PRIMARY KEY (id_proprietaires)
);

DROP TABLE IF EXISTS villes;
CREATE TABLE villes (
                id_ville INT AUTO_INCREMENT NOT NULL,
                code_postal INT NOT NULL,
                nom_ville VARCHAR(200) NOT NULL,
                PRIMARY KEY (id_ville)
);

DROP TABLE IF EXISTS statut_logement;
CREATE TABLE statut_logement (
                id_statut_logement INT AUTO_INCREMENT NOT NULL,
                libelle_statut_logement VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_statut_logement)
);

DROP TABLE IF EXISTS type_prestation;
CREATE TABLE type_prestation (
                id_type_prestation INT AUTO_INCREMENT NOT NULL,
                libelle_type_prestation VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_type_prestation)
);

DROP TABLE IF EXISTS type_logement;
CREATE TABLE type_logement (
                id_type_logement INT AUTO_INCREMENT NOT NULL,
                libelle_type_logement VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_type_logement)
);

DROP TABLE IF EXISTS logements;
CREATE TABLE logements (
                reference VARCHAR(50) NOT NULL,
                nb_pieces INT NOT NULL,
                nb_chambres INT NOT NULL,
                surface DECIMAL(11) NOT NULL,
                tarif DECIMAL(11) NOT NULL,
                description TEXT,
                performance_energetique INT,
                indice_ges INT,
                id_type_logement INT NOT NULL,
                id_type_prestation INT NOT NULL,
                id_ville INT NOT NULL,
                id_statut_logement INT NOT NULL,
                id_proprietaires INT NOT NULL,
                PRIMARY KEY (reference)
);

DROP TABLE IF EXISTS commentaires;
CREATE TABLE commentaires (
                id_commentaire INT AUTO_INCREMENT NOT NULL,
                contenu TEXT NOT NULL,
                date_creation TIMESTAMP NOT NULL,
                reference VARCHAR(50) NOT NULL,
                id_proprietaires INT NOT NULL,
                id_utilisateur INT NOT NULL,
                PRIMARY KEY (id_commentaire)
);

DROP TABLE IF EXISTS photos;
CREATE TABLE photos (
                id_photo INT AUTO_INCREMENT NOT NULL,
                chemin VARCHAR(200) NOT NULL,
                reference VARCHAR(50) NOT NULL,
                id_commentaire INT NOT NULL,
                PRIMARY KEY (id_photo)
);


ALTER TABLE proprietaires ADD CONSTRAINT genres_proprietaires_fk
FOREIGN KEY (id_genre)
REFERENCES genres (id_genre);


ALTER TABLE commentaires ADD CONSTRAINT utilisateur_commentaires_fk
FOREIGN KEY (id_utilisateur)
REFERENCES utilisateurs (id_utilisateur);

ALTER TABLE commentaires ADD CONSTRAINT proprietaires_commentaires_fk
FOREIGN KEY (id_proprietaires)
REFERENCES proprietaires (id_proprietaires);

ALTER TABLE logements ADD CONSTRAINT proprietaires_logements_fk
FOREIGN KEY (id_proprietaires)
REFERENCES proprietaires (id_proprietaires);

ALTER TABLE logements ADD CONSTRAINT villes_logement_fk
FOREIGN KEY (id_ville)
REFERENCES villes (id_ville);

ALTER TABLE logements ADD CONSTRAINT statut_logement_logement_fk
FOREIGN KEY (id_statut_logement)
REFERENCES statut_logement (id_statut_logement);

ALTER TABLE logements ADD CONSTRAINT type_prestation_logement_fk
FOREIGN KEY (id_type_prestation)
REFERENCES type_prestation (id_type_prestation);

ALTER TABLE logements ADD CONSTRAINT type_logement_logement_fk
FOREIGN KEY (id_type_logement)
REFERENCES type_logement (id_type_logement);

ALTER TABLE photos ADD CONSTRAINT logement_photos_fk
FOREIGN KEY (reference)
REFERENCES logements (reference);

ALTER TABLE commentaires ADD CONSTRAINT logement_commentaires_fk
FOREIGN KEY (reference)
REFERENCES logements (reference);

ALTER TABLE photos ADD CONSTRAINT commentaires_photos_fk
FOREIGN KEY (id_commentaire)
REFERENCES commentaires (id_commentaire);