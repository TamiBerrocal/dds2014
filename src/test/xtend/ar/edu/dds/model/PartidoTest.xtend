package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Before

class PartidoTest {
	
	private Partido target
	private Admin admin
	
	@Before	
	def void init() {
		
		admin = new Admin()
		
		// Nuevo partido el 25 de Mayo de 2014 a las 21Hs en Avellaneda
		target = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		// Se le agregan 5 jugadores standard
		for (int i : 1..5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
	}

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