package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.Partido

class PorLugar implements Condicion {
	
	new(String lugar) {
		this.lugar = lugar
	}
	
	private String lugar;
	
	override esSatisfechaPor(Partido partido) {
		lugar.equals(partido.lugar)
	}
	
}