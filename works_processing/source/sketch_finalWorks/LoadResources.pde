class LoadResources {

  PImage[] getImg() {
    //flag资源
    photo[9] = loadImage("img/flag/spain.png");
    photo[8] = loadImage("img/flag/italy.png");
    photo[7] = loadImage("img/flag/canada.png");
    photo[6] = loadImage("img/flag/france.png");
    photo[5] = loadImage("img/flag/india.png");
    photo[4] = loadImage("img/flag/germany.png");
    photo[3] = loadImage("img/flag/japan.png");
    photo[2] = loadImage("img/flag/united-kingdom.png");
    photo[1] = loadImage("img/flag/united-states.png");
    photo[0] = loadImage("img/flag/china.png");

    return photo;
  }
  PImage[] getImgO() {
    //flag资源
    photo[9] = loadImage("img/flag/australia.png");
    photo[8] = loadImage("img/flag/canada.png");
    photo[7] = loadImage("img/flag/japan.png");
    photo[6] = loadImage("img/flag/spain.png");
    photo[5] = loadImage("img/flag/china.png");
    photo[4] = loadImage("img/flag/italy.png");
    photo[3] = loadImage("img/flag/france.png");
    photo[2] = loadImage("img/flag/germany.png");
    photo[1] = loadImage("img/flag/united-kingdom.png");
    photo[0] = loadImage("img/flag/united-states.png");
    return photo;
  }
  //大脑资源
  PImage getBackgroundLeft() {
    return loadImage("img/other/brain.png");
  }
  PImage getBackgroundMiddle() {
    return loadImage("img/other/background01.png");
  }
  PImage getBackgroundRight() {
    return loadImage("img/other/background02.png");
  }
  PImage getConvey() {
    return loadImage("img/other/convey.png");
  }
  //解释字体
  PImage getWords(String img){
    return loadImage(img);
  }
}
