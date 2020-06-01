import logicaGeneral.*
import acciones.accionesPrototipo.*
import acciones.accionesEnter.*

object seleccionar inherits Accion{
	override method accion(){
		if(self.mismoJugador()){
		//Si estoy en el territorio marcado desselecciono, si no selecciono
			if(self.seleccionadoEsMarcado()){
				self.seleccionado(null)
			}else{
				self.seleccionado(self.enfocado())
				self.cambiarAccionEspacio(atacar)
			}
		}
	}
	//Cuando se establece esta accion, necesariamente no debe haber un territorio seleccionado
	override method esCambiadoA(){
		self.seleccionado(null)
	}
}


object atacar inherits Accion{
	
	override method accion(){
		
		if(self.seleccionado()==null)self.error("No hay territorio seleccionado")
		
		if(logicaGeneral.puedeAtacar()){
			logicaGeneral.ataca()
			self.cambiarAccionEspacio(seleccionar)
		}
		
		if(self.seleccionadoEsMarcado()){
			self.cambiarAccionEspacio(seleccionar)
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
				self.cambiarAccionEspacio(seleccionar)
				self.cambiarAccionEnter(pasarTurnoAtaque)
			}
		}
	}
}

object agregarRefuerzos inherits Accion{
	override method accion(){
		if(self.perteneceAJugadorActivo()){
			logicaGeneral.agregarRefuerzo()
			self.comprobarRefuerzos()
		}
	}
	
	//Cuando entro a este modo, debo revisar si el jugador activo tiene refuerzos para asignar
	override method esCambiadoA(){
		self.comprobarRefuerzos()
	}
	
	//Comprueba si al jugador actual le quedan refuerzos, si no lo salteo
	method comprobarRefuerzos(){
		//Si el jugadorno tiene refuerzos para asignar
		if(!logicaGeneral.jugadorTieneRefuerzos()){
			//Paso al siguiente jugador
			logicaGeneral.siguienteJugador()
			//Si estoy en el primer jugador, quiere decir que ya pase por todos los jugadores
			if(logicaGeneral.esPrimerJugador()){
				//Entro al modo de seleccion y ataque
				self.cambiarAccionEnter(pasarTurnoAtaque)
			}else{
				//Si no estoy en el primer jugador, quiere decir que estoy en un jugador que hace falta comprobar
				//si tiene refuerzos para asignar, asi que vuelvo a hacer al comprobacion
				self.esCambiadoA()
			}	
		}
	}
}