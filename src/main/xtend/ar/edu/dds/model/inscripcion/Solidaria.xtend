package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Solidaria implements ModoDeInscripcion {
	
	override leSirveElPartido(Partido partido) {
		true
	}
	
}