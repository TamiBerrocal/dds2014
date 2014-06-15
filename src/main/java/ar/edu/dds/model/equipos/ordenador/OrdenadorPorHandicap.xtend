package ar.edu.dds.model.equipos.ordenador

import ar.edu.dds.model.Jugador
import java.math.BigDecimal

class OrdenadorPorHandicap extends OrdenadorDeJugadores {
	
	override BigDecimal valuar(Jugador jugador) {
		BigDecimal.valueOf(jugador.handicap)
	}
	
	
	
}