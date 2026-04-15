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