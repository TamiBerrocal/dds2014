package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import junit.framework.Assert
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import java.util.Date

class testsObservers {

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

	private def void verificarQueHayUnaInfraccionDelDiaDeHoy(Jugador jugador, Date hoy) {
		Assert.assertTrue(jugador.infracciones.exists[infraccion|infraccion.fechaCreacion.equals(hoy)])
	}

	@Before
	def void init() {

		admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		for (int i : 0 .. 7) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar, "mail@ejemplo.com")
			partido.agregarJugadorPartido(jugador)
		}
	}

	@Test
	def void seCompletaLaListaCon10Jugadores() {

		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		val mariano = new Jugador("Mariano", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(mariano)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Mariano", partido)

		//verificamos que se haya enviado un mail al administrador notificando que hay10 juagores en la lista 
		verify(mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void seInscribeUnoPeroNoLleganADiez() {

		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		//verificamos que NO se haya enviado un mail al admin, y como no tiene ningun amigo no se debe notificar a nadie
		verify(mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void JugadorSeInscribeYseAvisaAlosAmigos() {

		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)

		val marcos = new Jugador("Marcos", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(marcos)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		enrique.agregarAmigo(marcos)

		//verificamos que se haya enviado un mail a los amigos
		verify(mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))

	}

	@Test
	def void unJugadorSeDaDeBajaDejaReemplazante() {

		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		val marcos = new Jugador("Marcos", 42, new Estandar, "mail@ejemplo.com")

		partido.reemplazarJugador(enrique, marcos)

		//verificamos que enrique ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//Verficamos que Marcos este en la lista 
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		//verificamos que no se haya mandado mail al administrador, como no tiene amigos no se debe mandar ningun mail
		verify(mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))

	}

	@Test
	def void unJugadorSeDaDeBajaYEran10EnLista() {

		var hoy = new Date()
		
		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender
		
		val marcos = new Jugador("Marcos", 42, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(marcos)
		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Marcos", partido)
		
		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)
		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		partido.darDeBajaJugador(marcos)

		//verificamos que marcos ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)

		//Verificamos que Marcos haya sido penalizado
		verificarQueHayUnaInfraccionDelDiaDeHoy(marcos, hoy)

		//se mandan 2 mails al administrador 
		//1-notificando que el partido tiene 10 jugadores
		//2-notificando que el jugador se ha dado de baja
		verify(mockedMailSender, times(2)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void seDaDeBajaUnoPeroNoEran10() {

		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender

		val enrique = new Jugador("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		//verificamos que sean 9 en la lista
		Assert.assertEquals(9, partido.cantidadJugadoresEnLista)

		partido.darDeBajaJugador(enrique)

		//verificamos que no se haya notificado al admin, no tiene amigos.. 
		verify(mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))

	}

}
