package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.PartidoImpl

class Solidaria implements ModoDeInscripcion {
	
	override leSirveElPartido(PartidoImpl partido) {
		true
	}
	
	override prioridad(int prioridadBase) {
		5000 - prioridadBase
	}
	
}