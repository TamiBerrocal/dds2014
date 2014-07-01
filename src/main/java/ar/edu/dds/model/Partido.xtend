package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.exception.EquiposNoGeneradosException
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.apache.commons.lang3.builder.ToStringBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ParDeEquipos

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
	
	@Property
	ParDeEquipos equipos

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
		this.equipos = null
	}

	def void confirmar() {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible confirmar partido con estado: ")
		
		if (equipos.estanOk) {
			this.estadoDePartido = EstadoDePartido.CONFIRMADO
		} else {
			throw new EquiposNoGeneradosException("Generar equipos antes de confirmar")
		}
	}

	// MÉTODOS DE EQUIPOS
	def void generarEquiposTentativos(OrdenadorDeJugadores ordenador, GeneradorDeEquipos generadorDeEquipos) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible generar equipos para partido con estado: ")
		
		// Me quedo con los 10 Jugadores con más prioridad
		val jugadoresFinales = this.jugadoresQueJugarian.sortBy[modoDeInscripcion.prioridadInscripcion].take(10).toList
	
		val cantidadDeConfirmados = jugadoresFinales.size 
		if (cantidadDeConfirmados.equals(10)) {
			val jugadoresOrdenados = ordenador.ordenar(jugadoresFinales) //agrego la asignacion porque el sortby no tiene efecto
			this.equipos = generadorDeEquipos.generar(jugadoresOrdenados)
		} else {
			throw new NoHaySuficientesJugadoresException("Solamente confirmaron " + cantidadDeConfirmados + "jugadores...")
		}
	}
	
	
	// MÉTODOS DE JUGADORES
	def void agregarJugadorPartido(Jugador jugador) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "Imposible agregar jugadores a un partido con estado: ")
		this.jugadores.add(jugador)

		//avisarle a los observers de inscripcion que se inscribio el jugador
		this.inscripcionObservers.forEach[observer|observer.jugadorInscripto(jugador, this)]
	}

	def void darDeBajaJugador(Jugador jugador) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "No se puede dar de baja de un partido con estado: ")
		this.jugadores.remove(jugador)

		//Avisar sobre baja de jugador a los Observers
		this.bajaObservers.forEach[observer | observer.jugadorSeDioDeBaja(jugador, this)]
	}
	
	def void reemplazarJugador(Jugador jugador, Jugador jugadorReemplazo) {
		this.validarEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION, "No se puede reemplazar jugadores en un partido con estado: ")
		
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
	
	private def List<Jugador> jugadoresQueJugarian() {
		jugadores.filter[integrante | integrante.leSirveElPartido(this)].toList
	}
	
	private def validarEstadoDePartido(EstadoDePartido estadoEsperado, String mensajeDeError) {
		if (!estadoEsperado.equals(this.estadoDePartido)) {
			throw new EstadoDePartidoInvalidoException(mensajeDeError + this.estadoDePartido)
		}
	}
	
	def estaEnElPartido(Jugador jugador){
		this.jugadores.contains(jugador)
	}
	
	// ------ HASHCODE - EQUALS - TOSTRING ------- //
	override hashCode() {
		HashCodeBuilder.reflectionHashCode(this)
	}

	override equals(Object obj) {
		EqualsBuilder.reflectionEquals(obj, this)
	}
	
	override toString() {
		ToStringBuilder.reflectionToString(this)
	}
}
