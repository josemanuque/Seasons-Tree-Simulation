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
  }

  void display() {
    strokeWeight(sw);
    stroke(114, 95, 75);

    line3D(pos.x, pos.y, pos.z, parent.pos.x, parent.pos.y, parent.pos.z, sw, c);

    //println("Pos: " + pos + "   Parent Pos: " + parent.pos);
  }
}
