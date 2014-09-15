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
import ar.edu.dds.ui.view.factory.GrillaDeJugadoresFactory

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
		labelTituloDer.text = "Buscar Jugador"
		labelTituloDer.width = 400
		
		// Renglón 1
		val cajaDeBusquedaRenglon1 = new Panel(panelPadre)
		cajaDeBusquedaRenglon1.layout = new HorizontalLayout
		
		val labelNombre = new Label(cajaDeBusquedaRenglon1)
		labelNombre.setText("Nombre (empieza con): ")
		
		val textBoxNombre = new TextBox(cajaDeBusquedaRenglon1)
		textBoxNombre.width = 90
		textBoxNombre.bindValueToProperty("busquedaNombreJugador")
		
		val labelApodo= new Label(cajaDeBusquedaRenglon1)
		labelApodo.setText("Apodo (contiene): ")
		
		val textBoxApodo = new TextBox(cajaDeBusquedaRenglon1)
		textBoxApodo.width = 90
		textBoxApodo.bindValueToProperty("busquedaApodoJugador")
		
		
		// Rengón 2
		val cajaDeBusquedaRenglon2 = new Panel(panelPadre)
		cajaDeBusquedaRenglon2.layout = new HorizontalLayout
		
		val labelHandicapMin = new Label(cajaDeBusquedaRenglon2)
		labelHandicapMin.setText("Handicap: (Min - Max) ")
		
		val textBoxHandicapMin = new TextBox(cajaDeBusquedaRenglon2)
		textBoxHandicapMin.width = 30
		textBoxHandicapMin.bindValueToProperty("busquedaHandicapMinJugador")
		
		val labelHandicapMax= new Label(cajaDeBusquedaRenglon2)
		labelHandicapMax.setText("-")
		
		val textBoxHandicapMax = new TextBox(cajaDeBusquedaRenglon2)
		textBoxHandicapMax.width = 30
		textBoxHandicapMax.bindValueToProperty("busquedaHandicapMaxJugador")
		
		
		// Rengón 2
		val cajaDeBusquedaRenglon3 = new Panel(panelPadre)
		cajaDeBusquedaRenglon3.layout = new HorizontalLayout
		
		val labelPromedioMin = new Label(cajaDeBusquedaRenglon3)
		labelPromedioMin.setText("Promedio Min: (Min - Max) ")
		
		val textBoxPromedioMin = new TextBox(cajaDeBusquedaRenglon3)
		textBoxPromedioMin.width = 30
		textBoxPromedioMin.bindValueToProperty("busquedaPromedioMinJugador")
		
		val labelPromedioMax= new Label(cajaDeBusquedaRenglon3)
		labelPromedioMax.setText("-")
		
		val textBoxPromedioMax = new TextBox(cajaDeBusquedaRenglon3)
		textBoxPromedioMax.width = 30
		textBoxPromedioMax.bindValueToProperty("busquedaPromedioMaxJugador")
		
		// Botón
		new Button(panelPadre) => [
			setCaption = "Buscar"
			onClick[|modelObject.buscarJugadores]	
		]
		
		GrillaDeJugadoresFactory.crearGrillaDeJugadores(panelPadre, "jugadoresDeBusqueda", "jugadorSeleccionado")
		
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
