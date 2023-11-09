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

  float timeSinceLastLeafFall = 0;
  float leafMinTimeInterval = 1;
  float leafMaxTimeInterval = 2;
  float leafFallChance = 0.005;
  ArrayList<Leaf> fallingLeaves = new ArrayList();
  PVector currentWindForce = new PVector();

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
    if (sizeOfTreeNodes > 8000) {
      branchColonizers.colonizers.clear();
      return;
    }
    for (int i = 0; i < sizeOfTreeNodes; i++) {
      TreeNode n = treeNodes.get(i);
      if (n.influenceDirection.x != 0 || n.influenceDirection.y != 0 || n.influenceDirection.z != 0) {

        PVector influenceVector = n.influenceDirection.setMag(branchNodeLength);
        PVector newPos = PVector.add(n.pos, influenceVector);

        TreeNode nextNode = new TreeNode(newPos, n);
        treeNodes.add(nextNode);
        currentNode = nextNode;
        // Reset influence direction in the node
        n.influenceDirection.x = 0;
        n.influenceDirection.y = 0;
        n.influenceDirection.z = 0;
      }
    }
  }

  /*
   * Method that generates leaves
   * - Generates leaves on a node only if the node is part of the branches
   *   and if its random is less than leafGenerationProbability in
   *   shouldGenerateLeavesForNode(node).
   * - Uses parallel transport frame methods to get the proper position and orientarion of the leaves.
   * - Each valid node will have a random of maxLeavesPerNode.
   */
  void generateLeaves(color leafColor, float leafSize, float leavesQuantity) {

    for (TreeNode node : treeNodes) {
      if (node.isBranch && shouldGenerateLeavesForNode(leavesQuantity)) {
        int numLeavesPerBranch = int(random(maxLeavesPerNode));
        float angle = 0.0;  // Inicializa el ángulo de posición de la hoja

        // Genera varias hojas alrededor de la rama
        for (int i = 0; i < numLeavesPerBranch; i++) {
          PVector leafPosition = calculateLeafPosition(node, angle);

          Leaf leaf = new Leaf(leafPosition, leafColor, leafSize);
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

  PVector calculateLeafPosition(TreeNode branch, float angle) {
    float radius = branchNodeWidth;  // Ajusta el radio según sea necesario
    PVector positionOffset = new PVector(branch.pos.x, branch.pos.y, branch.pos.z);

    // Calcula la posición de la hoja alrededor de la rama
    float x = positionOffset.x + radius * cos(angle);
    float y = positionOffset.y + radius * sin(angle);
    float z = positionOffset.z;  // Mantén la posición en el mismo plano para simplificar

    return new PVector(x, y, z);
  }

  boolean shouldGenerateLeavesForNode(float leavesQuantity) {
    // Generar hojas de manera aleatoria
    return random(1) < leavesQuantity;
  }

  void applyWindForce(PVector windForce) {
    int sizeTreeNodes = treeNodes.size();
    for (int i = 1; i < sizeTreeNodes; i++) {
      TreeNode t = treeNodes.get(i);

      // Aplica la fuerza de viento al nodo
      t.applyWindForce(windForce);
    }

    currentWindForce.add(windForce);

    //Leaf wind

    for (int i = leaves.size()-1; i >= 0; i--) {
      Leaf l = leaves.get(i);
      l.applyForce(windForce);
    }

    for (int i = fallingLeaves.size()-1; i >= 0; i--) {
      Leaf l = fallingLeaves.get(i);
      l.applyForce(windForce);
    }
  }

  void updateLeafPos(Leaf l) {
    PVector leafPosition = calculateLeafPosition(l.associatedNode, l.angle);
    l.setPos(leafPosition);
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
    timeSinceLastLeafFall += 0.0166;//60 fps delta time
    for (int i = leaves.size()-1; i >= 0; i--) {
      Leaf l = leaves.get(i);
      l.display();
      updateLeafPos(l);
      maybeLeafFall(l);
    }

    for (int i = fallingLeaves.size()-1; i >= 0; i--) {
      Leaf l = fallingLeaves.get(i);
      l.display();
      l.update();
      l.applyGravity(new PVector(0, 0.1));
    }
  }

  void deleteLeaves() {
    int sizeLeaves = leaves.size();
    for (int i = 0; i < sizeLeaves; i++) {
      Leaf l = leaves.get(i);
      l.clear();
    }
    leaves.clear();
    for (int i = 0; i < fallingLeaves.size(); i++) {
      Leaf l = fallingLeaves.get(i);
      l.clear();
    }
    fallingLeaves.clear();
  }

  void maybeLeafFall(Leaf l) {
    if (timeSinceLastLeafFall > leafMaxTimeInterval) {
      detachLeaf(l);
      timeSinceLastLeafFall = 0;
    }
    if (timeSinceLastLeafFall > leafMinTimeInterval) {
      if (random(0, 1) <= leafFallChance) {
        detachLeaf(l);
        timeSinceLastLeafFall = 0;
      }
    }
  }

  Leaf getRandomAttachedLeaf() {
    if (leaves.size() == 0)
      return null;
    return leaves.get(floor(random(0, leaves.size()-1)));
  }

  void detachLeaf(Leaf l) {
    l.detach();
    leaves.remove(l);
    l.applyGravity(new PVector(0, 0.81));
    l.applyForce(currentWindForce);
    fallingLeaves.add(l);
  }
}
