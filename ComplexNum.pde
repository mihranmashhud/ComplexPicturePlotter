//==================================================================================================================
// COMPLEX CLASS
//==================================================================================================================

// An object representation of a complex number with getter methods for all the properties.
class ComplexNum {
  
    private double a,b,r,arg;
    
    // Initialize the complex number with the real part; imaginary part; magnitude; and argument.
    ComplexNum(double _a,double _b,double _r, double _arg) {
      a = _a;
      b = _b;
      r = _r;
      arg = _arg;
    }
    
    // Get real part.
    public double re() {
      return this.a;
    }
    
    // Get imaginary part.
    public double im() {
      return this.b;
    }
    
    // Get magnitude.
    public double mag() {
      return this.r;
    }
    
    // Get argument.
    public double arg() {
      return this.arg;
    }
}
