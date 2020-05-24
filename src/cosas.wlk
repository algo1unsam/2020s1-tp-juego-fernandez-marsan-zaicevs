import wollok.game.*
import tableros.*

class Territorio{
	
	// Reemplazado adya por listaAdyacencia para que sea mas descriptivo
	var property listaAdyacencia=[]
	var property position
	var property cantidadInfanteria
	var property image = ("marcadoresJugadores/jugador0.png")
	
	method puedeMover() = cantidadInfanteria > 1
	method reducirInfanteria()  {cantidadInfanteria--}
	method aumentarInfanteria() {cantidadInfanteria++}
	// Eliminados los metodos de arriba, abajo, izquierda y derecha ya que no se van a usar
	
}
object logicaGeneral{
	
	var property territorioEnfocado = null
	var property territorioSeleccionado = null
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var property listaTerritorios = []
	
	method iniciar(){
	
		listaTerritorios = instanciadorTablero.instanciar(tableroEjemplo.listaConexiones())
		territorioEnfocado = listaTerritorios.first()
		
		self.crearVisualMarcadores()

		keyboard.up().onPressDo { self.moverSeleccion(0) }
		keyboard.down().onPressDo { self.moverSeleccion(2) }
		keyboard.left().onPressDo {self.moverSeleccion(3) }
		keyboard.right().onPressDo {  self.moverSeleccion(1)}
		keyboard.space().onPressDo {self.accionEspacio() }
		
	}
	method moverSeleccion(numero){
		if (territorioEnfocado.listaAdyacencia().get(numero)!=null){
			territorioEnfocado=territorioEnfocado.listaAdyacencia().get(numero)
		}
	}
	
	method seleccionar(){
		if(territorioEnfocado == territorioSeleccionado){
			territorioSeleccionado = null
		}else{
			territorioSeleccionado = territorioEnfocado
		}
	}
	
	method moverInfanteria(){
		if(territorioSeleccionado.puedeMover()){
			territorioEnfocado.aumentarInfanteria()
			territorioSeleccionado.reducirInfanteria()
		}else{
			territorioSeleccionado = null
		}
	}	
	
	method accionEspacio(){
		if(territorioSeleccionado != null and territorioSeleccionado != territorioEnfocado){
			self.moverInfanteria()
		}else{
			self.seleccionar()			
		}
	}
	
	method crearVisualMarcadores(){
		game.addVisual(marcadorFoco)
		game.addVisual(marcadorSeleccion)
	}
}


//Cambiado a objeto ya que no tiene sentido que sea una clase porque hay uno solo
//El objeto se va a preocupar por su propia posicion, va a sabar directamente la referencia
//al territorio enfocado de la logica general y va a posicionarse en el tablero apropiadamente
object marcadorFoco{
	var property image = "marcadoresSeleccion/foco.png"
	
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
	var property image = "marcadoresSeleccion/seleccion.png"
	
	method position(){
		const territorio = logicaGeneral.territorioSeleccionado()
		if(territorio != null){
			return territorio.position().down(1).left(1)
		}else{
			return game.at(-3,-3)
		}	
	}
}

class Numero{
	var property territorioReferencia
	
	method position() = territorioReferencia.position()
	
	method image(){
		if(territorioReferencia.cantidadInfanteria() < 10)
			return "numeros/" + territorioReferencia.cantidadInfanteria() +".png"
		else
			return "numeros/9+.png"
	} 
}