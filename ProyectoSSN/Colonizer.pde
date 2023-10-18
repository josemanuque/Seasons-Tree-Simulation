class Colonizer {
  
  PVector position;
  float deleteDistance = 5;
  float attractionDistance = 200;
  
  Colonizer(PVector position) {
    this.position = position;
  }
  
  void display() {
    fill(color(255));
    noStroke();
    pushMatrix();
    translate(position.x, position.y, position.z);
    sphereDetail(7);
    sphere(5);
    popMatrix();
  }
}
