package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.condicion.Condicion

abstract class Condicional extends ModoDeInscripcion {

	@Property
	private Condicion condicion

	override leSirveElPartido(Partido partido)

}
