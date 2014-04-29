package ar.edu.dds.model

import org.joda.time.DateTime
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.exception.PartidoYaConfirmadoException

class Admin extends Jugador {
	
	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar)
	}
	
	def ConfirmarPartido(Partido partido) {
		
		if (EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(partido.estadoDePartido)) {
			partido.removerALosQueNoJugarian
		
			// Falta Obtener a los 10 jugadores del partido y asignarlos a la lista de inscriptos
			// Una buena forma es ordenar la lista por prioridad y quedarse con los primeros 10 elementos
			
			val int size = partido.jugadoresInscriptos.size
			if (size.equals(10)) {
	 			partido.estadoDePartido = EstadoDePartido.CONFIRMADO
			} else {
				throw new NoHaySuficientesJugadoresException("Solamente confirmaron " + size + "jugadores...")
			}		
		} else {
			throw new PartidoYaConfirmadoException("Imposible confirmar partido con estado: " + partido.estadoDePartido)
		}
	
		// Retorna la lista con los 10 jugadores confirmados
		partido.jugadoresInscriptos
	}
}