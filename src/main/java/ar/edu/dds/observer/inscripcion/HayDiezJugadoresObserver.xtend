package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.Column
import org.hibernate.annotations.Type

@Entity
@DiscriminatorValue ("DiezJugadores")
class HayDiezJugadoresObserver extends InscripcionDeJugadorObserver {

	@Column 
	@Type (type = "string")
	@Property 
	MailSender mailSender

	new(MailSender mailSender) {	
		this.mailSender = mailSender
	}

	override jugadorInscripto(Jugador jugador, Partido partido) {

		val admin = partido.administrador

		if (partido.cantidadJugadoresEnLista.equals(10)) {
			val mail = new Mail
			mail.asunto = "Jugadores suficientes"
			mail.from = partido.mailOficial
			mail.to = admin.mail
			mail.mensaje = "El partido ya alcanzo los 10 jugadores inscriptos"
			
			mailSender.mandarMail(mail)
		}
	}

}
