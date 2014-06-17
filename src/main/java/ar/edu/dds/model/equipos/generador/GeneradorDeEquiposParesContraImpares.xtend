package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador

class GeneradorDeEquiposParesContraImpares extends GeneradorDeEquipos {
	
	override boolean cumpleParaEquipo1(Jugador j, List<Jugador> jugadores) {
		(jugadores.indexOf(j) + 1) % 2 == 0
	}
	
}