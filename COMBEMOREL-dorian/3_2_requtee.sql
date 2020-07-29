/**
    3.2 Une requête qui retourne la valeur moyenne des biens immobiliers vendus ordonnés dans le temps avec une granularité journalière.
    (Certains jours aucune vente n'a lieu. Il est attendu de ne pas avoir de ligne pour ces jours là)

*/
SELECT
hh.created_at as jour,
AVG(hh.tariff) as moyenne
fROM histo_housing hh
JOIN status s on s.id = hh.status_id
WHERE s.status = "Vendu"
GROUP BY DAY(jour)
ORDER BY jour