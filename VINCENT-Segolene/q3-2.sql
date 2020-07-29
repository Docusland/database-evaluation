-- requête pour afficher la moyenne des ventes par jour (je n'ai pas de données test je n'ai donc pas pu tester)
SELECT avg(tarif) from historisation_logement 
left join statut_logement on statut_logement.id_statut = historisation_logement.id_statut
GROUP BY historisation_logement.date_changement