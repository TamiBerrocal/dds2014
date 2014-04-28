package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.ModoDeInscripcion

class Jugador {
	
	@Property
	private ModoDeInscripcion modoDeInscripcion
	
	@Property
	private String nombre
	
	@Property 
	private int edad
	
	def void inscribirseA(Partido partido) {
		modoDeInscripcion.inscribir(this, partido)
	}
	
}