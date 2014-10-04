package ar.edu.dds.home

import org.joda.time.LocalDate
import ar.edu.dds.ui.filtros.FiltroDeJugadores
import java.util.List
import ar.edu.dds.model.Jugador

class Busqueda {
	
	@Property JugadoresHome repositorio = JugadoresHome.instance
	
	@Property String nombreJugador
	@Property String apodoJugador
	@Property LocalDate fechaNacJugador
	@Property Integer minHandicapJugador
	@Property Integer maxHandicapJugador
	@Property Integer minPromedioJugador
	@Property Integer maxPromedioJugador
	@Property FiltroDeJugadores filtroDeInfracciones
	
	def List<Jugador> efectuar(){
		repositorio.busquedaCompleta(this)
	}
		
}