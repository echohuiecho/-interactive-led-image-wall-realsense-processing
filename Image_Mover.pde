class Image_Mover {


  PImage [] img;
  int img_amount = 6;

  float img_ratio_x;
  float img_ratio_y = img_ratio_x*0.65;

  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector detector;
  float mass;

  float load_prob;

  int image_number;

  Image_Mover(float m, float x, float y) {
    img_ratio_x = random(0.6, 1.5);
    img_ratio_y = img_ratio_x*0.65;
    mass = m;
    image_number = int(random(1, 6));
    position = new PVector(x, y);
    velocity = new PVector(random(0.1, 0.5), 0);
    acceleration = new PVector(0, 0);

    img = new PImage[img_amount];

    for (int i = 1; i <6; i++) {
      img[i] = loadImage("RealSense_hashtag_GIF/"+i+".gif");

      img[i].resize(int(image_dim_x*img_ratio_x), int(image_dim_y*img_ratio_y));
    }
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.limit(random(7, 10));

    load_prob = random(0, 1);

    if (load_prob<0.01) {
      image_number = int(random(1, 7));
    }
  }

  void display() {
    rectMode(CORNER);
    detector = new PVector(mouseX, mouseY);
    stroke(0);
    strokeWeight(2);
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    switch(image_number) {
    case 1:
      image(loop_1, 0, 0);
      break;
    case 2:
      image(loop_2, 0, 0);
      break;
    case 3:
      image(loop_3, 0, 0);
      break;
    case 4:
      image(loop_4, 0, 0);
      break;
    case 5:
      image(loop_5, 0, 0);
      break;
    case 6:
      image(loop_6, 0, 0);
      break;
    }

    popMatrix();
  }
}
