void initControls() {
  cp5 = new ControlP5(this);

  cp5.addButton("setVerano")
    .setPosition(-450, -400)
    .setSize(70, 70)
    .setCaptionLabel("Verano");

  cp5.addButton("setInvierno")
    .setPosition(-350, -400)
    .setSize(70, 70)
    .setCaptionLabel("Invierno");

  cp5.addButton("setPrimavera")
    .setPosition(-250, -400)
    .setSize(70, 70)
    .setCaptionLabel("Primavera");

  cp5.addButton("setOtonno")
    .setPosition(-150, -400)
    .setSize(70, 70)
    .setCaptionLabel("Otoño");
}

void setVerano(){
  println("Hola, soy Verano");
}

void setInvierno(){
  println("Hola, soy Invierno");
}

void setPrimavera(){
  println("Hola, soy Primavera");
}

void setOtonno(){
  println("Hola, soy Otonno");
}
