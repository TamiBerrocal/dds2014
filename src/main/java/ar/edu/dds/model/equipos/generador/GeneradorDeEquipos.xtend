package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.equipos.ParDeEquipos
import org.uqbar.commons.utils.Observable

@Observable
abstract class GeneradorDeEquipos {
	
	@Property String nombre
	
	def generar(List<Jugador> jugadoresOrdenados) {
		val equipo1 = jugadoresOrdenados.filter[ j | j.cumpleParaEquipo1(jugadoresOrdenados)].toList
		val equipo2 = jugadoresOrdenados.filter[ j | !j.cumpleParaEquipo1(jugadoresOrdenados)].toList
		
		new ParDeEquipos(equipo1, equipo2)
	}
	
	def boolean cumpleParaEquipo1(Jugador j, List<Jugador> jugadores)
}