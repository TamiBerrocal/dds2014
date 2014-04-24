package ar.edu.dds.model

import ar.edu.dds.exception.PartidoCompletoException
import java.util.List
import org.joda.time.DateTime
import java.util.ArrayList

class Partido {
	
	@Property
	private List<Jugador> jugadoresInscriptos
	
	@Property 
	private DateTime fechaYHora;
	
	new(DateTime fechaYHora) {
		this.fechaYHora = fechaYHora
		this.jugadoresInscriptos = new ArrayList
	}
	
	def void agregarJugador(Jugador jugador) {
		if (quedaLugarPara(jugador)) {
			jugadoresInscriptos.add(jugador)
		} else {
			throw new PartidoCompletoException("No hay más lugar en el partido")
		}
	}
	
	private def boolean quedaLugarPara(Jugador jugador) {
		
		// TODO Considerar el caso del que se anota pueda tener prioridad sobre alguno ya anotado
		jugadoresInscriptos.size < 10
	}
}