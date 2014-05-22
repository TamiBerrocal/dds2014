package ar.edu.dds.model

import org.joda.time.LocalDate

class Rechazo {
	
	@Property
	Jugador jugador
	
	@Property
	String motivoDeRechazo
	
	@Property
	LocalDate fechaDeRechazo
	
	new(Jugador jugador, String motivoDeRechazo) {
		this.jugador = jugador
		this.motivoDeRechazo = motivoDeRechazo
		this.fechaDeRechazo = LocalDate.now
	}
	
}