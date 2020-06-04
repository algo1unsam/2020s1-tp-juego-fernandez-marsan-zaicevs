import logicaGeneral.*

class Jugador{
	const property id
	const property cpu
	var property refuerzos = 0
	//Refuerzos es la cantidad de unidades que se le van a dar a un jugador para asignar
	
	//Metodo para calcular refuerzos, cambiar dependiendo del balance del juego
	method calcularRefuerzos(){
		refuerzos = self.cantidadTerritorios()
	}
	
	//Devuelve la lista de terriotorios que perteneces al jugador
	method listaTerritorios() = logicaGeneral.listaTerritorios().filter({territorio =>territorio.jugador() == self})
	
	//Devuelve la cantidad de territorios que tiene el jugador
	method cantidadTerritorios() = self.listaTerritorios().size()
	
	method reducirRefuerzos(){refuerzos--}
	
	method tengoRefuerzos() = refuerzos > 0
	
	method perdio() = self.cantidadTerritorios() == 0
	
	method jugar(modo){ if(cpu) modo.computadora() }
	
	method puedoAtacar() = self.listaTerritorios().any({territorio => territorio.tengoParaAtacar()})
	method listaTerritoriosPuedenAtacar() = self.listaTerritorios().filter({territorio => territorio.tengoParaAtacar()})
}