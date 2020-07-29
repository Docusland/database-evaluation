# Evaluation du module : Database Administration
Evaluation réalisée le 29 Juillet 2020.

B2 Info DEV - Campus Academy Rennes

Formateur: Erwann DUCLOS

L'évaluation se porte sur l'acquisition de techniques et de bonnes pratiques concernant l'implémentation d'une base de données.

\clearpage
## Contexte

Vous vous apprêtez à réaliser une application à destination d'une agence immobilière.
Le client a de nombreux axes de réflexion sur de la proposition de nouveaux services à leurs clients,  mais souhaiterait déjà voir migrer leur application actuelle sur une technologie plus récente. 

A vous de jouer donc pour modéliser la base de données, au sein de mariaDB, pour la demande suivante :

L'application doit pouvoir assurer un suivi des logements que l'agence immobilière a à son actif. 

* Chaque logement a un type (Appartement, Maison, Logement commercial...) et une adresse.
* Chaque logement est accompagné de plusieurs photos. Chacune de ces photos doivent pouvoir être accompagnée d'un commentaire. 
* Chaque logement dispose d'un nombre de pièces, d'un nombre de chambres, d'une surface en mètre carrés, d'un tarif, d'une description, d'une référence interne, d'une performance énergétique (ex : 253 kWhEP/m2/an), d'un indice d'émission de GES (ex : 8kgeqCO2/m2/an) et d'un type de prestation (location/vente)
* Les types de logement ainsi que les types de prestation doivent pouvoir être configurables.
* Chaque logement est également associé à son propriétaire actuel. Un logement ne peut être associé qu'à un propriétaire.
Les fiches propriétaires ont un nom, prénom et genre, mais également des champs facultatifs tels que: tel, email, adresse... Les propriétaires ne disposent pas de compte au sein de l'application.

Au sein de l'application, le personnel de l'agence dispose de comptes utilisateurs permettant de rajouter des commentaires sur la fiche d'un logement. Sachant que plusieurs commentaires doivent pouvoir être listés sur un logement, rangés par date de création.
Ils sont également habilités à rajouter des commentaires sur les fiches des propriétaires.

Le personnel peut également modifier le statut d'un logement. En effet la fiche d'un logement est d'abord au statut Brouillon, puis passe au statut Publié avant de passer à un statut "Dossier en cours" pour finalement arriver sur un statut final "Vendu" ou encore "Loué".

\clearpage
## Production attendue

Réalisez un fork de ce dépôt et créez un dossier au format NOM-prenom. Ce dossier sera considéré comme votre livrable. Vous pouvez inclure des documents markdown, word, pdf, sql, images etc...

Il est attendu de recevoir une merge request sur ce dépôt d'ici 16h30. 

Bon courage !

### 1 - Modélisation de la base de données (7 pts)

 - 1.1 Réaliser le dictionnaire de données
 - 1.2 Réaliser le Modèle Entité Association
 - 1.3 Réaliser le Modèle Physique de Données

### 2 - Réaliser des scripts (trigger/procedure...) (6 pts)

Détaillez sommairement à l'écrit puis réalisez l'ensemble des scripts SQL ou adaptations de la base de données répondant aux exigences ci-dessous. Attention, cette épreuve concerne la base de données, nul autre language que le SQL n'est attendu : 

 - 2.1 Lorsqu'un utilisateur modifie les photos associées à une maison, les photos anciennement liées doivent être retirées du serveur. Proposez une solution.
 - 2.1 Il peut arriver de modifier voire supprimer les photos liées à une maison. Les anciennes
 - 2.2 La base de données actuellement existante n'a pas forcément l'intégrité des données attendues au sein de la nouvelle application. Les fiches propriétaires ne sont pas toutes complètes. Lors de la création ou mise à jour d'un propriétaire, il doit être obligatoire d'avoir le téléphone et/ou le mail de défini. Quelle solution proposez-vous?
 - 2.3 Le tarif d'un logement a tendance à varier en fonction de l'offre et de la demande ainsi que de l'ancienneté de l'annonce. Il doit être possible d'avoir un historique des différentes tarifications d'un logement. Le changement de statut doit également être historisé au sein de l'application. Proposez une solution.

### 3 - Réaliser une requête SQL. (4 pts)

Proposez deux requêtes SQL:

- 3.1 Une requête qui permet de retourner l'ensemble des informations sur les logements situés à Calais appartenant au propriétaire 'Xavier Niel'
- 3.2 Une requête qui retourne la valeur moyenne des biens immobiliers vendus ordonnés dans le temps avec une granularité journalière. (Certains jours aucune vente n'a lieu. Il est attendu de ne pas avoir de ligne pour ces jours là)

### 4 - Optimisez votre base de données (3 pts)

Imaginons que la base de données que vous avez conçue soit utilisée au sein d'une application conçue par une autre équipe de développeur.
Listez ici les recommandations que vous pourriez leur apporter pour l'administration, l'optimisation et la gestion de la base de données.
 
