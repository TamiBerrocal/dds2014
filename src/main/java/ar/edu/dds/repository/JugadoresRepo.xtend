package ar.edu.dds.repository

import java.util.List
import ar.edu.dds.model.Jugador
import ar.edu.dds.ui.applicationmodel.BusquedaDeJugadores

interface JugadoresRepo {
	
	def List<Jugador> buscarPorNombre(String s)
	def List<Jugador> busquedaCompleta(BusquedaDeJugadores busqueda)
	def List<Jugador> buscarPorApodo(String string)
	def void aprobarJugador(Jugador jugador)
	def void actualizarJugador(Jugador jugador)
	def void rechazarJugador(Jugador jugador, String motivoDeRechazo)
}