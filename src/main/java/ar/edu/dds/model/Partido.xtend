package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.apache.commons.lang3.builder.ToStringBuilder

class Partido {
	
	private static final String MAIL_OFICIAL = "no-reply@of5.com"

	@Property
	List<Jugador> jugadores

	@Property
	DateTime fechaYHora

	@Property
	String lugar

	@Property
	EstadoDePartido estadoDePartido

	@Property
	Admin administrador

	List<InscripcionDeJugadorObserver> inscripcionObservers
	List<BajaDeJugadorObserver> bajaObservers

	new(DateTime fechaYHora, String lugar, Admin administrador) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.administrador = administrador
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
		this.jugadores = new ArrayList
		this.inscripcionObservers = new ArrayList
		this.bajaObservers = new ArrayList
		this.jugadores = new ArrayList
	}

	def confirmar() {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible confirmar partido con estado: ")
		
		this.removerALosQueNoJugarian

		// Me quedo con los 10 Jugadores con más prioridad
		var jugadoresFinales = this.jugadores.sortBy[modoDeInscripcion.prioridadInscripcion].take(10).toList
		this.jugadores = jugadoresFinales

		val int size = this.cantidadJugadoresEnLista
		if (size.equals(10)) {
			this.estadoDePartido = EstadoDePartido.CONFIRMADO
		} else {
			throw new NoHaySuficientesJugadoresException("Solamente confirmaron " + size + "jugadores...")
		}

		// Retorna la lista con los 10 jugadores confirmados
		return jugadores
	}
	
	
	// MÉTODOS DE JUGADORES
	def void agregarJugadorPartido(Jugador jugador) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible agregar jugadores a un partido con estado: ")
		this.jugadores.add(jugador)

		//avisarle a los observers de inscripcion que se inscribio el jugador
		this.inscripcionObservers.forEach[observer|observer.jugadorInscripto(jugador, this)]
	}

	def void darDeBajaJugador(Jugador jugador) {
		this.jugadores.remove(jugador)

		//Avisar sobre baja de jugador a los Observers
		this.bajaObservers.forEach[observer | observer.jugadorSeDioDeBaja(jugador, this)]
	}
	
	def void reemplazarJugador(Jugador jugador, Jugador jugadorReemplazo) {
		this.jugadores.remove(jugador)
		this.jugadores.add(jugadorReemplazo)

	}


	// MÉTODOS DE OBSERVERS
	def void registrarObserverDeInscripcion(InscripcionDeJugadorObserver inscripcionObserver) {
		inscripcionObservers.add(inscripcionObserver)
	}
	
	def void removerObserverDeInscripcion(InscripcionDeJugadorObserver inscripcionObserver) {
		inscripcionObservers.remove(inscripcionObserver)
	}

	def void registrarObserverDeBaja(BajaDeJugadorObserver bajaObserver) {
		bajaObservers.add(bajaObserver)
	}
	
	def void removerObserverDeBaja(BajaDeJugadorObserver bajaObserver) {
		bajaObservers.remove(bajaObserver)
	}
	
	
	// OTROS
	def String mailOficial() {
		MAIL_OFICIAL
	}
	
	def cantidadJugadoresEnLista() {
		this.jugadores.size
	}
	
	private def void removerALosQueNoJugarian() {
		jugadores = jugadores.filter[integrante | integrante.leSirveElPartido(this)].toList
	}
	
	private def validarEstadoDePartido(EstadoDePartido estadoEsperado, String mensajeDeError) {
		if (!estadoEsperado.equals(this.estadoDePartido)) {
			throw new EstadoDePartidoInvalidoException(mensajeDeError + this.estadoDePartido)
		}
	}
	
	
	// TOSTRING
	override toString() {
		ToStringBuilder.reflectionToString(this)
	}
	
	
	def estaEnElPartido(Jugador jugador){
		this.jugadores.contains(jugador)
	}
}
