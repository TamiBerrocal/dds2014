package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.JugadoresRepo
import ar.edu.dds.ui.applicationmodel.BusquedaDeJugadores
import ar.edu.dds.model.Jugador

class JugadoresHibernateRepo extends AbstractRepoHibernate<Jugador> implements JugadoresRepo {
	
	override get(Long id, boolean deep) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override busquedaCompleta(BusquedaDeJugadores busqueda) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override buscarPorApodo(String string) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override aprobarJugador(Jugador jugador) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override buscarPorNombre(String s) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}