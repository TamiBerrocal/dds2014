package ar.edu.dds.model

import org.junit.Before
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.junit.Test
import org.junit.Assert
import ar.edu.dds.exception.JugadorYaCalificadoParaEsePartidoException
import ar.edu.dds.home.JugadoresHome

class Entrega3Tests {

	Admin admin
	Partido partido
	
	JugadoresHome jugadoresHome

	Jugador matias
	Jugador jorge
	Jugador carlos
	Jugador pablo
	Jugador pedro
	Jugador franco

	@Before
	def void init() {

		this.admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		this.partido = this.admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		JugadoresHome.reset
		jugadoresHome = JugadoresHome.instance

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
	}

	@Test
	def void comprobarQueLosJugadoresEstanEnElPartido() {
		Assert.assertTrue(partido.estaEnElPartido(franco))
		Assert.assertTrue(partido.estaEnElPartido(matias))
		Assert.assertTrue(partido.estaEnElPartido(jorge))
	}

	/* *****************************************************************************
 	*                         Tests de las calificaciones
	********************************************************************************/
	@Test
	def void unJugadorCalificaAOtro() {

		val calificacion = new Calificacion
		calificacion.nota = 6
		calificacion.comentario = "Cabezeas muy mal, todo el resto OK"
		calificacion.autor = matias
		calificacion.partido = partido

		jorge.calificarJugador(matias, calificacion)

		Assert.assertTrue(matias.tieneCalificacion(calificacion))

	}

	@Test(expected=JugadorYaCalificadoParaEsePartidoException)
	def void unJugadorTrataDeCalificarDosVecesAlMismoJugador() {

		val calificacion1 = new Calificacion
		calificacion1.nota = 6
		calificacion1.comentario = "Cabeceas muy mal, todo el resto OK"
		calificacion1.autor = jorge
		calificacion1.partido = partido

		jorge.calificarJugador(matias, calificacion1)

		val calificacion2 = new Calificacion
		calificacion2.nota = 4
		calificacion2.comentario = "no corres nada!"
		calificacion2.autor = jorge
		calificacion2.partido = partido

		jorge.calificarJugador(matias, calificacion2)

	}

	/********************************************************************************
 	*                             Tests de proponer Amigos
	*******************************************************************************/
	@Test
	def void unJugadorProponeAUnAmigoYElAdminNoHaceNada() {

		val rodrigo = new Jugador("Rodrigo", 25, new Estandar, "mail@ejemplo.com")
		this.matias.recomendarAmigo(rodrigo)

		Assert.assertTrue(jugadoresHome.estaPendiente(rodrigo))
	}

	@Test
	def void unJugadorProponeUnAmigoYElAdminLoRechaza() {

		val rodrigo = new Jugador("Rodrigo", 25, new Estandar, "mail@ejemplo.com")
		this.matias.recomendarAmigo(rodrigo)

		//el admin rechaza el amigo del jugador 
		admin.rechazarJugador(rodrigo, "No sabe jugar")

		Assert.assertTrue(jugadoresHome.estaRechazado(rodrigo))
		Assert.assertFalse(jugadoresHome.estaPendiente(rodrigo))

	}

	@Test
	def void unJugadorProponeAmigoYseAcepta() {

		val rodrigo = new Jugador("Rodrigo", 25, new Estandar, "mail@ejemplo.com")
		this.matias.recomendarAmigo(rodrigo)

		//el admin acepta el amigo del jugador 
		admin.aprobarJugador(rodrigo)

		Assert.assertTrue(jugadoresHome.estaAprobado(rodrigo))
		Assert.assertFalse(jugadoresHome.estaPendiente(rodrigo))

	}

}
