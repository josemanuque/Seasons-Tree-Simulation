class TreeNode {

  float mass = 4;
  float k = 0.1;
  float restLen = 5;
  float dampingFactor = 0.005; //0.05 con 1 de viento se ve bien // 0.005 para 0.1 de viento
  PVector pos;
  PVector vel;
  PVector acc;
  ArrayList<Colonizer> closestColonizers;
  PVector influenceDirection;
  int colonizersCount;
  float sw = 0;
  TreeNode parent;
  boolean isBranch = true;
  boolean isRoot = false;
  color c = color(114, 95, 75);


  TreeNode(PVector pos, TreeNode parent) {
    this.pos = pos;
    this.closestColonizers = new ArrayList<Colonizer>();
    this.influenceDirection = new PVector(0, 0, 0);
    this.parent = parent;
    this.vel = new PVector(0, 0, 0);
    this.acc = new PVector(0, 0, 0);
    this.restLen = 5;
  }

  TreeNode(PVector pos) {
    this.pos = pos;
    this.closestColonizers = new ArrayList<Colonizer>();
    this.influenceDirection = new PVector(0, 0, 0);
    this.vel = new PVector(0, 0, 0);
  }

  void addInfluence(Colonizer c) {
    closestColonizers.add(c);
  }

  void applyInfluence(PVector difference) {
    colonizersCount++;

    if (colonizersCount > 1) {
      PVector rand = PVector.random2D();
      rand.setMag(0.1);
      influenceDirection.add(rand);
    }
    influenceDirection.add(difference.normalize()).normalize();
  }

  void update() {
    PVector springForce = calculateSpringForce();
    PVector dampingForce = calculateDampingForce();
    vel.add(acc);
    vel.add(dampingForce);
    pos.add(vel);
    acc.mult(0);
    springForce.mult(-1);
    //parent.applyWindForce(springForce);
  }

  PVector calculateSpringForce() {
    PVector springForce = PVector.sub(this.pos, parent.pos);
    float len = springForce.mag();
    float displacement = len - restLen;
    springForce.setMag(-k * displacement);
    springForce.div(2);
    return springForce;
  }
  
  PVector calculateDampingForce() {
    // Calcula la fuerza de amortiguación proporcional a la velocidad
    PVector dampingForce = vel.copy().mult(-dampingFactor);
    return dampingForce;
  }

  void applyWindForce(PVector force) {
    if (!isRoot) {
      PVector f = force.copy();
      f.div(mass);
      acc.add(f);
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

  void display() {
    strokeWeight(sw);
    stroke(114, 95, 75);

    line3D(pos.x, pos.y, pos.z, parent.pos.x, parent.pos.y, parent.pos.z, sw, c);

  }
}
