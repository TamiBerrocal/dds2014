package ar.edu.dds.model.equipos.ordenador

import java.math.BigDecimal
import java.util.List
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.Jugador

abstract class OrdenadorPorPromedio extends OrdenadorDeJugadores {
	
	def BigDecimal promedio(List<Calificacion> calificaciones) {
		val total = calificaciones.fold(BigDecimal.ZERO, [ res, cal | res.add(BigDecimal.valueOf(cal.nota))])
		total.divide(BigDecimal.valueOf(calificaciones.size))
	}
	
	def BigDecimal promedio(List<OrdenadorDeJugadores> ordenadores, Jugador jugador) {
		val total = ordenadores.fold(BigDecimal.ZERO, [ res, ord | res.add(ord.valuar(jugador))])
		total.divide(BigDecimal.valueOf(ordenadores.size))
	}
	
}