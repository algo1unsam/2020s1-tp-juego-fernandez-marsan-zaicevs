import logicaGeneral.*
import acciones.accionesPrototipo.*
import acciones.accionesEspacio.*

//Accion de enter de refuerzos, no debe hacer nada con enter y que todos los refuerzos deben ser asignados
object pasarTurnoRefuerzos inherits Accion{
	override method accion(){
		//No hay accion, todas las tropas deben ser asignadas
	}
	
	//Cuando entro en esta accion, se deben calcular los refuerzos y la accion de espacio pasa a agregarRefuerzos
	override method esCambiadoA(){
		//No quiero calcular los refuerzos de jugadores que ya no juegan
		logicaGeneral.removerJugadoresDerrotados()
		logicaGeneral.calcularRefuerzos()
		self.cambiarAccionEspacio(agregarRefuerzos)
	}
}

//Accion de enter de pasar el turno cuando esta en modo de ataque
object pasarTurnoAtaque inherits Accion{
	override method accion(){
		//No quiero poder pasar a un jugador que ya no tiene territorios
		self.seleccionado(null)
		logicaGeneral.removerJugadoresDerrotados()
		logicaGeneral.siguienteJugador()
		if(logicaGeneral.esPrimerJugador()){
			self.cambiarAccionEnter(pasarTurnoRefuerzos)
		}
		
	}
	
	override method esCambiadoA(){
		self.cambiarAccionEspacio(seleccionar)
	}
}
