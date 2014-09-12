package ar.edu.dds.view

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ar.edu.dds.applicationModel.OrganizadorPartido
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.bindings.PropertyAdapter
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.layout.ColumnLayout

class OrganizadorWindow extends SimpleWindow<OrganizadorPartido> {

	new(WindowOwner parent) {
		super(parent, new OrganizadorPartido)
		modelObject.inicializar()
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Organizador de partidos"
		taskDescription = "Ingrese datos para generar"

		super.createMainTemplate(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {

		var panelContenedor = new Panel(mainPanel)
		panelContenedor.setLayout(new HorizontalLayout)

		var panelIzquierdo = new Panel(panelContenedor)
		panelIzquierdo.setLayout(new VerticalLayout)
		
		this.crearPanelIzquierdo(panelIzquierdo)

		var panelDerecho = new Panel(panelContenedor)
		panelDerecho.setLayout(new VerticalLayout)

		this.crearPanelDerecho(panelDerecho)
		
	}
	
	def crearPanelIzquierdo(Panel mainPanel){
		var labelTituloIzq = new Label(mainPanel)
		labelTituloIzq.text = "Generar Equipos"
		
		var comboCriterio = new Selector(mainPanel)
		comboCriterio.allowNull = false
		comboCriterio.bindItemsToProperty("criterios").setAdapter(new PropertyAdapter(typeof(GeneradorDeEquipos), "nombre"))
		comboCriterio.bindValueToProperty("criterioSeleccionado")
		
		var comboOrdenamiento = new Selector(mainPanel)
		comboOrdenamiento.allowNull = false
		comboOrdenamiento.bindItemsToProperty("ordenamientos").setAdapter(new PropertyAdapter(typeof(OrdenadorDeJugadores), "nombre"))
		comboOrdenamiento.bindValueToProperty("ordenadorSeleccionado")

		var labelCantCalif = new Label(mainPanel)
		labelCantCalif.setText("Cant de calificaciones:")
		
		var cantDeCalificaciones = new TextBox(mainPanel)
		cantDeCalificaciones.bindValueToProperty("cantCalificaciones")
		
		this.crearActionPanelGenerarEquipos(mainPanel)
		
		var panelEquipos = new Panel(mainPanel)
		panelEquipos.setLayout(new ColumnLayout(2))
		
		var labelEq1 = new Label(panelEquipos)
		labelEq1.setText("Equipo 1")
		var labelEq2 = new Label(panelEquipos)
		labelEq2.setText("Equipo 2")
		
		var listaEquipo1 = new List(panelEquipos)
		listaEquipo1.bindItemsToProperty("equipo1")
		listaEquipo1.width = 125
		listaEquipo1.height = 200
		
		var listaEquipo2 = new List(panelEquipos)
		listaEquipo2.bindItemsToProperty("equipo2")
		listaEquipo2.width = 125
		listaEquipo2.height = 200
		
		this.crearActionPanelConfirmarEquipos(mainPanel)
	}
	
	def crearPanelDerecho (Panel mainPanel){
		
		var labelTituloDer = new Label(mainPanel)
		labelTituloDer.text = "BuscarJugador"

		var listado2 = new List(mainPanel)
		listado2.width = 250
		listado2.height = 385
	}
	
	
	def crearActionPanelGenerarEquipos (Panel mainPanel){
		
		var actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		
		new Button(actionsPanel) => [			
			setCaption("Generar Equipos")
			setAsDefault
			onClick[|modelObject.generarEquipos]			
			bindEnabledToProperty("puedeGenerar")
			disableOnError			
		]
	}
	
	def crearActionPanelConfirmarEquipos(Panel mainPanel){
		
		var actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		
		new Button(actionsPanel)
			.setCaption("Confirmar Equipos")
			.onClick[|modelObject.confirmarEquipos]
			.setAsDefault
			.disableOnError
	}

	override protected addActions(Panel actionsPanel) {
	}

}
