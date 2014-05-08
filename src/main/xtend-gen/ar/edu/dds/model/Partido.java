package ar.edu.dds.model;

import ar.edu.dds.exception.EstadoDePartidoInvalidoException;
import ar.edu.dds.exception.NoHaySuficientesJugadoresException;
import ar.edu.dds.model.EstadoDePartido;
import ar.edu.dds.model.Jugador;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.ListExtensions;
import org.eclipse.xtext.xbase.lib.Pair;
import org.joda.time.DateTime;

@SuppressWarnings("all")
public class Partido {
  /**
   * Lista de jugadores inscriptos con sus respectivas prioridades por orden
   */
  private List<Pair<Jugador,Integer>> jugadoresConSusPrioridadesSegunOrden;
  
  private DateTime _fechaYHora;
  
  public DateTime getFechaYHora() {
    return this._fechaYHora;
  }
  
  public void setFechaYHora(final DateTime fechaYHora) {
    this._fechaYHora = fechaYHora;
  }
  
  private String _lugar;
  
  public String getLugar() {
    return this._lugar;
  }
  
  public void setLugar(final String lugar) {
    this._lugar = lugar;
  }
  
  private EstadoDePartido _estadoDePartido;
  
  public EstadoDePartido getEstadoDePartido() {
    return this._estadoDePartido;
  }
  
  public void setEstadoDePartido(final EstadoDePartido estadoDePartido) {
    this._estadoDePartido = estadoDePartido;
  }
  
  private Integer prioridadAAsignarPorOrden;
  
  public Partido(final DateTime fechaYHora, final String lugar) {
    this.setFechaYHora(fechaYHora);
    this.setLugar(lugar);
    ArrayList<Pair<Jugador,Integer>> _arrayList = new ArrayList<Pair<Jugador, Integer>>();
    this.jugadoresConSusPrioridadesSegunOrden = _arrayList;
    this.setEstadoDePartido(EstadoDePartido.ABIERTA_LA_INSCRIPCION);
    this.prioridadAAsignarPorOrden = Integer.valueOf(200);
  }
  
  public List<Jugador> confirmar() {
    try {
      List<Jugador> _xblockexpression = null;
      {
        EstadoDePartido _estadoDePartido = this.getEstadoDePartido();
        boolean _equals = EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(_estadoDePartido);
        if (_equals) {
          this.removerALosQueNoJugarian();
          final Function1<Pair<Jugador,Integer>,Integer> _function = new Function1<Pair<Jugador,Integer>,Integer>() {
            public Integer apply(final Pair<Jugador,Integer> j) {
              Jugador _key = j.getKey();
              Integer _value = j.getValue();
              Integer _prioridad = _key.prioridad(_value);
              return Integer.valueOf((-(_prioridad).intValue()));
            }
          };
          List<Pair<Jugador,Integer>> _sortBy = IterableExtensions.<Pair<Jugador,Integer>, Integer>sortBy(this.jugadoresConSusPrioridadesSegunOrden, _function);
          Iterable<Pair<Jugador,Integer>> _take = IterableExtensions.<Pair<Jugador,Integer>>take(_sortBy, 10);
          List<Pair<Jugador,Integer>> _list = IterableExtensions.<Pair<Jugador,Integer>>toList(_take);
          this.jugadoresConSusPrioridadesSegunOrden = _list;
          List<Jugador> _jugadoresInscriptos = this.jugadoresInscriptos();
          final int size = _jugadoresInscriptos.size();
          boolean _equals_1 = Integer.valueOf(size).equals(Integer.valueOf(10));
          if (_equals_1) {
            this.setEstadoDePartido(EstadoDePartido.CONFIRMADO);
          } else {
            throw new NoHaySuficientesJugadoresException((("Solamente confirmaron " + Integer.valueOf(size)) + "jugadores..."));
          }
        } else {
          EstadoDePartido _estadoDePartido_1 = this.getEstadoDePartido();
          String _plus = ("Imposible confirmar partido con estado: " + _estadoDePartido_1);
          throw new EstadoDePartidoInvalidoException(_plus);
        }
        _xblockexpression = this.jugadoresInscriptos();
      }
      return _xblockexpression;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public List<Jugador> jugadoresInscriptos() {
    final Function1<Pair<Jugador,Integer>,Jugador> _function = new Function1<Pair<Jugador,Integer>,Jugador>() {
      public Jugador apply(final Pair<Jugador,Integer> par) {
        return par.getKey();
      }
    };
    return ListExtensions.<Pair<Jugador,Integer>, Jugador>map(this.jugadoresConSusPrioridadesSegunOrden, _function);
  }
  
  public void agregarJugador(final Jugador jugador) {
    try {
      EstadoDePartido _estadoDePartido = this.getEstadoDePartido();
      boolean _equals = EstadoDePartido.ABIERTA_LA_INSCRIPCION.equals(_estadoDePartido);
      if (_equals) {
        Pair<Jugador,Integer> _pair = new Pair<Jugador, Integer>(jugador, this.prioridadAAsignarPorOrden);
        this.jugadoresConSusPrioridadesSegunOrden.add(_pair);
        this.prioridadAAsignarPorOrden = Integer.valueOf(((this.prioridadAAsignarPorOrden).intValue() - 10));
      } else {
        EstadoDePartido _estadoDePartido_1 = this.getEstadoDePartido();
        String _plus = ("Imposible agregar jugadores a un partido con estado: " + _estadoDePartido_1);
        throw new EstadoDePartidoInvalidoException(_plus);
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public void reemplazarJugador(final Jugador jugador, final Jugador reemplazo) {
    final Pair<Jugador,Integer> jugadorConSuPrioridadAReemplazar = this.quitarJugador(jugador);
    Integer _value = jugadorConSuPrioridadAReemplazar.getValue();
    Pair<Jugador,Integer> _pair = new Pair<Jugador, Integer>(reemplazo, _value);
    this.jugadoresConSusPrioridadesSegunOrden.add(_pair);
  }
  
  public void darDeBajaJugador(final Jugador jugador) {
    this.quitarJugador(jugador);
  }
  
  private Pair<Jugador,Integer> quitarJugador(final Jugador jugador) {
    Pair<Jugador,Integer> _xblockexpression = null;
    {
      final Function1<Pair<Jugador,Integer>,Boolean> _function = new Function1<Pair<Jugador,Integer>,Boolean>() {
        public Boolean apply(final Pair<Jugador,Integer> par) {
          Jugador _key = par.getKey();
          return Boolean.valueOf(_key.equals(jugador));
        }
      };
      final Pair<Jugador,Integer> jugadorConSuPrioridadADarDeBaja = IterableExtensions.<Pair<Jugador,Integer>>findFirst(this.jugadoresConSusPrioridadesSegunOrden, _function);
      this.jugadoresConSusPrioridadesSegunOrden.remove(jugadorConSuPrioridadADarDeBaja);
      _xblockexpression = jugadorConSuPrioridadADarDeBaja;
    }
    return _xblockexpression;
  }
  
  private void removerALosQueNoJugarian() {
    final Function1<Pair<Jugador,Integer>,Boolean> _function = new Function1<Pair<Jugador,Integer>,Boolean>() {
      public Boolean apply(final Pair<Jugador,Integer> j) {
        Jugador _key = j.getKey();
        return Boolean.valueOf(_key.leSirveElPartido(Partido.this));
      }
    };
    Iterable<Pair<Jugador,Integer>> _filter = IterableExtensions.<Pair<Jugador,Integer>>filter(this.jugadoresConSusPrioridadesSegunOrden, _function);
    List<Pair<Jugador,Integer>> _list = IterableExtensions.<Pair<Jugador,Integer>>toList(_filter);
    this.jugadoresConSusPrioridadesSegunOrden = _list;
  }
  
  public String toString() {
    return ToStringBuilder.reflectionToString(this);
  }
}
