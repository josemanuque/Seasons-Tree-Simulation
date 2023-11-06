//Simulación de estaciones del año
//Fabio Calderón, Juleisy Porras, José Manuel Quesada

import peasy.*;

PeasyCam cam;
Season season;

void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D, 1);
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  season = new Season();
}

void draw() {
  background(0);
  lights();
  //ambientLight(100, 100, 100);
  //directionalLight(255, 255, 255, 0, 0, -1);
  stroke(255, 255, 255, 50);
  strokeWeight(1);
  noFill();
  box(1000);
  season.initialSeason();
  
  keyPressed();
}

void keyPressed() {
  if (key == 'i') {
    println("Hola soy invierno");
    season.winter();
  }
  if (key == 'p') {
    println("Hola soy primavera");
    season.spring();
  }
  if (key == 'o') {
    println("Hola soy otoño");
    season.autumn();
  }
  if (key == 'v') {
    println("Hola soy verano");
    season.summer();
  }
}
