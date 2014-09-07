package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class OrdenadorCompuesto extends OrdenadorPorPromedio {
	
	@Property String nombre = "Promedio Mixto"
	@Property
	List<OrdenadorDeJugadores> ordenadoresDeJugadores
	
	new(List<OrdenadorDeJugadores> ordenadoresDeJugadores) {
		this.ordenadoresDeJugadores = ordenadoresDeJugadores
	}
	
	override valuar(Jugador jugador) {
		ordenadoresDeJugadores.promedio(jugador)
	}
	
}