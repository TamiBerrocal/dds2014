package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.ToStringBuilder
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity
import javax.persistence.Enumerated
import javax.persistence.EnumType
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.GenerationType
import javax.persistence.Column

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
abstract class ModoDeInscripcion{
	
	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	@Property long id
	
	@Column
	@Enumerated(EnumType.ORDINAL)
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
	
	new(){
		
	}
	
}