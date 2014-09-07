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

class OrganizadorWindow extends SimpleWindow<OrganizadorPartido> {

	new(WindowOwner parent) {
		super(parent, new OrganizadorPartido)
		modelObject.search()
	}

	override def createMainTemplate(Panel mainPanel) {
		title = "Organizador de partidos"

		super.createMainTemplate(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {

		var panelContenedor = new Panel(mainPanel)
		panelContenedor.setLayout(new HorizontalLayout)

		var panelIzquierdo = new Panel(panelContenedor)
		panelIzquierdo.setLayout(new VerticalLayout)

		var labelTituloIzq = new Label(panelIzquierdo)
		labelTituloIzq.text = "Generar Equipos"

		var panelDerecho = new Panel(panelContenedor)
		panelDerecho.setLayout(new VerticalLayout)

		var labelTituloDer = new Label(panelDerecho)
		labelTituloDer.text = "BuscarJugador"

		var comboCriterio = new Selector(panelIzquierdo)
		comboCriterio.bindItemsToProperty("criterios").setAdapter(new PropertyAdapter(typeof(GeneradorDeEquipos), "nombre"))
		comboCriterio.bindValueToProperty("criterioSeleccionado")
		
		var comboOrdenamiento = new Selector(panelIzquierdo)
		comboOrdenamiento.bindItemsToProperty("ordenamientos").setAdapter(new PropertyAdapter(typeof(OrdenadorDeJugadores), "nombre"))
		comboOrdenamiento.bindValueToProperty("ordenamientoSeleccionado")

		var listado2 = new List(panelDerecho)
		listado2.width = 250
		listado2.height = 385

	}

	override protected addActions(Panel actionsPanel) {
	}

}
