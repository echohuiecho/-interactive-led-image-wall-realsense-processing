import gifAnimation.*;

import ch.bildspur.vision.DeepVision;
import ch.bildspur.vision.SingleHumanPoseNetwork;
import ch.bildspur.vision.result.*;

import ch.bildspur.realsense.*;

RealSenseCamera camera = new RealSenseCamera(this);
DeepVision vision = new DeepVision(this, true);

SingleHumanPoseNetwork pose;
HumanPoseResult result;

KeyPointResult right;

int xCoor;
int yCoor;
int xCoor_map;
int yCoor_map;
int cam_width = 640;
int cam_height = 480;

Gif loop_1;
Gif loop_2;
Gif loop_3;
Gif loop_4;
Gif loop_5;
Gif loop_6;
Gif loop_mouse;

Mover[] movers = new Mover[10];
Image_Mover[] img_movers = new Image_Mover[6];
BgBlock[] bgb = new BgBlock[400];
ArrayList <TextBlock> tbbs;
float textbox_array [] = new float [40];
String  [] tag= { 
  "#BattleForSurvival", "#Birds", "#BrownCheekedRail", 
  "#Farmers", "#GreaterPaintedSnipe", "#Growth", "#Harvest"
  , "#Hatching", "#HongKong", "#LittleErget", " #Local", "#Planting"
  , "#RiceFlower", "#RiceKernel", "#RicePaddy", "#Sowing", "#Growth"
  , "#SpikeOfRice", "#WatchOver", "#WaterFilledField"
  , "#WhiteRumpedMania", "#YellowBreast"
};

Attractor a;

float ratio_x = 1;
float ratio_y = 0.65;
float hash_dim_x = 70;
float hash_dim_y = 400;

float image_dim_x = 169;
float image_dim_y = 300;

int h; 
int m;

void setup() {
  fullScreen();
  frameRate(60);
  noCursor();

  // Setup pose network and camera
  println("creating network...");
  pose = vision.createSingleHumanPoseEstimation();
  println("loading model...");
  pose.setup();
  println("starting camera...");
  camera.enableColorStream(cam_width, cam_height, 30);
  camera.start();

  //imageMode(CENTER);
  for (int i = 0; i < bgb.length; i++) {
    bgb[i] = new BgBlock(3, random(width), random(height));
  }
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(random(0.1, 2), random(width), random(height));
  }
  for (int i = 0; i < img_movers.length; i++) {
    img_movers[i] = new Image_Mover(random(0.1, 2), random(width), random(height));
  }

  for (int i = 0; i < textbox_array.length; i++) {
    textbox_array[i] = hash_dim_x*i;
  }

  a = new Attractor();
  tbbs = new ArrayList <TextBlock>();

  load_gif();
}

void load_gif() {
  loop_1 = new Gif(this, "/RealSense_hashtag_GIF/1.gif");
  loop_1.loop();
  loop_2 = new Gif(this, "/RealSense_hashtag_GIF/2.gif");
  loop_2.loop();
  loop_3 = new Gif(this, "/RealSense_hashtag_GIF/3.gif");
  loop_3.loop();
  loop_4 = new Gif(this, "/RealSense_hashtag_GIF/4.gif");
  loop_4.loop();
  loop_5 = new Gif(this, "/RealSense_hashtag_GIF/5.gif");
  loop_5.loop();
  loop_6 = new Gif(this, "/RealSense_hashtag_GIF/6.gif");
  loop_6.loop();
  loop_mouse = new Gif(this, "/RealSense_hashtag_GIF/mouse.gif");
  loop_mouse.loop();
}

void coorMap() {
  xCoor_map = width - int(map(xCoor, 0, cam_width, 0, width));
  yCoor_map = int(map(yCoor, 0, cam_height, 0, height));
}

float prob;
int block_selection;

void draw() {
  // read frames
  camera.readFrames();
  // get camera image
  PImage input = camera.getColorImage();
  result = pose.run(input);

  coorMap();
  //println(xCoor, yCoor);

  block_selection = int(map(xCoor_map, 0, width, 0, 20));
  prob = random(0, 1);
  background(255);

  if (prob<0.5) {
    tbbs.add(new TextBlock(textbox_array[block_selection], -hash_dim_y/2));
  }

  for (TextBlock tbb : tbbs) {
    tbb.display();
    tbb.cal();
  }

  a.display();
  a.drag();
  a.clicked(xCoor_map, yCoor_map);

  for (int i = 0; i < img_movers.length; i++) {
    PVector force = a.attract(img_movers[i]);
    img_movers[i].applyForce(force);

    img_movers[i].update();
    img_movers[i].display();
  }

  fill(0);
  rect(0, 0, width, 50);
  rect(0, height-50, width, height-50);

  if (tbbs.size() > 500) {
    tbbs.remove(0);
  }
  stroke(255);
  noFill();

  // draw video
  pushMatrix();
  translate(850, 700);
  scale(-0.7, 0.35);

  image(input, 0, 0);
  drawHuman(result);
  popMatrix();

  if (keyPressed) {
    if (key == 'd') {
      image(input, 0, 0, 300, 300);
      filter(GRAY);
      drawHuman(result);
    }
  }


  // get Coordinates
  realSenseCoordinates(result);

  // get time
  h = hour();

  // display clock during closing hours
  if (h > 18 || h <9) {
    fill(0);
    noStroke();
    rect(0,0,width,height);
    fill(255);
    textSize(60);
    text("will open after 10:00",200,height/2-100);
    text("now is " + h+":xx",200,height/2);
  }
}

void debugMode() {
}

void realSenseCoordinates(HumanPoseResult human) {
  right = human.getRightWrist();
  xCoor = right.getX();
  yCoor = right.getY();
}

void buttom_bar() {
  noFill();
  stroke(255);
  rectMode(CENTER);
  rect(width/2, height-30, random(10, width-20), 2);
}

int text_number;
float text_prob;

void text_bottom() {
  text_prob = random(0, 1);
  if (text_prob<0.15) {
    if (text_number < 17) {
      text_number++;
    } else {
      text_number=0;
    }
  }

  fill(255);
  textAlign(CENTER);
  textSize(20);
  text(tag[text_number], width/2, height-20);
  text(tag[text_number+1], width/2-width/6, height-20);
  text(tag[text_number+1+1], width/2+width/6, height-20);
  text(tag[text_number+1+1+1], width/2-width/6-width/6, height-20);
  text(tag[text_number+1+1+1+1], width/2+width/6+width/6, height-20);
}

void drawHuman(HumanPoseResult human) {
  connect(human.getLeftShoulder(), 
    human.getLeftElbow(), 
    human.getLeftWrist());

  connect(human.getRightShoulder(), 
    human.getRightElbow(), 
    human.getRightWrist());

  connect(human.getLeftShoulder(), human.getRightShoulder());
}

private void connect(KeyPointResult... keyPoints) {
  for (int i = 0; i < keyPoints.length - 1; i++) {
    KeyPointResult a = keyPoints[i];
    KeyPointResult b = keyPoints[i + 1];

    line(a.getX(), a.getY(), b.getX(), b.getY());
  }
}
