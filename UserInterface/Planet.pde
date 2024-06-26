class Planet {
  String name;
  float size;
  float distanceFromSun;
  float mass;
  float orbitalPeriod;
  float angle;
  PImage img;
  boolean displayText = false;
  int displayTime = 0;
  PVector position;
  PVector velocity;
  PVector acceleration;

  Planet(String name, float size, float distanceFromSun, float mass, float orbitalPeriod, PImage img) {
    this.name = name;
    this.size = size*300;
    this.distanceFromSun = distanceFromSun/10;
    this.mass = mass;
    this.orbitalPeriod = orbitalPeriod;
    this.angle = 0; // Initial angle for the planet's position in its orbit
    this.img = img;
    float x = cos(angle) * sqrt(this.distanceFromSun) * 25;
    float y = sin(angle) * sqrt(this.distanceFromSun) * 25;
    this.position = new PVector(x, y);
    this.velocity = calculateInitialVelocity();
    this.acceleration = new PVector(0, 0);
  }

  PVector calculateInitialVelocity() {
    float G = 6.67430e-11f; // Gravitational constant
    float M = 1.989e30f; // Mass of the Sun in kg
    float r = this.distanceFromSun * 1e9f; // Convert to meters
    float v = sqrt(G * M / r);
    PVector velocity = new PVector(-sin(angle) * v, cos(angle) * v); // Perpendicular to the position vector
    return velocity.div(1e9f); // Convert to a smaller scale for the simulation
  }
  
  String getInfo() {
    String str = "";
    str += "This planet is " + name + ". ";
    str += name + " is " + distanceFromSun * 10 + " million km away from the sun. \n";
    str += name + " has a diameter of " + size/3 * 10 + " km and a mass of " + mass + " Earths. ";
    str += "It completes one full orbit around the sun in " + orbitalPeriod + " days.";
    return str;
  }

  void setMass(float m) {
    this.mass = m;
    if (simulate == true || changed == false){
      modifyPlanets();
      changed = true;
    }
  }
  
  void setSize(float s) {
    this.size = s*300;
    if (simulate == true || changed == false){
      modifyPlanets();
      changed = true;
    }
  }

  void setDistanceFromSun(float distance) {
    this.distanceFromSun = distance/10;
    this.orbitalPeriod = calcOrbitalPeriod(distance);
    if (simulate == true || changed == false){
      modifyPlanets();
      changed = true;
    }
    float x = cos(angle) * sqrt(this.distanceFromSun) * 25;
    float y = sin(angle) * sqrt(this.distanceFromSun) * 25;
    this.position = new PVector(x, y);
  }

  void updatePosition(float timeScale) {
    // Update the angle of the planet in its orbit based on the time scale and orbital period, planets orbit counterclockwise
    angle -= (TWO_PI / orbitalPeriod) * timeScale;
    // Keep the angle within the range of 0 to TWO_PI
    angle = angle % TWO_PI;
  }
  
  void setDisplay(int time){
    this.displayTime = time;
  }
  
  int getDisplay(){
    return this.displayTime;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    velocity = new PVector(0, 0);
    velocity.add(acceleration);
    float mag = velocity.mag();
    velocity.x = mag * sin(angle);
    velocity.y = mag * cos(angle);
    velocity.limit(100);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void draw() {
    // Calculate the position of the planet in its orbit
    float x = position.mag() * cos(angle);
    float y = position.mag() * sin(angle);
    // Draw the orbital path
    noFill();
    stroke(100);
    ellipse(width / 2, height / 2, 50 * sqrt(distanceFromSun), 50 * sqrt(distanceFromSun));
    // Draw the planet at its current position
    pushMatrix();
    translate(width / 2, height / 2);
    imageMode(CENTER);
    image(img, x, y, sqrt(size)/4, sqrt(size)/4); // Scale down the size for drawing
    if (this.getDisplay() > 0){
      fill(255);
      this.setDisplay(this.getDisplay() - 1);
    }
    popMatrix();
  }
}
