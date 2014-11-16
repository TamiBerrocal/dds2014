package ar.edu.dds.model

import ar.edu.dds.exception.JugadorYaCalificadoParaEsePartidoException
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import ar.edu.dds.repository.hibernate.PartidosHibernateRepo
import ar.edu.dds.repository.inmemory.JugadoresHome
import java.util.ArrayList
import java.util.List
import javax.persistence.CascadeType
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToMany
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import org.apache.commons.lang3.builder.EqualsBuilder
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.eclipse.xtend.lib.Property
import org.joda.time.LocalDate
import org.joda.time.Period
import org.uqbar.commons.utils.Observable
import org.hibernate.annotations.Type

@Entity
@Observable
class Jugador {
	
	@Id
	@GeneratedValue
	@Property long id
	
	@ManyToOne (cascade = CascadeType.PERSIST)
	@Property ModoDeInscripcion modoDeInscripcion
	
	@ManyToMany (cascade = CascadeType.PERSIST)
	@Property List<Jugador> amigos
	
	@Column
	@Property String mail
	
	@Column
	@Property String nombre
	
	@Column
	@Property String apodo
	
	@Column
	@Property LocalDate fechaNacimiento
	
	@Column
	@Property int handicap
	
	@Column
	@Type (type = "yes_no")
	@Property Boolean aprobado
	
	@OneToMany(cascade = CascadeType.ALL)
	@Property List<Infraccion> infracciones
	
	@OneToMany(cascade = CascadeType.ALL)
	@Property List<Calificacion> calificaciones
		
/*	
 	@Id
	@GeneratedValue
	@Property long id

	@Column def ModoDeInscripcion getModoDeInscripcion() {
		modoDeInscripcion
	}
	
	def void setModoDeInscripcion(ModoDeInscripcion unModoDeInscripcion) {
		modoDeInscripcion = unModoDeInscripcion
	}
	
	@ManyToMany def List<Jugador> getAmigos() {
		amigos
	}
	
	def void setAmigos (List<Jugador> unosAmigos) {
		amigos = unosAmigos
	}
	
	@Column def String getMail() {
		mail
	}
	
	def void setMail(String unMail) {
		mail = unMail
	}
	
	@Column def String getNombre() {
		nombre
	}
	
	def void setNombre (String unNombre) {
		nombre = unNombre
	}
	
	@Column def String getApodo() {
		apodo
	}
	
	def void setApodo(String unApodo) {
		apodo = unApodo
	}
	
	@Column def LocalDate getFechaNacimiento() {
		fechaNacimiento
	}
	
	def void setFechaNacimiento(LocalDate unaFecha) {
		fechaNacimiento = unaFecha
	}
	
	@Column def int getHandicap() {
		handicap
	}
	
	def void setHandicap(int unHandicap) {
		handicap = unHandicap
	}
	
	@Column	@Type (type = "yes_no")
	def Boolean getAprobado() {
		aprobado
	}
	
	def void setAprobado(Boolean unBooleano) {
		aprobado = unBooleano
	}
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	def List<Infraccion> getInfracciones() {
		infracciones
	}
	
	def void setInfracciones(List<Infraccion> unasInfracciones) {
		infracciones = unasInfracciones
	}
	
	@OneToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	def List<Calificacion> getCalificaciones() {
		calificaciones	
	}
	
	def void setCalificaciones(List<Calificacion> unasCalificaciones) {
		calificaciones = unasCalificaciones
	}
	*/
	
	new(String nombre, LocalDate fechaNac, ModoDeInscripcion modoDeInscripcion, String direccionMail, String apodo) {
		this()
		this.nombre = nombre
		this.fechaNacimiento = fechaNac
		this.modoDeInscripcion = modoDeInscripcion
		this.mail = direccionMail
		this.apodo = apodo
	}

	new() {
		this.amigos = new ArrayList
		this.infracciones = new ArrayList
		this.calificaciones = new ArrayList
	}
	
 	def getPromedio() {
 		this.promedioDeCalificaciones(calificaciones)
	}
	
	def edad() {
		new Period(fechaNacimiento, LocalDate.now).years
	}
	
	def getPromedioUltimoPartido() {
		this.promedioDeCalificaciones(this.calificacionesDelUltimoPartido)
	}
	
	def int promedioDeCalificaciones (List<Calificacion> calificaciones) {
		if (calificaciones.isEmpty)
			0
		else
			calificaciones.map[ c | c.nota ].reduce[ n1, n2 | n1 + n2 ] / calificaciones.size
	}
	
	def tieneNombreQueEmpieza(String comienzo){
		nombre.startsWith(comienzo)
	}
	
	def tieneApodoCon(String cuasiApodo){
		apodo.contains(cuasiApodo)
	}

	def boolean fechaDeNacimientoAnteriorA(LocalDate fecha) {
		fecha.isAfter(fechaNacimiento)
	}
	
	def boolean estaEnRangoDeHandicap(Integer min, Integer max) {
		estaEnRango(min, max, handicap)
	}
	
	def boolean estaEnRangoDePromedio(Integer min, Integer max) {
		estaEnRango(min, max, promedioUltimoPartido)
	}
	
	def estaEnRango(Integer min, Integer max, Integer valor) {
		var minOk = true
		var maxOk = true
		
		if (min != null) {
			minOk = min <= valor
		}
		if (max != null) {
			maxOk = max >= valor
		}
		
		minOk && maxOk
	}
	
	def getPartidosJugados () {
		PartidosHibernateRepo.instance.todosLosPartidos.fold(0)[ jugados, partido |
			if (this.jugastePartido(partido))
				jugados + 1
			else
				jugados
		]
	}

	def boolean jugastePartido(Partido partido) {
		partido.jugadores.contains(this)
	}
	
	def void recomendarAmigo(Jugador jugador, JugadoresHome jugadoresHome) {
		jugadoresHome.recomendarNuevoJugador(jugador)
	}

	def boolean leSirveElPartido(Partido partido) {
		modoDeInscripcion.leSirveElPartido(partido)
	}

	def void agregateInfraccion() {
		var infraccion = new Infraccion
		//	infraccion.validaHasta = Falta definir validez de infracción
		infraccion.causa = "Baja sin reemplazante"
		infracciones.add(infraccion)
	}
	
	def void agregarAmigo(Jugador amigo) {
		amigos.add(amigo)
	}
	

	// ----- CALIFICACIONES ----- //
	def void calificarJugador(Jugador jugador, Calificacion calificacion) {
		jugador.recibirCalificacion(calificacion)
	}
	
	def void recibirCalificacion(Calificacion calificacion) {
		if (this.calificaciones.exists[ c | c.esLaMismaQue(calificacion) ]) {
			throw new JugadorYaCalificadoParaEsePartidoException("Jugador Ya Calificado...")
		}
		this.calificaciones.add(calificacion)
	}
	
	def boolean tieneCalificacion(Calificacion calificacion) {
		this.calificaciones.contains(calificacion)
	}
	
	def List<Calificacion> ultimasNCalificaciones(int n) {
		this.calificaciones.sortBy[ c | c.fechaDeCarga ].take(n).toList
	}
	
	def List<Calificacion> calificacionesDelUltimoPartido() {
		val ultimaCalificacion = this.calificaciones.sortBy[ c | c.partido.fechaYHora ].head
		if (ultimaCalificacion == null) {
			new ArrayList		
		} else {
			this.calificaciones.filter[ c | c.partido.equals(ultimaCalificacion.partido)].toList
		}
	}



	// ------ HASHCODE - EQUALS - TOSTRING ------- //
	override hashCode() {
		HashCodeBuilder.reflectionHashCode(this)
	}

	override equals(Object obj) {
		EqualsBuilder.reflectionEquals(obj, this)
	}
	
	override toString() {
		nombre
	}
		
	def isEsCrack(){
		handicap >= 8
	}

}
