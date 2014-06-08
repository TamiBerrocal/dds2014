package ar.edu.dds.model.equipos

import java.util.List
import ar.edu.dds.model.Jugador

interface GeneradorDeEquipos {
	
	def ParDeEquipos generar(List<Jugador> jugadoresOrdenados)
}