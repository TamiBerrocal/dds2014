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
	
	/*def actualizarModo(ModoDeInscripcion modo) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.saveOrUpdate(modo)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}*/
	
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