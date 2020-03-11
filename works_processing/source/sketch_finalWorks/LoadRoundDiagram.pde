class LoadRoundDiagram {

  //类园状图标
  void createRoundDiagramFun() {
    pushMatrix();
    //每一层级的项目个数
    int items = 10;
    //最大层级
    int hierarchy = 5;
    translate(width/4.0f*3.0f + width/8, height/4.0f*3.0f);
    float r = width/8;
    float perLevelWidth = r/hierarchy;
    fill(#EAE6E6);
    for (int i = hierarchy; i >= 1; i--) {
      //循环生成图表
      subRound01Fun(perLevelWidth*i, items);
    }
    //中心
    fill(#ffffff);
    ellipse(0, 0, perLevelWidth/2, perLevelWidth/2);
    popMatrix();
  }
  void subRound01Fun(float r, int items) {
    //所有占有量的总和
    float allNu = items;
    //每个占有量的价值
    int value = 1;
    //计算比率
    float rate =  radians(360.0f/allNu);
    //开始结束的角度
    float startAngle = 0.0f;
    float endAngle = 0.0f;

    stroke(#ffffff);
    strokeWeight(1);
    for (int i = 1; i <= items; i++) {

      fill(#C43D3D);
      endAngle += rate*value;
      arc(0, 0, r, r, startAngle, endAngle, PIE);
      startAngle = endAngle;
      //填充白色
      //if ((int)random(0, items) == 0) {
      //  fill(#ffffff);
      //  r = random(0, 10);
      //  arc(0, 0, radians(startAngle - endAngle)*r, radians(startAngle - endAngle)*r, startAngle, endAngle, PIE);
      //}
      ////随机线
      strokeCap(ROUND);
      float y = random(-r, r);
      float x = (sqrt(pow(r, 2) - pow(y, 2)));
      x = ((int)random(0, 2) == 0 ? -x : x);
      strokeWeight(1);
      line(0, 0, x, y);
    }
  }
}
