import wollok.game.*
import tableros.*
import territorio.*
import marcadores.*
import acciones.accionesEnter.*
import acciones.accionesEspacio.*
import acciones.accionesPrototipo.*
import jugador.*

object logicaGeneral{
	
	var property territorioEnfocado = null
	var property territorioSeleccionado = null
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var property listaTerritorios = []
	//indiceJugador guarda el indice del jugador activo (0 = rojo, 1 = verde, 2 = azul)
	var property indiceJugador = 0
	var property listaJugadores = []
	//Acciones
	var property accionEspacio = noHacerNada
	var property accionEnter = noHacerNada
	var property jugadorActivo = null

	method iniciar(){
	
		listaJugadores = instanciadorTablero.generarJugadores(3)
		listaTerritorios = instanciadorTablero.instanciar(tableroEjemplo.listaConexiones())
		territorioEnfocado = listaTerritorios.first()
		
		self.crearVisualMarcadores()
		self.iniciarControles()
		
		accionEspacio = asignarTerritorio
		
	}
	method moverSeleccion(numero){
		if (territorioEnfocado.listaAdyacencia().get(numero)!=null){
			territorioEnfocado=territorioEnfocado.listaAdyacencia().get(numero)
		}
	}
	
	//Devuelve true cuando no queda ningun territorio sin asignar
	method todosTerritoriosAsignados() = listaTerritorios.all({territorio => territorio.estaAsignado()})
	
	//Asigna el territorio al jugador activo
	method asignarTerritorioAJugador(){
		territorioEnfocado.asignarJugador(self.getJugador())
		territorioEnfocado.aumentarInfanteria(1)
	}
	
	//El territorio seleccionado y el territorio enfocado pertenecen al mismo jugador
	method mismoJugador() = territorioEnfocado.jugador() == territorioSeleccionado.jugador()
	
	//El territorio seleccionado puede atacar al territorio enfocado?
	method puedeAtacar() = territorioSeleccionado.puedoAtacar(territorioEnfocado)
	
	//El territorio seleccionado ataca al territorio enfocado
	method ataca(){
		//no son necesarias las constantes, pero las creo para que sea mas facil la lectura
		const atacante = territorioSeleccionado
		const atacado = territorioEnfocado
		
		if(atacante.puntuacion() > atacado.puntuacion()){
			//Gano el atacante
			atacado.asignarJugador(atacante.jugador())
			atacado.cantidadInfanteria(1)
			atacante.reducirInfanteria()
		}else{
			//Gano el defensor
			atacante.cantidadInfanteria(1)
		}
	}
	
	//Devuelve true cuando esta seleccionado el ultimo jugador (en este caso el jugador 2 o azul)
	//Ver porque listaJugadores devuelve 1 jugador mas de lo que deberia
	method esUltimoJugador() = indiceJugador == listaJugadores.size() - 2
	//Devieñve true cuando esta seleciconado el primer jugador (en este caso el jugador 0 o rojo)
	method esPrimerJugador() = indiceJugador == 0
	
	//Avanza al siguiente jugador, si se encuentra en el ultimo vuelve al primero
	method siguienteJugador(){
		indiceJugador++
		if(indiceJugador >= listaJugadores.size() - 1){
			indiceJugador = 0
		}
	}
	
	//Devuelve la cantidad de jugadores que hay que no hayan perdido
	method jugadoresRestantes() = listaJugadores.filter({jugador => !jugador.perdio()}).size()
	
	//Devuelve una referencia al jugador activo
	method getJugador() = listaJugadores.get(indiceJugador)
	
	//Calcula los refuerzos que le corresponde a todos los jugadores
	method calcularRefuerzos(){
		listaJugadores.forEach({jugador =>
			jugador.calcularRefuerzos()
		})
	}
	
	//Devuelve si el jugador activo tiene refuerzos por asignar
	method jugadorTieneRefuerzos() = self.getJugador().tengoRefuerzos()
	
	//Asigna refuerzos al territorio enfocado del jugador activo
	method agregarRefuerzo(){
		territorioEnfocado.aumentarInfanteria()
		self.getJugador().reducirRefuerzos()
	} 
	
	//Inicializa los controles, cualquier control que se agregue que sea referente al juego deberia ir aqui
	method iniciarControles(){
		keyboard.up().onPressDo { self.moverSeleccion(0) }
		keyboard.down().onPressDo { self.moverSeleccion(2) }
		keyboard.left().onPressDo { self.moverSeleccion(3) }
		keyboard.right().onPressDo {  self.moverSeleccion(1)}
		keyboard.space().onPressDo { accionEspacio.accion() }
		keyboard.enter().onPressDo { accionEnter.accion() }		
	}
	
	//Creo los visuales de todos los marcadores que se van a usar
	method crearVisualMarcadores(){
		game.addVisual(marcadorFoco)
		game.addVisual(marcadorSeleccion)
		game.addVisual(marcadorRefuerzos)
	}
}