package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.ToStringBuilder

abstract class ModoDeInscripcion {
	
	@Property PrioridadInscripcion prioridadInscripcion
	
	def boolean leSirveElPartido(Partido partido)
	
	
	// ------ HASHCODE - EQUALS - TOSTRING ------- //
	override hashCode() {
		HashCodeBuilder.reflectionHashCode(this)
	}

	override equals(Object obj) {
		EqualsBuilder.reflectionEquals(obj, this)
	}
	
	override toString() {
		ToStringBuilder.reflectionToString(this)
	}
	
}