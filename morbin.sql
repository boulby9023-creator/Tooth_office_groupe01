CREATE TABLE PLAN_ABONNEMENT(
    id_plan int PRIMARY KEY AUTO_INCREMENT,
    nom varchar(50) NOT NULL,
    prix_mensuel int NOT NULL,
    prix_annuel int NOT NULL,
    max_cabinet int NOT NULL,
    max_dentiste int NOT NULL,
    max_secretaire int NOT NULL,
    description text
)

CREATE TABLE ABONNEMENT(
	id_abonnement int PRIMARY KEY AUTO_INCREMENT,
	date_debut date NOT NULL,
	date_fin date NOT NULL,
	etat_abonnement enum('actif','suspendu','expire') NOT NULL,
	type_paiement enum('mensuel','annuel') NOT NULL,
	montant_total int NOT NULL
)

CREATE TABLE PAIEMENT_ABONNEMENT(
	id_paiement int PRIMARY KEY AUTO_INCREMENT,
	montant int NOT NULL,
	mode_paiement enum('carte_bancaire','mobile_money') NOT NULL,
	date_paiement datetime NOT NULL
)