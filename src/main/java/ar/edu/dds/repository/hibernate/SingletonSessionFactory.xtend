package ar.edu.dds.repository.hibernate

import ar.edu.dds.model.Jugador
import ar.edu.dds.model.Partido
import ar.edu.dds.model.Admin
import ar.edu.dds.model.equipos.ParDeEquipos
import ar.edu.dds.model.inscripcion.ModoDeInscripcion
import ar.edu.dds.model.inscripcion.Estandar
import ar.edu.dds.model.Infraccion
import ar.edu.dds.model.Calificacion
import ar.edu.dds.model.ArmadorEquipos
import ar.edu.dds.model.equipos.generador.GeneradorDeEquipos
import ar.edu.dds.model.equipos.ordenador.OrdenadorDeJugadores
import ar.edu.dds.observer.inscripcion.InscripcionDeJugadorObserver
import ar.edu.dds.observer.inscripcion.NotificarAmigosObserver
import ar.edu.dds.observer.inscripcion.HayDiezJugadoresObserver
import ar.edu.dds.observer.baja.BajaDeJugadorObserver
import ar.edu.dds.observer.baja.NotificarAdministradorObserver
import ar.edu.dds.observer.baja.InfraccionObserver
import org.hibernate.cfg.AnnotationConfiguration
import org.hibernate.SessionFactory
import ar.edu.dds.model.equipos.JugadorEnEquipo

class SingletonSessionFactory {
	
	static SessionFactory INSTANCE
	
	def static SessionFactory getInstance() {
		if (INSTANCE == null) {
			INSTANCE = new AnnotationConfiguration()
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
								.addAnnotatedClass(ParDeEquipos)
								.addAnnotatedClass(JugadorEnEquipo)
								.buildSessionFactory()
		}
		INSTANCE
	}
	
}