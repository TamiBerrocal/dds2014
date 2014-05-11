package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.Condicional
import ar.edu.dds.model.inscripcion.PrioridadInscripcion

class PorLugar extends Condicional {
	
	new(String lugar) {
		this.lugar = lugar
		this.prioridadInscripcion = PrioridadInscripcion.CONDICIONAL
	}
	
	private String lugar;
	
	override leSirveElPartido(Partido partido) {
		lugar.equals(partido.lugar)
	}
	
}