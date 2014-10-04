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
import ar.edu.dds.model.Infraccion
import org.joda.time.LocalDate
import ar.edu.dds.ui.filtros.FiltroDeJugadores
import ar.edu.dds.ui.filtros.SoloConInfracciones
import ar.edu.dds.ui.filtros.SoloSinInfracciones
import ar.edu.dds.ui.filtros.TodosLosJugadores
import ar.edu.dds.model.EstadoDePartido
import ar.edu.dds.home.Busqueda

@Observable
class OrganizadorPartido implements Serializable {
	
	//Busqueda
	@Property Busqueda busqueda

	// CRITERIOS DE GENERACION
	@Property List<GeneradorDeEquipos> criterios
	@Property GeneradorDeEquipos criterioSeleccionado

	// ORDENADORES
	@Property List<OrdenadorDeJugadores> ordenamientos
	@Property OrdenadorDeJugadores ordenadorSeleccionado
	@Property OrdenadorPorPromedioDeUltimasNCalificaciones porPromedioDeUltimasN = new OrdenadorPorPromedioDeUltimasNCalificaciones(2)
	
	@Property Partido partido
	@Property Jugador jugadorSeleccionado
	@Property Infraccion infraccionSeleccionada
	@Property Jugador amigoSeleccionado
	@Property List<Jugador> resultados

	// BUSQUEDA	
	@Property List<Jugador> jugadoresDeBusqueda
	//@Property String busquedaNombreJugador
	//@Property String busquedaApodoJugador
	//@Property Integer busquedaPromedioMinJugador
	//@Property Integer busquedaPromedioMaxJugador
	//@Property Integer busquedaHandicapMinJugador
	//Property Integer busquedaHandicapMaxJugador
	//@Property LocalDate busquedaFechaNacimientoJugador

	@Property List<FiltroDeJugadores> filtrosDeInfracciones
	//@Property FiltroDeJugadores filtroDeInfraccionesSeleccionado

	new() {
		this.inicializar
	}
	
	def setCriterioSeleccionado(GeneradorDeEquipos criterioSeleccionado) {
		this._criterioSeleccionado = criterioSeleccionado
		cambioPuedeGenerar
		cambioPuedeOrdenar
	}

	def setOrdenadorSeleccionado(OrdenadorDeJugadores ordenadorSeleccionado) {
		this._ordenadorSeleccionado = ordenadorSeleccionado
		cambioPuedeGenerar
		cambioPuedeOrdenar
	}
	
	def isPuedeGenerar(){
		criterioSeleccionado != null &&
		ordenadorSeleccionado != null &&
		(!puedeOrdenarPorLasNUltimas || porPromedioDeUltimasN.n != null)
	}
	
	def partidoYaConfirmado() {
		EstadoDePartido.CONFIRMADO.equals(partido.estadoDePartido)
	}

	def isPuedeOrdenarPorLasNUltimas() {
		ordenadorSeleccionado != null && ordenadorSeleccionado.conNUltimas
	}

	def isPuedeConfirmar() {
		EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(partido.estadoDePartido) &&
		partido.equipos.estanOk
	}
	
	def cambioPuedeGenerar() {
		ObservableUtils.firePropertyChanged(this, "puedeGenerar", puedeGenerar)
	}

	def cambioPuedeOrdenar() {
		ObservableUtils.firePropertyChanged(this, "puedeOrdenarPorLasNUltimas", puedeOrdenarPorLasNUltimas)
	}

	def cambioPuedeConfirmar() {
		ObservableUtils.firePropertyChanged(this, "puedeConfirmar", puedeConfirmar)
	}

	def generarEquipos() {
		partido.generarEquiposTentativos(ordenadorSeleccionado, criterioSeleccionado)

		cambioPuedeConfirmar			
	}

	def buscarJugadores() {
		this.jugadoresDeBusqueda = busqueda.efectuar
	}

	def confirmarEquipos() {
		partido.confirmar
		cambioPuedeConfirmar
	}
	
	def setBusquedaNombreJugador(String nombre){
		this.busqueda.nombreJugador = nombre
	}
	def getBusquedaNombreJugador(){
		this.busqueda.nombreJugador
	}
	
	
	def setBusquedaApodoJugador(String apodo){
		this.busqueda.apodoJugador = apodo
	}	
	
	def getBusquedaApodoJugador(){
		this.busqueda.apodoJugador
	}
		
	
	def setBusquedaPromedioMaxJugador(Integer promedio){
		this.busqueda.maxPromedioJugador = promedio
	}
	def getBusquedaPromedioMaxJugador(){
		this.busqueda.maxPromedioJugador
	}
	
	
	def setBusquedaPromedioMinJugador(Integer promedio){
		this.busqueda.minPromedioJugador = promedio
	}
	def getBusquedaPromedioMinJugador(){
		this.busqueda.minPromedioJugador
	}
	
	
	def setBusquedaHandicapMaxJugador(Integer handicap){
		this.busqueda.maxHandicapJugador = handicap
	}
	def getBusquedaHandicapMaxJugador(){
		this.busqueda.maxHandicapJugador
	}
	
	
	def setBusquedaHandicapMinJugador(Integer handicap){
		this.busqueda.minHandicapJugador = handicap
	}
	def getBusquedaHandicapMinJugador(){
		this.busqueda.minHandicapJugador
	}
	
	
	def setBusquedaFechaNacimientoJugador(LocalDate fecha){
		this.busqueda.fechaNacJugador = fecha
	}
	def getBusquedaFechaNacimientoJugador(){
		this.busqueda.fechaNacJugador
	}
	
	
	def setFiltroDeInfraccionesSeleccionado(FiltroDeJugadores filtro){
		this.busqueda.filtroDeInfracciones = filtro
	}
	def getFiltroDeInfraccionesSeleccionado(){
		this.busqueda.filtroDeInfracciones
	}

	def void inicializar() {

		//inicializo la busqueda
		busqueda = new Busqueda

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
	}
	
}