package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador
import java.math.BigDecimal
import org.uqbar.commons.utils.Observable

@Observable
class OrdenadorPorHandicap extends OrdenadorDeJugadores {
	
	@Property String nombre = "Promedio por Handicap"

	override BigDecimal valuar(Jugador jugador) {
		BigDecimal.valueOf(jugador.handicap)
	}

}
