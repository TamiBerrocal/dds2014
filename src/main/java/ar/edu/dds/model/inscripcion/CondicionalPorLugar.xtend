package ar.edu.dds.model.inscripcion

import ar.edu.dds.model.Partido
import ar.edu.dds.model.inscripcion.PrioridadInscripcion
import javax.persistence.Entity
import javax.persistence.DiscriminatorValue

//import javax.persistence.DiscriminatorValue

@Entity
@DiscriminatorValue("PorLugar")
class CondicionalPorLugar extends ModoDeInscripcion {

	new(String lugar) {
		this.lugar = lugar
		this.prioridadInscripcion = PrioridadInscripcion.CONDICIONAL
	}
	
	private String lugar;
	
	override leSirveElPartido(Partido partido) {
		lugar.equals(partido.getLugar)
	}
	
	new(){
		
	}
}