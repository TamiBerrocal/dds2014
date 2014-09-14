package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion

import java.util.List
import java.util.ArrayList
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import ar.edu.dds.home.JugadoresHome
import ar.edu.dds.exception.JugadorYaCalificadoParaEsePartidoException
import org.joda.time.LocalDate

class Jugador {

	@Property
	ModoDeInscripcion modoDeInscripcion

	@Property
	List<Jugador> amigos

	@Property
	String mail

	@Property
	String nombre
	
	@Property
	String apodo
	
	@Property
	int edad
	
	@Property
	int fechaNacimiento
		
	@Property
	int handicap
	
	@Property
	List<Infraccion> infracciones
	
	@Property
	List<Calificacion> calificaciones
		
	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String direccionMail, String apodo) {
		this()
		this.nombre = nombre
		this.edad = edad
		this.modoDeInscripcion = modoDeInscripcion
		this.mail = direccionMail
		this.apodo = apodo
	}

	new() {
		this.amigos = new ArrayList
		this.infracciones = new ArrayList
		this.calificaciones = new ArrayList
	}
	
	def getFechaNacimiento() {
		val hoy = new LocalDate
		hoy.minusYears(edad)
	}
	
 	def getPromedio() {
 		this.promedioDeCalificaciones(calificaciones)
	}
	
	def getPromedioUltPartido() {
		this.promedioDeCalificaciones(this.calificacionesDelUltimoPartido)
	}
	
	def promedioDeCalificaciones (List<Calificacion> calificaciones) {
		if (calificaciones.isEmpty) 0 else calificaciones.map[ c | c.nota ].reduce[ n1, n2 | n1 + n2 ] / calificaciones.size
	} 
	
	def void recomendarAmigo(Jugador jugador) {
		JugadoresHome.instance.recomendarNuevoJugador(jugador)
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
		val ultimoPartidoEnElQueFueCalificado = this.calificaciones.sortBy[ c | c.partido.fechaYHora ].head.partido
		this.calificaciones.filter[ c | c.partido.equals(ultimoPartidoEnElQueFueCalificado)].toList
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
}
