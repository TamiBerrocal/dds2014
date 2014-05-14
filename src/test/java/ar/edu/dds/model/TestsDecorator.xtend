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

class TestsDecorator {
	Admin admin
	Partido partido

	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario",
		"Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"]

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

		partido = new YaHay10EnElPartidoDecorator(partido)

		//agregamos 2 jugadores estandar mas y se tendria que notificar al adm
		partido.agregarJugador(new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com"))
		partido.agregarJugador(new Jugador("Mariano", 25, new Estandar, "mail@ejemplo.com"))

		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))
	}

	@Test
	def void testSeInscribeUnoPeroNoLleganADiez() {

		partido = new YaHay10EnElPartidoDecorator(partido)
		partido.agregarJugador(new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com"))

		//verificamos que NO se haya enviado un mail al admin, y como no tiene ningun amigo no se debe notificar a nadie
		verify(partido.mailSender, times(0)).enviar(any(typeof(Mail)))
	}

	@Test
	def void JugadorSeInscribeYseAvisaAlosAmigos() {

		partido = new AvisarAmigosDeInscripcion(partido)

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugador(enrique)
		val marcos = new Jugador("Marcos", 25, new Estandar, "mail@ejemplo.com")
		marcos.agregarJugadorAListaDeAmigos(enrique)
		
		//cuando agrego al partido a marcos (amigo de enrique) se le debe notificar a enrique
		partido.agregarJugador(marcos)
		verify(partido.mailSender, times(1)).enviar(any(typeof(Mail)))

	}
}
