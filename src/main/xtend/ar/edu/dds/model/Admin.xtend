package ar.edu.dds.model

import org.joda.time.DateTime

class Admin {
	
	def Partido organizarPartido(DateTime fechaYHora, String lugar) {
		new Partido(fechaYHora, lugar)
	}
}