// TO DO 1
class Vehicle{
  String brand;
  int year;

  Vehicle(this.brand, this.year);
  
  void startEngine(){
    print("Khởi động phương tiện...");
  }
}

// TO DO 2
class Car extends Vehicle{
  bool isElectric;

  // TO DO 3
  Car(String brand, int year, this.isElectric) : super(brand, year);

  Car.tesla(int year) : isElectric = true, super("Tesla", year);
  
  // TO DO 4
  @override
  void startEngine(){
    if(isElectric){
      print("$brand (xe điện) sản xuât $year đang khởi động... zinzin");
    } else {
      print("$brand (xe hơi) sản xuât $year đang khởi động... bumbum");
    }
  }
}

void main() {
  // TO DO 5
  Car car1 = Car("Lexus", 2021, false);
  car1.startEngine();

  // TO DO 6
  Car car2 = Car.tesla(2022);
  car2.startEngine();
}