package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import ar.edu.dds.model.mail.MailSender
import ar.edu.dds.model.mail.Mail

class testsDecorator {
	Admin admin
	Partido partido
	
	//lista de 8 jugadores
	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario", "Carlos"]

	@Before
	def void init() {
		admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		NOMBRES.forEach[n|partido.agregarJugador(new Jugador(n, 21, new Estandar, "mimail@dds.com"))]

	}

	@Test
	def seCompletaLaListaCon10Jugadores() {
		val mockedMailSender = mock(typeof(MailSender))
		partido.mailSender = mockedMailSender
		
		//agregamos 2 jugadores estandar mas y se tendria que notificar al adm
		partido.agregarJugador(new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com"))
		partido.agregarJugador(new Admin("Mariano", 25, new Estandar, "mail@ejemplo.com"))
		
		verify(mockedMailSender, times(1)).enviar(any(typeof(Mail))
			
			
		)
	}

}
