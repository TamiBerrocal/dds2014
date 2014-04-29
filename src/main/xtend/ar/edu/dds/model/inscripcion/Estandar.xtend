package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Estandar implements ModoDeInscripcion {
	
	override leSirveElPartido(Partido partido) {
		true
	}
	
	override prioridad() {
		10000
	}
	
}