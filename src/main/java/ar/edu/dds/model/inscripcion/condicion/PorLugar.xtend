package ar.edu.dds.model.inscripcion.condicion

import ar.edu.dds.model.PartidoImpl

class PorLugar implements Condicion {
	
	new(String lugar) {
		this.lugar = lugar
	}
	
	private String lugar;
	
	override esSatisfechaPor(PartidoImpl partido) {
		lugar.equals(partido.lugar)
	}
	
}