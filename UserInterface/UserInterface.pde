SolarSystem solar;
float scale = 1.0;
int wait = 0;
PImage mercuryImage, venusImage, earthImage, marsImage, jupiterImage, saturnImage, uranusImage, neptuneImage;

void setup() {
  size(1000, 800);
  solar = new SolarSystem(scale);
  mercuryImage = loadImage("mercury.png");
  venusImage = loadImage("venus.png");
  earthImage = loadImage("earth.png");
  marsImage = loadImage("mars.png");
  jupiterImage = loadImage("jupiter.png");
  saturnImage = loadImage("saturn.png");
  uranusImage = loadImage("uranus.png");
  neptuneImage = loadImage("neptune.png");
  solar.addPlanet(new Planet("Mercury", 4.879, 57.9, 0.055, 88, mercuryImage));   // Mercury
  solar.addPlanet(new Planet("Venus", 12.104, 108.2, 0.815, 225, venusImage));  // Venus
  solar.addPlanet(new Planet("Earth", 12.742, 149.6, 1, 365, earthImage));      // Earth
  solar.addPlanet(new Planet("Mars", 6.779, 227.9, 0.107, 687, marsImage));    // Mars
  solar.addPlanet(new Planet("Jupiter", 139.820, 778.5, 317.8, 4333, jupiterImage)); // Jupiter
  solar.addPlanet(new Planet("Saturn", 116.460, 1434, 95.2, 10759, saturnImage)); // Saturn
  solar.addPlanet(new Planet("Uranus", 50.724, 2871, 14.5, 30687, uranusImage));  // Uranus
  solar.addPlanet(new Planet("Neptune", 49.244, 4495, 17.1, 60190, neptuneImage)); // Neptune
}

void draw() {
  background(0);
  handleInput();
  solar.update();
  solar.draw();
  drawControls();
  wait -= 1;
}

void handleInput() {
  if (keyPressed) {
    if (wait == 0){
      keyReleased();
      wait = 100;
    }
  }
}

void keyReleased(){
  if (key == '+'){
    scale *= 2;
    solar.adjustTimeScale(scale);
  } else if (key == '-'){
    scale /= 2;
    solar.adjustTimeScale(scale);
  }
}

void drawControls() {
  fill(255);
  textSize(16);
  text("Press '+' to speed up time", 20, 30);
  text("Press '-' to slow down time", 20, 50);
  text("Current time speed: " + scale + " days per second", 20 , 70);
}

void adjustPlanetMass(Planet planet, float mass) {
  planet.setMass(mass);
}

void adjustPlanetDistance(Planet planet, float distance) {
  planet.setDistanceFromSun(distance);
}

void mouseClicked() {
  if (wait <= 0){
    for (Planet planet : solar.planets) {
      if (dist(mouseX, mouseY, cos(planet.angle) * planet.distanceFromSun * 10, sin(planet.angle) * planet.distanceFromSun * 10) < 100) {
        planet.setDisplay(1000);
      }
    }
    wait = 100;
  }
}
