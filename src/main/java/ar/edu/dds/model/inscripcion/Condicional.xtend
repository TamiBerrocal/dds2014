package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.condicion.Condicion

class Condicional extends ModoDeInscripcion {

//	@Property PrioridadInscripcion prioriadInscripcion
	
//	override getPrioridadInscripcion(){
//		return prioridadInscripcion
//	}

	new(Condicion condicion) {
		this.condicion = condicion
		this.prioridadInscripcion = PrioridadInscripcion.CONDICIONAL
	}

	@Property
	private Condicion condicion

	override leSirveElPartido(Partido partido) {
		condicion.esSatisfechaPor(partido)
	}

}
