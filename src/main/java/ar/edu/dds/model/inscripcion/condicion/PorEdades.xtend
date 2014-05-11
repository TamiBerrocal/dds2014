package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.Condicional
import ar.edu.dds.model.inscripcion.PrioridadInscripcion

class PorEdades extends Condicional {

	private int edadHasta
	private int cantidad

	new(int edadHasta, int cantidad) {
		this.edadHasta = edadHasta
		this.cantidad = cantidad
		this.prioridadInscripcion = PrioridadInscripcion.CONDICIONAL

	}

	override leSirveElPartido(Partido partido) {
		return (this.cantidadDeJovenes(partido) <= cantidad)
	}

	def cantidadDeJovenes(Partido partido) {
		partido.jugadores.filter[integrante|integrante.edad <= edadHasta].size
	}

}
