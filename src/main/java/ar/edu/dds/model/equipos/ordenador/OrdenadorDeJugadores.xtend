package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador
import java.math.BigDecimal

abstract class OrdenadorDeJugadores {
	
	def ordenar(List<Jugador> jugadores) {
		jugadores.sortBy[ j | valuar(j)  ]
	}
	
	def BigDecimal valuar(Jugador jugador)
}