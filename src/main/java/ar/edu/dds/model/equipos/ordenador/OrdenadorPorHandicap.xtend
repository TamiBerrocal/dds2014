package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador
import java.math.BigDecimal
import org.uqbar.commons.utils.Observable
import javax.persistence.Entity
import javax.persistence.Column

@Observable
@Entity
class OrdenadorPorHandicap extends OrdenadorDeJugadores {
	
	@Column
	@Property String nombre = "Promedio por Handicap"

	override BigDecimal valuar(Jugador jugador) {
		BigDecimal.valueOf(jugador.handicap)
	}

}
