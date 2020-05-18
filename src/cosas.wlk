import wollok.game.*
import tableros.*

class Territorio{
	
	// Reemplazado adya por listaAdyacencia para que sea mas descriptivo
	var property listaAdyacencia=[]
	var property position
	var property cantidadInfanteria
	var property image = ("marcadoresJugadores/jugador0.png")
	// Eliminados los metodos de arriba, abajo, izquierda y derecha ya que no se van a usar
	
}
object logicaGeneral{
	
	var territorioEnfocado
	var marcador
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var listaTerritorios = []
	
	method iniciar(){
	
		listaTerritorios = instanciadorTablero.instanciar(tableroEjemplo.listaConexiones())
		self.crearMarcadorFoco()

		keyboard.up().onPressDo { self.moverSeleccion(0) }
		keyboard.down().onPressDo { self.moverSeleccion(2) }
		keyboard.left().onPressDo {self.moverSeleccion(3) }
		keyboard.right().onPressDo {  self.moverSeleccion(1)}
		
	}
	method moverSeleccion(numero){
		if (territorioEnfocado.listaAdyacencia().get(numero)!=null){
			territorioEnfocado=territorioEnfocado.listaAdyacencia().get(numero)
			marcador.territorio(territorioEnfocado)
		}
	}	
	
	method crearMarcadorFoco(){
		//Al crear foco, se establece el primer territorio de la lista como enfocado.
		territorioEnfocado = listaTerritorios.first()
		marcador = new Marcador(territorio = territorioEnfocado)
		game.addVisual(marcador)
	}
}

class Marcador{
	
	var property territorio
	var property image = "marcadoresSeleccion/foco.png"
	
	method position(){
		return territorio.position().down(1).left(1)
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