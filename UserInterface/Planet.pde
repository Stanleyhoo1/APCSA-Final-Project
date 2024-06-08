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

  Planet(String name, float size, float distanceFromSun, float mass, float orbitalPeriod, PImage img) {
    this.name = name;
    this.size = size*300;
    this.distanceFromSun = distanceFromSun/10;
    this.mass = mass;
    this.orbitalPeriod = orbitalPeriod;
    this.angle = 0; // Initial angle for the planet's position in its orbit
    this.img = img;
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
    if (simulate == true){
      modifyPlanets();
    }
  }
  
  void setSize(float s) {
    this.size = s*300;
    if (simulate == true){
      modifyPlanets();
    }
  }

  void setDistanceFromSun(float distance) {
    this.distanceFromSun = distance/10;
    this.orbitalPeriod = calcOrbitalPeriod(distance);
    if (simulate == true){
      modifyPlanets();
    }
  }

  void updatePosition(float timeScale) {
    // Update the angle of the planet in its orbit based on the time scale and orbital period
    angle += (TWO_PI / orbitalPeriod) * timeScale;
    // Keep the angle within the range of 0 to TWO_PI
    angle = angle % TWO_PI;
  }
  
  void setDisplay(int time){
    this.displayTime = time;
  }
  
  int getDisplay(){
    return this.displayTime;
  }
  
  String getNames(){
    return this.name;
  }

  void draw() {
    // Calculate the position of the planet in its orbit
    float x = cos(angle) * 25 * sqrt(distanceFromSun);  // Scale distance for better visibility
    float y = sin(angle) * 25 * sqrt(distanceFromSun);
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
      textSize(14);
      textAlign(CENTER);
      text(this.getInfo(), 0, 300);
      textAlign(BASELINE);
      this.setDisplay(this.getDisplay() - 1);
    }
    popMatrix();
  }
}
