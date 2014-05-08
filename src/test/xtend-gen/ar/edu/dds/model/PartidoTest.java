package ar.edu.dds.model;

import ar.edu.dds.exception.EstadoDePartidoInvalidoException;
import ar.edu.dds.exception.NoHaySuficientesJugadoresException;
import ar.edu.dds.model.Admin;
import ar.edu.dds.model.EstadoDePartido;
import ar.edu.dds.model.Jugador;
import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.Condicional;
import ar.edu.dds.model.inscripcion.Estandar;
import ar.edu.dds.model.inscripcion.Solidaria;
import ar.edu.dds.model.inscripcion.condicion.PorEdades;
import ar.edu.dds.model.inscripcion.condicion.PorLugar;
import java.util.List;
import junit.framework.Assert;
import org.eclipse.xtext.xbase.lib.Conversions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IntegerRange;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.joda.time.DateTime;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class PartidoTest {
  private Partido target;
  
  private Admin admin;
  
  private final static String[] NOMBRES = { "Matías", "Martín", "Nicolás", "Santiago", "Andrés", "Gonzalo", "Mario", "Carlos", "Luis", "Esteban", "Nestor", "Jose", "Mariano" };
  
  private void verificarQueElNombreEstaEnElPartido(final String nombre, final Partido partido) {
    List<Jugador> _jugadoresInscriptos = partido.jugadoresInscriptos();
    final Function1<Jugador,Boolean> _function = new Function1<Jugador,Boolean>() {
      public Boolean apply(final Jugador j) {
        String _nombre = j.getNombre();
        return Boolean.valueOf(_nombre.equals(nombre));
      }
    };
    boolean _exists = IterableExtensions.<Jugador>exists(_jugadoresInscriptos, _function);
    Assert.assertTrue(_exists);
  }
  
  private void verificarQueElNombreNoEstaEnElPartido(final String nombre, final Partido partido) {
    List<Jugador> _jugadoresInscriptos = partido.jugadoresInscriptos();
    final Function1<Jugador,Boolean> _function = new Function1<Jugador,Boolean>() {
      public Boolean apply(final Jugador j) {
        String _nombre = j.getNombre();
        return Boolean.valueOf(_nombre.equals(nombre));
      }
    };
    boolean _exists = IterableExtensions.<Jugador>exists(_jugadoresInscriptos, _function);
    Assert.assertFalse(_exists);
  }
  
  @Before
  public void init() {
    Admin _admin = new Admin();
    this.admin = _admin;
    DateTime _dateTime = new DateTime(2014, 5, 25, 21, 0);
    Partido _organizarPartido = this.admin.organizarPartido(_dateTime, "Avellaneda");
    this.target = _organizarPartido;
    IntegerRange _upTo = new IntegerRange(0, 4);
    for (final int i : _upTo) {
      {
        String _get = PartidoTest.NOMBRES[i];
        Estandar _estandar = new Estandar();
        final Jugador jugador = new Jugador(_get, 30, _estandar);
        this.target.agregarJugador(jugador);
      }
    }
  }
  
  @Test(expected = EstadoDePartidoInvalidoException.class)
  public void testPartidoConfirmadoNoPuedeAgregarJugador() {
    this.target.setEstadoDePartido(EstadoDePartido.CONFIRMADO);
    Jugador _jugador = new Jugador();
    _jugador.inscribirseA(this.target);
  }
  
  @Test
  public void testConfirmaPartidoCon11EstandaresDejaLosPrimeros10() {
    IntegerRange _upTo = new IntegerRange(5, 10);
    for (final int i : _upTo) {
      {
        String _get = PartidoTest.NOMBRES[i];
        Estandar _estandar = new Estandar();
        final Jugador jugador = new Jugador(_get, 25, _estandar);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
    EstadoDePartido _estadoDePartido = this.target.getEstadoDePartido();
    Assert.assertEquals(EstadoDePartido.CONFIRMADO, _estadoDePartido);
    List<Jugador> _jugadoresInscriptos = this.target.jugadoresInscriptos();
    int _size = _jugadoresInscriptos.size();
    Assert.assertEquals(10, _size);
    IntegerRange _upTo_1 = new IntegerRange(0, 9);
    for (final int i_1 : _upTo_1) {
      String _get = PartidoTest.NOMBRES[i_1];
      this.verificarQueElNombreEstaEnElPartido(_get, this.target);
    }
    int _size_1 = ((List<String>)Conversions.doWrapArray(PartidoTest.NOMBRES)).size();
    int _minus = (_size_1 - 1);
    IntegerRange _upTo_2 = new IntegerRange(10, _minus);
    for (final int i_2 : _upTo_2) {
      String _get_1 = PartidoTest.NOMBRES[i_2];
      this.verificarQueElNombreNoEstaEnElPartido(_get_1, this.target);
    }
  }
  
  @Test
  public void testConfirmarPartido10EstandaresYUnSolidarioQuedaAfueraElSolidario() {
    Solidaria _solidaria = new Solidaria();
    final Jugador marcos = new Jugador("Marcos", 42, _solidaria);
    this.target.agregarJugador(marcos);
    this.verificarQueElNombreEstaEnElPartido("Marcos", this.target);
    IntegerRange _upTo = new IntegerRange(5, 9);
    for (final int i : _upTo) {
      {
        final Jugador jugador = new Jugador();
        Estandar _estandar = new Estandar();
        jugador.setModoDeInscripcion(_estandar);
        String _get = PartidoTest.NOMBRES[i];
        jugador.setNombre(_get);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
    EstadoDePartido _estadoDePartido = this.target.getEstadoDePartido();
    Assert.assertEquals(EstadoDePartido.CONFIRMADO, _estadoDePartido);
    IntegerRange _upTo_1 = new IntegerRange(0, 9);
    for (final int i_1 : _upTo_1) {
      String _get = PartidoTest.NOMBRES[i_1];
      this.verificarQueElNombreEstaEnElPartido(_get, this.target);
    }
    this.verificarQueElNombreNoEstaEnElPartido("Marcos", this.target);
  }
  
  @Test
  public void testConfirmarPartido10EstandaresYUnCondicionalQuedaAfueraElCondicional() {
    PorLugar _porLugar = new PorLugar("Avellaneda");
    Condicional _condicional = new Condicional(_porLugar);
    final Jugador roman = new Jugador("Román", 42, _condicional);
    this.target.agregarJugador(roman);
    this.verificarQueElNombreEstaEnElPartido("Román", this.target);
    IntegerRange _upTo = new IntegerRange(5, 9);
    for (final int i : _upTo) {
      {
        final Jugador jugador = new Jugador();
        Estandar _estandar = new Estandar();
        jugador.setModoDeInscripcion(_estandar);
        String _get = PartidoTest.NOMBRES[i];
        jugador.setNombre(_get);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
    EstadoDePartido _estadoDePartido = this.target.getEstadoDePartido();
    Assert.assertEquals(EstadoDePartido.CONFIRMADO, _estadoDePartido);
    IntegerRange _upTo_1 = new IntegerRange(0, 9);
    for (final int i_1 : _upTo_1) {
      String _get = PartidoTest.NOMBRES[i_1];
      this.verificarQueElNombreEstaEnElPartido(_get, this.target);
    }
    this.verificarQueElNombreNoEstaEnElPartido("Román", this.target);
  }
  
  @Test
  public void testConfirmarPartido9Estandare1Condicional1SolidarioPriorizaAlSolidario() {
    PorLugar _porLugar = new PorLugar("Avellaneda");
    Condicional _condicional = new Condicional(_porLugar);
    final Jugador roman = new Jugador("Román", 42, _condicional);
    this.target.agregarJugador(roman);
    Solidaria _solidaria = new Solidaria();
    final Jugador marcos = new Jugador("Marcos", 42, _solidaria);
    this.target.agregarJugador(marcos);
    this.verificarQueElNombreEstaEnElPartido("Román", this.target);
    this.verificarQueElNombreEstaEnElPartido("Marcos", this.target);
    IntegerRange _upTo = new IntegerRange(5, 8);
    for (final int i : _upTo) {
      {
        final Jugador jugador = new Jugador();
        Estandar _estandar = new Estandar();
        jugador.setModoDeInscripcion(_estandar);
        String _get = PartidoTest.NOMBRES[i];
        jugador.setNombre(_get);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
    EstadoDePartido _estadoDePartido = this.target.getEstadoDePartido();
    Assert.assertEquals(EstadoDePartido.CONFIRMADO, _estadoDePartido);
    IntegerRange _upTo_1 = new IntegerRange(0, 8);
    for (final int i_1 : _upTo_1) {
      String _get = PartidoTest.NOMBRES[i_1];
      this.verificarQueElNombreEstaEnElPartido(_get, this.target);
    }
    this.verificarQueElNombreEstaEnElPartido("Marcos", this.target);
    this.verificarQueElNombreNoEstaEnElPartido("Román", this.target);
  }
  
  @Test
  public void testConfirmarPartido5Estandares6SolidariosEliminaAlPrimerSolidarioQueSeAnoto() {
    Solidaria _solidaria = new Solidaria();
    final Jugador marcos = new Jugador("Marcos", 42, _solidaria);
    this.target.agregarJugador(marcos);
    this.verificarQueElNombreEstaEnElPartido("Marcos", this.target);
    IntegerRange _upTo = new IntegerRange(5, 9);
    for (final int i : _upTo) {
      {
        final Jugador jugador = new Jugador();
        Solidaria _solidaria_1 = new Solidaria();
        jugador.setModoDeInscripcion(_solidaria_1);
        String _get = PartidoTest.NOMBRES[i];
        jugador.setNombre(_get);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
    EstadoDePartido _estadoDePartido = this.target.getEstadoDePartido();
    Assert.assertEquals(EstadoDePartido.CONFIRMADO, _estadoDePartido);
    IntegerRange _upTo_1 = new IntegerRange(0, 9);
    for (final int i_1 : _upTo_1) {
      String _get = PartidoTest.NOMBRES[i_1];
      this.verificarQueElNombreEstaEnElPartido(_get, this.target);
    }
    this.verificarQueElNombreNoEstaEnElPartido("Marcos", this.target);
  }
  
  @Test(expected = NoHaySuficientesJugadoresException.class)
  public void testNoSePuedeConfirmarPartidoConMenosDe10Jugadores() {
    this.admin.confirmarPartido(this.target);
  }
  
  @Test(expected = NoHaySuficientesJugadoresException.class)
  public void test7Estandares4CondicionalQueNoPasanLaCondicionNoSePuedeConfirmar() {
    IntegerRange _upTo = new IntegerRange(5, 6);
    for (final int i : _upTo) {
      {
        String _get = PartidoTest.NOMBRES[i];
        Estandar _estandar = new Estandar();
        final Jugador jugador = new Jugador(_get, 30, _estandar);
        Estandar _estandar_1 = new Estandar();
        jugador.setModoDeInscripcion(_estandar_1);
        String _get_1 = PartidoTest.NOMBRES[i];
        jugador.setNombre(_get_1);
        this.target.agregarJugador(jugador);
      }
    }
    IntegerRange _upTo_1 = new IntegerRange(7, 10);
    for (final int i_1 : _upTo_1) {
      {
        String _get = PartidoTest.NOMBRES[i_1];
        PorEdades _porEdades = new PorEdades(30, 6);
        Condicional _condicional = new Condicional(_porEdades);
        final Jugador jugador = new Jugador(_get, 35, _condicional);
        this.target.agregarJugador(jugador);
      }
    }
    this.admin.confirmarPartido(this.target);
  }
}
