class TreeNode {
  
  PVector position;
  ArrayList<Colonizer> closestColonizers;
  PVector direction = null;
  
  
  TreeNode(PVector position) {
    this.position = position;
    this.closestColonizers = new ArrayList<Colonizer>();
  }
  
  void addInfluence(Colonizer c) {
    closestColonizers.add(c);
  }
  
  void applyInfluence() {
    int closestColonizersSize = closestColonizers.size();
    //if (closestColonizersSize == 1) {
    //  Colonizer c = closestColonizers.get(0);
    //  PVector distance = PVector.sub(this.position, c.position);
    //  this.direction = distance.normalize();
    //  return;
    //}
    this.direction = new PVector(0, 0, 0);  
    for (int i = 0; i < closestColonizersSize; i++) {
      Colonizer c = closestColonizers.get(i);
      PVector distance = PVector.sub(this.position, c.position);
      direction.add(distance.normalize());
    }
    direction.normalize();
  }
}
