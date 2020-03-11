class LoadTriangleDiagram {
  float triangleLength = 64;
  float triangleHeight = 100;
  int dis = 10;
  //立体感

  color[][] triangleColor = new color[4][2];
  PImage[] photo;

  //三角统计图
  boolean createTriangleDiagramFun(int x, int y, int number) {
    boolean showDataJu = false;
    //获得数据
    ld = new LoadData("/data/talentNumber.json");
    hm = ld.getData();
    //
    triangleColor[2][0] =#fa9d72;
    triangleColor[2][1] =#E8916C;
    triangleColor[1][0] =#cde779;
    triangleColor[1][1] =#BCE52C;
    triangleColor[0][0] =#7bcce7;
    triangleColor[0][1] =#6EB7CE;
    triangleColor[3][0] =#7e7e7e;
    triangleColor[3][1] =#484848;
    float high = 100;
    float rate;
    int fact;
    float outcome;
    float outcomeO;
    float outcomeOO;
    float moveNu = dis ;
    //计算比列
    dc = hm.get(0);
    float ratePercentO = triangleHeight/(dc.talent);//总人才
    dc = hm.get(7);
    float ratePercent = triangleHeight/((dc.superTalent*1f)/dc.talent);//杰出比列

    translate(x, y);
    //axis
    strokeWeight(1);
    stroke(grayColor);
    float axialX = ((triangleLength+dis)*number + dis*2) + margin*2;
    //横轴
    line(dis, 0, axialX, 0);
    //纵轴
    line(axialX, -triangleLength, axialX, triangleLength);
    //加载国家
    photo = lr.getImgO();
    for (int i = 0; i < number; i++) {
      pushMatrix();

      dc = hm.get(i);
      //println(dc.name + ", " + dc.talent + ", " +  dc.superTalent + ", " + dc.rate);

      float num = (dis + triangleLength)*i;
      //rate = (triangleHeight/high);
      fact = 1;
      //计算单个单位在统计图中所占的长度
      outcome = ((dc.superTalent*1f)/dc.talent)*fact*ratePercent;
      outcomeO = dc.talent*fact*ratePercentO;
      outcomeOO = dc.talent*fact*ratePercentO;

      //测试
      //println("---------------------------------------------------");
      //println("outcome: " + outcome + ", " + "outcomeO: " + outcomeO +  ", " + "outcomeOO: " + outcomeOO);
      //println("---------------------------------------------------");

      float randNu = random(0, 2);
      noStroke();
      //最高值，底层
      beginShape(TRIANGLE_STRIP);
      fill(triangleColor[3][0], 40);
      vertex(dis + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, -triangleHeight);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      fill(triangleColor[3][1], 40);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, -triangleHeight);
      vertex(dis+triangleLength/5.0f*5.0f + moveNu, 0);
      endShape();

      //总比列值
      beginShape(TRIANGLE_STRIP);
      fill(triangleColor[0][0], 200);
      vertex(dis + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, -(((dc.superTalent*1f)/dc.talent)*ratePercent + randNu));
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      fill(triangleColor[0][1], 200);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, -(((dc.superTalent*1f)/dc.talent)*ratePercent + randNu));
      vertex(dis+triangleLength/5.0f*5.0f + moveNu, 0);
      ////
      endShape();

      //
      beginShape(TRIANGLE_STRIP);
      fill(triangleColor[3][0], 40);
      vertex(dis + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, triangleHeight);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      fill(triangleColor[3][1], 40);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, triangleHeight);
      vertex(dis+triangleLength/5.0f*5.0f + moveNu, 0);
      endShape();
      //总人数和杰出人数
      beginShape(TRIANGLE_STRIP);
      fill(triangleColor[1][0], 200);
      vertex(dis + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, ratePercentO*dc.talent);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      fill(triangleColor[1][1], 200);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, ratePercentO*dc.talent);
      vertex(dis+triangleLength/5.0f*5.0f + moveNu, 0);
      endShape();
      beginShape(TRIANGLE_STRIP);
      fill(triangleColor[2][0], 200);
      vertex(dis + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, ratePercentO*dc.superTalent);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      fill(triangleColor[2][1], 200);
      vertex(dis+triangleLength/5.0f*4.0f + moveNu, 0);
      vertex(dis+triangleLength/2 + moveNu, ratePercentO*dc.superTalent);
      vertex(dis+triangleLength/5.0f*5.0f + moveNu, 0);
      println(outcome);
      endShape();

      //
      photo[i].resize(countryPicSize, countryPicSize);
      imageMode(CENTER);
      float xx = dis+triangleLength/2 + moveNu;
      float yy = -(((dc.superTalent*1f)/dc.talent)*ratePercent + 16 + randNu);
      image(photo[i], xx, yy);

      //判断鼠标位置
      if (((xx + x - countryPicSize/2f) <= mouseX) && ((xx + x + countryPicSize/2f) >= mouseX)) {
        if (((yy + y - countryPicSize/2f) <= mouseY) && ((yy + y + countryPicSize/2f) >= mouseY)) {
          showDc = dc;
          showDataJu = true;
        }
      }
      popMatrix();
      //
      moveNu = moveNu + (triangleLength + dis);
    }
    return showDataJu;
  }
}
