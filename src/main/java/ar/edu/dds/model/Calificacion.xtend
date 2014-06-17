package ar.edu.dds.model

import org.apache.commons.lang3.builder.ToStringBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.joda.time.DateTime

class Calificacion {
	
	@Property
	int nota
	
	@Property
	String comentario
	
	@Property
	Jugador autor
	
	@Property
	Partido partido
	
	@Property
	DateTime fechaDeCarga
	
	def boolean esLaMismaQue(Calificacion calificacion) {
		calificacion.autor.equals(this.autor) && calificacion.partido.equals(this.partido)
	}
	
	new() {
		this.fechaDeCarga = new DateTime
	}
	
	// ------ HASHCODE - EQUALS - TOSTRING ------- //
	override hashCode() {
		HashCodeBuilder.reflectionHashCode(this, "fechaDeCarga")
	}

	override equals(Object obj) {
		EqualsBuilder.reflectionEquals(obj, this, "fechaDeCarga")
	}
	
	override toString() {
		ToStringBuilder.reflectionToString(this)
	}
	
}