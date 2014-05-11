package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.PartidoImpl

interface Condicion {
	
	def boolean esSatisfechaPor(PartidoImpl partido)
}