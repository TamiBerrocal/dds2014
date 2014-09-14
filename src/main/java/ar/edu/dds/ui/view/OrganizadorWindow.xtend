package ar.edu.dds.ui.view

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
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
import ar.edu.dds.ui.applicationmodel.OrganizadorPartido
import ar.edu.dds.home.JugadoresHome
import org.uqbar.arena.widgets.tables.Column
import ar.edu.dds.model.Jugador
import org.uqbar.arena.widgets.tables.Table

class OrganizadorWindow extends SimpleWindow<OrganizadorPartido> {

	new(WindowOwner parent) {
		super(parent, new OrganizadorPartido)
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Organizador de partidos"
		taskDescription = "Ingrese datos para generar"

		super.createMainTemplate(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {

		val panelContenedor = new Panel(mainPanel)
		panelContenedor.setLayout(new HorizontalLayout)

		val panelIzquierdo = new Panel(panelContenedor)
		panelIzquierdo.setLayout(new VerticalLayout)
		
		this.crearPanelIzquierdo(panelIzquierdo)

		val panelDerecho = new Panel(panelContenedor)
		panelDerecho.width = 450
		panelDerecho.setLayout(new VerticalLayout)

		this.crearPanelDerecho(panelDerecho)
		
	}
	
	def crearPanelIzquierdo(Panel panelPadre){
		val labelTituloIzq = new Label(panelPadre)
		labelTituloIzq.text = "Generar Equipos"
		
		val comboCriterios = new Selector(panelPadre)
		comboCriterios.allowNull = false
		comboCriterios.bindItemsToProperty("criterios").setAdapter(new PropertyAdapter(typeof(GeneradorDeEquipos), "nombre"))
		comboCriterios.bindValueToProperty("criterioSeleccionado")
		
		val comboOrdenamientos = new Selector(panelPadre)
		comboOrdenamientos.allowNull = false
		comboOrdenamientos.bindItemsToProperty("ordenamientos").setAdapter(new PropertyAdapter(typeof(OrdenadorDeJugadores), "nombre"))
		comboOrdenamientos.bindValueToProperty("ordenadorSeleccionado")

		val labelCantCalif = new Label(panelPadre)
		labelCantCalif.setText("Cantidad de calificaciones:")
		
		val cantDeCalificaciones = new TextBox(panelPadre)
		cantDeCalificaciones.bindValueToProperty("cantCalificaciones")
		
		this.crearActionPanelGenerarEquipos(panelPadre)
		
		val panelEquipos = new Panel(panelPadre)
		panelEquipos.setLayout(new ColumnLayout(2))
		
		val labelEq1 = new Label(panelEquipos)
		labelEq1.setText("Equipo 1")
		val labelEq2 = new Label(panelEquipos)
		labelEq2.setText("Equipo 2")
		
		new List(panelEquipos) => [
			bindItemsToProperty("equipo1")
			bindValueToProperty("jugadorSeleccionado")
			width = 125
			height = 200
			onSelection[| this.verDetalleDeJugador ]
		]
		
		new List(panelEquipos) => [
			bindItemsToProperty("equipo2")
			bindValueToProperty("jugadorSeleccionado")
			width = 125
			height = 200
			onSelection[| this.verDetalleDeJugador]
		]
		
		this.crearActionPanelConfirmarEquipos(panelPadre)
	}
	
	
	def crearPanelDerecho (Panel panelPadre){
		
		val labelTituloDer = new Label(panelPadre)
		labelTituloDer.text = "BuscarJugador"
		labelTituloDer.width = 400
		
		val cajaDeBusqueda = new Panel(panelPadre)
		cajaDeBusqueda.layout = new HorizontalLayout
		
		val labelNombre = new Label(cajaDeBusqueda)
		labelNombre.setText("Nombre: ")
		
		val textBoxNombre = new TextBox(cajaDeBusqueda)
		textBoxNombre.width = 180
		textBoxNombre.bindValueToProperty("busquedaNombreJugador")
		
		val botonBuscar = new Button(cajaDeBusqueda)
		botonBuscar.caption = "Buscar !!"
		botonBuscar.onClick(this.buscarJugadores)

		new List(panelPadre) => [
			bindItemsToProperty("jugadoresDeBusqueda")
			bindValueToProperty("jugadorSeleccionado")
			onSelection[| this.verDetalleDeJugador ]
		]
		
	}
	
	def buscarJugadores() {
		[| modelObject.jugadoresDeBusqueda = JugadoresHome.getInstance.buscarPorNombre(modelObject.busquedaNombreJugador) ]
	}
	
	def protected createResultsGrid(Panel panelPadre) {
		
		var table = new Table<Jugador>(panelPadre, typeof(Jugador))
		table.height = 100
		table.width = 450
		table.bindItemsToProperty("resultados")
		table.bindValueToProperty("jugadorSeleccionado")
		
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
	
	def crearActionPanelGenerarEquipos (Panel mainPanel){
		
		val actionsPanel = new Panel(mainPanel)
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
		
		val actionsPanel = new Panel(mainPanel)
		actionsPanel.setLayout(new HorizontalLayout)
		
		new Button(actionsPanel) => [	
			setCaption("Confirmar Equipos")
			setAsDefault
			onClick[|modelObject.confirmarEquipos]
			//bindEnabledToProperty("puedeConfirmar")
			disableOnError
		]
	}

	override protected addActions(Panel actionsPanel) {
	}
	
	def verDetalleDeJugador(){
		new DetalleDeJugadorWindow(this, modelObject).open
	}
	
	
}
