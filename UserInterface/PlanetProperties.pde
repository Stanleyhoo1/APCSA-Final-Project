import java.util.HashMap;

class PlanetProperties {
  HashMap<String, Float> properties;

  PlanetProperties(float size, float mass, float distance) {
    properties = new HashMap<String, Float>();
    properties.put("Size", size);
    properties.put("Mass", mass);
    properties.put("Distance", distance);
  }

  void setProperty(String property, float value) {
    properties.put(property, value);
  }

  float getProperty(String property) {
    return properties.get(property);
  }
}
