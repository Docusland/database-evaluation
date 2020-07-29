/************************************************
*************************************************
*************************************************
* 2.1
* Réalisation d'un TRIGGER BEFORE UPDATE
* Récupération de l'ancienne image avant sa modification pour l'insérer dans une table
* pour les photos à supprimer
*/
DELIMITER |
CREATE TRIGGER before_update_photo BEFORE UPDATE
ON photos FOR EACH ROW
BEGIN
    IF NEW.path != OLD.path
      THEN
        INSERT INTO photos_to_remove (path) VALUES(OLD.path);
    END IF;
END |
DELIMITER ;

/************************************************
* 2.2
* Réalisation d'un TRIGGER BEFORE UPDATE et BEFORE INSERT et d'une PROCEDURE
* Vérification des informations de contact d'un propriétaire
* (Ajout du DROP pour les tests)
*/
DELIMITER |
-- DROP TRIGGER before_insert_proprietaire|
CREATE TRIGGER before_insert_proprietaire BEFORE INSERT
ON proprietaire FOR EACH ROW
BEGIN
    CALL verifier_proprietaire_contact(NEW.tel, NEW.email);
END |
DELIMITER ;

DELIMITER |
-- DROP TRIGGER before_update_proprietaire|
CREATE TRIGGER before_update_proprietaire BEFORE UPDATE
ON proprietaire FOR EACH ROW
BEGIN
    CALL verifier_proprietaire_contact(NEW.tel, NEW.email);
END |
DELIMITER ;

DELIMITER |
-- DROP PROCEDURE verifier_proprietaire_contact|
CREATE PROCEDURE `verifier_proprietaire_contact`(IN `tel` VARCHAR(25), IN `email` VARCHAR(100))
BEGIN
    IF ((tel IS NULL OR tel = '') AND (email IS NULL OR email = ''))
    THEN
        SIGNAL SQLSTATE '90001'
        SET MESSAGE_TEXT = 'Le proprietaire ne possède pas de méthode de contact';
    END IF;
END |
DELIMITER ;

/************************************************
* 2.3
* Réalisation d'un TRIGGER BEFORE UPDATE et BEFORE INSERT et d'une PROCEDURE
* Vérification des informations de contact d'un propriétaire
* (Ajout du DROP pour les tests)
*/
DELIMITER |
-- DROP TRIGGER before_insert_logement|
CREATE TRIGGER before_insert_logement BEFORE INSERT
ON logement FOR EACH ROW
BEGIN
    CALL historisation_logement(NEW.id_logement, OLD.prix, NEW.prix, OLD.id_statut_logement, NEW.id_statut_logement);
END |
DELIMITER ;

DELIMITER |
-- DROP TRIGGER before_update_logement|
CREATE TRIGGER before_update_logement BEFORE UPDATE
ON logement FOR EACH ROW
BEGIN
    CALL historisation_logement(NEW.id_logement, OLD.prix, NEW.prix, OLD.id_statut_logement, NEW.id_statut_logement);
END |
DELIMITER ;

DELIMITER |
-- DROP PROCEDURE verifier_proprietaire_contact|
CREATE PROCEDURE `historisation_logement`(IN `id_logement` INT, IN `prix_ancien` DECIMAL(10,0), IN `prix` DECIMAL(10,0), IN `id_statut_logement_ancien` INT, IN `id_statut_logement` INT)
BEGIN
    IF prix != prix_ancien
    THEN
        INSERT INTO historique_logement_prix (id_logement, prix) VALUES(id_logement, prix);
    END IF;
    IF id_statut_logement != id_statut_logement_ancien
    THEN
        INSERT INTO historique_logement_statut (id_logement, id_statut_logement) VALUES(id_logement, id_statut_logement);
    END IF;
END |
DELIMITER ;

/************************************************
*************************************************
*************************************************
* 3.1
* Les logements de Xavier Niel à Calais
*/
SELECT logement.* FROM logement LEFT JOIN commune ON logement.id_commune = commune.id_commune
LEFT JOIN proprietaire ON logement.id_proprietaire = proprietaire.id_proprietaire
WHERE commune.nom = 'Calais' AND proprietaire.prenom = 'Xavier' AND  proprietaire.nom = 'Niel'

/************************************************
* 3.2
* La moyenne des ventes par jour
*/
SELECT DATE_FORMAT(historique_logement_statut.date, "%d/%m/%Y") as 'Date', AVG(logement.prix) as 'Moyenne Prix Vente' FROM statut_logement
LEFT JOIN historique_logement_statut ON historique_logement_statut.id_statut_logement = statut_logement.id_statut_logement
LEFT JOIN logement ON logement.id_statut_logement = statut_logement.id_statut_logement
WHERE statut_logement.statut = 'Vendu' GROUP BY historique_logement_statut.date;