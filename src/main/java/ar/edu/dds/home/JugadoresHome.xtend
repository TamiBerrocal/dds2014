package ar.edu.dds.home

import java.util.List
import ar.edu.dds.model.Jugador
import java.util.ArrayList
import ar.edu.dds.model.Rechazo

class JugadoresHome {

	private static JugadoresHome INSTANCE

	List<Jugador> jugadoresAprobados
	List<Jugador> jugadoresPendientesDeAprobacion

	List<Rechazo> rechazos

	def void recomendarNuevoJugador(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.add(jugador)
	}

	def void aprobarJugador(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.remove(jugador)
		this.jugadoresAprobados.add(jugador)
	}

	def void rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		this.jugadoresPendientesDeAprobacion.remove(jugador)
		this.rechazos.add(new Rechazo(jugador, motivoDeRechazo))
	}

	def boolean estaRechazado(Jugador jugador) {
		this.jugadoresRechazados().contains(jugador)
	}

	def boolean estaAprobado(Jugador jugador) {
		this.jugadoresAprobados.contains(jugador)
	}

	def boolean estaPendiente(Jugador jugador) {
		this.jugadoresPendientesDeAprobacion.contains(jugador)
	}

	// Singleton
	private new() {
		this.jugadoresAprobados = new ArrayList
		this.jugadoresPendientesDeAprobacion = new ArrayList
		this.rechazos = new ArrayList
	}

	def static JugadoresHome getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new JugadoresHome
		}
		INSTANCE
	}

	// Getters
	def List<Jugador> jugadoresAprobados() {
		this.jugadoresAprobados
	}

	def List<Jugador> jugadoresPendientesDeAprobacion() {
		this.jugadoresPendientesDeAprobacion
	}

	def List<Jugador> jugadoresRechazados() {
		this.rechazos.map[r|r.jugador]
	}

	def List<Rechazo> rechazos() {
		this.rechazos
	}

}
