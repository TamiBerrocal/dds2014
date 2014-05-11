package ar.edu.dds.model.decorator

import ar.edu.dds.model.Partido
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.PartidoImpl
import ar.edu.dds.model.mail.Mail

class YaHay10EnElPartidoDecorator implements Partido {
	
	private Partido decorado
	
	private static final String DE = "grupo1_2014@dds.com"
	private static final String ASUNTO = "Partido listo para confirmar"
	private static final String CUERPO = "El partido ya tiene 10 jugadores en condiciones de jugarlo"
	
	new(Partido decorado) {
		this.decorado = decorado
	}
	
	override PartidoImpl partido() {
		this.decorado.partido
	}
	
	override agregarJugador(Jugador jugador) {
		this.decorado.agregarJugador(jugador)
		
		// Si después de agregar al jugador tengo 10 jugadores a los que les sirve el partido, notifico al admin
		if (this.partido.jugadoresInscriptos.filter[ j | j.leSirveElPartido(this.partido)].size.equals(10)) {
			val mail = new Mail
			mail.setDe(DE)
			mail.setPara(this.partido.admin.email)
			mail.setAsunto(ASUNTO)
			mail.setCuerpo(CUERPO)			
			mailSender.enviar(mail)
		}
	}
	
	override quitarJugador(Jugador jugador) {
		this.decorado.quitarJugador(jugador)
	}
	
	override mailSender() {
		decorado.mailSender
	}
	
}