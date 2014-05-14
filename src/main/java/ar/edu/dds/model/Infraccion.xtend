package ar.edu.dds.model
import org.joda.time.LocalDate

class Infraccion {

	@Property
	private LocalDate fechaCreacion
	
	@Property
	private LocalDate validaHasta

	@Property
	String causa
	
	new() {
		this.fechaCreacion = new LocalDate()
	}

	//Si bien todavía no es un requerimiento que debamos atender, acá tendríamos un método como el siguiente
	def void penalizarJugador(Jugador jugador, Partido partido) {
		partido.darDeBajaJugador(jugador)
	}
}
