class TextBlock {
  PImage [] hashtag;
  int image_number;

  PVector loc, vel, acc;
  float xoff = 0.0;


  TextBlock(float mx,float my) {
    loc = new PVector (mx, my);
    vel = new PVector (0.0, 0.0);
    acc = new PVector(0, 1);
    
    image_number = int(random(1,22));

    hashtag = new PImage[22];

    for (int i = 1; i <22; i++) {
      hashtag[i] = loadImage("hashtag/0 ("+i+").png");
      hashtag[i].resize(int(hash_dim_x*ratio_x), int(hash_dim_y*ratio_y));
    }
  }

  void display() {
    rectMode(CORNER);
    stroke(0);
    strokeWeight(2);
    fill(255);
    pushMatrix();
    translate(loc.x, loc.y);
    image(hashtag[image_number],0,0);
    popMatrix();
  }

  void cal() {
    xoff = xoff + 0.001; 
    vel.add(acc);
    loc.add(vel);

    vel = new PVector (0, 3);
    acc = new PVector(0, 0.0);
    
  }

  void applyForce(PVector force) {
    acc = force;
  }
}
