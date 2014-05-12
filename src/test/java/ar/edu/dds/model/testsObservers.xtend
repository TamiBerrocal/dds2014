package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import junit.framework.Assert
import static org.mockito.Matchers.* 
import static org.mockito.Mockito.*

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
	def void unJugadorSeDaDeBaja() {

		val marcos = new Jugador("Marcos", 42, new Estandar, "mail@ejemplo.com")
		partido.agregarJugadorPartido(marcos)

		//verificamos que se haya agregado a la lista de jugadores
		verificarQueElNombreEstaEnElPartido("Marcos", partido)

		partido.darDeBajaJugador(marcos)

		//verificamos que marcos ya no este en la lista
		verificarQueElNombreNoEstaEnElPartido("Marcos", partido)

	//verificamos que marcos haya sido penalizado
	}

	@Test
	def void unJugadorSeDaDeBajaDejaReemplazante() {

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
	

        verify(mockedMailSender, times(1)).mandarMail(any(typeof (Mail)))
}


}
