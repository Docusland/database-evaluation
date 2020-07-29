-- création de la table 
CREATE TABLE anciennes_photos (id INT PRIMARY KEY NOT NULL AUTO_INCREMENT , chemin VARCHAR(255));

-- création du trigger sur le update
DELIMITER //

CREATE TRIGGER  update_photo
    BEFORE UPDATE
    ON photos FOR EACH ROW

BEGIN  
    IF OLD.photo != NEW.photo 
    THEN
        INSERT INTO anciennes_photos (chemin) VALUES (OLD.photo);
    END IF 

END //
DELIMITER ;


-- script de suppression des données qui devra être appelé à la fin du script sur le serveur

TRUNCATE TABLE anciennes_photos;