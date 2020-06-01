import logicaGeneral.*
import acciones.accionesPrototipo.*
import acciones.accionesEspacio.*

object pasarTurnoRefuerzos inherits Accion{
	override method accion(){
		//No hay accion, todas las tropas deben ser asignadas
	}
	
	override method esCambiadoA(){
		logicaGeneral.calcularRefuerzos()
		self.cambiarAccionEspacio(agregarRefuerzos)
	}
}

object pasarTurnoAtaque inherits Accion{
	override method accion(){
		if(logicaGeneral.esUltimoJugador()){
			self.cambiarAccionEnter(pasarTurnoRefuerzos)
		}
		logicaGeneral.siguienteJugador()
	}
	
	override method esCambiadoA(){
		console.println("Cambio a selecion y ataque")
		self.cambiarAccionEspacio(seleccionar)
	}
}
