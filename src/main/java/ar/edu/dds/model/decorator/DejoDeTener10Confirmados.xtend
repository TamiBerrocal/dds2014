package ar.edu.dds.model.decorator

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.mail.Mail

class DejoDeTener10Confirmados extends PartidoDecorator {

	private static final String DE = "grupo1_2014@dds.com"
	private static final String ASUNTO = "Partido incompleto"
	private static final String CUERPO = "El partido dejo de tener 10 confirmados"

	new(Partido decorado) {
		super(decorado)
	}

	override quitarJugador(Jugador jugador) {
		
		val jugadorConSuPrioridadADarDeBaja = this.partido.quitarJugador(jugador)

		//Si despues de quitar un jugador no quedan los 10 confirmados, que le sirve el partido,
		//se le notifica al admin
		if (this.partido.jugadoresInscriptos.filter[j|j.leSirveElPartido(this.partido)].size.equals(9)) {
			val mail = new Mail
			mail.setDe(DE)
			mail.setPara(partido.admin.email)
			mail.setAsunto(ASUNTO)
			mail.setCuerpo(CUERPO)
			mailSender.enviar(mail)

		}

		jugadorConSuPrioridadADarDeBaja

	}

}
