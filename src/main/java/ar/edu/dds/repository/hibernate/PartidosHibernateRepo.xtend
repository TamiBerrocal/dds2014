package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.PartidosRepo
import ar.edu.dds.model.Partido

class PartidosHibernateRepo extends AbstractRepoHibernate<Partido> implements PartidosRepo {
	
	override get(Long id, boolean deep) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override todosLosPartidos() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
}