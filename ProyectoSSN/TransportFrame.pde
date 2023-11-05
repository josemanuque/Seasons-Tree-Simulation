class TransportFrame {
  PVector tangent;
  PVector normal;
  PVector binormal;

  TransportFrame(PVector tangent, PVector normal, PVector binormal) {
    this.tangent = tangent;
    this.normal = normal;
    this.binormal = binormal;
  }
}
