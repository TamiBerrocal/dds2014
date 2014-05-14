package ar.edu.dds.model.decorator

import ar.edu.dds.model.Partido
import ar.edu.dds.model.PartidoImpl
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.mail.MailSender

abstract class PartidoDecorator implements Partido {

	@Property Partido decorado

	new(Partido partido) {
		this.decorado = partido
	}

	override PartidoImpl partido() {
		this.decorado.partido
	}

	override agregarJugador(Jugador jugador) {
		this.decorado.agregarJugador(jugador)
	}

	override quitarJugador(Jugador jugador) {
		this.decorado.quitarJugador(jugador)
	}
	
	override reemplazarJugador(Jugador jugador, Jugador reemplazo){
		this.decorado.reemplazarJugador(jugador,reemplazo)	
		
	}
	override MailSender mailSender() {
		this.decorado.mailSender
	}

}
