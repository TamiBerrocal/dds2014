package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class OrdenadorPorPromedioDeUltimasNCalificaciones extends OrdenadorPorPromedio {
	
	@Property String nombre = "Promedio de Ultimas n Calificaciones"
	int n
	
	new(int n) {
		this.n = n
	}
	
	override valuar(Jugador jugador) {
		jugador.ultimasNCalificaciones(n).promedio
	}
	
}