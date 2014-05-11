package ar.edu.dds.model

import org.joda.time.DateTime
import java.util.List
import ar.edu.dds.model.inscripcion.ModoDeInscripcion

class Admin extends Jugador {
	
	new() {}
	
	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion) {
		super(nombre, edad, modoDeInscripcion)
	}
	
	def PartidoImpl organizarPartido(DateTime fechaYHora, String lugar) {
		new PartidoImpl(fechaYHora, lugar)
	}
	
	def List<Jugador> confirmarPartido(PartidoImpl partido) {
		partido.confirmar
	}
}