package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import java.util.List

class Jugador {

	@Property
	private ModoDeInscripcion modoDeInscripcion

	@Property
	private String nombre

	@Property
	private int edad

	@Property
	private String email;

	@Property
	private List<Jugador> amigos;

	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion) {
		this.nombre = nombre
		this.edad = edad
		this.modoDeInscripcion = modoDeInscripcion
	}

	new() {
	}

	def agregarJugadorAListaDeAmigos(Jugador jugador) {
		this.amigos.add(jugador)
	}

	def void inscribirseA(PartidoImpl partido) {
		partido.agregarJugador(this)
	}

	def boolean leSirveElPartido(PartidoImpl partido) {
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
