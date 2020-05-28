import wollok.game.*
import tableros.*
import territorio.*
import marcadores.*
import acciones.*

class Jugador{
	const property id
	const property territorios = []
	
	method agregarTerritorio(territorio){
		territorios.add(territorio)
	} 
}

object logicaGeneral{
	
	var property territorioEnfocado = null
	var property territorioSeleccionado = null
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var property listaTerritorios = []
	var indiceJugador = 0
	var property listaJugadores = []
	//Acciones
	var property accion
	

	method iniciar(){
	
		listaJugadores = instanciadorTablero.generarJugadores(3)
		listaTerritorios = instanciadorTablero.instanciar(tableroEjemplo.listaConexiones())
		territorioEnfocado = listaTerritorios.first()
		
		self.crearVisualMarcadores()
		self.iniciarControles()
		
		accion = asignarTerritorio
		
	}
	method moverSeleccion(numero){
		if (territorioEnfocado.listaAdyacencia().get(numero)!=null){
			territorioEnfocado=territorioEnfocado.listaAdyacencia().get(numero)
		}
	}
	
	method crearVisualMarcadores(){
		game.addVisual(marcadorFoco)
		game.addVisual(marcadorSeleccion)
	}
	
	method todosTerritoriosAsignados() = listaTerritorios.all({territorio => territorio.estaAsignado()})
	//Asigna el territorio al jugador activo
	method asignarTerritorioAJugador(){
		territorioEnfocado.asignarJugador(self.getJugador())
		territorioEnfocado.aumentarInfanteria(2)
	}
	
	method pasarTurno(){
		self.siguienteJugador()
		territorioSeleccionado = null
		accion = seleccionar
	}
	
	method siguienteJugador(){
		indiceJugador++
		if(indiceJugador >= listaJugadores.size() - 1){
			indiceJugador = 0
		}
	}
	
	method getJugador() = listaJugadores.get(indiceJugador)
	method getJugador(i) = listaJugadores.get(i)
	
	method iniciarControles(){
		keyboard.up().onPressDo { self.moverSeleccion(0) }
		keyboard.down().onPressDo { self.moverSeleccion(2) }
		keyboard.left().onPressDo { self.moverSeleccion(3) }
		keyboard.right().onPressDo {  self.moverSeleccion(1)}
		keyboard.space().onPressDo { accion.accion() }
		keyboard.enter().onPressDo { self.pasarTurno() }
		
	}
}