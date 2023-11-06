class Season {
  ColonizerSystem colonizerSystem;
  Tree tree;
  Ground ground;

  Season() {
    tree = new Tree();
    ground = new Ground(#005c00);
    colonizerSystem = tree.branchColonizers;
  }

  void initialSeason() {
    ground.display();
    colonizerSystem.display();
    tree.display();
    tree.generateBranches();
  }

  void winter() {
    ground.changeColor(#FFFFFF);
  }

  void spring() {
    ground.changeColor(#8ace3d);
  }

  void summer() {
    ground.changeColor(#005c00);
  }

  void autumn() {
    ground.changeColor(#8B5737);
  }
}
