DROP DATABASE IF EXISTS organizador_futbol5;

CREATE DATABASE organizador_futbol5;

USE organizador_futbol5;

-- JUGADORES
CREATE TABLE jugadores (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
			            nombre VARCHAR(30) NOT NULL,
						apodo VARCHAR(30) NOT NULL,
			            mail VARCHAR(30) NOT NULL, 
					    fecha_nac DATE NOT NULL,
						handicap TINYINT,
                        aprobado CHAR(1) default'N' CHECK(aprobado in ('Y','N')));
             

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Marcos', 'Marquitos', 'marquitos@gmail.com', '1991-09-23', 6, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Juan Jose', 'Juanjo', 'jj@gmail.com', '1992-01-22', 5, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Carlos', 'Apache', 'carlitos@gmail.com', '1986-02-13', 6, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Roberto', 'Beto', 'beto@gmail.com', '1988-05-15', 9, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Manuel', 'Manolo', 'manolo@gmail.com', '1971-04-16', 2, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Luis', 'Lucho', 'lucho@gmail.com', '1987-07-30', 4, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Matias', 'Tute', 'tute@gmail.com', '1994-03-13', 5, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Damian', 'Damo', 'damoina@gmail.com', '1987-09-30', 8, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Omar', 'Omi', 'vomi@gmail.com', '1986-10-11', 3, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Joaquin', 'Joacko', 'joacko@gmail.com', '1992-07-21', 2, 'Y');

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap, aprobado)
	VALUES('Rodrigo', 'Uruguayo', 'rmora@gmail.com', '1988-07-21', 10, 'Y');

-- INFRACCIONES
CREATE TABLE infracciones (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
				           jugador_id MEDIUMINT NOT NULL,
						   causa VARCHAR(255) NOT NULL,
						   valida_desde DATETIME NOT NULL,
						   valida_hasta DATETIME NOT NULL,
						   FOREIGN KEY (jugador_id) REFERENCES jugadores(id));
             

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(3, 'Por ser malísimo', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(5, 'Por llegar tarde', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(2, 'Por no correr', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(1, 'Por haber errado un gol hecho', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(3, 'Porque me cae mal', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugador_id, causa, valida_desde, valida_hasta)
	VALUES(3, 'Por haber faltado sin avisar', '2014-10-15 20:15:00', '2014-10-20 20:15:00');
	


-- EQUIPOS
CREATE TABLE equipos(id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
			         nombre VARCHAR(30) NOT NULL,
				  	 goles MEDIUMINT);

INSERT INTO equipos(nombre, goles) 
	VALUES('Nothingam Miedo', 4);

INSERT INTO equipos(nombre, goles) 
	VALUES('Aston Birra', 2);
					

-- PARTIDOS
CREATE TABLE partidos (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
		               equipo1_id MEDIUMINT NOT NULL,
		               equipo2_id MEDIUMINT NOT NULL,
					   fecha DATE NOT NULL,
					   lugar VARCHAR (255) NOT NULL,
					   FOREIGN KEY (equipo1_id) REFERENCES equipos(id),
					   FOREIGN KEY (equipo2_id) REFERENCES equipos(id));

INSERT INTO partidos (equipo1_id, equipo2_id, fecha, lugar)
	VALUES (1, 2, '2014-10-14', 'Quintino y autopista');
			
                               
                          
-- JUGADORES-EQUIPOS
CREATE TABLE jugadores_equipos (jugador_id MEDIUMINT NOT NULL,
								equipo_id MEDIUMINT NOT NULL,
								PRIMARY KEY (jugador_id, equipo_id),
								FOREIGN KEY (jugador_id) REFERENCES jugadores (id),
								FOREIGN KEY (equipo_id) REFERENCES equipos (id));

INSERT INTO jugadores_equipos VALUES (1, 1);
INSERT INTO jugadores_equipos VALUES (2, 1);
INSERT INTO jugadores_equipos VALUES (3, 1);
INSERT INTO jugadores_equipos VALUES (4, 1);
INSERT INTO jugadores_equipos VALUES (5, 1);
INSERT INTO jugadores_equipos VALUES (6, 2);
INSERT INTO jugadores_equipos VALUES (7, 2);
INSERT INTO jugadores_equipos VALUES (8, 2);
INSERT INTO jugadores_equipos VALUES (9, 2);
INSERT INTO jugadores_equipos VALUES (10, 2);


-- INSCRIPCIONES
CREATE TABLE inscripciones (jugador_id MEDIUMINT NOT NULL,
							partido_id MEDIUMINT NOT NULL,
							tipo_inscripcion VARCHAR (255) NOT NULL, 
							PRIMARY KEY (jugador_id, partido_id),
							FOREIGN KEY (jugador_id) REFERENCES jugadores (id),
							FOREIGN KEY (partido_id) REFERENCES equipos (id));

INSERT INTO inscripciones VALUES (1, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (2, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (3, 1, 'CONDICIONAL');
INSERT INTO inscripciones VALUES (4, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (5, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (6, 1, 'SOLIDARIA');
INSERT INTO inscripciones VALUES (7, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (8, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (9, 1, 'ESTANDAR');
INSERT INTO inscripciones VALUES (10, 1, 'ESTANDAR');


-- CALIFICACIONES
CREATE TABLE calificaciones (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
							 partido_id MEDIUMINT NOT NULL,
							 jugador_id MEDIUMINT NOT NULL,
							 jugador_autor_id MEDIUMINT NOT NULL,
							 nota TINYINT NOT NULL,
							 comentario VARCHAR(255) NOT NULL,
							 fecha_de_carga DATE NOT NULL,
							 FOREIGN KEY (partido_id) REFERENCES partidos(id),
							 FOREIGN KEY (jugador_id) REFERENCES jugadores(id),
							 FOREIGN KEY (jugador_autor_id) REFERENCES jugadores(id));

INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 3, 2, 7, 'Buena pegada', '2014-10-15');
INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 5, 1, 9, 'Bestia del futbol', '2014-10-15');
INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 5, 4, 8, 'Mucha potencia', '2014-10-15');
INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 6, 4, 2, 'Sos de cartón hermano', '2014-10-15');
INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 2, 5, 4, 'Safa', '2014-10-15');
INSERT INTO calificaciones (partido_id, jugador_id, jugador_autor_id, nota, comentario, fecha_de_carga)
	VALUES (1, 5, 6, 8, 'Muy bien', '2014-10-15');

-- BAJA JUGADORES
CREATE TABLE baja_jugadores (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
							 jugador_id MEDIUMINT NOT NULL,
							 partido_id MEDIUMINT NOT NULL,
                             FOREIGN KEY (jugador_id) REFERENCES jugadores(id),
                             FOREIGN KEY (partido_id) REFERENCES partidos(id));     
-- RECHAZO JUGADORES
CREATE TABLE rechazo_jugadores (id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
								jugador_id MEDIUMINT NOT NULL,
                                motivo VARCHAR(60),
                                fecha DATETIME);