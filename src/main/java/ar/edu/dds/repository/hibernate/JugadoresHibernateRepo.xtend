package ar.edu.dds.repository.hibernate

import ar.edu.dds.repository.JugadoresRepo
import ar.edu.dds.ui.applicationmodel.BusquedaDeJugadores
import ar.edu.dds.model.Jugador
import java.util.List
import org.hibernate.criterion.Restrictions
import org.hibernate.HibernateException
import ar.edu.dds.model.Rechazo

class JugadoresHibernateRepo extends AbstractRepoHibernate<Jugador> implements JugadoresRepo {

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
			result = session.createCriteria(typeof(Jugador)).createAlias("_jugadores", "jugadores").add(
				Restrictions.like("jugadores.nombre", busqueda.nombreJugador.toString)).add(
				Restrictions.like("jugadores.apodo", busqueda.apodoJugador)).add(
				Restrictions.le("jugadores.fecha_nac", busqueda.fechaNacJugador)).add(
				Restrictions.between("jugadores.handicap", busqueda.minHandicapJugador, busqueda.maxHandicapJugador))
				//.add(Restrictions.between()) buscar por el promedio
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
			result = session.createCriteria(typeof(Jugador)).createAlias("_jugadores", "jugadores").add(
				Restrictions.like("jugadores.apodo", apodo)).list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	}

	override aprobarJugador(Jugador jugador) {
		jugador.aprobado = true
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.saveOrUpdate(jugador)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	override rechazarJugador(Jugador jugador, String motivoDeRechazo) {
		var rechazo = new Rechazo(jugador, motivoDeRechazo)
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			session.saveOrUpdate(rechazo)
			session.getTransaction.commit
		} catch (HibernateException e) {
			session.getTransaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}

	override buscarPorNombre(String nombre) {
		var List<Jugador> result = null
		val session = sessionFactory.openSession
		try {
			result = session.createCriteria(typeof(Jugador)).createAlias("_jugadores", "jugadores").add(
				Restrictions.like("jugadores.nombre", nombre)).list
		} catch (HibernateException e) {
			throw new RuntimeException(e)
		} finally {
			session.close
		}
		result
	}

}
