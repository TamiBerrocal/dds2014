package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail

class NotificarAmigosObserver implements InscripcionDeJugadorObserver {

	@Property 
	MailSender mailSender

	new(MailSender mailSender) {
		this.mailSender = mailSender
	}

	override jugadorInscripto(Jugador jugador, Partido partido) {

		val amigos = jugador.amigos
		
		amigos.forEach [ amigo |
			val mail = new Mail
			mail.from = partido.mailOficial
			mail.asunto = "Se inscribio al partido un amigo!"
			mail.mensaje = "Se inscribio al partido" + jugador.nombre
			mail.to = amigo.mail
			
			this.mailSender.mandarMail(mail)
		]
	}
}
