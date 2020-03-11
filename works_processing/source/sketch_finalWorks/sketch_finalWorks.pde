import processing.pdf.*;

//资源
PImage[] photo = new PImage[10];
LoadResources lr = new LoadResources();
//论文排名ranking
LoadPaperRankingDiagram lprd = new LoadPaperRankingDiagram();
//三角形diagram
LoadTriangleDiagram ltd = new LoadTriangleDiagram();
//圆形diagram
LoadRoundDiagram lrd = new LoadRoundDiagram();
//发展历史图表
LoadHistoryDiagram Lhd = new LoadHistoryDiagram();
//接收数据
HashMap<Integer, DataCell>  hm = new  HashMap<Integer, DataCell>();
DataCell dc = new DataCell();//单个元素
//显示鼠标停留处的数据
DataCell showDc;
String showData;
//工具类
UtilTool ut = new UtilTool();
//基本界面元素
LoadBasicUI lbui = new LoadBasicUI();
int margin = 10;
//lu
//ld

//字体
PFont myFont;
//字体大小
int wordMin = 7;
int wordMiddle = 10;
int wordMax = 0;
//显示内容
String content;
boolean show = false;
PImage themePic;
PImage conveyPic;

//LoadBasicUI
int fi = 0;//记录机器人的呼出次数
//颜色
int grayColor = 200;
//地图素材缩放大小
int countryPicSize = 20; 
//人工智能发展年限表

LoadData ld;
//辅助线
void setup() {
  background(#ffffff);
  size(1600, 1000);
  //scale(300/72.0);
  //beginRecord(PDF, "everything.pdf");
  //smooth();
  //pixelDensity(displayDensity());
  //frameRate(5);
  smooth();
  themePic = lr.getBackgroundLeft();
  conveyPic = lr.getConvey();
  //人工智能发展年限表

  //加载数据
}
void draw() {
  background(#ffffff);

  //加载基本元素
  pushMatrix();
  lbui.loadBasis();
  lbui.loadAnimation();
  popMatrix();

  //pushMatrix();
  //stroke(240);
  //ut.showRuler();
  //popMatrix();

  pushMatrix();
  ////发展历史图表
  //ut.createWord(20);
  if (Lhd.loadHistoryDiagramFun(new PVector(800, 150))) {
    showDataBoard();
  }
  //加载年段分析图
  if (Lhd.loadSubHD(130f, 20f)) {
    showDataBoard();
  }
  //实际值
  popMatrix(); 

  ////ru
  ////论文产出国排名r
  pushMatrix();
  if (lprd.loadPaperDiagramFun("perCountryPaperNumberRanking.json", (int)(width/8.0f*5 + margin*2), (int)(height/6f*4f + margin*3), 32)) {
    showDataBoard();
  }
  popMatrix();
  boolean ff = false;
  pushMatrix();
  //ltd.createTriangleDiagramFun((int)(width/16.0f*8), (int)(height/4f*3),10);
  //ltd.createTriangleDiagramFun((int)(width/8.0f*4 -margin/2f*2), (int)(height/6f*3), 10);
  ff = ltd.createTriangleDiagramFun((int)(width/8.0f*4 -margin/2f*2), (int)(height/6f*3), 10);
  popMatrix();
  if (ff == true) {
    showDataBoard();
  }
  //lu侧
  //ut.createWord(0, #000000, "CENTER");
  //text("人工智能", width/8, 47);

  //rd
  //roundDiagram
  //lrd.createRoundDiagramFun();
  //解释文字
  PImage  pi01 = lr.getWords("img/other/themeWord.png");
  imageMode(CENTER);
  pi01.resize(200, 500);
  image(pi01, 160, 260);

  pi01 = lr.getWords("img/other/explain.png");
  pi01.resize(213, 203);
  image(pi01, 865, 770);
  //pi01 = 
  textAlign(LEFT, TOP);
  ut.createWord("等线", 20);
  text("人工智能发展史:", 640, 30);
  text("人工智能各时" + "\n" + "期热度:", 1200, 30);
  text("全球人工智能人才分布:", 766, 332);
  text("全球人工智能论文分布:", 1100, 645);
  text("元素:", 810, 645);


  //图表分界线
  stroke(grayColor);
  strokeWeight(0.5f);
  strokeCap(ROUND);
  strokeJoin(ROUND);
  line(750, 250, 800, 300);
  line(800, 300, 1140, 300);
  line(1240, 300, 1570, 300);

  line(1190, 20, 1190, 250);
  line(1190, 250, 1140, 300);
  line(1190, 250, 1240, 300);

  line(750, 664, 800, 614);
  line(800, 614, 930, 615); 
  line(1030, 615, 1570, 614);

  line(1030, 615, 980, 665);
  line(980, 665, 990, 1000);
  line(980, 665, 930, 615);

  //tip
  //if (show) {
  //  content = "MouseX: " + mouseX + "\n " + "MouseY: " + mouseY; 
  //  //String[] arrayContent = content.split(",");
  //  ut.createWord(20);
  //  text(content, mouseX, mouseY); 
  //  println(mouseX + ", " + mouseY);
  //}
  //endRecord();
  //exit();
}

//void mousePressed() {
//  show = true;
//  showDataBoard();
//}
//void mouseReleased() {
//  show = false;
//}
//描画辅助线
void drawAssistantLine() {
  stroke(grayColor);
  strokeWeight(1);
  strokeCap(ROUND);
  strokeJoin(ROUND);
  //
  //line(pmouseX, pmouseY, mouseX,mouseY);
}
//展示信息
void showDataBoard() {
  ut.createWord(wordMiddle);
  int boardlength = 20;
  int boardWidth = 100;
  float rate = wordMiddle + wordMiddle/2f;
  if (showDc != null) {
    if (showDc.id >= 0) {
      showData = ("排名：" + (showDc.id + 1)) + "\n";
      boardlength += rate;
    }
    if (showDc.period != null) {
      showData = ("时期：" + "\n" + showDc.period + "\n");
      boardlength += rate;
      boardlength += rate;
    }
    if (showDc.name != null) {
      showData += ("名称："+"\n" + showDc.name + "\n");
      boardlength += rate;
      boardlength += rate;
    }
    if (showDc.events[0] != null) {
      showData += ("重大事件：" + "\n");
      boardlength += rate;
      for (String s : showDc.events) {
        if (s != null) {
          showData += (s + "\n");
          boardlength += rate;
        }
      }
    }
    if (showDc.timeline != null) {
      showData += ("时间区间：" +"\n" +  showDc.timeline + "\n");
      boardlength += rate;
      boardlength += rate;
    }
    if (showDc.value != -1) {
      showData += ("总数：" + showDc.value + "\n");
      boardlength += rate;
    }
    if (showDc.talent != -1) {
      showData += ("总人数：" + showDc.talent + "\n");
      boardlength += rate;
    }
    if (showDc.superTalent != -1) {
      showData += ("杰出人数：" + showDc.superTalent + "\n");
      boardlength += rate;
    }
    if (showDc.rate != null) {
      showData += ("杰出比率：" + showDc.rate + "\n");
      boardlength += rate;
    }
    //字符处理
    if (showDc.description != null) {
      //showData += ("描述：" + showDc.description + "\n");
      boardlength += rate;
      String[] ss = showDc.description.split("@");
      for (String s : ss) {
        showData += (s + "\n");
        boardlength += rate;
      }
    }
    //显示数据
    noStroke();
    rectMode(CENTER);
    fill(#ffffff, 200);
    rect(mouseX, mouseY, boardWidth, boardlength);
    ut.createWord(wordMiddle, #000000);
    textAlign(CENTER, CENTER);
    text(showData, mouseX, mouseY);
  }
}
