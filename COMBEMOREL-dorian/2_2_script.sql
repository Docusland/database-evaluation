/**
    2.2 La base de données actuellement existante n'a pas forcément l'intégrité des données attendues au sein de la nouvelle application.
    Les fiches propriétaires ne sont pas toutes complètes. Lors de la création ou mise à jour d'un propriétaire,
    il doit être obligatoire d'avoir le téléphone et/ou le mail de défini.

    j'utiliserai deux trigger 
    un qui avant chaque update et l'autre avant chaque insert sur la table owner,
    verifirais que le telephone et le mail ne soit pas nul.

*/
DELIMITER /
CREATE OR REPLACE TRIGGER triggerInsertOwner
    BEFORE INSERT ON owner
    FOR EACH ROW
BEGIN

    IF(new.phone is null && new.email is null) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "le téléphone et l'email ne peuvent pas etre null";
    END IF;
END;
/

DELIMITER /
CREATE OR REPLACE TRIGGER triggerUpdateOwner
    BEFORE UPDATE ON owner
    FOR EACH ROW
BEGIN

    IF(new.phone is null && new.email is null) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "le téléphone et l'email ne peuvent pas etre null";
    END IF;
END;
/