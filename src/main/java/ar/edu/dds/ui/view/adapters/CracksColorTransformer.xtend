package ar.edu.dds.ui.view.adapters

import com.uqbar.commons.collections.Transformer
import java.awt.Color

class CracksColorTransformer implements Transformer<Integer, Color> {
	
	override transform(Integer handicap) {
		if (handicap >= 8) {
			Color.GREEN
		} else {
			Color.WHITE
		}
	}
	
}