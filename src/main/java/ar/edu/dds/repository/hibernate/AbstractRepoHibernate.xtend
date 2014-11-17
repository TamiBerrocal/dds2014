package ar.edu.dds.repository.hibernate

import org.apache.commons.collections.Closure
import org.hibernate.HibernateException
import org.hibernate.Session

abstract class AbstractRepoHibernate<T> {

	def getSessionFactory() {
		SingletonSessionFactory.instance
	}
	
	def T get(Long id) {}
	 
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
