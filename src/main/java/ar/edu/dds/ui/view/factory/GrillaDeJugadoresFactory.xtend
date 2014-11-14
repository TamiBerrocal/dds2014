package ar.edu.dds.ui.view.factory

import ar.edu.dds.model.Jugador
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.Panel
import ar.edu.dds.ui.view.adapters.CracksColorTransformer

class GrillaDeJugadoresFactory {
	
	def static crearGrillaDeJugadores(Panel panelPadre, String elementosProperty, String seleccionadoProperty) {
		
		val table = new Table<Jugador>(panelPadre, typeof(Jugador)) => [
			bindItemsToProperty(elementosProperty)
			bindValueToProperty(seleccionadoProperty)
//			height = 230
			width = 560
		]
		
		new Column<Jugador>(table) 
			.setTitle("Nombre")
			.bindBackground("esCrack", new CracksColorTransformer)
			.setFixedSize(125)
			.bindContentsToProperty("nombre")
						
		new Column<Jugador>(table) 
			.setTitle("Apodo")
			.bindBackground("esCrack", new CracksColorTransformer)
			.setFixedSize(125)
			.bindContentsToProperty("apodo")
		
		new Column<Jugador>(table) 
			.setTitle("Fecha de nacimiento")
			.bindBackground("esCrack", new CracksColorTransformer)
			.setFixedSize(150)
			.bindContentsToProperty("fechaNacimiento")
			
		new Column<Jugador>(table) 
			.setTitle("Handicap")
			.bindBackground("esCrack", new CracksColorTransformer)
			.setFixedSize(80)
			.bindContentsToProperty("handicap")
			
		new Column<Jugador>(table) 
			.setTitle("Promedio")
			.bindBackground("esCrack", new CracksColorTransformer)
			.setFixedSize(80)
			.bindContentsToProperty("promedioUltimoPartido")
	}
}