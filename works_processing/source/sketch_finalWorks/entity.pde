  class DataCell {
    //
    int id = -1;
    String name;
    int value = -1;
    //
    String timeline;
    String[] events = new String[5];
    //
    int talent = -1;
    int superTalent = -1;
    String rate;
    //
    String period;
    String description;
    
    //长度
    int getLengthName() {  

      return this.name.length();
    }
    int getLengthValue() {
      int radix = 1;
      int exponent = 0;
      do {
        exponent++;
        radix *= 10;
      } while (value/radix > 10);
      exponent++;
      return exponent;
    }
  }
