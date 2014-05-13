package ar.edu.dds.model.decorator

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.mail.Mail

class AvisarAmigosDeInscripcion extends PartidoDecorator {

	new(Partido decorado) {
		super(decorado)
	}

	override agregarJugador(Jugador jugador) {

		this.decorado.agregarJugador(jugador)

		//notifica a sus amigos que se agrego al partido
		val mail = new Mail
		mail.setDe(jugador.email)
		mail.setPara(jugador.amigos.map[j|j.email].join(","))
		mail.setAsunto("Nueva Inscripcion")
		mail.setCuerpo(
			"Me he inscripto al partido en " + this.partido.lugar + " de la fecha " + this.partido.fechaYHora)
		mailSender.enviar(mail)

	}

}
