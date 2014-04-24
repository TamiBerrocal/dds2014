package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import java.util.Date

class Jugador {
	
	@Property
	private ModoDeInscripcion modoDeInscripcion
	
	@Property
	private String nombre
	
	@Property 
	private Date fechaDeNacimiento
	
	def void inscribirseA(Partido partido) {
		modoDeInscripcion.inscribirA(partido)
	}
}