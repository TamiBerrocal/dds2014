package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import ar.edu.dds.repository.JugadoresRepo
import org.joda.time.DateTime
import org.joda.time.LocalDate

class Admin extends Jugador {
	
	new(String nombre, LocalDate fechaDeNac, ModoDeInscripcion modoDeInscripcion, String mail, String apodo) {
		super(nombre, fechaDeNac, modoDeInscripcion, mail, apodo)
	}

	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar, this)
	}

	def void aprobarJugador(Jugador jugador, JugadoresRepo jugadoresRepo) {
		jugadoresRepo.aprobarJugador(jugador)
	}
	
	def void rechazarJugador(Jugador jugador, String motivoDeRechazo, JugadoresRepo jugadoresRepo) {
		jugadoresRepo.rechazarJugador(jugador, motivoDeRechazo)
	}
}
