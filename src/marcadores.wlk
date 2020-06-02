import logicaGeneral.*
import wollok.game.*
//Marcadores que dan feedback al usuario de que zona esta enfocada, seleccionada y refuerzos
//Cada marcador es independiente de la logicaGeneral para su posicionamiento
//Toman todos los valores automaticamente de la logica general

//Marcador que se encarga de mostrar que territorio esta enfocado
object marcadorFoco{
	method image() = "marcadoresSeleccion/foco" + logicaGeneral.indiceJugador() + ".png"
	
	method position(){
		const territorio = logicaGeneral.territorioEnfocado()
		
		if(territorio != null){
			return territorio.position().down(1).left(1)
		}else{
			return game.at(-3,-3)
		}	
	}
}

//Idem marcadorFoco
object marcadorSeleccion{
	method image() = "marcadoresSeleccion/seleccion" + logicaGeneral.indiceJugador() + ".png"
	
	method position(){
		const territorio = logicaGeneral.territorioSeleccionado()
		if(territorio != null){
			return territorio.position().down(1).left(1)
		}else{
			return game.at(-3,-3)
		}	
	}
}

//Solo es visible durante el modo de agregar refuerzos ya que es el unico momento en que 
//un jugador tiene refuerzos > 0
object marcadorRefuerzos{
	method image(){
		if(logicaGeneral.getJugador().refuerzos() < 10)
			return "marcadorRefuerzos/" + logicaGeneral.getJugador().refuerzos() +".png"
		else
			return "marcadorRefuerzos/9+.png"
	} 
	
	method position(){
		const territorio = logicaGeneral.territorioEnfocado()
		if(territorio != null){
			return territorio.position().down(1).left(1)
		}else{
			return game.at(-3,-3)
		}	
	}
}