import logicaGeneral.*
import modos.*

//Accion padre, el metodo accion debe impementarse si o si
//Cada accion tiene un metodo accion que se ejecuta cuando se apreta la tecla correspondiente (espacio o enter)
//La logica general guarda la accion correspondiente para la tecla correspondiente
//Cada accion puede tener un metodo esCambiadoA que se ejecuta cuando se asigna esa accion a una tecla

class Accion{
	
	//Accion que ejecuta la logica general
	method accion()
	//Accion que ejecuta la instancia de accion cuando se cambia a ella
	
	//Metodos para facilitar y acortar
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

object seleccionar inherits Accion{
	override method accion(){
		if(self.mismoJugador()){
		//Si estoy en el territorio marcado desselecciono, si no selecciono
			if(self.seleccionadoEsMarcado()){
				self.seleccionado(null)
			}else{
				self.seleccionado(self.enfocado())
				ataque.accion(atacar)
			}
		}
	}
}

object atacar inherits Accion{
	
	override method accion(){	
		if(self.seleccionado()==null)self.error("No hay territorio seleccionado")
		
		if(logicaGeneral.puedeAtacar()){
			logicaGeneral.ataca()
			self.seleccionado(null)
			ataque.accion(seleccionar)
		}
		
		if(self.seleccionadoEsMarcado()){
			ataque.accion(seleccionar)
		}
	}
}