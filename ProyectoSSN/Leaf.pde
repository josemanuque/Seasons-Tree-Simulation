class Leaf extends AgentSystem3D {
  ArrayList<Spring> springs;
  float mass = 2;
  float k = 0.1;
  float friction = 0.1;
  float drag = 0.005;
  PVector orientation;
  color c;
  float size;
  float mass;
  TreeNode associatedNode;
  float angle;
  float mouseDist = 5;
  int numPoints = 7;
  int numFixedPoints = 4;
  PVector pos;

  Leaf(PVector pos, PVector orientation, color leafColor) {
    super();
    springs = new ArrayList();
    this.pos = pos;
    this.orientation = orientation;
    this.c = leafColor;
  }

  void createLeaf() {
    for (int i = 0; i < numPoints; i++) {
      float angle = map(i, 0, numPoints, 0, TWO_PI);
      float x = pos.x + cos(angle) * mouseDist;
      float y = pos.y + sin(angle) * (mouseDist * 0.5); // Ajustar la forma ovalada
      Agent3D a = new Agent3D(x, y, pos.z, mass);
      agents.add(a);
    }

    // Conectar los puntos con resortes
    for (int i = 0; i < agents.size(); i++) {
      Agent3D a1 = agents.get(i);
      Agent3D a2 = agents.get((i + 1) % agents.size());
      springs.add(new Spring(a1, a2, a1.pos.dist(a2.pos), k));
    }

    agents.get(2).fix();
    agents.get(3).fix();
    agents.get(4).fix();
    agents.get(5).fix();

    for (Agent3D a : agents) {
      a.randomVel(1);
    }
  }

  void display() {
    for (Agent3D a : agents) {
      a.applyFriction(friction);
      a.applyDrag(drag);
      a.update();
      //a.display();
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
}
