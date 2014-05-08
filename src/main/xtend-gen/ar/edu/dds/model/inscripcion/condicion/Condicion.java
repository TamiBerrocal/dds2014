package ar.edu.dds.model.inscripcion.condicion;

import ar.edu.dds.model.Partido;

@SuppressWarnings("all")
public interface Condicion {
  public abstract boolean esSatisfechaPor(final Partido partido);
}
