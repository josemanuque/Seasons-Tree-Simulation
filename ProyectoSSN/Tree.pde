class Tree {
  ArrayList<TreeNode> treeNodes;
  ArrayList<Leaf> leaves;
  ColonizerSystem branchColonizers;
  TreeNode currentNode = null;

  Tree() {
    treeNodes = new ArrayList<TreeNode>();
    leaves = new ArrayList<Leaf>();
    branchColonizers = new ColonizerSystem(this.treeNodes);
    this.addTrunk();
  }

  // Method that generates branches (treeNodes)
  void generateBranches() {
    branchColonizers.applyInfluence();


    // For each node it creaes a new node in the direction of the influence
    int sizeOfTreeNodes = treeNodes.size();
    //println(sizeOfTreeNodes);
    if (sizeOfTreeNodes > 8000) {
      branchColonizers.colonizers.clear();
      return;
    }
    for (int i = 0; i < sizeOfTreeNodes; i++) {
      TreeNode n = treeNodes.get(i);
      if (n.influenceDirection.x != 0 || n.influenceDirection.y != 0 || n.influenceDirection.z != 0) {

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
    //generateLeaves();
  }

  void addRoot() {
    currentNode = new TreeNode(new PVector(0, height - 100, 0));
    treeNodes.add(currentNode);
  }

  void addTrunk() {
    addRoot();
    // While the current node has no influence direction, add a new node (trunk)
    while (!branchColonizers.isCloseEnough(currentNode)) {
      TreeNode nextNode = new TreeNode(new PVector(0, currentNode.pos.y - 5, 0), currentNode);
      treeNodes.add(nextNode);
      currentNode = nextNode;
      currentNode.sw = 12;
    }
    TreeNode nextNode = new TreeNode(new PVector(0, currentNode.pos.y - 5, 0), currentNode);
    treeNodes.add(nextNode);
    currentNode = nextNode;
    currentNode.sw = 12;
  }

  void generateLeaves() {
    int numLeavesPerBranch = 10;

    for (TreeNode branch : treeNodes) {
      PVector tangent, normal, binormal;
      float angle = 0.0;  // Inicializa el ángulo de posición de la hoja
      
      // Calcula el "parallel transport frame" para la rama
      TransportFrame transportFrame = calculateParallelTransportFrame(branch);
      tangent = transportFrame.tangent;
      normal = transportFrame.normal;
      binormal = transportFrame.binormal;
      
      // Genera varias hojas alrededor de la rama
      for (int i = 0; i < numLeavesPerBranch; i++) {
        PVector leafPosition = calculateLeafPosition(branch, angle);
        PVector leafOrientation = calculateLeafOrientation(tangent, normal, binormal);
        float leafSize = 10.0;  // Ajusta el tamaño según sea necesario

        Leaf leaf = new Leaf(leafPosition, leafOrientation, leafSize);
        leaves.add(leaf);

        // Aumenta el ángulo para posicionar la siguiente hoja
        angle += radians(360.0 / numLeavesPerBranch);
      }
    }
  }

  TransportFrame calculateParallelTransportFrame(TreeNode branch) {
    PVector tangent = branch.influenceDirection.copy().normalize();  // Dirección de la rama
    PVector up = PVector.random3D();  // Vector auxiliar para mantener la orientación constante
    PVector binormal = tangent.cross(up).normalize();
    PVector normal = binormal.cross(tangent).normalize();

    // Devuelve un objeto TransportFrame que contiene los tres vectores del "parallel transport frame"
    return new TransportFrame(tangent, normal, binormal);
  }

  PVector calculateLeafPosition(TreeNode branch, float angle) {
    float radius = 20.0;  // Ajusta el radio según sea necesario
    PVector positionOffset = new PVector(branch.pos.x, branch.pos.y, branch.pos.z);

    // Calcula la posición de la hoja alrededor de la rama
    float x = positionOffset.x + radius * cos(angle);
    float y = positionOffset.y + radius * sin(angle);
    float z = positionOffset.z;  // Mantén la posición en el mismo plano para simplificar

    return new PVector(x, y, z);
  }

  PVector calculateLeafOrientation(PVector tangent, PVector normal, PVector binormal) {
    // Utiliza el "parallel transport frame" para calcular la orientación de la hoja
    // Puedes experimentar con la combinación de estos vectores para obtener el efecto deseado
    PVector orientation = tangent.copy();  // En este ejemplo, la hoja apunta en la dirección de la rama
    return orientation;
  }

  void display() {
    int sizeTreeNodes = treeNodes.size();
    int sizeLeaves = leaves.size();
    for (int i = 1; i < sizeTreeNodes; i++) {
      TreeNode t = treeNodes.get(i);
      float sw = map(i, 0, sizeTreeNodes, 6, 0);
      t.sw = sw;
      t.display();
    }
    for (int i = 0; i < sizeLeaves; i++){
      println(i);
      Leaf l = leaves.get(i);
      l.display();
    }
  }
}
