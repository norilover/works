class LoadPaperRankingDiagram {
  color wordColor = color(#343434);
  LoadResources lr = new LoadResources();
  //LoadPaperRankingDiagram() {
  //  this.fileName = fileName;
  //  this.beginX = beginX;
  //  this.beginY = beginY;
  //  this.gap = gap;
  //}
  boolean loadPaperDiagramFun(String fileName, int beginX, int beginY, int gap) {
    boolean showDataJu = false;
    //加载国旗
    photo = lr.getImg();
    //柱状图
    ld = new LoadData(fileName);
    HashMap<Integer, DataCell> hm = ld.getData(); 

    //定义每一小格五万
    float per = 1000f;
    //
    int perValue; 
    float perValueRuler;
    String perName;
    //
    DataCell dc = (DataCell)hm.get(0);
    float rate = ((dc.value/per + 4)/(float)(height/2 - margin*5));

    //
    pushMatrix();
    translate(beginX, beginY);

    //println("rate: " + rate);
    //取出其中的数据


    strokeCap(ROUND);
    strokeJoin(ROUND);
    strokeWeight(0.1f);
    stroke(grayColor);
    fill(grayColor);

    line(0, 0, 0, 4);

    float ruX = ((gap + countryPicSize)*10f+margin/2 +countryPicSize);

    //line(ruX, (margin + countryPicSize/2 + 9*40), ruX, 0);

    line(0, 0, ruX, 0);
    fill(wordColor);
    stroke(grayColor);
    //国家flag
    imageMode(CENTER);
    rectMode(CENTER);
    //(gap + countryPicSize)*9f+margin/2 +countryPicSize
    for (int i =  0; i < photo.length; i++) {
      photo[i].resize(countryPicSize, countryPicSize);
      //位置
      float dis = (gap + 4 + countryPicSize)*i;
      //flag 位置
      float x = (dis +countryPicSize);
      float y = (margin + countryPicSize/2 + 5*40);
      float randNu = random(0, 3);
      //开头线
      //画线
      strokeWeight(1);
      line(x, 0, x, y + randNu);
      //ruler
      //strokeWeight(10f);
      //line(ruX, y, ruX - 2, y);
      textSize(5);
      textAlign(RIGHT, CENTER);
      //得到单个数据
      dc = (DataCell)hm.get(i);
      perName = dc.name;
      perValue = dc.value;
      perValueRuler = perValue*rate/per;
      ut.createWord(wordMin);
      image(photo[i], x, y + randNu);
      //传输鼠标对应的值
      if (((x - countryPicSize/2f + beginX) <= mouseX) && ((x + countryPicSize/2f + beginX) >= mouseX)) {
        if ((y + randNu - countryPicSize/2f + beginY) <= mouseY && (y + randNu + countryPicSize/2f + beginY) > mouseY) {
          showDc = dc;
          showDataJu = true;
        }
      }
      //存在延迟
      //showDataJu = ut.judgeMousePos((x - countryPicSize/2f + beginX), (x + countryPicSize/2f + beginX), (y + randNu - countryPicSize/2f + beginY), (y + randNu + countryPicSize/2f + beginY));
      //if (showDataJu) {
      //  showDc = dc;
      //  println(showDataJu + "showDataJuValue" + "enter" + "----------------------");
      //}
    }
    //加载介绍信息
    popMatrix();
    return showDataJu;
  }
  //解释上面图表的信息
  //void stateTheCountryDirgram(HashMap<Integer, DataCell> hm) {
  //  fill(#000000);
  //  strokeWeight(0.1f);
  //  stroke(grayColor);
  //  fill(grayColor);
  //  ellipse(45, 250, 4, 4);
  //  line(45, 250, 45, 390);
  //  line(45, 390, width/4 - margin*2, 390);
  //  ellipse(width/4 - margin*2, 390, 4, 4);
  //  stroke(wordColor);
  //  fill(wordColor);
  //  pushMatrix();
  //  translate(45, 390);
  //  int nextColumn = margin*4;
  //  int bothInterval = 10;
  //  int recor = 0;
  //  int wordScale = 5;
  //  DataCell dc;
  //  for (int i = 0; i < photo.length; i++, recor++) {
  //    if (i == 5) {
  //      nextColumn = countryPicSize*2 ;
  //      recor = 0;
  //    }
  //    photo[i].resize(countryPicSize/4, countryPicSize/4);
  //    image(photo[i], (nextColumn), -(14*recor + 14));
  //    //文字
  //    dc = (DataCell)hm.get(i);
  //    String name = dc.name;
  //    ut.createWord(wordScale);
  //    textAlign(LEFT, CENTER);
  //    text(name, (nextColumn) + bothInterval, -(14*recor + 14));
  //  }
  //  //图表类型
  //  int wordScaleContent = wordScale*2; 
  //  ut.createWord(wordScaleContent);
  //  textAlign(CENTER, CENTER);
  //  text("全球论文排行", ((nextColumn + bothInterval)-margin*2), -(14*recor + 14 + margin + wordScaleContent));
  //  popMatrix();
  //}
}
