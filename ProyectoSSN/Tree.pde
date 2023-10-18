class Tree {
  ArrayList<TreeNode> treeNodes;
  TreeNode currentNode = null;
  
  Tree(){
    treeNodes = new ArrayList<TreeNode>();
    addTrunk();
  }
  
  
  void addTrunk(){
    currentNode = new TreeNode(new PVector(0, height - 100, 0));
    treeNodes.add(currentNode);
  }
  
  void addNode(){
    PVector pos = currentNode.direction;
    if(pos == null){
      TreeNode nextNode = new TreeNode(new PVector(0, currentNode.position.y - 5, 0));
      treeNodes.add(nextNode);
      currentNode = nextNode;
      return;
    }

    PVector newPos = PVector.sub(currentNode.position, pos.copy().setMag(5));
    TreeNode nextNode = new TreeNode(newPos);
    treeNodes.add(nextNode);
    currentNode = nextNode;
  }
  
  
  void grow(){
    for (TreeNode n : treeNodes){
      
  
  void display(){
    for (int i = 0; i < treeNodes.size(); i++){
      TreeNode t = treeNodes.get(i);
      t.display();
    }
  }
  
}
