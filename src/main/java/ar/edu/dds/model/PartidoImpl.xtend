package ar.edu.dds.model

import java.util.ArrayList
import org.joda.time.DateTime
import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import java.util.List
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import org.apache.commons.lang3.builder.ToStringBuilder
import ar.edu.dds.model.mail.MailSender
import static org.mockito.Mockito.*

class PartidoImpl implements Partido {

	/**
	 * Lista de jugadores inscriptos con sus respectivas prioridades por orden
	 */
	private List<Pair<Jugador, Integer>> jugadoresConSusPrioridadesSegunOrden

	@Property
	private DateTime fechaYHora

	@Property
	private String lugar

	@Property
	private Admin admin

	@Property
	private EstadoDePartido estadoDePartido
	
	private MailSender mailSender

	private Integer prioridadAAsignarPorOrden = 0

	new(DateTime fechaYHora, String lugar, Admin admin) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.jugadoresConSusPrioridadesSegunOrden = new ArrayList
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
		this.admin = admin
		this.mailSender = mock(typeof(MailSender))
	}

	def confirmar() {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible confirmar partido con estado: ")

		this.removerALosQueNoJugarian

		// Me quedo con los 10 Jugadores con más prioridad
		this.jugadoresConSusPrioridadesSegunOrden = this.jugadoresConSusPrioridadesSegunOrden.sortBy[j|
			-j.key.prioridad(j.value)].take(10).toList

		val int size = this.jugadoresInscriptos.size
		if (size.equals(10)) {
			this.estadoDePartido = EstadoDePartido.CONFIRMADO
		} else {
			throw new NoHaySuficientesJugadoresException("Solamente confirmaron " + size + "jugadores...")
		}

		// Retorna la lista con los 10 jugadores confirmados
		jugadoresInscriptos
	}

	def List<Jugador> jugadoresInscriptos() {
		this.jugadoresConSusPrioridadesSegunOrden.map[par|par.key]
	}

	override void agregarJugador(Jugador jugador) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION,
			"Imposible agregar jugadores a un partido con estado: ")
		jugadoresConSusPrioridadesSegunOrden.add(new Pair(jugador, this.prioridadAAsignarPorOrden))
		prioridadAAsignarPorOrden = prioridadAAsignarPorOrden - 10
	}

	def void reemplazarJugador(Jugador jugador, Jugador reemplazo) {
		val jugadorConSuPrioridadAReemplazar = quitarJugador(jugador)
		this.jugadoresConSusPrioridadesSegunOrden.add(
			new Pair<Jugador, Integer>(reemplazo, jugadorConSuPrioridadAReemplazar.value))
	}

	def void darDeBajaJugador(Jugador jugador) {
		this.quitarJugador(jugador)

	// PENALIZAR
	}

	override PartidoImpl partido() {
		this
	}

	override Pair<Jugador, Integer> quitarJugador(Jugador jugador) {
		val jugadorConSuPrioridadADarDeBaja = this.jugadoresConSusPrioridadesSegunOrden.findFirst[par|
			par.key.equals(jugador)]
		this.jugadoresConSusPrioridadesSegunOrden.remove(jugadorConSuPrioridadADarDeBaja)
		jugadorConSuPrioridadADarDeBaja
	}

	private def void removerALosQueNoJugarian() {
		jugadoresConSusPrioridadesSegunOrden = jugadoresConSusPrioridadesSegunOrden.filter[j|
			j.key.leSirveElPartido(this)].toList
	}

	private def validarEstadoDePartido(EstadoDePartido estadoEsperado, String error) {
		if (!estadoEsperado.equals(this.estadoDePartido)) {
			throw new EstadoDePartidoInvalidoException(error + this.estadoDePartido)
		}
	}

	override MailSender mailSender() {
		this.mailSender
	}

	override toString() {
		ToStringBuilder.reflectionToString(this)
	}

}
