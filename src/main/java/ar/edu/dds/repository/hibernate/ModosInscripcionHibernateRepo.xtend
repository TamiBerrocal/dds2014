package ar.edu.dds.repository.hibernate

import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException

class ModosInscripcionHibernateRepo extends AbstractRepoHibernate<ModoDeInscripcion> {
	
	static ModosInscripcionHibernateRepo INSTANCE
	
	def static ModosInscripcionHibernateRepo getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new ModosInscripcionHibernateRepo
		}
		INSTANCE
	}
	

	def buscarPorNombre(String nombre){
		var ModoDeInscripcion result = null
		val session = sessionFactory.openSession
		try {
			result = session
					.createCriteria(typeof(ModoDeInscripcion))
					.createAlias("_ModosDeInscripcion", "modos")
					.add(Restrictions.eq("modos.prioridadInscripcion", nombre)) as ModoDeInscripcion
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	} 
	
}