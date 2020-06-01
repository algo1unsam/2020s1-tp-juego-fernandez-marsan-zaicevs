import logicaGeneral.*

class Accion{
	
	//Accion que ejecuta la logica general
	method accion()
	//Accion que ejecuta la instancia de accion cuando se cambia a ella
	method esCambiadoA(){}
	//Metodo que usa una accion para cambiar a otra
	method cambiarAccionEspacio(accion){
		logicaGeneral.accionEspacio(accion)
		accion.esCambiadoA()
	}
	
	method cambiarAccionEnter(accion){
		logicaGeneral.accionEnter(accion)
		accion.esCambiadoA()
	}
	
	method enfocado() = logicaGeneral.territorioEnfocado()
	method seleccionado() = logicaGeneral.territorioSeleccionado()
	method seleccionado(territorio){
		logicaGeneral.territorioSeleccionado(territorio)
	}
	method seleccionadoEsMarcado() = self.seleccionado() == self.enfocado()
	
	method mismoJugador()=(self.enfocado().jugador() == logicaGeneral.getJugador())
	method sonAdyacentes() = self.enfocado().esAdyacente(self.seleccionado())
}

object noHacerNada inherits Accion{
	override method accion(){}
}