class TreeNode {
  
  PVector pos;
  ArrayList<Colonizer> closestColonizers;
  PVector influenceDirection;
  int colonizersCount;
  float sw = 0;
  TreeNode parent;
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
  
  void applyInfluence(PVector difference){
    colonizersCount++;
    
    if (colonizersCount > 1){
      PVector rand = PVector.random2D();
      rand.setMag(0.1);
      influenceDirection.add(rand);
    }
    influenceDirection.add(difference.normalize()).normalize();
  }
  

  void display() {
    strokeWeight(sw);
    stroke(114, 95, 75);
    line3D(pos.x, pos.y, pos.z, parent.pos.x, parent.pos.y, parent.pos.z, sw, c);
    
    //println("Pos: " + pos + "   Parent Pos: " + parent.pos); 
  }
}
