package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.PartidoImpl

public interface ModoDeInscripcion {
	def boolean leSirveElPartido(PartidoImpl partido)
	def Integer prioridad(int prioridadBase)
}