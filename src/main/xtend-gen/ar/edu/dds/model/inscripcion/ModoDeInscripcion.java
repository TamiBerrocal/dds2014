package ar.edu.dds.model.inscripcion;

import ar.edu.dds.model.Partido;

@SuppressWarnings("all")
public interface ModoDeInscripcion {
  public abstract boolean leSirveElPartido(final Partido partido);
  
  public abstract Integer prioridad(final int prioridadBase);
}
