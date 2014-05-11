package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.PartidoImpl

class Estandar implements ModoDeInscripcion {
	
	override leSirveElPartido(PartidoImpl partido) {
		true
	}
	
	override prioridad(int prioridadBase) {
		10000 + prioridadBase
	}
	
}