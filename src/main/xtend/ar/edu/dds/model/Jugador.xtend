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
		partido.agregarJugador(this)
	}
	
	def boolean leSirveElPartido(Partido partido) {
		modoDeInscripcion.leSirveElPartido(partido)
	}
	
}