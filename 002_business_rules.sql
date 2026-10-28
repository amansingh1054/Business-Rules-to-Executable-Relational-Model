USE InternshipDB;

DROP TRIGGER IF EXISTS validate_offer_before_insert;
DELIMITER $$

CREATE TRIGGER validate_offer_before_insert
BEFORE INSERT ON Offers
FOR EACH ROW
BEGIN
    DECLARE application_status VARCHAR(20) DEFAULT NULL;

    SELECT status
      INTO application_status
      FROM Applications
     WHERE application_id = NEW.application_id
     FOR UPDATE;

    IF application_status IS NULL OR application_status <> 'SELECTED' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Offer can only be issued to a selected student';
    END IF;
END$$

DELIMITER ;
