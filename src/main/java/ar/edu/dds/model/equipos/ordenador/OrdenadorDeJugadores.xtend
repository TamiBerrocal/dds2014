package ar.edu.dds.model.equipos.ordenador

import java.util.List
import ar.edu.dds.model.Jugador
import java.math.BigDecimal
import org.uqbar.commons.utils.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType

@Observable
@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
abstract class OrdenadorDeJugadores {
	
	@Id
	@GeneratedValue
	@Property long Id
	
	@Column
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