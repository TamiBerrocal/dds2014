package ar.edu.dds.model

import org.joda.time.DateTime
import java.util.List
import ar.edu.dds.model.inscripcion.ModoDeInscripcion

class Admin extends Jugador {
	
	new() {}
	
	new(String nombre, int edad, ModoDeInscripcion modoDeInscripcion, String mail) {
		super(nombre, edad, modoDeInscripcion, mail)
	}
	
	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar)
	}
	
	def List<Jugador> confirmarPartido(Partido partido) {
		partido.confirmar
	}
}