package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido

interface BajaDeJugadorObserver {
	def void jugadorSeBajo(Jugador jugador, Partido partido)
}