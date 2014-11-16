package ar.edu.dds.persistence

import ar.edu.dds.repository.hibernate.JugadoresHibernateRepo
import ar.edu.dds.repository.hibernate.PartidosHibernateRepo
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Admin
import ar.edu.dds.model.Partido
import org.junit.Before
import org.joda.time.LocalDate
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.model.Calificacion
import org.junit.Test
import junit.framework.Assert
import org.joda.time.DateTimeimport org.junit.After

class Entrega9 {
	
	JugadoresHibernateRepo jugadoresRepo = JugadoresHibernateRepo.instance
	PartidosHibernateRepo partidosRepo =  PartidosHibernateRepo.instance
	
	Admin admin
	Partido partido
	
	Calificacion calificacion1
	Calificacion calificacion2
	Calificacion calificacion3
	Calificacion calificacion4
	Calificacion calificacion5
	Calificacion calificacion6
	Calificacion calificacion7
	Calificacion calificacion8
	Calificacion calificacion9
	Calificacion calificacion10
			
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
	Jugador martin
	
	@Before
	def init() {
		
		admin = new Admin("Enrique", new LocalDate(1989, 12, 12), new Estandar,	"mail@ejemplo.com",	"Quique")
		partido = new Partido(DateTime.now.minusDays(20), "Parque Patricios", admin)
		
		//CALIFICACIONES
		
		calificacion1 = new Calificacion => [
		autor = carlos
		nota = 1
		partido = partido
		]

		calificacion2 = new Calificacion => [
		autor = pedro
		nota = 2
		partido = partido
		]

		calificacion3 = new Calificacion => [
		autor = patricio
		nota = 3
		partido = partido
		]

		calificacion4 = new Calificacion => [
		autor = simon
		nota = 4
		partido = partido
		]

		calificacion5 = new Calificacion => [
		autor = franco
		nota = 5
		partido = partido
		]
		
		calificacion6 = new Calificacion => [
		autor = lucas
		nota = 6
		partido = partido
		]

		calificacion7 = new Calificacion => [
		autor = adrian
		nota = 7
		partido = partido
		]

		calificacion8 = new Calificacion => [
		autor = jorge
		nota = 8
		partido = partido
		]

		calificacion9 = new Calificacion => [
		autor = pablo
		nota = 9
		partido = partido
		]

		calificacion10 = new Calificacion => [
		autor = adrian
		nota = 10
		partido = partido
		]
		
		//JUGADORES
				
		matias = new Jugador => [
			nombre = "Matias"
			fechaNacimiento = new LocalDate(1989, 5, 7)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Matute"
			handicap = 5
			recibirCalificacion(calificacion10)
			recibirCalificacion(calificacion8)
			agregateInfraccion
			agregarAmigo(jorge)
			agregarAmigo(pablo)
			agregarAmigo(pedro)
		]
		
		jorge = new Jugador => [
			nombre = "Jorge"
			fechaNacimiento = new LocalDate(1988, 12, 2)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Jorgito"
			handicap = 8
			recibirCalificacion(calificacion7)
			recibirCalificacion(calificacion3)
			agregateInfraccion
			agregarAmigo(lucas)
			agregarAmigo(adrian)
			agregarAmigo(matias)
			agregarAmigo(pablo)
		]
		
		carlos = new Jugador => [
			nombre = "Carlos"
			fechaNacimiento = new LocalDate(1987, 9, 9)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Chino"
			handicap = 3
			recibirCalificacion(calificacion8)
			recibirCalificacion(calificacion9)
			agregateInfraccion
		]
		
		pablo = new Jugador => [
			nombre = "Pablo"
			fechaNacimiento = new LocalDate(1978, 3, 7)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Pol"
			handicap = 2
			recibirCalificacion(calificacion6)
			recibirCalificacion(calificacion7)
			agregateInfraccion
		]
		
		pedro = new Jugador => [
			nombre = "Pedro"
			fechaNacimiento = new LocalDate(1988, 2, 11)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Pepe"
			handicap = 9
			recibirCalificacion(calificacion9)
			recibirCalificacion(calificacion10)
		]
		
		franco = new Jugador => [
			nombre = "Franco"
			fechaNacimiento = new LocalDate(1984, 12, 7)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Francho"
			handicap = 1
			recibirCalificacion(calificacion4)
			recibirCalificacion(calificacion5)
		]
		
		lucas = new Jugador => [
			nombre = "Lucas"
			fechaNacimiento = new LocalDate(1992, 6, 8)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Toto"
			handicap = 4
			recibirCalificacion(calificacion1)
			recibirCalificacion(calificacion2)
		]
		
		adrian = new Jugador => [
			nombre = "Adrian"
			fechaNacimiento = new LocalDate(1995, 12, 4)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Tano"
			handicap = 7
			recibirCalificacion(calificacion3)
			recibirCalificacion(calificacion4)
		]
		
		simon = new Jugador => [
			nombre = "Simon"
			fechaNacimiento = new LocalDate(1982, 12, 9)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Simba"
			handicap = 6
			recibirCalificacion(calificacion3)
			recibirCalificacion(calificacion1)
		]
		
		patricio = new Jugador => [
			nombre = "Patricio"
			fechaNacimiento = new LocalDate(1985, 12, 10)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Pato"
			handicap = 10
			recibirCalificacion(calificacion5)
			recibirCalificacion(calificacion6)
		]
		
		martin = new Jugador => [
			nombre = "Martin"
			fechaNacimiento = new LocalDate(1991, 2, 3)
			modoDeInscripcion = new Estandar
			mail = "mail@ejemplo.com"
			apodo = "Tincho"
			handicap = 10
		]
		
		jugadoresRepo.actualizarJugador(matias)
		jugadoresRepo.actualizarJugador(jorge)
		jugadoresRepo.actualizarJugador(carlos)
		jugadoresRepo.actualizarJugador(pablo)
		jugadoresRepo.actualizarJugador(pedro)
		jugadoresRepo.actualizarJugador(franco)
		jugadoresRepo.actualizarJugador(lucas)
		jugadoresRepo.actualizarJugador(adrian)
		jugadoresRepo.actualizarJugador(simon)
		jugadoresRepo.actualizarJugador(patricio)
		
		partidosRepo.add (partido)

	}
	
	@After
	def void limpiarBase(){
		jugadoresRepo.deleteAll
		partidosRepo.deleteAll
	}
	
	
	@Test
	def void seAgregaAMartinAlRepoDeJugadores()	{
		jugadoresRepo.actualizarJugador(martin)
		Assert.assertEquals(true, jugadoresRepo.existe(martin))				
	}
	
<<<<<<< HEAD
	
	@Test
	def void seApruebaJugador(){
		jugadoresRepo.aprobarJugador(matias)
		Assert.assertEquals(1, jugadoresRepo.jugadoresAprobados.size)		
	}
	
	
	@Test
	def void jugadoresPendientesDeAprobacion(){
		Assert.assertEquals(10, jugadoresRepo.jugadoresPendientesDeAprobacion.size)		
	}
	
	
=======
>>>>>>> 9cd6b56c34eeeaa5b5a022e9104c1e69b300b443
}
