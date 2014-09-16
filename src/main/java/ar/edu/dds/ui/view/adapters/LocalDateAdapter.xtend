package ar.edu.dds.ui.view.adapters

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
		if (valueFromModel != null) {
			valueFromModel.toString(PATTERN)
		} else {
			""
		}
	}
	
	override viewToModel(String valueFromView) {
		if (valueFromView != null && !valueFromView.empty) {
			new LocalDate(valueFromView)
		} else {
			null
		}
	}
	
	
	
}