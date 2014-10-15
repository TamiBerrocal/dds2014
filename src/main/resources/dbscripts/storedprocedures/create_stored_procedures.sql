-- 3.e
DELIMITER \\
CREATE PROCEDURE dar_de_baja_jugador(IN jugador_que_se_baja_id MEDIUMINT,
									 IN p_partido_id MEDIUMINT,
									 IN jugador_reemplazo_id MEDIUMINT)
BEGIN
	DELETE FROM inscripciones WHERE jugador_id = jugador_que_se_baja_id AND partido_id = p_partido_id;
	IF jugador_reemplazo_id IS NOT NULL THEN 
		INSERT INTO inscripciones VALUES (jugador_reemplazo_id, p_partido_id, 'ESTANDAR');
	ELSE
		INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
			VALUES(jugador_que_se_baja_id, 'Baja sin reemplazo', NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY));
	END IF;
END \\
DELIMITER ;