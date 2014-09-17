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
import ar.edu.dds.model.Infraccionimport org.joda.time.LocalDateimport ar.edu.dds.ui.filtros.FiltroDeJugadores
import ar.edu.dds.ui.filtros.SoloConInfracciones
import ar.edu.dds.ui.filtros.SoloSinInfracciones
import ar.edu.dds.ui.filtros.TodosLosJugadores

@Observable
class OrganizadorPartido implements Serializable{
	
	// CRITERIOS DE GENERACION
	@Property List<GeneradorDeEquipos> criterios
	@Property GeneradorDeEquipos criterioSeleccionado
	
	// ORDENADORES
	@Property List<OrdenadorDeJugadores> ordenamientos
	@Property OrdenadorDeJugadores ordenadorSeleccionado
	@Property OrdenadorPorPromedioDeUltimasNCalificaciones porPromedioDeUltimasN = new OrdenadorPorPromedioDeUltimasNCalificaciones(2)
	
	@Property Integer cantCalificaciones
	@Property Partido partido
	@Property List<Jugador> equipo1
	@Property List<Jugador> equipo2
	@Property Jugador jugadorSeleccionado
	@Property Infraccion infraccionSeleccionada
	@Property Jugador amigoSeleccionado
	@Property List<Jugador> resultados

	// BUSQUEDA	
	@Property List<Jugador> jugadoresDeBusqueda
	@Property String busquedaNombreJugador
	@Property String busquedaApodoJugador 
	@Property Integer busquedaPromedioMinJugador
	@Property Integer busquedaPromedioMaxJugador
	@Property Integer busquedaHandicapMinJugador
	@Property Integer busquedaHandicapMaxJugador
	@Property LocalDate busquedaFechaNacimientoJugador
	
	@Property List<FiltroDeJugadores> filtrosDeInfracciones
	@Property FiltroDeJugadores filtroDeInfraccionesSeleccionado
	@Property Boolean enabledConfirmarButton
	
	new() {
		this.inicializar
	}
	
	def setCriterioSeleccionado(GeneradorDeEquipos criterioSeleccionado){
		this._criterioSeleccionado = criterioSeleccionado
		cambioPuedeGenerar
		cambioPuedeOrdenar		
	}
	
	def setOrdenadorSeleccionado(OrdenadorDeJugadores ordenadorSeleccionado){
		this._ordenadorSeleccionado = ordenadorSeleccionado
		cambioPuedeGenerar
		cambioPuedeOrdenar		
	}
	
	def isPuedeGenerar(){
		criterioSeleccionado != null &&
		ordenadorSeleccionado != null
	}
	def isPuedeOrdenarPorLasNUltimas(){
		ordenadorSeleccionado != null &&
		ordenadorSeleccionado.conNUltimas
	}
	def isPuedeConfirmar(){
		enabledConfirmarButton.booleanValue
	}

	def cambioPuedeGenerar() {
		ObservableUtils.firePropertyChanged(this, "puedeGenerar", puedeGenerar)
	}
	def cambioPuedeOrdenar() {
		ObservableUtils.firePropertyChanged(this, "puedeOrdenarPorLasNUltimas", puedeOrdenarPorLasNUltimas)
	}
	def cambioPuedeConfirmar(){
		ObservableUtils.firePropertyChanged(this, "puedeConfirmar", puedeConfirmar)
	}
	
	def generarEquipos(){
		
		partido.generarEquiposTentativos(ordenadorSeleccionado,criterioSeleccionado)
		equipo1 = partido.equipos.equipo1
		equipo2 = partido.equipos.equipo2
		
		enabledConfirmarButton = true
		cambioPuedeConfirmar
			
	}
	
	def buscarJugadores() {
		this.jugadoresDeBusqueda = 
			JugadoresHome.getInstance.busquedaCompleta(this.busquedaNombreJugador,
												       this.busquedaApodoJugador,
												       this.busquedaFechaNacimientoJugador,
												       this.busquedaHandicapMinJugador,
												       this.busquedaHandicapMaxJugador,
												       this.busquedaPromedioMinJugador,
												       this.busquedaPromedioMaxJugador,
												       this.filtroDeInfraccionesSeleccionado)
	}

	def confirmarEquipos(){
		partido.confirmar
	}
	
	def void inicializar(){
		
		//Criterios
		criterios = new ArrayList
		criterios.add(new GeneradorDeEquipos14589Vs236710)
		criterios.add(new GeneradorDeEquiposParesContraImpares)
		
		//Ordenamientos
		ordenamientos = new ArrayList
		
		val porHandicap = new OrdenadorPorHandicap
		val porPromedioUltimoPartido = new OrdenadorPorPromedioDeCalificacionesDelUltimoPartido
		
		ordenamientos.add(porHandicap)
		ordenamientos.add(porPromedioUltimoPartido)
		ordenamientos.add(porPromedioDeUltimasN)
		ordenamientos.add(new OrdenadorCompuesto(newArrayList(porHandicap, porPromedioUltimoPartido, porPromedioDeUltimasN)))
		
		// Filtros de infracciones
		filtrosDeInfracciones = new ArrayList
		filtrosDeInfracciones.add(new TodosLosJugadores())
		filtrosDeInfracciones.add(new SoloConInfracciones())
		filtrosDeInfracciones.add(new SoloSinInfracciones())
		
		filtroDeInfraccionesSeleccionado = new TodosLosJugadores()
		
		partido = PartidosHome.getInstance.partidos.head
		
		busquedaNombreJugador = ""
		busquedaApodoJugador = ""
	    
	    jugadoresDeBusqueda = JugadoresHome.getInstance.todosLosJugadores
	    
	    ordenadorSeleccionado = null
	    criterioSeleccionado = null
	    
	    enabledConfirmarButton = false
	  
	}

}