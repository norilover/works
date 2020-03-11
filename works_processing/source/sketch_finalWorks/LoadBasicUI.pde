class LoadBasicUI {
  void loadBasis() {
    //pushMatrix();
    themePic.resize(760, 1374);
    imageMode(CENTER);
    image(lr.getBackgroundMiddle(), 508, 502);
    image(themePic, 52, 647);
    image(lr.getBackgroundRight(), 991, 500);

    //popMatrix();
  }
  void loadAnimation() {
    ellipseMode(CENTER);
    fill(#ececec, 200);

    noStroke();
    PVector pvStart = new PVector(446, 507);
    PVector pvEnd = new PVector(600, 800);

    //获取中间值
    float x = lerp(pvStart.x, pvEnd.x, fi/20.0);
    float y = lerp(pvStart.y, pvEnd.y, fi/20.0);
    ellipse(x, y, 120 - fi*5, 100 - fi*4);

    fi = (fi <= 20 ? ++fi : 0);
  }
}
