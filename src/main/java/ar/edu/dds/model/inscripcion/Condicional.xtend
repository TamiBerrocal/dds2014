package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.inscripcion.condicion.Condicion
import ar.edu.dds.model.PartidoImpl

class Condicional implements ModoDeInscripcion {
	
	new(Condicion condicion) {
		this.condicion = condicion
	}
	
	@Property
	private Condicion condicion
	
	override leSirveElPartido(PartidoImpl partido) {
		condicion.esSatisfechaPor(partido)
	}
	
	override prioridad(int prioridadBase) {
		prioridadBase
	}
	
}