package ar.edu.dds.ui.applicationmodel

import ar.edu.dds.model.ArmadorEquipos
import ar.edu.dds.model.EstadoDePartido
import ar.edu.dds.model.Infraccion
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos14589Vs236710
import ar.edu.dds.model.equipos.generador.GeneradorDeEquiposParesContraImpares
import ar.edu.dds.model.equipos.ordenador.OrdenadorCompuesto
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorHandicap
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeCalificacionesDelUltimoPartido
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorPromedioDeUltimasNCalificaciones
import ar.edu.dds.repository.hibernate.JugadoresHibernateRepo
import ar.edu.dds.repository.hibernate.PartidosHibernateRepo
import ar.edu.dds.ui.filtros.FiltroDeJugadores
import ar.edu.dds.ui.filtros.SoloConInfracciones
import ar.edu.dds.ui.filtros.SoloSinInfracciones
import ar.edu.dds.ui.filtros.TodosLosJugadores
import java.io.Serializable
import java.util.ArrayList
import java.util.List
import org.uqbar.commons.model.ObservableUtils
import org.uqbar.commons.utils.Observable

@Observable
class OrganizadorPartido implements Serializable {
	
//	@Property JugadoresRepo repositorioDeJugadores = JugadoresHome.instance
//	@Property PartidosRepo partidosRepo = PartidosHome.instance

	@Property JugadoresHibernateRepo repositorioDeJugadores = JugadoresHibernateRepo.instance
	@Property PartidosHibernateRepo partidosRepo = PartidosHibernateRepo.instance

	
	// CRITERIOS DE GENERACION
	@Property List<GeneradorDeEquipos> criterios
	@Property GeneradorDeEquipos criterioSeleccionado

	// ORDENADORES
	@Property List<OrdenadorDeJugadores> ordenamientos
	@Property OrdenadorDeJugadores ordenadorSeleccionado
	@Property OrdenadorPorPromedioDeUltimasNCalificaciones porPromedioDeUltimasN = new OrdenadorPorPromedioDeUltimasNCalificaciones(2)
	
	@Property ArmadorEquipos armador
	
	@Property Partido partido
	@Property Jugador jugadorSeleccionado
	@Property Infraccion infraccionSeleccionada
	@Property Jugador amigoSeleccionado
	@Property List<Jugador> resultados

	// BUSQUEDA	
	@Property BusquedaDeJugadores busquedaDeJugadores
	@Property List<Jugador> jugadoresDeBusqueda
	@Property List<FiltroDeJugadores> filtrosDeInfracciones

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
		armador.ordenador != null &&
		armador.generador != null &&
		armador.equipos.estanOk 
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
		
		//partido.generarEquiposTentativos(ordenadorSeleccionado, criterioSeleccionado)
		armador.generador = criterioSeleccionado
		armador.ordenador = ordenadorSeleccionado
		//partido.armadorDeEquipos = armador
		armador.armarTentativos(partido)
		cambioPuedeConfirmar			
	}

	def buscarJugadores() {
		this.jugadoresDeBusqueda = repositorioDeJugadores.busquedaCompleta(busquedaDeJugadores)
	}

	def confirmarEquipos() {
		armador.confirmarEquipos(partido)
		partidosRepo.add(partido)
		cambioPuedeConfirmar
	}
	
	def void inicializar() {

		partido = partidosRepo.todosLosPartidos.head
		
		//inicializo la busqueda
		busquedaDeJugadores = new BusquedaDeJugadores
		
		armador = partido.armadorDeEquipos
		
		armador.equipos = partido.equipos
		
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

		jugadoresDeBusqueda = repositorioDeJugadores.todosLosJugadores()

		ordenadorSeleccionado = null
		criterioSeleccionado = null
		
		cambioPuedeConfirmar
		cambioPuedeOrdenar
		cambioPuedeGenerar
		
	}
	
}