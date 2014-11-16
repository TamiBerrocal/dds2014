package ar.edu.dds.model

import org.joda.time.LocalDate
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.hibernate.annotations.Type
import javax.persistence.Entity
import javax.persistence.OneToOne
import javax.persistence.CascadeType

@Entity
class Rechazo {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@OneToOne(cascade = CascadeType.PERSIST)
	@Property
	Jugador jugador
	
	@Column
	@Property
	String motivoDeRechazo
	
	@Column
	@Type (type = "org.jadira.usertype.dateandtime.joda.PersistentLocalDate")
	@Property
	LocalDate fechaDeRechazo
	
	new (Jugador jugador, String motivoDeRechazo) {
		this.jugador = jugador
		this.motivoDeRechazo = motivoDeRechazo
		this.fechaDeRechazo = new LocalDate
	}

}