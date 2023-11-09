class Agent3D {
  PVector pos;
  PVector vel;
  PVector acc;
  float r;
  color c;
  float mass;
  boolean fixed;

  Agent3D(float x, float y, float z, float mass, color agentColor) {
    pos = new PVector(x, y, z);
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
    c = agentColor;
    this.mass = mass;
    r = sqrt(mass / PI) * 2;
    fixed = false;
  }
  void update() {
    if (!fixed) {
      vel.add(acc);
      pos.add(vel);
      acc.mult(0);
    }
  }
  void display() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    noStroke();
    popMatrix();
  }
  void randomVel(float mag) {
    vel = PVector.random3D();
    vel.setMag(mag);
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
  void applyDrag(float c) {
    PVector drag = vel.copy();
    drag.normalize();
    drag.mult(vel.magSq());
    drag.mult(-c);
    applyForce(drag);
  }
  void fix() {
    fixed = true;
  }
  void unfix() {
    fixed = false;
  }

  void resetForces() {
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}
