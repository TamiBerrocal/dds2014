package ar.edu.dds.model.equipos.generador

import java.util.List
import ar.edu.dds.model.Jugador
import ar.edu.dds.model.equipos.ParDeEquipos

interface GeneradorDeEquipos {
	
	def ParDeEquipos generar(List<Jugador> jugadoresOrdenados)
}