package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@Inheritance (strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn (name = "tipo")
abstract class InscripcionDeJugadorObserver {
	
	@Id
	@GeneratedValue
	@Property long id
	
	def void jugadorInscripto(Jugador jugador, Partido partido)
}