package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

class Condicional implements ModoDeInscripcion {
	
	@Property
	private Condicion condicion
	
	override inscribirA(Partido partido) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}