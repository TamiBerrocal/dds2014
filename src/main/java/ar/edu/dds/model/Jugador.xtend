package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion

import java.util.List
import java.util.ArrayList
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import ar.edu.dds.home.JugadoresHome
import ar.edu.dds.exception.JugadorYaCalificadoParaEsePartidoException
import org.joda.time.LocalDateimport org.uqbar.commons.utils.Observable
import ar.edu.dds.home.PartidosHome

@Observable
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
	LocalDate fechaNacimiento
		
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
	
	def void agregarFechaDeNacimiento (int dia, int mes) {
		val hoy = new LocalDate
		this.fechaNacimiento = new LocalDate(hoy.minusYears(edad).getYear, mes, dia)
	}
	
 	def getPromedio() {
 		this.promedioDeCalificaciones(calificaciones)
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

	def boolean esFechaDeNacimientoAnterior(int dia, int mes, int anio) {
		val fecha = new LocalDate(anio, mes, dia)
		
		fecha.compareTo(fechaNacimiento) > 0
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
	
	def getPartidosJugados() {
		PartidosHome.getInstance.partidos.fold(0)[ jugados, partido |
			if (this.jugastePartido(partido))
				jugados + 1
			else
				jugados
		]
	}

	def boolean jugastePartido(Partido partido) {
		partido.jugadores.contains(this)
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
	
	
	
	
	
	
}
