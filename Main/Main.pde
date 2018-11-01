double cWidth;
double cHeight;
double xScale;
double yScale;
float E = (float) Math.E;
PImage img;
color[][] imgPixels;
ComplexNum[][] grid;
Complex complex;

void preload() {
  img = loadImage("assets/Pattern.png");
  imgPixels = new color[img.width][img.height];
  img.loadPixels();
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) {
        int index = x + y * img.width;
        imgPixels[x][y] = img.pixels[index];
    }
  }

  cWidth = 1000.0;
  cHeight = 1000.0;
  xScale = 1.0;
  yScale = 1.0;
  E = (float) Math.E;
  grid = new ComplexNum[(int) cWidth][(int) cHeight];
  complex = new Complex();
  double min = 0;
  double max = 0;

  for (double y = 0.0; y < cWidth; y++) {
    for (double x = 0.0; x < cHeight; x++) {
      int X = (int) x;
      int Y = (int) y;
      grid[X][Y] = complex.cart((x-cWidth/2.0)*xScale, (cHeight/2.0-y)*yScale);
      if(grid[X][Y].arg < min) {
        min = grid[X][Y].arg;
      }
      if(grid[X][Y].arg > max) {
        max = grid[X][Y].arg;
      }
    }
  }
  println(min);
  println(max);
}

void setup() {
  colorMode(HSB, 2.0 * PI, 1.0, 1.0);
  smooth(6);
  size(1000, 1000);
  preload();
  //drawInput();
  //drawOutput();
  //drawInputImage();
  drawOutputImage();
}

void draw() {
  //drawInput();
  //drawOutput();
  //drawInputImage();
  //drawOutputImage();
}

void drawInput() {
  strokeWeight(1);
  for (int y = 0; y < cWidth; y++) {
    for (int x = 0; x < cHeight; x++) {
      stroke(getColor(grid[x][y]));
      point(x, y);
    }
  }
}

void drawOutput() {
  strokeWeight(1);
  for (int y = 0; y < cWidth; y++) {
    for (int x = 0; x < cHeight; x++) {
      stroke(getColor(f(grid[x][y])));
      point(x+ (int) cWidth, y);
    }
  }
}

void drawInputImage() {
  colorMode(RGB, 255);
  strokeWeight(1);
  for (int y = 0; y < cWidth; y++) {
    for (int x = 0; x < cHeight; x++) {
      stroke(getPixel(grid[x][y]));
      point(x, y);
    }
  }
}

void drawOutputImage() {
  colorMode(RGB, 255);
  strokeWeight(1);
  for (int y = 0; y < cWidth; y++) {
    for (int x = 0; x < cHeight; x++) {
      stroke(getPixel(g(grid[x][y])));
      point(x, y);
    }
  }
}

ComplexNum f(ComplexNum z) {
  double multiples = 4.0;
  ComplexNum a = complex.cart((multiples*1000)/PI, 0);
  ComplexNum rotate = complex.polar(1000.0,PI/4);
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
  return color(arg, 1, 1 - 1.0/log(r+E));
}

color getPixel(ComplexNum z) {
  int a = (int) Math.floor(z.a % img.height);
  int b = (int) Math.floor(z.b % img.width);
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

  return imgPixels[x][y];
}
