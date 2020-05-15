import wollok.game.*

class Territorio{
	
	var property adya=[]
	var property position
	var property image="amarillo.png"
	
	method arriba(){		
		return adya.get(0)		
	}
	method abajo(){		
		return adya.get(2)		
	}
	method derecha(){		
		return adya.get(1)		
	}
	method izquierda(){		
		return adya.get(3)		
	}
}
object logicaGeneral{
	
	var territorioEnfocado
	var terri1
	var terri2
	var terri3
	
	method iniciar(){
	
	terri1=new Territorio(position=new Position(x = 5, y = 8))
	terri2=new Territorio(position=new Position(x = 5, y = 6))
	terri3=new Territorio(position=new Position(x = 5, y = 4))
	
	territorioEnfocado=terri2
	
	terri1.adya([null, null, terri2, null])
	terri2.adya([terri1, null, terri3, null])
	terri3.adya([terri2, null, null, null])
	
	
	
	game.addVisual(terri1)
	game.addVisual(terri2)
	game.addVisual(terri3)
	
		
	keyboard.up().onPressDo { self.moverSeleccion(0) }
	keyboard.down().onPressDo { self.moverSeleccion(2) }
	keyboard.left().onPressDo {self.moverSeleccion(3) }
	keyboard.right().onPressDo {  self.moverSeleccion(1)}
	
	}
	method moverSeleccion(numero){
		if (territorioEnfocado.adya().get(numero)!=null){
			territorioEnfocado=territorioEnfocado.adya().get(numero)
			game.say(territorioEnfocado, "Soy el foco")
		}
	}
	
	
	method irAbajo(){
		
		
	}
}