//Simulación de estaciones climáticas
//Fabio Calderón, Juleisy Porras, José Manuel Quesada

import peasy.*;
import controlP5.*;

PeasyCam cam;
ControlP5 cp5;

ColonizerSystem colonizerSystem;
Tree tree;
ArrayList<TreeNode> treeNodes;
Ground ground;

void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D, 1);
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  tree = new Tree();
  colonizerSystem = tree.branchColonizers;
  ground = new Ground(#005c00);
  initControls();
}

void line3D(float x1, float y1, float z1, float x2, float y2, float z2, float weight, color strokeColour) {
  // was called drawLine; programmed by James Carruthers
  // see http://processing.org/discourse/yabb2/YaBB.pl?num=1262458611/0#9

  PVector p1 = new PVector(x1, y1, z1);
  PVector p2 = new PVector(x2, y2, z2);
  PVector v1 = new PVector(x2-x1, y2-y1, z2-z1);
  float rho = sqrt(pow(v1.x, 2)+pow(v1.y, 2)+pow(v1.z, 2));
  float phi = acos(v1.z/rho);
  float the = atan2(v1.y, v1.x);

  v1.mult(0.5);

  pushMatrix();
  translate(x1, y1, z1);
  translate(v1.x, v1.y, v1.z);
  rotateZ(the);
  rotateY(phi);
  noStroke();
  fill(strokeColour);
  box(weight, weight, p1.dist(p2)*1.2);
  popMatrix();
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
  colonizerSystem.display();
  tree.display();
  tree.generateBranches();
  ground.display();
}
