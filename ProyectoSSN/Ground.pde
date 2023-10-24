class Ground {
  color c;

  Ground(color groundColor) {
    c = groundColor;
  }

  void display() {
    pushMatrix();
    translate(0, 465, 0);
    fill(c);
    box(1000, 70, 1000);
    popMatrix();
  }
}
