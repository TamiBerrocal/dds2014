package ar.edu.dds.model

import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Before
import org.junit.Test
import ar.edu.dds.exception.EstadoDePartidoInvalidoException
import junit.framework.Assert
import ar.edu.dds.model.inscripcion.Solidaria
import ar.edu.dds.model.inscripcion.Condicional
import ar.edu.dds.model.inscripcion.condicion.PorLugar
import ar.edu.dds.exception.NoHaySuficientesJugadoresException
import ar.edu.dds.model.inscripcion.condicion.PorEdades

class PartidoTest {
	
	private PartidoImpl partido
	private Admin admin
	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo",
											  "Mario", "Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"] 
	
	private def void verificarQueElNombreEstaEnElPartido(String nombre, PartidoImpl partido) {
		Assert.assertTrue(partido.jugadoresInscriptos.exists[ j | j.nombre.equals(nombre)])
	}
	
	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, PartidoImpl partido) {
		Assert.assertFalse(partido.jugadoresInscriptos.exists[ j | j.nombre.equals(nombre)])
	}
	
	@Before	
	def void init() {
		
		admin = new Admin()
		
		// Nuevo partido el 25 de Mayo de 2014 a las 21Hs en Avellaneda
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		// Se le agregan 5 jugadores standard de 30 años
		for (int i : 0..4) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar,"mail@ejemplo.com")
			partido.agregarJugador(jugador)
		}
	}
	
	@Test(expected = EstadoDePartidoInvalidoException) 
	def void testPartidoConfirmadoNoPuedeAgregarJugador() {
		partido.estadoDePartido = EstadoDePartido.CONFIRMADO
		new Jugador().inscribirseA(partido)
	}
	
	@Test()
	def void testConfirmaPartidoCon11EstandaresDejaLosPrimeros10() {
		// Se le agregan 6 jugadores standards más
		for (int i : 5..10) {
			val jugador = new Jugador(NOMBRES.get(i), 25, new Estandar,"mail@ejemplo.com")
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		Assert.assertEquals(10, partido.jugadoresInscriptos.size)
		
		// Verifico tener a los 10 jugadores que anote primero
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
		
		// Verifico que no haya más jugadores con otros nombres
		for (int i : 10..NOMBRES.size - 1) {
			verificarQueElNombreNoEstaEnElPartido(NOMBRES.get(i), partido)
		}
	}
	
	@Test
	def void testConfirmarPartido10EstandaresYUnSolidarioQuedaAfueraElSolidario() {
		
		// Inscribo a Marcos solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria,"mail@ejemplo.com")
		partido.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Marcos", partido)
		
		// Inscribo a otros 5 Standares
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
		
		// Marcos quedó afuera por ser solidario
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)
		
	}
	
	@Test
	def void testConfirmarPartido10EstandaresYUnCondicionalQuedaAfueraElCondicional() {
		// Inscribo a Román condicional
		val roman = new Jugador("Román", 42, new Condicional(new PorLugar("Avellaneda")),"mail@ejemplo.com")
		partido.agregarJugador(roman)
		
		// Antes de confirmarse el partido, Román figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Román", partido)
		
		// Inscribo a otros 5 Standares
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
		
		// Román quedó afuera por ser condicional
		verificarQueElNombreNoEstaEnElPartido("Román", partido)
	}
	
	@Test
	def void testConfirmarPartido9Estandare1Condicional1SolidarioPriorizaAlSolidario() {
		
		// Inscribo a Román condicional
		val roman = new Jugador("Román", 42, new Condicional(new PorLugar("Avellaneda")),"mail@ejemplo.com")
		partido.agregarJugador(roman)
		
		// Inscribo a Marcos solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria,"mail@ejemplo.com")
		partido.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Román y Marcos figuran entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Román", partido)
		verificarQueElNombreEstaEnElPartido("Marcos", partido)
		
		// Inscribo a otros 4 Standares
		for (int i : 5..8) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		
		// Los 9 primeros nombres del array quedaron confirmados
		for (int i : 0..8) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
		
		// Marcos quedó confirmado
		verificarQueElNombreEstaEnElPartido("Marcos", partido)
		
		// Román quedó afuera por ser condicional
		verificarQueElNombreNoEstaEnElPartido("Román", partido)
	}
	
	@Test
	def void testConfirmarPartido5Estandares6SolidariosEliminaAlPrimerSolidarioQueSeAnoto() {
		
		// Inscribo a Marcos como primer solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria,"mail@ejemplo.com")
		partido.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Marcos", partido)
		
		// Inscribo a otros 5 Solidarios
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Solidaria)
			jugador.nombre = NOMBRES.get(i)
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, partido.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), partido)
		}
		
		// Marcos quedó afuera por ser el primer solidario anotado
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)
	}
	
	@Test(expected = NoHaySuficientesJugadoresException)
	def void testNoSePuedeConfirmarPartidoConMenosDe10Jugadores() {
		admin.confirmarPartido(partido);
	}
	
	@Test(expected = NoHaySuficientesJugadoresException) 
	def void test7Estandares4CondicionalQueNoPasanLaCondicionNoSePuedeConfirmar() {
		// Inscribo a otros 2 Estandares
		for (int i : 5..6) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar,"mail@ejemplo.com")
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			partido.agregarJugador(jugador)
		}
		
		// Inscribo a 4 Condicionales cuya condicion no es satisfecha
		for (int i : 7..10) {
			val jugador = new Jugador(NOMBRES.get(i), 35, new Condicional(new PorEdades(30, 6)),"mail@ejemplo.com")
			partido.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(partido)
	}
	

}