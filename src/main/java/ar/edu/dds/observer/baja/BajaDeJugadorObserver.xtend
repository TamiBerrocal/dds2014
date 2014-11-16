package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partidoimport javax.persistence.Inheritance
import javax.persistence.DiscriminatorColumn
import javax.persistence.InheritanceType
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Entity

@Entity
@Inheritance ( strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn (name = "tipo")
abstract class BajaDeJugadorObserver {
	
	@Id
	@GeneratedValue
	@Property long id
	
	def void jugadorSeDioDeBaja(Jugador jugador, Partido partido)
}
