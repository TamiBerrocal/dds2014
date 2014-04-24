package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.Jugador

abstract class ModoDeInscripcion {
	
	def void inscribir(Jugador jugador, Partido partido) {
		partido.agregarJugador(jugador)
	}
	
}