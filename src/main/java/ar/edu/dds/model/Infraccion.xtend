package ar.edu.dds.model

import org.joda.time.LocalDate

class Infraccion {

	@Property
	private LocalDate fechaCreacion

	@Property
	private LocalDate validaHasta

	@Property
	String causa

	new() {
		this.fechaCreacion = new LocalDate()
	}

}
