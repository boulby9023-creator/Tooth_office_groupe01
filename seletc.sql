

SELECT * FROM  PATIENT
SELECT p.nom, p.prenom, r.date_rdv, r.motif FROM RENDEZ_VOUS as r JOIN PATIENT as p ON r.id_patient=p.id_patient WHERE p.id_patient=1;
SELECT c.date_consultation, c.diagnostic, c.description, d.nom, d.prenom FROM CONSULTATION as c JOIN DENTISTE as d ON c.id_dentiste=d.id_Dentiste;
SELECT c.date_consultation, c.diagnostic, c.description, d.nom AS nomDentiste, d.prenom AS prenomDentiste, p.nom, p.prenom FROM CONSULTATION as c JOIN DENTISTE as d ON c.id_dentiste=d.id_Dentiste JOIN PATIENT as p ON p.id_patient=c.id_patient;
SELECT r.id_patient, COUNT(id_rdv), p.nom, p.prenom FROM RENDEZ_VOUS as r JOIN PATIENT as p ON r.id_patient=p.id_patient GROUP BY id_patient;
SELECT p.nom, p.prenom, c.diagnostic, t.nom, cb.nom_cabinet FROM CONSULTATION as c JOIN PATIENT as p ON c.id_patient=p.id_patient JOIN TRAITEMENT as t ON t.id_consultation=c.id_consultation JOIN DENTISTE as d ON d.id_Dentiste=c.id_dentiste JOIN CABINET as cb ON cb.id_cabinet=d.id_cabinet ORDER BY c.id_consultation DESC LIMIT 1;