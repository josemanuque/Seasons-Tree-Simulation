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


}

void keyPressed() {
  if (keyPressed && key == 'i') {
    season.specialSeason(#FFFFFF, #FFFFFF);
  }
  if (keyPressed && key == 'p') {
    season.specialSeason(#8ace3d, #d5408e);
  }
  if (keyPressed && key == 'v') {
    season.specialSeason(#005c00, #005c00);
  }
  if (keyPressed && key == 'o') {
    season.specialSeason(#8B5737, #FFA500);
  }
}
