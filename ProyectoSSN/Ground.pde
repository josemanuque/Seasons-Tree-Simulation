class Ground {
  float[][] terrain;
  int cols, rows;
  color c;
  boolean displayBoxEnabled = true;

  Ground(int cols, int rows, color groundColor) {
    this.cols = cols;
    this.rows = rows;
    terrain = new float[cols][rows];
    c = groundColor;
  }

void generateTerrain(float maxHeight) {
    float xOff = 0;
    for (int x = 0; x < cols; x++) {
      float yOff = 0;
      for (int z = 0; z < rows; z++) {
        terrain[x][z] = map(noise(xOff, yOff), 0, 1, -maxHeight, maxHeight);
        yOff += 0.1;
      }
      xOff += 0.1;
    }
}

  void displayBox() {
    if (displayBoxEnabled) {
      pushMatrix();
      translate(0, 465, 0);
      fill(c);
      box(1000, 40, 1000);
      popMatrix();
    }
  }

  void display() {
    pushMatrix();
    translate(-cols * 5, 465, -rows * 5); // Center
    fill(c);
    noStroke();

    for (int x = 0; x < cols - 1; x++) {
      beginShape(TRIANGLE_STRIP);
      for (int z = 0; z < rows; z++) {
        vertex(x * 10, terrain[x][z], z * 10);
        vertex((x + 1) * 10, terrain[x + 1][z], z * 10);
      }
      endShape();
    }
    popMatrix();
  }

  void changeColor(color groundColor) {
    c = groundColor;
    display();
  }

  void changeBox(boolean b) {
    displayBoxEnabled = b;
  }
}
