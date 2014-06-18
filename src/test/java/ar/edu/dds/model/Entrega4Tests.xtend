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
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeUltimasNCalificaciones
import ar.edu.dds.model.equipos.ordenador.OrdenadorCompuesto
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import java.util.List
import java.util.ArrayList
import ar.edu.dds.exception.NoHaySuficientesJugadoresException

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

		val calificacion1 = new Calificacion
		calificacion1.autor = carlos
		calificacion1.nota = 1
		calificacion1.partido = partido

		val calificacion2 = new Calificacion
		calificacion2.autor = pedro
		calificacion2.nota = 2
		calificacion2.partido = partido

		val calificacion3 = new Calificacion
		calificacion3.autor = patricio
		calificacion3.nota = 3
		calificacion3.partido = partido

		val calificacion4 = new Calificacion
		calificacion4.autor = simon
		calificacion4.nota = 4
		calificacion4.partido = partido

		val calificacion5 = new Calificacion
		calificacion5.autor = franco
		calificacion5.nota = 5
		calificacion5.partido = partido

		val calificacion6 = new Calificacion
		calificacion6.autor = lucas
		calificacion6.nota = 6
		calificacion6.partido = partido

		val calificacion7 = new Calificacion
		calificacion7.autor = adrian
		calificacion7.nota = 7
		calificacion7.partido = partido

		val calificacion8 = new Calificacion
		calificacion8.autor = jorge
		calificacion8.nota = 8
		calificacion8.partido = partido

		val calificacion9 = new Calificacion
		calificacion9.autor = pablo
		calificacion9.nota = 9
		calificacion9.partido = partido

		val calificacion10 = new Calificacion
		calificacion10.autor = adrian
		calificacion10.nota = 10
		calificacion10.partido = partido
		
		matias.recibirCalificacion(calificacion10)
		matias.recibirCalificacion(calificacion8)

		jorge.recibirCalificacion(calificacion7)
		jorge.recibirCalificacion(calificacion3)

		carlos.recibirCalificacion(calificacion8)
		carlos.recibirCalificacion(calificacion9)

		pablo.recibirCalificacion(calificacion6)
		pablo.recibirCalificacion(calificacion7)

		pedro.recibirCalificacion(calificacion9)
		pedro.recibirCalificacion(calificacion10)

		franco.recibirCalificacion(calificacion4)
		franco.recibirCalificacion(calificacion5)

		lucas.recibirCalificacion(calificacion1)
		lucas.recibirCalificacion(calificacion2)

		adrian.recibirCalificacion(calificacion3)
		adrian.recibirCalificacion(calificacion4)

		simon.recibirCalificacion(calificacion3)
		simon.recibirCalificacion(calificacion1)

		patricio.recibirCalificacion(calificacion5)
		patricio.recibirCalificacion(calificacion6)
	}

	/* *****************************************************************************
 	*                                     Tests                                    *
	********************************************************************************/
	//--------------Test 1------------------
	@Test
	def void testOrdenarPorHandicapYGenerarEquipoPorParesEImpares() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorHandicap,
			new GeneradorDeEquiposParesContraImpares
		)

		//Verificamos que los jugadores se encuentren en los Equipos que corresponde
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))

		Assert.assertTrue(this.partido.equipos.equipo2.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(matias))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pedro))
		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

	}

	//--------------Test 2------------------
	@Test
	def void testOrdenarPorHandicapYGenerarEquipoPor14589Vs236710() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorHandicap,
			new GeneradorDeEquipos14589Vs236710
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//verificamos que todos los jugadores esten donde corresponde
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))

		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(patricio))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//-------------Test 3------------------
	@Test
	def void testOrdenarPorPromedioDeCalificacionesDelUltimoPartidoYGeneraEquipoPorParidad() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido,
			new GeneradorDeEquiposParesContraImpares
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//verificamos que todos los jugadores esten donde corresponde
		Assert.assertTrue(this.partido.equipos.equipo1.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))

		Assert.assertTrue(this.partido.equipos.equipo2.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(matias))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

	}

	//--------------Test 4------------------
	@Test
	def void testOrdenarPorPromedioDeCalificacionesDelUltimoPartidoYGeneraEquipoPor14589Vs236710() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido,
			new GeneradorDeEquipos14589Vs236710
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//Verificamos para el equipo1 las posiciones 14589
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))

		//Verificamos para el equipo2 las posiciones 236710
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pedro))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

	}

	//--------------Test 5------------------
	@Test
	def void testOrdenarPorPromedioDeNCalificacionesYGenereEquipoPorParidad() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeUltimasNCalificaciones(2),
			new GeneradorDeEquiposParesContraImpares
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//verificamos que todos los jugadores esten donde corresponde
		Assert.assertTrue(this.partido.equipos.equipo1.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))

		Assert.assertTrue(this.partido.equipos.equipo2.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(matias))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//-------------------test 6-------------------
	@Test
	def void testOrdenarPorPromedioDeNCalificacionesYGenereEquipoPor14589Vs236710() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeUltimasNCalificaciones(2),
			new GeneradorDeEquipos14589Vs236710
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//Verificamos para el equipo1 las posiciones 14589
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))

		//Verificamos para el equipo2 las posiciones 236710
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pedro))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//-------------------Test 7---------------------
	@Test
	def void testOrdenarPorHandicapYUltimasCalificacionesOrdenarPorParidad() {

		var List<OrdenadorDeJugadores> listaOrdenadores = new ArrayList
		listaOrdenadores.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		listaOrdenadores.add(new OrdenadorPorHandicap)

		this.partido.generarEquiposTentativos(
			new OrdenadorCompuesto(listaOrdenadores),
			new GeneradorDeEquiposParesContraImpares
		)

		//verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//verificamos que todos los jugadores esten donde corresponde en cada equipo
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))

		Assert.assertTrue(this.partido.equipos.equipo2.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(patricio))

		this.partido.confirmar

		//Confirmo  el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//---------------Test 8----------------------------
	@Test
	def void testOrdenarPorHandicapYUltimasCalificacionesOrdenarPorAlgoritmoRaro() {

		var List<OrdenadorDeJugadores> listaOrdenadores = new ArrayList
		listaOrdenadores.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		listaOrdenadores.add(new OrdenadorPorHandicap)

		this.partido.generarEquiposTentativos(
			new OrdenadorCompuesto(listaOrdenadores),
			new GeneradorDeEquipos14589Vs236710
		)

		//verificamos que los 2 equipos tengan 5 jugadores cada uno
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//Verificamos para el equipo1 las posiciones 14589
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))

		//Verificamos para el equipo2 las posiciones 236710
		Assert.assertTrue(this.partido.equipos.equipo2.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pedro))

		this.partido.confirmar

		//Confirmamos el equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

	}
	
	//-------------------Test 11---------------------
	@Test
	def void testOrdenarPorPromedioDeCalificacionesDelUltimoPartidoYPorPromedioDeUltimas2CalificacionesYGenerarEquipoPorParidad() {
	
		var List<OrdenadorDeJugadores> ordenadoresDeJugadores = new ArrayList
		ordenadoresDeJugadores.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		ordenadoresDeJugadores.add(new OrdenadorPorPromedioDeUltimasNCalificaciones(2))

		this.partido.generarEquiposTentativos(
			new OrdenadorCompuesto(ordenadoresDeJugadores),
			new GeneradorDeEquiposParesContraImpares
		)

		//Verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//Verificamos que el equipo1 contenga las posiciones pares
		Assert.assertTrue(this.partido.equipos.equipo1.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(pedro))

		//Verificamos que el equipo2 contenga las posiciones impares
		Assert.assertTrue(this.partido.equipos.equipo2.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(matias))

		this.partido.confirmar

		//Verificamos que el equipo esté confirmado
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//-------------------Test 12---------------------
	@Test
	def void testOrdenarPorPromedioDeCalificacionesDelUltimoPartidoYPorPromedioDeUltimas2CalificacionesYGenerarEquipoPor14589Vs236710() {
	
		var List<OrdenadorDeJugadores> ordenadoresDeJugadores = new ArrayList
		ordenadoresDeJugadores.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		ordenadoresDeJugadores.add(new OrdenadorPorPromedioDeUltimasNCalificaciones(2))

		this.partido.generarEquiposTentativos(
			new OrdenadorCompuesto(ordenadoresDeJugadores),
			new GeneradorDeEquipos14589Vs236710
		)

		//Verificamos que ambos equipos tengan 5 jugadores
		Assert.assertEquals(5, this.partido.equipos.equipo1.size)
		Assert.assertEquals(5, this.partido.equipos.equipo2.size)

		//Verificamos que el equipo1 contenga las posiciones 14589
		Assert.assertTrue(this.partido.equipos.equipo1.contains(lucas))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(franco))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(jorge))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(carlos))
		Assert.assertTrue(this.partido.equipos.equipo1.contains(matias))

		//Verificamos que el equipo2 contenga las posiciones 236710
		Assert.assertTrue(this.partido.equipos.equipo2.contains(simon))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(adrian))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(patricio))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pablo))
		Assert.assertTrue(this.partido.equipos.equipo2.contains(pedro))

		this.partido.confirmar

		//Verificamos que el equipo esté confirmado
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)
	}

	//--------------Test 13------------------
	@Test(expected=EstadoDePartidoInvalidoException)
	def void testConfirmarEquipoYNoSePuedeDarDeAltaJugador() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido,
			new GeneradorDeEquiposParesContraImpares
		)

		this.partido.confirmar

		//Confirmamos el estado del equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

		this.partido.agregarJugadorPartido(matias)
	}

	//--------------Test 14------------------
	@Test(expected=EstadoDePartidoInvalidoException)
	def void testConfirmarEquipoYNoSePuedeDarDeBajaJugador() {

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido,
			new GeneradorDeEquiposParesContraImpares
		)

		this.partido.confirmar

		//Confirmamos el estado del equipo
		Assert.assertEquals(EstadoDePartido.CONFIRMADO, this.partido.estadoDePartido)

		this.partido.darDeBajaJugador(matias)
	}

	//------------Test 15--------------------------
	@Test(expected=NoHaySuficientesJugadoresException)
	def void testTratarDeGenerarEquiposTentativosConJugadoresInsuficientes() {
		this.partido.darDeBajaJugador(matias)

		//corroborar que no pertenezca a la lista de jugadores
		Assert.assertEquals(9, this.partido.cantidadJugadoresEnLista)

		this.partido.generarEquiposTentativos(
			new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido,
			new GeneradorDeEquiposParesContraImpares
		)

	}

}
