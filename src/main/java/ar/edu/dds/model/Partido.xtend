package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import ar.edu.dds.observer.inscripcion.HayDiezJugadoresObserver
import ar.edu.dds.observer.inscripcion.NotificarAmigosObserver
import static org.mockito.Mockito.*
import ar.edu.dds.observer.baja.InfraccionObserver
import ar.edu.dds.observer.baja.NotificarAdministradorObserver

class Partido {

	/**
	 * Lista de jugadores inscriptos con sus respectivas prioridades por orden
	 */
	@Property
	List<Jugador> jugadores

	@Property
	DateTime fechaYHora

	@Property
	String lugar

	@Property 
	String mailOficial

	@Property
	EstadoDePartido estadoDePartido

	@Property
	Admin administrador

	@Property
	MailSender mailSender

	@Property 
	List<InscripcionDeJugadorObserver> inscripcionObservers
	
	@Property 
	List<BajaDeJugadorObserver> bajaObservers

	new(DateTime fechaYHora, String lugar) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.jugadores = new ArrayList
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
		this.mailOficial = "no-reply@of5.com"
		this.inscripcionObservers = new ArrayList<InscripcionDeJugadorObserver>
		this.bajaObservers = new ArrayList<BajaDeJugadorObserver>
		this.jugadores = new ArrayList<Jugador>
		this.mailSender = mock(typeof(MailSender))
		val diezJugadoresObserver = new HayDiezJugadoresObserver
		val avisarAmigosObserver = new NotificarAmigosObserver
		inscripcionObservers.add(diezJugadoresObserver)
		inscripcionObservers.add(avisarAmigosObserver)
		val infraccionObserver = new InfraccionObserver
		val notificarObserver = new NotificarAdministradorObserver
		bajaObservers.add(infraccionObserver)
		bajaObservers.add(notificarObserver)
	}

	def confirmar() {
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(this.estadoDePartido)) {
			this.removerALosQueNoJugarian

			// Me quedo con los 10 Jugadores con más prioridad
			var jugadoresFinales = this.jugadores.take(10).toList
			this.jugadores = jugadoresFinales

			val int size = this.cantidadJugadoresEnLista
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
			this.inscripcionObservers.forEach[observer|observer.jugadorInscripto(jugador, this)]

		} else {
			throw new EstadoDePartidoInvalidoException(
				"Imposible agregar jugadores a un partido con estado: " + this.estadoDePartido)
		}
	}

	def void agregarJugadorALista(Jugador jugador) {
		jugadores.add(jugador)
		this.jugadores = jugadores.sortBy[modoDeInscripcion.prioridadInscripcion]
	}

	def void reemplazarJugador(Jugador jugador, Jugador jugadorReemplazo) {
		this.eliminarJugadorDeLista(jugador)
		this.agregarJugadorALista(jugadorReemplazo)

	}

	def void eliminarJugadorDeLista(Jugador jugador) {
		this.jugadores.remove(jugador)

	}

	def void darDeBajaJugador(Jugador jugador) {
		this.eliminarJugadorDeLista(jugador)
		//Avisar sobre baja de jugador a los Observers
		this.bajaObservers.forEach[observer|observer.jugadorSeDioDeBaja(jugador, this)]
	}

	private def void removerALosQueNoJugarian() {
		jugadores = jugadores.filter[integrante|integrante.leSirveElPartido(this)].toList
	}

	//
	//	override toString() {
	//		ToStringBuilder.reflectionToString(this)
	//	}	
	def cantidadJugadoresEnLista() {
		this.jugadores.size
	}
}
