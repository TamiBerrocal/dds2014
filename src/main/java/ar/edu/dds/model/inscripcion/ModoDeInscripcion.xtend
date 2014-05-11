package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

abstract class ModoDeInscripcion {
	
	@Property PrioridadInscripcion prioridadInscripcion
	
	def boolean leSirveElPartido(Partido partido)
	
}