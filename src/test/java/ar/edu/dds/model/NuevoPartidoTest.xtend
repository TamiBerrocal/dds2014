package ar.edu.dds.model

import junit.framework.Assert
import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.junit.Test
import org.joda.time.DateTime

class NuevoPartidoTest {
	
	Admin admin
	Partido partido
	
	private static final String[] NOMBRES = #["Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo",
											  "Mario", "Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano"] 
//	
//	private def void verificarQueElNombreEstaEnElPartido(String nombre, Partido partido) {
//		Assert.assertTrue(partido.jugadores.exists[ jugador | jugador.nombre.equals(nombre)])
//	}
//	
//	private def void verificarQueElNombreNoEstaEnElPartido(String nombre, Partido partido) {
//		Assert.assertFalse(partido.jugadores.exists[ jugador | jugador.nombre.equals(nombre)])
//	}
	
	@Before 
	def void init(){
		admin = new Admin ("Enrique", 25, new Estandar, "mail@ejemplo.com")
		partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		for (int i : 0..4) {
			val jugador = new Jugador(NOMBRES.get(i), 30, new Estandar, "mail@ejemplo.com")
			partido.agregarJugadorPartido(jugador)
		}
	}
	
	@Test
	def void comprobarEstadoPartido(){
		Assert.assertEquals(EstadoDePartido.ABIERTA_LA_INSCRIPCION, partido.estadoDePartido)
	}
	
}