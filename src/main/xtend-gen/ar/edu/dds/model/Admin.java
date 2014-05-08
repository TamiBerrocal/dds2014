package ar.edu.dds.model;

import ar.edu.dds.model.Jugador;
import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.ModoDeInscripcion;
import java.util.List;
import org.joda.time.DateTime;

@SuppressWarnings("all")
public class Admin extends Jugador {
  public Admin() {
  }
  
  public Admin(final String nombre, final int edad, final ModoDeInscripcion modoDeInscripcion) {
    super(nombre, edad, modoDeInscripcion);
  }
  
  public Partido organizarPartido(final DateTime fechaYHora, final String lugar) {
    return new Partido(fechaYHora, lugar);
  }
  
  public List<Jugador> confirmarPartido(final Partido partido) {
    return partido.confirmar();
  }
}
