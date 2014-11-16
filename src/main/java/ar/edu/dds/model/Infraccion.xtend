package ar.edu.dds.model
import org.joda.time.LocalDate
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.ToStringBuilder
import org.joda.time.LocalTimeimport org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.hibernate.annotations.Type

@Observable
@Entity
class Infraccion {

	@Id
	@GeneratedValue
	@Property long id

	@Column
	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentLocalDate")
	@Property
	LocalDate fechaCreacion
	
	@Column
	@Property
	String hora
	
	@Column
	@Type (type = "org.jadira.usertype.dateandtime.joda.PersistentLocalDate")
	@Property
	LocalDate validaHasta

	@Column
	@Property
	String causa
	
	public static final String PATTERN = "HH:mm"
	
	new() {
		val hora = new LocalTime
		this.fechaCreacion = new LocalDate
		this.hora = hora.toString(PATTERN)
	}

	//Si bien todavía no es un requerimiento que debamos atender, acá tendríamos un método como el siguiente
	def void penalizarJugador(Jugador jugador, Partido partido) {
		partido.darDeBajaJugador(jugador)
	}
	
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
