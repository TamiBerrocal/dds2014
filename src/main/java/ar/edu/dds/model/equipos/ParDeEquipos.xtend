package ar.edu.dds.model.equipos

import ar.edu.dds.model.Jugador
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.hibernate.annotations.LazyCollection
import org.hibernate.annotations.LazyCollectionOption
import org.uqbar.commons.utils.Observable
import javax.persistence.OneToMany

@Observable
@Entity
class ParDeEquipos {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@OneToMany(cascade = CascadeType.ALL)
	@LazyCollection(LazyCollectionOption.FALSE)
	@Property List<JugadorEnEquipo> jugadores
	
	new() {
		this.jugadores = new ArrayList
	}
	
	// Chanchada para hibernate que no puede mappear dos colecciones del mismo tipo
	new(List<Jugador> equipo1, List<Jugador> equipo2) {
		this.jugadores = new ArrayList
		equipo1.forEach[ j | jugadores.add(new JugadorEnEquipo(j, IndiceDeEquipo.EQUIPO_1)) ]
		equipo2.forEach[ j | jugadores.add(new JugadorEnEquipo(j, IndiceDeEquipo.EQUIPO_2)) ]
	}
	
	def boolean estanOk() {
		//equipo1.size == 5 && equipo2.size == 5
		(equipo1.size != 0) && (equipo2.size != 0)
	}
	
	def List<Jugador> equipo1() {
		jugadores.filter[ j | IndiceDeEquipo.EQUIPO_1 == j.equipo ].map[ j | j.jugador ].toList
	}
	
	def List<Jugador> equipo2() {
		jugadores.filter[ j | IndiceDeEquipo.EQUIPO_2 == j.equipo ].map[ j | j.jugador ].toList
	} 
}