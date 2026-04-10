ALTER TABLE RENDEZ_VOUS
drop COLUMN heure

ALTER TABLE AVIS
ADD  id_patient

ALTER TABLE AVIS ADD CONSTRAINT fk_id_patient FOREIGN KEY (id_patient) REFERENCES PATIENT(id_patient);

ALTER TABLE RENDEZ_VOUS
MODIFY date_rdv datetime

ALTER TABLE RENDEZ_VOUS
MODIFY motif varchar(50)

UPDATE CABINET SET nom_cabinet="cabinet_keneya" WHERE id_cabinet=1