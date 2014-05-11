package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import org.apache.commons.lang3.builder.ToStringBuilder
import org.joda.time.DateTime

class Partido {

	/**
	 * Lista de jugadores inscriptos con sus respectivas prioridades por orden
	 */
	@Property
	List<Jugador> jugadores

	@Property
	private DateTime fechaYHora

	@Property
	private String lugar

	@Property String mailOficial

	@Property
	private EstadoDePartido estadoDePartido

	@Property
	Jugador administrador

	private List<InscripcionDeJugadorObserver> inscripcionObservers
	private List<BajaDeJugadorObserver> bajaObservers

	new(DateTime fechaYHora, String lugar) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.jugadores = new ArrayList
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
		this.mailOficial = "no-reply@of5.com"
	}

	def confirmar() {
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(this.estadoDePartido)) {
			this.removerALosQueNoJugarian

			// Me quedo con los 10 Jugadores con más prioridad
			this.jugadores = this.jugadores.take(10).toList

			val int size = this.jugadores.size
			if (size.equals(10)) {
				this.estadoDePartido = EstadoDePartido.CONFIRMADO
			} else {
				throw new NoHaySuficientesJugadoresException("Solamente confirmaron " + size + "jugadores...")
			}
		} else {
			throw new EstadoDePartidoInvalidoException("Imposible confirmar partido con estado: " + this.estadoDePartido)
		}

		// Retorna la lista con los 10 jugadores confirmados
		return jugadores
	}

	def void agregarJugadorPartido(Jugador jugador) {
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(this.estadoDePartido)) {
			agregarJugadorALista(jugador)

		//avisarle a los observers de inscripcion que se inscribio el jugador
		} else {
			throw new EstadoDePartidoInvalidoException(
				"Imposible agregar jugadores a un partido con estado: " + this.estadoDePartido)
		}
	}

	def void agregarJugadorALista(Jugador jugador) {
		jugadores.add(jugador)
		jugadores.sortBy[integrante|integrante.modoDeInscripcion.getPrioridadInscripcion]
	}

	def void reemplazarJugador(Jugador jugador, Jugador reemplazo) {
		this.darDeBajaJugador(jugador)
		this.agregarJugadorALista(reemplazo)

	
	}

	def void eliminarJugadorDeLista(Jugador jugador) {
		this.jugadores.remove(jugador)

	}

	def void darDeBajaJugador(Jugador jugador) {
		this.eliminarJugadorDeLista(jugador)
		//avisar que se dio de baja jugador a los observers
		//pensalizar
	}

	private def void removerALosQueNoJugarian() {
		jugadores = jugadores.filter[integrante|integrante.leSirveElPartido(this)].toList
	}

	//
	//	override toString() {
	//		ToStringBuilder.reflectionToString(this)
	//	}	
	def cantidadDeJugadoresEnLista() {
		this.jugadores.size
	}

}
