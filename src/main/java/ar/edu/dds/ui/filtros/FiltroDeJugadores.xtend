package ar.edu.dds.ui.filtros

import ar.edu.dds.model.Jugador

interface FiltroDeJugadores {
	
	def boolean aplica(Jugador j) 
	
	def String nombre()
}