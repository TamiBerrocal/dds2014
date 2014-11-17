package ar.edu.dds.repository.hibernate

import ar.edu.dds.model.Admin
import ar.edu.dds.model.ArmadorEquipos
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.Infraccion
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.equipos.ParDeEquipos
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.baja.InfraccionObserver
import ar.edu.dds.observer.baja.NotificarAdministradorObserver
import ar.edu.dds.observer.inscripcion.HayDiezJugadoresObserver
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import ar.edu.dds.observer.inscripcion.NotificarAmigosObserver
import org.apache.commons.collections.Closure
import org.hibernate.HibernateException
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.cfg.AnnotationConfiguration

abstract class AbstractRepoHibernate<T> {
	
	private static final SessionFactory sessionFactory = 
		new AnnotationConfiguration()
			.configure()
			.addAnnotatedClass(Jugador)
			.addAnnotatedClass(Partido)
			.addAnnotatedClass(Admin)
			.addAnnotatedClass(ParDeEquipos)
			.addAnnotatedClass(ModoDeInscripcion)
			.addAnnotatedClass(Estandar)
			.addAnnotatedClass(Infraccion)
			.addAnnotatedClass(Calificacion)
			.addAnnotatedClass(ArmadorEquipos)
			.addAnnotatedClass(GeneradorDeEquipos)
			.addAnnotatedClass(OrdenadorDeJugadores)
			.addAnnotatedClass(InscripcionDeJugadorObserver)
			.addAnnotatedClass(NotificarAmigosObserver)
			.addAnnotatedClass(HayDiezJugadoresObserver)
			.addAnnotatedClass(BajaDeJugadorObserver)
			.addAnnotatedClass(NotificarAdministradorObserver)
			.addAnnotatedClass(InfraccionObserver)
			.buildSessionFactory()

	def getSessionFactory() {
		sessionFactory
	}
	
	def T get(Long id) {}

	 
	/* Para el test */
	/* Necesitamos siempre hacer lo mismo:
	 * 1) abrir la sesión
	 * 2) ejecutar un query que actualice
	 * 3) commitear los cambios 
	 * 4) y cerrar la sesión
	 * 5) pero además controlar errores
	 * Entonces definimos un método executeBatch que hace eso
	 * y recibimos un closure que es lo que cambia cada vez
	 * (otra opción podría haber sido definir un template method)
	 */
	 
	 
	def void add(T object) {
		this.executeBatch([ session| (session as Session).saveOrUpdate(object)])
	}
		
	def void delete(T object) {
		this.executeBatch([ session| (session as Session).delete(object)])
	}
	
	def void executeBatch(Closure closure) {
		val session = sessionFactory.openSession
		try {
			session.beginTransaction
			closure.execute(session)
			session.transaction.commit
		} catch (HibernateException e) {
			session.transaction.rollback
			throw new RuntimeException(e)
		} finally {
			session.close
		}
	}
	
	def void deleteAll() {
		this.executeBatch([ session| (session as Session)
									.createCriteria(this.class)
									.list
									.forEach [ elem | this.delete(elem) ]
		])
	}
	
}
