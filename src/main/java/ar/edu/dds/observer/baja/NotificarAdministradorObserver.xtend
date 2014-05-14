package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail

class NotificarAdministradorObserver implements BajaDeJugadorObserver {

	@Property 
	MailSender mailSender

	new() {
	}

	override jugadorSeDioDeBaja(Jugador jugador, Partido partido) {

		this.mailSender = partido.mailSender
		var administrador = partido.administrador
		var mail = new Mail

		if (partido.cantidadJugadoresEnLista.equals(9)) { //si son menos o mas no se notifica al admin

			mail.from = partido.mailOficial
			mail.asunto = "Se ha dado de baja un jugador"
			mail.mensaje = "El jugador" + jugador.nombre + "se ha dado de baja del partido sin dejar reemplazante."
			mail.to = administrador.mail
			mailSender.mandarMail(mail)
		}
	}
}

