import java.util.Iterator;

class ColonizerSystem {
  
  ArrayList<Colonizer> colonizers;
  ArrayList<TreeNode> treeNodes;
  
  ColonizerSystem(ArrayList<TreeNode> treeNodes) {
    this.colonizers = new ArrayList<Colonizer>();
    this.treeNodes = treeNodes;
    this.addColonizers();
  }
  
  void addColonizers(){
    float radius = min(width, height) / 2.0 * 0.8;  
    
    for (int i = 0; i < 1000; i++) {
      float theta = random(0, TWO_PI);
      float phi = random(PI / 2, PI);  // Limita phi a la mitad inferior de la esfera
      float x = radius * sin(phi) * cos(theta) * random(0.7, 2.0);
      float y = radius * cos(phi) * random(0.7, 2.0) + 200;  // Cambiado sin(phi) por cos(phi)
      float z = radius * sin(phi) * sin(theta) * random(0.7, 2.0);
      
      Colonizer colonizer = new Colonizer(new PVector(x, y, z));
      colonizers.add(colonizer);
    }
  }
  
  void display(){
    for (Colonizer c : colonizers) {
      c.display();
    }
  }
  
  void addInfluence(){
    Iterator<Colonizer> iterator = colonizers.iterator();
    while (iterator.hasNext()) {
      Colonizer c = iterator.next();
      float minDistance = Float.MAX_VALUE;
      TreeNode closestTreeNode = null;
      for (TreeNode t : treeNodes) {
        float distance = PVector.dist(t.position, c.position);
        if (distance < minDistance) {
          minDistance = distance;
          closestTreeNode = t;
        }
      }
      if (closestTreeNode != null && minDistance <= c.attractionDistance) { 
        closestTreeNode.addInfluence(c);
        closestTreeNode.applyInfluence();
        if (minDistance <= c.deleteDistance){
          closestTreeNode.closestColonizers.remove(c);
          iterator.remove();
        }
      }
    }
  }
  
  void applyInfluence(){
    for (TreeNode t : treeNodes) {
      t.applyInfluence();
    }
  }
}
