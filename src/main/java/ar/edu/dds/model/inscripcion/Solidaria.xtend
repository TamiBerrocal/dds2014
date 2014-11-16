package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue

//import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue("Solidaria")
class Solidaria extends ModoDeInscripcion {

	new() {
		this.prioridadInscripcion = PrioridadInscripcion.SOLIDARIA
	}

	override leSirveElPartido(Partido partido) {
		true
	}

}
