import wollok.game.*
import tableros.*

class Territorio{
	
	// Reemplazado adya por listaAdyacencia para que sea mas descriptivo
	var property listaAdyacencia=[]
	var property position
	var property image = ("marcadoresJugadores/jugador0.png")
	// Eliminados los metodos de arriba, abajo, izquierda y derecha ya que no se van a usar
	
}
object logicaGeneral{
	
	var territorioEnfocado
	var marcador
	
	/*var terri1
	var terri2
	var terri3*/
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var listaTerritorios = []
	
	method iniciar(){
	
		listaTerritorios = instanciadorTablero.instanciar(tableroEjemplo.listaConexiones())
		self.crearMarcadorFoco()
	
		/*terri1=new Territorio(position=new Position(x = 5, y = 8))
		terri2=new Territorio(position=new Position(x = 5, y = 6))
		terri3=new Territorio(position=new Position(x = 5, y = 4))
		
		territorioEnfocado=terri2
		
		self.crearMarcadorFoco()
		
		terri1.listaAdyacencia([null, null, terri2, null])
		terri2.listaAdyacencia([terri1, null, terri3, null])
		terri3.listaAdyacencia([terri2, null, null, null])
		
		game.addVisual(terri1)
		game.addVisual(terri2)
		game.addVisual(terri3)*/
			
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