class UtilTool {
  int margin = 10;
  //创造字体
  //字体类型
  void createWord(int wordScale, color wordColor, String wordAlign) {
    String word = "等线 Bold";
    wordScale = (wordScale == 0 ? 60 : wordScale);
    PFont myFont = createFont(word, wordScale);
    fill(wordColor);
    textFont(myFont);
    int wordAligns = ( wordAlign == "CENTER" ? CENTER : LEFT); 
    textAlign(wordAligns, TOP);
  }
  void createWord(int wordScale, color wordColor) {
    String word = "等线 Bold";
    wordScale = (wordScale == 0 ? 60 : wordScale);
    PFont myFont = createFont(word, wordScale);
    fill(wordColor);
    textFont(myFont);
  }
  void createWord(String name, int scale) {
    myFont = createFont(name, scale);
    textFont(myFont);
    fill(#3a3a3c);
  }
  void createWord(int scale) {
    myFont = createFont("等线 Bold", scale);
    textFont(myFont);
    fill(#3a3a3c);
  }
  //鼠标位置
  void getMousePosition() {
    print("X: " + mouseX);
    println("Y: " + mouseY);
    stroke(#000000);
    text("X: " + mouseX + "/n" + "Y: " + mouseY, mouseX, mouseY);
    println(mouseX + ", " + mouseY);
  }
  //参考线
  void showRuler() {

    //fill(#000000);
    strokeWeight(2);
    line(0, margin, width, margin);
    line(0, height/3, width, height/3);
    line(0, height/3f*2, width, height/3f*2);
    //line(0, height/, width, height/2);
    line(0, height - margin, width, height - margin);

    line(margin, 0, margin, height);
    line(width/4, 0, width/4, height);
    line(width/4*3, 0, width/4*3, height);
    line(width/2, 0, width/2, height);
    line(width - margin, 0, width - margin, height);
  }
  //存在延迟，
  //判断鼠标位置
  boolean judgeMousePos(float x01, float x02, float y01, float y02) {
    //传输鼠标对应的值
    if ((x01 <= mouseX && x02 >= mouseX) && (y01 <= mouseY && y02 > mouseY)) {
      return true;
    }
    return false;
  }
}
