package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador

class OrdenadorPorPromedioDeUltimasNCalificaciones extends OrdenadorPorPromedio {
	
	int n
	
	new(int n) {
		this.n = n
	}
	
	override valuar(Jugador jugador) {
		jugador.ultimasNCalificaciones(n).promedio
	}
	
}