class Season {
  ColonizerSystem colonizerSystem;
  Tree tree;
  Ground ground;
  color groundColor = color(#005c00);
  AgentSystem3D sys = new AgentSystem3D();
  PVector gravity = new PVector(0, 0.1);

  Season() {
    tree = new Tree();
    ground = new Ground(groundColor);
    colonizerSystem = tree.branchColonizers;
  }

  void initialSeason() {
    ground.display(groundColor);
    colonizerSystem.display();
    tree.display();
    tree.generateBranches();
    tree.displayLeaves();
  }

  void specialSeason(color groundColor, color leafColor, float leafSize, float leavesQuantity) {
    tree.deleteLeaves();
    this.groundColor = groundColor;
    ground.display(groundColor);
    tree.generateLeaves(leafColor, leafSize, leavesQuantity);
  }
}
