import logicaGeneral.*

class Jugador{
	const property id
	var property siguienteJugador = null
	var property refuerzos = 0
	//Refuerzos es la cantidad de unidades que se le van a dar a un jugador para asignar
	
	//Metodo para calcular refuerzos, cambiar dependiendo del balance del juego
	method calcularRefuerzos(){
		refuerzos = self.cantidadTerritorios()
	}
	
	//Devuelve la cantidad de territorios que tiene el jugador
	method cantidadTerritorios() = logicaGeneral.listaTerritorios().filter({territorio =>territorio.jugador() == self}).size()
	
	method reducirRefuerzos(){refuerzos--}
	
	method tengoRefuerzos() = refuerzos > 0
	
	method perdio() = self.cantidadTerritorios() == 0
}