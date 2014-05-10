package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido

interface InscripcionDeJugadorObserver {
	def void jugadorInscripto(Jugador jugador, Partido partido)
}