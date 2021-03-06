package ar.edu.dds.persistence

import ar.edu.dds.model.Admin
import ar.edu.dds.model.ArmadorEquipos
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.Infraccion
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.equipos.JugadorEnEquipo
import ar.edu.dds.model.equipos.ParDeEquipos
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.baja.InfraccionObserver
import ar.edu.dds.observer.baja.NotificarAdministradorObserver
import ar.edu.dds.observer.inscripcion.HayDiezJugadoresObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import ar.edu.dds.observer.inscripcion.NotificarAmigosObserver
import ar.edu.dds.repository.hibernate.AdminHibernateRepo
import ar.edu.dds.repository.hibernate.JugadoresHibernateRepo
import ar.edu.dds.repository.hibernate.ModosInscripcionHibernateRepo
import ar.edu.dds.repository.hibernate.PartidosHibernateRepo
import junit.framework.Assert
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.Transaction
import org.hibernate.cfg.AnnotationConfiguration
import org.joda.time.DateTime
import org.joda.time.LocalDate
import org.junit.After
import org.junit.Before
import org.junit.Test

class Entrega9 {
	
	Transaction tran
	SessionFactory sessionFactory
	Session openSession
	
	val adminRepo = AdminHibernateRepo.instance
	val modosRepo = ModosInscripcionHibernateRepo.instance
	val partidosRepo = PartidosHibernateRepo.instance
	val jugadoresRepo = JugadoresHibernateRepo.instance
	
	Admin admin
	Partido partidoJugado
	
	//ModoDeInscripcion estandar
	Estandar estandar
	
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
		
		val configuration = new AnnotationConfiguration
		configuration.addAnnotatedClass(Jugador)
					 .addAnnotatedClass(Partido)
					 .addAnnotatedClass(Admin)
					 .addAnnotatedClass(ParDeEquipos)
					 .addAnnotatedClass(ModoDeInscripcion)
					 .addAnnotatedClass(Estandar)
					 .addAnnotatedClass(Infraccion)
					 .addAnnotatedClass(Calificacion)
					 .addAnnotatedClass(ArmadorEquipos)
					 .addAnnotatedClass(GeneradorDeEquipos)
					 .addAnnotatedClass(OrdenadorDeJugadores)
					 .addAnnotatedClass(InscripcionDeJugadorObserver)
					 .addAnnotatedClass(NotificarAmigosObserver)
					 .addAnnotatedClass(HayDiezJugadoresObserver)
					 .addAnnotatedClass(BajaDeJugadorObserver)
					 .addAnnotatedClass(NotificarAdministradorObserver)
					 .addAnnotatedClass(InfraccionObserver)
					 .addAnnotatedClass(ParDeEquipos)
					 .addAnnotatedClass(JugadorEnEquipo)
					   
		configuration.setProperty("hibernate.dialect", "org.hibernate.dialect.H2Dialect")
		configuration.setProperty("hibernate.connection.driver_class", "org.h2.Driver")
		configuration.setProperty("hibernate.connection.url", "jdbc:h2:mem")
		configuration.setProperty("hibernate.hbm2ddl.auto", "create")
		 
		sessionFactory = configuration.buildSessionFactory()
		openSession = sessionFactory.openSession
		
		estandar = new Estandar
		
		admin = new Admin("Enrique", new LocalDate(1989, 12, 12), estandar,	"mail@ejemplo.com",	"Quique")
		partidoJugado = new Partido(DateTime.now.minusDays(20), "Parque Patricios", admin)
		
		
		//JUGADORES
		
		jorge = new Jugador => [
			nombre = "Jorge"
			fechaNacimiento = new LocalDate(1988, 12, 2)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Jorgito"
			handicap = 8
			agregateInfraccion
			agregarAmigo(lucas)
			agregarAmigo(adrian)
			agregarAmigo(pablo)
		]
		
		matias = new Jugador => [
			nombre = "Matias"
			fechaNacimiento = new LocalDate(1989, 5, 7)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Matute"
			handicap = 5
			agregateInfraccion
			agregarAmigo(jorge)
			agregarAmigo(pablo)
			agregarAmigo(pedro)
		]
		
		carlos = new Jugador => [
			nombre = "Carlos"
			fechaNacimiento = new LocalDate(1987, 9, 9)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Chino"
			handicap = 3
			agregateInfraccion
		]
		
		pablo = new Jugador => [
			nombre = "Pablo"
			fechaNacimiento = new LocalDate(1978, 3, 7)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Pol"
			handicap = 2
			agregateInfraccion
		]
		
		pedro = new Jugador => [
			nombre = "Pedro"
			fechaNacimiento = new LocalDate(1988, 2, 11)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Pepe"
			handicap = 9
		]
		
		franco = new Jugador => [
			nombre = "Franco"
			fechaNacimiento = new LocalDate(1984, 12, 7)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Francho"
			handicap = 1
		]
		
		lucas = new Jugador => [
			nombre = "Lucas"
			fechaNacimiento = new LocalDate(1992, 6, 8)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Toto"
			handicap = 4
		]
		
		adrian = new Jugador => [
			nombre = "Adrian"
			fechaNacimiento = new LocalDate(1995, 12, 4)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Tano"
			handicap = 7
		]
		
		simon = new Jugador => [
			nombre = "Simon"
			fechaNacimiento = new LocalDate(1982, 12, 9)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Simba"
			handicap = 6
		]
		
		patricio = new Jugador => [
			nombre = "Patricio"
			fechaNacimiento = new LocalDate(1985, 12, 10)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Pato"
			handicap = 10
		]
		
		martin = new Jugador => [
			nombre = "Martin"
			fechaNacimiento = new LocalDate(1991, 2, 3)
			modoDeInscripcion = estandar
			mail = "mail@ejemplo.com"
			apodo = "Tincho"
			handicap = 10
		]
		
		
		//CALIFICACIONES
		
		calificacion1 = new Calificacion => [
			autor = pedro
			nota = 1
			partido = partidoJugado
		]

		calificacion2 = new Calificacion => [
			autor = pedro
			nota = 2
			partido = partidoJugado
		]

		calificacion3 = new Calificacion => [
			autor = patricio
			nota = 3
			partido = partidoJugado
		]

		calificacion4 = new Calificacion => [
			autor = matias
			nota = 4
			partido = partidoJugado
		]

		calificacion5 = new Calificacion => [
			autor = pedro
			nota = 5
			partido = partidoJugado
		]
		
		calificacion6 = new Calificacion => [
			autor = matias
			nota = 6
			partido = partidoJugado
		]

		calificacion7 = new Calificacion => [
			autor = pedro
			nota = 7
			partido = partidoJugado
		]

		calificacion8 = new Calificacion => [
			autor = matias
			nota = 8
			partido = partidoJugado
		]

		calificacion9 = new Calificacion => [
			autor = matias
			nota = 9
			partido = partidoJugado
		]

		calificacion10 = new Calificacion => [
			autor = patricio
			nota = 10
			partido = partidoJugado
		]
		
		tran = openSession.beginTransaction()
		
		modosRepo.add(estandar)
		adminRepo.add(admin)
		
		jugadoresRepo.add(pedro)
		jugadoresRepo.add(pablo)
		//jugadoresRepo.add(martin)
		jugadoresRepo.add(carlos)
		jugadoresRepo.add(franco)
		jugadoresRepo.add(lucas)
		jugadoresRepo.add(adrian)
		jugadoresRepo.add(simon)
		jugadoresRepo.add(patricio)
		jugadoresRepo.add(jorge)
		jugadoresRepo.add(matias)
		
		partidoJugado.agregarJugadorPartido(pedro)
		partidoJugado.agregarJugadorPartido(pablo)
		partidoJugado.agregarJugadorPartido(carlos)
		partidoJugado.agregarJugadorPartido(franco)
		partidoJugado.agregarJugadorPartido(lucas)
		partidoJugado.agregarJugadorPartido(adrian)
		partidoJugado.agregarJugadorPartido(simon)
		partidoJugado.agregarJugadorPartido(patricio)
		partidoJugado.agregarJugadorPartido(jorge)
		partidoJugado.agregarJugadorPartido(matias)

		
		partidosRepo.add (partidoJugado)
		
		matias.recibirCalificacion(calificacion1)
		
		jorge.recibirCalificacion(calificacion3)
		jorge.recibirCalificacion(calificacion4)
		jorge.recibirCalificacion(calificacion2)			
	
		carlos.recibirCalificacion(calificacion5)
		carlos.recibirCalificacion(calificacion6)
		
		pedro.recibirCalificacion(calificacion9)
		pedro.recibirCalificacion(calificacion10)

		franco.recibirCalificacion(calificacion4)
		franco.recibirCalificacion(calificacion5)
		
		lucas.recibirCalificacion(calificacion7)
		lucas.recibirCalificacion(calificacion8)
	}
	
	 @After
	 def void after() {
	  openSession.close()
	  sessionFactory.close()
	 }

	@Test
	def void jugadoresPendientesDeAprobacion(){
		Assert.assertEquals(10, jugadoresRepo.jugadoresPendientesDeAprobacion.size)
	}
	
	@Test
	def void seAgregaAMartinAlRepoDeJugadores()	{
		jugadoresRepo.add(martin)
		Assert.assertEquals(true, jugadoresRepo.existe(martin))
	}	

	@Test
	def void seApruebaJugador(){
		jugadoresRepo.aprobarJugador(matias)
		Assert.assertEquals(1, jugadoresRepo.jugadoresAprobados.size)
	}

	
}
