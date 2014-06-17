package ar.edu.dds.model

import ar.edu.dds.model.equipos.generador.GeneradorDeEquiposParesContraImpares
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorHandicap
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeCalificacionesDelUltimoPartido
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos14589Vs236710
import ar.edu.dds.exception.EstadoDePartidoInvalidoException

class Entrega4Tests {
	
	Admin admin
	Partido partido
	
	Jugador matias
	Jugador jorge
	Jugador carlos
	Jugador pablo
	Jugador pedro
	Jugador franco
	Jugador lucas
	Jugador adrian
	Jugador simon
	Jugador patricio
	
	
	@Before
	def void init() {
		
		this.admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		this.partido = this.admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")	
		
		matias = new Jugador("Matias", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(matias)

		jorge = new Jugador("Jorge", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(jorge)

		carlos = new Jugador("Carlos", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(carlos)

		pablo = new Jugador("Pablo", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(pablo)

		pedro = new Jugador("Pedro", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(pedro)

		franco = new Jugador("Franco", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(franco)
		
		lucas = new Jugador("lucas", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(lucas)
		
		adrian = new Jugador("adrian", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(adrian)
		
		simon = new Jugador("simon", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(simon)
		
		patricio = new Jugador("patricio", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(patricio)
		
		matias.handicap = 5
		jorge.handicap = 8
		carlos.handicap = 3
		pablo.handicap = 2
		pedro.handicap = 9
	 	franco.handicap = 1
	 	lucas.handicap = 4
	 	adrian.handicap = 7
	 	simon.handicap = 6
	 	patricio.handicap = 10
	 	
	 	val calificacion = new Calificacion
		calificacion.nota = 10
		calificacion.partido = partido
		
		val calificacion1 = new Calificacion
		calificacion1.nota = 1
		calificacion1.partido = partido
	
		val calificacion2 = new Calificacion
		calificacion2.nota = 2
		calificacion2.partido = partido
		
		val calificacion3 = new Calificacion
		calificacion3.nota = 3
		calificacion3.partido = partido
	
		val calificacion4 = new Calificacion
		calificacion4.nota = 4
		calificacion4.partido = partido
		
		val calificacion5 = new Calificacion
		calificacion5.nota = 5
		calificacion5.partido = partido
		
		val calificacion6 = new Calificacion
		calificacion6.nota = 6
		calificacion6.partido = partido
	
		val calificacion7 = new Calificacion
		calificacion7.nota = 7
		calificacion7.partido = partido
		
		val calificacion8 = new Calificacion
		calificacion8.nota = 8
		calificacion8.partido = partido
	
		val calificacion9 = new Calificacion
		calificacion9.nota = 9
		calificacion9.partido = partido
		
		matias.recibirCalificacion(calificacion)
		jorge.recibirCalificacion(calificacion7)
		carlos.recibirCalificacion(calificacion8)
		pablo.recibirCalificacion(calificacion6)
		pedro.recibirCalificacion(calificacion9)
	 	franco.recibirCalificacion(calificacion4)
	 	lucas.recibirCalificacion(calificacion1)
	 	adrian.recibirCalificacion(calificacion3)
	 	simon.recibirCalificacion(calificacion2)
	 	patricio.recibirCalificacion(calificacion5)
	 	
	}
	
	/* *****************************************************************************
 	*                                     Tests                                    *
	********************************************************************************/

	@Test
	def void testOrdenarPorHandicapYGenerarEquipoPorParesEImpares(){
		
		val ordenadosPorHandicap = new OrdenadorPorHandicap
		val generadosEquiposPorParesEImpares = new GeneradorDeEquiposParesContraImpares
		
		this.partido.jugadores = ordenadosPorHandicap.ordenar(this.partido.jugadores)
		
		//verificamos que el que tiene el peor handicap sea el primero de la lista
		Assert.assertEquals(1, this.partido.jugadores.get(0).handicap)
		//verificamos que el que tiene el mejor handicap sea el ultimo de la lista
		Assert.assertEquals(10, this.partido.jugadores.get(9).handicap)
		
		this.partido.equipos = generadosEquiposPorParesEImpares.generar(this.partido.jugadores)
		
		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)
		
		//Verificamos que Franco se encuentre en el Equipo de los pares ya que esta en la posicion 0 de la lista
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		
		this.partido.confirmar
	 	//Confirmamos el equipo
	 	Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
		
	}
	
	@Test
	def void testOrdenarPorPromedioDeCalificacionesDelUltimoPartidoYGeneraEquipoPor14589Vs236710(){
		
		val ordenadosPorPromCalificUltPart = new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido
		val generadosEquiposPor14589Vs236710 = new GeneradorDeEquipos14589Vs236710
		
		this.partido.jugadores = ordenadosPorPromCalificUltPart.ordenar(this.partido.jugadores)
	 	
	 	//verificamos que Lucas sea el Jugador con el peor promedio
	 	Assert.assertEquals("lucas",this.partido.jugadores.get(0).nombre)
	 	
	 	this.partido.equipos = generadosEquiposPor14589Vs236710.generar(this.partido.jugadores)
	 	
	 	//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)
		
		//Verificamos para el equipo1 las posiciones 14589
	 	Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
	 	Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
	 	Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))
	 	Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
	 	Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))
	 	
		//Verificamos para el equipo2 las posiciones 236710
	 	Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
	 	Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
	 	Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
	 	Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
	 	Assert.assertTrue(this.partido.equipos.equipo2.contains(matias))
	 	
	 	
	 	this.partido.confirmar
	 	//Confirmamos el equipo
	 	Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	 		 	
	}
	
	@Test(expected=EstadoDePartidoInvalidoException)
	def void confirmarEquipoYNoSePuedeDarDeBajaJugador(){
		
		val ordenadosPorPromCalificUltPart = new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido
		val generadosEquiposPorParesEImpares = new GeneradorDeEquiposParesContraImpares
		
		this.partido.jugadores = ordenadosPorPromCalificUltPart.ordenar(this.partido.jugadores)
		this.partido.equipos = generadosEquiposPorParesEImpares.generar(this.partido.jugadores)
		
		this.partido.confirmar
		
		this.partido.darDeBajaJugador(matias)
	}
		
}