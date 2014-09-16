package ar.edu.dds.ui.filtros

import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
class SoloConInfracciones implements FiltroDeJugadores {
	
	override aplica(Jugador j) {
		!j.infracciones.nullOrEmpty
	}
	
	override nombre() {
		"Solo con infracciones"
	}
	
}