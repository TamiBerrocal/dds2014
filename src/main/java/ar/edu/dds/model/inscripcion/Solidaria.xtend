package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Solidaria extends ModoDeInscripcion {

//	@Property PrioridadInscripcion prioridadInscripcion
//	
//	override getPrioridadInscripcion(){
//		return prioridadInscripcion
//	}

	new() {
		this.prioridadInscripcion = PrioridadInscripcion.SOLIDARIA
	}

	override leSirveElPartido(Partido partido) {
		true
	}

}
