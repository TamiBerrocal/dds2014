package ar.edu.dds.model
import java.util.Date

class Infraccion {

	@Property
	private Date fechaCreacion
	
	@Property
	private Date validaHasta

	@Property
	String causa
	
	new() {
		this.fechaCreacion = new Date()
	}

	//Si bien todavía no es un requerimiento que debamos atender, acá tendríamos un método como el siguiente
	def void penalizarJugador(Jugador jugador, Partido partido) {
		partido.darDeBajaJugador(jugador)
	}
}
