package ar.edu.dds.model;

import ar.edu.dds.model.Partido;
import ar.edu.dds.model.inscripcion.ModoDeInscripcion;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

@SuppressWarnings("all")
public class Jugador {
  private ModoDeInscripcion _modoDeInscripcion;
  
  public ModoDeInscripcion getModoDeInscripcion() {
    return this._modoDeInscripcion;
  }
  
  public void setModoDeInscripcion(final ModoDeInscripcion modoDeInscripcion) {
    this._modoDeInscripcion = modoDeInscripcion;
  }
  
  private String _nombre;
  
  public String getNombre() {
    return this._nombre;
  }
  
  public void setNombre(final String nombre) {
    this._nombre = nombre;
  }
  
  private int _edad;
  
  public int getEdad() {
    return this._edad;
  }
  
  public void setEdad(final int edad) {
    this._edad = edad;
  }
  
  public Jugador(final String nombre, final int edad, final ModoDeInscripcion modoDeInscripcion) {
    this.setNombre(nombre);
    this.setEdad(edad);
    this.setModoDeInscripcion(modoDeInscripcion);
  }
  
  public Jugador() {
  }
  
  public void inscribirseA(final Partido partido) {
    partido.agregarJugador(this);
  }
  
  public boolean leSirveElPartido(final Partido partido) {
    ModoDeInscripcion _modoDeInscripcion = this.getModoDeInscripcion();
    return _modoDeInscripcion.leSirveElPartido(partido);
  }
  
  public Integer prioridad(final Integer prioridadBase) {
    ModoDeInscripcion _modoDeInscripcion = this.getModoDeInscripcion();
    return _modoDeInscripcion.prioridad((prioridadBase).intValue());
  }
  
  public int hashCode() {
    return HashCodeBuilder.reflectionHashCode(this);
  }
  
  public boolean equals(final Object obj) {
    return EqualsBuilder.reflectionEquals(obj, this);
  }
  
  public String toString() {
    return this.getNombre();
  }
}
