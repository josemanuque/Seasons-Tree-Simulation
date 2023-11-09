//Simulación de estaciones del año
//Fabio Calderón, Juleisy Porras, José Manuel Quesada

import peasy.*;

PeasyCam cam;
Season season;
int transitionTime = 50000; //milliseconds
int transitionStart;
color bgColorStart;
color bgColorEnd;
//color backgroundColor = color(0);
int lastChange;
float windForce = 0;

void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D, 1);
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  season = new Season(100, 100);
  bgColorStart= color(0);  // Color inicial (rojo)
  bgColorEnd = color(0);  // Color destino (azul)
  transitionStart = millis();
}

void draw() {
  //background(backgroundColor);
  float progress = map(millis() - transitionStart, 0, transitionTime, 0, 1);
  int currentColor = lerpColor(bgColorStart, bgColorEnd, progress);
  background(currentColor);
  if (progress >= 1) {
    // Reinicia la transición
    transitionStart = millis();

    // Intercambia los colores inicial y destino para la próxima transición
    int temp = bgColorStart;
    bgColorStart = bgColorEnd;
    bgColorEnd = temp;
  }
  lights();
  directionalLight(255, 255, 255, -200, - 300, 0);
  ////ambientLight(100, 100, 100);
  ////directionalLight(255, 255, 255, 0, 0, -1);
  //stroke(255, 255, 255, 50);
  //strokeWeight(1);
  //noFill();
  //box(1000);
  /*   colonizerSystem.display();
   tree.display();
   tree.generateBranches();
   ground.display();
   
   if(keyPressed && keyCode == LEFT){
   tree.applyWindForce(new PVector(-0.1, random(-0.1, 0.1), random(-0.1, 0.1)));
   //println("Entered");
   }
   if(keyPressed && keyCode == RIGHT){
   tree.applyWindForce(new PVector(0.1, random(-0.1, 0.1), random(-0.1, 0.1)));
   } */

  season.initialSeason();
  keyPressed();
}

void keyPressed() {
  if (keyPressed && key == 'i') { // Winter
    windForce = 2;
    bgColorStart = color(#004764);
    bgColorEnd = color(#000000);
    season.specialSeason(#FFFFFF, #FFFFFF, 5, 0.3);
  }
  if (keyPressed && key == 'p') { // Spring
    windForce = 1;
    bgColorStart = color(#C7FFFA);
    bgColorEnd = color(#FFD5C2);
    //backgroundColor = color(#FFD5C2);
    season.specialSeason(#8ace3d, #d5408e, 5, 0.6);
  }
  if (keyPressed && key == 'v') { // Summer
    //backgroundColor = color(#FFEFB3);
    windForce = 0.7;
    bgColorStart = color(#01CBFE);
    bgColorEnd = color(#FFEFB3);
    season.specialSeason(#005c00, #005c00, 9, 0.6);
  }
  if (keyPressed && key == 'o') { // Autumn
    //backgroundColor = color(#C48A69);
    windForce = 1.5;
    bgColorStart = color(#0072A0);
    bgColorEnd = color(#C48A69);
    season.specialSeason(#8B5737, #FFA500, 5, 0.4);
  }
  if (keyPressed && keyCode == LEFT) {
    season.tree.applyWindForce(new PVector(-windForce, random(-0.1, 0.1), random(-0.1, 0.1)));
    //println("Entered");
  }
  if (keyPressed && keyCode == RIGHT) {
    season.tree.applyWindForce(new PVector(windForce, random(-0.1, 0.1), random(-0.1, 0.1)));
  }
}
