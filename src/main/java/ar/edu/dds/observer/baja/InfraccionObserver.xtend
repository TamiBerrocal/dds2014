package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partidoimport javax.persistence.Entity
/*import javax.persistence.Inheritance
import javax.persistence.InheritanceType*/
import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue ("Infraccion")
class InfraccionObserver extends BajaDeJugadorObserver {
	
	override jugadorSeDioDeBaja(Jugador jugador, Partido partido) {
		jugador.agregateInfraccion()
	}
}
