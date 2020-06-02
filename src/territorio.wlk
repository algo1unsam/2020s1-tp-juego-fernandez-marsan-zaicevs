class Territorio{
	var property listaAdyacencia=[]
	var property position
	var property cantidadInfanteria
	var property jugador = null
	method image(){
		if(jugador == null){
			return "marcadoresJugadores/jugadorNull.png"
		}else{
			return "marcadoresJugadores/jugador"+jugador.id()+".png"
		}
	}
	
	//Devuelve true si se cumple la condicion para poder mover unidades (no puede haber 1 o menos unidades)
	method puedeMover() = cantidadInfanteria > 1
	
	//Devuelve true si el territorio (self o atacante) puede atacar al territorio recibido por parametro (atacado)
	//Las condiciones son: 
		//deben ser adyacentes
		//el territorio atacante y el territorio atacado deben pertenecer a jugadores diferentes
		//el territorio atadcante debe poder mover unidades (cantidad de unidades mayor a 1
	method puedoAtacar(_territorio) = self.esAdyacente(_territorio) and jugador != _territorio.jugador() and self.puedeMover()
	
	method reducirInfanteria()  {cantidadInfanteria--}
	method reducirInfanteria(num)  {cantidadInfanteria-= num}
	method aumentarInfanteria() {cantidadInfanteria++}
	method aumentarInfanteria(num) {cantidadInfanteria+=num}
	
	//Devuelve true si pertenece a algun jugador
	method estaAsignado() = !(jugador == null)
	//Asigna al jugador recibido por parametro
	method asignarJugador(_jugador){jugador = _jugador}
	//Calculo de la puntuacion del territorio, depende de la cantidad de infanteria y un valor aleatorio
	method puntuacion() = 0.randomUpTo(cantidadInfanteria*3).roundUp()
	//Devuelve true si el territorio recibido por parametro es adyacente
	method esAdyacente(_territorio) = listaAdyacencia.contains(_territorio)
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