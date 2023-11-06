class Leaf {
  PVector pos;
  PVector orientation;
  PVector vel;
  PVector acc;
  color c;
  float size;
  float mass;

  Leaf(float x, float y, float z, color leafColor) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    c = leafColor;
    mass = random(10, 30);
    size = random(3, 10);
  }
  
  Leaf(PVector pos, PVector orientation, float size) {
    this.pos = pos;
    this.orientation = orientation;
    this.size = size;
    this.c = color(97, 138, 61);
  }

void display() {
    //fill(c);
    //noStroke();
    //pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    //ellipse(0, 0, size * 2, size * 5);
    //popMatrix();
    fill(c);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphereDetail(1);
    sphere(5);
    popMatrix();
  }
}
