import java.util.Iterator;

class ColonizerSystem {

  ArrayList<Colonizer> colonizers;
  ArrayList<TreeNode> treeNodes;

  ColonizerSystem(ArrayList<TreeNode> treeNodes) {
    this.colonizers = new ArrayList<Colonizer>();
    this.treeNodes = treeNodes;
    this.createBranchColonizers();
  }

  void createBranchColonizers() {
    float radius = min(width, height) / 2.0 * 0.8;

    for (int i = 0; i < 1000; i++) {
      float theta = random(0, TWO_PI);
      float phi = random(PI / 2, PI);  // Limita phi a la mitad inferior de la esfera
      float x = radius * sin(phi) * cos(theta) * random(0.7, 2.0);
      float y = radius * cos(phi) * random(0.7, 2.0) + 200;  // Cambiado sin(phi) por cos(phi)
      float z = radius * sin(phi) * sin(theta) * random(0.7, 2.0);
      
      //float theta = random(0, TWO_PI);
      //float phi = random(PI / 2, PI);  // Limita phi a la mitad inferior de la esfera
      //float x = radius * sin(phi) * cos(theta) * random(0.7, 2.0);
      //float y = radius * cos(phi) * random(-1, 1);  // Cambiado sin(phi) por cos(phi)
      //float z = radius * sin(phi) * sin(theta) * random(0.7, 2.0);

      Colonizer colonizer = new Colonizer(new PVector(x, y, z));
      colonizers.add(colonizer);
    }
    colonizers.size();
  }

  void display() {
    for (Colonizer c : colonizers) {
      c.display();
    }
  }

  // Applies an influence (difference vector) to the closest tree node for the next generation node
  void applyInfluence() {
    //println(colonizers.size());
    Iterator<Colonizer> iterator = colonizers.iterator();

    while (iterator.hasNext()) {
      Colonizer c = iterator.next();
      c.c = color(255);
      // Find the closest tree node for each colonizer and its distance
      float minDistance = Float.MAX_VALUE;
      TreeNode closestTreeNode = null;
      for (TreeNode t : treeNodes) {
        float distance = PVector.dist(t.pos, c.pos);
        if (distance < minDistance) {
          minDistance = distance;
          closestTreeNode = t;
        }
      }

      // If a tree node is close enough to the attractionDistance, apply influence
      if (closestTreeNode != null && minDistance <= c.attractionDistance) {
        PVector difference = PVector.sub(c.pos, closestTreeNode.pos);
        closestTreeNode.applyInfluence(difference);
        c.c = color(255, 0, 0);

        // If a tree node is close enough to the deleteDistance, remove the colonizer
        if (minDistance <= c.deleteDistance) {
          closestTreeNode.closestColonizers.remove(c);
          iterator.remove();
        }
      }
    }
  }

  // Checks if a any colonizer is close enough to a specific tree node
  boolean isCloseEnough(TreeNode t) {
    for (Colonizer c : colonizers) {
      float distance = PVector.dist(t.pos, c.pos);
      if (distance <= c.attractionDistance) {
        return true;
      }
    }
    return false;
  }

  /*   void applyInfluence(){
   for (TreeNode t : treeNodes) {
   t.applyInfluence();
   }
   } */

  /*   void deleteColonizers(){
   Iterator<Colonizer> iterator = colonizers.iterator();
   while (iterator.hasNext()) {
   Colonizer c = iterator.next();
   if (!c.isAlive) {
   iterator.remove();
   }
   }
   } */
}
