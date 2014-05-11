package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.inscripcion.condicion.Condicion
import ar.edu.dds.model.PartidoImpl

class PorEdades implements Condicion {
	
	private int edadHasta
	private int cantidad
	
	new(int edadHasta, int cantidad) {
		this.edadHasta = edadHasta
		this.cantidad = cantidad
	}
	
	override esSatisfechaPor(PartidoImpl partido) {
		return (this.cantidadDeJovenes(partido) <= cantidad)
	}
	
	def cantidadDeJovenes(PartidoImpl partido) {
		partido.jugadoresInscriptos.filter[j | j.edad <= edadHasta].size
	}
	
}