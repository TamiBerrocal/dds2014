package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partidoimport javax.persistence.Entity
import javax.persistence.Inheritance
import javax.persistence.InheritanceType
import javax.persistence.DiscriminatorColumn
import javax.persistence.DiscriminatorValue
import javax.persistence.Id
import javax.persistence.GeneratedValue

@Entity
@DiscriminatorValue ("Infraccion")
class InfraccionObserver extends BajaDeJugadorObserver {
	
	override jugadorSeDioDeBaja(Jugador jugador, Partido partido) {
		jugador.agregateInfraccion()
	}
}
