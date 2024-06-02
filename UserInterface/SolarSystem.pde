PImage sunImage;

class SolarSystem {
  ArrayList<Planet> planets = new ArrayList<Planet>();
  float timeScale;
  
  SolarSystem(float scale) {
    this.timeScale = scale;
    sunImage = loadImage("sun.png");
  }
  
  void addPlanet(Planet p) {
    planets.add(p);
  }
  
  void removePlanet(Planet p) {
    planets.remove(p);
  }
  
  void update() {
    for (Planet planet : planets) {
      planet.updatePosition(timeScale);
    }
  }
  
  void draw() {
    // Draw the sun at the center
    imageMode(CENTER);
    image(sunImage, width/2, height/2, 50, 50);

    for (Planet planet : planets) {
      planet.draw();
    }
  }
  
  void adjustTimeScale(float scale) {
    this.timeScale = scale;
  }
}
