package ar.edu.dds.observer.inscripcion

import ar.edu.dds.model.Jugador
import java.util.List

interface MailSender {
	def void mandarMailDiezJugadores(Jugador admin)
	def void mandarMailEquipoIncompleto(Jugador admin)
	def void mandarMailAmigos(List<Jugador> amigos)
}