package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.joda.time.DateTime

class Jugador {
	
	@Property
	private ModoDeInscripcion modoDeInscripcion
	
	@Property
	private String nombre
	
	@Property 
	private DateTime fechaDeNacimiento
	
	def void inscribirseA(Partido partido) {
		modoDeInscripcion.inscribir(this, partido)
	}
}