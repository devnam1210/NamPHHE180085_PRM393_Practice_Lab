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

void main(){
  Car myCar = Car("Toyota", 20000);
  myCar.showInfo();
  print("");
  Car myLuxuryCar = Car.luxuryCar("Mercedes", 50000);
  myLuxuryCar.showInfo();
  print("");
  ElectricCar myElectricCar = ElectricCar("VinFast", 60000, 100);
  myElectricCar.showInfo();
  print("");
}