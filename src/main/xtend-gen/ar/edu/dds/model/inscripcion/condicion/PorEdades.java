package ar.edu.dds.model.inscripcion.condicion;

import ar.edu.dds.model.Jugador;
import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.condicion.Condicion;
import java.util.List;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;

@SuppressWarnings("all")
public class PorEdades implements Condicion {
  private int edadHasta;
  
  private int cantidad;
  
  public PorEdades(final int edadHasta, final int cantidad) {
    this.edadHasta = edadHasta;
    this.cantidad = cantidad;
  }
  
  public boolean esSatisfechaPor(final Partido partido) {
    int _cantidadDeJovenes = this.cantidadDeJovenes(partido);
    return (_cantidadDeJovenes <= this.cantidad);
  }
  
  public int cantidadDeJovenes(final Partido partido) {
    List<Jugador> _jugadoresInscriptos = partido.jugadoresInscriptos();
    final Function1<Jugador,Boolean> _function = new Function1<Jugador,Boolean>() {
      public Boolean apply(final Jugador j) {
        int _edad = j.getEdad();
        return Boolean.valueOf((_edad <= PorEdades.this.edadHasta));
      }
    };
    Iterable<Jugador> _filter = IterableExtensions.<Jugador>filter(_jugadoresInscriptos, _function);
    return IterableExtensions.size(_filter);
  }
}
