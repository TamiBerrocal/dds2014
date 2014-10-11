CREATE DATABASE organizador_futbol5;

USE organizador_futbol5;

CREATE TABLE jugadores (
             id MEDIUMINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
             nombre VARCHAR(30) NOT NULL,
			 apodo VARCHAR(30) NOT NULL,
             mail VARCHAR(30) NOT NULL, 
		     fecha_nac DATE NOT NULL,
			 handicap TINYINT
             );

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
