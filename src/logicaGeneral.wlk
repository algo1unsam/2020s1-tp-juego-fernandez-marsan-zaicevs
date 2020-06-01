import wollok.game.*
import tableros.*
import territorio.*
import marcadores.*
import acciones.accionesEnter.*
import acciones.accionesEspacio.*
import acciones.accionesPrototipo.*

class Jugador{
	const property id
	var property refuerzos = 0
	
	method calcularRefuerzos(){
		const misTerritorios = logicaGeneral.listaTerritorios().filter({territorio =>
			territorio.jugador() == self
		}).size()
		
		refuerzos = misTerritorios
	}
	
	method reducirRefuerzos(){
		refuerzos--
	}
	
	method tengoRefuerzos() = refuerzos > 0
}

object logicaGeneral{
	
	var property territorioEnfocado = null
	var property territorioSeleccionado = null
	
	// En lugar de variables, se usara un listado para los territorios
	// de modo que a la logica principal no le importe cuantos territorios haya y los pueda manejar a todos.
	var property listaTerritorios = []
	var property indiceJugador = 0
	var property listaJugadores = []
	//Acciones
	var property accionEspacio = noHacerNada
	var property accionEnter = noHacerNada
	

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
	
	method esUltimoJugador() = indiceJugador == listaJugadores.size() - 2
	method esPrimerJugador() = indiceJugador == 0
	
	method siguienteJugador(){
		indiceJugador++
		if(indiceJugador >= listaJugadores.size() - 1){
			indiceJugador = 0
		}
	}
	
	method getJugador() = listaJugadores.get(indiceJugador)
	method getJugador(i) = listaJugadores.get(i)
	
	
	method calcularRefuerzos(){
		listaJugadores.forEach({jugador =>
			jugador.calcularRefuerzos()
		})
	}
	method jugadorTieneRefuerzos() = self.getJugador().tengoRefuerzos()
	method agregarRefuerzo(){
		territorioEnfocado.aumentarInfanteria()
		self.getJugador().reducirRefuerzos()
	} 
	
	method iniciarControles(){
		keyboard.up().onPressDo { self.moverSeleccion(0) }
		keyboard.down().onPressDo { self.moverSeleccion(2) }
		keyboard.left().onPressDo { self.moverSeleccion(3) }
		keyboard.right().onPressDo {  self.moverSeleccion(1)}
		keyboard.space().onPressDo { accionEspacio.accion() }
		keyboard.enter().onPressDo { accionEnter.accion() }		
	}
	
	method crearVisualMarcadores(){
		game.addVisual(marcadorFoco)
		game.addVisual(marcadorSeleccion)
		game.addVisual(marcadorRefuerzos)
	}
}