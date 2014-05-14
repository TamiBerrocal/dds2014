package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.apache.commons.lang3.builder.HashCodeBuilder
import org.apache.commons.lang3.builder.EqualsBuilder
import java.util.List
import java.util.ArrayList

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
	private List<Jugador> amigos 
	
	@Property
	private List<Infraccion> infracciones
	
	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String mail) {
		this.nombre = nombre
		this.edad = edad
		this.modoDeInscripcion = modoDeInscripcion
		this.email = mail
		this.amigos = new ArrayList
		this.infracciones = new ArrayList
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
	
	def void agregateInfraccion(){
		var infraccion = new Infraccion
		infraccion.causa = "Baja sin reemplazante"
		infracciones.add(infraccion)
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
