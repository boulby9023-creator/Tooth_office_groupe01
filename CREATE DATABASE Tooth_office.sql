CREATE DATABASE Tooth_office;
USE Tooth_office;
CREATE TABLE CHEF_CABINET(
    id_chef_cabinet int PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(60)UNIQUE,
    tel VARCHAR(50) UNIQUE,
    adresse VARCHAR(60),
    motDePasse VARCHAR(20)
    );

CREATE TABLE CABINET(
    id_cabinet int PRIMARY KEY AUTO_INCREMENT,
    nom_cabinet VARCHAR(50),
    tel VARCHAR(50) UNIQUE,
    adresse VARCHAR(60),
    logo VARCHAR(200),
    description VARCHAR(200),
    id_chef_cabinet int,
    FOREIGN KEY( id_chef_cabinet) REFERENCES chef_cabinet(id_chef_cabinet)
    );

CREATE TABLE SECRETAIRE(
    id_Secretaire INT PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(50) NOT NULL, 
    prenom VARCHAR(50) NOT NULL, 
    email VARCHAR(50) NOT NULL UNIQUE, 
    tel VARCHAR(50) NOT NULL UNIQUE,
    adresse VARCHAR(50) NOT NULL,  
    motDePasse VARCHAR(50) NOT NULL,
    id_cabinet INT ,
    FOREIGN KEY (id_cabinet) REFERENCES cabinet(id_cabinet)
);

CREATE TABLE DENTISTE(
    id_Dentiste INT PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(50) NOT NULL, 
    prenom VARCHAR(50) NOT NULL, 
    email VARCHAR(50) NOT NULL UNIQUE, 
    telephone VARCHAR(50) NOT NULL UNIQUE,
    adresse VARCHAR(50) NOT NULL, 
    motDePasse VARCHAR(50) NOT NULL, 
    specialité VARCHAR(50) NOT NULL,
    id_cabinet INT,
    FOREIGN KEY (id_cabinet) REFERENCES cabinet(id_cabinet)
);

CREATE TABLE AVIS (
    id_avis int PRIMARY KEY AUTO_INCREMENT, 
    note double, 
    commentaire text, 
    date_avis date, 
    id_cabinet int, 
    id_patient int,
    FOREIGN KEY (id_cabinet) REFERENCES cabinet(id_cabinet)
);
CREATE TABLE RENDEZ_VOUS  (
    id_rdv int PRIMARY KEY AUTO_INCREMENT, 
    date_rdv double, 
    heure text, 
    motif date, 
    statut int, 
    id_patient int,
    id_Secretaire int,
    id_Dentiste int, 
    FOREIGN KEY (id_patient) REFERENCES PATIENT(id_patient),
    FOREIGN KEY (id_Secretaire) REFERENCES SECRETAIRE(id_Secretaire),
    FOREIGN KEY (id_Dentiste) REFERENCES DENTISTE(id_Dentiste)
);

CREATE TABLE PATIENT (
    id_patient int PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(50) NOT NULL, 
    prenom VARCHAR(50) NOT NULL, 
    date_naissance date, 
    telephone VARCHAR(50) NOT NULL UNIQUE, 
    email VARCHAR(50) NOT NULL UNIQUE, 
    adresse VARCHAR(50) NOT NULL
);
CREATE TABLE DOSSIER_MEDICAL (
    id_dossierMedical int PRIMARY KEY AUTO_INCREMENT, 
    antecedents VARCHAR(100) NOT NULL, 
    allergies VARCHAR(100) NOT NULL, 
    historique VARCHAR(50) NOT NULL, 
    id_patient int,
    FOREIGN KEY (id_patient) REFERENCES PATIENT(id_patient)
);
CREATE TABLE CONSULTATION (
    id_consultation int PRIMARY KEY AUTO_INCREMENT, 
    date_consultation date, 
    diagnostic VARCHAR(50) NOT NULL, 
    description text, 
    id_patient int, 
    id_dentiste int, 
    id_rdv int,
    id_dossierMedical int,
    FOREIGN KEY (id_patient) REFERENCES PATIENT(id_patient),
    FOREIGN KEY (id_dentiste) REFERENCES DENTISTE(id_dentiste),
    FOREIGN KEY (id_rdv) REFERENCES RENDEZ_VOUS(id_rdv),
    FOREIGN KEY (id_dossierMedical) REFERENCES DOSSIER_MEDICAL(id_dossierMedical)
);
CREATE TABLE TRAITEMENT (
    id_traitement int PRIMARY KEY AUTO_INCREMENT, 
    nom VARCHAR(50) NOT NULL, 
    description text, 
    date_debut date, 
    date_fin date, 
    type_traitement VARCHAR(50) NOT NULL, 
    id_consultation int,
    FOREIGN KEY (id_consultation) REFERENCES CONSULTATION(id_consultation)
    
)