package ar.edu.dds.ui.filtros

import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class TodosLosJugadores implements FiltroDeJugadores {
	
	override aplica(Jugador j) {
		true
	}
	
	override nombre() {
		"Todos los jugadores"
	}
	
}