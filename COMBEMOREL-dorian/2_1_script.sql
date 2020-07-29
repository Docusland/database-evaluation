/**
    2.1 Lorsqu'un utilisateur modifie les photos associées à une maison, les photos anciennement liées doivent être retirées du serveur.

    je crée une nouvelle table qui me servira à savoir quelle photo son a supprmier

    j'utiliserai un trigger qui avant chaque update sur le chemain de la photo modifiée,
    enregistrerais le chemain de l'ancien photo dans la table crée au par avant.

*/
DELIMITER /

CREATE TABLE mydb.images_to_remove
(
    id INT NOT NULL PRIMARY KEY,
    path VARCHAR(255) NOT NULL
);
/

DELIMITER /
CREATE OR REPLACE TRIGGER triggerUpdatePhoto
    BEFORE UPDATE ON photo
    FOR EACH ROW

BEGIN
    IF (new.path != old.path) THEN
        INSERT INTO images_to_remove (id,path) VALUES (null,old.path);
    END IF;
END;
/