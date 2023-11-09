class Ground {
  color c;

  Ground(color groundColor) {
    c = groundColor;
  }

  void display(color groundColor) {
    pushMatrix();
    translate(0, 465, 0);
    fill(groundColor);
    box(1000, 70, 1000);
    popMatrix();
  }
}
