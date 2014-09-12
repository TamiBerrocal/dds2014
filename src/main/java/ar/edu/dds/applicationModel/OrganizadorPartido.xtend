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
import org.uqbar.commons.model.ObservableUtils
import ar.edu.dds.model.inscripcion.Estandar
import org.joda.time.DateTime
import ar.edu.dds.model.Admin
import ar.edu.dds.model.Calificacion

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
		
		//Jugadores
		val admin = new Admin("Enrique", 25, new Estandar, "mail@ejemplo.com")
		this.partido = admin.organizarPartido(new DateTime(2014, 5, 25, 21, 0), "Avellaneda")

		val matias = new Jugador("Matias", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(matias)

		val jorge = new Jugador("Jorge", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(jorge)

		val carlos = new Jugador("Carlos", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(carlos)

		val pablo = new Jugador("Pablo", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(pablo)

		val pedro = new Jugador("Pedro", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(pedro)

		val franco = new Jugador("Franco", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(franco)

		val lucas = new Jugador("lucas", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(lucas)

		val adrian = new Jugador("adrian", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(adrian)

		val simon = new Jugador("simon", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(simon)

		val patricio = new Jugador("patricio", 30, new Estandar, "mail@ejemplo.com")
		this.partido.agregarJugadorPartido(patricio)

		//handicaps
		matias.handicap = 5
		jorge.handicap = 8
		carlos.handicap = 3
		pablo.handicap = 2
		pedro.handicap = 9
		franco.handicap = 1
		lucas.handicap = 4
		adrian.handicap = 7
		simon.handicap = 6
		patricio.handicap = 10

		//Calificaciones jugadores
		val calificacion1 = new Calificacion
		calificacion1.autor = carlos
		calificacion1.nota = 1
		calificacion1.partido = partido

		val calificacion2 = new Calificacion
		calificacion2.autor = pedro
		calificacion2.nota = 2
		calificacion2.partido = partido

		val calificacion3 = new Calificacion
		calificacion3.autor = patricio
		calificacion3.nota = 3
		calificacion3.partido = partido

		val calificacion4 = new Calificacion
		calificacion4.autor = simon
		calificacion4.nota = 4
		calificacion4.partido = partido

		val calificacion5 = new Calificacion
		calificacion5.autor = franco
		calificacion5.nota = 5
		calificacion5.partido = partido

		val calificacion6 = new Calificacion
		calificacion6.autor = lucas
		calificacion6.nota = 6
		calificacion6.partido = partido

		val calificacion7 = new Calificacion
		calificacion7.autor = adrian
		calificacion7.nota = 7
		calificacion7.partido = partido

		val calificacion8 = new Calificacion
		calificacion8.autor = jorge
		calificacion8.nota = 8
		calificacion8.partido = partido

		val calificacion9 = new Calificacion
		calificacion9.autor = pablo
		calificacion9.nota = 9
		calificacion9.partido = partido

		val calificacion10 = new Calificacion
		calificacion10.autor = adrian
		calificacion10.nota = 10
		calificacion10.partido = partido
		
		matias.recibirCalificacion(calificacion10)
		matias.recibirCalificacion(calificacion8)

		jorge.recibirCalificacion(calificacion7)
		jorge.recibirCalificacion(calificacion3)

		carlos.recibirCalificacion(calificacion8)
		carlos.recibirCalificacion(calificacion9)

		pablo.recibirCalificacion(calificacion6)
		pablo.recibirCalificacion(calificacion7)

		pedro.recibirCalificacion(calificacion9)
		pedro.recibirCalificacion(calificacion10)

		franco.recibirCalificacion(calificacion4)
		franco.recibirCalificacion(calificacion5)

		lucas.recibirCalificacion(calificacion1)
		lucas.recibirCalificacion(calificacion2)

		adrian.recibirCalificacion(calificacion3)
		adrian.recibirCalificacion(calificacion4)

		simon.recibirCalificacion(calificacion3)
		simon.recibirCalificacion(calificacion1)

		patricio.recibirCalificacion(calificacion5)
		patricio.recibirCalificacion(calificacion6)
		
	}
}
