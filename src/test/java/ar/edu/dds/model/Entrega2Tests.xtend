package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import junit.framework.Assert
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import org.joda.time.LocalDate
import ar.edu.dds.observer.inscripcion.HayDiezJugadoresObserver
import ar.edu.dds.observer.inscripcion.NotificarAmigosObserver
import ar.edu.dds.observer.baja.InfraccionObserver
import ar.edu.dds.observer.baja.NotificarAdministradorObserver

class Entrega2Tests {

	Admin admin
	Partido partido
	MailSender mockedMailSender

	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario",
		"Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"]
		
	private static final String[] APODOS = #["Matute", "Tincho", "Nico", "Negro", "Andrés", "Gonza", "Marito",
		"Tito", "Lucho", "Chino", "Nestor", "Pepe", "Mariano"]
		

	private def void verificarQueElNombreEstaEnElPartido(String nombreJugador, Partido partido) {
		Assert.assertTrue(partido.jugadores.exists[jugador|jugador.nombre.equals(nombreJugador)])
	}

	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
		Assert.assertFalse(partido.jugadores.exists[jugador|jugador.nombre.equals(nombre)])
	}

	private def void verificarQueHayUnaInfraccionDelDiaDeHoy(Jugador jugador, LocalDate hoy) {
		Assert.assertTrue(jugador.infracciones.exists[infraccion|infraccion.fechaCreacion.equals(hoy)])
	}

	@Before
	def void init() {

		this.admin = new Admin("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido = this.admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		this.mockedMailSender = mock(MailSender)
		
		this.partido.registrarObserverDeInscripcion(new HayDiezJugadoresObserver(this.mockedMailSender))
		this.partido.registrarObserverDeInscripcion(new NotificarAmigosObserver(this.mockedMailSender))

		this.partido.registrarObserverDeBaja(new InfraccionObserver)
		this.partido.registrarObserverDeBaja(new NotificarAdministradorObserver(this.mockedMailSender))

		for (int i : 0 .. 7) {
			val jugador = new Jugador(NOMBRES.get(i), new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", APODOS.get(i))
			this.partido.agregarJugadorPartido(jugador)
		}
	}

	@Test
	def void seCompletaLaListaCon10Jugadores() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		val mariano = new Jugador("Mariano", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Mariano")
		this.partido.agregarJugadorPartido(mariano)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Mariano", partido)

		//verificamos que se haya enviado un mail al administrador notificando que hay10 juagores en la lista 
		verify(this.mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void seInscribeUnoPeroNoLleganADiez() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		//verificamos que NO se haya enviado un mail al admin, y como no tiene ningun amigo no se debe notificar a nadie
		verify(this.mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void JugadorSeInscribeYseAvisaAlosAmigos() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		val marcos = new Jugador("Marcos", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Marcos")
		this.partido.agregarJugadorPartido(marcos)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		enrique.agregarAmigo(marcos)

		//verificamos que se haya enviado un mail a los amigos
		verify(this.mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))

	}

	@Test
	def void unJugadorSeDaDeBajaDejaReemplazante() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		val marcos = new Jugador("Marcos", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Marcos")

		this.partido.reemplazarJugador(enrique, marcos)

		//verificamos que enrique ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//Verficamos que Marcos este en la lista 
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		//verificamos que no se haya mandado mail al administrador, como no tiene amigos no se debe mandar ningun mail
		verify(this.mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))

	}

	@Test
	def void unJugadorSeDaDeBajaYEran10EnLista() {

		var hoy = new LocalDate()

		val marcos = new Jugador("Marcos", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Marcos")
		this.partido.agregarJugadorPartido(marcos)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		this.partido.darDeBajaJugador(marcos)

		//verificamos que marcos ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)

		//Verificamos que Marcos haya sido penalizado
		verificarQueHayUnaInfraccionDelDiaDeHoy(marcos, hoy)

		//se mandan 2 mails al administrador 
		//1-notificando que el partido tiene 10 jugadores
		//2-notificando que el jugador se ha dado de baja
		verify(this.mockedMailSender, times(2)).mandarMail(any(typeof(Mail)))
	}

	@Test
	def void seDaDeBajaUnoPeroNoEran10() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		//verificamos que sean 9 en la lista
		Assert.assertEquals(9, partido.cantidadJugadoresEnLista)

		this.partido.darDeBajaJugador(enrique)
		//verificamos que se haya eliminado el jugador de la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//verificamos que no se haya notificado al admin, no tiene amigos.. 
		verify(this.mockedMailSender, times(0)).mandarMail(any(typeof(Mail)))

	}

	@Test
	def void seDaDeBajaUnoPeroTodaviaHay10() {

		val enrique = new Jugador("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		this.partido.agregarJugadorPartido(enrique)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Enrique", partido)

		val marcos = new Jugador("Marcos", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Marcos")
		this.partido.agregarJugadorPartido(marcos)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		//verificamos que le manda un mail al admin por que se llego a los 10 jugadores
		verify(mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))

		val augusto = new Jugador("Augusto", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Augusto")
		this.partido.agregarJugadorPartido(augusto)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Augusto", partido)

		//verificamos que sean 11 en la lista
		Assert.assertEquals(11, partido.cantidadJugadoresEnLista)

		this.partido.darDeBajaJugador(enrique)

		//verificamos que se haya eliminado el jugador de la lista
		verificarQueElNombreNoEstaEnElPartido("Enrique", partido)

		//verificamos que no se haya notificado de vuelta al admin
		verify(this.mockedMailSender, times(1)).mandarMail(any(typeof(Mail)))

	}
}