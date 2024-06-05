SolarSystem solar;
float scale = 1.0;
int wait = 0;
PImage mercuryImage, venusImage, earthImage, marsImage, jupiterImage, saturnImage, uranusImage, neptuneImage;
import controlP5.*;
boolean simulate;


ControlP5 cp5;
Planet selectedPlanet;
Textfield sizeTextfield;
Textfield massTextfield;
Textfield distanceTextfield;

void setup() {
  size(1000, 800);
  cp5 = new ControlP5(this);
  simulate = false;

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
    
  cp5.addSlider("Distance")
    .setPosition(20, 200)
    .setSize(200, 20)
    .setRange(1, 5000)
    .setValue(1)
    .plugTo(this, "adjustDistance");
    
  distanceTextfield = cp5.addTextfield("Input Distance")
    .setPosition(250, 200)
    .setSize(50, 20)
    .setAutoClear(false)
    .setText("1")
    .onChange(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        float value = PApplet.parseFloat(distanceTextfield.getText());
        if (value >= 1 && value <= 5000) {
          adjustDistance(value);
          cp5.getController("Distance").setValue(value);
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

void adjustDistance(float distance) {
  if (selectedPlanet != null) {
    selectedPlanet.setDistanceFromSun(distance);
    distanceTextfield.setText(str(distance));
  }
}


void draw() {
  if (simulate){
    background(0);
    handleInput();
    solar.update();
    solar.draw();
    drawControls();
    drawButton();
    wait -= 1;
  }
  else{
    background(0);
    handleInput();
    solar.draw();
    drawControls();
    drawButton();
    wait -= 1;
  }
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
  if (mouseHoverStart()){
    simulate = !simulate;
  }
  if (mouseHoverReset()){
    reset();
  }
}

void drawButton() {
  if (mouseHoverStart()){
    fill(99, 160, 222);
  } else{
    fill(0, 51, 102);
  }
  rectMode(CENTER);
  rect(70, 250, 100, 25);
  fill(255, 255, 255);
  textSize(13);
  if (simulate == true){
    textAlign(CENTER);
    text("Pause simulation", 70, 250);
    textAlign(BASELINE);
  } else{
    textAlign(CENTER);
    text("Start simulation", 70, 250);
    textAlign(BASELINE);
  }
  if (mouseHoverReset()){
    fill(99, 160, 222);
  } else{
    fill(0, 51, 102);
  }
  rect(160, 250, 50, 25);
  fill(255, 255, 255);
  textSize(13);
  textAlign(CENTER);
  text("Reset", 160, 250);
  textAlign(BASELINE);
}

boolean mouseHoverStart(){
  if ((mouseX >= 20 && mouseX <= 120) && (mouseY >= 237.5 && mouseY <= 262.5)){
    return true;
  } else {
    return false;
  }
}

boolean mouseHoverReset(){
  if ((mouseX >= 135 && mouseX <= 185) && (mouseY >= 237.5 && mouseY <= 262.5)){
    return true;
  } else {
    return false;
  }
}

void reset() {
  setup();
}

float calcOrbitalPeriod(float distance){
  return 365 * sqrt(pow(distance/149.6, 3));
}
