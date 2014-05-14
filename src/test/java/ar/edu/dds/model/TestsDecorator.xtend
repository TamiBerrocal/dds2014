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
		admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		for (int i : 0 .. 7) {
			partido.agregarJugador(new Jugador(NOMBRES.get(i), 21, new Estandar, "mimail@dds.com"))
		}
	}

	@Test
	def void testSeCompletaLaListaCon10Jugadores() {

		//decoro partido para que notifique al admin
		partido = new YaHay10EnElPartidoDecorator(partido)

		//agregamos 2 jugadores estandar mas y se tendria que notificar al adm
		partido.agregarJugador(new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com"))
		partido.agregarJugador(new Jugador("Mariano", 25, new Estandar, "mail@ejemplo.com"))

		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))
	}

	@Test
	def void testSeInscribeUnoPeroNoLleganADiez() {

		//decoro partido para que notifique al admin
		partido = new YaHay10EnElPartidoDecorator(partido)

		partido.agregarJugador(new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com"))

		//verificamos que NO se haya enviado un mail al admin, y como no tiene ningun amigo no se debe notificar a nadie
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))
	}

	@Test
	def void testJugadorSeInscribeYseAvisaAlosAmigos() {

		//decoro partido para que avise a sus amigos 
		partido = new AvisarAmigosDeInscripcion(partido)

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(enrique)
		val marcos = new Jugador("Marcos", 25, new Estandar, "mail@ejemplo.com")
		marcos.agregarJugadorAListaDeAmigos(enrique)

		//cuando agrego al partido a marcos (amigo de enrique) se le debe notificar a enrique
		partido.agregarJugador(marcos)
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))

	}

	@Test
	def void testUnJugadorSeDaDeBajaDejaReemplazante() {

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(enrique)

		val marcos = new Jugador("Marcos", 42, new Estandar, "mail@ejemplo.com")
		partido.reemplazarJugador(enrique, marcos)

		//verificamos que enrique ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//Verficamos que Marcos este en la lista 
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		//verificamos que no se haya mandado mail al administrador, como no tiene amigos no se debe mandar ningun mail
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))

	}

	@Test
	def void testUnJugadorSeDaDeBaja() {

		val marcos = new Jugador("Marcos", 42, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(marcos)

		var hoy = new LocalDate()

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		partido.darDeBajaJugador(marcos)

		//verificamos que marcos ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)

		//Verificamos que Marcos haya sido penalizado
		verificarQueHayUnaInfraccionDelDiaDeHoy(marcos, hoy)

	}

}
