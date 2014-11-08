package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime
import org.apache.commons.lang3.builder.ToStringBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import org.uqbar.commons.utils.Observable
import ar.edu.dds.model.equipos.ParDeEquipos
import javax.persistence.Id
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.OneToMany
import javax.persistence.Column
import javax.persistence.OneToOne
import javax.persistence.ManyToOne

@Entity
@Observable
class Partido {
	
	private static final String MAIL_OFICIAL = "no-reply@of5.com"
	
	@Id
	@GeneratedValue
	@Property long Id

	@OneToMany
	@Property List<Jugador> jugadores
	
	@Column
	@Property DateTime fechaYHora
	
	@Column
	@Property String lugar
	
	@Column
	@Property EstadoDePartido estadoDePartido
	
	@ManyToOne
	@Property Admin administrador
	
	@OneToOne
	@Property ParDeEquipos equipos
	
	@Property ArmadorEquipos armadorDeEquipos

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
		this.equipos = new ParDeEquipos
		this.armadorDeEquipos = new ArmadorEquipos(this)
	}
	
	new() {
	}
	
	def void cerrarInscripcion(){
		estadoDePartido = EstadoDePartido.CONFIRMADO
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
	
	def List<Jugador> jugadoresQueJugarian() {
		jugadores.filter[integrante | integrante.leSirveElPartido(this)].toList
	}
	
	def validarEstadoDePartido(EstadoDePartido estadoEsperado, String mensajeDeError) {
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
