// Coding Rainbow
// Daniel Shiffman
// http://patreon.com/codingtrain
// Code for: https://youtu.be/JcopTKXt8L8


class Leaf {
  PVector pos;
  boolean reached = false;

  Leaf() {
    float radius = min(width, height) / 2.0 * 0.8;  
    float theta = random(0, TWO_PI);
    float phi = random(PI / 2, PI);  // Limita phi a la mitad inferior de la esfera
    float x = radius * sin(phi) * cos(theta) * random(0.7, 2.0);
    float y = radius * cos(phi) * random(-1, 1);  // Cambiado sin(phi) por cos(phi)
    float z = radius * sin(phi) * sin(theta) * random(0.7, 2.0);
  
    pos = new PVector(x, y, z);
  }

  void reached() {
    reached = true;
  }

  void show() {
    fill(255);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    //sphere(4);
    ellipse(0,0, 4, 4);
    popMatrix();
  }
}
