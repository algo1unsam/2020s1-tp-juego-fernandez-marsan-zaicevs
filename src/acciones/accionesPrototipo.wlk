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
	//Devuelve al jugador activo
	method jugadorActivo() = logicaGeneral.getJugador()
	//Devuelve true si el territorio seleccionado y el terriotio enfocado son el mismo
	method seleccionadoEsMarcado() = self.seleccionado() == self.enfocado()
	//Devuelve true si el territorio seleccionado y el territorio enfocado pertenecen al mismo jugador
	method mismoJugador()=(self.enfocado().jugador() == logicaGeneral.getJugador())
	//Devuelve true si el territorio seleccionado y el enfocado son adyacentes
	method sonAdyacentes() = self.enfocado().esAdyacente(self.seleccionado())
	//Devuelve true si el territorio enfocado pertenece al jugador activo
	method perteneceAJugadorActivo() = self.enfocado().jugador() == self.jugadorActivo()
}

object noHacerNada inherits Accion{
	override method accion(){}
}