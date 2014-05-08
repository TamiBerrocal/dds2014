package ar.edu.dds.model.inscripcion;

import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.ModoDeInscripcion;

@SuppressWarnings("all")
public class Estandar implements ModoDeInscripcion {
  public boolean leSirveElPartido(final Partido partido) {
    return true;
  }
  
  public Integer prioridad(final int prioridadBase) {
    return Integer.valueOf((10000 + prioridadBase));
  }
}
