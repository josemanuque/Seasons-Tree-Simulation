class Tree {
  ArrayList<TreeNode> treeNodes;
  ColonizerSystem branchColonizers;
  TreeNode currentNode = null;
  
  Tree(){
    treeNodes = new ArrayList<TreeNode>();
    branchColonizers = new ColonizerSystem(this.treeNodes);
    this.addTrunk();
  }
  
  // Method that generates branches (treeNodes)
  void generateBranches(){
    branchColonizers.applyInfluence();
    

    // For each node it creaes a new node in the direction of the influence
    int sizeOfTreeNodes = treeNodes.size();
    println(sizeOfTreeNodes);
    if (sizeOfTreeNodes > 10000)
      return;
    
    for (int i = 0; i < sizeOfTreeNodes; i++){
      TreeNode n = treeNodes.get(i);
      if(n.influenceDirection.x != 0 || n.influenceDirection.y != 0 || n.influenceDirection.z != 0){

        PVector influenceVector = n.influenceDirection.setMag(5);       
        PVector newPos = PVector.add(n.pos, influenceVector);
        
        //println(newPos);
        
        TreeNode nextNode = new TreeNode(newPos, n);
        treeNodes.add(nextNode);
        currentNode = nextNode;
        n.influenceDirection.x = 0;
        n.influenceDirection.y = 0;
        n.influenceDirection.z = 0;
      }
    }
  }

  void addRoot(){
    currentNode = new TreeNode(new PVector(0, height - 100, 0));
    treeNodes.add(currentNode);
  }
  
  void addTrunk(){
    addRoot();
    // While the current node has no influence direction, add a new node (trunk)
    while(!branchColonizers.isCloseEnough(currentNode)){
      TreeNode nextNode = new TreeNode(new PVector(0, currentNode.pos.y - 5, 0), currentNode);
      treeNodes.add(nextNode);
      currentNode = nextNode;
    }
    TreeNode nextNode = new TreeNode(new PVector(0, currentNode.pos.y - 5, 0), currentNode);
    treeNodes.add(nextNode);
    currentNode = nextNode;
  }

  
  void display(){
    int sizeTreeNodes = treeNodes.size();
    for (int i = 1; i < sizeTreeNodes; i++){
      TreeNode t = treeNodes.get(i);
      float sw = map(i, 0, sizeTreeNodes, 6, 0);
      t.sw = sw;
      t.display();
    }
  }
  
}
