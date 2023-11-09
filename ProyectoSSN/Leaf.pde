class Leaf extends AgentSystem3D {
  ArrayList<Spring> springs;
  float mass = 2;
  float k = 0.1;
  float friction = 0.1;
  float drag = 0.01;
  color c;
  float size;
  TreeNode associatedNode;
  float angle;
  int numPoints = 8;
  int numFixedPoints = 4;
  PVector pos;

  Leaf(PVector pos, color leafColor, float leafSize) {
    super();
    springs = new ArrayList();
    this.pos = pos;
    this.c = leafColor;
    this.size = leafSize;
  }

  void createLeaf() {
    for (int i = 0; i < numPoints; i++) {
      float angle = map(i, 0, numPoints, 0, TWO_PI);
      float x = pos.x + cos(angle) * size;
      float y = pos.y + sin(angle) * (size * 0.5); // Ajustar la forma ovalada
      Agent3D a = new Agent3D(x, y, pos.z, mass, 0);
      agents.add(a);
    }

    // Conectar los puntos con resortes
    for (int i = 0; i < agents.size(); i++) {
      Agent3D a1 = agents.get(i);
      Agent3D a2 = agents.get((i + 1) % agents.size());
      springs.add(new Spring(a1, a2, a1.pos.dist(a2.pos), k));
    }

    //agents.get(5).fix();
    agents.get(6).fix();
    //agents.get(4).fix();
    //agents.get(5).fix();

    for (Agent3D a : agents) {
      a.randomVel(1);
    }
  }

  void display() {
    if (agents.get(0).pos.y < 420)
      for (Agent3D a : agents) {
        a.applyFriction(friction);
        a.applyDrag(drag);
        a.update();
      } else
      for (Agent3D a : agents) {
        a.resetForces();
      }


    for (Spring s : springs) {
      s.update();
    }

    fill(c);
    beginShape();
    for (int i = 0; i < agents.size(); i++) {
      Agent3D a = agents.get(i);
      vertex(a.pos.x, a.pos.y, a.pos.z);
    }
    endShape(CLOSE);
  }

  void clear() {
    agents.clear();
    springs.clear();
  }

  void applyForce(PVector force) {
    for (Agent3D a : agents) {
      a.applyForce(force);
    }
  }
  void applyGravity(PVector force) {
    for (Agent3D a : agents) {
      a.applyGravity(force);
    }
  }

  void setPos(PVector newPos) {
    pos = newPos.copy();
    for (int i = 0; i < agents.size(); i++) {
      float angle = map(i, 0, numPoints, 0, TWO_PI);
      float x = pos.x + cos(angle) * size;
      float y = pos.y + sin(angle) * (size * 0.5); // Ajustar la forma ovalada
      float z = pos.z;
      agents.get(i).pos.set(x, y, z);
    }

    //agents.get(5).fix();
    agents.get(6).fix();
    //agents.get(4).fix();
    //agents.get(5).fix();
  }

  boolean isAttached() {
    return associatedNode != null;
  }

  void detach() {
    associatedNode = null;
    for (Agent3D a : agents) {
      a.resetForces();
      a.unfix();
    }
  }
}
