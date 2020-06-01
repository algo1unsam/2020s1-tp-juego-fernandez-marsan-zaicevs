import logicaGeneral.*
import wollok.game.*

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

//Idem marcadorFoco
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