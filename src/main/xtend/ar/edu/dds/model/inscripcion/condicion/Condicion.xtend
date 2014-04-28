package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.Partido

interface Condicion {
	
	def boolean puedeInscribirseA(Partido partido)
}