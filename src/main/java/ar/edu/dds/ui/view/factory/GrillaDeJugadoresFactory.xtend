package ar.edu.dds.ui.view.factory

import ar.edu.dds.model.Jugador
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Panel

class GrillaDeJugadoresFactory {
	
	def static crearGrillaDeJugadores(Panel panelPadre, String elementosProperty, String seleccionadoProperty) {
		
		val table = new Table<Jugador>(panelPadre, typeof(Jugador)) => [
			bindItemsToProperty(elementosProperty)
			bindValueToProperty(seleccionadoProperty)
			height = 100
			width = 450
		
		]
		
		new Column<Jugador>(table) //
			.setTitle("Nombre")
			.setFixedSize(150)
			.bindContentsToProperty("nombre")
						
		new Column<Jugador>(table) //
			.setTitle("Apodo")
			.setFixedSize(150)
			.bindContentsToProperty("apodo")
			
		new Column<Jugador>(table) //
			.setTitle("Handicap")
			.setFixedSize(80)
			.bindContentsToProperty("handicap")
			
		new Column<Jugador>(table) //
			.setTitle("Promedio")
			.bindContentsToProperty("promedioUltimoPartido")
	}
}