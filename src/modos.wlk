import logicaGeneral.*
import acciones.*

class Modo{
	//Acciones de teclado
	method accionEnter()
	method accionEspacio()
	
	//Metodo que se invoca por jugador
	method accionNuevoJugador()
	
	//Metodos que se invocan automaticamente cuando entra al modo o termina el modo
	method termino()
	method empezo()
	
	//Metodos de ayuda
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

object asignacion inherits Modo {
	override method accionEnter(){}
	
	override method accionEspacio(){
		if(!self.enfocado().estaAsignado()){
			logicaGeneral.asignarTerritorioAJugador()
			logicaGeneral.siguienteJugador()
			self.comprobar()
		}
	}
	
	override method termino(){}	
	override method empezo(){}
	override method accionNuevoJugador(){}
	
	method comprobar(){
		if(logicaGeneral.todosTerritoriosAsignados()){
			logicaGeneral.cambiarModoA(refuerzos)
		}
	}

}

object ataque inherits Modo {
	var property accion = seleccionar
	
	override method accionEnter(){
		logicaGeneral.siguienteJugador()
	}
	
	override method accionEspacio(){
		accion.accion()
	}
	
	override method termino(){
		logicaGeneral.cambiarModoA(refuerzos)
	}
	
	override method empezo(){
		self.seleccionado(null)
	}
	
	override method accionNuevoJugador(){
		self.seleccionado(null)
	}
}

object refuerzos inherits Modo {
	override method accionEnter(){
		//No debe hacer nada
	}
	
	override method accionEspacio(){
		if(self.perteneceAJugadorActivo()){
			logicaGeneral.agregarRefuerzo()
			self.comprobarRefuerzos()
		}
	}
	
	override method termino(){
		logicaGeneral.cambiarModoA(ataque)
	}
	
	override method empezo(){
		logicaGeneral.removerJugadoresDerrotados()
		logicaGeneral.calcularRefuerzos()
	}
	
	override method accionNuevoJugador(){
		
	}
	
	method comprobarRefuerzos(){
		if(!logicaGeneral.jugadorTieneRefuerzos()){
			logicaGeneral.siguienteJugador()
		}
	}
}
