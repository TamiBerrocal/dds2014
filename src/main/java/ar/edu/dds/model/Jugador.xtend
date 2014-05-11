package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import java.util.List

class Jugador {
	
	@Property
	private ModoDeInscripcion modoDeInscripcion
	
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
	}
	
	new() {}
	
	def void inscribirseA(Partido partido) {
		partido.agregarJugador(this)
	}
	
	def boolean leSirveElPartido(Partido partido) {
		modoDeInscripcion.leSirveElPartido(partido)
	}
	
	def Integer prioridad(Integer prioridadBase) {
		modoDeInscripcion.prioridad(prioridadBase)
	}
	
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