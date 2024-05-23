SolarSystem solar;
float scale;

void setup(){
  size(1000, 800);
  solar = new SolarSystem(scale);
  solar.addPlanet(new Planet("Mars", 3760.4, 67.24, 0.815));
}

void handleInput(){
}

void drawControls(){
}

void adjustPlanetMass(Planet planet, float mass){
  planet.setMass(mass);
}

void adjustPlanetDistance(Planet planet, float distance){
  planet.setDistanceFromSun(distance);
}
