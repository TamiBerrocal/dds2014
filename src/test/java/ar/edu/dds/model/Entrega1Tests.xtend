package ar.edu.dds.model

import ar.edu.dds.exception.EquiposNoGeneradosException
import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test

class Entrega1Tests {

	Admin admin
	Partido partido

	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario",
		"Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"]

//	private def void verificarQueElNombreEstaEnElPartido(String nombreJugador, Partido partido) {
//		Assert.assertTrue(partido.jugadores.exists[jugador|jugador.nombre.equals(nombreJugador)])
//	}
//
//	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
//		Assert.assertFalse(partido.jugadores.exists[jugador|jugador.nombre.equals(nombre)])
//	}

	@Before
	def void init() {
		this.admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		this.partido = this.admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		for (int i : 0 .. 4) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar, "mail@ejemplo.com")
			this.partido.agregarJugadorPartido(jugador)
		}
	}

	@Test(expected=EstadoDePartidoInvalidoException)
	def void testPartidoConfirmadoNoPuedeAgregarJugador() {
		this.partido.estadoDePartido = EstadoDePartido.CONFIRMADO
		this.partido.agregarJugadorPartido(new Jugador())
	}

//	@Test()
//	def void testConfirmaPartidoCon11EstandaresDejaLosPrimeros10() {
//
//		// Se le agregan 6 jugadores standards más
//		for (int i : 5 .. 10) {
//			val jugador = new Jugador(NOMBRES.get(i), 25, new Estandar, "mail@ejemplo.com")
//			this.partido.agregarJugadorPartido(jugador)
//		}
//
//		this.admin.confirmarPartido(partido)
//		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
//		Assert.assertEquals(10, this.partido.jugadores.size)
//
//		// Verifico tener a los 10 jugadores que anote primero
//		for (int i : 0 .. 9) {
//			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
//		}
//
//		// Verifico que no haya más jugadores con otros nombres
//		for (int i : 10 .. NOMBRES.size - 1) {
//			verificarQueElNombreNoEstaEnElPartido(NOMBRES.get(i), partido)
//		}
//	}
//
//	@Test
//	def void testConfirmarPartido10EstandaresYUnSolidarioQuedaAfueraElSolidario() {
//
//		// Inscribo a Marcos solidario
//		val marcos = new Jugador("Marcos", 42, new Solidaria, "mail@ejemplo.com")
//		this.partido.agregarJugadorPartido(marcos)
//
//		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
//		verificarQueElNombreEstaEnElPartido("Marcos", partido)
//
//		// Inscribo a otros 5 Standares
//		for (int i : 5 .. 9) {
//			val jugador = new Jugador()
//			jugador.modoDeInscripcion = new Estandar
//			jugador.nombre = NOMBRES.get(i)
//			jugador.mail = "mail@ejemplo.com"
//			this.partido.agregarJugadorPartido(jugador)
//		}
//
//		this.admin.confirmarPartido(partido)
//		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
//
//		// Los 10 primeros nombres del array quedaron confirmados
//		for (int i : 0 .. 9) {
//			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), this.partido)
//		}
//	}
//
//	@Test
//	def void testConfirmarPartido10EstandaresYUnCondicionalQuedaAfueraElCondicional() {
//
//		// Inscribo a Román condicional
//		val roman = new Jugador("Roman", 42, new CondicionalPorLugar("Avellaneda"), "mail@ejemplo.com")
//		this.partido.agregarJugadorPartido(roman)
//
//		// Antes de confirmarse el partido, Román figura entre los inscriptos
//		verificarQueElNombreEstaEnElPartido("Roman", partido)
//
//		// Inscribo a otros 5 Standares
//		for (int i : 5 .. 9) {
//			val jugador = new Jugador()
//			jugador.setModoDeInscripcion(new Estandar)
//			jugador.nombre = NOMBRES.get(i)
//			jugador.mail = "mail@ejemplo.com"
//			this.partido.agregarJugadorPartido(jugador)
//		}
//
//		this.admin.confirmarPartido(partido)
//		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
//
//		// Los 10 primeros nombres del array quedaron confirmados
//		for (int i : 0 .. 9) {
//			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), this.partido)
//		}
//
//		// Román quedó afuera por ser condicional
//		verificarQueElNombreNoEstaEnElPartido("Roman", this.partido)
//	}
//
//	@Test
//	def void testConfirmarPartido9Estandare1Condicional1SolidarioPriorizaAlSolidario() {
//
//		// Inscribo a Román condicional
//		val roman = new Jugador("Román", 42, new CondicionalPorLugar("Avellaneda"), "mail@ejemplo.com")
//		this.partido.agregarJugadorPartido(roman)
//
//		// Inscribo a Marcos solidario
//		val marcos = new Jugador("Marcos", 42, new Solidaria, "mail@ejemplo.com")
//		this.partido.agregarJugadorPartido(marcos)
//
//		// Antes de confirmarse el partido, Román y Marcos figuran entre los inscriptos
//		verificarQueElNombreEstaEnElPartido("Román", this.partido)
//		verificarQueElNombreEstaEnElPartido("Marcos", this.partido)
//
//		// Inscribo a otros 4 Standares
//		for (int i : 5 .. 8) {
//			val jugador = new Jugador()
//			jugador.setModoDeInscripcion(new Estandar)
//			jugador.nombre = NOMBRES.get(i)
//			this.partido.agregarJugadorPartido(jugador)
//		}
//
//		this.admin.confirmarPartido(this.partido)
//		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
//
//		// Los 9 primeros nombres del array quedaron confirmados
//		for (int i : 0 .. 8) {
//			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), this.partido)
//		}
//
//		// Marcos quedó confirmado
//		verificarQueElNombreEstaEnElPartido("Marcos", this.partido)
//
//		// Román quedó afuera por ser condicional
//		verificarQueElNombreNoEstaEnElPartido("Román", this.partido)
//	}
//
//	@Test
//	def void testConfirmarPartido5Estandares6SolidariosEliminaAlUltimoSolidarioQueSeAnoto() {
//
//		// Inscribo a 5 Solidarios
//		for (int i : 5 .. 9) {
//			val jugador = new Jugador()
//			jugador.setModoDeInscripcion(new Solidaria)
//			jugador.nombre = NOMBRES.get(i)
//			jugador.mail = "mail@ejemplo.com"
//			this.partido.agregarJugadorPartido(jugador)
//		}
//
//		// Inscribo a Marcos como ultimo solidario
//		val marcos = new Jugador("Marcos", 42, new Solidaria, "mail@ejemplo.com")
//		this.partido.agregarJugadorPartido(marcos)
//
//		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
//		verificarQueElNombreEstaEnElPartido("Marcos", partido)
//
//		this.admin.confirmarPartido(partido)
//		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
//
//		// Los 10 primeros nombres del array quedaron confirmados
//		for (int i : 0 .. 9) {
//			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), this.partido)
//		}
//
//		// Marcos quedó afuera por ser el primer solidario anotado
//		verificarQueElNombreNoEstaEnElPartido("Marcos", this.partido)
//	}
	
	@Test(expected = EquiposNoGeneradosException)
	def void testNoSePuedeConfirmarPartidoConMenosDe10Jugadores() {
		this.partido.confirmar;
	}
	
}
