package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido

public interface ModoDeInscripcion {
	def boolean leSirveElPartido(Partido partido)
	def PrioridadInscripcion getPrioridadInscripcion()
}