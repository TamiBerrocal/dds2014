package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.JugadoresRepo
import ar.edu.dds.ui.applicationmodel.BusquedaDeJugadores
import ar.edu.dds.model.Jugador
import java.util.List
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException
import ar.edu.dds.model.Rechazo
import java.util.ArrayList
import org.hibernate.Session

class JugadoresHibernateRepo extends AbstractRepoHibernate<Jugador> implements JugadoresRepo {
	
	static JugadoresHibernateRepo INSTANCE
	
	def static JugadoresHibernateRepo getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new JugadoresHibernateRepo
		}
		INSTANCE
	}
	
	new(){
		
	}
	
	override get(Long id) {
		var Jugador jugador = null
		val session = sessionFactory.openSession
		try {
			jugador = session.get(Jugador, id) as Jugador
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		jugador
	}
	
	override busquedaCompleta(BusquedaDeJugadores busqueda) {
		var List<Jugador> result = null
		val session = sessionFactory.openSession
		try {
			result = session
					.createCriteria(typeof(Jugador))
					.add(Restrictions.like("_nombre", busqueda.nombreJugador+"%"))
					//.add(Restrictions.like("_apodo", busqueda.apodoJugador+"%"))
					//.add(Restrictions.le("_fechaNacimiento", busqueda.fechaNacJugador))
					//.add(Restrictions.between(
						//"_handicap", busqueda.minHandicapJugador, busqueda.maxHandicapJugador))
//					.add(Restrictions.between(
//						"_promedio", busqueda.minPromedioJugador, busqueda.maxPromedioJugador))
					.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	}

	override buscarPorApodo(String apodo) {
		var List<Jugador> result = null
		val session = sessionFactory.openSession
		try {
			result = session
					.createCriteria(typeof(Jugador))
					.add(Restrictions.like("_apodo", apodo+"%"))
					.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	}
	
	override aprobarJugador(Jugador jugador) {
		jugador.aprobado = true
		add(jugador)
		}

	override rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		val rechazo = new Rechazo(jugador, motivoDeRechazo)
		executeBatch([ session| (session as Session).saveOrUpdate(rechazo)])
	}
	
	override buscarPorNombre(String nombre) {
		var List<Jugador> result = null
		val session = sessionFactory.openSession
		try {
			result = session
					.createCriteria(typeof(Jugador))
					.add(Restrictions.like("_nombre", nombre+"%"))
					.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	}
	
	def List<Jugador> jugadoresAprobados() {
		var List<Jugador> aprobados = null
		val session = sessionFactory.openSession
		try {
			aprobados = session
					.createCriteria(Jugador)
					.add(Restrictions.eq("_aprobado", true))
					.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		aprobados
	}

	def List<Jugador> jugadoresPendientesDeAprobacion() {	
		var List<Jugador> pendientes = null
		val session = sessionFactory.openSession
		try {
			pendientes = session
					.createCriteria(Jugador)
					.add(Restrictions.eq("_aprobado", false))
					.add(Restrictions.ne("class", "Admin"))
					.list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		pendientes
	}

	override List<Jugador> todosLosJugadores() {
		val result = new ArrayList<Jugador>
		result.addAll(jugadoresAprobados)
		result.addAll(jugadoresPendientesDeAprobacion)
		result
	}
	
	def existe(Jugador jugador) {
		buscarPorNombre(jugador.nombre) != null
	}

}