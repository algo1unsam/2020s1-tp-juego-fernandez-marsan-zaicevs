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
	
	method puedeMover() = cantidadInfanteria > 1
	method puedoAtacar(_territorio) = self.esAdyacente(_territorio) and jugador != _territorio.jugador() and self.puedeMover()
	method reducirInfanteria()  {cantidadInfanteria--}
	method reducirInfanteria(num)  {cantidadInfanteria-= num}
	method aumentarInfanteria() {cantidadInfanteria++}
	method aumentarInfanteria(num) {cantidadInfanteria+=num}
	method estaAsignado() = !(jugador == null)
	method asignarJugador(_jugador){
		jugador = _jugador
	}
	method puntuacion() = 0.randomUpTo(cantidadInfanteria*3).roundUp()
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