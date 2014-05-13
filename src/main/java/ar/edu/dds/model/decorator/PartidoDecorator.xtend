package ar.edu.dds.model.decorator

import ar.edu.dds.model.Partido
import ar.edu.dds.model.PartidoImpl
import ar.edu.dds.model.Jugador

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

	override mailSender() {
		this.decorado.mailSender
	}

}
