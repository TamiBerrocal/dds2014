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
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeUltimasNCalificaciones
import ar.edu.dds.model.equipos.ordenador.OrdenadorCompuesto
import ar.edu.dds.model.Partido
import ar.edu.dds.model.Jugador

@Observable
class OrganizadorPartido implements Serializable{
	
	@Property List<GeneradorDeEquipos> criterios
	@Property GeneradorDeEquipos criterioSeleccionado
	@Property List<OrdenadorDeJugadores> ordenamientos
	@Property OrdenadorDeJugadores ordenadorSeleccionado
	@Property int cantCalificaciones
	@Property List<OrdenadorDeJugadores> ordenamientosMixtos
	@Property Partido partido
	@Property List<Jugador> equipo1
	@Property List<Jugador> equipo2
	
	def void search(){
		
		criterios = new ArrayList<GeneradorDeEquipos>
		criterios.add(new GeneradorDeEquipos14589Vs236710)
		criterios.add(new GeneradorDeEquiposParesContraImpares)
		
		ordenamientos = new ArrayList<OrdenadorDeJugadores>
		ordenamientos.add(new OrdenadorPorHandicap)
		ordenamientos.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		ordenamientos.add(new OrdenadorPorPromedioDeUltimasNCalificaciones(cantCalificaciones))
		ordenamientos.add(new OrdenadorCompuesto(ordenamientosMixtos))
		
	}
	
	def generarEquipos(){
		partido.generarEquiposTentativos(ordenadorSeleccionado,criterioSeleccionado)
		equipo1 = partido.equipos.equipo1
		equipo2 = partido.equipos.equipo2
	}
}