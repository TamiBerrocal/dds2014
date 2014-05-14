package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import ar.edu.dds.model.mail.Mail
import ar.edu.dds.model.decorator.YaHay10EnElPartidoDecorator
import ar.edu.dds.model.decorator.AvisarAmigosDeInscripcion
import org.junit.Assert
import org.joda.time.LocalDate
import ar.edu.dds.model.decorator.DejoDeTener10Confirmados

class TestsDecorator {

	Admin admin
	Partido partido

	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario",
		"Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"]

	private def void verificarQueElNombreEstaEnElPartido(String nombreJugador, Partido partido) {
		Assert.assertTrue(partido.partido().jugadoresInscriptos().exists[j|j.nombre.equals(nombreJugador)])
	}

	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
		Assert.assertFalse(partido.partido().jugadoresInscriptos().exists[j|j.nombre.equals(nombre)])
	}

	private def void verificarQueHayUnaInfraccionDelDiaDeHoy(Jugador jugador, LocalDate hoy) {
		Assert.assertTrue(jugador.infracciones.exists[infraccion|infraccion.fechaCreacion.equals(hoy)])
	}

	@Before
	def void init() {
		admin = new Admin("Claudio", 27, new Estandar, "mail@ejemplo.com")
		val Partido datosPartido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		//DECORO con todos los decorators
		partido = new DejoDeTener10Confirmados(
			new AvisarAmigosDeInscripcion(
				new YaHay10EnElPartidoDecorator(datosPartido)
			))

		//Agrego 8 jugadores estandar
		for (int i : 0 .. 7) {
			partido.agregarJugador(new Jugador(NOMBRES.get(i), 21, new Estandar, "mimail@dds.com"))
		}
	}

	@Test
	def void testSeCompletaLaListaCon10Jugadores() {
		
		//agregamos 2 jugadores estandar mas y se tendria que notificar al adm
		partido.agregarJugador(new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com"))
		partido.agregarJugador(new Jugador("Victor", 25, new Estandar, "mail@ejemplo.com"))

		//verificamos que avise al admin
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))
	}

	@Test
	def void testSeInscribeUnoPeroNoLleganADiez() {

		partido.agregarJugador(new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com"))

		//verificamos que NO se haya enviado un mail al admin, y como no tiene ningun amigo no se debe notificar a nadie
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))
	}

	@Test
	def void testJugadorSeInscribeYseLeAvisaAlosAmigos() {

		val claudio = new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(claudio)
		val hector = new Jugador("Hector", 25, new Estandar, "mail@ejemplo.com")
		hector.agregarJugadorAListaDeAmigos(claudio)

		//cuando agrego al partido a hector (amigo de claudio) se le debe notificar a claudio
		//y notificar al admin porque se llego a los 10 confirmados. Serian 2 mails
		partido.agregarJugador(hector)
		verify(partido.mailSender, times(2)).enviar(any(typeof(Mail)))

	}

	@Test
	def void testUnJugadorSeDaDeBajaDejaReemplazante() {

		val claudio = new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(claudio)

		val lucas = new Jugador("Lucas", 42, new Estandar, "mail@ejemplo.com")
		partido.reemplazarJugador(claudio, lucas)

		//verificamos que claudio ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Claudio", partido)

		//Verficamos que Lucas este en la lista 
		verificarQueElNombreEstaEnElPartido("Lucas", partido)

		//verificamos que no se haya mandado mail al administrador, como no tiene amigos no se debe mandar ningun mail
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))

	}

	@Test
	def void testUnJugadorSeDaDeBajaYEran10EnLaLista() {

		val claudio = new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(claudio)

		val gustavo = new Jugador("Gustavo", 42, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(gustavo)

		var hoy = new LocalDate()

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Gustavo", partido)

		partido.darDeBajaJugador(gustavo)

		//verificamos que gustavo ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Gustavo", partido)

		//Verificamos que gustavo haya sido penalizado
		verificarQueHayUnaInfraccionDelDiaDeHoy(gustavo, hoy)

		//Verificamos que notifica al admin por no haber 10 confirmados
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))

	}

	//////////////////////////7
	@Test
	def void testSeDaDeBajaUnoPeroNoEran10() {

		val claudio = new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(claudio)

		//verificamos que sean 9 en la lista
		Assert.assertEquals(9, partido.partido().jugadoresInscriptos().size)

		partido.darDeBajaJugador(claudio)

		//verificamos que se haya eliminado el jugador de la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//verificamos que no se haya notificado al admin, no tiene amigos.. 
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))

	}

	@Test
	def void testSeDaDeBajaUnoPeroTodaviaHay10() {

		val claudio = new Jugador("Claudio", 27, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(claudio)

		val marcos = new Jugador("Marcos", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(marcos)

		//verificamos que le manda un mail al admin por que se llego a los 10 jugadores
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))

		val augusto = new Jugador("Augusto", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(augusto)

		//verificamos que sean 11 en la lista
		Assert.assertEquals(11, partido.partido().jugadoresInscriptos().size)

		partido.darDeBajaJugador(claudio)

		//verificamos que no se haya notificado de vuelta al admin
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))

	}
}
