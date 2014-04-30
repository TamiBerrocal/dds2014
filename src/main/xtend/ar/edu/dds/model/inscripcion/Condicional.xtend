package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.condicion.Condicion

class Condicional implements ModoDeInscripcion {
	
	new(Condicion condicion) {
		this.condicion = condicion
	}
	
	@Property
	private Condicion condicion
	
	override leSirveElPartido(Partido partido) {
		condicion.esSatisfechaPor(partido)
	}
	
	override prioridad(int prioridadBase) {
		prioridadBase
	}
	
}