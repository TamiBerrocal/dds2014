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
		
		val colNombre = new Column<Jugador>(table)
		colNombre.setTitle("Nombre")
				 .setFixedSize(125)
				 .bindContentsToProperty("nombre")
			
		colNombre.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
						
		val colApodo = new Column<Jugador>(table) 
		colApodo.setTitle("Apodo")
				.setFixedSize(125)
				.bindContentsToProperty("apodo")
		
		val colFechaNac = new Column<Jugador>(table) 
		colFechaNac.setTitle("Fecha de nacimiento")
					.setFixedSize(150)
					.bindContentsToProperty("fechaNacimiento")
			
		val colHandicap = new Column<Jugador>(table) 
		colHandicap.setTitle("Handicap")
				   .setFixedSize(80)
				   .bindContentsToProperty("handicap")
			
		val colPromedio = new Column<Jugador>(table) 
		colPromedio.setTitle("Promedio")
				   .setFixedSize(80)
				   .bindContentsToProperty("promedioUltimoPartido")
				   
		colNombre.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
		colApodo.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
		colFechaNac.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
		colHandicap.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
		colPromedio.bindBackground("esCrack").setTransformer(new CracksColorTransformer)
	}
}