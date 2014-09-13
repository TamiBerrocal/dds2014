package ar.edu.dds.ui.applicationmodel

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
import org.uqbar.commons.model.ObservableUtils
import ar.edu.dds.home.PartidosHome
import ar.edu.dds.home.JugadoresHome

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
	@Property Jugador jugadorSeleccionado
	@Property String busquedaNombreJugador
	@Property List<Jugador> jugadoresDeBusqueda
	
	new() {
		this.inicializar
	}
	
	def isPuedeGenerar(){
		cantCalificaciones > 0 &&
		criterioSeleccionado != null &&
		ordenadorSeleccionado != null		
	}
	
	def cambioPuedeGenerar() {
		ObservableUtils.firePropertyChanged(this, "puedeGenerar", puedeGenerar)
	}
	
	def setCantCalificaciones(int cantCalificaciones){
		this._cantCalificaciones = cantCalificaciones
		cambioPuedeGenerar		
	}
	
	def setCriterioSeleccionado(GeneradorDeEquipos criterioSeleccionado){
		this._criterioSeleccionado = criterioSeleccionado
		cambioPuedeGenerar		
	}
	
	def setOrdenadorDeJugadores(OrdenadorDeJugadores ordenadorSeleccionado){
		this._ordenadorSeleccionado = ordenadorSeleccionado
		cambioPuedeGenerar		
	}
	
	def generarEquipos(){
		
		partido.generarEquiposTentativos(ordenadorSeleccionado,criterioSeleccionado)
		equipo1 = partido.equipos.equipo1
		equipo2 = partido.equipos.equipo2
		
	}

	def confirmarEquipos(){
		partido.confirmar
	}
	
	def void inicializar(){
		
		//Criterios
		criterios = new ArrayList<GeneradorDeEquipos>
		criterios.add(new GeneradorDeEquipos14589Vs236710)
		criterios.add(new GeneradorDeEquiposParesContraImpares)
		
		//Ordenamientos
		ordenamientos = new ArrayList<OrdenadorDeJugadores>
		ordenamientos.add(new OrdenadorPorHandicap)
		ordenamientos.add(new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido)
		ordenamientos.add(new OrdenadorPorPromedioDeUltimasNCalificaciones(cantCalificaciones))
		ordenamientos.add(new OrdenadorCompuesto(ordenamientosMixtos))
		
		partido = PartidosHome.getInstance.partidos.head
		
		cantCalificaciones = 1
		
		busquedaNombreJugador = ""
		jugadoresDeBusqueda = JugadoresHome.getInstance.buscarPorNombre(busquedaNombreJugador)
	}
}
