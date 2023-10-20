class Colonizer {
  
  PVector pos;
  float deleteDistance = 15;
  float attractionDistance = 120;
  color c = color(255);
  
  Colonizer(PVector pos) {
    this.pos = pos;
  }
  
  void display() {
    fill(c);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphereDetail(7);
    sphere(5);
    popMatrix();
  }
}
