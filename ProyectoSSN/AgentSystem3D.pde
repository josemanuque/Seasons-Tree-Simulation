class AgentSystem3D {
  ArrayList<Agent3D> agents;

  AgentSystem3D() {
    agents = new ArrayList<Agent3D>();
  }
  
  void update() {
    for (Agent3D a : agents) {
      a.update();
      a.display();
    }
  }
  void addAgent(float x, float y, float z, float mass) {
    Agent3D a = new Agent3D(x, y, z, mass);
    a.randomVel(1);
    agents.add(a);
  }
  void applyForce(PVector force) {
    for (Agent3D a : agents) {
      a.applyForce(force);
    }
  }
  void applyGravity(PVector gravity) {
    for (Agent3D a : agents) {
      a.applyGravity(gravity);
    }
  }
  void attract(float x, float y, float rate) {
    for (Agent3D a : agents) {
      PVector dif = new PVector(x, y);
      dif.sub(a.pos);
      dif.setMag(rate);
      a.applyForce(dif);
    }
  }
  void repel(float x, float y, float rate) {
    attract(x, y, -rate);
  }
  void clear() {
    agents.clear();
  }
}
