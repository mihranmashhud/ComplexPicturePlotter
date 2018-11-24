//==================================================================================================================
// COMPLEX CLASS
//==================================================================================================================

// This class allows for easy creation and manipulation of complex numbers.
class Complex {

  //==================================================================================================================
  // COMPLEX NUMBER CONSTRUCTORS
  //==================================================================================================================

  // Returns a complex number based on its cartesian coordinates. ( z = a + bi )
  public ComplexNum cart(double a, double b) {
    double arg = Math.atan(b/a);
    if (a < 0) {
      if (b < 0) {
        arg -= Math.PI;
      } else {
        arg += Math.PI;
      }
    }
    return new ComplexNum(a, b, Math.sqrt(Math.pow(a, 2.0) + Math.pow(b, 2.0)), arg);
  }

  // Returns a complex number based on its polar coordinates. ( z = |z|(cos(arg(z)) + sin(arg(z)i)) = |z|*e^(arg(z)i) )
  public ComplexNum polar(double r, double arg) {
    // Make sure the argument only ranges from -pi to pi
    arg %= 2*Math.PI;
    if ( arg >= Math.PI) {
      arg -= 2*Math.PI;
    } else if (arg <= -Math.PI) {
      arg += 2*Math.PI;
    }

    return new ComplexNum(r*Math.cos(arg), r*Math.sin(arg), r, arg);
  }

  // Returns a scalar number. (z = a + 0i = a)
  public ComplexNum scalar(double mag) {
    return this.cart(mag, 0);
  }

  // Returns a complex unit. ( z = cos(arg(z)) + sin(arg(z))i = e^(arg(z)i) )
  public ComplexNum unit(double arg) {
    return this.polar(1.0, arg);
  }

  //==================================================================================================================
  // COMPLEX NUMBER OPERATIONS AND FUNCTIONS
  //==================================================================================================================
  
  // Return the addition of two complex numbers. ( z1 + z2 )
  public ComplexNum add(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.re() + z2.re(), z1.im() + z2.im());
  }

  // Return the subtraction of two complex numbers. ( z1 - z2 )
  public ComplexNum sub(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.re() - z2.re(), z1.im() - z2.im());
  }

  // Return the multpilication of two complex numbers. ( z1 * z2 )
  public ComplexNum mult(ComplexNum z1, ComplexNum z2) {
    return this.cart(z1.re()*z2.re() - z1.im()*z2.im(), z1.re()*z2.im() + z1.im()*z2.re());
  }

  // Return the division of two complex numbers. ( z1 / z2 )
  public ComplexNum div(ComplexNum z1, ComplexNum z2) {
    double denom = Math.pow(z2.re(), 2) + Math.pow(z2.im(), 2);
    double aNum = z1.re()*z2.re() + z1.im()*z2.im();
    double bNum = z1.im()*z2.im() - z1.re()*z2.im();
    return this.cart(aNum / denom, bNum / denom);
  }

  // Return the conjugate of a complex number. ( z.re() - z.im() )
  public ComplexNum conjugate(ComplexNum z) {
    return this.cart(z.re(), -z.im());
  }

  // Return a complex number raised to a real power. ( z^k )
  public ComplexNum pow(ComplexNum z, double k) {
    return this.polar(Math.pow(z.mag(), k), k*z.arg());
  }

  // Returns a real base raised to a complex number. ( k^z )
  public ComplexNum powKtoZ(double k, ComplexNum z) {
    return this.polar(Math.exp(z.re()*Math.log(k)), z.im()*Math.log(k));
  }
  
  // Returns a complex base raised to a complex number. ( z1^z2 )
  public ComplexNum powZ(ComplexNum z1, ComplexNum z2) {
    return this.polar(Math.exp(Math.log(z1.mag())*z2.re() - z1.arg()*z2.im()), Math.log(z1.mag())*z2.im() + z1.arg()*z2.re());
  }
  
  // Return the sqrt of a complex number. ( z^(1/2) )
  public ComplexNum sqrt(ComplexNum z) {
    return this.pow(z, 0.5);
  }

  // Return the natural logarithm of a complex number. ( ln(z) )
  public ComplexNum log(ComplexNum z) {
    return this.cart( Math.log( z.mag() ), z.arg() );
  }

  // Overloading of the log function to allow for other solutions to ln(z) to be returned. ( ln(r*e^(arg + 2pi*k)) )
  public ComplexNum log(ComplexNum z, int k) {
    return this.cart(Math.log(z.mag()), ((double) k)*2*Math.PI + z.arg());
  }

  // Return the logarithm of complex number using a real base. ( ln(z)/ln(k) )
  public ComplexNum logA(double k, ComplexNum z) {
    return this.div(this.log(z), this.log(this.scalar(k)));
  }
  
  // Return the logarithm of a real number using a complex base. ( ln(k)/ln(z) )
  public ComplexNum logZofK(ComplexNum z, double k) {
    return this.div(this.log(this.scalar(k)), this.log(z));
  }

  // Return the logarithm of a complex number using a complex base. ( ln(z2)/ln(z1) )
  public ComplexNum logZ(ComplexNum z1, ComplexNum z2) {
    return this.div(this.log(z2), this.log(z1));
  }
  
  // Returns e raised to a complex number. ( e^z )
  public ComplexNum exp(ComplexNum z) {
    return this.polar(Math.exp(z.re()), z.im());
  }
}
