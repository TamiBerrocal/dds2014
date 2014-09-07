package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class OrdenadorPorPromedioDeCalificacionesDelUltimoPartido extends OrdenadorPorPromedio {
	
	@Property String nombre = "Promedio de Ultimo Partido"
	
	override valuar(Jugador jugador) {
		jugador.calificacionesDelUltimoPartido.promedio
	}
	
}