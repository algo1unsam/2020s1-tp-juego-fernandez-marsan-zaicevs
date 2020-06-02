import logicaGeneral.*
import acciones.accionesPrototipo.*
import acciones.accionesEnter.*

//Aca van todas las acciones de espacio

//Accion que de seleccion, una vez selecciando un territorio, pasa a atacar
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

//Accion de ataque, le pregunta a la logica general si se cumplen las condiciones para atacar, y si se cumplen ataca
//Desselecciona el terriorio si el territorio enfocado es el mismo que el territorio seleccionado
//Si no ataca y no desselecciona, no hace nada.
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
//Esta accion solo se utiliza al inicio del juego cuando hay territorios sin asignar
//Despues pasa a modo de refuerzos para que cada jugador pueda distribuir sus unidades
object asignarTerritorio inherits Accion{
	override method accion(){
		if(!self.enfocado().estaAsignado()){
			logicaGeneral.asignarTerritorioAJugador()
			logicaGeneral.siguienteJugador()
			if(logicaGeneral.todosTerritoriosAsignados()){
				self.cambiarAccionEnter(pasarTurnoRefuerzos)
			}
		}
	}
}

//Accion de agregar refuerzos, cuando entra en esta accion comprueba si el jugador activo tiene refuerzos para asignar
//Si no tiene saltea al jugador
//Realiza la comprobacion de refuerzos por cada refuerzo que se asigna, si a un jugador se le acabaron, lo saltea
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
		//Si el jugador no tiene refuerzos para asignar
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