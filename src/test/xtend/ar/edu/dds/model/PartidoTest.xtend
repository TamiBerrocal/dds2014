package ar.edu.dds.model

import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import ar.edu.dds.model.inscripcion.Estandar

class PartidoTest {
	
	private Partido target
	
	@Before	
	def void init() {
		
		val Admin admin = new Admin()
		
		// Nuevo partido el 25 de Mayo de 2014 a las 21Hs en Avellaneda
		target = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		// Se le agregan 5 jugadores standard
		for (int i : 1..5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
	}

	@Test
	def void test() {
		
	}

//  Ya no aplica
//	@Test(expected = PartidoCompletoException)
//	def void testMaximo10JugadoresStandard() {
//		// Se le agregan 5 jugadores standard
//		for (int i : 1..5) {
//			val jugador = new Jugador()
//			jugador.setModoDeInscripcion(new Estandar)
//			target.agregarJugador(jugador)
//		}	
//		
//		// Agregar un onceavo jugador debería causar una PartidoCompletoException
//		val jugador = new Jugador()
//			jugador.setModoDeInscripcion(new Estandar)
//			target.agregarJugador(jugador)
//		
//	}

}