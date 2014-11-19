package ar.edu.dds.model.equipos

import ar.edu.dds.model.Jugador
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToOne
import org.uqbar.commons.utils.Observable

@Entity
@Observable
class JugadorEnEquipo {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@OneToOne(cascade = CascadeType.ALL)
	@Property Jugador jugador
	
	@Column
	@Property IndiceDeEquipo equipo
	

	new() {}
	
	new(Jugador j, IndiceDeEquipo e) {
		this.jugador = j
		this.equipo = e
	}
}