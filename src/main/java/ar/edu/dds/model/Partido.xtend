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
	private List<Pair<Jugador, Integer>> jugadoresConSusPrioridadesSegunOrden

	@Property
	private DateTime fechaYHora
	
	@Property
	private String lugar

	@Property
	private EstadoDePartido estadoDePartido

	@Property
	Jugador administrador
	
	private Integer prioridadAAsignarPorOrden
	
	private List<InscripcionDeJugadorObserver> inscripcionObservers
	private List<BajaDeJugadorObserver> bajaObservers

	new(DateTime fechaYHora, String lugar) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.jugadoresConSusPrioridadesSegunOrden = new ArrayList
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
		this.prioridadAAsignarPorOrden = 200
	}

	def confirmar() {
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(this.estadoDePartido)) {
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
		} else {
			throw new EstadoDePartidoInvalidoException("Imposible confirmar partido con estado: " + this.estadoDePartido)
		}

		// Retorna la lista con los 10 jugadores confirmados
		jugadoresInscriptos
	}

	def List<Jugador> jugadoresInscriptos() {
		this.jugadoresConSusPrioridadesSegunOrden.map[par|par.key]
	}

	def void agregarJugador(Jugador jugador) {
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(this.estadoDePartido)) {
			jugadoresConSusPrioridadesSegunOrden.add(new Pair(jugador, this.prioridadAAsignarPorOrden))
			prioridadAAsignarPorOrden = prioridadAAsignarPorOrden - 10
		} else {
			throw new EstadoDePartidoInvalidoException(
				"Imposible agregar jugadores a un partido con estado: " + this.estadoDePartido)
		}
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

	private def Pair<Jugador, Integer> quitarJugador(Jugador jugador) {
		val jugadorConSuPrioridadADarDeBaja = this.jugadoresConSusPrioridadesSegunOrden.findFirst[par|
			par.key.equals(jugador)]
		this.jugadoresConSusPrioridadesSegunOrden.remove(jugadorConSuPrioridadADarDeBaja)
		jugadorConSuPrioridadADarDeBaja
	}

	private def void removerALosQueNoJugarian() {
		jugadoresConSusPrioridadesSegunOrden = jugadoresConSusPrioridadesSegunOrden.filter[j|
			j.key.leSirveElPartido(this)].toList
	}

	override toString() {
		ToStringBuilder.reflectionToString(this)
	}
	
	def cantidadDeJugadoresEnLista() {
		this.jugadoresConSusPrioridadesSegunOrden.size
	}

}
