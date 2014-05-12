package ar.edu.dds.model.decorator

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.PartidoImpl
import ar.edu.dds.model.mail.Mail

class AvisarAmigosDeInscripcion implements Partido {

	private Partido decorado

	new(Partido decorado) {
		this.decorado = decorado
	}

	override PartidoImpl partido() {
		this.decorado.partido
	}

	override agregarJugador(Jugador jugador) {

		this.decorado.agregarJugador(jugador)

		//notifica a sus amigos que se agrego al partido
		val mail = new Mail
		mail.setDe(jugador.email)
		mail.setPara(jugador.amigos.map[a|a.email].join(","))
		mail.setAsunto("Nueva Inscripcion")
		mail.setCuerpo(
			"Me he inscripto al partido " + decorado.partido.lugar + " en la fecha " + decorado.partido.fechaYHora)
		mailSender.enviar(mail)

	}

	override quitarJugador(Jugador jugador) {
		this.decorado.quitarJugador(jugador)
	}

	override mailSender() {
		this.decorado.mailSender
	}

}
