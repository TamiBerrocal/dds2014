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
	
	private Partido target
	private Admin admin
	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo",
											  "Mario", "Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"] 
	
	private def void verificarQueElNombreEstaEnElPartido(String nombre, Partido partido) {
		Assert.assertTrue(partido.jugadoresInscriptos.exists[ j | j.nombre.equals(nombre)])
	}
	
	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
		Assert.assertFalse(partido.jugadoresInscriptos.exists[ j | j.nombre.equals(nombre)])
	}
	
	@Before	
	def void init() {
		
		admin = new Admin()
		
		// Nuevo partido el 25 de Mayo de 2014 a las 21Hs en Avellaneda
		target = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		// Se le agregan 5 jugadores standard de 30 años
		for (int i : 0..4) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar)
			target.agregarJugador(jugador)
		}
	}
	
	@Test(expected = EstadoDePartidoInvalidoException) 
	def void testPartidoConfirmadoNoPuedeAgregarJugador() {
		target.estadoDePartido = EstadoDePartido.CONFIRMADO
		new Jugador().inscribirseA(target)
	}
	
	@Test()
	def void testInscripcionExitosa() {
		Assert.assertEquals(5, target.jugadoresInscriptos.size)
		new Jugador().inscribirseA(target)
		Assert.assertEquals(6, target.jugadoresInscriptos.size)
	}
	
	@Test()
	def void testConfirmaPartidoCon11EstandaresDejaLosPrimeros10() {
		// Se le agregan 6 jugadores standards más
		for (int i : 5..10) {
			val jugador = new Jugador(NOMBRES.get(i), 25, new Estandar)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, target.estadoDePartido)
		Assert.assertEquals(10, target.jugadoresInscriptos.size)
		
		// Verifico tener a los 10 jugadores que anote primero
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), target)
		}
		
		// Verifico que no haya más jugadores con otros nombres
		for (int i : 10..NOMBRES.size - 1) {
			verificarQueElNombreNoEstaEnElPartido(NOMBRES.get(i), target)
		}
	}
	
	@Test
	def void testConfirmarPartido10EstandaresYUnSolidarioQuedaAfueraElSolidario() {
		
		// Inscribo a Marcos solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria)
		target.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Marcos", target)
		
		// Inscribo a otros 5 Standares
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, target.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), target)
		}
		
		// Marcos quedó afuera por ser solidario
		verificarQueElNombreNoEstaEnElPartido("Marcos", target)
		
	}
	
	@Test
	def void testConfirmarPartido10EstandaresYUnCondicionalQuedaAfueraElCondicional() {
		// Inscribo a Román condicional
		val roman = new Jugador("Román", 42, new Condicional(new PorLugar("Avellaneda")))
		target.agregarJugador(roman)
		
		// Antes de confirmarse el partido, Román figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Román", target)
		
		// Inscribo a otros 5 Standares
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, target.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), target)
		}
		
		// Román quedó afuera por ser condicional
		verificarQueElNombreNoEstaEnElPartido("Román", target)
	}
	
	@Test
	def void testConfirmarPartido9Estandare1Condicional1SolidarioPriorizaAlSolidario() {
		
		// Inscribo a Román condicional
		val roman = new Jugador("Román", 42, new Condicional(new PorLugar("Avellaneda")))
		target.agregarJugador(roman)
		
		// Inscribo a Marcos solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria)
		target.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Román y Marcos figuran entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Román", target)
		verificarQueElNombreEstaEnElPartido("Marcos", target)
		
		// Inscribo a otros 4 Standares
		for (int i : 5..8) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, target.estadoDePartido)
		
		// Los 9 primeros nombres del array quedaron confirmados
		for (int i : 0..8) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), target)
		}
		
		// Marcos quedó confirmado
		verificarQueElNombreEstaEnElPartido("Marcos", target)
		
		// Román quedó afuera por ser condicional
		verificarQueElNombreNoEstaEnElPartido("Román", target)
	}
	
	@Test
	def void testConfirmarPartido5Estandares6SolidariosEliminaAlPrimerSolidarioQueSeAnoto() {
		
		// Inscribo a Marcos como primer solidario
		val marcos = new Jugador("Marcos", 42, new Solidaria)
		target.agregarJugador(marcos)
		
		// Antes de confirmarse el partido, Marcos figura entre los inscriptos
		verificarQueElNombreEstaEnElPartido("Marcos", target)
		
		// Inscribo a otros 5 Solidarios
		for (int i : 5..9) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Solidaria)
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, target.estadoDePartido)
		
		// Los 10 primeros nombres del array quedaron confirmados
		for (int i : 0..9) {
			verificarQueElNombreEstaEnElPartido(NOMBRES.get(i), target)
		}
		
		// Marcos quedó afuera por ser el primer solidario anotado
		verificarQueElNombreNoEstaEnElPartido("Marcos", target)
	}
	
	@Test(expected = NoHaySuficientesJugadoresException)
	def void testNoSePuedeConfirmarPartidoConMenosDe10Jugadores() {
		admin.confirmarPartido(target);
	}
	
	@Test(expected = NoHaySuficientesJugadoresException) 
	def void test7Estandares4CondicionalQueNoPasanLaCondicionNoSePuedeConfirmar() {
		// Inscribo a otros 2 Estandares
		for (int i : 5..6) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Estandar)
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		// Inscribo a 4 Condicionales cuya condicion no es satisfecha
		for (int i : 7..10) {
			val jugador = new Jugador()
			jugador.setModoDeInscripcion(new Condicional(new PorEdades(30, 6)))
			jugador.nombre = NOMBRES.get(i)
			target.agregarJugador(jugador)
		}
		
		admin.confirmarPartido(target)
	}
	

}