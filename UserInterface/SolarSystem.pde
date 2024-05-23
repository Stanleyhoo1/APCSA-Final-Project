class SolarSystem{
  ArrayList<Planet> planets = new ArrayList<Planet>();
  float TimeScale;
  
  SolarSystem(float scale){
    TimeScale = scale;
  }
  
  void addPlanet(Planet p){
    planets.add(p);
  }
  
  void removePlanet(Planet p){
    planets.remove(p);
  }
  
  void update(){
  }
  
  void draw(){
  }
  
  void adjustTimeScale(float scale){
    TimeScale = scale;
  }
}
