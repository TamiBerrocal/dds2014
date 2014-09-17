package ar.edu.dds.model.equipos

import ar.edu.dds.model.Jugador
import java.util.List
import java.util.ArrayList
import org.uqbar.commons.utils.Observable

@Observable
class ParDeEquipos {
	
	@Property
	List<Jugador> equipo1
	
	@Property
	List<Jugador> equipo2
	
	new() {
		this.equipo1 = new ArrayList
		this.equipo2 = new ArrayList
	}
	
	new(List<Jugador> equipo1, List<Jugador> equipo2) {
		this.equipo1 = equipo1
		this.equipo2 = equipo2
	}
	
	def boolean estanOk() {
		equipo1.size == 5 && equipo2.size == 5
	}
}