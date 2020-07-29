/**
    2.3 Le tarif d'un logement a tendance à varier en fonction de l'offre et de la demande ainsi que de l'ancienneté de l'annonce.
    Il doit être possible d'avoir un historique des différentes tarifications d'un logement.
    Le changement de statut doit également être historisé au sein de l'application.

    j'utiliserai un trigger
    un qui avant chaque update du tarif sur la table housing,
    enregistrerais l'ancien tarif ainsi que la date.
    et qui avant chaque update du status sur la table housing,
    enregistrerais l'ancien status ainsi que la date.

*/
DELIMITER /

CREATE OR REPLACE TRIGGER triggerUpdateHousing
    BEFORE UPDATE ON housing
    FOR EACH ROW

BEGIN
    IF new.tariff != old.tariff THEN
        INSERT INTO histo_housing (id,tariff,created_at,housing_id,status_id) VALUES (null,old.tariff,DATE(NOW()),new.id,old.status_id);
    ELSEIF new.status_id != old.status_id THEN
        INSERT INTO histo_housing (id,tariff,created_at,housing_id,status_id) VALUES (null,old.tariff,DATE(NOW()),new.id,old.status_id);

    END IF;
END;

/