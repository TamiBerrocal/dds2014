package ar.edu.dds.ui.view

import org.uqbar.arena.bindings.Transformer
import org.joda.time.LocalDate

class LocalDateAdapter implements Transformer<LocalDate, String> {
	
	public static final String PATTERN = "YYYY-MM-dd"
	
	override getModelType() {
		typeof(LocalDate)
	}
	
	override getViewType() {
		typeof(String)
	}
	
	override modelToView(LocalDate valueFromModel) {
		valueFromModel.toString(PATTERN)
	}
	
	override viewToModel(String valueFromView) {
		new LocalDate(valueFromView)
	}
	
	
	
}