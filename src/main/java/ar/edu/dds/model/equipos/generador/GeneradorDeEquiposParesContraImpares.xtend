package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class GeneradorDeEquiposParesContraImpares extends GeneradorDeEquipos {
	
	@Property String nombre = "Pares contra Impares"
	
	override boolean cumpleParaEquipo1(Jugador j, List<Jugador> jugadores) {
		(jugadores.indexOf(j) + 1) % 2 == 0
	}
	
}