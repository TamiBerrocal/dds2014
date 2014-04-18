package ar.edu.dds

import org.junit.Test
import junit.framework.Assert
import ar.edu.dds.model.Cliente

class HelloXtendTest {
	
	Cliente cliente
	
	@Test
	def void testHelloWorld() {
		cliente = new Cliente() 
		cliente.setMonto(3)
		Assert.assertEquals(3, cliente.monto)
	} 
}