package ar.edu.dds.ui.view

import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.ui.applicationmodel.OrganizadorPartido
import ar.edu.dds.ui.filtros.FiltroDeJugadores
import ar.edu.dds.ui.view.factory.GrillaDeJugadoresFactory
import org.uqbar.arena.bindings.PropertyAdapter
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

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
		
		val labelCriterioSeleccion = new Label(panelPadre)
		labelCriterioSeleccion.text = "Determine el criterio de selección:"
		
		val comboCriterios = new Selector(panelPadre)
		comboCriterios.allowNull = false
		comboCriterios.bindItemsToProperty("criterios").setAdapter(new PropertyAdapter(typeof(GeneradorDeEquipos), "nombre"))
		comboCriterios.bindValueToProperty("criterioSeleccionado")
		
		val labelCriterioOrdenamiento = new Label(panelPadre)
		labelCriterioOrdenamiento.text = "Determine el criterio de ordenamiento:"
				
		val comboOrdenamientos = new Selector(panelPadre)
		comboOrdenamientos.allowNull = false
		comboOrdenamientos.bindItemsToProperty("ordenamientos").setAdapter(new PropertyAdapter(typeof(OrdenadorDeJugadores), "nombre"))
		comboOrdenamientos.bindValueToProperty("ordenadorSeleccionado")

		val panelCalifs = new Panel(panelPadre)
		panelCalifs.setLayout(new HorizontalLayout)

		val labelCantCalif = new Label(panelCalifs)
		labelCantCalif.setText("Cantidad de calificaciones:")
		labelCantCalif.bindVisibleToProperty("puedeOrdenarPorLasNUltimas")
		
		val cantDeCalificaciones = new TextBox(panelCalifs)
		cantDeCalificaciones.setWidth(15)
		cantDeCalificaciones.bindValueToProperty("porPromedioDeUltimasN.n")
		cantDeCalificaciones.bindVisibleToProperty("puedeOrdenarPorLasNUltimas")
		
		//Genera equipo
		this.crearActionPanelGenerarEquipos(panelPadre)
		
		//Listas de los equipos
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
		
		//Confirma equipo
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
		
		
		// Renglón 2		
		val cajaDeBusquedaRenglon2 = new Panel(panelPadre)
		cajaDeBusquedaRenglon2.layout = new HorizontalLayout
		
		val labelFecha= new Label(cajaDeBusquedaRenglon2)
		labelFecha.setText("Fecha (anterior a): ")
		
		val textBoxFecha = new TextBox(cajaDeBusquedaRenglon2)
		textBoxFecha.width = 90
		textBoxFecha.bindValueToProperty("busquedaFechaNacimientoJugador").setTransformer(new ar.edu.dds.ui.view.adapters.LocalDateAdapter)

		val labelFormatoFecha= new Label(cajaDeBusquedaRenglon2)
		labelFormatoFecha.setText("(AAAA-MM-DD)")
		
		
		// Renglón 3
		val cajaDeBusquedaRenglon3 = new Panel(panelPadre)
		cajaDeBusquedaRenglon3.layout = new HorizontalLayout
				
		val labelHandicapMin = new Label(cajaDeBusquedaRenglon3)
		labelHandicapMin.setText("Handicap: (Min - Max) ")
		
		val textBoxHandicapMin = new TextBox(cajaDeBusquedaRenglon3)
		textBoxHandicapMin.width = 30
		textBoxHandicapMin.bindValueToProperty("busquedaHandicapMinJugador")
		
		val labelHandicapMax= new Label(cajaDeBusquedaRenglon3)
		labelHandicapMax.setText("-")
		
		val textBoxHandicapMax = new TextBox(cajaDeBusquedaRenglon3)
		textBoxHandicapMax.width = 30
		textBoxHandicapMax.bindValueToProperty("busquedaHandicapMaxJugador")
		
		val labelPromedioMin = new Label(cajaDeBusquedaRenglon3)
		labelPromedioMin.setText("     Promedio Min: (Min - Max) ")
		
		val textBoxPromedioMin = new TextBox(cajaDeBusquedaRenglon3)
		textBoxPromedioMin.width = 30
		textBoxPromedioMin.bindValueToProperty("busquedaPromedioMinJugador")
		
		val labelPromedioMax= new Label(cajaDeBusquedaRenglon3)
		labelPromedioMax.setText("-")
		
		val textBoxPromedioMax = new TextBox(cajaDeBusquedaRenglon3)
		textBoxPromedioMax.width = 30
		textBoxPromedioMax.bindValueToProperty("busquedaPromedioMaxJugador")
		
		// Renglón 4
		val cajaDeBusquedaRenglon4 = new Panel(panelPadre)
		cajaDeBusquedaRenglon4.layout = new HorizontalLayout
		
		val labelInfracciones = new Label(cajaDeBusquedaRenglon4)
		labelInfracciones.setText("Infracciones: ")
		
		val comboFiltros = new Selector(cajaDeBusquedaRenglon4)
		comboFiltros.allowNull = false
		comboFiltros.bindItemsToProperty("filtrosDeInfracciones").setAdapter(new PropertyAdapter(typeof(FiltroDeJugadores), "nombre"))
		comboFiltros.bindValueToProperty("filtroDeInfraccionesSeleccionado")
		
		// Botón
		new Button(cajaDeBusquedaRenglon4) => [
			setCaption = "Buscar !!"
			setWidth(75)
			onClick[|modelObject.buscarJugadores]	
		]
		
		//Crea grilla de busquedad jugadores
		GrillaDeJugadoresFactory.crearGrillaDeJugadores(panelPadre, "jugadoresDeBusqueda", "jugadorSeleccionado")
		
		val panelDeDetalles = new Panel(panelPadre)
		panelDeDetalles.setLayout(new HorizontalLayout)
		
		//Botón para ver detalle
		new Button(panelDeDetalles) => [
			setCaption = "Ver detalle"
			setWidth(90)
			setAsDefault
			onClick[|this.verDetalleDeJugador]
			disableOnError		
		]
		
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
			bindEnabledToProperty("puedeConfirmar")
			disableOnError
		]
	}

	override protected addActions(Panel actionsPanel) {
	}
	
	def verDetalleDeJugador(){
		new DetalleDeJugadorWindow(this, modelObject).open
	}
	
}