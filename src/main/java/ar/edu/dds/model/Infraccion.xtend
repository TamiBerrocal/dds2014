package ar.edu.dds.model

import org.joda.time.DateTime

class Infraccion {

	@Property
	private DateTime fechaCreacion
	
	@Property
	private DateTime validaHasta

	@Property
	String causa
	
	new() {
		this.fechaCreacion = new DateTime()
	}

	//Si bien todavía no es un requerimiento que debamos atender, acá tendríamos un método como el siguiente
	def void penalizarJugador(Jugador jugador, Partido partido) {
		partido.darDeBajaJugador(jugador)
	}
}
