package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador

class OrdenadorPorPromedioDeCalificacionesDelUltimoPartido extends OrdenadorPorPromedio {
	
	override valuar(Jugador jugador) {
		jugador.calificacionesDelUltimoPartido.promedio
	}
	
}