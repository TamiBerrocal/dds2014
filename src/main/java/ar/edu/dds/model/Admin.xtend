package ar.edu.dds.model

import ar.edu.dds.home.JugadoresHome
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.joda.time.DateTime

class Admin extends Jugador {

	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String mail) {
		super(nombre, edad, modoDeInscripcion, mail)
	}

	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar, this)
	}

	def void confirmarPartido(Partido partido) {
		partido.confirmar
	}
	
	def void aprobarJugador(Jugador jugador) {
		JugadoresHome.instance.aprobarJugador(jugador)
	}
	
	def void rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		JugadoresHome.instance.rechazarJugador(jugador, motivoDeRechazo)
	}
}
