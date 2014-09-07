package ar.edu.dds.view

import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner
import ar.edu.dds.applicationModel.OrganizadorPartido
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.HorizontalLayout

class OrganizadorWindow extends SimpleWindow <OrganizadorPartido> {
	

	new(WindowOwner parent) {
		super(parent, new OrganizadorPartido)
		//modelObject.search()
	}
	
	override def createMainTemplate(Panel mainPanel) {
		title = "Organizador de partidos"

		super.createMainTemplate(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {

		var panelContendor = new Panel(mainPanel)
		panelContendor.setLayout(new HorizontalLayout)
		
	}

	override protected addActions(Panel actionsPanel) {
	}
	
}