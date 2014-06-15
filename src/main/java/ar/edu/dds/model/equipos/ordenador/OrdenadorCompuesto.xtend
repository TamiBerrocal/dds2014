package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador

class OrdenadorCompuesto extends OrdenadorPorPromedio {
	
	@Property
	List<OrdenadorDeJugadores> ordenadoresDeJugadores
	
	new(List<OrdenadorDeJugadores> ordenadoresDeJugadores) {
		this.ordenadoresDeJugadores = ordenadoresDeJugadores
	}
	
	override valuar(Jugador jugador) {
		ordenadoresDeJugadores.promedio(jugador)
	}
	
}