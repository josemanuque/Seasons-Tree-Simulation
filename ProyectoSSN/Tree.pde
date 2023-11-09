class Tree {
  ArrayList<TreeNode> treeNodes;
  ArrayList<Leaf> leaves;
  ColonizerSystem branchColonizers;
  TreeNode currentNode = null;

  // Tree Grow Parameters
  PVector treeStartPos = new PVector(0, height - 100, 0);
  int trunkEndIndex = 0;
  int trunkNodeWidth = 70;
  int branchNodeWidth = 6;
  int trunkNodeLength = 10;
  int branchNodeLength = 10;
  int maxLeavesPerNode = 3;
  float leafGenerationProbability = 0.08;

  Tree() {
    treeNodes = new ArrayList<TreeNode>();
    leaves = new ArrayList<Leaf>();
    branchColonizers = new ColonizerSystem(this.treeNodes);
    this.addTrunk();
  }

  /*
   * Method that creates the first treeNode for the tree (root)
   * Gets called by addTrunk()
   * - treeStartPos defines the position where the tree will start growing its trunk
   * - root is set as currentNode for continuing growth of trunk.
   */
  void addRoot() {
    currentNode = new TreeNode(treeStartPos);
    treeNodes.add(currentNode);
    currentNode.isBranch = false;
    currentNode.isRoot = true;
  }

  /*
   * Method that generates the trunk of the tree
   * - Keeps growing vertically while no colonizer is aplying influence.
   * - Defines the index of treeNodes where the trunk nodes end.
   */

  void addTrunk() {
    addRoot();
    // While the current node has no influence direction, add a new node (trunk)
    while (!branchColonizers.isCloseEnough(currentNode)) {
      TreeNode nextNode = new TreeNode(new PVector(random(5), currentNode.pos.y - trunkNodeLength, random(5)), currentNode);
      treeNodes.add(nextNode);
      currentNode = nextNode;
      currentNode.isBranch = false;
    }
    //TreeNode nextNode = new TreeNode(new PVector(random(5), currentNode.pos.y - trunkNodeLength, random(5)), currentNode);
    //treeNodes.add(nextNode);
    //currentNode = nextNode;
    //currentNode.isBranch = false;
    trunkEndIndex = treeNodes.size();
  }

  /*
   * Method that generates branches using treeNodes if there are colonizers left
   * - If there are more than 8000 branches some colonizers were not removed properly,
   *   hence removing them and not continuing.
   * - For each treeNode it generates a new node in the position of the influence
   *   with magnitude of the desired length of the branch.
   * - Called repeatedly in draw. Needs to be efficient
   */
  void generateBranches() {
    branchColonizers.applyInfluence();

    if (branchColonizers.colonizers.isEmpty()) {
      return;
    }

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

        PVector influenceVector = n.influenceDirection.setMag(branchNodeLength);
        PVector newPos = PVector.add(n.pos, influenceVector);

        //println(newPos);

        TreeNode nextNode = new TreeNode(newPos, n);
        treeNodes.add(nextNode);
        currentNode = nextNode;
        // Reset influence direction in the node
        n.influenceDirection.x = 0;
        n.influenceDirection.y = 0;
        n.influenceDirection.z = 0;
      }
    }
    //generateLeaves();
  }

  /*
   * Method that generates leaves
   * - Generates leaves on a node only if the node is part of the branches
   *   and if its random is less than leafGenerationProbability in
   *   shouldGenerateLeavesForNode(node).
   * - Uses parallel transport frame methods to get the proper position and orientarion of the leaves.
   * - Each valid node will have a random of maxLeavesPerNode.
   */
  void generateLeaves(color leafColor) {

    for (TreeNode node : treeNodes) {
      if (node.isBranch && shouldGenerateLeavesForNode()) {
        int numLeavesPerBranch = int(random(maxLeavesPerNode));
        PVector tangent, normal, binormal;
        float angle = 0.0;  // Inicializa el ángulo de posición de la hoja

        // Calcula el "parallel transport frame" para la rama
        TransportFrame transportFrame = calculateParallelTransportFrame(node);
        tangent = transportFrame.tangent;
        normal = transportFrame.normal;
        binormal = transportFrame.binormal;

        // Genera varias hojas alrededor de la rama
        for (int i = 0; i < numLeavesPerBranch; i++) {
          PVector leafPosition = calculateLeafPosition(node, angle);
          PVector leafOrientation = calculateLeafOrientation(tangent, normal, binormal);

          Leaf leaf = new Leaf(leafPosition, leafOrientation, leafColor);
          leaf.associatedNode = node;
          leaf.angle = angle;
          leaf.createLeaf();
          leaves.add(leaf);

          // Aumenta el ángulo para posicionar la siguiente hoja
          angle += radians(360.0 / numLeavesPerBranch);
        }
      }
    }
  }

  /*
   * Method that calculates the Parallel Transport Frame
   * - Parallel Transport Frame sets a position parallel to the frame (node)
   */
  TransportFrame calculateParallelTransportFrame(TreeNode branch) {
    PVector tangent = branch.influenceDirection.copy().normalize();  // Dirección de la rama
    PVector up = PVector.random3D();  // Vector auxiliar para mantener la orientación constante
    PVector binormal = tangent.cross(up).normalize();
    PVector normal = binormal.cross(tangent).normalize();

    // Devuelve un objeto TransportFrame que contiene los tres vectores del "parallel transport frame"
    return new TransportFrame(tangent, normal, binormal);
  }

  PVector calculateLeafPosition(TreeNode branch, float angle) {
    float radius = branchNodeWidth;  // Ajusta el radio según sea necesario
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

  boolean shouldGenerateLeavesForNode() {
    // Generar hojas de manera aleatoria
    return random(1) < leafGenerationProbability;
  }

  void applyWindForce(PVector windForce) {
    int sizeTreeNodes = treeNodes.size();
    for (int i = 1; i < sizeTreeNodes; i++) {
      TreeNode t = treeNodes.get(i);

      // Aplica la fuerza de viento al nodo
      t.applyWindForce(windForce);
    }
  }

  void updateLeafPos(Leaf l) {
    PVector tangent, normal, binormal;
    // Calcula el "parallel transport frame" para la rama
    TransportFrame transportFrame = calculateParallelTransportFrame(l.associatedNode);
    tangent = transportFrame.tangent;
    normal = transportFrame.normal;
    binormal = transportFrame.binormal;

    PVector leafPosition = calculateLeafPosition(l.associatedNode, l.angle);
    PVector leafOrientation = calculateLeafOrientation(tangent, normal, binormal);

    l.pos = leafPosition;
    l.orientation = leafOrientation;
  }

  void display() {
    int sizeTreeNodes = treeNodes.size();
    

    // Trunk display
    for (int i = 1; i < trunkEndIndex; i++) {
      TreeNode t = treeNodes.get(i);
      float sw = map(i, 0, trunkEndIndex, trunkNodeWidth, trunkNodeWidth - trunkEndIndex);
      float mass = map(i, 0, trunkEndIndex, 500, 250);
      t.mass = mass;
      t.sw = sw;
      t.display();
    }
    // Branches display
    if (sizeTreeNodes >= 100) {
      for (int i = trunkEndIndex; i < 100; i++) {
        TreeNode t = treeNodes.get(i);
        float sw = map(i, trunkEndIndex, 100, trunkNodeWidth - trunkEndIndex, branchNodeWidth);
        float mass = map(i, 0, sizeTreeNodes, 250, 180);
        t.sw = sw;
        t.mass = mass;
        t.display();
      }
    }
    for (int i = trunkEndIndex; i < sizeTreeNodes; i++) {
      TreeNode t = treeNodes.get(i);
      float sw = map(i, 0, sizeTreeNodes, branchNodeWidth, 1);
      float mass = map(i, 0, sizeTreeNodes, 100, 20);
      t.sw = sw;
      t.mass = mass;
      t.display();
    }
    
    for (int i = 1; i < sizeTreeNodes; i++) {
      TreeNode t = treeNodes.get(i);
      t.update();
    }
  }

  void displayLeaves() {
    int sizeLeaves = leaves.size();
    for (int i = 0; i < sizeLeaves; i++) {
      Leaf l = leaves.get(i);
      l.display();
      updateLeafPos(l);
    }
  }
}
