package ar.edu.dds.model

import ar.edu.dds.model.mail.MailSender

interface Partido {

	def PartidoImpl partido()
	def void agregarJugador(Jugador jugador)
	def Pair<Jugador, Integer> quitarJugador(Jugador jugador)
	def MailSender mailSender()

}