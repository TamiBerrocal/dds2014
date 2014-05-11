package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.inscripcion.condicion.Condicion
import ar.edu.dds.model.Partido

class PorEdades implements Condicion {
	
	private int edadHasta
	private int cantidad
	
	new(int edadHasta, int cantidad) {
		this.edadHasta = edadHasta
		this.cantidad = cantidad
	}
	
	override esSatisfechaPor(Partido partido) {
		return (this.cantidadDeJovenes(partido) <= cantidad)
	}
	
	def cantidadDeJovenes(Partido partido) {
		partido.jugadores.filter[ integrante | integrante.edad <= edadHasta].size
	}
	
}