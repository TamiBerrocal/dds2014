package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.MailSender

class NotificarAmigosObserver implements InscripcionDeJugadorObserver{
	
	@Property MailSender mailSender
	
	new(MailSender sender){
		this.mailSender = sender
	}
	
	override jugadorInscripto (Jugador jugador, Partido partido){
		var amigos = jugador.amigos
		mailSender.mandarMailAmigos(amigos)
		}
}