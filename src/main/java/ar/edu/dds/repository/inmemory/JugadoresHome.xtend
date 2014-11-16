package ar.edu.dds.repository.inmemory

import java.util.List
import ar.edu.dds.model.Jugador
import java.util.ArrayList
import ar.edu.dds.model.Rechazo
import org.uqbar.commons.utils.Observable
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.Partido
import ar.edu.dds.model.Admin
import org.joda.time.DateTime
import org.joda.time.LocalDate
import ar.edu.dds.ui.applicationmodel.BusquedaDeJugadores
import ar.edu.dds.repository.JugadoresRepo

@Observable
class JugadoresHome implements JugadoresRepo {
	
	override actualizarJugador(Jugador jugador) {
	}

	static JugadoresHome INSTANCE

	List<Jugador> jugadoresAprobados
	List<Jugador> jugadoresPendientesDeAprobacion
	
	List<Rechazo> rechazos
	
	override List<Jugador> buscarPorNombre(String s) {
		todosLosJugadores.filter[ j | j.nombre.contains(s) ].toList
	}
	
	override List<Jugador> busquedaCompleta(BusquedaDeJugadores busqueda) {
		todosLosJugadores.filter[ j|
			j.tieneNombreQueEmpieza(busqueda.nombreJugador) &&
			j.tieneApodoCon(busqueda.apodoJugador) &&
			(busqueda.fechaNacJugador == null || 
				j.fechaDeNacimientoAnteriorA(busqueda.fechaNacJugador)) &&
			j.estaEnRangoDeHandicap(busqueda.minHandicapJugador, busqueda.maxHandicapJugador) &&
			j.estaEnRangoDePromedio(busqueda.minPromedioJugador, busqueda.maxPromedioJugador) &&
			busqueda.filtroDeInfracciones.aplica(j)].toList
	}
	
	
	def void recomendarNuevoJugador(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.add(jugador)
	}

	override void aprobarJugador(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.remove(jugador)
		this.jugadoresAprobados.add(jugador)
	}

	override void rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		this.jugadoresPendientesDeAprobacion.remove(jugador)
		this.rechazos.add(new Rechazo(jugador, motivoDeRechazo))
	}

	def boolean estaRechazado(Jugador jugador) {
		this.jugadoresRechazados().contains(jugador)
	}

	def boolean estaAprobado(Jugador jugador) {
		this.jugadoresAprobados.contains(jugador)

	}

	def boolean estaPendiente(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.contains(jugador)
	}

	// Singleton
	new() {
		this.jugadoresAprobados = new ArrayList
		this.jugadoresPendientesDeAprobacion = new ArrayList
		this.rechazos = new ArrayList
		inicializarStub
	}

	def static JugadoresHome getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new JugadoresHome
		}
		INSTANCE
	}
	
	def static void reset() {
		INSTANCE = new JugadoresHome
	}

	// Getters
	def List<Jugador> jugadoresAprobados() {
		this.jugadoresAprobados
	}

	def List<Jugador> jugadoresPendientesDeAprobacion() {
		this.jugadoresPendientesDeAprobacion
	}

	def List<Jugador> jugadoresRechazados() {
		this.rechazos.map[r|r.jugador]
	}

	def List<Rechazo> rechazos() {
		this.rechazos
	}
	
	override buscarPorApodo(String string) {
			todosLosJugadores.filter[ j | j.apodo.contains(string) ].toList
	}
		
	def List<Jugador> todosLosJugadores() {
		val result = new ArrayList<Jugador>
		result.addAll(jugadoresAprobados)
		result.addAll(jugadoresPendientesDeAprobacion)
		result.addAll(this.jugadoresRechazados)
		result
	}
	

	def inicializarStub() {
		
		val matias = new Jugador("Matias", new LocalDate(1989, 5, 7), new Estandar, "mail@ejemplo.com", "Matute")
		val jorge = new Jugador("Jorge", new LocalDate(1988, 12, 2), new Estandar, "mail@ejemplo.com", "Jorgito")
		val carlos = new Jugador("Carlos", new LocalDate(1987, 9, 9), new Estandar, "mail@ejemplo.com", "Chino")
		val pablo = new Jugador("Pablo", new LocalDate(1978, 3, 7), new Estandar, "mail@ejemplo.com", "Pol")
		val pedro = new Jugador("Pedro", new LocalDate(1988, 2, 11), new Estandar, "mail@ejemplo.com", "Pepe")
		val franco = new Jugador("Franco", new LocalDate(1984, 12, 7), new Estandar, "mail@ejemplo.com", "Francho")
		val lucas = new Jugador("Lucas", new LocalDate(1992, 6, 8), new Estandar, "mail@ejemplo.com", "Toto")
		val adrian = new Jugador("Adrian", new LocalDate(1995, 12, 4), new Estandar, "mail@ejemplo.com", "Tano")
		val simon = new Jugador("Simon", new LocalDate(1982, 12, 9), new Estandar, "mail@ejemplo.com", "Simba")
		val patricio = new Jugador("Patricio", new LocalDate(1985, 12, 10), new Estandar, "mail@ejemplo.com", "Pato")

		//handicaps
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
		
		val admin = new Admin("Enrique", new LocalDate(1989, 12, 12), new Estandar, "mail@ejemplo.com", "Quique")
		val algunPartidoYaJugado = new Partido(DateTime.now.minusDays(20), "Parque Patricios", admin)

		//Calificaciones jugadores
		val calificacion1 = new Calificacion
		calificacion1.autor = carlos
		calificacion1.nota = 1
		calificacion1.partido = algunPartidoYaJugado

		val calificacion2 = new Calificacion
		calificacion2.autor = pedro
		calificacion2.nota = 2
		calificacion2.partido = algunPartidoYaJugado

		val calificacion3 = new Calificacion
		calificacion3.autor = patricio
		calificacion3.nota = 3
		calificacion3.partido = algunPartidoYaJugado

		val calificacion4 = new Calificacion
		calificacion4.autor = simon
		calificacion4.nota = 4
		calificacion4.partido = algunPartidoYaJugado

		val calificacion5 = new Calificacion
		calificacion5.autor = franco
		calificacion5.nota = 5
		calificacion5.partido = algunPartidoYaJugado

		val calificacion6 = new Calificacion
		calificacion6.autor = lucas
		calificacion6.nota = 6
		calificacion6.partido = algunPartidoYaJugado

		val calificacion7 = new Calificacion
		calificacion7.autor = adrian
		calificacion7.nota = 7
		calificacion7.partido = algunPartidoYaJugado

		val calificacion8 = new Calificacion
		calificacion8.autor = jorge
		calificacion8.nota = 8
		calificacion8.partido = algunPartidoYaJugado

		val calificacion9 = new Calificacion
		calificacion9.autor = pablo
		calificacion9.nota = 9
		calificacion9.partido = algunPartidoYaJugado

		val calificacion10 = new Calificacion
		calificacion10.autor = adrian
		calificacion10.nota = 10
		calificacion10.partido = algunPartidoYaJugado
		
		matias.recibirCalificacion(calificacion10)
		matias.recibirCalificacion(calificacion8)
		
//		jorge.recibirCalificacion(calificacion7)
//		jorge.recibirCalificacion(calificacion3)

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
		
		//Infracciones jugadores
		matias.agregateInfraccion
		jorge.agregateInfraccion
		carlos.agregateInfraccion
		pablo.agregateInfraccion
		
		//Amigos jugadores
		matias.agregarAmigo(jorge)
		matias.agregarAmigo(pablo)
		matias.agregarAmigo(pedro)
		
		jorge.agregarAmigo(lucas)
		jorge.agregarAmigo(adrian)
		jorge.agregarAmigo(matias)
		jorge.agregarAmigo(pablo)
		
		jugadoresAprobados.addAll(matias, 
								  jorge,
								  carlos,
					     	      pablo,
								  pedro,
								  franco,
								  lucas,
								  adrian,
								  simon,
								  patricio)
	}
	

	
}
