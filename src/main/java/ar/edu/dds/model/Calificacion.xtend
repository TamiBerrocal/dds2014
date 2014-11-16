package ar.edu.dds.model

import org.apache.commons.lang3.builder.ToStringBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.joda.time.DateTime
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.CascadeType
import org.hibernate.annotations.Type

@Entity
class Calificacion {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@Column
	@Property
	int nota
	
	@Column
	@Property
	String comentario
	
	@ManyToOne(cascade = CascadeType.PERSIST)
	@Property
	Jugador autor
	
	@ManyToOne(cascade = CascadeType.PERSIST)
	@Property
	Partido partido
	
	@Column
	@Type (type = "date")
	@Property
	DateTime fechaDeCarga
	
	def boolean esLaMismaQue(Calificacion calificacion) {
		calificacion.autor.equals(this.autor) && calificacion.partido.equals(this.partido)
	}
	
	new() {
		this.fechaDeCarga = new DateTime
	}
	
	new(int nota, String comentario, Jugador autor, Partido partido) {
		this.nota = nota
		this.comentario = comentario
		this.autor = autor
		this.partido = partido
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