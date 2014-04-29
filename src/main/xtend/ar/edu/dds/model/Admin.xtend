package ar.edu.dds.model

import org.joda.time.DateTime
import java.util.List

class Admin extends Jugador {
	
	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar)
	}
	
	def List<Jugador> confirmarPartido(Partido partido) {
		partido.confirmar
	}
}