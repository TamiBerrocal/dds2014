CREATE DATABASE organizador_futbol5;

USE organizador_futbol5;

CREATE TABLE jugadores (
             id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
             nombre VARCHAR(30) NOT NULL,
			 apodo VARCHAR(30) NOT NULL,
             mail VARCHAR(30) NOT NULL, 
		     fecha_nac DATE NOT NULL,
			 handicap TINYINT);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Marcos', 'Marquitos', 'marquitos@gmail.com', '1991-09-23', 6);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Juan Jose', 'Juanjo', 'jj@gmail.com', '1992-01-22', 5);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Carlos', 'Apache', 'carlitos@gmail.com', '1986-02-13', 6);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Roberto', 'Beto', 'beto@gmail.com', '1988-05-15', 9);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Manuel', 'Manolo', 'manolo@gmail.com', '1971-04-16', 2);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Luis', 'Lucho', 'lucho@gmail.com', '1987-07-30', 4);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Matias', 'Tute', 'tute@gmail.com', '1994-03-13', 5);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Damian', 'Damo', 'damoina@gmail.com', '1987-09-30', 8);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Omar', 'Omi', 'vomi@gmail.com', '1986-10-11', 3);

INSERT INTO jugadores (nombre, apodo, mail, fecha_nac, handicap)
	VALUES('Joaquin', 'Joacko', 'joacko@gmail.com', '1992-07-21', 2);

CREATE TABLE infracciones (
             id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
             jugadorId MEDIUMINT NOT NULL,
			 causa VARCHAR(255) NOT NULL,
			 validaDesde DATETIME NOT NULL,
			 validaHasta DATETIME NOT NULL,
			 FOREIGN KEY (jugadorId)
				REFERENCES jugadores(id));

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(3, 'Por ser malísimo', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(5, 'Por llegar tarde', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(2, 'Por no correr', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(1, 'Por haber errado un gol hecho', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(3, 'Porque me cae mal', '2014-10-15 20:15:00', '2014-10-20 20:15:00');

INSERT INTO infracciones (jugadorId, causa, validaDesde, validaHasta)
	VALUES(3, 'Por haber faltado sin avisar', '2014-10-15 20:15:00', '2014-10-20 20:15:00');


CREATE TABLE partido (
             id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
             id_equipo1 MEDIUMINT NOT NULL,
             id_equipo2 MEDIUMINT NOT NULL,
			 Fecha DATE NOT NULL,
			 lugar VARCHAR (255) NOT NULL,
			 FOREIGN KEY (id_equipo1)
				REFERENCES equipo(id),
			FOREIGN KEY (id_equipo2)
			       REFERENCES equipo (id));
			       
CREATE TABLE inscripcion (
			id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
			jugador_id MEDIUMINT NOT NULL,
			partido_id MEDIUMINT NOT NULL,
			tipo_inscripcion VARCHAR (255) NOT NULL, 
			FOREIGN KEY ( id_jugador) REFERENCES jugadores (id),
			FOREIGN KEY (id_partido ) REFERENCES partido (id));
                  
                  
CREATE TABLE jugador_equipo ( 
			jugador_id MEDIUMINT NOT NULL,
			equipo_id MEDIUMINT NOT NULL,
			FOREIGN KEY (id_jugador) REFERENCES jugadores (id),
			FOREIGN KEY ( id_equipo) REFERENCES equipo (id));
                               
CREATE TABLE equipo(
			id_equipo MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	                nombre	VARCHAR(30) NOT NULL,
			goles	MEDIUMINT NOT NULL ); 
			
CREATE TABLE infraciones ( 
                            id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
                         jugador_id MEDIUMINT NOT NULL,
			partido_id MEDIUMINT NOT NULL, 
			jugador_autor_id MEDIUMINT NOT NULL, 
			nota VARCHAR (255) NOT NULL, 
			comentarios VARCHAR(255), 
			fecha_de_carga DATE NOT NULL, 
			FOREIGN KEY (partido_id) REFERENCES partido (id),
			FOREIGN KEY ( jugador_id) REFERENCES Jugadores (id),
			FOREIGN KEY (jugador_autor_id) REFERENCES jugadores(id));
                          
              
            
                               
                               


