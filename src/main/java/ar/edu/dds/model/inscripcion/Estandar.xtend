package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Estandar extends ModoDeInscripcion {

	new() {
		this.prioridadInscripcion = PrioridadInscripcion.ESTANDAR
	}

	override leSirveElPartido(Partido partido) {
		true
	}

}
