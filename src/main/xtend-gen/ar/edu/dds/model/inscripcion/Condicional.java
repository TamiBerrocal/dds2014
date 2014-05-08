package ar.edu.dds.model.inscripcion;

import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.ModoDeInscripcion;
import ar.edu.dds.model.inscripcion.condicion.Condicion;

@SuppressWarnings("all")
public class Condicional implements ModoDeInscripcion {
  public Condicional(final Condicion condicion) {
    this.setCondicion(condicion);
  }
  
  private Condicion _condicion;
  
  public Condicion getCondicion() {
    return this._condicion;
  }
  
  public void setCondicion(final Condicion condicion) {
    this._condicion = condicion;
  }
  
  public boolean leSirveElPartido(final Partido partido) {
    Condicion _condicion = this.getCondicion();
    return _condicion.esSatisfechaPor(partido);
  }
  
  public Integer prioridad(final int prioridadBase) {
    return Integer.valueOf(prioridadBase);
  }
}
