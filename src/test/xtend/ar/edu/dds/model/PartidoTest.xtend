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
		for (int i : 1 .. 5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
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
	
	@Test
	def void testConfirmarEquipoStandard() {

		for (int i : 1 .. 6) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}

		admin.confirmarPartido(target)
		Assert.asserEquals(target.jugadoresInscriptos.size, 10)

		//Assert.assertEquals()
		Assert.assertEquals(tarjet.estadoDePartido, EstadoDePartido.CONFIRMADO)

	}
	
	@Test
	def void testConfirmarEquipoConUnSolidario() {

		for (int i : 1 .. 5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
		val carlos = new Jugador()
		carlos.setModoInscripcion(new Solidario)
		target.agregarJugadr(carlos)

		admin.confirmarPartido(target)
		Assert.asserEquals(target.jugadoresInscriptos.size, 10)

		// Assert.assertEquals()
		Assert.assertEquals(tarjet.estadoDePartido, EstadoDePartido.CONFIRMADO)
	}

	@Test
	def void testConfirmarEquipoConUnCondicional() {

		for (int i : 1 .. 5) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}
		val jugador = new Jugador()
		jugador.setModoDeInscripcion(new Condicional(new PorLugar("Belgrano")))
		target.agregarJugadr(jugador)

		admin.confirmarPartido(target)
		Assert.asserEquals(target.jugadoresInscriptos.size, 10)

		// Assert.assertEquals()
		Assert.assertEquals(tarjet.estadoDePartido, EstadoDePartido.CONFIRMADO)
	}
	
	@Test
	def void testConfirmarEquipoReemplazandoSolidarioPorCondicional() {

		for (int i : 1 .. 4) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			target.agregarJugador(jugador)
		}

		val jugador = new Jugador()
		jugador.setModoInscripcion(new Solidario)
		target.agregarJugadr(jugador)

		val jugador = new Jugador()
		jugador.setModoDeInscripcion(new Condicional(new PorLugar("Belgrano")))
		target.agregarJugadr(jugador)

		admin.confirmarPartido(target)
		Assert.asserEquals(target.jugadoresInscriptos.size, 10)

		// Assert.assertEquals()
		Assert.assertEquals(tarjet.estadoDePartido, EstadoDePartido.CONFIRMADO)
	}
	
	@Test
	def void testConfirmarEquipoCon5Solidario() {

		for (int i : 1 .. 6) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Solidario)
			target.agregarJugador(jugador)
		}

		admin.confirmarPartido(target)
		Assert.asserEquals(target.jugadoresInscriptos.size, 10)

		//Assert.assertEquals()
		Assert.assertEquals(tarjet.estadoDePartido, EstadoDePartido.CONFIRMADO)

	}
	
	@Test(expected = NoHaySuficientesJugadoresException)
	def void testConfirmarEquipoIncompleto() {

		admin.confirmarPartido(target)

	}

	@Test(expected = NoHaySuficientesJugadoresException)
	def void testConfirmarEquipoConCondicionales() {

		for (int i : 1 .. 4) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Condicional(new PorLugar("Belgrano")))
			target.agregarJugador(jugador)
		}
		
		for (i : 1..2) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Standard)
			target.agregarJugador(jugador)
		}
		
	}

}
