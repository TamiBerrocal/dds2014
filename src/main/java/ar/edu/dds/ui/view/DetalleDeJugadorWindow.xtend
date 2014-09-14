package ar.edu.dds.ui.view

import ar.edu.dds.model.Infraccion
import ar.edu.dds.model.Jugador
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ar.edu.dds.ui.applicationmodel.OrganizadorPartido

class DetalleDeJugadorWindow extends Dialog<OrganizadorPartido> {
		
	new(WindowOwner owner, OrganizadorPartido organizadorPartido) {
		super(owner, organizadorPartido)
		title = "Datos del jugador"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val panel = new Panel(mainPanel)
		panel.setLayout(new ColumnLayout(2))
		
		new Label(panel).text = "Nombre"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.nombre")
		
		new Label(panel).text = "Apodo"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.apodo")
		
		new Label(panel).text = "Handicap"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.handicap")
		
		new Label(panel).text = "Promedio del último partido"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.promedioUltPartido")
		
		new Label(panel).text = "Promedio general"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.promedio")
			
		new Label(panel).text = "Fecha de nacimiento"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.fechaNacimiento")
		
		new Label(panel).text = "Cantidad de partidos jugados"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.partidosJugados")
				
		var labelEq1 = new Label(panel)
		labelEq1.setText("Amigos:")
//		labelEq1.fontSize = 10
		var labelEq2 = new Label(panel)
		labelEq2.setText("Infracciones:")
//		labelEq2.fontSize = 10
		
		this.crearGridAmigos(panel)
		this.crearGridInfracciones(panel)
		
	}
	
	def crearGridInfracciones(Panel panel) {
		var table = new Table<Infraccion>(panel, typeof(Infraccion))
		table.height = 100
		table.width = 450
		table.bindItemsToProperty("jugadorSeleccionado.infracciones")
		table.bindValueToProperty("infraccionSeleccionada")
		
		new Column<Infraccion>(table)
			.setTitle("Fecha").setFixedSize(125)
			.bindContentsToProperty("fechaCreacion")

		new Column<Infraccion>(table) 
			.setTitle("Hora").setFixedSize(125)
			.bindContentsToProperty("hora")	
		
		new Column<Infraccion>(table)
			.setTitle("Motivo")
//			.setFixedSize(200)
			.bindContentsToProperty("causa")

	}
	
	def crearGridAmigos(Panel panel) {
		var table = new Table<Jugador>(panel, typeof(Jugador))
		table.height = 100
		table.width = 450
		table.bindItemsToProperty("jugadorSeleccionado.amigos")
		table.bindValueToProperty("amigoSeleccionado")
		
		new Column<Jugador>(table)
			.setTitle("Nombre").setFixedSize(150)
			.bindContentsToProperty("nombre")

		new Column<Jugador>(table) 
			.setTitle("Apodo").setFixedSize(150)
			.bindContentsToProperty("apodo")
			
		
		new Column<Jugador>(table)
			.setTitle("Handicap").setFixedSize(75)
			.bindContentsToProperty("handicap")
		
		new Column<Jugador>(table)
			.setTitle("Promedio")
//			.setFixedSize(75)
			.bindContentsToProperty("promedio")
	}
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Volver")
			.onClick [|this.accept]
			.setAsDefault.disableOnError
	}
	
}