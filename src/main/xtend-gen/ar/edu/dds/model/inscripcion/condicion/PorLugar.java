package ar.edu.dds.model.inscripcion.condicion;

import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.condicion.Condicion;

@SuppressWarnings("all")
public class PorLugar implements Condicion {
  public PorLugar(final String lugar) {
    this.lugar = lugar;
  }
  
  private String lugar;
  
  public boolean esSatisfechaPor(final Partido partido) {
    String _lugar = partido.getLugar();
    return this.lugar.equals(_lugar);
  }
}
