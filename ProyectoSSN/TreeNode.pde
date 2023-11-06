class TreeNode {

  PVector pos;
  ArrayList<Colonizer> closestColonizers;
  PVector influenceDirection;
  int colonizersCount;
  float sw = 0;
  TreeNode parent;
  boolean isBranch = true;
  color c = color(114, 95, 75);


  TreeNode(PVector pos, TreeNode parent) {
    this.pos = pos;
    this.closestColonizers = new ArrayList<Colonizer>();
    this.influenceDirection = new PVector(0, 0, 0);
    this.parent = parent;
  }

  TreeNode(PVector pos) {
    this.pos = pos;
    this.closestColonizers = new ArrayList<Colonizer>();
    this.influenceDirection = new PVector(0, 0, 0);
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
