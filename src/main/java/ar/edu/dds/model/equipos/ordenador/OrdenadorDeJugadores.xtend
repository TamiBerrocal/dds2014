package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador
import java.math.BigDecimal
import org.uqbar.commons.utils.Observable

@Observable
abstract class OrdenadorDeJugadores {
	
	@Property String nombre
	
	new(){}
	
	def ordenar(List<Jugador> jugadores) {
		jugadores.sortBy[ j | valuar(j)  ]
	}
	
	def BigDecimal valuar(Jugador jugador)
	
	def boolean conNUltimas() {
		false
	}
	
}