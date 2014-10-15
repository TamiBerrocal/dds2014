-- 3.a
CREATE VIEW malos AS SELECT * FROM jugadores WHERE handicap < 6;

-- 3.b
CREATE VIEW traicioneros AS SELECT * FROM jugadores j
									 WHERE (SELECT COUNT(*) FROM infracciones i
															WHERE i.jugador_id = j.id
															  AND DATEDIFF(NOW(), i.valida_hasta) < 90) > 3;

-- 3.c
CREATE VIEW pueden_mejorar AS 
	SELECT * FROM malos
			 WHERE DATE_FORMAT(FROM_DAYS(TO_DAYS(NOW())-TO_DAYS(fecha_nac)), '%Y')+0 < 25;
             
-- 3.d
DELIMITER \\
CREATE TRIGGER tr_delete_jugador AFTER DELETE ON inscripciones
FOR EACH ROW
	BEGIN
		INSERT INTO baja_jugadores(id, jugador_id, partido_id) 
        VALUES (NULL, OLD.jugador_id, OLD.partido_id);
	END \\
DELIMITER ;


