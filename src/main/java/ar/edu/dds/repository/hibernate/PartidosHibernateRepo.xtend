package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.PartidosRepo
import ar.edu.dds.model.Partido
import org.hibernate.HibernateException
import java.util.List

class PartidosHibernateRepo extends AbstractRepoHibernate<Partido> implements PartidosRepo {
	
	override get(Long id) {
		var Partido partido = null
		val session = sessionFactory.openSession
		try {
			partido = session.get(Partido, id) as Partido
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		partido
	}
	
	override todosLosPartidos() {
		var List<Partido> partidos = null
		val session = sessionFactory.openSession
		try {
			partidos = session
				.createCriteria(typeof(Partido))
				.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		partidos
	}
}