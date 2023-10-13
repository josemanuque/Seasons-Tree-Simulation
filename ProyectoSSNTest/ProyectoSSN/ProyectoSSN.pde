import peasy.*;

PeasyCam cam;

ColonizerSystem colonizerSystem;
ArrayList<TreeNode> treeNodes;

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 0, 0, 0, 2000);
  treeNodes = new ArrayList<TreeNode>();
  colonizerSystem = new ColonizerSystem(treeNodes);
}


void draw() {
  blendMode(ADD);
  background(0);
  lights();
  colonizerSystem.display();
}
