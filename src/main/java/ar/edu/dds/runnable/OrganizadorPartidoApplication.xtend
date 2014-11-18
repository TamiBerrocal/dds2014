package ar.edu.dds.runnable

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.ui.view.OrganizadorWindow
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import org.uqbar.commons.utils.ApplicationContext
import ar.edu.dds.repository.hibernate.JugadoresHibernateRepo
import ar.edu.dds.repository.hibernate.PartidosHibernateRepo

class OrganizadorPartidoApplication extends Application {
	
	static def void main(String[] args) { 
		new OrganizadorPartidoApplication().start
	}

	override protected Window<?> createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(Jugador), new JugadoresHibernateRepo)
		ApplicationContext.instance.configureSingleton(typeof(Partido), new PartidosHibernateRepo)
		return new OrganizadorWindow(this)
	}
} 
