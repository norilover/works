class LoadHistoryDiagram {

  int tLHeight = 10;
  float period = 4f;
  int tLWidth = 350;
  float minRad = 30f;
  //事件小圆
  float minEvenRad = 10;
  //发展时间轴
  int times = 1;//变化基数
  float randLeft;
  float randMiddle;
  float randRight;

  //节点对应的X值
  float nodeX1 ;
  float nodeX2 ;
  float nodeX3 ;
  //存储遍历一次后的坐标
  PVector[] pvPos = new PVector[(int)period]; 
  PVector[][] pvEnvent = new PVector[10][10]; 
  //
  float[] angle = new float[4];
  //存储开头和结尾的坐标
  PVector[] pvBE = new PVector[2];
  //年段解释颜色
  color[] cYear = new color[4];
  //坐标轴的位置
  float[][] posXY = new float[4][2];

  //加载历史图表
  boolean loadHistoryDiagramFun( PVector pvTL) {
    boolean showDataJu = false;
    //
    nodeX1 = pvTL.x + (tLWidth + margin*4)/3f;
    nodeX2 = pvTL.x + (tLWidth + margin*4)/3*2f;
    nodeX3 = pvTL.x + (tLWidth + margin*4);
    //
    randLeft = random(-times, times);
    randMiddle = random(-times*2, times*2 );
    randRight = random(-times*3, times*3);
    float dis = (pvTL.x + margin*2);
    //加载数据
    ld = new LoadData("developmentHistory.json");
    //得到数据
    hm = ld.getData();

    //设置旋转的角度；
    angle[0] = 0;
    angle[1] = PI;
    angle[2] = -(PI/4f)*3f;
    angle[3] = (PI/4f);
    ellipseMode(CENTER);
    //年段颜色
    color[] TLColor = {#7e7e7e, #fa9d72, #cde779, #7bcce7};
    //某一年段的时间个数
    int items = 4;
    for (int i = 1; i <= period; i++) {
      noStroke();
      float rad = (i >=2 ? ((lerp(minRad, minRad+50, i/period) + pow(3, i))) : lerp(minRad, minRad+50, i/period));
      //println("rad：" + rad);
      fill(TLColor[i-1], 200);
      //通过对X值的判断，找到对应的Y值变化；
      float randY = ((dis+rad/2) > nodeX1 ? ((dis+rad/2) > nodeX2 ? randRight : randMiddle ) :  randLeft);
      float xx = (dis + rad/2);
      float yy = (pvTL.y + randY);
      ellipse(xx, yy, rad, rad);
      dc = hm.get(i - 1);
      //判断鼠标的位置
      if (((xx  - rad/2f) <= mouseX) && ((xx + rad/2f) >= mouseX)) {
        if (((yy - rad/2f) <= mouseY) && ((yy + rad/2f) >= mouseY)) {
          showDc = dc;
          showDataJu = true;
        }
      }
      //存储开头和结尾
      if (i == 1) {
        pvBE[0] = new PVector(dis, pvTL.y);
      } else if (i == 4) {
        pvBE[1] = new PVector(dis + rad, pvTL.y);
      }
      //存储位置
      pvPos[i-1] = new PVector(dis + rad/2, pvTL.y + randY);
      //添加距离
      dis += ( i >=2 ? (rad - pow(3, i)) : (rad + margin*2));
      //添加事件

      //fill(#3245dd);
      //ellipse(pvPos[i-1].x + eventX,pvPos[i-1].y + eventY,10,10);
      //println("eventX: " + eventX + "Y: " + eventY);

      println("Number: " + items);
      for (int j = 0; j < items; j++) {

        float eventX = (rad/2f)*sin(angle[j]);
        float eventY = (rad/2f)*cos(angle[j]);
        pvEnvent[i-1][j] = new PVector(eventX + pvPos[i-1].x, eventY + pvPos[i-1].y);
      }
    }

    //轴属性
    stroke(grayColor);
    strokeWeight(15);
    strokeJoin(ROUND);
    strokeCap(ROUND);
    //绘制横轴
    //line(pvTL.x, pvTL.y, nodeX1, pvTL.y + randLeft);
    line(pvBE[0].x, pvBE[0].y, nodeX1, pvTL.y + randLeft);
    line(nodeX1, pvTL.y + randLeft, nodeX2, pvTL.y + randMiddle);
    //line(nodeX2, pvTL.y + randMiddle, nodeX3, pvTL.y + randRight);
    line(nodeX2, pvTL.y + randMiddle, pvBE[1].x, pvBE[1].y );
    //显示年限
    //年限
    //line(dis + rad/2, pvTL.y + randY,dis + rad/2, pvTL.y + randY + (minRad+50));
    textAlign(CENTER, CENTER);
    fill(#ffffff);
    ut.createWord(wordMiddle, #ffffff);
    for (int j = 0; j < period; j++) {
      dc = hm.get(j); 
      text(dc.timeline, pvPos[j].x, pvPos[j].y);
    } 
    //显示事件
    ut.createWord(wordMin);
    textAlign(CENTER, CENTER);
    strokeWeight(1);
    int LL = 40;
    for (int a = 0; a < period; a++) {
      //得到事件数据
      //int nu = 0;
      dc = hm.get(a);
      for (int b = 0; b < dc.events.length; b++) {
        //跳过空值
        if (dc.events[b] == null) {
          break;
        }
        stroke(grayColor);
        //判断线的方向；
        int dir = LL;
        int disWL = 5;//为时间字体的大小
        if (pvEnvent[a][b].y < pvTL.y) {
          dir = -LL ;
          disWL = -disWL;
        }
        line(pvEnvent[a][b].x, pvEnvent[a][b].y, pvEnvent[a][b].x, pvEnvent[a][b].y + dir);
        //文字
        fill(#000000);

        text(dc.events[b], pvEnvent[a][b].x, pvEnvent[a][b].y + dir + disWL);
        //圈圈
        stroke(#000000);
        fill(#ffffff);
        ellipse(pvEnvent[a][b].x, pvEnvent[a][b].y, minEvenRad, minEvenRad);
        fill(#000000);
        ellipse(pvEnvent[a][b].x, pvEnvent[a][b].y, minEvenRad/2f, minEvenRad/2f);
      }
    }

    return showDataJu;
  }
  boolean loadSubHD(float space, float fDis) {
    //加载数据
    ld = new LoadData("data/periodDevelopment.json");
    hm = ld.hm;
    boolean showDataJu = false;
    //
    strokeCap(ROUND);
    strokeJoin(ROUND);
    float indexWidth = 4f;
    float axisLength = 100;
    //坐标中的图像
    rectMode(CORNERS);
    noStroke();
    float disRow = axisLength + fDis;
    float disColu = axisLength + fDis;
    //
    float posX = 0;
    float hight = 6;
    color c;
    //颜色
    cYear[0] = color(#7e7e7e);
    cYear[1] = color(#fa9d72);
    cYear[2] = color(#cde779);
    cYear[3] = color(#7bcce7);
    //坐标轴位置
    posXY[0][0] = space;
    posXY[0][1] = 0;
    posXY[1][0] = space + axisLength + fDis;
    posXY[1][1] = 0;
    posXY[2][0] = space;
    posXY[2][1] = axisLength + fDis;
    posXY[3][0] = space + axisLength + fDis;
    posXY[3][1] = axisLength + fDis;
    float hightV = 0;
  out:
    for (int re = 0; re < 4; re++) {
      //最大活跃时间
      //hight = hight + re*3;
      hight = ( re <= 2 ? 4*(re + 1) : 19);
      //坐标轴位置
      disRow = posXY[re][0];
      disColu = posXY[re][1];
      //记录最小值
      float lowValue = 0;
    inner:
      for (int i = 5, j = (int)hight; i <= axisLength; i += 5) {
        //调节颜色和高度
        if (i/5 <= hight) {
          c = color(cYear[re], i*5);
          hightV = lerp(0, 100, j/hight);
          j--;
          if (i == 5) {
            lowValue = hightV;
          }
        } else {
          c = color(cYear[re], re == 3 ? i*5 : (100 - i)*5);
          hightV = lerp(0, 100, j/hight);
          j++;
        }
        //解决负值问题
        if (lowValue < hightV) {
          break inner;
        }
        noStroke();
        fill(c);
        rect(width - width/4f +disRow + posX, margin*4f + axisLength + disColu, width - width/4f + disRow + i, margin*4f + disColu + hightV);
        posX = i;
        println("hightV: " + hightV);
      }

      //坐标轴
      stroke(grayColor);
      strokeWeight(1);
      ut.createWord(wordMin);
      line(width - width/4f + disRow, margin*4f + disColu, width - width/4f + disRow, margin*4f + axisLength + disColu);
      line(width - width/4f + disRow, margin*4f + axisLength + disColu, width - width/4f + axisLength + disRow, margin*4f + axisLength + disColu);
      //纵轴value
      line(width - width/4f + disRow, margin*4f + disColu, width - width/4f + indexWidth + disRow, margin*4f + disColu);
      line(width - width/4f + disRow, margin*4f + axisLength/2f + disColu, width - width/4f + indexWidth + disRow, margin*4f + axisLength/2f + disColu);
      //横轴value
      line(width - width/4f + axisLength/2f + disRow, margin*4f + axisLength + disColu, width - width/4f + axisLength/2f + disRow, margin*4f + axisLength - indexWidth + disColu);
      line(width - width/4f + axisLength + disRow, margin*4f + axisLength  + disColu, width - width/4f + axisLength + disRow, margin*4f + axisLength - indexWidth + disColu);

      //文字
      textAlign(CENTER, TOP);
      dc = hm.get(re);
      //横轴值
      text(dc.name, width - width/4f + axisLength/2f + disRow, margin*4f + axisLength + disColu + wordMin);
      //纵轴值
      textAlign(LEFT, CENTER);
      text("热度", width - width/4f + disRow + indexWidth, margin*4f + disColu);
      text("0.5", width - width/4f + disRow + indexWidth, margin*4f + axisLength/2f + disColu);
      float xx = (width - width/4f + disRow);
      float yy = (margin*4f + disColu);
      //判断鼠标位置
      if ((xx <= mouseX) && ((xx + axisLength) >= mouseX)) {
        if ((yy <= mouseY) && ((yy + axisLength) >= mouseY)) {
          showDc = hm.get(re);
          showDataJu = true;
        }
      }
    }
    return showDataJu;
  }
  //private void tip() {

  //  //float disT = 10f;
  //  //float disItemY = 0;
  //  //PVector pvTip = new PVector(width/4f*3, margin*4);
  //  ////事件
  //  //ellipseMode(CENTER);
  //  //fill(#ffffff);
  //  //ellipse(pvTip.x + minEvenRad, pvTip.y, minEvenRad, minEvenRad);
  //  //fill(#000000);
  //  //ellipse(pvTip.x + minEvenRad, pvTip.y, minEvenRad/2f, minEvenRad/2f);
  //  //ut.createWord(wordMin);
  //  //textAlign(LEFT, CENTER);
  //  //text("对应年段所发生的事件", pvTip.x + minEvenRad + disT, pvTip.y);
  //  //disItemY = pvTip.y + minEvenRad/2f;
  //  //rectMode(CENTER);
  //  //float va = 100/3f;
  //  //fill(#ffffff,va);
  //  ////rect(pvTip.x + , disItemY + 5 ,5,5);
  //}
}
