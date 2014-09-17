package ar.edu.dds.ui.view

import ar.edu.dds.model.Infraccion
//import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import ar.edu.dds.ui.applicationmodel.OrganizadorPartido
import ar.edu.dds.ui.view.factory.GrillaDeJugadoresFactory
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.layout.HorizontalLayout

class DetalleDeJugadorWindow extends Dialog<OrganizadorPartido> {
		
	new(WindowOwner owner, OrganizadorPartido organizadorPartido) {
		super(owner, organizadorPartido)
		title = "Datos del jugador"
	}
	
	override protected createFormPanel(Panel mainPanel) {
		
		val panel = new Panel(mainPanel)
		panel.setLayout(new VerticalLayout)
		
		// Renglón 1
		val renglon1 = new Panel(panel)
		renglon1.layout = new HorizontalLayout
		
		new Label(renglon1).text = "Nombre:"
		new Label(renglon1).bindValueToProperty("jugadorSeleccionado.nombre")
		
		// Renglón 2
		val renglon2 = new Panel(panel)
		renglon2.layout = new HorizontalLayout
		
		new Label(renglon2).text = "Apodo:"
		new Label(renglon2).bindValueToProperty("jugadorSeleccionado.apodo")
		
		// Renglón 3
		val renglon3 = new Panel(panel)
		renglon3.layout = new HorizontalLayout
		
		new Label(renglon3).text = "Handicap:"
		new Label(renglon3).bindValueToProperty("jugadorSeleccionado.handicap")
		
		// Renglón 4
		val renglon4 = new Panel(panel)
		renglon4.layout = new HorizontalLayout
		
		new Label(renglon4).text = "Promedio del último partido:"
		new Label(renglon4).bindValueToProperty("jugadorSeleccionado.promedioUltimoPartido")
		
		// Renglón 5
		val renglon5 = new Panel(panel)
		renglon5.layout = new HorizontalLayout
		
		new Label(renglon5).text = "Promedio general:"
		new Label(renglon5).bindValueToProperty("jugadorSeleccionado.promedio")
					
		// Renglón 6
		val renglon6 = new Panel(panel)
		renglon6.layout = new HorizontalLayout
					
		new Label(renglon6).text = "Fecha de nacimiento:"
		new Label(renglon6).bindValueToProperty("jugadorSeleccionado.fechaNacimiento")
		
		// Renglón 7
		val renglon7 = new Panel(panel)
		renglon7.layout = new HorizontalLayout
		
		new Label(renglon7).text = "Cantidad de partidos jugados:"
		new Label(renglon7).bindValueToProperty("jugadorSeleccionado.partidosJugados")
		
		// Grilla de amigos		
		new Label(panel).text = "Amigos"
		GrillaDeJugadoresFactory.crearGrillaDeJugadores(panel, "jugadorSeleccionado.amigos", "amigoSeleccionado")
		
		// Grilla de infracciones
		new Label(panel).text = "Infracciones"		
		this.crearGridInfracciones(panel)
		
	}
	
	def crearGridInfracciones(Panel panel) {
		var table = new Table<Infraccion>(panel, typeof(Infraccion))
		table.height = 100
		table.width = 560
		table.bindItemsToProperty("jugadorSeleccionado.infracciones")
		table.bindValueToProperty("infraccionSeleccionada")
		
		new Column<Infraccion>(table)
			.setTitle("Fecha").setFixedSize(125)
			.bindContentsToProperty("fechaCreacion")

		new Column<Infraccion>(table) 
			.setTitle("Hora").setFixedSize(125)
			.bindContentsToProperty("hora")	
		
		new Column<Infraccion>(table)
			.setTitle("Motivo").setFixedSize(310)
			.bindContentsToProperty("causa")

	}
	
	override protected void addActions(Panel actions) {
		new Button(actions)
			.setCaption("Volver")
			.onClick [|this.accept]
			.setAsDefault.disableOnError
	}
	
}