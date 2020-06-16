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
	
	//Metodo que se va a ejecutar cuando le toque a la computadora en este modo
	method computadora()
	
	//Metodos de ayuda
	method enfocado() = logicaGeneral.territorioEnfocado()
	method enfocado(territorio){ logicaGeneral.territorioEnfocado(territorio) }
	method seleccionado() = logicaGeneral.territorioSeleccionado()
	method seleccionado(territorio){logicaGeneral.territorioSeleccionado(territorio) }
	//Devuelve al jugador activo
	method jugadorActivo() = logicaGeneral.getJugador()
	//Devuelve true si el territorio seleccionado y el territorio enfocado pertenecen al mismo jugador
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

	override method computadora(){
		self.enfocado(aleatorio.deLista(logicaGeneral.territoriosSinAsignar()))
		self.accionEspacio()
	}
	
}

object ataque inherits Modo {
	var property espacio
	
	override method accionEnter(){
		logicaGeneral.siguienteJugador()
	}
	
	override method accionEspacio(){
		espacio.accion()
	}
	
	override method termino(){
		logicaGeneral.cambiarModoA(refuerzos)
	}
	
	override method empezo(){
		//self.seleccionado(null)
	}
	
	override method accionNuevoJugador(){
		self.seleccionado(null)
		espacio = seleccionar
	}
	
	override method computadora(){
		if(self.puedoAtacar()){
			const territoriosPuedenAtacar = logicaGeneral.getJugador().listaTerritoriosPuedenAtacar()
			const territorioAtacante = aleatorio.deLista(territoriosPuedenAtacar)
			self.enfocado(territorioAtacante)
			self.accionEspacio()
			const territorioAtacado = aleatorio.deLista(territorioAtacante.listaPuedoAtacar())
			self.enfocado(territorioAtacado)
			self.accionEspacio()
			self.computadora()
		}else{
			self.accionEnter()
		}
	}
	
	method puedoAtacar() = logicaGeneral.getJugador().puedoAtacar()
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
		self.seleccionado(null)
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
	
	override method computadora(){
		const cantidadRefuerzos = logicaGeneral.getJugador().refuerzos()
		(1 .. cantidadRefuerzos).forEach({i =>
			self.asignarUnTerritorioComputadora()
		})
	}
	
	method asignarUnTerritorioComputadora(){
		self.enfocado(aleatorio.deLista(logicaGeneral.getJugador().listaTerritorios()))
		self.accionEspacio()
	}
}
