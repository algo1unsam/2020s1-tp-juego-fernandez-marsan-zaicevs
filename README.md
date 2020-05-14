# Estructura básica del juego Risk para Wollok Game.

Quedan detalladas las características que deben tener los objetos y clases para poder implementar una versión básica del juego:

La versión básica constaría de un tablero dividido en regiones, con un solo jugador. Y que el jugador pueda navegar y transferir tropas entre las regiones. El siguiente paso seria agregar n jugadores humanos.

No se va a crear ningun menu para esta versión, pero más adelante habría que analizar para poner uno.

Debería constar de un tablero compuesto por regiones, cada región tiene un número determinado de infantería, representado por marcadores visuales de región. 

![alt text](https://i.imgur.com/MQXQAVV.png "Ejemplo tablero")

La imagen de fondo, así como las adyacencias de cada región deben estar determinadas en un objeto Tablero.
Un objeto de lógica principal maneja los turnos de los jugadores humanos y permite a los mismos navegar el tablero con la ayuda de marcadores de selección, que dan feedback visual al jugador.

### Clase Jugador:
- Debe guardar los datos referentes al jugador, primeramente va a guardar las regiones que pertenecen a ese jugador. Se puede omitir esta clase, pero optaria para tenerla para realizar pasajes más limpios de información cuando agreguemos jugadores controlados por computadora. Tener esta clase implicaría tener cierta duplicación de datos.

### Objeto logicaPrincipal:
- La parte central del juego, va a manejar los turnos de los jugadores y las acciones que haga el/los jugadores humanos. Se debe definir si el ataque/defensa se resuelve en la lógica principal o en la lógica de región. 

- Al iniciarse el juego, este objeto debe establecer los controles del juego.

- Tendría un listado de jugadores a través de los cuales va ciclando, cuando está en un jugador determinado, ese jugador va a poder interactuar con sus regiones hasta terminar su turno.

- Cuando el turno es del jugador humano, el jugador debe poder recorrer las regiones con las flechas (usando las adyacencias de regiones), y seleccionar y realizar acciones con alguna tecla determinada. 

- Cada acción de navegación, selección, ataque o transferencia debe ser visualmente mostrada a través de marcadores de selección.

- La lógica principal guarda la referencia a regiones seleccionadas para distintas acciones.

- Sugiero no usar más de una tecla para realizar acciones (seleccionar con una tecla, y una vez que una región quede como seleccionada, atacar o mover sea con la misma tecla).

### Objeto tablero:
- Este objeto debe saber el fondo que se va a utilizar (las regiones van a dibujarse en un archivo de imagen, el único feedback de las mismas va a ser a través de los marcadores visuales).

- Debe conocer todas las regiones y cuales regiones son adyacentes entre sí. Al iniciar el juego se debe invocar este objeto para instanciar las regiones (con sus adyacencias), así como establecer el fondo.

- La razón de tener esta información en un objeto es en caso de querer tener más de un tablero, tener cada uno contenido en un objeto, y que todos sean polimórficos (se pueda instanciar el tablero que se desee).

### Clase Region:
- Una instancia de región debe tener una lista de las regiones adyacentes, así como también una lista de la infantería que se encuentra en la misma. Cada región va a recibir las adyacencias que tiene, no hace falta que las calcule.

- Cada región debe conocer la posición de donde se va a realizar su representación visual (que va a ser en el centro de la región dibujada en el archivo de imagen).

- Sugiero para simplificar el código y el juego que cada región pueda tener solamente 4 regiones adyacentes que se corresponden a las direcciones que se van a usar para navegar las mismas (arriba, abajo, izquierda derecha). Debe poder recibir una lista de regiones adyacentes y identifique qué región se encuentre en qué dirección.

- Cada región debe poder decir qué región tiene un una determinada dirección (ej region.arriba() debería devolver una referencia a la región que tiene arriba, y si no tiene una región arriba debería devolver un null).

- Debe poder recibir y restar infanterías (la infantería es una instancia de la clase infantería).

- Debe tener una indicación visual de la infantería ubicada en la región, la misma puede ser el visual de cada instancia, o se puede desacoplar a una clase aparte. En caso de desacoplarse se implementa con la clase marcadorRegion.

- Debe poder, dada la referencia a una región, transferir una de sus infanterías a la región que recibió siempre y cuando sean adyacentes y no quede menos de 1 infantería.

### Clase Infanteria:
- Actualmente no es necesario que esta clase tenga ningun metodo o propiedad, y probablemente se pueda implementar completamente dentro de región, pero sugiero definirlo como una clase propia en caso de que más adelante se propone expandir el juego (añadiendo otros tipos de unidades).

### Clase marcadorRegion:
- Debe poder recibir una referencia a una región y hacer la representación visual de la misma, indicando a qué jugador pertenece, y cuanta infantería hay en la misma.

- Sugiero implementar de tal forma que internamente tenga otra clase, de modo que por cada marcador se pueda dibujar 2 objetos visuales en la misma celda (uno para el color que represente el jugador y otro para el número que represente la cantidad de infanteria).

### Clase marcadorSeleccion:
- Clase que va a usar la lógica principal para dar feedback visual al jugador. Debe poder recibir una referencia a una región, un estado de selección, y poder mostrar un visual que represente el estado de selección que se le pasó. Por ejemplo: 

![alt text](https://i.imgur.com/jiSqL8O.png "Marcadores de seleccion")
	

