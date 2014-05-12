package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail

class NotificarAmigosObserver implements InscripcionDeJugadorObserver {

	@Property MailSender mailSender

	new() {
	}

	override jugadorInscripto(Jugador jugador, Partido partido) {

		this.mailSender = partido.mailSender

		var amigos = jugador.amigos
		
		amigos.forEach [ amigo |
			var mail = new Mail
			mail.from = partido.mailOficial
			mail.asunto = "Se inscribio al partido un amigo!"
			mail.mensaje = "Se inscribio al partido" + jugador.nombre
			mail.to = amigo.mail
			mailSender.mandarMail(mail)
		]
	}
}
