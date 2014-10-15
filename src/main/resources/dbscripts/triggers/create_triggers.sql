DELIMITER \\
CREATE TRIGGER tr_delete_jugador AFTER DELETE ON inscripciones
FOR EACH ROW
	BEGIN
		INSERT INTO baja_jugadores(jugador_id, partido_id) 
        VALUES (OLD.jugador_id, OLD.partido_id);
	END \\
DELIMITER ;