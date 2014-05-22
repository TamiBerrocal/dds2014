package ar.edu.dds.model

import org.joda.time.DateTime
import java.util.List
import ar.edu.dds.model.inscripcion.ModoDeInscripcionimport ar.edu.dds.home.JugadoresHome

class Admin extends Jugador {

	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String mail) {
		super(nombre, edad, modoDeInscripcion, mail)
	}

	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar, this)
	}

	def List<Jugador> confirmarPartido(Partido partido) {
		partido.confirmar
	}
	
	def void aprobarJugador(Jugador jugador) {
		JugadoresHome.instance.aprobarJugador(jugador)
	}
	
	def void rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		JugadoresHome.instance.rechazarJugador(jugador, motivoDeRechazo)
	}
}
