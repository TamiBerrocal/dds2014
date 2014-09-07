package ar.edu.dds.model.equipos.ordenador

import java.math.BigDecimal
import java.util.List
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.Jugador
import org.uqbar.commons.utils.Observable

@Observable
abstract class OrdenadorPorPromedio extends OrdenadorDeJugadores {
	
	@Property String nombre
	def BigDecimal promedio(List<Calificacion> calificaciones) {
		calcularPromedio(calificaciones.map[ c | BigDecimal.valueOf(c.nota) ])
	}
	
	def BigDecimal promedio(List<OrdenadorDeJugadores> ordenadores, Jugador jugador) {
		calcularPromedio(ordenadores.map[ o | o.valuar(jugador)] )
	}
	
	private def BigDecimal calcularPromedio(List<BigDecimal> numeros) {
		val cant = numeros.size
		if (cant == 0) return BigDecimal.ZERO
		
		numeros.fold(BigDecimal.ZERO, [ sem, num | sem.add(num) ]).divide(BigDecimal.valueOf(cant))
	}
	
}