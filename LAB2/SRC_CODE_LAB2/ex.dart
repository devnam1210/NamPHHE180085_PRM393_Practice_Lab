void checkScore(double score) {
  if(score >= 5.0){
    print("Passed");
  } else{
    print("Failed");
  }
}

int multiply(int a, int b) => a * b;

class Car{
  String brand;
  double price;
  bool isLuxury;

  Car(this.brand, this.price) : isLuxury = false;

  Car.luxuryCar(this.brand, this.price) : isLuxury = true;

  void showInfo(){
    print("Brand: $brand");
    print("Price: $price");
    print("Is Luxury: $isLuxury");
  }
}

class ElectricCar extends Car{
  double batteryCapacity;

  ElectricCar(String brand, double price, this.batteryCapacity) : super(brand, price);

  @override
  void showInfo(){
    print("Brand: $brand");
    print("Price: $price");
    print("Battery Capacity: $batteryCapacity kWh");
  }
}

Future<String> fetchDataLoading() async {
  print("Loading....");
  await Future.delayed(Duration(seconds: 10));
  return "Loading complete!";
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}


void main() async{
  // Ex1
  print("--------Exercise 1---------");
  String name = "Pham Hoang Nam";
  int age = 23;
  double height = 1.75;
  bool haveGirlfriend = true;

  print("Name: $name");
  print("Next year I will be ${age + 1} years old");
  print("Height: $height meters");
  print("Have a girlfriend: $haveGirlfriend");

  // Ex2
  print("");
  print("--------Exercise 2---------");
  // List
  List<int> numbers = [1, 2, 3, 4, 5];
  numbers.remove(1);
  numbers.add(6);
  print("List after modifications: $numbers");
  print("Length of the list: ${numbers.length}");

  // Set
  Set<String> fruits = {"Apple", "Banana", "Orange", "Apple"};
  print("Set of fruits: $fruits");

  // Map 
  Map<String, int> ages = {
    "Nam": 25,
    "Huyen": 30,
    "Hoa": 35,
  };
  print("Hoa's age: ${ages['Hoa']}");

  // Toán tử số học, logic, toán tử 3 ngôi
  int a = 10;
  int b = 5;
  bool isGreater = a > b;

  int sum = a + b;
  print("Sum of a and b: $sum");

  String result = isGreater ? "a is greater than b" : "a is not greater than b";
  print(result);

  // Ex3
  print("");
  print("--------Exercise 3---------");
  double score = 7.5;
  checkScore(score);

  int day = 6;
  switch(day){
    case 1:
      print("Monday");
      break;
    case 2:
      print("Tuesday");
      break;
    case 3:
      print("Wednesday");
      break;
    case 4:
      print("Thursday");
      break;
    case 5:
      print("Friday");
      break;
    case 6:
      print("Saturday");
      break;
    case 7:
      print("Sunday");
      break;
    default:
      print("Invalid day");
  }

  List<String> colors = ["Red", "Green", "Blue"];
  for(int i = 0; i < colors.length; i++){
    print("Color at index $i: ${colors[i]}");
  }
  for(String color in colors){
    print("Color: $color");
  }
  colors.forEach((color) => print("Color: $color")); 

  int res = multiply(3, 4);
  print("Result of multiplication: $result");

  // Ex4
  print("");
  print("--------Exercise 4---------");
  Car myCar = Car("Toyota", 20000);
  myCar.showInfo();
  print("");
  Car myLuxuryCar = Car.luxuryCar("Mercedes", 50000);
  myLuxuryCar.showInfo();
  print("");
  ElectricCar myElectricCar = ElectricCar("VinFast", 60000, 100);
  myElectricCar.showInfo();
  
  // Ex5
  print("");
  print("--------Exercise 5---------");

  String? footballTeam;
  print("Foodball team: ${footballTeam ?? "No team selected"}");
  footballTeam = "Manchester United";
  print("I love $footballTeam have been supporting them for ${footballTeam!.length} years");
  print("");
  String loadingMessage = await fetchDataLoading();
  print(loadingMessage);

  countStream(3).listen((number) {
    print("Count: $number");
  });
}