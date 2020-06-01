import logicaGeneral.*

//El concepto de accion es que la logica general no se tenga que encargar de cada posible evento que se tenga que realizar.
//Por ejemplo vamos a tener primero eventos de asignasion de territorios, eventos de ataque, eventos de mover infanteria y
//eventos de reagrupacion

//Si fueramos a poner todas esa logica en la logica general habria miles de if esta en este estado else if esta en este estado
//lo cual no seria idea

//En cambio mejor tener objetos que sepan como actuar, y le decis a la logica general que objeto (accion) debe ejecutar
//Las acciones saben cambiar el estado de la logica general, y pueden pasar ellas misma de un estado a otro

class Accion{
	
	//Accion que ejecuta la logica general
	method accion()
	//Accion que ejecuta la instancia de accion cuando se cambia a ella
	method esCambiadoA(){}
	//Metodo que usa una accion para cambiar a otra
	method cambiarAccionA(accion){
		logicaGeneral.accion(accion)
		accion.esCambiadoA()
	}
	
	method enfocado() = logicaGeneral.territorioEnfocado()
	method seleccionado() = logicaGeneral.territorioSeleccionado()
	method seleccionado(territorio){
		logicaGeneral.territorioSeleccionado(territorio)
	}
	method seleccionadoEsMarcado() = self.seleccionado() == self.enfocado()
	
	method mismoJugador()=(self.enfocado().jugador() == logicaGeneral.getJugador())
}


object seleccionar inherits Accion{
	override method accion(){
		if(self.mismoJugador()){
		//Si estoy en el territorio marcado desselecciono, si no selecciono
			if(self.seleccionadoEsMarcado()){
				self.seleccionado(null)
			}else{
				self.seleccionado(self.enfocado())
				self.cambiarAccionA(moverInfanteria)
			}
		}
	}
	
	//Cuando se establece esta accion, necesariamente no debe haber un territorio seleccionado
	override method esCambiadoA(){
		self.seleccionado(null)
	}
}


object moverInfanteria inherits Accion{
	
	override method accion(){
		
		if(self.seleccionado()==null)self.error("No hay territorio seleccionado")
		
		if(self.seleccionadoEsMarcado()){
			self.cambiarAccionA(seleccionar)
		}
		
		if(!self.mismoJugador() and self.seleccionado().puedeMover()){
			self.atacar()
		}
	}
	
	method atacar(){
		const atacante = self.seleccionado()
		const atacado = self.enfocado()
		
		if(atacante.puntuacion() > atacado.puntuacion()){
			atacado.asignarJugador(atacante.jugador())
			atacado.cantidadInfanteria(1)
			atacante.reducirInfanteria()
		}else{
			atacante.cantidadInfanteria(1)
		}
	}
}

//Accion de asignacion de territorio, se fija si el territorio no se encuentra ya asignado, y si no lo asigna
object asignarTerritorio inherits Accion{
	override method accion(){
		if(!self.enfocado().estaAsignado()){
			logicaGeneral.asignarTerritorioAJugador()
			logicaGeneral.siguienteJugador()
			if(logicaGeneral.todosTerritoriosAsignados()){
				self.cambiarAccionA(seleccionar)
			}
		}
	}
	override method esCambiadoA(){
		
	}
}

