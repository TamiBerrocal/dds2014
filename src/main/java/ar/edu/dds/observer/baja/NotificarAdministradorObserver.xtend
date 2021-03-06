package ar.edu.dds.observer.baja

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender
import ar.edu.dds.model.Mail
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue
import javax.persistence.Column
import org.hibernate.annotations.Type

@Entity
@DiscriminatorValue ("NotificarAdmin")
class NotificarAdministradorObserver extends BajaDeJugadorObserver {
	
	@Column 
	@Type (type = "string")
	@Property 
	MailSender mailSender

	new(MailSender mailSender) {
		this.mailSender = mailSender
	}

	override jugadorSeDioDeBaja(Jugador jugador, Partido partido) {

		val administrador = partido.administrador
		val mail = new Mail

		if (partido.cantidadJugadoresEnLista.equals(9)) { //si son menos o mas no se notifica al admin

			mail.from = partido.mailOficial
			mail.asunto = "Se ha dado de baja un jugador"
			mail.mensaje = "El jugador" + jugador.nombre + "se ha dado de baja del partido sin dejar reemplazante."
			mail.to = administrador.mail
			mailSender.mandarMail(mail)
		}
	}
}

