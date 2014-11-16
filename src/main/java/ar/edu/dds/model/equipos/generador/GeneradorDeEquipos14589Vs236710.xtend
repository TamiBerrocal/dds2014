package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import java.util.Arrays
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column

@Observable
@Entity
class GeneradorDeEquipos14589Vs236710 extends GeneradorDeEquipos {

	@Column
	@Property String nombre = "14589 Vs. 236710"
	val posicionesEquipo1 = Arrays.asList(1,4,5,8,9)
	
	override boolean cumpleParaEquipo1(Jugador j, List<Jugador> jugadores) {
		posicionesEquipo1.contains(jugadores.indexOf(j) + 1)
	}
	
	
	
}