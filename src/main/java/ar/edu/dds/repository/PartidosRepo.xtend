package ar.edu.dds.repository

import java.util.List
import ar.edu.dds.model.Partido

interface PartidosRepo {
	
	def List<Partido> todosLosPartidos()
}