package ar.edu.dds.home

import ar.edu.dds.model.Partido
import java.util.List
import java.util.ArrayList
import ar.edu.dds.model.Admin
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import org.uqbar.commons.utils.Observable

@Observable
class PartidosHome {
	
	static PartidosHome INSTANCE
	
	@Property List<Partido> partidos
	
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
	}
	
	def inicializarStub() {
		val admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		val partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")
		
		JugadoresHome.getInstance.jugadoresAprobados.take(10).forEach[
			j | partido.agregarJugadorPartido(j)	
		]
		
		agregarPartido(partido)
		
	}
	
	def agregarPartido(Partido partido) {
		partidos.add(partido)
	}
	
}