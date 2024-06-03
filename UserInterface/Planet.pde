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
    this.distanceFromSun = distanceFromSun/100;
    this.mass = mass;
    this.orbitalPeriod = orbitalPeriod;
    this.angle = 0; // Initial angle for the planet's position in its orbit
    this.img = img;
  }

  String getInfo() {
    String str = "";
    str += "This planet is " + name + ". ";
    str += name + " is " + distanceFromSun + " million km away from the sun. ";
    str += name + " has a diameter of " + size/3 * 10 + " km and a mass of " + mass + " Earths. ";
    str += "It completes one full orbit around the sun in " + orbitalPeriod + " days.";
    return str;
  }

  void setMass(float m) {
    this.mass = m;
  }

  void setDistanceFromSun(float distance) {
    this.distanceFromSun = distance;
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

  void draw() {
    // Calculate the position of the planet in its orbit
    float x = cos(angle) * distanceFromSun * 10;  // Scale distance for better visibility
    float y = sin(angle) * distanceFromSun * 10;
    // Draw the orbital path
    noFill();
    stroke(100);
    ellipse(width / 2, height / 2, distanceFromSun * 20, distanceFromSun * 20);
    // Draw the planet at its current position
    pushMatrix();
    translate(width / 2, height / 2);
    imageMode(CENTER);
    image(img, x, y, size / 1000, size / 1000); // Scale down the size for drawing
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
