package ar.edu.dds.model

import org.joda.time.LocalDate

class Rechazo {
	
	@Property
	Jugador jugador
	
	@Property
	String motivoDeRechazo
	
	@Property
	LocalDate fechaDeRechazo
	
	Object LocalDate
	
	new(Jugador jugador, String motivoDeRechazo) {
		this.jugador = jugador
		this.motivoDeRechazo = motivoDeRechazo
		this.fechaDeRechazo = LocalDate.now
	}
	
	def getNow(Object object) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}