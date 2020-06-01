import logicaGeneral.*
import acciones.accionesPrototipo.*
import acciones.accionesEspacio.*

object pasarTurnoAtaque inherits Accion{
	override method accion(){
		logicaGeneral.siguienteJugador()	
		self.cambiarAccionEspacio(seleccionar)
	}
}

object pasarTurnoRefuerzos inherits Accion{
	override method accion(){
		
	}
}
