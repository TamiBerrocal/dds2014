package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.equipos.ParDeEquipos

class GeneradorDeEquiposParesContraImpares implements GeneradorDeEquipos {
	
	override generar(List<Jugador> jugadoresOrdenados) {
		val equipo1 = jugadoresOrdenados.filter[ j | jugadoresOrdenados.indexOf(j) % 2 == 0].toList
		val equipo2 = jugadoresOrdenados.filter[ j | jugadoresOrdenados.indexOf(j) % 2 == 1].toList
		
		new ParDeEquipos(equipo1, equipo2)
	}
	
}