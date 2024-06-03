SolarSystem solar;
float scale = 1.0;
int wait = 0;
PImage mercuryImage, venusImage, earthImage, marsImage, jupiterImage, saturnImage, uranusImage, neptuneImage;
import controlP5.*;

ControlP5 cp5;
Planet selectedPlanet;
Textfield sizeTextfield;
Textfield massTextfield;

void setup() {
  size(1000, 800);
  cp5 = new ControlP5(this);

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

  createControls();
}

void createControls() {
  // Size Slider and Textfield
  cp5.addSlider("Size")
    .setPosition(20, 100)
    .setSize(200, 20)
    .setRange(1, 500)
    .setValue(1)
    .plugTo(this, "adjustSize");

  sizeTextfield = cp5.addTextfield("Input Size")
    .setPosition(250, 100)
    .setSize(50, 20)
    .setAutoClear(false)
    .setText("1")
    .onChange(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        float value = PApplet.parseFloat(sizeTextfield.getText());
        if (value >= 1 && value <= 500) {
          adjustSize(value);
          cp5.getController("Size").setValue(value);
        }
      }
    });

  // Mass Slider and Textfield
  cp5.addSlider("Mass")
    .setPosition(20, 150)
    .setSize(200, 20)
    .setRange(0.1, 500)
    .setValue(1)
    .plugTo(this, "adjustMass");

  massTextfield = cp5.addTextfield("Input Mass")
    .setPosition(250, 150)
    .setSize(50, 20)
    .setAutoClear(false)
    .setText("1")
    .onChange(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        float value = PApplet.parseFloat(massTextfield.getText());
        if (value >= 0.1 && value <= 500) {
          adjustMass(value);
          cp5.getController("Mass").setValue(value);
        }
      }
    });
}

void adjustSize(float size) {
  if (selectedPlanet != null) {
    selectedPlanet.setSize(size);
    sizeTextfield.setText(str(size));
  }
}

void adjustMass(float mass) {
  if (selectedPlanet != null) {
    selectedPlanet.setMass(mass);
    massTextfield.setText(str(mass));
  }
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
  if (wait <= 0) {
    for (Planet planet : solar.planets) {
      float x = width / 2 + cos(planet.angle) * planet.distanceFromSun * 10;
      float y = height / 2 + sin(planet.angle) * planet.distanceFromSun * 10;
      if (dist(mouseX, mouseY, x, y) < planet.size / 1000) {
        solar.setDisplayingPlanet(planet);
        selectedPlanet = planet;
        break; // Exit the loop once the clicked planet is found
      }
    }
    wait = 100;
  }
}
