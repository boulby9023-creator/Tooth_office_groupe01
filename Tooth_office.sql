-- Base de données: Tooth_office
-- Structure moderne avec gestion complète du cabinet dentaire

CREATE DATABASE IF NOT EXISTS Tooth_office;
USE Tooth_office;

-- Table principale des utilisateurs
CREATE TABLE Utilisateur (
    id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    mpd VARCHAR(100),
    adresse VARCHAR(255),
    role ENUM('CHEF_CABINET','PATIENT','SECRETAIRE','DENTISTE') DEFAULT 'PATIENT',
    telephone VARCHAR(20),
    statutCompte ENUM('VALIDE','SUSPENDU','SUPPRIMER') DEFAULT 'VALIDE',
    createdAt DATE
);

-- Table Cabinet (doit être créée avant les références)
CREATE TABLE Cabinet (
    id_cabinet INT PRIMARY KEY AUTO_INCREMENT,
    nom_cabinet VARCHAR(50),
    tel VARCHAR(50) UNIQUE,
    adresse VARCHAR(60),
    logo VARCHAR(200),
    description VARCHAR(200)
);

-- Table Chef de Cabinet
CREATE TABLE Chef_Cabinet (
    id_chef_cabinet INT PRIMARY KEY,
    id_cabinet INT,
    FOREIGN KEY (id_chef_cabinet) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (id_cabinet) REFERENCES Cabinet(id_cabinet)
);

-- Table Secrétaire
CREATE TABLE Secretaire (
    id_secretaire INT PRIMARY KEY,
    id_cabinet INT,
    FOREIGN KEY (id_secretaire) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (id_cabinet) REFERENCES Cabinet(id_cabinet)
);

-- Table Dentiste
CREATE TABLE Dentiste (
    id_dentiste INT PRIMARY KEY,
    specialite VARCHAR(100),
    id_cabinet INT,
    FOREIGN KEY (id_dentiste) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (id_cabinet) REFERENCES Cabinet(id_cabinet)
);

-- Table Patient
CREATE TABLE Patient (
    id_patient INT PRIMARY KEY,
    date_naissance DATE,
    FOREIGN KEY (id_patient) REFERENCES Utilisateur(id_utilisateur)
);

-- Table Créneau
CREATE TABLE Creneau (
    id_creneau INT PRIMARY KEY AUTO_INCREMENT,
    date DATE,
    heure_debut TIME,
    heure_fin TIME,
    disponible BOOLEAN
);

-- Table Rendez-vous
CREATE TABLE Rendez_vous (
    id_rendez_vous INT PRIMARY KEY AUTO_INCREMENT,
    date_RDV DATETIME,
    motif VARCHAR(50),
    note TEXT,
    etat_RDV ENUM('EN_ATTENTE','VALIDE','FAIT','ANNULE','REPORTE') DEFAULT 'EN_ATTENTE',
    type_rdv ENUM('ENLIGNE','SURPLACE') DEFAULT 'ENLIGNE',
    id_patient INT,
    id_dentiste INT,
    id_creneau INT,
    FOREIGN KEY (id_patient) REFERENCES Patient(id_patient),
    FOREIGN KEY (id_dentiste) REFERENCES Dentiste(id_dentiste),
    FOREIGN KEY (id_creneau) REFERENCES Creneau(id_creneau)
);

-- Table Dossier Médical
CREATE TABLE DossierMedicale (
    id_dossier INT PRIMARY KEY AUTO_INCREMENT,
    antecedents VARCHAR(100),
    allergies VARCHAR(100),
    historique TEXT,
    id_patient INT,
    FOREIGN KEY (id_patient) REFERENCES Patient(id_patient)
);

-- Table Consultation
CREATE TABLE Consultation (
    id_consultation INT PRIMARY KEY AUTO_INCREMENT,
    date_consultation DATE,
    diagnostic VARCHAR(50),
    notes TEXT,
    id_dossier INT,
    id_rendez_vous INT,
    FOREIGN KEY (id_dossier) REFERENCES DossierMedicale(id_dossier),
    FOREIGN KEY (id_rendez_vous) REFERENCES Rendez_vous(id_rendez_vous)
);

-- Table Traitement
CREATE TABLE Traitement (
    id_traitement INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    description TEXT,
    date_deb DATE,
    date_fin DATE,
    type_traitement VARCHAR(50),
    id_consultation INT,
    FOREIGN KEY (id_consultation) REFERENCES Consultation(id_consultation)
);

-- Table Avis
CREATE TABLE Avis (
    id_avis INT PRIMARY KEY AUTO_INCREMENT,
    commentaire TEXT,
    note DOUBLE,
    date_avis DATE,
    id_patient INT,
    id_cabinet INT,
    FOREIGN KEY (id_patient) REFERENCES Patient(id_patient),
    FOREIGN KEY (id_cabinet) REFERENCES Cabinet(id_cabinet)
);

-- Table Plan d'Abonnement
CREATE TABLE Plan_Abonnement (
    id_plan INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    prix DECIMAL(10,2)
);

-- Table Abonnement
CREATE TABLE Abonnement (
    id_abonnement INT PRIMARY KEY AUTO_INCREMENT,
    etat ENUM('ACTIF','SUSPENDU','EXPIRE') DEFAULT 'ACTIF',
    id_cabinet INT,
    id_plan INT,
    FOREIGN KEY (id_cabinet) REFERENCES Cabinet(id_cabinet),
    FOREIGN KEY (id_plan) REFERENCES Plan_Abonnement(id_plan)
);

-- Table Paiement Abonnement
CREATE TABLE Paiement_Abonnement (
    id_paiement INT PRIMARY KEY AUTO_INCREMENT,
    type ENUM('MENSUEL','ANNUEL') DEFAULT 'MENSUEL',
    datePaiement DATE,
    id_abonnement INT,
    FOREIGN KEY (id_abonnement) REFERENCES Abonnement(id_abonnement)
);
