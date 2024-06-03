class SolarSystem {
  ArrayList<Planet> planets = new ArrayList<Planet>();
  float timeScale;
  Planet displayingPlanet = null;

  SolarSystem(float scale) {
    this.timeScale = scale;
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
    image(sunImage, width / 2, height / 2, 100, 100); // Adjusted sun size

    for (Planet planet : planets) {
      planet.draw();
    }

    if (displayingPlanet != null && displayingPlanet.getDisplay() > 0) {
      fill(255);
      textSize(14);
      textAlign(CENTER);
      text(displayingPlanet.getInfo(), width / 2, height - 30); // Centered at the bottom
      textAlign(BASELINE);
      displayingPlanet.setDisplay(displayingPlanet.getDisplay() - 1);
    }
  }

  void setDisplayingPlanet(Planet planet) {
    if (displayingPlanet != null) {
      displayingPlanet.setDisplay(0); // Stop displaying previous planet
    }
    displayingPlanet = planet;
    displayingPlanet.setDisplay(200); // Display text for 200 frames
  }
}
