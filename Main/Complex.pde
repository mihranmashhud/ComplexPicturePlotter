class Complex {

  public ComplexNum cart(double a, double b) {
    double arg = Math.atan(b / a);
    if(a < 0) {
      if(b < 0) {
        arg -= Math.PI;
      } else {
        arg += Math.PI;
      }
    }
    return new ComplexNum(a, b, Math.sqrt(Math.pow(a, 2.0)+Math.pow(b, 2.0)), arg);
  }

  public ComplexNum polar(double r, double arg) {
    arg %= 2*Math.PI;
    if ( arg >= Math.PI) {
      arg -= 2*Math.PI;
    } else if (arg <= -Math.PI) {
      arg += 2*Math.PI;
    }
    //arg = arg - Math.ceil(arg / (Math.PI*2) - 1) * Math.PI*2;
    return new ComplexNum(r*Math.cos(arg), r*Math.sin(arg), r, arg);
  }

  public ComplexNum add(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.a + z2.a, z1.b + z2.b);
  }

  public ComplexNum sub(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.a - z2.a, z1.b - z2.b);
  }

  public ComplexNum mult(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.a * z2.a - z1.b * z2.b, z1.a * z2.b + z1.b * z2.a);
  }

  public ComplexNum div(ComplexNum z1, ComplexNum z2) {
    double denom = Math.pow(z2.a, 2) + Math.pow(z2.b, 2);
    double aNum = z1.a * z2.a + z1.b * z2.b;
    double bNum = z1.b * z2.b - z1.a * z2.b;
    return this.cart(aNum / denom, bNum / denom);
  }

  public ComplexNum conjugate(ComplexNum z) {
    return this.cart(z.a, -z.b);
  }

  public ComplexNum pow(ComplexNum z, double k) {
    return this.polar(Math.pow(z.r, k), k*z.arg);
  }

  public ComplexNum sqrt(ComplexNum z) {
    return this.pow(z, 0.5);
  }

  public ComplexNum log(ComplexNum z) {
    return this.cart(Math.log(z.r), z.arg);
  }

  public ComplexNum log(ComplexNum z, int k) {
    return this.cart(Math.log(z.r), ((double) k) *2*Math.PI + z.arg);
  }
}
