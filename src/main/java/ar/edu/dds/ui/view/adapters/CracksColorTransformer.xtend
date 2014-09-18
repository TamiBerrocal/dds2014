package ar.edu.dds.ui.view.adapters

import com.uqbar.commons.collections.Transformer
import java.awt.Color

class CracksColorTransformer implements Transformer<Boolean, Color> {
	
	override transform(Boolean esCrack) {
		if (esCrack) {
			Color.GREEN
		} else {
			Color.WHITE
		}
	}
	
}