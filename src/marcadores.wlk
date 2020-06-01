import logicaGeneral.*
import wollok.game.*

object marcadorFoco{
	method image() = "marcadoresSeleccion/foco" + logicaGeneral.getIndexJug() + ".png"
	
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
	method image() = "marcadoresSeleccion/seleccion" + logicaGeneral.getIndexJug() + ".png"
	
	method position(){
		const territorio = logicaGeneral.territorioSeleccionado()
		if(territorio != null){
			return territorio.position().down(1).left(1)
		}else{
			return game.at(-3,-3)
		}	
	}
}