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
    this.c = color(255);
  }


  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  void display() {
    fill(c);
    noStroke();
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    ellipse(0, 0, size * 2, size * 5);
    popMatrix();
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acc.add(f);
  }

  void applyGravity(PVector force) {
    acc.add(force);
  }

  void applyFriction(float c) {
    PVector fric = vel.copy();
    fric.normalize();
    fric.mult(-c);
    applyForce(fric);
  }
}
