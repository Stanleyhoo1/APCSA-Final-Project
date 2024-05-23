class Planet{
  String name;
  float size;
  float distanceFromSun;
  float mass;
  float orbitalPeriod;
  
  Planet(String name, float size, float distanceFromSun, float mass){
    name = name;
    size = size;
    distanceFromSun = distanceFromSun;
    mass = mass;
  }
  
  String getInfo(){
    String str = "";
    str += "This planet is " + name + ".";
    str += name + " is " + distanceFromSun + "away from the sun.";
    str += name + " diameter is " + size + " across and has a mass of " + mass + "Earths.";
    str += "It completes one full orbit around the sun in " + orbitalPeriod + " days";
    return str;
  }
  
  void setMass(float m){
    mass = mass;
  }
  
  void setDistanceFromSun(float distance){
    distanceFromSun = distance;
  }
  
  void updatePosition(float timeScale){
    
  }
  
  void draw(){
    circle(0, 0, size/1000);
    
  }
}
