package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder

class Jugador {
	
	@Property
	private ModoDeInscripcion modoDeInscripcion
	
	@Property
	private String nombre
	
	@Property 
	private int edad
	
	def void inscribirseA(Partido partido) {
		partido.agregarJugador(this)
	}
	
	def boolean leSirveElPartido(Partido partido) {
		modoDeInscripcion.leSirveElPartido(partido)
	}
	
	def Integer prioridad(Integer prioridadBase) {
		prioridadBase + modoDeInscripcion.prioridad
	}
	
	override hashCode() {
		HashCodeBuilder.reflectionHashCode(this)
	}

	override equals(Object obj) {
		EqualsBuilder.reflectionEquals(obj, this)
	}
	
}