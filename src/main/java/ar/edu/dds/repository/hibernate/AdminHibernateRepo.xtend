package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.hibernate.AbstractRepoHibernate
import ar.edu.dds.model.Admin

class AdminHibernateRepo extends AbstractRepoHibernate<Admin> {
	
	static AdminHibernateRepo INSTANCE
	
	def static AdminHibernateRepo getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new AdminHibernateRepo
		}
		INSTANCE
	}
}