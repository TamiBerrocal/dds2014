package ar.edu.dds.home

import org.joda.time.LocalDate
import ar.edu.dds.ui.filtros.FiltroDeJugadores
import org.uqbar.commons.utils.Observable
import ar.edu.dds.ui.filtros.TodosLosJugadores

@Observable
class BusquedaDeJugadores {
	
	@Property String nombreJugador
	@Property String apodoJugador
	@Property LocalDate fechaNacJugador
	@Property Integer minHandicapJugador
	@Property Integer maxHandicapJugador
	@Property Integer minPromedioJugador
	@Property Integer maxPromedioJugador
	@Property FiltroDeJugadores filtroDeInfracciones
	
	new() {
		filtroDeInfracciones = new TodosLosJugadores()
		nombreJugador = ""
		apodoJugador = ""
	}
}