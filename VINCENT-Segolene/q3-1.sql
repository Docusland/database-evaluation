
-- requête pour retrouver les logement de xvier niel à calais (je n'ai pas de données tests je n'ai donc pas pu tester)
SELECT * FROM logements 
LEFT JOIN villes on villes.id_ville = logements.id_ville 
LEFT JOIN proprietaires on proprietaires.id_proprietaire= logements.id_proprietaire
WHERE 
villes.nom = UPPERCASE('calais')
AND 
proprietaires.nom_proprietaire = UPPERCASE('niel')
AND 
proprietaires.prenom_proprietaire = UPPERCASE('xavier')