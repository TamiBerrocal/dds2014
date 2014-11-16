package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column

@Observable
@Entity
class OrdenadorCompuesto extends OrdenadorPorPromedio {
	
	@Column
	@Property String nombre = "Promedio de todos los anteriores"
	
	@Property
	List<OrdenadorDeJugadores> ordenadoresDeJugadores
	
	new(List<OrdenadorDeJugadores> ordenadoresDeJugadores) {
		this.ordenadoresDeJugadores = ordenadoresDeJugadores
	}
	
	override valuar(Jugador jugador) {
		ordenadoresDeJugadores.promedio(jugador)
	}
	
	override conNUltimas() {
		ordenadoresDeJugadores.exists[ o | o.conNUltimas ]
	}
	
}