package ar.edu.dds.model

import ar.edu.dds.model.mail.MailSender

interface Partido {

	def PartidoImpl partido()
	def void agregarJugador(Jugador jugador)
	def Pair<Jugador, Integer> quitarJugador(Jugador jugador)
	def void reemplazarJugador(Jugador jugador, Jugador reemplazo)
	def void darDeBajaJugador(Jugador jugador)
	def MailSender mailSender()

}