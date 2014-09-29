package ar.edu.dds.ui

import org.junit.Before
import ar.edu.dds.ui.applicationmodel.OrganizadorPartido
import org.junit.Test
import ar.edu.dds.model.equipos.ordenador.OrdenadorPorHandicap
import ar.edu.dds.model.equipos.generador.GeneradorDeEquiposParesContraImpares
import ar.edu.dds.model.Partido
import junit.framework.Assert
import ar.edu.dds.home.JugadoresHome
import java.util.Arrays
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos14589Vs236710
import ar.edu.dds.ui.filtros.TodosLosJugadores
import ar.edu.dds.ui.filtros.SoloConInfracciones
import java.util.List
import ar.edu.dds.model.Jugador
import ar.edu.dds.ui.filtros.SoloSinInfracciones

class Entrega7Tests {
	
	@Property Partido partido
	var appModel = new OrganizadorPartido
	val homeJugadores = JugadoresHome.instance
	
	var matias = homeJugadores.buscarPorNombre("Matias").head
	var jorge = homeJugadores.buscarPorNombre("Jorge").head
	var carlos = homeJugadores.buscarPorNombre("Carlos").head
	var pablo = homeJugadores.buscarPorNombre("Pablo").head
	var pedro = homeJugadores.buscarPorNombre("Pedro").head
	var franco = homeJugadores.buscarPorNombre("Franco").head
	var lucas = homeJugadores.buscarPorNombre("Lucas").head
	var adrian = homeJugadores.buscarPorNombre("Adrian").head
	var simon = homeJugadores.buscarPorNombre("Simon").head
	var patricio = homeJugadores.buscarPorNombre("Patricio").head
	
	
	@Before
	def void init(){
		appModel.inicializar
		partido = appModel.partido
	}
	
	@Test
	def void testOrdenarPorHandicapYGenerarPorParesEImpares(){
		
		appModel.ordenadorSeleccionado = new OrdenadorPorHandicap
		appModel.criterioSeleccionado = new GeneradorDeEquiposParesContraImpares
		
		appModel.generarEquipos
		var equipos = partido.equipos
		var equipo1 = equipos.equipo1
		var equipo2 = equipos.equipo2
		
		var appModelEquipo1 = Arrays.asList(pablo,  lucas,  simon, jorge, patricio)
		var appModelEquipo2 = Arrays.asList(franco,  carlos,  matias, adrian, pedro)
		
		Assert.assertEquals(appModelEquipo1, equipo1)
		Assert.assertEquals(appModelEquipo2, equipo2)
		
	}
	@Test
	def void testOrdenaPorHandicapYGenerarPor14589Vs236710(){
		
		appModel.ordenadorSeleccionado = new OrdenadorPorHandicap
		appModel.criterioSeleccionado = new GeneradorDeEquipos14589Vs236710
		
		appModel.generarEquipos
		
		var equipos = partido.equipos
		var equipo1 = equipos.equipo1
		var equipo2 = equipos.equipo2
		
		var appModelEquipo1 = Arrays.asList(franco,  lucas,  matias, jorge, pedro)
		var appModelEquipo2 = Arrays.asList(pablo,  carlos,  simon, adrian, patricio)
		
		Assert.assertEquals(appModelEquipo1, equipo1)
		Assert.assertEquals(appModelEquipo2, equipo2)
	}
	
	@Test
	def void testGeneraEquiposYPuedeConfirmar(){
		
		appModel.ordenadorSeleccionado = new OrdenadorPorHandicap
		appModel.criterioSeleccionado = new GeneradorDeEquiposParesContraImpares
		
		appModel.generarEquipos
		
		Assert.assertTrue(appModel.puedeConfirmar)
	}
	
	@Test
	def void testConfirmaEquiposYNoSePuedeVolverAConfirmar(){
		appModel.ordenadorSeleccionado = new OrdenadorPorHandicap
		appModel.criterioSeleccionado = new GeneradorDeEquiposParesContraImpares
		
		appModel.generarEquipos
		appModel.confirmarEquipos
				
		Assert.assertFalse(appModel.puedeConfirmar)
	}
	
	@Test
	def void testNoSeleccionoOrdenadorYNoPuedeGenerar(){
		appModel.criterioSeleccionado = new GeneradorDeEquiposParesContraImpares
		
		Assert.assertFalse(appModel.puedeGenerar)
	}
	
	@Test
	def void testNoSeleccionoCriterioYNoPuedeGenerar(){
		appModel.ordenadorSeleccionado = new OrdenadorPorHandicap
		
		Assert.assertFalse(appModel.puedeGenerar)
	}
	
	@Test
	def void filtrarGrillaPorTodosLosJugadores(){
		
		appModel.filtroDeInfraccionesSeleccionado = new TodosLosJugadores
		appModel.buscarJugadores
		
		Assert.assertEquals(homeJugadores.todosLosJugadores ,appModel.jugadoresDeBusqueda)
		
	}
	
	@Test
	def void filtrarGrillaSoloPorJugadoresConInfracciones(){
		
		appModel.filtroDeInfraccionesSeleccionado = new SoloConInfracciones
		appModel.buscarJugadores
		
		var List<Jugador> jugadoresConInfracciones = homeJugadores.todosLosJugadores.filter(j|!j.infracciones.nullOrEmpty).toList
		
		Assert.assertEquals(jugadoresConInfracciones, appModel.jugadoresDeBusqueda)
	}
	
	@Test
	def void filtrarGrillaSoloPorJugadoresSinJugadores(){
		
		appModel.filtroDeInfraccionesSeleccionado = new SoloSinInfracciones
		appModel.buscarJugadores
		
		var List<Jugador> jugadoresSinInfracciones = homeJugadores.todosLosJugadores.filter(j|j.infracciones.nullOrEmpty).toList
		
		Assert.assertEquals(jugadoresSinInfracciones, appModel.jugadoresDeBusqueda)
	}
}




