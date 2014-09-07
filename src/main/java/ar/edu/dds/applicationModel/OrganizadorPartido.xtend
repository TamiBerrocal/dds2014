package ar.edu.dds.applicationModel

import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import java.util.ArrayList
import java.util.List
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos14589Vs236710
import ar.edu.dds.model.equipos.generador.GeneradorDeEquiposParesContraImpares
import java.io.Serializable
import org.uqbar.commons.utils.Observable
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorHandicap
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeCalificacionesDelUltimoPartido

@Observable
class OrganizadorPartido implements Serializable{
	
	@Property List<GeneradorDeEquipos> criterios
	@Property GeneradorDeEquipos criterioSeleccionado
	@Property List<OrdenadorDeJugadores> ordenamientos
	@Property OrdenadorDeJugadores ordenamientoSeleccionado
	@Property int nCalificaciones
	
	def void search(){
		
		criterios = new ArrayList<GeneradorDeEquipos>
		criterios.add(new GeneradorDeEquipos14589Vs236710)
		criterios.add(new GeneradorDeEquiposParesContraImpares)
		
		ordenamientos = new ArrayList<OrdenadorDeJugadores>
		ordenamientos.add(new OrdenadorPorHandicap)
		ordenamientos.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
	}
	
}