class Mover {
  PImage [] hashtag;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  int image_number;

  Mover(float m, float x, float y) {
    mass = m;
    image_number = int(random(1,22));
    position = new PVector(x, y);
    velocity = new PVector(random(0.1,0.5), 0);
    acceleration = new PVector(0, 0);

    hashtag = new PImage[22];

    for (int i = 1; i <22; i++) {
      hashtag[i] = loadImage("hashtag/0 ("+i+").png");
      hashtag[i].resize(int(hash_dim_x*ratio_x),int(hash_dim_y*ratio_y));
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
    velocity.limit(random(4,6));
  }

  void display() {
    rectMode(CORNER);
    float theta = velocity.heading();
    stroke(0);
    strokeWeight(2);
    fill(255);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    image(hashtag[image_number],0,0);
    popMatrix();
  }
}
