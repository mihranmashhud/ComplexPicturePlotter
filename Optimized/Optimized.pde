import controlP5.*;
ControlP5 controlP5;

double xScale = 100.0;
double yScale = 100.0;
double xOffset = 0.0;
double yOffset = 0.0;
double viewX;
double viewY;
PImage img;
double[] controlNums = new double[4];
boolean locked = false;
Complex complex = new Complex();

void initGlobals() {
  viewX = width/2.0;
  viewY = height/2.0;
  controlNums[0] = 0.0;
}

void loadInputImage() {
  img = loadImage("assets/Pattern.png");
  img.loadPixels();
  controlP5 = new ControlP5(this);
}

void loadGUI() {
  controlP5.addNumberbox("numberbox1",0,10,10,100,30);
  controlP5.addToggle("dragable");
  controlP5.getController("dragable").setPosition(10,60);
}

void drawOutput() {
  colorMode(HSB, 2.0 * PI, 1.0, 1.0);
  strokeWeight(1);
  loadPixels();
  for (double y = 0.0; y < width; y++) {
    for (double x = 0.0; x < height; x++) {
      pixels[(int) (y*width+x)] = getColor(f(complex.cart((x-viewX)*xScale, (viewY-y)*yScale)));
    }
  }
  updatePixels();
  print(pixels[1000]);
}

void drawOutput(PImage image) {
  colorMode(RGB, 255);
  for (double y = 0.0; y < width; y++) {
    for (double x = 0.0; x < height; x++) {
      pixels[(int) (y*width+x)] = getPixel(f(complex.cart((x-viewX)*xScale, (viewY-y)*yScale)),image);
    }
  }
  updatePixels();
}

void load() {
  initGlobals();
  loadInputImage();
  loadGUI();
  loadPixels();
}

void setup() {
  size(500, 500);
  load();
  drawOutput(img);
  save("output.png");
}

void draw() {
  drawOutput(img);
}

ComplexNum f(ComplexNum z) {
  double multiples = 5.1;
  ComplexNum a = complex.cart(multiples*img.height/PI, 0);
  ComplexNum rotate = complex.polar(1.0,PI/4);
  ComplexNum newZ = complex.cart(z.a,z.b);
  newZ = complex.log(newZ);
  newZ = complex.mult(rotate, newZ);
  newZ = complex.mult(a,newZ);
  return newZ;
}

ComplexNum g(ComplexNum z) {
  return complex.pow(z,1);
}

color getColor(ComplexNum z) {
  float arg = (float) -z.arg + PI;
  float r = (float) z.r;
  return color(arg, 1, 1 - 1.0/log(r+(float) Math.E));
}

color getPixel(ComplexNum z, PImage image) {
  int a = (int) z.a % img.width;
  int b = (int) z.b % img.height;
  int x, y;

  if (a >= 0) {
    x = a;
  } else {
    x = img.width + a;
  }

  if (b >= 0) {
    y = b;
  } else {
    y = img.height + b;
  }
  int index = x + y * img.width;

  return image.pixels[index];
}

void mousePressed() {
  xOffset = mouseX-viewX; 
  yOffset = mouseY-viewY; 
}

void mouseDragged() {
  if(!locked) {
   viewX = mouseX-xOffset; 
   viewY = mouseY-yOffset;
  }
}

void controlEvent(ControlEvent e) {
  
  
  switch(e.getController().getName()) {
    case "dragable":
      locked = controlP5.getController("dragable").getState();
  }
  
  if(e.getController().getName()=="dragable") {
    
  }
  if(e.getController().getName()=="numberbox1"){
    controlNums[0] = (double) e.getController().getValue();
  }
}
