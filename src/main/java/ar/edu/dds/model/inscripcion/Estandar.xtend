package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Estandar extends ModoDeInscripcion {

//	@Property PrioridadInscripcion prioridadInscripcion
	
//	override getPrioridadInscripcion(){
//		return prioridadInscripcion
//	}

	new() {
		this.prioridadInscripcion = PrioridadInscripcion.ESTANDAR
	}

	override leSirveElPartido(Partido partido) {
		true
	}

}
