class Spring {
  Agent3D a1;
  Agent3D a2;
  float restLen;
  float k;
  color c;
  
  Spring(Agent3D a1, Agent3D a2, float restLen, float k) {
    this.a1 = a1;
    this.a2 = a2;
    this.restLen = restLen;
    this.k = k;
    c = color(255);
  }
  void update() {
    PVector springForce = PVector.sub(a2.pos, a1.pos);
    float len = springForce.mag();
    float displacement = len - restLen;
    springForce.setMag(-k * displacement);
    springForce.div(2);
    a2.applyForce(springForce);
    springForce.mult(-1);
    a1.applyForce(springForce);
  }
  void display() {
    strokeWeight(7);
    stroke(c);
    line(a1.pos.x, a1.pos.y, a1.pos.z, a2.pos.x, a2.pos.y, a2.pos.z);
  }
}
