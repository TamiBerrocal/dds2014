package ar.edu.dds.model

import junit.framework.Assert
import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.junit.Test
import org.joda.time.DateTime
import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.model.inscripcion.Solidaria
import ar.edu.dds.model.inscripcion.condicion.PorLugar

class NuevoPartidoTest {

	Admin admin
	Partido partido

	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario",
		"Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"]

	private def void verificarQueElNombreEstaEnElPartido(String nombreJugador, Partido partido) {
		Assert.assertTrue(partido.jugadores.exists[jugador|jugador.nombre.equals(nombreJugador)])
	}

	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
		Assert.assertFalse(partido.jugadores.exists[jugador|jugador.nombre.equals(nombre)])
	}

	@Before
	def void init() {
		admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		for (int i : 0 .. 4) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar, "mail@ejemplo.com")
			partido.agregarJugadorPartido(jugador)
		}
	}

	@Test
	def void comprobarEstadoPartido() {
		Assert.assertEquals(EstadoDePartido.ABIERTA_LA_INSCRIPCION, partido.estadoDePartido)
	}

	@Test(expected=EstadoDePartidoInvalidoException)
	def void testPartidoConfirmadoNoPuedeAgregarJugador() {
		partido.estadoDePartido = EstadoDePartido.CONFIRMADO
		new Jugador().inscribirseA(partido)
	}

	@Test()
	def void testConfirmaPartidoCon11EstandaresDejaLosPrimeros10() {

		// Se le agregan 6 jugadores standards más
		for (int i : 5 .. 10) {
			val jugador = new Jugador(NOMBRES.get(i), 25, new Estandar, "mail@ejemplo.com")
			partido.agregarJugadorPartido(jugador)
		}

		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		Assert.assertEquals(10, partido.jugadores.size)

		// Verifico tener a los 10 jugadores que anote primero
		for (int i : 0 .. 9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}

		// Verifico que no haya más jugadores con otros nombres
		for (int i : 10 .. NOMBRES.size - 1) {
			verificarQueElNombreNoEstaEnElPartido(NOMBRES.get(i), partido)
		}
	}

	@Test
	def void testConfirmarPartido10EstandaresYUnSolidarioQuedaAfueraElSolidario() {

		// Inscribo a Marcos solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria, "mail@ejemplo.com")
		partido.agregarJugadorPartido(marcos)

		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		// Inscribo a otros 5 Standares
		for (int i : 5 .. 9) {
			val jugador = new Jugador()
			jugador.modoDeInscripcion = new Estandar
			jugador.nombre = NOMBRES.get(i)
			jugador.mail = "mail@ejemplo.com"
			partido.agregarJugadorPartido(jugador)
		}

		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)

		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0 .. 9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
	}

	@Test
	def void testConfirmarPartido10EstandaresYUnCondicionalQuedaAfueraElCondicional() {

		// Inscribo a Román condicional
		val roman = new Jugador("Roman", 42, new PorLugar("Avellaneda"), "mail@ejemplo.com")
		partido.agregarJugadorPartido(roman)

		// Antes de confirmarse el partido, Román figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Roman", partido)

		// Inscribo a otros 5 Standares
		for (int i : 5 .. 9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			jugador.mail = "mail@ejemplo.com"
			partido.agregarJugadorPartido(jugador)
		}

		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)

		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0 .. 9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}

		// Román quedó afuera por ser condicional
		verificarQueElNombreNoEstaEnElPartido("Román", partido)
	}

}
