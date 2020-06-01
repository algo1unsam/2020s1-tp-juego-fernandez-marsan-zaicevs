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
		
		if(self.seleccionadoEsMarcado()){
			self.cambiarAccionEspacio(seleccionar)
		}
		
		if(!self.mismoJugador() and self.seleccionado().puedeMover() and self.sonAdyacentes()){
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
		self.cambiarAccionEspacio(seleccionar)
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
				//Por alguna razon cambiarAccionEnter(accion) da error de tipo, preguntar luego
				//Temporalmente escribo directamente lo que hace
				//logicaGeneral.accionEnter(pasarTurnoAtaque)
				self.cambiarAccionEnter(pasarTurnoAtaque)
			}
		}
	}
}