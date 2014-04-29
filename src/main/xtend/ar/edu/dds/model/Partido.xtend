package ar.edu.dds.model

import java.util.ArrayList
import java.util.List
import org.joda.time.DateTime

class Partido {
	
	@Property
	private List<Jugador> jugadoresInscriptos
	
	@Property 
	private DateTime fechaYHora
	
	@Property
	private String lugar
	
	@Property
	private EstadoDePartido estadoDePartido
	
	new(DateTime fechaYHora, String lugar) {
		this.fechaYHora = fechaYHora
		this.lugar = lugar
		this.jugadoresInscriptos = new ArrayList
		this.estadoDePartido = EstadoDePartido.ABIERTA_LA_INSCRIPCION
	}
	
	def void removerALosQueNoJugarian() {
		jugadoresInscriptos = jugadoresInscriptos.filter[ j | j.leSirveElPartido(this) ].toList
	}
	
	def void agregarJugador(Jugador jugador) {
		jugadoresInscriptos.add(jugador)
	}
	
}