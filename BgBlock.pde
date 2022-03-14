class BgBlock {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  float grad;
  

  BgBlock(float m, float x, float y) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(random(5,7), 0);
    acceleration = new PVector(0, 0);
    grad = random(220,240);

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
    noStroke();
    //strokeWeight(2);
    fill(grad);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    rect(0, 0, 10, 19);
    popMatrix();
  }
}
