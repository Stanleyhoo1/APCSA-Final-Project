class SolarSystem {
  ArrayList<Planet> planets = new ArrayList<Planet>();
  float timeScale;
  Planet displayingPlanet = null;
  PImage sunImage;
  float sunSize = 696.265;
  float sunMass = 333000;
  
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
  
  void draw() {
    // Draw the sun at the center
    imageMode(CENTER);
    image(sunImage, width / 2, height / 2, sqrt(sunSize*300)/4, sqrt(sunSize*300)/4); // Adjusted sun size

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
    } else {
      displayingPlanet = null;
    }
  }
  
  void adjustTimeScale(float scale) {
    this.timeScale = scale;
  }
  
  void setDisplayingPlanet(Planet planet) {
    if (displayingPlanet != null) {
      displayingPlanet.setDisplay(0);
    }
    displayingPlanet = planet;
    displayingPlanet.setDisplay(500); // Display text for 200 frames
  }
  
  void update() {
    // Calculate and apply gravitational forces
    for (Planet planet : planets) {
      PVector totalForce = new PVector(0, 0);
      for (Planet other : planets) {
        if (planet != other) {
          PVector force = calculateGravitationalForce(planet, other);
          totalForce.add(force);
        }
      }
      PVector force = calculateCentripetal(planet);
      totalForce.add(force);
      planet.applyForce(totalForce);
    }
    // Update planet positions
    for (Planet planet : planets) {
      planet.update();
      planet.updatePosition(timeScale);
    }
  }

  PVector calculateGravitationalForce(Planet a, Planet b) {
    float G = 6.67430e-11f; // Gravitational constant
    PVector force = PVector.sub(b.position, a.position);
    float distance = force.mag();
    float strength = (G * a.mass * b.mass) / (distance * distance);
    float scale = pow(10, 10);
    strength *= scale;
    force.setMag(strength);
    return force;
  }
  
  PVector calculateCentripetal(Planet planet){
    float forceMag = planet.mass * pow(planet.velocity.mag(), 2) / planet.position.mag();
    PVector force = new PVector(cos(planet.angle) * forceMag, sin(planet.angle) * forceMag);
    force.mult(pow(10, 3));
    return force;
  }
}
