package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.Partido

class PorLugar implements Condicion {
	
	private String lugar;
	
	override esSatisfechaPor(Partido partido) {
		lugar.equals(partido.lugar)
	}
	
}