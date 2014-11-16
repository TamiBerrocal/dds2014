package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import javax.persistence.Column
import org.hibernate.annotations.Type

@Entity
@DiscriminatorValue ("NotificarAmigos")
class NotificarAmigosObserver extends InscripcionDeJugadorObserver {

	@Column 
	@Type (type = "string")
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
