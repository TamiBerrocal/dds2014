package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail

class HayDiezJugadoresObserver implements InscripcionDeJugadorObserver {

	@Property 
	MailSender mailSender

	new() {	
		
	}

	override jugadorInscripto(Jugador jugador, Partido partido) {

		var admin = partido.administrador

		this.mailSender = partido.mailSender

		if (partido.cantidadJugadoresEnLista.equals(10)) {
			var mail = new Mail
			mail.asunto = "Jugadores suficientes"
			mail.from = partido.mailOficial
			mail.to = admin.mail
			mail.mensaje = "El partido ya alcanzo los 10 jugadores inscriptos"
			mailSender.mandarMail(mail)
		}
	}

}
