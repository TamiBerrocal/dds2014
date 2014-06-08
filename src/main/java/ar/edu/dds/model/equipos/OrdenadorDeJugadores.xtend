package ar.edu.dds.model.equipos

import java.util.List
import ar.edu.dds.model.Jugador

interface OrdenadorDeJugadores {
	
	def void ordenar(List<Jugador> jugadores)
}