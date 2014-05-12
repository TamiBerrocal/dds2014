package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
//import org.apache.commons.lang3.builder.HashCodeBuilder
//import org.apache.commons.lang3.builder.EqualsBuilder
import java.util.List
import java.util.ArrayList

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
	private int edad
	
	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String direccionMail) {
		this.nombre = nombre
		this.edad = edad
		this.modoDeInscripcion = modoDeInscripcion
		this.mail = direccionMail
		this.amigos = new ArrayList<Jugador>
	}
	
	new() {
		this.amigos = new ArrayList<Jugador>
	}
	
	def void inscribirseA(Partido partido) {
		partido.agregarJugadorPartido(this)
	}
	
	def boolean leSirveElPartido(Partido partido) {
		modoDeInscripcion.leSirveElPartido(partido)
	}
	
//	def Integer prioridad(Integer prioridadBase) {
//		modoDeInscripcion.prioridad(prioridadBase)
//	}
	
//	override hashCode() {
//		HashCodeBuilder.reflectionHashCode(this)
//	}
//
//	override equals(Object obj) {
//		EqualsBuilder.reflectionEquals(obj, this)
//	}
	
	override toString() {
		nombre
	}
	
}