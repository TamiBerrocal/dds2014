package ar.edu.dds.repository.hibernate

import org.apache.commons.collections.Closure
import org.hibernate.HibernateException
import org.hibernate.Session

abstract class AbstractRepoHibernate<T> {

	def getSessionFactory() {
		SingletonSessionFactory.instance
	}
	
	def T get(Long id) {}

	 
	/* Para el test */
	/* Necesitamos siempre hacer lo mismo:
	 * 1) abrir la sesión
	 * 2) ejecutar un query que actualice
	 * 3) commitear los cambios 
	 * 4) y cerrar la sesión
	 * 5) pero además controlar errores
	 * Entonces definimos un método executeBatch que hace eso
	 * y recibimos un closure que es lo que cambia cada vez
	 * (otra opción podría haber sido definir un template method)
	 */
	 
	 
	def void add(T object) {
		this.executeBatch([ session| (session as Session).saveOrUpdate(object)])
	}
		
	def void delete(T object) {
		this.executeBatch([ session| (session as Session).delete(object)])
	}
	
	def void executeBatch(Closure closure) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			closure.execute(session)
			session.transaction.commit
		} catch (HibernateException e) {
			session.transaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void deleteAll() {
		this.executeBatch([ session| (session as Session)
									.createCriteria(this.class)
									.list
									.forEach [ elem | this.delete(elem) ]
		])
	}

}
