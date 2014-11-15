package ar.edu.dds.model

import org.joda.time.LocalDate
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.hibernate.annotations.Type
import javax.persistence.Entity

@Entity
class Rechazo {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@Column
	@Property
	Jugador jugador
	
	@Column
	@Property
	String motivoDeRechazo
	
	@Column
	@Type (type = "date")
	@Property
	LocalDate fechaDeRechazo
	
	new (Jugador jugador, String motivoDeRechazo) {
		this.jugador = jugador
		this.motivoDeRechazo = motivoDeRechazo
		this.fechaDeRechazo = new LocalDate
	}

}