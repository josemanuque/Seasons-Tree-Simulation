class Season {
  ColonizerSystem colonizerSystem;
  Tree tree;
  Ground ground;
  AgentSystem3D sys = new AgentSystem3D();
  PVector gravity = new PVector(0, 0.1);

  Season(int cols, int rows) {
    tree = new Tree();
    ground = new Ground(cols, rows,#005c00);
    colonizerSystem = tree.branchColonizers;
  }

  void initialSeason() {
    ground.generateTerrain(0.5, 60); // Adjust the scale and maxHeight as needed
    ground.display();
    ground.displayBox();
    colonizerSystem.display();
    tree.display();
    tree.generateBranches();
    tree.displayLeaves();
  }

  void specialSeason(color groundColor, color leafColor, float leafSize, float leavesQuantity) {
    if (groundColor == #FFFFFF){
      ground.changeBox(false);
    } else {
      ground.changeBox(true);
    }
    tree.deleteLeaves();
    ground.changeColor(groundColor);
    ground.display();
    tree.generateLeaves(leafColor, leafSize, leavesQuantity);
  }
}
