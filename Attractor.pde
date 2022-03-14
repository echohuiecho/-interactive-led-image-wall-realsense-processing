class Attractor {
  float mass;    // Mass, tied to size
  float G;       // Gravitational Constant
  PVector position;   // position
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on

  Attractor() {
    position = new PVector(width/2, height/2);
    mass = 30;
    G = 1;
    dragOffset = new PVector(0.0, 0.0);
  }
  
  PVector attract(BgBlock bgb) {
    PVector force_bgb = PVector.sub(position, bgb.position);   
    float d = force_bgb.mag();                              // Distance between objects
    d = constrain(d, 5.0, 25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force_bgb.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * bgb.mass) / (d * d);      // Calculate gravitional force magnitude
    force_bgb.mult(strength);                                  // Get force vector --> magnitude * direction
    return force_bgb;
  }

  PVector attract(Mover m) {
    PVector force_m = PVector.sub(position, m.position);   
    float d = force_m.mag();                              // Distance between objects
    d = constrain(d, 5.0, 25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force_m.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * m.mass) / (d * d);      // Calculate gravitional force magnitude
    force_m.mult(strength);                                  // Get force vector --> magnitude * direction
    return force_m;
  }
  
  PVector attract(Image_Mover img_movers) {
    PVector force_img = PVector.sub(position, img_movers.position);   
    float d = force_img.mag();                              // Distance between objects
    d = constrain(d, 5.0, 25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force_img.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * img_movers.mass) / (d * d);      // Calculate gravitional force magnitude
    force_img.mult(strength);                                  // Get force vector --> magnitude * direction
    return force_img;
  }

  void display() {
    // hand point display
    pushMatrix();
    translate(position.x, position.y);
    image(loop_mouse, 0, 0);
    popMatrix();
  }

  void clicked(int mx, int my) {
    position.x = mx;
    position.y = my;
  }

  void hover(int mx, int my) {
    float d = dist(mx, my, position.x, position.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag() {
    if (dragging) {
      position.x = mouseX + dragOffset.x;
      position.y = mouseY + dragOffset.y;
    }
  }
}
