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

class VisualizadorJugadorWindows extends Dialog<OrganizadorPartido>{
	
	new(WindowOwner owner, OrganizadorPartido organizadorPartido) {
		super(owner, organizadorPartido)
		title = "Datos Jugador"
		
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val panel = new Panel(mainPanel)
		panel.setLayout(new ColumnLayout(2))
		
		new Label(panel).text = "Nombre"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.nombre")
		
		new Label(panel).text = "Apodo"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.nombre")
		
		new Label(panel).text = "Handicap"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.handicap")
		
		new Label(panel).text = "Promedio último partido"
		new Label(panel).text = "una cantidad"
		
		new Label(panel).text = "Promedio partidos jugados"
		new Label(panel).text = "una cantidad"
		
		new Label(panel).text = "Fecha nacimiento"
		new Label(panel).bindValueToProperty("jugadorSeleccionado.edad")
		
		var labelEq1 = new Label(panel)
		labelEq1.setText("Amigos")
		var labelEq2 = new Label(panel)
		labelEq2.setText("Infracciones")
		
		this.crearGridAmigos(panel)
		this.crearGridInfracciones(panel)
		
	}
	
	def crearGridInfracciones(Panel panel) {
		var table = new Table<Infraccion>(panel, typeof(Infraccion))
		//table.heigth = 200
		table.width = 450
		
		new Column<Infraccion>(table) 
			.setTitle("Fecha").setFixedSize(90)

		new Column<Infraccion>(table) 
			.setTitle("Hora").setFixedSize(70)
		
		new Column<Infraccion>(table)
			.setTitle("Motivo").setFixedSize(190)

	}
	
	def crearGridAmigos(Panel panel) {
		var table = new Table<Jugador>(panel, typeof(Jugador))
		//table.heigth = 200
		table.width = 450
		
	}
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Volver")
			.onClick [|this.accept]
			.setAsDefault.disableOnError
	}
	
}