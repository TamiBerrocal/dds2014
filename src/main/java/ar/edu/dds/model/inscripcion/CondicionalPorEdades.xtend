package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.PrioridadInscripcion
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue

@Entity
//@DiscriminatorValue ("Por Edad")
class CondicionalPorEdades extends ModoDeInscripcion {

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
		partido.getJugadores.filter[integrante | integrante.edad <= edadHasta].size
	}

	new(){
		
	}
}
