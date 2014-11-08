package ar.edu.dds.repository.inmemory

import ar.edu.dds.model.Partido
import java.util.List
import java.util.ArrayList
import ar.edu.dds.model.Admin
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable
import org.joda.time.LocalDate
import ar.edu.dds.repository.PartidosRepo

@Observable
class PartidosHome implements PartidosRepo {
	
	static PartidosHome INSTANCE
	
	@Property List<Partido> partidos
	
	override List<Partido> todosLosPartidos() {
		partidos
	}
	
	// Singleton
	new() {
		this.partidos = new ArrayList
		inicializarStub
	}

	def static PartidosHome getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new PartidosHome
		}
		INSTANCE
	}
	
	def static void reset() {
		INSTANCE = new PartidosHome
		INSTANCE.inicializarStub
	}
	
	def inicializarStub() {
		val admin = new Admin("Enrique", new LocalDate(1989, 12, 6), new Estandar, "mail@ejemplo.com", "Quique")
		val partido = admin.organizarPartido(new DateTime(2014, 5, 4, 21, 0), "Avellaneda")
		
		JugadoresHome.getInstance.jugadoresAprobados.take(10).forEach[
			j | partido.agregarJugadorPartido(j)	
		]
		
		agregarPartido(partido)
		
	}
	
	def agregarPartido(Partido partido) {
		partidos.add(partido)
	}
	
}