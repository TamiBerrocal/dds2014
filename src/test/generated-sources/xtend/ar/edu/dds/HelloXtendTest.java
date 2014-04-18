package ar.edu.dds;

import ar.edu.dds.model.Cliente;
import junit.framework.Assert;
import org.junit.Test;

@SuppressWarnings("all")
public class HelloXtendTest {
  private Cliente cliente;
  
  @Test
  public void testHelloWorld() {
    Cliente _cliente = new Cliente();
    this.cliente = _cliente;
    this.cliente.setMonto(4);
    int _monto = this.cliente.getMonto();
    Assert.assertEquals(4, _monto);
  }
}
