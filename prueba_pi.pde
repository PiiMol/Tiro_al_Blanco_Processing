//Tp 2: Tiro al blanco
//Paula Margeritch 
//Pilar D. Molnar
//Cátedra Bedoian


//Declaramos estados, velocidad del blanco, imágenes, entre otras cosas

float x = 55;
float y = 55;
float velocidadx = 3;
float velocidady = 3;
float radio = 70;

int directionx= -1;
int directiony= 1;
int ContadorClicks;

PImage img;
PImage img1;
PImage img3;
PImage img4;

int estado;
int puntos = 0;

boolean tiro;
boolean gameover;

//Set up
/*Establecemos el tamaño de la ventana y cargamos las imágenes
A su vez, personalizamos el cursor del mouse*/

void setup() {
  size(400, 400);
  estado = 0;
  //imagen subida
  img = loadImage("diana.jpg");
  img1 = loadImage("dardo.png");
  img3 = loadImage("ganar.jpg");
  img4 = loadImage("perder.jpg");
  cursor(img1, mouseX, mouseY);
}

// Draw
/* Establecemos los estados del minijuego a lo largo de su recorrido:
La pantalla de inicio, instrucciones, el juego, en caso de ganar, perder*/
void draw() {

  // establecemos el estado del juego
  if (estado == 0) {
  //estadio de presentacion del juego y quienes somos
    background(22, 181, 186);
    textSize(50);
    fill(250);
    textAlign(CENTER);
    text("Tiro al blanco", width/2, height/3);
    textSize(20);
    text("Presione la tecla S para empezar", width/2, height/2);
    text("Hecho por Pau & Pi", width/2, height/4*3);
    
    // presiona la tecla S para empezar
    if (keyPressed) {
      if (key =='s'|| key == 'S') {
        estado++;
      }
    }
 //Pasa a pantalla 2 que contiene instrucciones del minijuego
  } else if (estado == 1) {
    // Instrucciones del juego
    background(22, 181, 186);
    textSize(20);
    textAlign(CENTER);
    fill(250);
    text("Instrucciones", 200, height/3);
    textSize(15);
    text("El jugador deberá hacer click en el blanco para sumar puntos ", width/2, height/2.5);
    text("y lograr ganar. En caso de errar se le", width/2, height/2.25);
    text("restarán puntos hasta perder.", width/2, height/2);
    text("Desea comenzar?", width/2, height/1.5);
    text("C/c", width/2, height/1.4);
  }
  // A partir de presionar tecla 'c' cambia el estado de instrucciones al juego
  if (keyPressed) { 
    if (key =='c'|| key == 'C') {
      //presiona la C y pasa a jugar
      estado =2;
    }
  } else if (estado == 2) {

    tiro = false;
    image(img, 0, 0);
    text("PUNTOS: ",  width/7, height/1);
    text( puntos,  width/4, height/1);

    //pelota de juego
  ellipse(x, y, radio, radio);
    //multiplicamos la velocidad por la direccion para que se dibuje
    x += velocidadx * directionx;

    //para que la direccionalidad de la pelota establecemos datos en relación
    //a la pelota y al tamaño del lienzo
    if ((x > width - radio/2) || (x < radio/2)) {
      directionx = -directionx;
    }
    y += velocidady * directiony;
    if ((y > height - radio/2) || (y < radio/2)) {
      directiony = -directiony;
    }
  }
}
void mousePressed() {
  //Establecemos la colisión y la suma de puntos para lograr ganar
  if (estado == 2) {
    
   if (mouseX >= x - radio/2 && mouseX <= x + radio/2 && mouseY >= y - radio/2 && mouseY <= y + radio/2) {
      puntos++;
    }
 
    //o perder en caso de no clickear sobre el objetivo
    else {
      puntos--;
    }
  }
  //en caso que los puntos sean menor a 0, aparece pantalla de GAMEOVER
  if (puntos<0) {
    estado = 3;
    image(img4, 0, 0);
    textSize(60);
    textAlign(CENTER);
    text("PERDISTE", width/2, height/4.5);
    textSize(20);
    text("¿Desea volver al menú principal? N/n ", width/2, height/3.2);
  
  } 
   //en caso que los puntos sean 10, aparece pantalla de GANASTE
  else if (puntos==10) {
    estado = 4;
    image(img3, 0, 0);
    fill(0);
    textSize(60);
    textAlign(CENTER);
    text("¡¡GANASTE!!", width/2, height/4.5);
    textSize(20);
    text("¿Desea volver al menú principal? N/n ", width/2, height/1.1);
  }}
 void keyPressed() {
  if (estado == 3 || estado == 4) { // Verifica si el estado es de Game Over o Ganaste
    if (key == 'n' || key == 'N') { // Si se presiona la tecla 'N' o 'n'
      reiniciarJuego(); // Llama a la función reiniciarJuego()
    } 
  }
}
void reiniciarJuego() {
  // Reinicia las variables del juego
  estado = 0;
  puntos = 0;
  x = 55;
  y = 55;
  directionx = -1;
  directiony = -1;
  
}
