package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido

class InfraccionObserver implements BajaDeJugadorObserver {
	
	override jugadorSeDioDeBaja(Jugador jugador, Partido partido) {
		jugador.agregateInfraccion()
	}
}
