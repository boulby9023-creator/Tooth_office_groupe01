-- Requetes SELECT adaptees a la nouvelle structure de base de donnees

-- 1. Afficher tous les patients avec leurs informations
SELECT 
    p.id_patient,
    u.nom,
    u.prenom,
    p.date_naissance,
    u.email,
    u.telephone,
    u.adresse
FROM Patient p
JOIN Utilisateur u ON p.id_patient = u.id_utilisateur;

-- 2. Afficher les rendez-vous d'un patient specifique (id_patient = 10)
SELECT 
    u.nom,
    u.prenom,
    r.date_RDV,
    r.motif,
    r.etat_RDV,
    r.type_rdv
FROM Rendez_vous r
JOIN Patient p ON r.id_patient = p.id_patient
JOIN Utilisateur u ON p.id_patient = u.id_utilisateur
WHERE p.id_patient = 10;

-- 3. Afficher les consultations avec les informations du dentiste
SELECT 
    c.date_consultation,
    c.diagnostic,
    c.notes,
    ud.nom AS nomDentiste,
    ud.prenom AS prenomDentiste,
    d.specialite
FROM Consultation c
JOIN Rendez_vous r ON c.id_rendez_vous = r.id_rendez_vous
JOIN Dentiste d ON r.id_dentiste = d.id_dentiste
JOIN Utilisateur ud ON d.id_dentiste = ud.id_utilisateur;

-- 4. Afficher les consultations avec patient et dentiste
SELECT 
    c.date_consultation,
    c.diagnostic,
    c.notes,
    ud.nom AS nomDentiste,
    ud.prenom AS prenomDentiste,
    up.nom AS nomPatient,
    up.prenom AS prenomPatient
FROM Consultation c
JOIN Rendez_vous r ON c.id_rendez_vous = r.id_rendez_vous
JOIN Dentiste d ON r.id_dentiste = d.id_dentiste
JOIN Patient p ON r.id_patient = p.id_patient
JOIN Utilisateur ud ON d.id_dentiste = ud.id_utilisateur
JOIN Utilisateur up ON p.id_patient = up.id_utilisateur;

-- 5. Compter le nombre de rendez-vous par patient
SELECT 
    r.id_patient,
    COUNT(r.id_rendez_vous) AS nombre_rdv,
    u.nom,
    u.prenom
FROM Rendez_vous r
JOIN Patient p ON r.id_patient = p.id_patient
JOIN Utilisateur u ON p.id_patient = u.id_utilisateur
GROUP BY r.id_patient, u.nom, u.prenom;

-- 6. Afficher la derniere consultation avec traitement, patient, dentiste et cabinet
SELECT 
    up.nom AS nomPatient,
    up.prenom AS prenomPatient,
    c.diagnostic,
    t.nom AS nomTraitement,
    t.description AS descriptionTraitement,
    cab.nom_cabinet,
    ud.nom AS nomDentiste,
    ud.prenom AS prenomDentiste
FROM Consultation c
JOIN Rendez_vous r ON c.id_rendez_vous = r.id_rendez_vous
JOIN Patient p ON r.id_patient = p.id_patient
JOIN Dentiste d ON r.id_dentiste = d.id_dentiste
JOIN Utilisateur up ON p.id_patient = up.id_utilisateur
JOIN Utilisateur ud ON d.id_dentiste = ud.id_utilisateur
JOIN Cabinet cab ON d.id_cabinet = cab.id_cabinet
JOIN Traitement t ON t.id_consultation = c.id_consultation
ORDER BY c.id_consultation DESC
LIMIT 1;

-- 7. Afficher les patients nes apres 1995
SELECT 
    u.id_utilisateur,
    u.nom,
    u.prenom,
    p.date_naissance,
    u.email,
    u.telephone,
    u.adresse
FROM Patient p
JOIN Utilisateur u ON p.id_patient = u.id_utilisateur
WHERE p.date_naissance > '1995-12-31'
ORDER BY p.date_naissance;

-- 8. Afficher tous les dentistes avec leur specialite et cabinet
SELECT 
    u.nom,
    u.prenom,
    d.specialite,
    u.telephone,
    u.email,
    cab.nom_cabinet,
    cab.adresse AS adresse_cabinet
FROM Dentiste d
JOIN Utilisateur u ON d.id_dentiste = u.id_utilisateur
JOIN Cabinet cab ON d.id_cabinet = cab.id_cabinet;

-- 9. Afficher les avis avec les informations du patient et du cabinet
SELECT 
    a.note,
    a.commentaire,
    a.date_avis,
    u.nom AS nomPatient,
    u.prenom AS prenomPatient,
    cab.nom_cabinet
FROM Avis a
JOIN Patient p ON a.id_patient = p.id_patient
JOIN Utilisateur u ON p.id_patient = u.id_utilisateur
JOIN Cabinet cab ON a.id_cabinet = cab.id_cabinet
ORDER BY a.date_avis DESC;

-- 10. Afficher les abonnements actifs avec chef de cabinet et plan
SELECT 
    ab.id_abonnement,
    ab.etat,
    u.nom AS nomChef,
    u.prenom AS prenomChef,
    cab.nom_cabinet,
    pl.nom AS nomPlan,
    pl.prix
FROM Abonnement ab
JOIN Chef_Cabinet cc ON ab.id_chef_cabinet = cc.id_chef_cabinet
JOIN Utilisateur u ON cc.id_chef_cabinet = u.id_utilisateur
JOIN Cabinet cab ON cc.id_cabinet = cab.id_cabinet
JOIN Plan_Abonnement pl ON ab.id_plan = pl.id_plan
WHERE ab.etat = 'ACTIF';
