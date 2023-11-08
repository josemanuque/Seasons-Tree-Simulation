class Season {
  ColonizerSystem colonizerSystem;
  Tree tree;
  Ground ground;
  color groundColor = color(#005c00);

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

  void specialSeason(color groundColor, color leafColor) {
    this.groundColor = groundColor;
    ground.display(groundColor);
    tree.generateLeaves(leafColor);
    //tree.displayLeaves();
  }

  //void winter() {
  //  ground.changeColor(#FFFFFF);
  //  tree.generateLeaves(#FFFFFF);
  //  tree.displayLeaves();
  //}

  //void spring() {
  //  ground.changeColor(#8ace3d);
  //  tree.generateLeaves(#8ace3d);
  //  tree.displayLeaves();
  //}

  //void summer() {
  //  ground.changeColor(#005c00);
  //  tree.generateLeaves(#005c00);
  //  tree.displayLeaves();
  //}

  //void autumn() {
  //  ground.changeColor(#8B5737);
  //  tree.generateLeaves(#8B5737);
  //  tree.displayLeaves();
  //}
}
