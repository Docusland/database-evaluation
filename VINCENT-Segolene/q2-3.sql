-- créatoion de la table d'historisation
CREATE IF NOT EXISTS TABLE historisation_logement (
                reference VARCHAR(50) NOT NULL,
                date_chagement DATETIME NOT NULL,
                id_statut_logement INT NOT NULL,
                tarif DECIMAL(11) NOT NULL,
                PRIMARY KEY (reference)
);
ALTER TABLE historisation_logement ADD CONSTRAINT statut_logement_historisation_logement_fk
FOREIGN KEY (id_statut_logement)
REFERENCES statut_logement (id_statut_logement);

ALTER TABLE historisation_logement ADD CONSTRAINT logements_historisation_logement_fk
FOREIGN KEY (reference)
REFERENCES logements (reference);


-- trigger d'enregistrement des changement sur logements
DELIMITER //

CREATE TRIGGER  historisation_logement
    BEFORE UPDATE
    ON logements FOR id_statut OR tarif

BEGIN  
    IF OLD.id_statut != NEW.id_statut 
    THEN
        INSERT INTO historisation_logement (reference, id_statut, tarif, date_changement) VALUES (reference, OLD.id_statut, tarif, NOW() );
    END IF 
    if OLD.tarif != NEW.tarif
    then
        INSERT INTO  historisation_logement (reference, id_statut, tarif, date_changement) VALUES (reference, id_statut, OLD.tarif, NOW());
      
    end if;

END //
DELIMITER ;