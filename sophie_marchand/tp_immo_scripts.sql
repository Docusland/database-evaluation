Question 2.1
-- Lorsqu'un utilisateur modifie les photos associées à une maison, 
-- les photos anciennement liées doivent être retirées du serveur. 
-- Proposez une solution.

=> PROPOSITION : 
-- J'ai pensé qu'un script pourrait régulièrement "nettoyer" les données du serveur où sont stockées les photos solitaires.
-- Mais on peut peut-être être plus réactif avec un trigger dans la BDD qui déclenche ce script chaque fois qu'une photo est "DELETE" en BDD.




Question 2.2
-- La base de données actuellement existante n'a pas forcément
-- l'intégrité des données attendues au sein de la nouvelle application.
-- Les fiches propriétaires ne sont pas toutes complètes.
-- Lors de la création ou mise à jour d'un propriétaire,
-- il doit être obligatoire d'avoir le téléphone et/ou le mail de défini.
-- Quelle solution proposez-vous?

=> PROPOSITION : 
-- Il est possible de définir des contraintes d'intégrité, (CONSTRAINT) 
-- un peu comme les Foreign Key ou le fait d'avoir un attribut NOT NULL ou UNIQUE selon les cas. 
-- on peut passer des conditions sur des champs entre eux, ou des colonnes.
-- mais de base le champ contact doit être NOT NULL (il pourra contenir 1 à 3 informations : mail, tel ou adresse).



Question 2.3
-- Le tarif d'un logement a tendance à varier en fonction de l'offre et de la demande ainsi que de l'ancienneté de l'annonce.
-- Il doit être possible d'avoir un historique des différentes tarifications d'un logement. 
-- Le changement de statut doit également être historisé au sein de l'application. 
-- Proposez une solution.

=> PROPOSITION : 
-- Réaliser un trigger qui stocke au sein d'une nouvelle table les anciens tarifs (TABLE rate_oldies)
-- et les mise à jour du statut des logements (TABLE status_oldies)
-- lorsqu'il y a un update et que ces données ont été modifiées.

-- Je trouverais sans doute mieux d'enregistrer des plages avec date de début et date de fin pour chaque donnée.
-- J'ai juste essayé avec une date de mise à jour dans ce cas, et l'ID du logement pour s'y retrouver.
 

CREATE TABLE IF NOT EXISTS rate_oldies (
  id_rate INT NOT NULL AUTO_INCREMENT,
  old_rate VARCHAR(255),
  housing_id INT,
  updated_at Date;
  PRIMARY KEY (`id_rate`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS status_updates (
  id_update INT NOT NULL AUTO_INCREMENT,
  new_rate VARCHAR(255),
  housing_id INT,
  updated_at Date;
  PRIMARY KEY (`id_update`))
ENGINE = InnoDB;
 
 DELIMITER |
 CREATE TRIGGER status_oldies
 BEFORE 
 UPDATE ON housing
 FOR EACH ROW

 BEGIN
    if NEW.rate != OLD.rate THEN
        INSERT INTO rate_oldies (old_rate)
        VALUES (OLD.rate);
    END IF;
     if NEW.status != OLD.status THEN
        INSERT INTO status_oldies (status)
        VALUES (OLD.status);
    END IF;
 END |
  DELIMITER ;

  
  UPDATE housing
SET housing.status = 'nouvelle valeur'
WHERE id_housing = x;
-- (x selon l'ID du logement concerné)




Question 3.1/

-- Une requête qui permet de retourner l'ensemble des logements situés à Calais 
-- appartenant au propriétaire 'Xavier Niel'

-- ... j'ai oublié de lier une adresse au logement,
-- je fais comme si la table logement disposait d'une Foreign Key FK_adresse_id. 

=> PROPOSITION : 

SELECT * from housing 
INNER JOIN address ON housing.FK_adress_id = address.id_address
INNER JOIN owner ON housing.FK_owner_id = owner.id_owner
WHERE address.city = "Calais" AND WHERE owner.lastName = "Niel" AND owner.firstname = "Xavier"





Question 3.2

-- Une requête qui retourne la valeur moyenne des biens immobiliers vendus 
-- ordonnés dans le temps avec une granularité journalière. 
-- (Certains jours aucune vente n'a lieu.
-- Il est attendu de ne pas avoir de ligne pour ces jours là)

=> PROPOSITION : 

SELECT AVG(rate) FROM housing WHERE housing.status = "vendu" ORDER BY DATE...
-- Il me manque une date enregistrée lorsque le status "vendu" est affecté au logement
-- du coup je devrais créer une table de jointure vente où enregistrer chaque vente avec sa date,
-- et préciser dans la requête de ne pas retenir les données pour les jours où aucune vente n'est enregistrée.

Question 3.4
=> PROPOSITION :

-- Respect de la normalisation pour éviter les redondances (découpage assez fin des données),
-- bien gérer les contraintes (clefs primaires, foreign keys)
-- être cohérent et respecter les bonnes pratiques et les conventions de nommage établies.
-- Automatiser les actions de sauvegardes et de "nettoyage" des données.



