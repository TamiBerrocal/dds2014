package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import java.util.Arrays
import ar.edu.dds.model.equipos.ParDeEquipos

class GeneradorDeEquipos14589Vs236710 implements GeneradorDeEquipos {

	val posicionesEquipo1 = Arrays.asList(1,4,5,8,9)
	val posicionesEquipo2 = Arrays.asList(2,3,6,7,10)
	
	override generar(List<Jugador> jugadoresOrdenados) {
		val equipo1 = jugadoresOrdenados.filter[ j | posicionesEquipo1.contains(jugadoresOrdenados.indexOf(j))].toList
		val equipo2 = jugadoresOrdenados.filter[ j | posicionesEquipo2.contains(jugadoresOrdenados.indexOf(j))].toList
		
		new ParDeEquipos(equipo1, equipo2)
	}
	
}