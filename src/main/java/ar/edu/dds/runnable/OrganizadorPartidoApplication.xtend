package ar.edu.dds.runnable

import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window
import org.uqbar.commons.utils.ApplicationContext
import ar.edu.dds.home.JugadoresHome
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.home.PartidosHome
import ar.edu.dds.ui.view.OrganizadorWindow

class OrganizadorPartidoApplication extends Application {
	
	static def void main(String[] args) { 
		new OrganizadorPartidoApplication().start
	}

	override protected Window<?> createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(Jugador), new JugadoresHome)
		ApplicationContext.instance.configureSingleton(typeof(Partido), new PartidosHome)
		return new OrganizadorWindow(this)
	}
} 
