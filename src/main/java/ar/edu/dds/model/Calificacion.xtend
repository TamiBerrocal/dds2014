package ar.edu.dds.model

import org.apache.commons.lang3.builder.ToStringBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder

class Calificacion {
	
	@Property
	int nota
	
	@Property
	String comentario
	
	@Property
	Jugador autor
	
	@Property
	Partido partido
	
	
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