class Settings {
  // Singleton instance
  static final Settings _instance = Settings._internal();
  String theme = "Dark";

  factory Settings(String theme) {
    _instance.theme = theme;
    return _instance;
  }
  
  Settings._internal();
}

void main() {
  print("--- EXERCISE 5 ---");
  var settings1 = Settings("Light");
  var settings2 = Settings("Dark");

  print(settings1.theme);
  settings2.theme = "Green";
  print(settings2.theme);
}