import wollok.game.*
import cosas.*

object tableroEjemplo {
	
	// El fondo que se va a usar para este tablero
	const property fondo = "pepita.png"
	
	/*
	 Matriz de informaciond de territorio, es una lista compuesta por listas [[],[],[]], cada sublista es un terrotorio
	 dentro de cada sublista hay 6 valores:
		valor 0: posicion en x
		valor 1: posicion en y
		valor 2-5: conexion de arriba, derecha, abajo, izquieda  del territorio, 
	  si es null es que no tiene conexion, si tiene un numero, entonces quiere decir que tiene conexion al territorio indexado en ese numero
	
	  Ejemplo
		El territorio 2 [5, 6, 0, null, 2, null] esta en la posicion 1 (se accede con get(1)), 
	    se encuentra en la posicion x = 5, y = 6, y tiene arriba una conexion al territorio 0, y abajo una conexion al territorio 2
	*/
	
	const property listaConexiones = 
							[[1, 13, null,     3, 	   1,   null], //0
							 [2, 10,    0,	null,      2,	null], //1
							 [1, 3,     1,     5, 	null,  	null], //2
							 [10, 12, null,    6,   null,      0], //3  
							 [10,7,   null,    7,      5,   null], //4  
							 [11,3,      4,    8,   null,      2], //5
							 [14,12, null,     9,      7,      3], //6
							 [15,8,     6,    10,      8,      4], //7 
							 [15,3,     7,    11,   null,      5], //8 
							 [19,12, null,  null,     10,      6], //9 
							 [19,7,     9,  null,     11,      7], //10
							 [19,1,    10,  null,   null,      8]  //11 
							 
							 ]	
}

object instanciadorTablero {
	
	//Metodo que crea un territorio en base a su posicion, y  le agrego su visual
	method crearTerritorio(x, y){
		const territorio = new Territorio(position=new Position(x = x, y = y), cantidadInfanteria = 1)
		game.addVisual(territorio)
		//Creo tambien el visual del numero del territorio
		game.addVisual(new Numero(territorioReferencia = territorio))
		return territorio
	}
	
	method instanciar(listaConexiones){
		const listaTerritorios = []
		
		// Primero instancio todos los territorios, no puedo crear adyacencias si no estan instanciados
		// (porque necesito pasarl la referencia a los territorios, pero como muchos no estan creados, las referencias no existe y van a dar error)
		listaConexiones.forEach({territorio =>
			listaTerritorios.add(self.crearTerritorio(territorio.get(0), territorio.get(1)))
		})
		/*
		Ahora que tengo todos los territorios creados, puedo asignar
		Para esto debo poder indexar tanto la listaTerritorios (referencias a territorios ya creados), como la listaConexiones
		por esto uso un la funcion de wollok para crear lista numericas (x .. y) donde x es el numero inicial e y el numero final
		Esto crea una lista de numeros que van de x a y, por ejemplo: (0 .. 5) crea [0, 1, 2, 3, 4, 5]
		Si uso un forEach sobre esta lista puedo iterar la cantidad de veces como elementos tiene esta lista.
		*/
		(0 .. listaTerritorios.size() - 1).forEach({i => 
			//Variable temporal que corresponde a la lista de adyacencia que va a tener el territorio i
			const listaAdyacenciaTerritorio = []
			//Necesito recorrer los valores que represantan adyacencia en listaTerritorios (son de 2 a 5, asi que creo la lista correspondiente)
			(2 .. 5).forEach({j =>
				// Por cada valor de adyacencia, si es null no hago nada, si no esl null debo recuperar la referencia al territorio correcto
				var referenciaATerritorio = null
				// Obtengo el valor de adyacencia, si es distinto de null, tengo que buscar la referencia al territorio usando el valor de adyacencia para
				// indexar la lista de territorios ya creados (listaTerritorios). Obtengo el territorio de esa forma
				const adyacencia = listaConexiones.get(i).get(j)
				if(adyacencia != null){
					referenciaATerritorio = listaTerritorios.get(adyacencia)
				}
				//Agrego el valor de adyacencia a la lista de adyacencias
				//Como esta ordenado en la matriz de info, puedo hacer un add sabiendo que el orden va a ser correcto
				listaAdyacenciaTerritorio.add(referenciaATerritorio)
			})
			// Le agrego el listado de adyacencias que cree en el paso anterior al territorio correspondiente
			listaTerritorios.get(i).listaAdyacencia(listaAdyacenciaTerritorio)
			// Hago esto tantas veces como territorios haya
		})
		
		return listaTerritorios
	}
}