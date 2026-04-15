-- Insertion des donnees pour la base Tooth_office
-- NOTE: Executer ces commandes uniquement si les donnees n'existent pas deja

DELIMITER //

CREATE TRIGGER before_insert_chef_cabinet_cabinet
BEFORE INSERT ON CHEFCABINET_CABINET
FOR EACH ROW
BEGIN
    DECLARE nb_cabinets_actuels INT;
    DECLARE max_autorise INT;

    -- Compter combien de cabinets le chef a déjà
    SELECT COUNT(*) INTO nb_cabinets_actuels
    FROM CHEFCABINET_CABINET
    WHERE id_chef_cabinet = NEW.id_chef_cabinet;

    -- Récupérer le max_cabinet du plan d'abonnement ACTIF du chef
    SELECT pa.max_cabinet INTO max_autorise
    FROM Abonnement a
    JOIN Plan_Abonnement pa ON a.id_plan = pa.id_plan
    WHERE a.id_chef_cabinet = NEW.id_chef_cabinet
      AND a.etat = 'ACTIF'
    ORDER BY a.date_fin DESC
    LIMIT 1;

    -- Si aucun abonnement actif trouvé
    IF max_autorise IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erreur : Aucun abonnement actif trouvé pour ce Chef de Cabinet.';
    END IF;

    -- Vérification de la limite
    IF (nb_cabinets_actuels + 1) > max_autorise THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erreur : Limite de cabinets atteinte selon le plan d\'abonnement.';
    END IF;

END //

DELIMITER ;

-- 1. Insertion des Cabinets
INSERT INTO Cabinet (nom_cabinet, tel, adresse, logo, description) VALUES 
('cabinet_keneya', '70230456', 'ACI 200', 'logo', 'Description tooth office'),
('Espoir', '60245617', 'BADALABOUGOU', 'logo', 'Cabinet dentaire Espoir');

-- 2. Insertion des Utilisateurs (Chef Cabinet, Dentistes, Secretaires, Patients)
INSERT INTO Utilisateur (nom, prenom, email, mpd, adresse, role, telephone, statutCompte, createdAt) VALUES 
-- Chef de Cabinet
('Diallo', 'Ali', 'alidaillo@gmail.com', 'ali123', 'ACI 200', 'CHEF_CABINET', '70230456', 'VALIDE', '2026-01-01'),
('Diarra', 'Fanene', 'diarrafanene@gmail.com', 'fanene123', 'ACI 200', 'CHEF_CABINET', '70000000', 'VALIDE', '2026-01-01'),

-- Dentistes
('Konate', 'Idrissa', 'idrissakonate@gmail.com', 'idrissa123', 'BADALABOUGOU', 'DENTISTE', '70245678', 'VALIDE', '2026-01-15'),
('Coulibaly', 'Mamadou', 'mamadou.coulibaly@gmail.com', 'dent123', 'Bamako', 'DENTISTE', '76001122', 'VALIDE', '2026-01-15'),
('Konate', 'Awa', 'awa.konate@gmail.com', 'pass456', 'Bamako', 'DENTISTE', '77002233', 'VALIDE', '2026-01-15'),
('Traore', 'Ibrahim', 'ibrahim.traore@gmail.com', 'mdp789', 'Kati', 'DENTISTE', '78003344', 'VALIDE', '2026-01-15'),
('Diallo', 'Fatou', 'fatou.diallo@gmail.com', 'secure321', 'Bamako', 'DENTISTE', '79004455', 'VALIDE', '2026-01-15'),

-- Secretaires
('Traore', 'Moussa', 'moussa.traore@gmail.com', 'secret456', 'Kati', 'SECRETAIRE', '70112233', 'VALIDE', '2026-01-10'),
('Keita', 'Fatoumata', 'fatoumata.keita@gmail.com', 'mdp789', 'Sikasso', 'SECRETAIRE', '66223344', 'VALIDE', '2026-01-10'),

-- Patients
('Keita', 'Abdoulaye', 'abdoulaye.keita@gmail.com', 'patient123', 'Bamako', 'PATIENT', '65001122', 'VALIDE', '2026-02-01'),
('Diallo', 'Aissata', 'aissata.diallo@gmail.com', 'patient456', 'Kati', 'PATIENT', '66002233', 'VALIDE', '2026-02-01'),
('Traore', 'Moussa', 'moussa.traore.patient@gmail.com', 'patient789', 'Sikasso', 'PATIENT', '67003344', 'VALIDE', '2026-02-01'),
('Coulibaly', 'Fatoumata', 'fatoumata.coulibaly@gmail.com', 'patient321', 'Segou', 'PATIENT', '68004455', 'VALIDE', '2026-02-01');

-- 3. Insertion des Chefs de Cabinet
INSERT INTO Chef_Cabinet (id_chef_cabinet) VALUES 
(1),
(2);


-- 4. Insertion de la relation Chef_Cabinet - Cabinet
INSERT INTO CHEFCABINET_CABINET (id_chef_cabinet, id_cabinet) VALUES 
(1, 1),
(2, 2);

-- 5. Insertion des Secretaires
INSERT INTO Secretaire (id_secretaire, id_cabinet, id_chef_cabinet) VALUES 
(8, 1, 1),
(9, 2, 2);

-- 6. Insertion des Dentistes
INSERT INTO Dentiste (id_dentiste, specialite, id_cabinet, id_chef_cabinet) VALUES 
(3, 'Generaliste', 1, 1),
(4, 'Orthodontie', 1, 1),
(5, 'Chirurgie dentaire', 1, 1),
(6, 'Dentisterie generale', 1, 1),
(7, 'Endodontie', 1, 1);

-- 7. Insertion des Patients
INSERT INTO Patient (id_patient, date_naissance) VALUES 
(10, '1995-06-15'),
(11, '2000-03-22'),
(12, '1988-11-10'),
(13, '1992-08-05');

-- 8. Insertion des Creneaux
INSERT INTO Creneau (date, heure_debut, heure_fin, disponible, id_dentiste) VALUES 
('2026-04-09', '09:00:00', '09:30:00', FALSE, 3),
('2026-04-10', '10:00:00', '10:30:00', FALSE, 3),
('2026-04-11', '14:00:00', '14:30:00', FALSE, 4),
('2026-04-12', '15:00:00', '15:30:00', FALSE, 3);

-- 9. Insertion des Rendez-vous
INSERT INTO Rendez_vous (date_RDV, motif, note, etat_RDV, type_rdv, id_patient, id_dentiste, id_secretaire, id_creneau) VALUES 
('2026-04-09 09:00:00', 'Mal a la Dent', 'Premiere consultation', 'FAIT', 'ENLIGNE', 10, 3, Null, 1),
('2026-04-10 10:00:00', 'Consultation generale', 'Controle annuel', 'FAIT', 'ENLIGNE', 10, 3,Null , 2),
('2026-04-11 14:00:00', 'Douleur dentaire', 'Douleur persistante', 'FAIT', 'SURPLACE', 11, 4, 8, 3),
('2026-04-12 15:00:00', 'Detartrage', 'Nettoyage dentaire', 'FAIT', 'ENLIGNE', 12, 3, Null, 4);

-- 10. Insertion des Dossiers Medicaux
INSERT INTO DossierMedicale (antecedents, allergies, historique, id_patient) VALUES 
('Aucun', 'Aucune', 'Premiere visite', 10),
('Diabete', 'Penicilline', 'Suivi regulier', 11),
('Hypertension', 'Aucune', 'Patient regulier', 12),
('Aucun', 'Aucune', 'Bonne sante dentaire', 13);

-- 11. Insertion des Consultations
INSERT INTO Consultation (date_consultation, diagnostic, notes, id_dossier, id_rendez_vous) VALUES 
('2026-04-09', 'Carie dentaire', 'Presence d une carie sur la molaire gauche, nettoyage et traitement recommandes', 1, 1),
('2026-04-10', 'Carie', 'Carie detectee sur la molaire, traitement recommande', 1, 2),
('2026-04-11', 'Gingivite', 'Inflammation des gencives, nettoyage conseille', 2, 3),
('2026-04-12', 'Dents saines', 'Controle general sans anomalie', 3, 4);

-- 12. Insertion des Traitements
INSERT INTO Traitement (nom, description, date_deb, date_fin, type_traitement, id_consultation) VALUES 
('Traitement carie', 'Nettoyage de la carie et pose d un composite', '2026-04-09', '2026-04-11', 'Curatif', 1),
('Detartrage', 'Nettoyage complet des dents', '2026-04-12', '2026-04-12', 'Preventif', 4);

-- 13. Insertion des Avis
INSERT INTO Avis (commentaire, note, date_avis, id_patient, id_cabinet) VALUES 
('Tres bon accueil et service rapide', 4.5, '2026-04-05', 10, 1),
('Temps d attente un peu long mais bon traitement', 3.0, '2026-04-06', 11, 1);

-- 14. Insertion des Plans d Abonnement
INSERT INTO Plan_Abonnement (nom, prix_mensuel, prix_annuel, max_cabinet, max_dentiste, max_secretaire, description) VALUES 
('Plan Basic', 50000, 500000, 1, 3, 2, 'Plan de base pour petits cabinets'),
('Plan Premium', 100000, 1000000, 3, 10, 5, 'Plan premium pour cabinets moyens'),
('Plan Enterprise', 200000, 2000000, 10, 50, 20, 'Plan entreprise pour grands cabinets');

-- 15. Insertion des Abonnements
INSERT INTO Abonnement (date_debut, date_fin, etat, type_paiement, montant_total, id_chef_cabinet, id_plan) VALUES 
('2026-01-01', '2026-02-01', 'ACTIF', 'mensuel', 100000, 1, 2),
('2026-01-15', '2027-01-15', 'ACTIF', 'annuel', 500000, 2, 1);

-- 16. Insertion des Paiements d Abonnement
INSERT INTO Paiement_Abonnement (montant, mode_paiement, date_paiement, id_abonnement) VALUES 
(100000, 'carte_bancaire', '2026-04-01 10:30:00', 1),
(500000, 'mobile_money', '2026-01-15 14:20:00', 2);

-- 17. Insertion des Services
INSERT INTO SERVICES (nom_service, dateCreation) VALUES 
('Consultation generale', '2026-01-01'),
('Detartrage', '2026-01-01'),
('Blanchiment dentaire', '2026-01-01'),
('Orthodontie', '2026-01-01'),
('Implant dentaire', '2026-01-01');

-- 18. Insertion des Assignations Cabinet-Service
INSERT INTO ASSIGNATION_CAB_SER (prix, description, id_service, id_cabinet) VALUES 
(25000, 'Consultation standard', 1, 1),
(50000, 'Nettoyage complet', 2, 1),
(150000, 'Blanchiment professionnel', 3, 1),
(500000, 'Pose d appareil dentaire', 4, 1),
(1000000, 'Pose d implant', 5, 1);

-- 19. Insertion des Services par Dentiste
INSERT INTO SERVICE_DENTISTE (id_service, id_dentiste) VALUES 
(1, 3),
(2, 3),
(4, 4),
(5, 5);
