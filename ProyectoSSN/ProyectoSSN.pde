import peasy.*;

PeasyCam cam;

ColonizerSystem colonizerSystem;
Tree tree;
ArrayList<TreeNode> treeNodes;

void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D, 1);
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  tree = new Tree();
  colonizerSystem = new ColonizerSystem(tree.treeNodes);
}


void draw() {
  blendMode(ADD);
  background(0);
  lights();
  stroke(255, 255, 255, 50);
  noFill();
  box(1000);
  colonizerSystem.display();
  tree.display();
  tree.addNode();
  colonizerSystem.addInfluence();
}
