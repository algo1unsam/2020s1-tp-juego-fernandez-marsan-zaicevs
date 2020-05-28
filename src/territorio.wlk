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
	method reducirInfanteria()  {cantidadInfanteria--}
	method reducirInfanteria(num)  {cantidadInfanteria-= num}
	method aumentarInfanteria() {cantidadInfanteria++}
	method aumentarInfanteria(num) {cantidadInfanteria+=num}
	method estaAsignado() = !(jugador == null)
	method asignarJugador(_jugador){
		jugador = _jugador
		_jugador.agregarTerritorio(self)
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