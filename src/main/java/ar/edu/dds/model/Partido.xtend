package ar.edu.dds.model

import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.model.equipos.ParDeEquipos
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.ToStringBuilder
import org.eclipse.xtend.lib.Property
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import javax.persistence.OneToOne
import org.hibernate.annotations.Typeimport javax.persistence.ManyToMany

@Entity
@Observable
class Partido {
	
	private static final String MAIL_OFICIAL = "no-reply@of5.com"
	
/*	Long id
	List<Jugador> jugadores
	DateTime fechaYHora
	String lugar
	EstadoDePartido estadoDePartido
	Admin administrador
	ParDeEquipos equipos
	ArmadorEquipos armadorDeEquipos
	
	@Id @GeneratedValue
	def getId() {
		id
	}

	def void setId(Long unId) {
		id = unId
	}
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	def List<Jugador> getJugadores() {
		jugadores
	}
	
	def void setJugadores(List<Jugador> unosJugadores) {
		jugadores = unosJugadores
	}
	
	@Column def DateTime getFechaYHora() {
		fechaYHora
	}

	def void setFechaYHora(DateTime unaFechaYHora) {
		fechaYHora = unaFechaYHora
	}
	
	@Column def String getLugar() {
		lugar
	}

	def void setLugar(String unLugar) {
		lugar = unLugar
	}

	@Column def EstadoDePartido getEstadoDePartido() {
		estadoDePartido
	}

	def void setEstadoDePartido(EstadoDePartido unEstado) {
		estadoDePartido = unEstado
	}
	
	@ManyToOne	def Admin getAdministrador() {
		administrador
	}
	
	def void setAdministrador(Admin unAdministrador) {
		administrador = unAdministrador
	}
	
	@OneToOne	def ParDeEquipos getEquipos() {
		equipos
	}
	
	def void setEquipos(ParDeEquipos unosEquipos) {
		equipos = unosEquipos
	}
	
	@Column def ArmadorEquipos getArmadorDeEquipos() {
		armadorDeEquipos
	}
	
	def void setArmadorDeEquipos(ArmadorEquipos unArmadorDeEquipos) {
		armadorDeEquipos = unArmadorDeEquipos
	}*/

	@Id
	@GeneratedValue
	@Property long Id

	@ManyToMany (cascade = CascadeType.REFRESH)
	@Property List<Jugador> jugadores
	
	@Column
	@Type(type="org.jadira.usertype.dateandtime.joda.PersistentDateTime")
	@Property DateTime fechaYHora
	
	@Column
	@Property String lugar
	
	@Column
	@Property EstadoDePartido estadoDePartido
	
	@ManyToOne()
	@Property Admin administrador
	
	@OneToOne(cascade = CascadeType.ALL)
	@Property ParDeEquipos equipos
	
	@ManyToOne(cascade = CascadeType.ALL)
	@Property ArmadorEquipos armadorDeEquipos


	@OneToMany(cascade = CascadeType.ALL)
	List<InscripcionDeJugadorObserver> inscripcionObservers
	@OneToMany(cascade = CascadeType.ALL)
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
		this.armadorDeEquipos = new ArmadorEquipos
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
