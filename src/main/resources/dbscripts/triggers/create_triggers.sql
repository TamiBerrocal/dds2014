-- 3.d
DELIMITER \\
CREATE TRIGGER tr_delete_jugador AFTER DELETE ON inscripciones
FOR EACH ROW
	BEGIN
		INSERT INTO baja_jugadores(id, jugador_id, partido_id) 
        VALUES (NULL, OLD.jugador_id, OLD.partido_id);
	END \\
DELIMITER ;