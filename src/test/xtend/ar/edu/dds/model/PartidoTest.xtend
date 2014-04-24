package ar.edu.dds.model

import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.exception.PartidoCompletoException

class PartidoTest {
	
	private Partido target
	
	@Before	
	def void init() {
		
		val Admin admin = new Admin()
		
		// Nuevo partido el 25 de Mayo a las 21Hs
		target = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0))
		
		// Se le agregan 5 jugadores standard
		for (int i : 1..5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
	}

	@Test(expected = PartidoCompletoException)
	def void testMaximo10JugadoresStandard() {
		// Se le agregan 5 jugadores standard
		for (int i : 1..5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}	
		
		// Agregar un onceavo jugador debería causar una PartidoCompletoException
		val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		
	}

}