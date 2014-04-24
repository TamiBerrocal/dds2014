package ar.edu.dds.model.inscripcion

import ar.edu.dds.exception.PartidoNoSatisfaceLasCondicionesException
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido

class Condicional extends ModoDeInscripcion {
	
	@Property
	private Condicion condicion
	
	override inscribir(Jugador jugador, Partido partido) {
		if (condicion.puedeInscribirseA(partido)) {
			partido.agregarJugador(jugador)
		} else {
			throw new PartidoNoSatisfaceLasCondicionesException("El partido no satisface las condiciones impuestas por el jugador...")
		}
	}
	
}